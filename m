Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEC7C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66242154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66242154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeHTNfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:35:46 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:23789 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeHTNfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:35:45 -0400
X-IronPort-AV: E=Sophos;i="5.53,264,1531810800"; 
   d="scan'208";a="18398509"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Aug 2018 03:20:44 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Mon, 20 Aug 2018 03:20:43 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH] ARM: dts: at91/trivial: remove old NAND bindings leftover in sama5d2
Date:   Mon, 20 Aug 2018 12:20:41 +0200
Message-ID: <20180820102041.27476-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the new bindings are already in place in sama5d2.dtsi and that it's used
in the only Mainline board for this product (at91-sama5d2_ptc_ek.dts), we can
safely remove the old bindings.

Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5c48e9..fd1a401f2914 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -323,44 +323,6 @@
 			};
 		};
 
-		nand0: nand@80000000 {
-			compatible = "atmel,sama5d2-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			reg = < /* EBI CS3 */
-				0x80000000 0x08000000
-				/* SMC PMECC regs */
-				0xf8014070 0x00000490
-				/* SMC PMECC Error Location regs */
-				0xf8014500 0x00000200
-				/* ROM Galois tables */
-				0x00040000 0x00018000
-				>;
-			interrupts = <17 IRQ_TYPE_LEVEL_HIGH 6>;
-			atmel,nand-addr-offset = <21>;
-			atmel,nand-cmd-offset = <22>;
-			atmel,nand-has-dma;
-			atmel,has-pmecc;
-			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
-			status = "disabled";
-
-			nfc@c0000000 {
-				compatible = "atmel,sama5d3-nfc";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = < /* NFC Command Registers */
-					0xc0000000 0x08000000
-					/* NFC HSMC regs */
-					0xf8014000 0x00000070
-					/* NFC SRAM banks */
-					0x00100000 0x00100000
-					>;
-				clocks = <&hsmc_clk>;
-				atmel,write-by-sram;
-			};
-		};
-
 		sdmmc0: sdio-host@a0000000 {
 			compatible = "atmel,sama5d2-sdhci";
 			reg = <0xa0000000 0x300>;
-- 
2.15.1

