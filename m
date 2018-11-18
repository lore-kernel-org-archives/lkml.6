Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D84FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF59F2080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pWEOJ4K6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF59F2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeKSAK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:10:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34996 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKSAK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:10:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id t15-v6so2776745wmt.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 05:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cSanyqGLxfR52pTIFsFhcpyd7ANY/cvY9eKdTay6P+Y=;
        b=pWEOJ4K6zTiWylIps3rxdrwM/s472KaeRzcFou58JO75fP8Q6is8XfMCOMkN5JGrEX
         oxUBTiJZsWg0fChqqpNn0JvhnyKnQJjV8kqboYVGtdjyZU1IBRqmfjHcxOHCSIEHDhzq
         aDg5o6cTLlO+hk3xMU5hgOnwzbpfvTkE+jU+BKlVYQcTf6StNKwSQx6uDxpDcthsD2QZ
         hL8n7PF8omGl5JW9tlAjk6B+I1+B7UzPvR/zyc3TSpUIQQuSc+lxMb8/CabMUIcld0ez
         NUIhHxcHcHkn8e7UoKqkw8PI7dTzOwPQNwKuKZFgeowOFR+dRc7iVwgrsphictetDWpI
         AWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cSanyqGLxfR52pTIFsFhcpyd7ANY/cvY9eKdTay6P+Y=;
        b=LwwLVTc8FePLXzJxLGKbzUhLDKIAQr+ymzRQebYWXgI1Giik91za9zpruly1DX95HV
         e1rWwFkxVDSmnPIrXtRp1ebZuPiakd24wcBo8kuXCZpu3ft54h5pOCp4+690v0Nxp/RA
         ZKklLmuvvWkZCMqAoYRaDtoxuubndSGTjti2ZStDKoMnKU8VUULd5ubSC4aEKwM2ekM6
         vkikB91FHqOAs0NWaqebPSmwzGOKMovVx4zD05g7c6QdaQX5PmgPi4z4CVr6+1H3RoWL
         qvUKxyXgyrLKglPyx0mLlUBAGnosepcfWcP55Lh8KFusodFFE1QZnJueXQBdTHWnI6qj
         8wDg==
X-Gm-Message-State: AGRZ1gJjrpIRkEI0hS7snuCAn69S3TdRlAzkmP0Rg77hgBC5An+HkYYx
        Zg/qak7RB9fW2JaFXlIhTVSAU+l9yNPpIA==
X-Google-Smtp-Source: AJdET5cpkXGRIdJKQYjcxmkil00aEm/2wkv8JPCCBmo4V3h1RZjp/hP4MuGVuFecWDBE62Xhehz3mA==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr4365635wmh.92.1542549031389;
        Sun, 18 Nov 2018 05:50:31 -0800 (PST)
Received: from bender.home (lfbn-nic-1-84-209.w2-15.abo.wanadoo.fr. [2.15.173.209])
        by smtp.gmail.com with ESMTPSA id y9sm4491721wrq.55.2018.11.18.05.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 05:50:30 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/3] soc: amlogic: Add Meson Clock Measure driver
Date:   Sun, 18 Nov 2018 14:50:23 +0100
Message-Id: <20181118135024.30720-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118135024.30720-1-narmstrong@baylibre.com>
References: <20181118135024.30720-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson SoCs embeds a clock measurer IP to measure the internal
clock paths frequencies.
The precision is determined by stepping into the duration until the counter
overflows.
The debugfs slows a pretty summary and each clock can be measured
individually aswell.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/Kconfig             |   8 +
 drivers/soc/amlogic/Makefile            |   1 +
 drivers/soc/amlogic/meson-clk-measure.c | 350 ++++++++++++++++++++++++
 3 files changed, 359 insertions(+)
 create mode 100644 drivers/soc/amlogic/meson-clk-measure.c

diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index 2f282b472912..36633bb6c8bb 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -7,6 +7,14 @@ config MESON_CANVAS
 	help
 	  Say yes to support the canvas IP for Amlogic SoCs.
 
+config MESON_CLK_MEASURE
+	bool "Amlogic Meson SoC Clock Measure driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	default ARCH_MESON
+	help
+	  Say yes to support of Measuring a set of internal SoC clocks
+	  from the debugfs interface.
+
 config MESON_GX_SOCINFO
 	bool "Amlogic Meson GX SoC Information driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
index 0ab16d35ac36..bf2d109f61e9 100644
--- a/drivers/soc/amlogic/Makefile
+++ b/drivers/soc/amlogic/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
+obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
 obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
 obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
new file mode 100644
index 000000000000..daea191a66fa
--- /dev/null
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2018 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/bitfield.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <linux/regmap.h>
+
+#define MSR_CLK_DUTY		0x0
+#define MSR_CLK_REG0		0x4
+#define MSR_CLK_REG1		0x8
+#define MSR_CLK_REG2		0xc
+
+#define MSR_DURATION		GENMASK(15, 0)
+#define MSR_ENABLE		BIT(16)
+#define MSR_CONT		BIT(17) /* continuous measurement */
+#define MSR_INTR		BIT(18) /* interrupts */
+#define MSR_RUN			BIT(19)
+#define MSR_CLK_SRC		GENMASK(26, 20)
+#define MSR_BUSY		BIT(31)
+
+#define MSR_VAL_MASK		GENMASK(15, 0)
+
+#define DIV_MIN			32
+#define DIV_STEP		32
+#define DIV_MAX			640
+
+#define CLK_MSR_MAX		128
+
+struct meson_msr_id {
+	struct meson_msr *priv;
+	unsigned int id;
+	const char *name;
+};
+
+struct meson_msr {
+	struct regmap *regmap;
+	struct meson_msr_id msr_table[CLK_MSR_MAX];
+};
+
+#define CLK_MSR_ID(__id, __name) \
+	[__id] = {.id = __id, .name = __name,}
+
+static struct meson_msr_id clk_msr_m8[CLK_MSR_MAX] = {
+	CLK_MSR_ID(0, "ring_osc_out_ee0"),
+	CLK_MSR_ID(1, "ring_osc_out_ee1"),
+	CLK_MSR_ID(2, "ring_osc_out_ee2"),
+	CLK_MSR_ID(3, "a9_ring_osck"),
+	CLK_MSR_ID(6, "vid_pll"),
+	CLK_MSR_ID(7, "clk81"),
+	CLK_MSR_ID(8, "encp"),
+	CLK_MSR_ID(9, "encl"),
+	CLK_MSR_ID(11, "eth_rmii"),
+	CLK_MSR_ID(13, "amclk"),
+	CLK_MSR_ID(14, "fec_clk_0"),
+	CLK_MSR_ID(15, "fec_clk_1"),
+	CLK_MSR_ID(16, "fec_clk_2"),
+	CLK_MSR_ID(18, "a9_clk_div16"),
+	CLK_MSR_ID(19, "hdmi_sys"),
+	CLK_MSR_ID(20, "rtc_osc_clk_out"),
+	CLK_MSR_ID(21, "i2s_clk_in_src0"),
+	CLK_MSR_ID(22, "clk_rmii_from_pad"),
+	CLK_MSR_ID(23, "hdmi_ch0_tmds"),
+	CLK_MSR_ID(24, "lvds_fifo"),
+	CLK_MSR_ID(26, "sc_clk_int"),
+	CLK_MSR_ID(28, "sar_adc"),
+	CLK_MSR_ID(30, "mpll_clk_test_out"),
+	CLK_MSR_ID(31, "audac_clkpi"),
+	CLK_MSR_ID(32, "vdac"),
+	CLK_MSR_ID(33, "sdhc_rx"),
+	CLK_MSR_ID(34, "sdhc_sd"),
+	CLK_MSR_ID(35, "mali"),
+	CLK_MSR_ID(36, "hdmi_tx_pixel"),
+	CLK_MSR_ID(38, "vdin_meas"),
+	CLK_MSR_ID(39, "pcm_sclk"),
+	CLK_MSR_ID(40, "pcm_mclk"),
+	CLK_MSR_ID(41, "eth_rx_tx"),
+	CLK_MSR_ID(42, "pwm_d"),
+	CLK_MSR_ID(43, "pwm_c"),
+	CLK_MSR_ID(44, "pwm_b"),
+	CLK_MSR_ID(45, "pwm_a"),
+	CLK_MSR_ID(46, "pcm2_sclk"),
+	CLK_MSR_ID(47, "ddr_dpll_pt"),
+	CLK_MSR_ID(48, "pwm_f"),
+	CLK_MSR_ID(49, "pwm_e"),
+	CLK_MSR_ID(59, "hcodec"),
+	CLK_MSR_ID(60, "usb_32k_alt"),
+	CLK_MSR_ID(61, "gpio"),
+	CLK_MSR_ID(62, "vid2_pll"),
+	CLK_MSR_ID(63, "mipi_csi_cfg"),
+};
+
+static struct meson_msr_id clk_msr_gx[CLK_MSR_MAX] = {
+	CLK_MSR_ID(0, "ring_osc_out_ee_0"),
+	CLK_MSR_ID(1, "ring_osc_out_ee_1"),
+	CLK_MSR_ID(2, "ring_osc_out_ee_2"),
+	CLK_MSR_ID(3, "a53_ring_osc"),
+	CLK_MSR_ID(4, "gp0_pll"),
+	CLK_MSR_ID(6, "enci"),
+	CLK_MSR_ID(7, "clk81"),
+	CLK_MSR_ID(8, "encp"),
+	CLK_MSR_ID(9, "encl"),
+	CLK_MSR_ID(10, "vdac"),
+	CLK_MSR_ID(11, "rgmii_tx"),
+	CLK_MSR_ID(12, "pdm"),
+	CLK_MSR_ID(13, "amclk"),
+	CLK_MSR_ID(14, "fec_0"),
+	CLK_MSR_ID(15, "fec_1"),
+	CLK_MSR_ID(16, "fec_2"),
+	CLK_MSR_ID(17, "sys_pll_div16"),
+	CLK_MSR_ID(18, "sys_cpu_div16"),
+	CLK_MSR_ID(19, "hdmitx_sys"),
+	CLK_MSR_ID(20, "rtc_osc_out"),
+	CLK_MSR_ID(21, "i2s_in_src0"),
+	CLK_MSR_ID(22, "eth_phy_ref"),
+	CLK_MSR_ID(23, "hdmi_todig"),
+	CLK_MSR_ID(26, "sc_int"),
+	CLK_MSR_ID(28, "sar_adc"),
+	CLK_MSR_ID(31, "mpll_test_out"),
+	CLK_MSR_ID(32, "vdec"),
+	CLK_MSR_ID(35, "mali"),
+	CLK_MSR_ID(36, "hdmi_tx_pixel"),
+	CLK_MSR_ID(37, "i958"),
+	CLK_MSR_ID(38, "vdin_meas"),
+	CLK_MSR_ID(39, "pcm_sclk"),
+	CLK_MSR_ID(40, "pcm_mclk"),
+	CLK_MSR_ID(41, "eth_rx_or_rmii"),
+	CLK_MSR_ID(42, "mp0_out"),
+	CLK_MSR_ID(43, "fclk_div5"),
+	CLK_MSR_ID(44, "pwm_b"),
+	CLK_MSR_ID(45, "pwm_a"),
+	CLK_MSR_ID(46, "vpu"),
+	CLK_MSR_ID(47, "ddr_dpll_pt"),
+	CLK_MSR_ID(48, "mp1_out"),
+	CLK_MSR_ID(49, "mp2_out"),
+	CLK_MSR_ID(50, "mp3_out"),
+	CLK_MSR_ID(51, "nand_core"),
+	CLK_MSR_ID(52, "sd_emmc_b"),
+	CLK_MSR_ID(53, "sd_emmc_a"),
+	CLK_MSR_ID(55, "vid_pll_div_out"),
+	CLK_MSR_ID(56, "cci"),
+	CLK_MSR_ID(57, "wave420l_c"),
+	CLK_MSR_ID(58, "wave420l_b"),
+	CLK_MSR_ID(59, "hcodec"),
+	CLK_MSR_ID(60, "alt_32k"),
+	CLK_MSR_ID(61, "gpio_msr"),
+	CLK_MSR_ID(62, "hevc"),
+	CLK_MSR_ID(66, "vid_lock"),
+	CLK_MSR_ID(70, "pwm_f"),
+	CLK_MSR_ID(71, "pwm_e"),
+	CLK_MSR_ID(72, "pwm_d"),
+	CLK_MSR_ID(73, "pwm_c"),
+	CLK_MSR_ID(75, "aoclkx2_int"),
+	CLK_MSR_ID(76, "aoclk_int"),
+	CLK_MSR_ID(77, "rng_ring_osc_0"),
+	CLK_MSR_ID(78, "rng_ring_osc_1"),
+	CLK_MSR_ID(79, "rng_ring_osc_2"),
+	CLK_MSR_ID(80, "rng_ring_osc_3"),
+	CLK_MSR_ID(81, "vapb"),
+	CLK_MSR_ID(82, "ge2d"),
+};
+
+static int meson_measure_id(struct meson_msr_id *clk_msr_id,
+			       unsigned int duration)
+{
+	struct meson_msr *priv = clk_msr_id->priv;
+	unsigned int val;
+	int ret;
+
+	regmap_write(priv->regmap, MSR_CLK_REG0, 0);
+
+	/* Set measurement duration */
+	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_DURATION,
+			   FIELD_PREP(MSR_DURATION, duration - 1));
+
+	/* Set ID */
+	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
+			   FIELD_PREP(MSR_CLK_SRC, clk_msr_id->id));
+
+	/* Enable & Start */
+	regmap_update_bits(priv->regmap, MSR_CLK_REG0,
+			   MSR_RUN | MSR_ENABLE,
+			   MSR_RUN | MSR_ENABLE);
+
+	ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
+				       val, !(val & MSR_BUSY), 10, 10000);
+	if (ret)
+		return ret;
+
+	/* Disable */
+	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
+
+	/* Get the value in multiple of gate time counts */
+	regmap_read(priv->regmap, MSR_CLK_REG2, &val);
+
+	if (val >= MSR_VAL_MASK)
+		return -EINVAL;
+
+	return DIV_ROUND_CLOSEST_ULL((val & MSR_VAL_MASK) * 1000000ULL,
+				     duration);
+}
+
+static int meson_measure_best_id(struct meson_msr_id *clk_msr_id,
+				    unsigned int *precision)
+{
+	unsigned int duration = DIV_MAX;
+	int ret;
+
+	/* Start from max duration and down to min duration */
+	do {
+		ret = meson_measure_id(clk_msr_id, duration);
+		if (ret >= 0)
+			*precision = (2 * 1000000) / duration;
+		else
+			duration -= DIV_STEP;
+	} while (duration >= DIV_MIN && ret == -EINVAL);
+
+	return ret;
+}
+
+static int clk_msr_show(struct seq_file *s, void *data)
+{
+	struct meson_msr_id *clk_msr_id = s->private;
+	unsigned int precision = 0;
+	int val;
+
+	val = meson_measure_best_id(clk_msr_id, &precision);
+	if (val < 0)
+		return val;
+
+	seq_printf(s, "%d\t+/-%dHz\n", val, precision);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(clk_msr);
+
+static int clk_msr_summary_show(struct seq_file *s, void *data)
+{
+	struct meson_msr_id *msr_table = s->private;
+	unsigned int precision = 0;
+	int val, i;
+
+	seq_puts(s, "  clock                     rate    precision\n");
+	seq_puts(s, "---------------------------------------------\n");
+
+	for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
+		if (!msr_table[i].name)
+			continue;
+
+		val = meson_measure_best_id(&msr_table[i], &precision);
+		if (val < 0)
+			return val;
+
+		seq_printf(s, " %-20s %10d    +/-%dHz\n",
+			   msr_table[i].name, val, precision);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(clk_msr_summary);
+
+static const struct regmap_config meson_clk_msr_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = MSR_CLK_REG2,
+};
+
+static int meson_msr_probe(struct platform_device *pdev)
+{
+	const struct meson_msr_id *match_data;
+	struct meson_msr *priv;
+	struct resource *res;
+	struct dentry *root, *clks;
+	void __iomem *base;
+	int i;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct meson_msr),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	match_data = device_get_match_data(&pdev->dev);
+	if (!match_data) {
+		dev_err(&pdev->dev, "failed to get match data\n");
+		return -ENODEV;
+	}
+
+	memcpy(priv->msr_table, match_data, sizeof(priv->msr_table));
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base)) {
+		dev_err(&pdev->dev, "io resource mapping failed\n");
+		return PTR_ERR(base);
+	}
+
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					     &meson_clk_msr_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	root = debugfs_create_dir("meson-clk-msr", NULL);
+	clks = debugfs_create_dir("clks", root);
+
+	debugfs_create_file("measure_summary", 0444, root,
+			    priv->msr_table, &clk_msr_summary_fops);
+
+	for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
+		if (!priv->msr_table[i].name)
+			continue;
+
+		priv->msr_table[i].priv = priv;
+
+		debugfs_create_file(priv->msr_table[i].name, 0444, clks,
+				    &priv->msr_table[i], &clk_msr_fops);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id meson_msr_match_table[] = {
+	{
+		.compatible = "amlogic,meson-gx-clk-measure",
+		.data = (void *)clk_msr_gx,
+	},
+	{
+		.compatible = "amlogic,meson8-clk-measure",
+		.data = (void *)clk_msr_m8,
+	},
+	{
+		.compatible = "amlogic,meson8b-clk-measure",
+		.data = (void *)clk_msr_m8,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver meson_msr_driver = {
+	.probe	= meson_msr_probe,
+	.driver = {
+		.name		= "meson_msr",
+		.of_match_table	= meson_msr_match_table,
+	},
+};
+builtin_platform_driver(meson_msr_driver);
-- 
2.19.1

