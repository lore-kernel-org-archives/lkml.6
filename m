Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC809C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61B623DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="oGNHfdtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61B623DEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbeGELSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:18:15 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.132]:27271 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeGELSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530789491;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=YDBrDiW6WYXA00RkQwERGynv8FJXXTpWWf9YV05GYmg=;
        b=oGNHfdtkYI2/BRmG2yNfaWdtOu9tAvMPs4LJh5Spd9Ww6VCtuI4wlYRz6TqJ59Dt5S
        5XywY/fojKyEMt3MTxSpStIS1NmkLb/WLt14/oTZqu7pE1+MY7B07ygEYE2PcQBoraAJ
        hNdn12IQSvx32Ld9eVc9QABjFqL2ovyBxKJoVxQ91ZEK5c8K+fexyzqWGGrH2sTL0lME
        UfijUoESa4ylqWq1pD31l4j4/U9rODthGiFxyqsBxbm12ppacXfysPhGnHX+oG8spzbn
        Dub4s/LPp3tfE0D1BgEgdqzMnyeIzXhwGte/fIkHPz/CfNF/+rTXFWTMu/nHqijmVbtJ
        CSWw==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+daE87UU5bgm7XHzClQnm8VxHglxo5wj3H1fls="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id a0925bu65BHk4iC
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 13:17:46 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
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
Subject: [PATCH v2 05/12] dt-bindings: spi: Adjust the bindings for the FSL QSPI driver
Date:   Thu,  5 Jul 2018 13:15:01 +0200
Message-Id: <1530789310-16254-6-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the documentation of the new SPI memory interface based
driver to reflect the new drivers settings.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
Changes in v2:
==============
* Split the moving and editing of the dt-bindings in two patches

 .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index 483e9cf..8b4eed7 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -3,9 +3,8 @@
 Required properties:
   - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
 		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
-		 "fsl,ls1021a-qspi"
+		 "fsl,ls1021a-qspi", "fsl,ls2080a-qspi"
 		 or
-		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
 		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
   - reg : the first contains the register location and length,
           the second contains the memory mapping address and length
@@ -15,14 +14,15 @@ Required properties:
   - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
 
 Optional properties:
-  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
-                              Each bus can be connected with two NOR flashes.
-			      Most of the time, each bus only has one NOR flash
-			      connected, this is the default case.
-			      But if there are two NOR flashes connected to the
-			      bus, you should enable this property.
-			      (Please check the board's schematic.)
-  - big-endian : That means the IP register is big endian
+  - big-endian : That means the IP registers format is big endian
+
+Required SPI slave node properties:
+  - reg: There are two buses (A and B) with two chip selects each.
+	 This encodes to which bus and CS the flash is connected:
+		<0>: Bus A, CS 0
+		<1>: Bus A, CS 1
+		<2>: Bus B, CS 0
+		<3>: Bus B, CS 1
 
 Example:
 
@@ -40,7 +40,7 @@ qspi0: quadspi@40044000 {
 	};
 };
 
-Example showing the usage of two SPI NOR devices:
+Example showing the usage of two SPI NOR devices on bus A:
 
 &qspi2 {
 	pinctrl-names = "default";
-- 
2.7.4

