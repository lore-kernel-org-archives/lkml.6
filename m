Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DB9C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE1F218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfBGKQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:16:06 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:47557 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:16:06 -0500
X-IronPort-AV: E=Sophos;i="5.58,343,1544511600"; 
   d="scan'208";a="25952370"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Feb 2019 03:16:05 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Thu, 7 Feb 2019 03:16:05 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Eugen Hristev <eugen.hristev@microchip.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2: add labels to soc dtsi for derivative boards
Date:   Thu, 7 Feb 2019 11:15:47 +0100
Message-ID: <20190207101547.14602-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds labels to commonly used device-tree nodes so that derivative
boards can avoid ahb/apb hierarchy.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index d159ee42ef29..9519b9d5abca 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -688,13 +688,13 @@
 				ranges = <0 0xf8044000 0x1420>;
 			};
 
-			rstc@f8048000 {
+			reset_controller: rstc@f8048000 {
 				compatible = "atmel,sama5d3-rstc";
 				reg = <0xf8048000 0x10>;
 				clocks = <&clk32k>;
 			};
 
-			shdwc@f8048010 {
+			shutdown_controller: shdwc@f8048010 {
 				compatible = "atmel,sama5d2-shdwc";
 				reg = <0xf8048010 0x10>;
 				clocks = <&clk32k>;
@@ -710,7 +710,7 @@
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK2>;
 			};
 
-			watchdog@f8048040 {
+			watchdog: watchdog@f8048040 {
 				compatible = "atmel,sama5d4-wdt";
 				reg = <0xf8048040 0x10>;
 				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
-- 
2.17.1

