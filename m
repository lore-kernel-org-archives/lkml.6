Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F77C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B67223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B67223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbeKMXpi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:45:38 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:45046 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733211AbeKMXph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:45:37 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 452BC4FE8488;
        Tue, 13 Nov 2018 14:47:22 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 13 Nov
 2018 14:47:21 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Tue, 13 Nov 2018 14:47:21 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "Schrempf Frieder" <frieder.schrempf@kontron.De>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/9] arm64: dts: Reflect change of FSL QSPI driver and
 remove unused properties
Thread-Topic: [PATCH v5 2/9] arm64: dts: Reflect change of FSL QSPI driver and
 remove unused properties
Thread-Index: AQHUe1dmrfyrEszCXEul9XINffX+8A==
Date:   Tue, 13 Nov 2018 13:47:21 +0000
Message-ID: <1542116782-13118-3-git-send-email-frieder.schrempf@kontron.de>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 452BC4FE8488.A9D36
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        fabio.estevam@nxp.com, han.xu@nxp.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, prabhakar.kushwaha@nxp.com,
        richard@nod.at, robh+dt@kernel.org, shawnguo@kernel.org,
        yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSL QSPI driver will be moved to the SPI framework and it then
acts as a SPI controller. Therefore the subnodes need to set
spi-[rx/tx]-bus-width = <4>, so quad mode is used just as before.

Also the properties 'num-cs' and 'bus-num' were never read by the
driver and can be removed.

The property 'fsl,qspi-has-second-chip' is not needed anymore
and will be removed after the old driver was disabled to avoid
breaking fsl-ls1046a-rdb.dts.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 3 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 6 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 4 ++++
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index dff3d64..8a50094 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -135,7 +135,6 @@
 };
 
 &qspi {
-	bus-num = <0>;
 	status = "okay";
 
 	qflash0: s25fl128s@0 {
@@ -143,6 +142,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index e58a8ca..2f220ec 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -163,8 +163,6 @@
 };
 
 &qspi {
-	num-cs = <2>;
-	bus-num = <0>;
 	status = "okay";
 
 	qflash0: s25fl128s@0 {
@@ -172,6 +170,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index a59b482..07c665c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -99,8 +99,6 @@
 };
 
 &qspi {
-	num-cs = <2>;
-	bus-num = <0>;
 	status = "okay";
 
 	qflash0: s25fs512s@0 {
@@ -108,6 +106,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 
@@ -116,6 +116,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index c11f52e..10d2fe0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -134,6 +134,8 @@
 		#size-cells = <1>;
 		compatible = "st,m25p80";
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 	flash2: s25fl256s1@2 {
@@ -141,6 +143,8 @@
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
