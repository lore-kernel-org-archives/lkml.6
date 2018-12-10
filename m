Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE64C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91EC2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91EC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeLJQ24 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:28:56 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:59248 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeLJQ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:28:53 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id DB38267A7D4;
        Mon, 10 Dec 2018 17:28:49 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 10 Dec
 2018 17:28:49 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Mon, 10 Dec 2018 17:28:49 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] ARM: dts: imx6sx-sdb: Fix the reg properties for the FSL
 QSPI nodes
Thread-Topic: [PATCH 3/5] ARM: dts: imx6sx-sdb: Fix the reg properties for the
 FSL QSPI nodes
Thread-Index: AQHUkKVuHtSvCOMRkkmd6GB9nU1xpw==
Date:   Mon, 10 Dec 2018 16:28:49 +0000
Message-ID: <1544459182-23655-4-git-send-email-frieder.schrempf@kontron.de>
References: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
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
X-SnT-MailScanner-ID: DB38267A7D4.A0845
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        devicetree@vger.kernel.org, fabio.estevam@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The current driver does not use the reg properties, but we will
add a new driver soon. To make sure we have a consistent scheme,
let's fix the reg properties here.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/boot/dts/imx6sx-sdb-reva.dts | 4 ++--
 arch/arm/boot/dts/imx6sx-sdb.dts      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
index 9cc6ff2..344abc2 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -134,8 +134,8 @@
 		spi-max-frequency = <66000000>;
 	};
 
-	flash1: s25fl128s@1 {
-		reg = <1>;
+	flash1: s25fl128s@2 {
+		reg = <2>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spansion,s25fl128s", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 6dd9beb..5a39703 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -120,12 +120,12 @@
 		reg = <0>;
 	};
 
-	flash1: n25q256a@1 {
+	flash1: n25q256a@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "micron,n25q256a", "jedec,spi-nor";
 		spi-max-frequency = <29000000>;
-		reg = <1>;
+		reg = <2>;
 	};
 };
 
-- 
2.7.4
