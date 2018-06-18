Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AC9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE5620852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE5620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935139AbeFROO7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:14:59 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:41653 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935034AbeFROOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:14:07 -0400
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="16045991"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Jun 2018 07:14:06 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch06.mchp-main.com (10.10.76.107) with Microsoft SMTP Server id
 14.3.352.0; Mon, 18 Jun 2018 07:14:01 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <nicolas.ferre@microchip.com>, <boris.brezillon@bootlin.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <sboyd@kernel.org>
CC:     <Cristian.Birsan@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH v5 5/5] ARM: dts: at91: sama5d2 Xplained: add pin muxing for I2S
Date:   Mon, 18 Jun 2018 17:12:39 +0300
Message-ID: <20180618141239.10892-6-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
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

Changes in v5:
	- Previous name was:
	  [PATCH v4 7/7] ARM: dts: at91: sama5d2 Xplained: add pin muxing for I2S

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index e4bbb7e0f793..03917312dec1 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -281,6 +281,11 @@
 				status = "okay";
 			};
 
+			i2s0: i2s@f8050000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2s0_default>;
+			};
+
 			can0: can@f8054000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can0_default>;
@@ -424,6 +429,24 @@
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
@@ -546,6 +569,11 @@
 				status = "okay";
 			};
 
+			i2s1: i2s@fc04c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2s1_default>;
+			};
+
 			can1: can@fc050000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can1_default>;
-- 
2.17.1

