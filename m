Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A1EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987AE2082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987AE2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbeKMXp4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:45:56 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:45122 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732959AbeKMXpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:45:55 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 3646167A08A;
        Tue, 13 Nov 2018 14:47:38 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 13 Nov
 2018 14:47:37 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Tue, 13 Nov 2018 14:47:37 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/9] dt-bindings: spi: Adjust the bindings for the FSL QSPI
 driver
Thread-Topic: [PATCH v5 5/9] dt-bindings: spi: Adjust the bindings for the FSL
 QSPI driver
Thread-Index: AQHUe1dwps7l/YeMeECxVWvmG8EAHQ==
Date:   Tue, 13 Nov 2018 13:47:37 +0000
Message-ID: <1542116782-13118-6-git-send-email-frieder.schrempf@kontron.de>
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
X-SnT-MailScanner-ID: 3646167A08A.ACDEB
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        fabio.estevam@nxp.com, han.xu@nxp.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, prabhakar.kushwaha@nxp.com,
        richard@nod.at, robh+dt@kernel.org, shawnguo@kernel.org,
        yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the documentation of the new SPI memory interface based
driver to reflect the new drivers settings.

The "old" driver was using the "fsl,qspi-has-second-chip" property to
select one of two dual chip setups (two chips on one bus or two chips
on separate buses). And it used the order in which the subnodes are
defined in the dt to select the CS, the chip is connected to.

Both methods are wrong and in fact the "reg" property should be used to
determine which bus and CS a chip is connected to. This also enables us
to use different setups than just single chip, or symmetric dual chip.

So the porting of the driver from the MTD to the SPI framework actually
enforces the use of the "reg" properties and makes
"fsl,qspi-has-second-chip" superfluous.

As all boards that have "fsl,qspi-has-second-chip" set, also have
correct "reg" properties, the removal of this property shouldn't lead to
any incompatibilities.

The only compatibility issues I can see are with imx6sx-sdb.dts and
imx6sx-sdb-reva.dts, which have their reg properties set incorrectly
(see explanation here: [2]), all other boards should stay compatible.

Also the "big-endian" flag was removed, as this setting is now selected
by the driver, depending on which SoC is in use.

[2] https://patchwork.ozlabs.org/patch/922817/#1925445

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../devicetree/bindings/spi/spi-fsl-qspi.txt      | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index 483e9cf..e8f1d62 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -14,15 +14,13 @@ Required properties:
   - clocks : The clocks needed by the QuadSPI controller
   - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
 
-Optional properties:
-  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
-                              Each bus can be connected with two NOR flashes.
-			      Most of the time, each bus only has one NOR flash
-			      connected, this is the default case.
-			      But if there are two NOR flashes connected to the
-			      bus, you should enable this property.
-			      (Please check the board's schematic.)
-  - big-endian : That means the IP register is big endian
+Required SPI slave node properties:
+  - reg: There are two buses (A and B) with two chip selects each.
+	 This encodes to which bus and CS the flash is connected:
+		<0>: Bus A, CS 0
+		<1>: Bus A, CS 1
+		<2>: Bus B, CS 0
+		<3>: Bus B, CS 1
 
 Example:
 
@@ -40,7 +38,7 @@ qspi0: quadspi@40044000 {
 	};
 };
 
-Example showing the usage of two SPI NOR devices:
+Example showing the usage of two SPI NOR devices on bus A:
 
 &qspi2 {
 	pinctrl-names = "default";
-- 
2.7.4
