.PHONY = systemd_install systemd_uninstall docker_up docker_destroy

NAME = GoLang
INSTALL_LOCATION = /opt/${NAME}
SERVICE_SCRIPT = /etc/systemd/system/${NAME}.service

systemd_install:
	@cp ${NAME}.service ${SERVICE_SCRIPT}
	 @mkdir -p ${INSTALL_LOCATION}
	 @cp main ${INSTALL_LOCATION}
	 @cp -r static ${INSTALL_LOCATION}
	 @systemctl daemon-reload

systemd_uninstall:
	 @rm -rf ${INSTALL_LOCATION}
	@rm -rf ${SERVICE_SCRIPT}

docker_up:
	 @docker build -t bobcrutchley/${NAME}:latest .
	 @docker run -d -p 9000:9000 --name ${NAME} bobcrutchley/${NAME} 

docker_destroy:
	@docker stop ${NAME} 
	@docker rm ${NAME}
	@docker rmi bobcrutchley/${NAME}
