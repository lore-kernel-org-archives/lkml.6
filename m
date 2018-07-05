Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5579EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0187A23DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="OnpqXNTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0187A23DEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753635AbeGELSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:18:30 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.182]:18207 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753590AbeGELS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530789505;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=6nqxNFfetm6z29BbZ2XLYltD3qUIISTDCljCp98hv6I=;
        b=OnpqXNTPv7mnJUu6Iiy3hrQkkfn2fDsduo3eGw5mn8wxbtGXpY0NeJCUXCIBNp1FbM
        Dk61aMzloSATbHur9Ko0q4LrVCE3u5WXuQ9jPBNJX+o3UOIZcYgKHFXuQJhNyrf+bfOo
        FRupQyKN8ZHiZ9qDcoGkP6PkoJAu+7ZW2cIMj5gB+L7l+otxLm4hsmQCH2zijTt64Y9S
        64oanrVmaw2CRkwzZucBJX/U+vOXLLzSDtnvTCkijQMSMfHDLeKTyb7pDrRzAU8C+/vw
        OnUSinR4uOO9UeJbJz4+oZZfw0it39hwJwFsDY4U3OytVN5iOYySBljsRv+Dg4yKHh/L
        I+dQ==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+daE87UU5bgm7XHzClQnm8VxHglxo5wj3H1fls="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id a0925bu65BHq4iE
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 13:17:52 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/12] ARM: dts: Reflect change of FSL QSPI driver and remove unused properties
Date:   Thu,  5 Jul 2018 13:15:02 +0200
Message-Id: <1530789310-16254-7-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

