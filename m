Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BE8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A9A2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="XtbpgVZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A9A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbeKHA0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:26:33 -0500
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.130]:15069 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbeKHA0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1541602547;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=L+2C2V6X05Jd6Z3JyhwcUJuCDtAzLwdUlTWG7X9XnDk=;
        b=XtbpgVZPqwdWVJpMpdt/48/ZmRpGd6bbk2bjtcN/pL0bwSafyxSyOU/+tJJ+KfVfjI
        espJy1abK5QzI5ysfmlRNG4W9CELzvzBfiEGs3sZ3dGvhB2LbFvaot69KgewuhWTk7m1
        j7NBpkJFjLZEV6JXqN/lCpVbCtsMz9HOt5AnwVb5OHM1iGizEuAkTaZAkUtop1BKzWJk
        Rgmse/uiVO/4eBy0XUx/nWat1tddtpOJItYFrUmg8e8YaG2HU+ax1I07uEJ/l23q7tkr
        NDZPAhB71OsJ5CAohi6hL+YgeNc8k7k7ruBEaNFM7u+74cXrbfXUoJE13KZTo7idBSVd
        sGSw==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx7ZdE8mPU5nMS5P2QgHAetWm5FNngAjmE0pFNjw="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id j097e4uA7Ei8UQl
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 7 Nov 2018 15:44:08 +0100 (CET)
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/10] dt-bindings: spi: Move the bindings for the FSL QSPI driver
Date:   Wed,  7 Nov 2018 15:43:19 +0100
Message-Id: <1541601809-16950-3-git-send-email-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@exceet.de>

Move the documentation of the old SPI NOR driver to the place of the new
SPI memory interface based driver.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 .../devicetree/bindings/mtd/fsl-quadspi.txt     | 65 --------------------
 .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 65 ++++++++++++++++++++
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
deleted file mode 100644
index 483e9cf..0000000
--- a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-* Freescale Quad Serial Peripheral Interface(QuadSPI)
-
-Required properties:
-  - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
-		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
-		 "fsl,ls1021a-qspi"
-		 or
-		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
-		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
-  - reg : the first contains the register location and length,
-          the second contains the memory mapping address and length
-  - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
-  - interrupts : Should contain the interrupt for the device
-  - clocks : The clocks needed by the QuadSPI controller
-  - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
-
-Optional properties:
-  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
-                              Each bus can be connected with two NOR flashes.
-			      Most of the time, each bus only has one NOR flash
-			      connected, this is the default case.
-			      But if there are two NOR flashes connected to the
-			      bus, you should enable this property.
-			      (Please check the board's schematic.)
-  - big-endian : That means the IP register is big endian
-
-Example:
-
-qspi0: quadspi@40044000 {
-	compatible = "fsl,vf610-qspi";
-	reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
-	reg-names = "QuadSPI", "QuadSPI-memory";
-	interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clks VF610_CLK_QSPI0_EN>,
-		<&clks VF610_CLK_QSPI0>;
-	clock-names = "qspi_en", "qspi";
-
-	flash0: s25fl128s@0 {
-		....
-	};
-};
-
-Example showing the usage of two SPI NOR devices:
-
-&qspi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_qspi2>;
-	status = "okay";
-
-	flash0: n25q256a@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "micron,n25q256a", "jedec,spi-nor";
-		spi-max-frequency = <29000000>;
-		reg = <0>;
-	};
-
-	flash1: n25q256a@1 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "micron,n25q256a", "jedec,spi-nor";
-		spi-max-frequency = <29000000>;
-		reg = <1>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
new file mode 100644
index 0000000..483e9cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -0,0 +1,65 @@
+* Freescale Quad Serial Peripheral Interface(QuadSPI)
+
+Required properties:
+  - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
+		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
+		 "fsl,ls1021a-qspi"
+		 or
+		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
+		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
+  - reg : the first contains the register location and length,
+          the second contains the memory mapping address and length
+  - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
+  - interrupts : Should contain the interrupt for the device
+  - clocks : The clocks needed by the QuadSPI controller
+  - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
+
+Optional properties:
+  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
+                              Each bus can be connected with two NOR flashes.
+			      Most of the time, each bus only has one NOR flash
+			      connected, this is the default case.
+			      But if there are two NOR flashes connected to the
+			      bus, you should enable this property.
+			      (Please check the board's schematic.)
+  - big-endian : That means the IP register is big endian
+
+Example:
+
+qspi0: quadspi@40044000 {
+	compatible = "fsl,vf610-qspi";
+	reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
+	reg-names = "QuadSPI", "QuadSPI-memory";
+	interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks VF610_CLK_QSPI0_EN>,
+		<&clks VF610_CLK_QSPI0>;
+	clock-names = "qspi_en", "qspi";
+
+	flash0: s25fl128s@0 {
+		....
+	};
+};
+
+Example showing the usage of two SPI NOR devices:
+
+&qspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi2>;
+	status = "okay";
+
+	flash0: n25q256a@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q256a", "jedec,spi-nor";
+		spi-max-frequency = <29000000>;
+		reg = <0>;
+	};
+
+	flash1: n25q256a@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q256a", "jedec,spi-nor";
+		spi-max-frequency = <29000000>;
+		reg = <1>;
+	};
+};
-- 
2.7.4

