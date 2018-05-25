Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935471AbeEYMfk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:35:40 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:2687 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933238AbeEYMf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:35:27 -0400
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="15314135"
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <nicolas.ferre@microchip.com>,
        <boris.brezillon@bootlin.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <broonie@kernel.org>
CC: <Cristian.Birsan@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH v4 7/7] ARM: dts: at91: sama5d2 Xplained: add pin muxing for I2S
Date: Fri, 25 May 2018 15:34:28 +0300
Message-ID: <1527251668-31396-8-git-send-email-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch sets the pin muxing for the I2S controllers

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[codrin.ciubotariu@microchip.com: added pin muxing for the second
controller]
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index e4bbb7e..0391731 100644
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
2.7.4
