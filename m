Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D6DC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1F321A07
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1F321A07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbeHFN2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:28:40 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:1331 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbeHFN2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:28:39 -0400
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="17430258"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Aug 2018 04:20:03 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Mon, 6 Aug 2018 04:20:04 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Cristian.Birsan@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH v7 3/3] ARM: dts: at91: sama5d2 Xplained: add pin muxing for I2S
Date:   Mon, 6 Aug 2018 14:19:48 +0300
Message-ID: <20180806111948.4522-4-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180806111948.4522-1-codrin.ciubotariu@microchip.com>
References: <20180806111948.4522-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch sets the pin muxing for the I2S controllers

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[codrin.ciubotariu@microchip.com: added pin muxing for the second
controller]
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v7:
	- added comments with pin conflicts created by the I2S
	  controllers;
	- explicitly disable the I2S nodes;

Changes in v6:
        - none

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 30 +++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index fcc85d70f36e..518e2b095ccf 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -281,6 +281,12 @@
 				status = "okay";
 			};
 
+			i2s0: i2s@f8050000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2s0_default>;
+				status = "disabled"; /* conflict with can0 */
+			};
+
 			can0: can@f8054000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can0_default>;
@@ -424,6 +430,24 @@
 					bias-disable;
 				};
 
+				pinctrl_i2s0_default: i2s0_default {
+					pinmux = <PIN_PC1__I2SC0_CK>,
+						 <PIN_PC2__I2SC0_MCK>,
+						 <PIN_PC3__I2SC0_WS>,
+						 <PIN_PC4__I2SC0_DI0>,
+						 <PIN_PC5__I2SC0_DO0>;
+					bias-disable;
+				};
+
+				pinctrl_i2s1_default: i2s1_default {
+					pinmux = <PIN_PA15__I2SC1_CK>,
+						 <PIN_PA14__I2SC1_MCK>,
+						 <PIN_PA16__I2SC1_WS>,
+						 <PIN_PA17__I2SC1_DI0>,
+						 <PIN_PA18__I2SC1_DO0>;
+					bias-disable;
+				};
+
 				pinctrl_key_gpio_default: key_gpio_default {
 					pinmux = <PIN_PB9__GPIO>;
 					bias-pull-up;
@@ -546,6 +570,12 @@
 				status = "okay";
 			};
 
+			i2s1: i2s@fc04c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2s1_default>;
+				status = "disabled"; /* conflict with spi0, sdmmc1 */
+			};
+
 			can1: can@fc050000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can1_default>;
-- 
2.17.1

