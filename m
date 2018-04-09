Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeDIOyo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:54:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39902 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeDIOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:54:43 -0400
X-Google-Smtp-Source: AIpwx4+I1U3c8t/H6SNG0vbG3p/tRx7Pxfr5bBODeRT11TwOFDkuvMvrLzCM+oQPG/mlg0Y6j6IJKQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: meson: axg: add tdm pins
Date: Mon,  9 Apr 2018 16:54:29 +0200
Message-Id: <20180409145429.16619-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the information related to the tdm pins of the A113D SoC

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-axg.c | 107 ++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 4b91ff74779b..11dc23fde6d5 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -312,6 +312,47 @@ static const unsigned int pdm_din1_pins[] = {GPIOA_16};
 static const unsigned int pdm_din2_pins[] = {GPIOA_17};
 static const unsigned int pdm_din3_pins[] = {GPIOA_18};
 
+/* mclk */
+static const unsigned int mclk_c_pins[] = {GPIOA_0};
+static const unsigned int mclk_b_pins[] = {GPIOA_1};
+
+/* tdm */
+static const unsigned int tdma_sclk_pins[] = {GPIOX_12};
+static const unsigned int tdma_sclk_slv_pins[] = {GPIOX_12};
+static const unsigned int tdma_fs_pins[] = {GPIOX_13};
+static const unsigned int tdma_fs_slv_pins[] = {GPIOX_13};
+static const unsigned int tdma_din0_pins[] = {GPIOX_14};
+static const unsigned int tdma_dout0_x14_pins[] = {GPIOX_14};
+static const unsigned int tdma_dout0_x15_pins[] = {GPIOX_15};
+static const unsigned int tdma_dout1_pins[] = {GPIOX_15};
+static const unsigned int tdma_din1_pins[] = {GPIOX_15};
+
+static const unsigned int tdmc_sclk_pins[] = {GPIOA_2};
+static const unsigned int tdmc_sclk_slv_pins[] = {GPIOA_2};
+static const unsigned int tdmc_fs_pins[] = {GPIOA_3};
+static const unsigned int tdmc_fs_slv_pins[] = {GPIOA_3};
+static const unsigned int tdmc_din0_pins[] = {GPIOA_4};
+static const unsigned int tdmc_dout0_pins[] = {GPIOA_4};
+static const unsigned int tdmc_din1_pins[] = {GPIOA_5};
+static const unsigned int tdmc_dout1_pins[] = {GPIOA_5};
+static const unsigned int tdmc_din2_pins[] = {GPIOA_6};
+static const unsigned int tdmc_dout2_pins[] = {GPIOA_6};
+static const unsigned int tdmc_din3_pins[] = {GPIOA_7};
+static const unsigned int tdmc_dout3_pins[] = {GPIOA_7};
+
+static const unsigned int tdmb_sclk_pins[] = {GPIOA_8};
+static const unsigned int tdmb_sclk_slv_pins[] = {GPIOA_8};
+static const unsigned int tdmb_fs_pins[] = {GPIOA_9};
+static const unsigned int tdmb_fs_slv_pins[] = {GPIOA_9};
+static const unsigned int tdmb_din0_pins[] = {GPIOA_10};
+static const unsigned int tdmb_dout0_pins[] = {GPIOA_10};
+static const unsigned int tdmb_din1_pins[] = {GPIOA_11};
+static const unsigned int tdmb_dout1_pins[] = {GPIOA_11};
+static const unsigned int tdmb_din2_pins[] = {GPIOA_12};
+static const unsigned int tdmb_dout2_pins[] = {GPIOA_12};
+static const unsigned int tdmb_din3_pins[] = {GPIOA_13};
+static const unsigned int tdmb_dout3_pins[] = {GPIOA_13};
+
 static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0),
 	GPIO_GROUP(GPIOZ_1),
@@ -495,6 +536,15 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GROUP(eth_rx_dv_x, 4),
 	GROUP(eth_mdio_x, 4),
 	GROUP(eth_mdc_x, 4),
+	GROUP(tdma_sclk, 1),
+	GROUP(tdma_sclk_slv, 2),
+	GROUP(tdma_fs, 1),
+	GROUP(tdma_fs_slv, 2),
+	GROUP(tdma_din0, 1),
+	GROUP(tdma_dout0_x14, 2),
+	GROUP(tdma_dout0_x15, 1),
+	GROUP(tdma_dout1, 2),
+	GROUP(tdma_din1, 3),
 
 	/* bank GPIOY */
 	GROUP(eth_txd0_y, 1),
@@ -544,6 +594,32 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GROUP(pdm_din1, 1),
 	GROUP(pdm_din2, 1),
 	GROUP(pdm_din3, 1),
+	GROUP(mclk_c, 1),
+	GROUP(mclk_b, 1),
+	GROUP(tdmc_sclk, 1),
+	GROUP(tdmc_sclk_slv, 2),
+	GROUP(tdmc_fs, 1),
+	GROUP(tdmc_fs_slv, 2),
+	GROUP(tdmc_din0, 2),
+	GROUP(tdmc_dout0, 1),
+	GROUP(tdmc_din1, 2),
+	GROUP(tdmc_dout1, 1),
+	GROUP(tdmc_din2, 2),
+	GROUP(tdmc_dout2, 1),
+	GROUP(tdmc_din3, 2),
+	GROUP(tdmc_dout3, 1),
+	GROUP(tdmb_sclk, 1),
+	GROUP(tdmb_sclk_slv, 2),
+	GROUP(tdmb_fs, 1),
+	GROUP(tdmb_fs_slv, 2),
+	GROUP(tdmb_din0, 2),
+	GROUP(tdmb_dout0, 1),
+	GROUP(tdmb_din1, 2),
+	GROUP(tdmb_dout1, 1),
+	GROUP(tdmb_din2, 2),
+	GROUP(tdmb_dout2, 1),
+	GROUP(tdmb_din3, 2),
+	GROUP(tdmb_dout3, 1),
 };
 
 /* uart_ao_a */
@@ -845,6 +921,32 @@ static const char * const jtag_ao_groups[] = {
 	"jtag_ao_tdi", "jtag_ao_tdo", "jtag_ao_clk", "jtag_ao_tms",
 };
 
+static const char * const mclk_c_groups[] = {
+	"mclk_c",
+};
+
+static const char * const mclk_b_groups[] = {
+	"mclk_b",
+};
+
+static const char * const tdma_groups[] = {
+	"tdma_sclk", "tdma_sclk_slv", "tdma_fs", "tdma_fs_slv",
+	"tdma_din0", "tdma_dout0_x14", "tdma_dout0_x15", "tdma_dout1",
+	"tdma_din1",
+};
+
+static const char * const tdmc_groups[] = {
+	"tdmc_sclk", "tdmc_sclk_slv", "tdmc_fs", "tdmc_fs_slv",
+	"tdmc_din0", "tdmc_dout0", "tdmc_din1",	"tdmc_dout1",
+	"tdmc_din2", "tdmc_dout2", "tdmc_din3",	"tdmc_dout3",
+};
+
+static const char * const tdmb_groups[] = {
+	"tdmb_sclk", "tdmb_sclk_slv", "tdmb_fs", "tdmb_fs_slv",
+	"tdmb_din0", "tdmb_dout0", "tdmb_din1",	"tdmb_dout1",
+	"tdmb_din2", "tdmb_dout2", "tdmb_din3",	"tdmb_dout3",
+};
+
 static struct meson_pmx_func meson_axg_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
@@ -870,6 +972,11 @@ static struct meson_pmx_func meson_axg_periphs_functions[] = {
 	FUNCTION(spdif_in),
 	FUNCTION(jtag_ee),
 	FUNCTION(pdm),
+	FUNCTION(mclk_b),
+	FUNCTION(mclk_c),
+	FUNCTION(tdma),
+	FUNCTION(tdmb),
+	FUNCTION(tdmc),
 };
 
 static struct meson_pmx_func meson_axg_aobus_functions[] = {
-- 
2.14.3
