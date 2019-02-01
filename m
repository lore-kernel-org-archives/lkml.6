Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE7AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCD12082C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xSHv0CZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfBAOyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:54:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37387 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbfBAOyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:54:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so6492049wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 06:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8Re/2rj8EdqJJaKNDiyxfBZaYggChIyT/eXQCl+s1Q=;
        b=xSHv0CZkRy75Y4uHCt7dpXvhWirOTIt1QDvgqoxlZNJELIukRwwgxwODxw1fptteBS
         TJmL3X+CkUkjthYjwBZBfHMoySWm+VosCNqoRX6ppKBms8zPbVzBAoiPKLxjATgEZtYC
         sC5uLI0Y6kCka1wBqpV7ZBYYOUxvkaQiU9IosD1VUMscJjKXrCJ7iBnHwjvUE7okmJ+S
         zYxyXojFgayU503vMw7qKN8fLD4d0rreU1er2loZWRSiJkphJ+G7K4cwMA/+e2uARZFJ
         JFT0VOC4J1IfzYlC2dOkeMOvimd8yOray3vod0R4UhxxhUn3y3VtKkA6kjj7UHhqPgHO
         W6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8Re/2rj8EdqJJaKNDiyxfBZaYggChIyT/eXQCl+s1Q=;
        b=gEPlW+CLRwQP5kcp5XfdqK1BdB1ix1LCMKVvNxBBi70aAiL3uthbPD0oV0b/KvBjOe
         cS7P0UiDwssRrdn0XDW9WZFpgnAeXMFqqUswzLpazOqmBSNRVKAA6DvW1kOoeChS3cag
         iXNrPcnBwi+zNwIsl91569C6VMFG8vEXH1/ZZhtKUfMLmkksyFYWJQDWi/Msz292LJFn
         i/iHEmuPhGXyRaPdux9E68WCRQIDQVomxomoitXMph7XcgEbUTKFeCcgugz4Md/uorAa
         gUU4YQUIFn1PKuNlJyjZFkXbMKL0xuXCQxO7AEJ365d3v4kZ0AUJFCrI0dhf+3sY2Ive
         C/7A==
X-Gm-Message-State: AHQUAubFJNyTFTGd6tur33WwnQXhSv2pXlQ8XakZIAQv1dTroOUg8TvL
        KDHd/POZO9XK8SqG9qRD+yq71A==
X-Google-Smtp-Source: AHgI3IaSG7QYyAr/vS/aLPNG2m2r02HsHDBEVs4fTaRrXFq+D94LHf92O2X0t5917g0YpHzQYeSUHw==
X-Received: by 2002:a1c:2088:: with SMTP id g130mr2739711wmg.122.1549032842413;
        Fri, 01 Feb 2019 06:54:02 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id x186sm4754644wmg.41.2019.02.01.06.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 06:54:01 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Jian Hu <jian.hu@amlogic.com>
Subject: [PATCH v6 4/4] clk: meson: factorise meson64 peripheral clock controller drivers
Date:   Fri,  1 Feb 2019 15:53:45 +0100
Message-Id: <20190201145345.6795-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201145345.6795-1-jbrunet@baylibre.com>
References: <20190201145345.6795-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function used to probe the peripheral clock controller of the arm64
amlogic SoCs is mostly the same. We now have 3 of those controllers so
it is time to factorize things a bit.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig       |  11 +-
 drivers/clk/meson/Makefile      |   1 +
 drivers/clk/meson/axg.c         |  59 ++-----
 drivers/clk/meson/g12a.c        |  58 ++-----
 drivers/clk/meson/gxbb.c        | 272 +++++++++++++++++++++++---------
 drivers/clk/meson/meson-eeclk.c |  63 ++++++++
 drivers/clk/meson/meson-eeclk.h |  25 +++
 7 files changed, 313 insertions(+), 176 deletions(-)
 create mode 100644 drivers/clk/meson/meson-eeclk.c
 create mode 100644 drivers/clk/meson/meson-eeclk.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 4f61dd71f26d..b72439315340 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -35,6 +35,11 @@ config COMMON_CLK_MESON_AO_CLKC
 	select COMMON_CLK_MESON_INPUT
 	select RESET_CONTROLLER
 
+config COMMON_CLK_MESON_EE_CLKC
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_INPUT
+
 config COMMON_CLK_MESON8B
 	bool
 	depends on ARCH_MESON
@@ -51,13 +56,13 @@ config COMMON_CLK_MESON8B
 config COMMON_CLK_GXBB
 	bool
 	depends on ARCH_MESON
-	select COMMON_CLK_MESON_INPUT
 	select COMMON_CLK_MESON_REGMAP
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_VID_PLL_DIV
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
 	select COMMON_CLK_MESON_AO_CLKC
+	select COMMON_CLK_MESON_EE_CLKC
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
@@ -66,12 +71,12 @@ config COMMON_CLK_GXBB
 config COMMON_CLK_AXG
 	bool
 	depends on ARCH_MESON
-	select COMMON_CLK_MESON_INPUT
 	select COMMON_CLK_MESON_REGMAP
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
 	select COMMON_CLK_MESON_AO_CLKC
+	select COMMON_CLK_MESON_EE_CLKC
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic A113D devices, aka axg.
@@ -92,10 +97,10 @@ config COMMON_CLK_AXG_AUDIO
 config COMMON_CLK_G12A
 	bool
 	depends on ARCH_MESON
-	select COMMON_CLK_MESON_INPUT
 	select COMMON_CLK_MESON_REGMAP
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
+	select COMMON_CLK_MESON_EE_CLKC
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index c3dd3901afe3..32d17f18541e 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
+obj-$(CONFIG_COMMON_CLK_MESON_EE_CLKC) += meson-eeclk.o
 obj-$(CONFIG_COMMON_CLK_MESON_INPUT) += clk-input.o
 obj-$(CONFIG_COMMON_CLK_MESON_MPLL) += clk-mpll.o
 obj-$(CONFIG_COMMON_CLK_MESON_PHASE) += clk-phase.o
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index cbbdd93b175d..7a8ef80e5f2c 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -9,21 +9,17 @@
  * Author: Qiufang Dai <qiufang.dai@amlogic.com>
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
 #include <linux/of_device.h>
-#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 
 #include "clk-input.h"
 #include "clk-regmap.h"
 #include "clk-pll.h"
 #include "clk-mpll.h"
 #include "axg.h"
-
-#define IN_PREFIX "ee-in-"
+#include "meson-eeclk.h"
 
 static DEFINE_SPINLOCK(meson_clk_lock);
 
@@ -1260,55 +1256,20 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_pcie_pll_od,
 };
 
+static const struct meson_eeclkc_data axg_clkc_data = {
+	.regmap_clks = axg_clk_regmaps,
+	.regmap_clk_num = ARRAY_SIZE(axg_clk_regmaps),
+	.hw_onecell_data = &axg_hw_onecell_data,
+};
+
+
 static const struct of_device_id clkc_match_table[] = {
-	{ .compatible = "amlogic,axg-clkc" },
+	{ .compatible = "amlogic,axg-clkc", .data = &axg_clkc_data },
 	{}
 };
 
-static int axg_clkc_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct clk_hw *input;
-	struct regmap *map;
-	int ret, i;
-
-	/* Get the hhi system controller node if available */
-	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
-	if (IS_ERR(map)) {
-		dev_err(dev, "failed to get HHI regmap\n");
-		return PTR_ERR(map);
-	}
-
-	input = meson_clk_hw_register_input(dev, "xtal", IN_PREFIX "xtal", 0);
-	if (IS_ERR(input)) {
-		ret = PTR_ERR(input);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get input clock");
-		return ret;
-	}
-
-	/* Populate regmap for the regmap backed clocks */
-	for (i = 0; i < ARRAY_SIZE(axg_clk_regmaps); i++)
-		axg_clk_regmaps[i]->map = map;
-
-	for (i = 0; i < axg_hw_onecell_data.num; i++) {
-		/* array might be sparse */
-		if (!axg_hw_onecell_data.hws[i])
-			continue;
-
-		ret = devm_clk_hw_register(dev, axg_hw_onecell_data.hws[i]);
-		if (ret) {
-			dev_err(dev, "Clock registration failed\n");
-			return ret;
-		}
-	}
-
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-					   &axg_hw_onecell_data);
-}
-
 static struct platform_driver axg_driver = {
-	.probe		= axg_clkc_probe,
+	.probe		= meson_eeclkc_probe,
 	.driver		= {
 		.name	= "axg-clkc",
 		.of_match_table = clkc_match_table,
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 4d9ec6026ef6..0e1ce8c03259 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -13,19 +13,16 @@
 #include <linux/clk-provider.h>
 #include <linux/init.h>
 #include <linux/of_device.h>
-#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 
 #include "clk-input.h"
 #include "clk-mpll.h"
 #include "clk-pll.h"
 #include "clk-regmap.h"
 #include "vid-pll-div.h"
+#include "meson-eeclk.h"
 #include "g12a.h"
 
-#define IN_PREFIX "ee-in-"
-
 static DEFINE_SPINLOCK(meson_clk_lock);
 
 static struct clk_regmap g12a_fixed_pll_dco = {
@@ -2340,56 +2337,19 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_mpll_50m,
 };
 
+static const struct meson_eeclkc_data g12a_clkc_data = {
+	.regmap_clks = g12a_clk_regmaps,
+	.regmap_clk_num = ARRAY_SIZE(g12a_clk_regmaps),
+	.hw_onecell_data = &g12a_hw_onecell_data
+};
+
 static const struct of_device_id clkc_match_table[] = {
-	{ .compatible = "amlogic,g12a-clkc" },
+	{ .compatible = "amlogic,g12a-clkc", .data = &g12a_clkc_data },
 	{}
 };
 
-static int g12a_clkc_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct clk_hw *input;
-	struct regmap *map;
-	int ret, i;
-
-	/* Get the hhi system controller node */
-	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
-	if (IS_ERR(map)) {
-		dev_err(dev,
-			"failed to get HHI regmap\n");
-		return PTR_ERR(map);
-	}
-
-	input = meson_clk_hw_register_input(dev, "xtal", IN_PREFIX "xtal", 0);
-	if (IS_ERR(input)) {
-		ret = PTR_ERR(input);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get input clock");
-		return ret;
-	}
-
-	/* Populate regmap for the regmap backed clocks */
-	for (i = 0; i < ARRAY_SIZE(g12a_clk_regmaps); i++)
-		g12a_clk_regmaps[i]->map = map;
-
-	for (i = 0; i < g12a_hw_onecell_data.num; i++) {
-		/* array might be sparse */
-		if (!g12a_hw_onecell_data.hws[i])
-			continue;
-
-		ret = devm_clk_hw_register(dev, g12a_hw_onecell_data.hws[i]);
-		if (ret) {
-			dev_err(dev, "Clock registration failed\n");
-			return ret;
-		}
-	}
-
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-					   &g12a_hw_onecell_data);
-}
-
 static struct platform_driver g12a_driver = {
-	.probe		= g12a_clkc_probe,
+	.probe		= meson_eeclkc_probe,
 	.driver		= {
 		.name	= "g12a-clkc",
 		.of_match_table = clkc_match_table,
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 3741db9a9fe1..04df2e208ed6 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -4,19 +4,17 @@
  * Michael Turquette <mturquette@baylibre.com>
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
 #include <linux/of_device.h>
-#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 
 #include "gxbb.h"
 #include "clk-input.h"
 #include "clk-regmap.h"
 #include "clk-pll.h"
 #include "clk-mpll.h"
+#include "meson-eeclk.h"
 #include "vid-pll-div.h"
 
 #define IN_PREFIX "ee-in-"
@@ -2859,6 +2857,192 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 };
 
 static struct clk_regmap *const gxbb_clk_regmaps[] = {
+	&gxbb_clk81,
+	&gxbb_ddr,
+	&gxbb_dos,
+	&gxbb_isa,
+	&gxbb_pl301,
+	&gxbb_periphs,
+	&gxbb_spicc,
+	&gxbb_i2c,
+	&gxbb_sar_adc,
+	&gxbb_smart_card,
+	&gxbb_rng0,
+	&gxbb_uart0,
+	&gxbb_sdhc,
+	&gxbb_stream,
+	&gxbb_async_fifo,
+	&gxbb_sdio,
+	&gxbb_abuf,
+	&gxbb_hiu_iface,
+	&gxbb_assist_misc,
+	&gxbb_spi,
+	&gxbb_i2s_spdif,
+	&gxbb_eth,
+	&gxbb_demux,
+	&gxbb_aiu_glue,
+	&gxbb_iec958,
+	&gxbb_i2s_out,
+	&gxbb_amclk,
+	&gxbb_aififo2,
+	&gxbb_mixer,
+	&gxbb_mixer_iface,
+	&gxbb_adc,
+	&gxbb_blkmv,
+	&gxbb_aiu,
+	&gxbb_uart1,
+	&gxbb_g2d,
+	&gxbb_usb0,
+	&gxbb_usb1,
+	&gxbb_reset,
+	&gxbb_nand,
+	&gxbb_dos_parser,
+	&gxbb_usb,
+	&gxbb_vdin1,
+	&gxbb_ahb_arb0,
+	&gxbb_efuse,
+	&gxbb_boot_rom,
+	&gxbb_ahb_data_bus,
+	&gxbb_ahb_ctrl_bus,
+	&gxbb_hdmi_intr_sync,
+	&gxbb_hdmi_pclk,
+	&gxbb_usb1_ddr_bridge,
+	&gxbb_usb0_ddr_bridge,
+	&gxbb_mmc_pclk,
+	&gxbb_dvin,
+	&gxbb_uart2,
+	&gxbb_sana,
+	&gxbb_vpu_intr,
+	&gxbb_sec_ahb_ahb3_bridge,
+	&gxbb_clk81_a53,
+	&gxbb_vclk2_venci0,
+	&gxbb_vclk2_venci1,
+	&gxbb_vclk2_vencp0,
+	&gxbb_vclk2_vencp1,
+	&gxbb_gclk_venci_int0,
+	&gxbb_gclk_vencp_int,
+	&gxbb_dac_clk,
+	&gxbb_aoclk_gate,
+	&gxbb_iec958_gate,
+	&gxbb_enc480p,
+	&gxbb_rng1,
+	&gxbb_gclk_venci_int1,
+	&gxbb_vclk2_venclmcc,
+	&gxbb_vclk2_vencl,
+	&gxbb_vclk_other,
+	&gxbb_edp,
+	&gxbb_ao_media_cpu,
+	&gxbb_ao_ahb_sram,
+	&gxbb_ao_ahb_bus,
+	&gxbb_ao_iface,
+	&gxbb_ao_i2c,
+	&gxbb_emmc_a,
+	&gxbb_emmc_b,
+	&gxbb_emmc_c,
+	&gxbb_sar_adc_clk,
+	&gxbb_mali_0,
+	&gxbb_mali_1,
+	&gxbb_cts_amclk,
+	&gxbb_cts_mclk_i958,
+	&gxbb_32k_clk,
+	&gxbb_sd_emmc_a_clk0,
+	&gxbb_sd_emmc_b_clk0,
+	&gxbb_sd_emmc_c_clk0,
+	&gxbb_vpu_0,
+	&gxbb_vpu_1,
+	&gxbb_vapb_0,
+	&gxbb_vapb_1,
+	&gxbb_vapb,
+	&gxbb_mpeg_clk_div,
+	&gxbb_sar_adc_clk_div,
+	&gxbb_mali_0_div,
+	&gxbb_mali_1_div,
+	&gxbb_cts_mclk_i958_div,
+	&gxbb_32k_clk_div,
+	&gxbb_sd_emmc_a_clk0_div,
+	&gxbb_sd_emmc_b_clk0_div,
+	&gxbb_sd_emmc_c_clk0_div,
+	&gxbb_vpu_0_div,
+	&gxbb_vpu_1_div,
+	&gxbb_vapb_0_div,
+	&gxbb_vapb_1_div,
+	&gxbb_mpeg_clk_sel,
+	&gxbb_sar_adc_clk_sel,
+	&gxbb_mali_0_sel,
+	&gxbb_mali_1_sel,
+	&gxbb_mali,
+	&gxbb_cts_amclk_sel,
+	&gxbb_cts_mclk_i958_sel,
+	&gxbb_cts_i958,
+	&gxbb_32k_clk_sel,
+	&gxbb_sd_emmc_a_clk0_sel,
+	&gxbb_sd_emmc_b_clk0_sel,
+	&gxbb_sd_emmc_c_clk0_sel,
+	&gxbb_vpu_0_sel,
+	&gxbb_vpu_1_sel,
+	&gxbb_vpu,
+	&gxbb_vapb_0_sel,
+	&gxbb_vapb_1_sel,
+	&gxbb_vapb_sel,
+	&gxbb_mpll0,
+	&gxbb_mpll1,
+	&gxbb_mpll2,
+	&gxbb_mpll0_div,
+	&gxbb_mpll1_div,
+	&gxbb_mpll2_div,
+	&gxbb_cts_amclk_div,
+	&gxbb_fixed_pll,
+	&gxbb_sys_pll,
+	&gxbb_mpll_prediv,
+	&gxbb_fclk_div2,
+	&gxbb_fclk_div3,
+	&gxbb_fclk_div4,
+	&gxbb_fclk_div5,
+	&gxbb_fclk_div7,
+	&gxbb_vdec_1_sel,
+	&gxbb_vdec_1_div,
+	&gxbb_vdec_1,
+	&gxbb_vdec_hevc_sel,
+	&gxbb_vdec_hevc_div,
+	&gxbb_vdec_hevc,
+	&gxbb_gen_clk_sel,
+	&gxbb_gen_clk_div,
+	&gxbb_gen_clk,
+	&gxbb_fixed_pll_dco,
+	&gxbb_sys_pll_dco,
+	&gxbb_gp0_pll,
+	&gxbb_vid_pll,
+	&gxbb_vid_pll_sel,
+	&gxbb_vid_pll_div,
+	&gxbb_vclk,
+	&gxbb_vclk_sel,
+	&gxbb_vclk_div,
+	&gxbb_vclk_input,
+	&gxbb_vclk_div1,
+	&gxbb_vclk_div2_en,
+	&gxbb_vclk_div4_en,
+	&gxbb_vclk_div6_en,
+	&gxbb_vclk_div12_en,
+	&gxbb_vclk2,
+	&gxbb_vclk2_sel,
+	&gxbb_vclk2_div,
+	&gxbb_vclk2_input,
+	&gxbb_vclk2_div1,
+	&gxbb_vclk2_div2_en,
+	&gxbb_vclk2_div4_en,
+	&gxbb_vclk2_div6_en,
+	&gxbb_vclk2_div12_en,
+	&gxbb_cts_enci,
+	&gxbb_cts_enci_sel,
+	&gxbb_cts_encp,
+	&gxbb_cts_encp_sel,
+	&gxbb_cts_vdac,
+	&gxbb_cts_vdac_sel,
+	&gxbb_hdmi_tx,
+	&gxbb_hdmi_tx_sel,
+	&gxbb_hdmi_sel,
+	&gxbb_hdmi_div,
+	&gxbb_hdmi,
 	&gxbb_gp0_pll_dco,
 	&gxbb_hdmi_pll,
 	&gxbb_hdmi_pll_od,
@@ -2867,14 +3051,6 @@ static struct clk_regmap *const gxbb_clk_regmaps[] = {
 };
 
 static struct clk_regmap *const gxl_clk_regmaps[] = {
-	&gxl_gp0_pll_dco,
-	&gxl_hdmi_pll,
-	&gxl_hdmi_pll_od,
-	&gxl_hdmi_pll_od2,
-	&gxl_hdmi_pll_dco,
-};
-
-static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_clk81,
 	&gxbb_ddr,
 	&gxbb_dos,
@@ -3061,23 +3237,22 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_hdmi_sel,
 	&gxbb_hdmi_div,
 	&gxbb_hdmi,
+	&gxl_gp0_pll_dco,
+	&gxl_hdmi_pll,
+	&gxl_hdmi_pll_od,
+	&gxl_hdmi_pll_od2,
+	&gxl_hdmi_pll_dco,
 };
 
-struct clkc_data {
-	struct clk_regmap *const *regmap_clks;
-	unsigned int regmap_clks_count;
-	struct clk_hw_onecell_data *hw_onecell_data;
-};
-
-static const struct clkc_data gxbb_clkc_data = {
+static const struct meson_eeclkc_data gxbb_clkc_data = {
 	.regmap_clks = gxbb_clk_regmaps,
-	.regmap_clks_count = ARRAY_SIZE(gxbb_clk_regmaps),
+	.regmap_clk_num = ARRAY_SIZE(gxbb_clk_regmaps),
 	.hw_onecell_data = &gxbb_hw_onecell_data,
 };
 
-static const struct clkc_data gxl_clkc_data = {
+static const struct meson_eeclkc_data gxl_clkc_data = {
 	.regmap_clks = gxl_clk_regmaps,
-	.regmap_clks_count = ARRAY_SIZE(gxl_clk_regmaps),
+	.regmap_clk_num = ARRAY_SIZE(gxl_clk_regmaps),
 	.hw_onecell_data = &gxl_hw_onecell_data,
 };
 
@@ -3087,61 +3262,8 @@ static const struct of_device_id clkc_match_table[] = {
 	{},
 };
 
-static int gxbb_clkc_probe(struct platform_device *pdev)
-{
-	const struct clkc_data *clkc_data;
-	struct clk_hw *input;
-	struct regmap *map;
-	int ret, i;
-	struct device *dev = &pdev->dev;
-
-	clkc_data = of_device_get_match_data(dev);
-	if (!clkc_data)
-		return -EINVAL;
-
-	/* Get the hhi system controller node if available */
-	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
-	if (IS_ERR(map)) {
-		dev_err(dev, "failed to get HHI regmap\n");
-		return PTR_ERR(map);
-	}
-
-	input = meson_clk_hw_register_input(dev, "xtal", IN_PREFIX "xtal", 0);
-	if (IS_ERR(input)) {
-		ret = PTR_ERR(input);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get input clock");
-		return ret;
-	}
-
-	/* Populate regmap for the common regmap backed clocks */
-	for (i = 0; i < ARRAY_SIZE(gx_clk_regmaps); i++)
-		gx_clk_regmaps[i]->map = map;
-
-	/* Populate regmap for soc specific clocks */
-	for (i = 0; i < clkc_data->regmap_clks_count; i++)
-		clkc_data->regmap_clks[i]->map = map;
-
-	/* Register all clks */
-	for (i = 0; i < clkc_data->hw_onecell_data->num; i++) {
-		/* array might be sparse */
-		if (!clkc_data->hw_onecell_data->hws[i])
-			continue;
-
-		ret = devm_clk_hw_register(dev,
-					   clkc_data->hw_onecell_data->hws[i]);
-		if (ret) {
-			dev_err(dev, "Clock registration failed\n");
-			return ret;
-		}
-	}
-
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-					   clkc_data->hw_onecell_data);
-}
-
 static struct platform_driver gxbb_driver = {
-	.probe		= gxbb_clkc_probe,
+	.probe		= meson_eeclkc_probe,
 	.driver		= {
 		.name	= "gxbb-clkc",
 		.of_match_table = clkc_match_table,
diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
new file mode 100644
index 000000000000..37a34c9c3885
--- /dev/null
+++ b/drivers/clk/meson/meson-eeclk.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#include "clk-input.h"
+#include "clk-regmap.h"
+#include "meson-eeclk.h"
+
+int meson_eeclkc_probe(struct platform_device *pdev)
+{
+	const struct meson_eeclkc_data *data;
+	struct device *dev = &pdev->dev;
+	struct clk_hw *input;
+	struct regmap *map;
+	int ret, i;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	/* Get the hhi system controller node */
+	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
+	if (IS_ERR(map)) {
+		dev_err(dev,
+			"failed to get HHI regmap\n");
+		return PTR_ERR(map);
+	}
+
+	input = meson_clk_hw_register_input(dev, "xtal", IN_PREFIX "xtal", 0);
+	if (IS_ERR(input)) {
+		ret = PTR_ERR(input);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get input clock");
+		return ret;
+	}
+
+	/* Populate regmap for the regmap backed clocks */
+	for (i = 0; i < data->regmap_clk_num; i++)
+		data->regmap_clks[i]->map = map;
+
+	for (i = 0; i < data->hw_onecell_data->num; i++) {
+		/* array might be sparse */
+		if (!data->hw_onecell_data->hws[i])
+			continue;
+
+		ret = devm_clk_hw_register(dev, data->hw_onecell_data->hws[i]);
+		if (ret) {
+			dev_err(dev, "Clock registration failed\n");
+			return ret;
+		}
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   data->hw_onecell_data);
+}
diff --git a/drivers/clk/meson/meson-eeclk.h b/drivers/clk/meson/meson-eeclk.h
new file mode 100644
index 000000000000..1b809b1419fe
--- /dev/null
+++ b/drivers/clk/meson/meson-eeclk.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_CLKC_H
+#define __MESON_CLKC_H
+
+#include <linux/clk-provider.h>
+#include "clk-regmap.h"
+
+#define IN_PREFIX "ee-in-"
+
+struct platform_device;
+
+struct meson_eeclkc_data {
+	struct clk_regmap *const	*regmap_clks;
+	unsigned int			regmap_clk_num;
+	struct clk_hw_onecell_data	*hw_onecell_data;
+};
+
+int meson_eeclkc_probe(struct platform_device *pdev);
+
+#endif /* __MESON_CLKC_H */
-- 
2.20.1

