-- 1. Tabela EMPRESA
CREATE TABLE empresa (
    cnpj VARCHAR(18) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    nome_social VARCHAR(150) NOT NULL
);

-- 2. Tabela FILIAL
CREATE TABLE filial (
    cnpj_filial VARCHAR(18) PRIMARY KEY,
    cnpj_empresa VARCHAR(18) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    regiao VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    CONSTRAINT fk_filial_empresa 
        FOREIGN KEY (cnpj_empresa) REFERENCES empresa(cnpj)
);

-- 3. Tabela FUNCIONARIO
CREATE TABLE funcionario (
    cpf VARCHAR(14) PRIMARY KEY,
    cnpj_empresa VARCHAR(18) NOT NULL,
    cnpj_filial VARCHAR(18) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    sexo VARCHAR(20) NOT NULL,
    data_contratacao DATE NOT NULL,
    data_demissao DATE, -- Permite NULL, pois a cardinalidade é (0, 1)
    data_nascimento DATE NOT NULL,
    CONSTRAINT fk_funcionario_empresa 
        FOREIGN KEY (cnpj_empresa) REFERENCES empresa(cnpj),
    CONSTRAINT fk_funcionario_filial 
        FOREIGN KEY (cnpj_filial) REFERENCES filial(cnpj_filial)
);

-- 4. Tabela REGISTRO_MENSAL_FILIAL
CREATE TABLE registro_mensal_filial (
    id_registro_filial INT PRIMARY KEY,
    cnpj_filial VARCHAR(18) NOT NULL,
    residuos_reciclado_em_kg FLOAT NOT NULL,
    residuos_gerados_em_kg FLOAT NOT NULL,
    energia_consumida_em_kWh FLOAT NOT NULL,
    custo_operacional FLOAT NOT NULL,
    receita_em_reais FLOAT NOT NULL,
    emissoes_em_tco2e FLOAT NOT NULL,
    data_registro DATE NOT NULL,
    CONSTRAINT fk_registro_filial 
        FOREIGN KEY (cnpj_filial) REFERENCES filial(cnpj_filial)
);

-- 5. Tabela REGISTRO_MENSAL_FUNCIONARIO
CREATE TABLE registro_mensal_funcionario (
    id_registro_funcionario INT PRIMARY KEY,
    cpf_funcionario VARCHAR(14) NOT NULL,
    horas_trabalhadas TIME NOT NULL,
    horas_treinamento TIME NOT NULL,
    data_registro DATE NOT NULL,
    CONSTRAINT fk_registro_funcionario 
        FOREIGN KEY (cpf_funcionario) REFERENCES funcionario(cpf)
);

