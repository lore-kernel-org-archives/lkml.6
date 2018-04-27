Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeD0Ai6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 20:38:58 -0400
Received: from mx.socionext.com ([202.248.49.38]:11179 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753619AbeD0Aiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 20:38:55 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH 2/2] pinctrl: uniphier: add LD11 MPEG2-TS I/O pin-mux settings
Date: Fri, 27 Apr 2018 09:38:44 +0900
Message-Id: <20180427003844.3937-2-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427003844.3937-1-suzuki.katsuhiro@socionext.com>
References: <20180427003844.3937-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPEG2-TS input/output core both accepts serial TS and parallel TS.

The serial TS interface uses following pins:
  hscin0_s : HS0DOUT[0-3]
  hscin1_s : HS0DOUT[4-7]
  hscin2_s : HS1BCLKIN, HS1SYNCIN, HS1VALIN, HS1DIN0
  hscout0_s: HS0DOUT[0-3]
  hscout1_s: HS0DOUT[4-7]

And the parallel TS interface uses following pins:
  hscin0_p : HS0BCLKIN, HS0SYNCIN, HS0VALIN, HS0DIN[0-7]
  hscin1_p : HS1BCLKIN, HS1SYNCIN, HS1VALIN, HS1DIN[0-7]
  hscout0_p: HS0BCLKOUT, HS0SYNCOUT, HS0VALOUT, HS0DOUT[0-7]

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 .../pinctrl/uniphier/pinctrl-uniphier-ld11.c  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index 0976fbfecd50..5b5864efb514 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -481,6 +481,31 @@ static const int emmc_dat8_muxvals[] = {0, 0, 0, 0};
 static const unsigned ether_rmii_pins[] = {6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
 					   16, 17};
 static const int ether_rmii_muxvals[] = {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};
+static const unsigned hscin0_ci_pins[] = {102, 103, 104, 105, 106, 107, 108,
+					    109, 110, 111, 112};
+static const int hscin0_ci_muxvals[] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
+static const unsigned hscin0_p_pins[] = {102, 103, 104, 105, 106, 107, 108, 109,
+					 110, 111, 112};
+static const int hscin0_p_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned hscin1_p_pins[] = {124, 125, 126, 127, 128, 129, 130, 131,
+					 132, 133, 134};
+static const int hscin1_p_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned hscin0_s_pins[] = {116, 117, 118, 119};
+static const int hscin0_s_muxvals[] = {3, 3, 3, 3};
+static const unsigned hscin1_s_pins[] = {120, 121, 122, 123};
+static const int hscin1_s_muxvals[] = {3, 3, 3, 3};
+static const unsigned hscin2_s_pins[] = {124, 125, 126, 127};
+static const int hscin2_s_muxvals[] = {3, 3, 3, 3};
+static const unsigned hscout0_ci_pins[] = {113, 114, 115, 116, 117, 118, 119,
+					   120, 121, 122, 123};
+static const int hscout0_ci_muxvals[] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
+static const unsigned hscout0_p_pins[] = {113, 114, 115, 116, 117, 118, 119,
+					  120, 121, 122, 123};
+static const int hscout0_p_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned hscout0_s_pins[] = {116, 117, 118, 119};
+static const int hscout0_s_muxvals[] = {4, 4, 4, 4};
+static const unsigned hscout1_s_pins[] = {120, 121, 122, 123};
+static const int hscout1_s_muxvals[] = {4, 4, 4, 4};
 static const unsigned i2c0_pins[] = {63, 64};
 static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {65, 66};
@@ -556,6 +581,16 @@ static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(emmc),
 	UNIPHIER_PINCTRL_GROUP(emmc_dat8),
 	UNIPHIER_PINCTRL_GROUP(ether_rmii),
+	UNIPHIER_PINCTRL_GROUP(hscin0_ci),
+	UNIPHIER_PINCTRL_GROUP(hscin0_p),
+	UNIPHIER_PINCTRL_GROUP(hscin1_p),
+	UNIPHIER_PINCTRL_GROUP(hscin0_s),
+	UNIPHIER_PINCTRL_GROUP(hscin1_s),
+	UNIPHIER_PINCTRL_GROUP(hscin2_s),
+	UNIPHIER_PINCTRL_GROUP(hscout0_ci),
+	UNIPHIER_PINCTRL_GROUP(hscout0_p),
+	UNIPHIER_PINCTRL_GROUP(hscout0_s),
+	UNIPHIER_PINCTRL_GROUP(hscout1_s),
 	UNIPHIER_PINCTRL_GROUP(i2c0),
 	UNIPHIER_PINCTRL_GROUP(i2c1),
 	UNIPHIER_PINCTRL_GROUP(i2c3),
@@ -583,6 +618,15 @@ static const char * const aout1_groups[] = {"aout1"};
 static const char * const aoutiec1_groups[] = {"aoutiec1"};
 static const char * const emmc_groups[] = {"emmc", "emmc_dat8"};
 static const char * const ether_rmii_groups[] = {"ether_rmii"};
+static const char * const hscin0_groups[] = {"hscin0_s",
+					     "hscin0_p",
+					     "hscout0_ci"};
+static const char * const hscin1_groups[] = {"hscin1_s", "hscin0_p"};
+static const char * const hscin2_groups[] = {"hscin2_s"};
+static const char * const hscout0_groups[] = {"hscout0_s",
+					      "hscout0_p",
+					      "hscout0_ci"};
+static const char * const hscout1_groups[] = {"hscout1_s"};
 static const char * const i2c0_groups[] = {"i2c0"};
 static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c3_groups[] = {"i2c3"};
@@ -603,6 +647,11 @@ static const struct uniphier_pinmux_function uniphier_ld11_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(aoutiec1),
 	UNIPHIER_PINMUX_FUNCTION(emmc),
 	UNIPHIER_PINMUX_FUNCTION(ether_rmii),
+	UNIPHIER_PINMUX_FUNCTION(hscin0),
+	UNIPHIER_PINMUX_FUNCTION(hscin1),
+	UNIPHIER_PINMUX_FUNCTION(hscin2),
+	UNIPHIER_PINMUX_FUNCTION(hscout0),
+	UNIPHIER_PINMUX_FUNCTION(hscout1),
 	UNIPHIER_PINMUX_FUNCTION(i2c0),
 	UNIPHIER_PINMUX_FUNCTION(i2c1),
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
-- 
2.17.0
