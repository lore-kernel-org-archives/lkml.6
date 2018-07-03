Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFDAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BC523BFD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pLA+gjSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BC523BFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeGCNV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:21:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50369 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753055AbeGCNVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:21:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so2353218wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aLGd9EOxnS6p6+glTnW7j0ph+NlwCmWuPOqdAnWPevY=;
        b=pLA+gjSHIQTPjFrGdmmNrToxtLMZOY6KDJiv1fldOqShTWJ2UTMdZwXFuipGqEJu4g
         MqfowVV6LsSFVYLC6AaczKxJnroLNYGsI4lZr+k1vBW+uhx3ZNu1xkgakFj5KQnBDbEK
         Z3BQriQayoJWMg5lryBIDW49pDLFVW9xjlXWjhMjV6hmOU316kdg5hhqhWexZVTgusAt
         QaTnZWiM5zfcku4rGLFQLL37lzLyOxn0bAWGuqKdjIDjrefffQ8aqEBb0CwZ4fxzAS7j
         EH8GPhbzjFdBMayc5xR5lNnS1UuTvkYtS/6S4Ga124vo/57Rx3j//ghi+lD/wkH+ImSV
         6caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aLGd9EOxnS6p6+glTnW7j0ph+NlwCmWuPOqdAnWPevY=;
        b=QWEXpwFvRG98oV6inCKEMZhRbb6pKGVQaFE0N4ft8JXHi0QQcwsN98QREHv6JVupuS
         Hk+cAJDILeqQRxRWk8IAU12FuAsbYfqjcxnONtk5LMlMDGqgKvXP6fCoG1sF24IRvhjd
         VUpBocg/mQzYyh+4iCHbtDIWYEU8YeHDSVWKjU7mhUa3F207R/Sb19Y1VGzEIc++E0I6
         Kjuo8x/78UMfZ1JBGZVqdLmQ5Vxy+emeLt1a6Hh7WzERRv7p4DI4SZj5TLY5NpkKGytt
         lzWLk+xR57wZt/Vldy+89HAyQSqnF0gHLBTfOvCgy3RVdpvALXH7u0S6WtN2q4G0fj9G
         CiDg==
X-Gm-Message-State: APt69E3TGdmosNpfElMc5Pq3byL4PEy6/lxBCCVjLcJdX35xuhTn1Usc
        EbcBFI2oMI2o6wdrdvWH4P4vHg==
X-Google-Smtp-Source: AAOMgpecehDej4axYTS50G3dpTp1iC4gEhPxLeL2YZTGib3ZD1orw+RJHR/zWNb6UspTKDA1Vwy/yg==
X-Received: by 2002:a1c:dc89:: with SMTP id t131-v6mr6597903wmg.50.1530624113577;
        Tue, 03 Jul 2018 06:21:53 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l17-v6sm2019844wrh.45.2018.07.03.06.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 06:21:52 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] soc: amlogic: Add Meson GX Clock Measure driver
Date:   Tue,  3 Jul 2018 15:21:48 +0200
Message-Id: <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clock paths frequencies.
The precision is in the order of the MHz.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/Kconfig                |   8 ++
 drivers/soc/amlogic/Makefile               |   1 +
 drivers/soc/amlogic/meson-gx-clk-measure.c | 224 +++++++++++++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c

diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index b04f6e4..4a3217d 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -1,5 +1,13 @@
 menu "Amlogic SoC drivers"
 
+config MESON_GX_CLK_MEASURE
+	bool "Amlogic Meson GX SoC Clock Measure driver"
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
index 8fa3218..a0ad966 100644
--- a/drivers/soc/amlogic/Makefile
+++ b/drivers/soc/amlogic/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MESON_GX_CLK_MEASURE) += meson-gx-clk-measure.o
 obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
 obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
diff --git a/drivers/soc/amlogic/meson-gx-clk-measure.c b/drivers/soc/amlogic/meson-gx-clk-measure.c
new file mode 100644
index 0000000..434d9f3
--- /dev/null
+++ b/drivers/soc/amlogic/meson-gx-clk-measure.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2017 BayLibre, SAS
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
+#define MSR_CLK_DIV		GENMASK(15, 0)
+#define MSR_ENABLE		BIT(16)
+#define MSR_CONT		BIT(17) /* continuous measurement */
+#define MSR_INTR		BIT(18) /* interrupts */
+#define MSR_RUN			BIT(19)
+#define MSR_CLK_SRC		GENMASK(26, 20)
+#define MSR_BUSY		BIT(31)
+
+#define MSR_VAL_MASK		GENMASK(15, 0)
+
+#define DIV_50US		64
+
+#define CLK_MSR_MAX		128
+
+struct meson_gx_msr {
+	struct regmap *regmap;
+};
+
+struct meson_gx_msr_id {
+	struct meson_gx_msr *priv;
+	unsigned int id;
+	const char *name;
+};
+
+#define CLK_MSR_ID(__id, __name) \
+	[__id] = {.id = __id, .name = __name,}
+
+static struct meson_gx_msr_id clk_msr[CLK_MSR_MAX] = {
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
+	CLK_MSR_ID(73, "pwm_C"),
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
+static int meson_gx_measure_id(struct meson_gx_msr *priv, unsigned int id)
+{
+	unsigned int val;
+	int ret;
+
+	regmap_write(priv->regmap, MSR_CLK_REG0, 0);
+
+	/* Set measurement gate to 50uS */
+	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_DIV,
+			   FIELD_PREP(MSR_CLK_DIV, DIV_50US));
+
+	/* Set ID */
+	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
+			   FIELD_PREP(MSR_CLK_SRC, id));
+
+	/* Enable & Start */
+	regmap_update_bits(priv->regmap, MSR_CLK_REG0,
+			   MSR_RUN | MSR_ENABLE,
+			   MSR_RUN | MSR_ENABLE);
+
+	ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
+				       val, !(val & MSR_BUSY), 10, 1000);
+	if (ret)
+		return ret;
+
+	/* Disable */
+	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
+
+	/* Get the value in MHz*64 */
+	regmap_read(priv->regmap, MSR_CLK_REG2, &val);
+
+	return (((val + 31) & MSR_VAL_MASK) / 64) * 1000000;
+}
+
+static int clk_msr_show(struct seq_file *s, void *data)
+{
+	struct meson_gx_msr_id *clk_msr_id = s->private;
+	int val;
+
+	val = meson_gx_measure_id(clk_msr_id->priv, clk_msr_id->id);
+	if (val < 0)
+		return val;
+
+	seq_printf(s, "%d\n", val);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(clk_msr);
+
+static const struct regmap_config clk_msr_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = MSR_CLK_REG2,
+};
+
+static int meson_gx_msr_probe(struct platform_device *pdev)
+{
+	struct meson_gx_msr *priv;
+	struct resource *res;
+	struct dentry *root;
+	void __iomem *base;
+	int i;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct meson_gx_msr),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base)) {
+		dev_err(&pdev->dev, "io resource mapping failed\n");
+		return PTR_ERR(base);
+	}
+
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					      &clk_msr_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	root = debugfs_create_dir("meson-clk-msr", NULL);
+
+	for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
+		if (!clk_msr[i].name)
+			continue;
+
+		clk_msr[i].priv = priv;
+
+		debugfs_create_file(clk_msr[i].name, 0444, root,
+				    &clk_msr[i], &clk_msr_fops);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id meson_gx_msr_match_table[] = {
+	{ .compatible = "amlogic,meson-gx-clk-measure" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver meson_gx_msr_driver = {
+	.probe	= meson_gx_msr_probe,
+	.driver = {
+		.name		= "meson_gx_msr",
+		.of_match_table	= meson_gx_msr_match_table,
+	},
+};
+builtin_platform_driver(meson_gx_msr_driver);
-- 
2.7.4

