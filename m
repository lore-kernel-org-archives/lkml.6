Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A189C18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0331820851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0331820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeKUAqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:46:05 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37860 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbeKUAqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:46:04 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAKEEHBk030453;
        Tue, 20 Nov 2018 08:16:37 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth984dqr-1;
        Tue, 20 Nov 2018 08:16:36 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 696A8611E129;
        Tue, 20 Nov 2018 08:16:35 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 14:16:32 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAKEGVr2000703; Tue,
 20 Nov 2018 14:16:32 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH v5 7/8] clk: lochnagar: Add support for the Cirrus Logic Lochnagar
Date:   Tue, 20 Nov 2018 14:16:30 +0000
Message-ID: <20181120141631.18949-7-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
References: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811200128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v4.

Thanks,
Charles

 drivers/clk/Kconfig         |   7 +
 drivers/clk/Makefile        |   1 +
 drivers/clk/clk-lochnagar.c | 360 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 368 insertions(+)
 create mode 100644 drivers/clk/clk-lochnagar.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 81cdb4eaca07..2c63c431879f 100644
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
index 72be7a38cff1..2354f0c8c8f1 100644
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
index 000000000000..8b2a78689715
--- /dev/null
+++ b/drivers/clk/clk-lochnagar.c
@@ -0,0 +1,360 @@
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
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/lochnagar.h>
+#include <linux/mfd/lochnagar1_regs.h>
+#include <linux/mfd/lochnagar2_regs.h>
+
+#include <dt-bindings/clk/lochnagar.h>
+
+#define LOCHNAGAR_NUM_CLOCKS	(LOCHNAGAR_SPDIF_CLKOUT + 1)
+
+struct lochnagar_clk {
+	const char * const name;
+	struct clk_hw hw;
+
+	struct lochnagar_clk_priv *priv;
+
+	u16 cfg_reg;
+	u16 ena_mask;
+	u16 dir_mask; /* Control bit to set clock as a source or sink */
+
+	u16 src_reg;
+	u16 src_mask;
+};
+
+struct lochnagar_clk_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	enum lochnagar_type type;
+
+	const char **parents;
+	unsigned int nparents;
+
+	struct lochnagar_clk lclks[LOCHNAGAR_NUM_CLOCKS];
+
+	struct clk_hw_onecell_data *clk_data;
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
+#define LN1_CLK(ID, NAME, REG) \
+	[LOCHNAGAR_##ID] = { \
+		.name = NAME, \
+		.cfg_reg = LOCHNAGAR1_##REG, \
+		.ena_mask = LOCHNAGAR1_##ID##_ENA_MASK, \
+		.src_reg = LOCHNAGAR1_##ID##_SEL, \
+		.src_mask = LOCHNAGAR1_SRC_MASK, \
+	}
+
+#define LN2_CLK(ID, NAME) \
+	[LOCHNAGAR_##ID] = { \
+		.name = NAME, \
+		.cfg_reg = LOCHNAGAR2_##ID##_CTRL, \
+		.src_reg = LOCHNAGAR2_##ID##_CTRL, \
+		.ena_mask = LOCHNAGAR2_CLK_ENA_MASK, \
+		.dir_mask = LOCHNAGAR2_CLK_DIR_MASK, \
+		.src_mask = LOCHNAGAR2_CLK_SRC_MASK, \
+	}
+
+static const struct lochnagar_clk lochnagar1_clks[LOCHNAGAR_NUM_CLOCKS] = {
+	LN1_CLK(CDC_MCLK1,      "ln-cdc-mclk1",  CDC_AIF_CTRL2),
+	LN1_CLK(CDC_MCLK2,      "ln-cdc-mclk2",  CDC_AIF_CTRL2),
+	LN1_CLK(DSP_CLKIN,      "ln-dsp-clkin",  DSP_AIF),
+	LN1_CLK(GF_CLKOUT1,     "ln-gf-clkout1", GF_AIF1),
+};
+
+static const struct lochnagar_clk lochnagar2_clks[LOCHNAGAR_NUM_CLOCKS] = {
+	LN2_CLK(CDC_MCLK1,      "ln-cdc-mclk1"),
+	LN2_CLK(CDC_MCLK2,      "ln-cdc-mclk2"),
+	LN2_CLK(DSP_CLKIN,      "ln-dsp-clkin"),
+	LN2_CLK(GF_CLKOUT1,     "ln-gf-clkout1"),
+	LN2_CLK(GF_CLKOUT2,     "ln-gf-clkout2"),
+	LN2_CLK(PSIA1_MCLK,     "ln-psia1-mclk"),
+	LN2_CLK(PSIA2_MCLK,     "ln-psia2-mclk"),
+	LN2_CLK(SPDIF_MCLK,     "ln-spdif-mclk"),
+	LN2_CLK(ADAT_MCLK,      "ln-adat-mclk"),
+	LN2_CLK(SOUNDCARD_MCLK, "ln-soundcard-mclk"),
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
+	struct regmap *regmap = priv->regmap;
+	int ret;
+
+	ret = regmap_update_bits(regmap, lclk->cfg_reg,
+				 lclk->ena_mask, lclk->ena_mask);
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
+	struct regmap *regmap = priv->regmap;
+	int ret;
+
+	ret = regmap_update_bits(regmap, lclk->cfg_reg, lclk->ena_mask, 0);
+	if (ret < 0)
+		dev_err(priv->dev, "Failed to unprepare %s: %d\n",
+			lclk->name, ret);
+}
+
+static int lochnagar_regmap_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct lochnagar_clk *lclk = lochnagar_hw_to_lclk(hw);
+	struct lochnagar_clk_priv *priv = lclk->priv;
+	struct regmap *regmap = priv->regmap;
+	int ret;
+
+	/*
+	 * Some clocks on Lochnagar can either generate a clock themselves
+	 * or accept an external clock, these default to generating the clock
+	 * themselves. If we set a parent however we should update the dir_mask
+	 * to indicate to the hardware that this clock will now be receiving an
+	 * external clock.
+	 */
+	if (lclk->dir_mask) {
+		ret = regmap_update_bits(regmap, lclk->cfg_reg,
+					 lclk->dir_mask, lclk->dir_mask);
+		if (ret < 0) {
+			dev_err(priv->dev, "Failed to set %s direction: %d\n",
+				lclk->name, ret);
+			return ret;
+		}
+	}
+
+	ret = regmap_update_bits(regmap, lclk->src_reg, lclk->src_mask, index);
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
+	struct regmap *regmap = priv->regmap;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, lclk->src_reg, &val);
+	if (ret < 0) {
+		dev_err(priv->dev, "Failed to read parent of %s: %d\n",
+			lclk->name, ret);
+		return priv->nparents;
+	}
+
+	val &= lclk->src_mask;
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
+	struct device_node *np = priv->dev->of_node;
+	int i, j;
+
+	switch (priv->type) {
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
+		dev_err(priv->dev, "Unknown Lochnagar type: %d\n", priv->type);
+		return -EINVAL;
+	}
+
+	if (!priv->parents)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->nparents; i++) {
+		j = of_property_match_string(np, "clock-names",
+					     priv->parents[i]);
+		if (j >= 0)
+			priv->parents[i] = of_clk_get_parent_name(np, j);
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
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(priv->lclks); i++) {
+		lclk = &priv->lclks[i];
+
+		if (!lclk->name)
+			continue;
+
+		clk_init.name = lclk->name;
+
+		lclk->priv = priv;
+		lclk->hw.init = &clk_init;
+
+		ret = devm_clk_hw_register(priv->dev, &lclk->hw);
+		if (ret) {
+			dev_err(priv->dev, "Failed to register %s: %d\n",
+				lclk->name, ret);
+			return ret;
+		}
+
+		priv->clk_data->hws[i] = &lclk->hw;
+	}
+
+	priv->clk_data->num = ARRAY_SIZE(priv->lclks);
+
+	ret = devm_of_clk_add_hw_provider(priv->dev, of_clk_hw_onecell_get,
+					  priv->clk_data);
+	if (ret < 0) {
+		dev_err(priv->dev, "Failed to register provider: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id lochnagar_of_match[] = {
+	{ .compatible = "cirrus,lochnagar1-clk", .data = (void *)LOCHNAGAR1 },
+	{ .compatible = "cirrus,lochnagar2-clk", .data = (void *)LOCHNAGAR2 },
+	{},
+};
+
+static int lochnagar_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct lochnagar_clk_priv *priv;
+	const struct of_device_id *of_id;
+	int ret;
+
+	of_id = of_match_device(lochnagar_of_match, dev);
+	if (!of_id)
+		return -EINVAL;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->clk_data = devm_kzalloc(dev, struct_size(priv->clk_data, hws,
+						       ARRAY_SIZE(priv->lclks)),
+				      GFP_KERNEL);
+	if (!priv->clk_data)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->regmap = dev_get_regmap(dev->parent, NULL);
+	priv->type = (enum lochnagar_type)of_id->data;
+
+	ret = lochnagar_init_parents(priv);
+	if (ret)
+		return ret;
+
+	ret = lochnagar_init_clks(priv);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct platform_driver lochnagar_clk_driver = {
+	.driver = {
+		.name = "lochnagar-clk",
+		.of_match_table = of_match_ptr(lochnagar_of_match),
+	},
+
+	.probe = lochnagar_clk_probe,
+};
+module_platform_driver(lochnagar_clk_driver);
+
+MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.cirrus.com>");
+MODULE_DESCRIPTION("Clock driver for Cirrus Logic Lochnagar Board");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:lochnagar-clk");
-- 
2.11.0

