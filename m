Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315CBC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94C520841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94C520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeJHUhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:37:37 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46222 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726243AbeJHUhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:37:37 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98DOOQ4006869;
        Mon, 8 Oct 2018 08:25:46 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2mxwhea5hg-1;
        Mon, 08 Oct 2018 08:25:45 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 69855611E125;
        Mon,  8 Oct 2018 08:25:45 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Oct 2018
 14:25:43 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w98DPg7t012033; Mon,
 8 Oct 2018 14:25:43 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH v2 3/5] clk: lochnagar: Add support for the Cirrus Logic Lochnagar
Date:   Mon, 8 Oct 2018 14:25:40 +0100
Message-ID: <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810080131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Lochnagar is an evaluation and development board for Cirrus
Logic Smart CODEC and Amp devices. It allows the connection of
most Cirrus Logic devices on mini-cards, as well as allowing
connection of various application processor systems to provide a
full evaluation platform. This driver supports the board
controller chip on the Lochnagar board.

The Lochnagar can take several input clocks from the host system,
provides several of its own clock sources, and provides extensive
routing options for those clocks to be supplied to the attached
CODEC/Amp device.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v1:
 - Remove binding include file
 - Update commit message a little

Thanks,
Charles

 drivers/clk/Kconfig         |   7 +
 drivers/clk/Makefile        |   1 +
 drivers/clk/clk-lochnagar.c | 449 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 457 insertions(+)
 create mode 100644 drivers/clk/clk-lochnagar.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 292056bbb30e9..9247c97f85d79 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -219,6 +219,13 @@ config COMMON_CLK_XGENE
 	---help---
 	  Sypport for the APM X-Gene SoC reference, PLL, and device clocks.
 
+config COMMON_CLK_LOCHNAGAR
+	tristate "Cirrus Logic Lochnagar clock driver"
+	depends on MFD_LOCHNAGAR
+	help
+	  This driver supports the clocking features of the Cirrus Logic
+	  Lochnagar audio development board.
+
 config COMMON_CLK_NXP
 	def_bool COMMON_CLK && (ARCH_LPC18XX || ARCH_LPC32XX)
 	select REGMAP_MMIO if ARCH_LPC32XX
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index a84c5573cabea..0443a7219bdf4 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_COMMON_CLK_GEMINI)		+= clk-gemini.o
 obj-$(CONFIG_COMMON_CLK_ASPEED)		+= clk-aspeed.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
 obj-$(CONFIG_CLK_HSDK)			+= clk-hsdk-pll.o
+obj-$(CONFIG_COMMON_CLK_LOCHNAGAR)	+= clk-lochnagar.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 obj-$(CONFIG_COMMON_CLK_MAX9485)	+= clk-max9485.o
 obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
diff --git a/drivers/clk/clk-lochnagar.c b/drivers/clk/clk-lochnagar.c
new file mode 100644
index 0000000000000..fa54531dbf501
--- /dev/null
+++ b/drivers/clk/clk-lochnagar.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lochnagar clock control
+ *
+ * Copyright (c) 2017-2018 Cirrus Logic, Inc. and
+ *                         Cirrus Logic International Semiconductor Ltd.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/lochnagar.h>
+#include <dt-bindings/clk/lochnagar.h>
+
+#define LOCHNAGAR_NUM_CLOCKS	(LOCHNAGAR_SPDIF_CLKOUT + 1)
+
+enum lochnagar_clk_type {
+	LOCHNAGAR_CLK_TYPE_UNUSED,
+	LOCHNAGAR_CLK_TYPE_FIXED,
+	LOCHNAGAR_CLK_TYPE_REGMAP,
+};
+
+struct lochnagar_regmap_clk {
+	unsigned int cfg_reg;
+	unsigned int ena_mask;
+	unsigned int dir_mask;
+
+	unsigned int src_reg;
+	unsigned int src_mask;
+};
+
+struct lochnagar_fixed_clk {
+	unsigned int rate;
+};
+
+struct lochnagar_clk {
+	struct lochnagar_clk_priv *priv;
+	struct clk_hw hw;
+
+	const char * const name;
+
+	enum lochnagar_clk_type type;
+	union {
+		struct lochnagar_fixed_clk fixed;
+		struct lochnagar_regmap_clk regmap;
+	};
+};
+
+struct lochnagar_clk_priv {
+	struct device *dev;
+	struct lochnagar *lochnagar;
+
+	const char **parents;
+	unsigned int nparents;
+
+	struct lochnagar_clk lclks[LOCHNAGAR_NUM_CLOCKS];
+
+	struct clk *clks[LOCHNAGAR_NUM_CLOCKS];
+	struct clk_onecell_data of_clks;
+};
+
+static const char * const lochnagar1_clk_parents[] = {
+	"ln-none",
+	"ln-spdif-mclk",
+	"ln-psia1-mclk",
+	"ln-psia2-mclk",
+	"ln-cdc-clkout",
+	"ln-dsp-clkout",
+	"ln-pmic-32k",
+	"ln-gf-mclk1",
+	"ln-gf-mclk3",
+	"ln-gf-mclk2",
+	"ln-gf-mclk4",
+};
+
+static const char * const lochnagar2_clk_parents[] = {
+	"ln-none",
+	"ln-cdc-clkout",
+	"ln-dsp-clkout",
+	"ln-pmic-32k",
+	"ln-spdif-mclk",
+	"ln-clk-12m",
+	"ln-clk-11m",
+	"ln-clk-24m",
+	"ln-clk-22m",
+	"ln-reserved",
+	"ln-usb-clk-24m",
+	"ln-gf-mclk1",
+	"ln-gf-mclk3",
+	"ln-gf-mclk2",
+	"ln-psia1-mclk",
+	"ln-psia2-mclk",
+	"ln-spdif-clkout",
+	"ln-adat-clkout",
+	"ln-usb-clk-12m",
+};
+
+#define LN_CLK_FIXED(ID, NAME, RATE) \
+	[LOCHNAGAR_##ID] = { \
+		.name = NAME, .type = LOCHNAGAR_CLK_TYPE_FIXED, \
+		{ .fixed.rate = RATE, }, \
+	}
+
+#define LN1_CLK_REGMAP(ID, NAME, REG, ...) \
+	[LOCHNAGAR_##ID] = { \
+		.name = NAME, .type = LOCHNAGAR_CLK_TYPE_REGMAP, \
+		{ .regmap = { \
+			__VA_ARGS__ \
+			.cfg_reg = LOCHNAGAR1_##REG, \
+			.ena_mask = LOCHNAGAR1_##ID##_ENA_MASK, \
+			.src_reg = LOCHNAGAR1_##ID##_SEL, \
+			.src_mask = LOCHNAGAR1_SRC_MASK, \
+		}, }, \
+	}
+
+#define LN2_CLK_REGMAP(ID, NAME) \
+	[LOCHNAGAR_##ID] = { \
+		.name = NAME, .type = LOCHNAGAR_CLK_TYPE_REGMAP, \
+		{ .regmap = { \
+			.cfg_reg = LOCHNAGAR2_##ID##_CTRL, \
+			.src_reg = LOCHNAGAR2_##ID##_CTRL, \
+			.ena_mask = LOCHNAGAR2_CLK_ENA_MASK, \
+			.dir_mask = LOCHNAGAR2_CLK_DIR_MASK, \
+			.src_mask = LOCHNAGAR2_CLK_SRC_MASK, \
+		}, }, \
+	}
+
+static const struct lochnagar_clk lochnagar1_clks[LOCHNAGAR_NUM_CLOCKS] = {
+	LN1_CLK_REGMAP(CDC_MCLK1,      "ln-cdc-mclk1",  CDC_AIF_CTRL2),
+	LN1_CLK_REGMAP(CDC_MCLK2,      "ln-cdc-mclk2",  CDC_AIF_CTRL2),
+	LN1_CLK_REGMAP(DSP_CLKIN,      "ln-dsp-clkin",  DSP_AIF),
+	LN1_CLK_REGMAP(GF_CLKOUT1,     "ln-gf-clkout1", GF_AIF1),
+
+	LN_CLK_FIXED(PMIC_32K,         "ln-pmic-32k",   32768),
+};
+
+static const struct lochnagar_clk lochnagar2_clks[LOCHNAGAR_NUM_CLOCKS] = {
+	LN2_CLK_REGMAP(CDC_MCLK1,      "ln-cdc-mclk1"),
+	LN2_CLK_REGMAP(CDC_MCLK2,      "ln-cdc-mclk2"),
+	LN2_CLK_REGMAP(DSP_CLKIN,      "ln-dsp-clkin"),
+	LN2_CLK_REGMAP(GF_CLKOUT1,     "ln-gf-clkout1"),
+	LN2_CLK_REGMAP(GF_CLKOUT2,     "ln-gf-clkout2"),
+	LN2_CLK_REGMAP(PSIA1_MCLK,     "ln-psia1-mclk"),
+	LN2_CLK_REGMAP(PSIA2_MCLK,     "ln-psia2-mclk"),
+	LN2_CLK_REGMAP(SPDIF_MCLK,     "ln-spdif-mclk"),
+	LN2_CLK_REGMAP(ADAT_MCLK,      "ln-adat-mclk"),
+	LN2_CLK_REGMAP(SOUNDCARD_MCLK, "ln-soundcard-mclk"),
+
+	LN_CLK_FIXED(PMIC_32K,         "ln-pmic-32k",    32768),
+	LN_CLK_FIXED(CLK_12M,          "ln-clk-12m",     12288000),
+	LN_CLK_FIXED(CLK_11M,          "ln-clk-11m",     11298600),
+	LN_CLK_FIXED(CLK_24M,          "ln-clk-24m",     24576000),
+	LN_CLK_FIXED(CLK_22M,          "ln-clk-22m",     22579200),
+	LN_CLK_FIXED(USB_CLK_24M,      "ln-usb-clk-24m", 24000000),
+	LN_CLK_FIXED(USB_CLK_12M,      "ln-usb-clk-12m", 12000000),
+};
+
+static inline struct lochnagar_clk *lochnagar_hw_to_lclk(struct clk_hw *hw)
+{
+	return container_of(hw, struct lochnagar_clk, hw);
+}
+
+static int lochnagar_regmap_prepare(struct clk_hw *hw)
+{
+	struct lochnagar_clk *lclk = lochnagar_hw_to_lclk(hw);
+	struct lochnagar_clk_priv *priv = lclk->priv;
+	struct regmap *regmap = priv->lochnagar->regmap;
+	int ret;
+
+	dev_dbg(priv->dev, "Prepare %s\n", lclk->name);
+
+	if (!lclk->regmap.ena_mask)
+		return 0;
+
+	ret = regmap_update_bits(regmap, lclk->regmap.cfg_reg,
+				 lclk->regmap.ena_mask,
+				 lclk->regmap.ena_mask);
+	if (ret < 0)
+		dev_err(priv->dev, "Failed to prepare %s: %d\n",
+			lclk->name, ret);
+
+	return ret;
+}
+
+static void lochnagar_regmap_unprepare(struct clk_hw *hw)
+{
+	struct lochnagar_clk *lclk = lochnagar_hw_to_lclk(hw);
+	struct lochnagar_clk_priv *priv = lclk->priv;
+	struct regmap *regmap = priv->lochnagar->regmap;
+	int ret;
+
+	dev_dbg(priv->dev, "Unprepare %s\n", lclk->name);
+
+	if (!lclk->regmap.ena_mask)
+		return;
+
+	ret = regmap_update_bits(regmap, lclk->regmap.cfg_reg,
+				 lclk->regmap.ena_mask, 0);
+	if (ret < 0)
+		dev_err(priv->dev, "Failed to unprepare %s: %d\n",
+			lclk->name, ret);
+}
+
+static int lochnagar_regmap_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct lochnagar_clk *lclk = lochnagar_hw_to_lclk(hw);
+	struct lochnagar_clk_priv *priv = lclk->priv;
+	struct regmap *regmap = priv->lochnagar->regmap;
+	int ret;
+
+	dev_dbg(priv->dev, "Reparent %s to %s\n",
+		lclk->name, priv->parents[index]);
+
+	if (lclk->regmap.dir_mask) {
+		ret = regmap_update_bits(regmap, lclk->regmap.cfg_reg,
+					 lclk->regmap.dir_mask,
+					 lclk->regmap.dir_mask);
+		if (ret < 0) {
+			dev_err(priv->dev, "Failed to set %s direction: %d\n",
+				lclk->name, ret);
+			return ret;
+		}
+	}
+
+	ret = regmap_update_bits(regmap, lclk->regmap.src_reg,
+				 lclk->regmap.src_mask, index);
+	if (ret < 0)
+		dev_err(priv->dev, "Failed to reparent %s: %d\n",
+			lclk->name, ret);
+
+	return ret;
+}
+
+static u8 lochnagar_regmap_get_parent(struct clk_hw *hw)
+{
+	struct lochnagar_clk *lclk = lochnagar_hw_to_lclk(hw);
+	struct lochnagar_clk_priv *priv = lclk->priv;
+	struct regmap *regmap = priv->lochnagar->regmap;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, lclk->regmap.src_reg, &val);
+	if (ret < 0) {
+		dev_err(priv->dev, "Failed to read parent of %s: %d\n",
+			lclk->name, ret);
+		return 0;
+	}
+
+	val &= lclk->regmap.src_mask;
+
+	dev_dbg(priv->dev, "Parent of %s is %s\n",
+		lclk->name, priv->parents[val]);
+
+	return val;
+}
+
+static const struct clk_ops lochnagar_clk_regmap_ops = {
+	.prepare = lochnagar_regmap_prepare,
+	.unprepare = lochnagar_regmap_unprepare,
+	.set_parent = lochnagar_regmap_set_parent,
+	.get_parent = lochnagar_regmap_get_parent,
+};
+
+static int lochnagar_init_parents(struct lochnagar_clk_priv *priv)
+{
+	struct device_node *np = priv->lochnagar->dev->of_node;
+	enum lochnagar_type type = priv->lochnagar->type;
+	int i, j;
+
+	switch (type) {
+	case LOCHNAGAR1:
+		memcpy(priv->lclks, lochnagar1_clks, sizeof(lochnagar1_clks));
+
+		priv->nparents = ARRAY_SIZE(lochnagar1_clk_parents);
+		priv->parents = devm_kmemdup(priv->dev, lochnagar1_clk_parents,
+					     sizeof(lochnagar1_clk_parents),
+					     GFP_KERNEL);
+		break;
+	case LOCHNAGAR2:
+		memcpy(priv->lclks, lochnagar2_clks, sizeof(lochnagar2_clks));
+
+		priv->nparents = ARRAY_SIZE(lochnagar2_clk_parents);
+		priv->parents = devm_kmemdup(priv->dev, lochnagar2_clk_parents,
+					     sizeof(lochnagar2_clk_parents),
+					     GFP_KERNEL);
+		break;
+	default:
+		dev_err(priv->dev, "Unknown Lochnagar type: %d\n", type);
+		return -EINVAL;
+	}
+
+	if (!priv->parents)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->nparents; i++) {
+		j = of_property_match_string(np, "clock-names",
+					     priv->parents[i]);
+		if (j >= 0) {
+			const char * const name = of_clk_get_parent_name(np, j);
+
+			dev_dbg(priv->dev, "Set parent %s to %s\n",
+				priv->parents[i], name);
+
+			priv->parents[i] = name;
+		}
+	}
+
+	return 0;
+}
+
+static int lochnagar_init_clks(struct lochnagar_clk_priv *priv)
+{
+	struct clk_init_data clk_init = {
+		.ops = &lochnagar_clk_regmap_ops,
+		.parent_names = priv->parents,
+		.num_parents = priv->nparents,
+	};
+	struct lochnagar_clk *lclk;
+	struct clk *clk;
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(priv->lclks); i++) {
+		lclk = &priv->lclks[i];
+
+		lclk->priv = priv;
+
+		switch (lclk->type) {
+		case LOCHNAGAR_CLK_TYPE_FIXED:
+			clk = clk_register_fixed_rate(priv->dev, lclk->name,
+						      NULL, 0,
+						      lclk->fixed.rate);
+			break;
+		case LOCHNAGAR_CLK_TYPE_REGMAP:
+			clk_init.name = lclk->name;
+			lclk->hw.init = &clk_init;
+
+			clk = devm_clk_register(priv->dev, &lclk->hw);
+			break;
+		default:
+			continue;
+		}
+
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			dev_err(priv->dev, "Failed to register %s: %d\n",
+				lclk->name, ret);
+			return ret;
+		}
+
+		dev_dbg(priv->dev, "Registered %s\n", lclk->name);
+
+		priv->clks[i] = clk;
+	}
+
+	return 0;
+}
+
+static int lochnagar_init_of_providers(struct lochnagar_clk_priv *priv)
+{
+	struct device *dev = priv->dev;
+	int ret;
+
+	priv->of_clks.clks = priv->clks;
+	priv->of_clks.clk_num = ARRAY_SIZE(priv->clks);
+
+	ret = of_clk_add_provider(priv->lochnagar->dev->of_node,
+				  of_clk_src_onecell_get,
+				  &priv->of_clks);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register clock provider: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lochnagar_clk_probe(struct platform_device *pdev)
+{
+	struct lochnagar *lochnagar = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct lochnagar_clk_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->lochnagar = lochnagar;
+
+	ret = lochnagar_init_parents(priv);
+	if (ret)
+		return ret;
+
+	ret = lochnagar_init_clks(priv);
+	if (ret)
+		return ret;
+
+	ret = lochnagar_init_of_providers(priv);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int lochnagar_clk_remove(struct platform_device *pdev)
+{
+	struct lochnagar_clk_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	of_clk_del_provider(priv->lochnagar->dev->of_node);
+
+	for (i = 0; i < ARRAY_SIZE(priv->lclks); i++) {
+		switch (priv->lclks[i].type) {
+		case LOCHNAGAR_CLK_TYPE_FIXED:
+			clk_unregister_fixed_rate(priv->clks[i]);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static struct platform_driver lochnagar_clk_driver = {
+	.driver = {
+		.name = "lochnagar-clk",
+	},
+
+	.probe = lochnagar_clk_probe,
+	.remove = lochnagar_clk_remove,
+};
+module_platform_driver(lochnagar_clk_driver);
+
+MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.cirrus.com>");
+MODULE_DESCRIPTION("Clock driver for Cirrus Logic Lochnagar Board");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:lochnagar-clk");
-- 
2.11.0

