FROM centos:latest

MAINTAINER Esa Varemo <esa@kuivanto.fi>

EXPOSE 22


# Install packages
RUN yum update -y
RUN yum install -y wget gcc make gcc openssl-devel sqlite-devel git libffi-devel openssh-server python-setuptools

# Install Python3
RUN mkdir /src/
WORKDIR /src/

RUN wget -O - https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tar.xz | xzcat | tar xv

WORKDIR /src/Python-3.4.3/

RUN ./configure && make -j3 && make install -j3
RUN pip3 install --upgrade pip


RUN useradd user

# Run
ADD entrypoint_ssh.sh /entrypoint_ssh.sh
CMD bash
