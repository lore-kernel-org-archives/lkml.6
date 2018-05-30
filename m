Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeE3N23 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:28:29 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.135]:20808 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753399AbeE3N2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:28:05 -0400
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx7oJE8yFU0CFyS7Uq+kmFDrWBCuLGqeCYZgEsPw="
X-RZG-CLASS-ID: mo05
From: Frieder Schrempf <frieder.schrempf@exceet.de>
To: linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com, han.xu@nxp.com,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] ARM: dts: Reflect change of FSL QSPI driver and remove unused properties
Date: Wed, 30 May 2018 15:14:34 +0200
Message-Id: <1527686082-15142-6-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSL QSPI driver was moved to the SPI framework and it now
acts as a SPI controller. Therefore the subnodes need to set
spi-[rx/tx]-bus-width = <4>, so quad mode is used just as before.

Also the properties 'bus-num', 'fsl,spi-num-chipselects' and
'fsl,spi-flash-chipselects' were never read by the driver and
can be removed.

The 'reg' properties are adjusted to reflect the what bus and
chipselect the flash is connected to, as the new driver needs
this information.

The property 'fsl,qspi-has-second-chip' is not needed anymore
and will be removed after the old driver was disabled to avoid
breaking ls1021a-moxa-uc-8410a.dts.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 arch/arm/boot/dts/imx6sx-sdb-reva.dts       | 8 ++++++--
 arch/arm/boot/dts/imx6sx-sdb.dts            | 8 ++++++--
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi     | 2 ++
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts | 5 ++---
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
index e3533e7..1a6f680 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -131,13 +131,17 @@
 		#size-cells = <1>;
 		compatible = "spansion,s25fl128s", "jedec,spi-nor";
 		spi-max-frequency = <66000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 
-	flash1: s25fl128s@1 {
-		reg = <1>;
+	flash1: s25fl128s@2 {
+		reg = <2>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spansion,s25fl128s", "jedec,spi-nor";
 		spi-max-frequency = <66000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 6dd9beb..9acfda8 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -117,15 +117,19 @@
 		#size-cells = <1>;
 		compatible = "micron,n25q256a", "jedec,spi-nor";
 		spi-max-frequency = <29000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 
-	flash1: n25q256a@1 {
+	flash1: n25q256a@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "micron,n25q256a", "jedec,spi-nor";
 		spi-max-frequency = <29000000>;
-		reg = <1>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		reg = <2>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
index 32a0723..c2c9a2a 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
@@ -176,6 +176,8 @@
 		#size-cells = <1>;
 		compatible = "micron,n25q256a";
 		spi-max-frequency = <29000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 };
diff --git a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
index d01f64b..6a83f30 100644
--- a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
+++ b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
@@ -203,9 +203,6 @@
 };
 
 &qspi {
-	bus-num = <0>;
-	fsl,spi-num-chipselects = <2>;
-	fsl,spi-flash-chipselects = <0>;
 	fsl,qspi-has-second-chip;
 	status = "okay";
 
@@ -214,6 +211,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 
 		partitions@0 {
-- 
2.7.4
