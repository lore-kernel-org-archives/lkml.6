Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeCNFLt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:11:49 -0400
Received: from mx.socionext.com ([202.248.49.38]:50325 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbeCNFLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:11:47 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] pinctrl: uniphier: add PXs2 Audio in/out pin-mux settings
Date: Wed, 14 Mar 2018 14:11:37 +0900
Message-Id: <20180314051137.6091-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UniPhier PXs2 SoC audio core use following 25 pins:
  ain1    : 2ch I2S input : AI1ADCCK, AI1BCK, AI1D0, AI1LRCK
  ain2    : 8ch I2S input : AI2ADCCK, AI2BCK, AI2D[0-3], AI2LRCK
  ainiec1 : S/PDIF input  : XIRQ17 (for AO1IEC)
  aout2   : 8ch I2S output: AO2BCK, AO2D0, AO2DACCK, AO2LRCK
                            PORT226, 227, 230 (for AO2D[1-3])
  aout3   : 2ch I2S output: AO3BCK, AO3DMIX, AO3DACCK, AO3LRCK
  aoutiec1: S/PDIF output : PORT132(for AO1IEC)
  aoutiec2: S/PDIF output : AO2IEC

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index c0ef40ae99a7..f0a4cfc00160 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -728,6 +728,20 @@ static const struct pinctrl_pin_desc uniphier_pxs2_pins[] = {
 			     234, UNIPHIER_PIN_PULL_DOWN),
 };
 
+static const unsigned ain1_pins[] = {161, 162, 173, 174};
+static const int ain1_muxvals[] = {8, 8, 8, 8};
+static const unsigned ain2_pins[] = {98, 99, 100, 101, 102, 103, 104};
+static const int ain2_muxvals[] = {8, 8, 8, 8, 8, 8, 8};
+static const unsigned ainiec1_pins[] = {91};
+static const int ainiec1_muxvals[] = {11};
+static const unsigned aout2_pins[] = {175, 176, 177, 178, 183, 184, 185};
+static const int aout2_muxvals[] = {8, 8, 8, 8, 9, 9, 9};
+static const unsigned aout3_pins[] = {105, 106, 107, 108};
+static const int aout3_muxvals[] = {8, 8, 8, 8};
+static const unsigned aoutiec1_pins[] = {95};
+static const int aoutiec1_muxvals[] = {11};
+static const unsigned aoutiec2_pins[] = {97};
+static const int aoutiec2_muxvals[] = {8};
 static const unsigned emmc_pins[] = {36, 37, 38, 39, 40, 41, 42};
 static const int emmc_muxvals[] = {9, 9, 9, 9, 9, 9, 9};
 static const unsigned emmc_dat8_pins[] = {43, 44, 45, 46};
@@ -824,6 +838,13 @@ static const unsigned int gpio_range1_pins[] = {
 };
 
 static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
+	UNIPHIER_PINCTRL_GROUP(ain1),
+	UNIPHIER_PINCTRL_GROUP(ain2),
+	UNIPHIER_PINCTRL_GROUP(ainiec1),
+	UNIPHIER_PINCTRL_GROUP(aout2),
+	UNIPHIER_PINCTRL_GROUP(aout3),
+	UNIPHIER_PINCTRL_GROUP(aoutiec1),
+	UNIPHIER_PINCTRL_GROUP(aoutiec2),
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
 	UNIPHIER_PINCTRL_GROUP(ether_mii),
@@ -854,6 +875,13 @@ static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
 	UNIPHIER_PINCTRL_GROUP_GPIO(gpio_range1),
 };
 
+static const char * const ain1_groups[] = {"ain1"};
+static const char * const ain2_groups[] = {"ain2"};
+static const char * const ainiec1_groups[] = {"ainiec1"};
+static const char * const aout2_groups[] = {"aout2"};
+static const char * const aout3_groups[] = {"aout3"};
+static const char * const aoutiec1_groups[] = {"aoutiec1"};
+static const char * const aoutiec2_groups[] = {"aoutiec2"};
 static const char * const emmc_groups[] = {"emmc", "emmc_dat8"};
 static const char * const ether_mii_groups[] = {"ether_mii"};
 static const char * const ether_rgmii_groups[] = {"ether_rgmii"};
@@ -878,6 +906,13 @@ static const char * const usb2_groups[] = {"usb2"};
 static const char * const usb3_groups[] = {"usb3"};
 
 static const struct uniphier_pinmux_function uniphier_pxs2_functions[] = {
+	UNIPHIER_PINMUX_FUNCTION(ain1),
+	UNIPHIER_PINMUX_FUNCTION(ain2),
+	UNIPHIER_PINMUX_FUNCTION(ainiec1),
+	UNIPHIER_PINMUX_FUNCTION(aout2),
+	UNIPHIER_PINMUX_FUNCTION(aout3),
+	UNIPHIER_PINMUX_FUNCTION(aoutiec1),
+	UNIPHIER_PINMUX_FUNCTION(aoutiec2),
 	UNIPHIER_PINMUX_FUNCTION(emmc),
 	UNIPHIER_PINMUX_FUNCTION(ether_mii),
 	UNIPHIER_PINMUX_FUNCTION(ether_rgmii),
-- 
2.16.1
