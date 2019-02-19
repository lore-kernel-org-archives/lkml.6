Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702FAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACD221479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550576880;
	bh=adb2As3xWXqhSyr+CF/1gXcSM1B9+oyrnpIvbRXSP94=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=myBu5zsT3R4tj1NvoVCA65VqqsG9fqk66K7SXYoBafl5HVXNK8QeCNsNe2OA/kkQ+
	 anMBw5eBd8/k9rdKzYBzr4zbO5O/uKILDM+xmS/5REXh2x5w/mmcDSoK6uLUXc9eHB
	 MQHRRVIp6K6F1Qd6MBjWwqc1q8h3PFvTqSuzfrEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfBSLr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:47:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56504 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfBSLr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aISVuzDc/aVFul/3+P6EOvsVnNhAxym8retO+++pdcs=; b=doVUwVGRtxC0
        WCRYoMwpPkwFts4SsacWv2tA5alZJFvw9wurcYehYvKX8EYeAzlS2ove2KphZSFuiCTmZwqIX8cgP
        9kQcfAiOR3+RYQRBgtICS3mJ4mT5H8hylSH0w8ql/SIdFQKLw6vEdsdi/+7ejpTF+Hu/rJtseMN7W
        ICwyY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gw3rx-0008TM-CX; Tue, 19 Feb 2019 11:47:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DFE0A11284A6; Tue, 19 Feb 2019 11:47:24 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     pascal paillet <p.paillet@st.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: stpmic1: Simplify regulators registration" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190219114724.DFE0A11284A6@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 11:47:24 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stpmic1: Simplify regulators registration

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 8c44e448583cbabff5eeda4137f52a1bf2df9a4c Mon Sep 17 00:00:00 2001
From: Pascal PAILLET-LME <p.paillet@st.com>
Date: Tue, 19 Feb 2019 10:04:32 +0000
Subject: [PATCH] regulator: stpmic1: Simplify regulators registration

Stop using a regulator_init callback. This leads to a more simple regulator
registration code. This also permits to spuress struct stpmic1_regulator.
Also rename stpmic1_regulators_matches to stpmic1_matches.

Signed-off-by: pascal paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stpmic1_regulator.c | 168 ++++++++------------------
 1 file changed, 52 insertions(+), 116 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index c25f82fc28f4..f5c0e5887189 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -15,7 +15,7 @@
 #include <dt-bindings/mfd/st,stpmic1.h>
 
 /**
- * stpmic1 regulator description
+ * stpmic1 regulator description: this structure is used as driver data
  * @desc: regulator framework description
  * @mask_reset_reg: mask reset register address
  * @mask_reset_mask: mask rank and mask reset register mask
@@ -30,24 +30,9 @@ struct stpmic1_regulator_cfg {
 	u8 icc_mask;
 };
 
-/**
- * stpmic1 regulator data: this structure is used as driver data
- * @reg_node: DT node of regulator (unused on non-DT platforms)
- * @cfg: stpmic specific regulator description
- * @mask_reset: mask_reset bit value
- * @irq_curlim: current limit interrupt number
- */
-struct stpmic1_regulator {
-	struct device_node *reg_node;
-	const struct stpmic1_regulator_cfg *cfg;
-	u8 mask_reset;
-	int irq_curlim;
-};
-
 static int stpmic1_set_mode(struct regulator_dev *rdev, unsigned int mode);
 static unsigned int stpmic1_get_mode(struct regulator_dev *rdev);
 static int stpmic1_set_icc(struct regulator_dev *rdev);
-static int stpmic1_regulator_parse_dt(void *driver_data);
 static unsigned int stpmic1_map_mode(unsigned int mode);
 
 enum {
@@ -439,8 +424,9 @@ static unsigned int stpmic1_map_mode(unsigned int mode)
 static unsigned int stpmic1_get_mode(struct regulator_dev *rdev)
 {
 	int value;
+	struct regmap *regmap = rdev_get_regmap(rdev);
 
-	regmap_read(rdev->regmap, rdev->desc->enable_reg, &value);
+	regmap_read(regmap, rdev->desc->enable_reg, &value);
 
 	if (value & STPMIC1_BUCK_MODE_LP)
 		return REGULATOR_MODE_STANDBY;
@@ -451,6 +437,7 @@ static unsigned int stpmic1_get_mode(struct regulator_dev *rdev)
 static int stpmic1_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	int value;
+	struct regmap *regmap = rdev_get_regmap(rdev);
 
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
@@ -463,18 +450,18 @@ static int stpmic1_set_mode(struct regulator_dev *rdev, unsigned int mode)
 		return -EINVAL;
 	}
 
-	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
+	return regmap_update_bits(regmap, rdev->desc->enable_reg,
 				  STPMIC1_BUCK_MODE_LP, value);
 }
 
 static int stpmic1_set_icc(struct regulator_dev *rdev)
 {
-	struct stpmic1_regulator *regul = rdev_get_drvdata(rdev);
+	struct stpmic1_regulator_cfg *cfg = rdev_get_drvdata(rdev);
 	struct regmap *regmap = rdev_get_regmap(rdev);
 
 	/* enable switch off in case of over current */
-	return regmap_update_bits(regmap, regul->cfg->icc_reg,
-				  regul->cfg->icc_mask, regul->cfg->icc_mask);
+	return regmap_update_bits(regmap, cfg->icc_reg, cfg->icc_mask,
+				  cfg->icc_mask);
 }
 
 static irqreturn_t stpmic1_curlim_irq_handler(int irq, void *data)
@@ -493,47 +480,13 @@ static irqreturn_t stpmic1_curlim_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int stpmic1_regulator_init(struct platform_device *pdev,
-				  struct regulator_dev *rdev)
-{
-	struct stpmic1_regulator *regul = rdev_get_drvdata(rdev);
-	struct regmap *regmap = rdev_get_regmap(rdev);
-	int ret = 0;
-
-	/* set mask reset */
-	if (regul->mask_reset && regul->cfg->mask_reset_reg != 0) {
-		ret = regmap_update_bits(regmap,
-					 regul->cfg->mask_reset_reg,
-					 regul->cfg->mask_reset_mask,
-					 regul->cfg->mask_reset_mask);
-		if (ret) {
-			dev_err(&pdev->dev, "set mask reset failed\n");
-			return ret;
-		}
-	}
-
-	/* setup an irq handler for over-current detection */
-	if (regul->irq_curlim > 0) {
-		ret = devm_request_threaded_irq(&pdev->dev,
-						regul->irq_curlim, NULL,
-						stpmic1_curlim_irq_handler,
-						IRQF_ONESHOT | IRQF_SHARED,
-						pdev->name, rdev);
-		if (ret) {
-			dev_err(&pdev->dev, "Request IRQ failed\n");
-			return ret;
-		}
-	}
-	return 0;
-}
-
 #define MATCH(_name, _id) \
 	[STPMIC1_##_id] = { \
 		.name = #_name, \
 		.desc = &stpmic1_regulator_cfgs[STPMIC1_##_id].desc, \
 	}
 
-static struct of_regulator_match stpmic1_regulators_matches[] = {
+static struct of_regulator_match stpmic1_matches[] = {
 	MATCH(buck1, BUCK1),
 	MATCH(buck2, BUCK2),
 	MATCH(buck3, BUCK3),
@@ -550,92 +503,75 @@ static struct of_regulator_match stpmic1_regulators_matches[] = {
 	MATCH(pwr_sw2, SW_OUT),
 };
 
-static int stpmic1_regulator_parse_dt(void *driver_data)
-{
-	struct stpmic1_regulator *regul =
-		(struct stpmic1_regulator *)driver_data;
-
-	if (!regul)
-		return -EINVAL;
-
-	if (of_get_property(regul->reg_node, "st,mask-reset", NULL))
-		regul->mask_reset = 1;
-
-	regul->irq_curlim = of_irq_get(regul->reg_node, 0);
-
-	return 0;
-}
-
-static struct
-regulator_dev *stpmic1_regulator_register(struct platform_device *pdev, int id,
-					  struct regulator_init_data *init_data,
-					  struct stpmic1_regulator *regul)
+static int stpmic1_regulator_register(struct platform_device *pdev, int id,
+				      struct of_regulator_match *match,
+				      const struct stpmic1_regulator_cfg *cfg)
 {
 	struct stpmic1 *pmic_dev = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_dev *rdev;
 	struct regulator_config config = {};
+	int ret = 0;
+	int irq;
 
 	config.dev = &pdev->dev;
-	config.init_data = init_data;
-	config.of_node = stpmic1_regulators_matches[id].of_node;
+	config.init_data = match->init_data;
+	config.of_node = match->of_node;
 	config.regmap = pmic_dev->regmap;
-	config.driver_data = regul;
-
-	regul->reg_node = config.of_node;
-	regul->cfg = &stpmic1_regulator_cfgs[id];
+	config.driver_data = (void *)cfg;
 
-	rdev = devm_regulator_register(&pdev->dev, &regul->cfg->desc, &config);
+	rdev = devm_regulator_register(&pdev->dev, &cfg->desc, &config);
 	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "failed to register %s regulator\n",
-			regul->cfg->desc.name);
+			cfg->desc.name);
+		return PTR_ERR(rdev);
 	}
 
-	return rdev;
+	/* set mask reset */
+	if (of_get_property(config.of_node, "st,mask-reset", NULL) &&
+	    cfg->mask_reset_reg != 0) {
+		ret = regmap_update_bits(pmic_dev->regmap,
+					 cfg->mask_reset_reg,
+					 cfg->mask_reset_mask,
+					 cfg->mask_reset_mask);
+		if (ret) {
+			dev_err(&pdev->dev, "set mask reset failed\n");
+			return ret;
+		}
+	}
+
+	/* setup an irq handler for over-current detection */
+	irq = of_irq_get(config.of_node, 0);
+	if (irq > 0) {
+		ret = devm_request_threaded_irq(&pdev->dev,
+						irq, NULL,
+						stpmic1_curlim_irq_handler,
+						IRQF_ONESHOT | IRQF_SHARED,
+						pdev->name, rdev);
+		if (ret) {
+			dev_err(&pdev->dev, "Request IRQ failed\n");
+			return ret;
+		}
+	}
+	return 0;
 }
 
 static int stpmic1_regulator_probe(struct platform_device *pdev)
 {
-	struct regulator_dev *rdev;
-	struct stpmic1_regulator *regul;
-	struct regulator_init_data *init_data;
-	struct device_node *np;
 	int i, ret;
 
-	np = pdev->dev.of_node;
-
-	ret = of_regulator_match(&pdev->dev, np,
-				 stpmic1_regulators_matches,
-				 ARRAY_SIZE(stpmic1_regulators_matches));
+	ret = of_regulator_match(&pdev->dev, pdev->dev.of_node, stpmic1_matches,
+				 ARRAY_SIZE(stpmic1_matches));
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"Error in PMIC regulator device tree node");
 		return ret;
 	}
 
-	regul = devm_kzalloc(&pdev->dev, ARRAY_SIZE(stpmic1_regulator_cfgs) *
-			     sizeof(struct stpmic1_regulator),
-			     GFP_KERNEL);
-	if (!regul)
-		return -ENOMEM;
-
 	for (i = 0; i < ARRAY_SIZE(stpmic1_regulator_cfgs); i++) {
-		/* Parse DT & find regulators to register */
-		init_data = stpmic1_regulators_matches[i].init_data;
-		if (init_data)
-			init_data->regulator_init = &stpmic1_regulator_parse_dt;
-
-		rdev = stpmic1_regulator_register(pdev, i, init_data, regul);
-		if (IS_ERR(rdev))
-			return PTR_ERR(rdev);
-
-		ret = stpmic1_regulator_init(pdev, rdev);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"failed to initialize regulator %d\n", ret);
+		ret = stpmic1_regulator_register(pdev, i, &stpmic1_matches[i],
+						 &stpmic1_regulator_cfgs[i]);
+		if (ret < 0)
 			return ret;
-		}
-
-		regul++;
 	}
 
 	dev_dbg(&pdev->dev, "stpmic1_regulator driver probed\n");
-- 
2.20.1

