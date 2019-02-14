Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E98C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434D5218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550160035;
	bh=FzglLh6D6U2O2UyI8e6Y9pU9kXo7Q6ba/xVkMsoorXk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yjxBwvu93kGkXzLxxhESB8zDwB8pMJ8jALmtOcAgIGleB/ZfT758aHNcp4LbL9ssx
	 2TnfMUYSloGjgDDcWf1YugYxlZzzjU0HGn7y3JGnwjitMkVAvr3XowWMp1VJChMVDx
	 GzK/fdWwtL2/SiawWnLsSXP5NKoZyYh3SJ7CeohA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502476AbfBNQAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:00:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57444 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393948AbfBNQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZNJZNVEcGjw5uGYMXZimzpHeAwkrTATOB0iV2IAdqB8=; b=m/1t8y+Mh5RR
        FPTYz6+4VxY2+LOCQSyOBCUFqHvIsORp2Ut8FchOruNp8MnYLTLkPfuwgVOXacO/hpV04VJFfafvY
        YVsUVOx+ey2HZqQQ93DNe+qFp7t7MARZK0oRfsf0i2IR4PDugHjdUR82k3jW+M2vR6v6P3GgNzE+d
        4culk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guJR0-0005dS-UZ; Thu, 14 Feb 2019 16:00:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 13AD41126F78; Thu, 14 Feb 2019 16:00:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Angus Ainslie <angus@akkea.ca>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd718x7: Support SNVS low power state" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190214160022.13AD41126F78@debutante.sirena.org.uk>
Date:   Thu, 14 Feb 2019 16:00:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd718x7: Support SNVS low power state

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

From 049369d464289bb57bcfb6faa20990a06fe1e7ae Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Thu, 14 Feb 2019 11:39:36 +0200
Subject: [PATCH] regulator: bd718x7: Support SNVS low power state

read ROHM BD71837 / BD71847 specific device tree bindings for
controlling the PMIC shutdown/reset states and voltages for
different HW states. The PMIC was designed to be used with NXP
i.MX8 SoC and it supports SNVS low power state which seems to
be typical for NXP i.MX SoCs. However, when SNVS is used we must
not allow SW to control enabling/disabling those regulators which
are crucial for system to boot as there is a HW limitation which
causes SW controlled regulators to be kept shut down after SNVS
reset.

Allow setting the SNVS to be used as reset target state and allow
marking those regulators which are critical for boot.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Tested-by: Angus Ainslie <angus@akkea.ca>
Reviewed-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd718x7-regulator.c | 201 ++++++++++++++++++++++----
 1 file changed, 176 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index ccea133778c8..b2191be49670 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -350,6 +350,135 @@ static const struct reg_init bd71837_ldo6_inits[] = {
 	},
 };
 
+#define NUM_DVS_BUCKS 4
+
+struct of_dvs_setting {
+	const char *prop;
+	unsigned int reg;
+};
+
+static int set_dvs_levels(const struct of_dvs_setting *dvs,
+			  struct device_node *np,
+			  const struct regulator_desc *desc,
+			  struct regmap *regmap)
+{
+	int ret, i;
+	unsigned int uv;
+
+	ret = of_property_read_u32(np, dvs->prop, &uv);
+	if (ret) {
+		if (ret != -EINVAL)
+			return ret;
+		return 0;
+	}
+
+	for (i = 0; i < desc->n_voltages; i++) {
+		ret = regulator_desc_list_voltage_linear_range(desc, i);
+		if (ret < 0)
+			continue;
+		if (ret == uv) {
+			i <<= ffs(desc->vsel_mask) - 1;
+			ret = regmap_update_bits(regmap, dvs->reg,
+						 DVS_BUCK_RUN_MASK, i);
+			break;
+		}
+	}
+	return ret;
+}
+
+static int buck4_set_hw_dvs_levels(struct device_node *np,
+			    const struct regulator_desc *desc,
+			    struct regulator_config *cfg)
+{
+	int ret, i;
+	const struct of_dvs_setting dvs[] = {
+		{
+			.prop = "rohm,dvs-run-voltage",
+			.reg = BD71837_REG_BUCK4_VOLT_RUN,
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
+		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+static int buck3_set_hw_dvs_levels(struct device_node *np,
+			    const struct regulator_desc *desc,
+			    struct regulator_config *cfg)
+{
+	int ret, i;
+	const struct of_dvs_setting dvs[] = {
+		{
+			.prop = "rohm,dvs-run-voltage",
+			.reg = BD71837_REG_BUCK3_VOLT_RUN,
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
+		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static int buck2_set_hw_dvs_levels(struct device_node *np,
+			    const struct regulator_desc *desc,
+			    struct regulator_config *cfg)
+{
+	int ret, i;
+	const struct of_dvs_setting dvs[] = {
+		{
+			.prop = "rohm,dvs-run-voltage",
+			.reg = BD718XX_REG_BUCK2_VOLT_RUN,
+		},
+		{
+			.prop = "rohm,dvs-idle-voltage",
+			.reg = BD718XX_REG_BUCK2_VOLT_IDLE,
+		},
+	};
+
+
+
+	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
+		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static int buck1_set_hw_dvs_levels(struct device_node *np,
+			    const struct regulator_desc *desc,
+			    struct regulator_config *cfg)
+{
+	int ret, i;
+	const struct of_dvs_setting dvs[] = {
+		{
+			.prop = "rohm,dvs-run-voltage",
+			.reg = BD718XX_REG_BUCK1_VOLT_RUN,
+		},
+		{
+			.prop = "rohm,dvs-idle-voltage",
+			.reg = BD718XX_REG_BUCK1_VOLT_IDLE,
+		},
+		{
+			.prop = "rohm,dvs-suspend-voltage",
+			.reg = BD718XX_REG_BUCK1_VOLT_SUSP,
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
+		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 static const struct bd718xx_regulator_data bd71847_regulators[] = {
 	{
 		.desc = {
@@ -368,6 +497,7 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.enable_reg = BD718XX_REG_BUCK1_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck1_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD718XX_REG_BUCK1_CTRL,
@@ -391,6 +521,7 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.enable_reg = BD718XX_REG_BUCK2_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck2_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD718XX_REG_BUCK2_CTRL,
@@ -662,6 +793,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD718XX_REG_BUCK1_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck1_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD718XX_REG_BUCK1_CTRL,
@@ -685,6 +817,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD718XX_REG_BUCK2_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck2_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD718XX_REG_BUCK2_CTRL,
@@ -708,6 +841,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD71837_REG_BUCK3_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck3_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD71837_REG_BUCK3_CTRL,
@@ -731,6 +865,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD71837_REG_BUCK4_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck4_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD71837_REG_BUCK4_CTRL,
@@ -1029,6 +1164,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 	};
 
 	int i, j, err;
+	bool use_snvs;
 
 	mfd = dev_get_drvdata(pdev->dev.parent);
 	if (!mfd) {
@@ -1055,27 +1191,28 @@ static int bd718xx_probe(struct platform_device *pdev)
 			BD718XX_REG_REGLOCK);
 	}
 
-	/* At poweroff transition PMIC HW disables EN bit for regulators but
-	 * leaves SEL bit untouched. So if state transition from POWEROFF
-	 * is done to SNVS - then all power rails controlled by SW (having
-	 * SEL bit set) stay disabled as EN is cleared. This may result boot
-	 * failure if any crucial systems are powered by these rails.
-	 *
+	use_snvs = of_property_read_bool(pdev->dev.parent->of_node,
+					 "rohm,reset-snvs-powered");
+
+	/*
 	 * Change the next stage from poweroff to be READY instead of SNVS
 	 * for all reset types because OTP loading at READY will clear SEL
 	 * bit allowing HW defaults for power rails to be used
 	 */
-	err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
-				 BD718XX_ON_REQ_POWEROFF_MASK |
-				 BD718XX_SWRESET_POWEROFF_MASK |
-				 BD718XX_WDOG_POWEROFF_MASK |
-				 BD718XX_KEY_L_POWEROFF_MASK,
-				 BD718XX_POWOFF_TO_RDY);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to change reset target\n");
-		goto err;
-	} else {
-		dev_dbg(&pdev->dev, "Changed all resets from SVNS to READY\n");
+	if (!use_snvs) {
+		err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
+					 BD718XX_ON_REQ_POWEROFF_MASK |
+					 BD718XX_SWRESET_POWEROFF_MASK |
+					 BD718XX_WDOG_POWEROFF_MASK |
+					 BD718XX_KEY_L_POWEROFF_MASK,
+					 BD718XX_POWOFF_TO_RDY);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to change reset target\n");
+			goto err;
+		} else {
+			dev_dbg(&pdev->dev,
+				"Changed all resets from SVNS to READY\n");
+		}
 	}
 
 	for (i = 0; i < pmic_regulators[mfd->chip_type].r_amount; i++) {
@@ -1098,19 +1235,33 @@ static int bd718xx_probe(struct platform_device *pdev)
 			err = PTR_ERR(rdev);
 			goto err;
 		}
-		/* Regulator register gets the regulator constraints and
+
+		/*
+		 * Regulator register gets the regulator constraints and
 		 * applies them (set_machine_constraints). This should have
 		 * turned the control register(s) to correct values and we
 		 * can now switch the control from PMIC state machine to the
 		 * register interface
+		 *
+		 * At poweroff transition PMIC HW disables EN bit for
+		 * regulators but leaves SEL bit untouched. So if state
+		 * transition from POWEROFF is done to SNVS - then all power
+		 * rails controlled by SW (having SEL bit set) stay disabled
+		 * as EN is cleared. This will result boot failure if any
+		 * crucial systems are powered by these rails. We don't
+		 * enable SW control for crucial regulators if snvs state is
+		 * used
 		 */
-		err = regmap_update_bits(mfd->regmap, r->init.reg,
-					 r->init.mask, r->init.val);
-		if (err) {
-			dev_err(&pdev->dev,
-				"Failed to write BUCK/LDO SEL bit for (%s)\n",
-				desc->name);
-			goto err;
+		if (!use_snvs || !rdev->constraints->always_on ||
+		    !rdev->constraints->boot_on) {
+			err = regmap_update_bits(mfd->regmap, r->init.reg,
+						 r->init.mask, r->init.val);
+			if (err) {
+				dev_err(&pdev->dev,
+					"Failed to take control for (%s)\n",
+					desc->name);
+				goto err;
+			}
 		}
 		for (j = 0; j < r->additional_init_amnt; j++) {
 			err = regmap_update_bits(mfd->regmap,
-- 
2.20.1

