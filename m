Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeE3N31 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:29:27 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.135]:36248 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753540AbeE3N2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:28:22 -0400
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
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] arm64: dts: Reflect change of FSL QSPI driver and remove unused properties
Date: Wed, 30 May 2018 15:14:35 +0200
Message-Id: <1527686082-15142-7-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSL QSPI driver was moved to the SPI framework and it now
acts as a SPI controller. Therefore the subnodes need to set
spi-[rx/tx]-bus-width = <4>, so quad mode is used just as before.

Also the properties 'num-cs' and 'bus-num' were never read by the
driver and can be removed.

The property 'fsl,qspi-has-second-chip' is not needed anymore
and will be removed after the old driver was disabled to avoid
breaking fsl-ls1046a-rdb.dts.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 3 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 6 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 4 ++++
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index 6341281..31e7b31 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -170,7 +170,6 @@
 };
 
 &qspi {
-	bus-num = <0>;
 	status = "okay";
 
 	qflash0: s25fl128s@0 {
@@ -178,6 +177,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index 434383b..dc10105 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -198,8 +198,6 @@
 };
 
 &qspi {
-	num-cs = <2>;
-	bus-num = <0>;
 	status = "okay";
 
 	qflash0: s25fl128s@0 {
@@ -207,6 +205,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index 5dc2782..1848c33 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -136,8 +136,6 @@
 };
 
 &qspi {
-	num-cs = <2>;
-	bus-num = <0>;
 	status = "okay";
 
 	qflash0: s25fs512s@0 {
@@ -145,6 +143,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 
@@ -153,6 +153,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index 1de6188..fc62ed9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -170,6 +170,8 @@
 		#size-cells = <1>;
 		compatible = "st,m25p80";
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 	flash2: s25fl256s1@2 {
@@ -177,6 +179,8 @@
 		#size-cells = <1>;
 		compatible = "st,m25p80";
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <2>;
 	};
 };
-- 
2.7.4
