Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29BDC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD05205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="N2n5/q7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD05205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeH2BCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:02:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47804 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeH2BCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sEuafkH0Y87kJGGx7+bbubqpOVDBms4tGEsbaFSuKCg=; b=N2n5/q7AnVeb
        ILritcpj/BNVHpJ3Q0A3KoV2Qs4wrW2aRlyVUwfgQKaUYR4mvzJ/QQPM13n5Fujh7BCGD4l5ainZD
        VeKl5qcwoO7SccGAPNf7pFmIDi6YJQRw8m4IGZ5pKdZ9OJK3A56wZ5/c3yRR4aw4htWzuSCEXh9JZ
        MTF+c=;
Received: from 94.197.121.204.threembb.co.uk ([94.197.121.204] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fulE2-0007m0-03; Tue, 28 Aug 2018 21:08:34 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8A0E9440085; Tue, 28 Aug 2018 21:55:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Convert to using %pOFn instead of device_node.name" to the regulator tree
In-Reply-To: 
Message-Id: <20180828205506.8A0E9440085@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:55:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Convert to using %pOFn instead of device_node.name

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

From 0c9721a5d1dea7122601dc8694e7d4a208874b84 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Mon, 27 Aug 2018 20:52:42 -0500
Subject: [PATCH] regulator: Convert to using %pOFn instead of device_node.name

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8997-regulator.c      |  4 +-
 drivers/regulator/mc13xxx-regulator-core.c |  2 +-
 drivers/regulator/of_regulator.c           | 44 +++++++++++-----------
 drivers/regulator/qcom-rpmh-regulator.c    | 14 +++----
 drivers/regulator/s5m8767.c                | 12 +++---
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index ad0c806b0737..3bf5ddfaaea8 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -929,8 +929,8 @@ static int max8997_pmic_dt_parse_pdata(struct platform_device *pdev,
 				break;
 
 		if (i == ARRAY_SIZE(regulators)) {
-			dev_warn(&pdev->dev, "don't know how to configure regulator %s\n",
-				 reg_np->name);
+			dev_warn(&pdev->dev, "don't know how to configure regulator %pOFn\n",
+				 reg_np);
 			continue;
 		}
 
diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index da4fb9824757..65eb1e0350cf 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -203,7 +203,7 @@ struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 
 		if (!found)
 			dev_warn(&pdev->dev,
-				 "Unknown regulator: %s\n", child->name);
+				 "Unknown regulator: %pOFn\n", child);
 	}
 	of_node_put(parent);
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 638f17d4c848..92a516b959a7 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -95,8 +95,8 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!ret)
 		constraints->settling_time_up = pval;
 	if (constraints->settling_time_up && constraints->settling_time) {
-		pr_warn("%s: ambiguous configuration for settling time, ignoring 'regulator-settling-time-up-us'\n",
-			np->name);
+		pr_warn("%pOFn: ambiguous configuration for settling time, ignoring 'regulator-settling-time-up-us'\n",
+			np);
 		constraints->settling_time_up = 0;
 	}
 
@@ -105,8 +105,8 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!ret)
 		constraints->settling_time_down = pval;
 	if (constraints->settling_time_down && constraints->settling_time) {
-		pr_warn("%s: ambiguous configuration for settling time, ignoring 'regulator-settling-time-down-us'\n",
-			np->name);
+		pr_warn("%pOFn: ambiguous configuration for settling time, ignoring 'regulator-settling-time-down-us'\n",
+			np);
 		constraints->settling_time_down = 0;
 	}
 
@@ -127,12 +127,12 @@ static void of_get_regulation_constraints(struct device_node *np,
 		if (desc && desc->of_map_mode) {
 			mode = desc->of_map_mode(pval);
 			if (mode == REGULATOR_MODE_INVALID)
-				pr_err("%s: invalid mode %u\n", np->name, pval);
+				pr_err("%pOFn: invalid mode %u\n", np, pval);
 			else
 				constraints->initial_mode = mode;
 		} else {
-			pr_warn("%s: mapping for mode %d not defined\n",
-				np->name, pval);
+			pr_warn("%pOFn: mapping for mode %d not defined\n",
+				np, pval);
 		}
 	}
 
@@ -144,14 +144,14 @@ static void of_get_regulation_constraints(struct device_node *np,
 				ret = of_property_read_u32_index(np,
 					"regulator-allowed-modes", i, &pval);
 				if (ret) {
-					pr_err("%s: couldn't read allowed modes index %d, ret=%d\n",
-						np->name, i, ret);
+					pr_err("%pOFn: couldn't read allowed modes index %d, ret=%d\n",
+						np, i, ret);
 					break;
 				}
 				mode = desc->of_map_mode(pval);
 				if (mode == REGULATOR_MODE_INVALID)
-					pr_err("%s: invalid regulator-allowed-modes element %u\n",
-						np->name, pval);
+					pr_err("%pOFn: invalid regulator-allowed-modes element %u\n",
+						np, pval);
 				else
 					constraints->valid_modes_mask |= mode;
 			}
@@ -159,7 +159,7 @@ static void of_get_regulation_constraints(struct device_node *np,
 				constraints->valid_ops_mask
 					|= REGULATOR_CHANGE_MODE;
 		} else {
-			pr_warn("%s: mode mapping not defined\n", np->name);
+			pr_warn("%pOFn: mode mapping not defined\n", np);
 		}
 	}
 
@@ -197,13 +197,13 @@ static void of_get_regulation_constraints(struct device_node *np,
 			if (desc && desc->of_map_mode) {
 				mode = desc->of_map_mode(pval);
 				if (mode == REGULATOR_MODE_INVALID)
-					pr_err("%s: invalid mode %u\n",
-					       np->name, pval);
+					pr_err("%pOFn: invalid mode %u\n",
+					       np, pval);
 				else
 					suspend_state->mode = mode;
 			} else {
-				pr_warn("%s: mapping for mode %d not defined\n",
-					np->name, pval);
+				pr_warn("%pOFn: mapping for mode %d not defined\n",
+					np, pval);
 			}
 		}
 
@@ -351,8 +351,8 @@ int of_regulator_match(struct device *dev, struct device_node *node,
 							   match->desc);
 			if (!match->init_data) {
 				dev_err(dev,
-					"failed to parse DT for regulator %s\n",
-					child->name);
+					"failed to parse DT for regulator %pOFn\n",
+					child);
 				of_node_put(child);
 				return -EINVAL;
 			}
@@ -401,16 +401,16 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 		init_data = of_get_regulator_init_data(dev, child, desc);
 		if (!init_data) {
 			dev_err(dev,
-				"failed to parse DT for regulator %s\n",
-				child->name);
+				"failed to parse DT for regulator %pOFn\n",
+				child);
 			break;
 		}
 
 		if (desc->of_parse_cb) {
 			if (desc->of_parse_cb(child, desc, config)) {
 				dev_err(dev,
-					"driver callback failed to parse DT for regulator %s\n",
-					child->name);
+					"driver callback failed to parse DT for regulator %pOFn\n",
+					child);
 				init_data = NULL;
 				break;
 			}
diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 9f27daebd8c8..301e7f695374 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -414,7 +414,7 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
 			break;
 
 	if (!rpmh_data->name) {
-		dev_err(dev, "Unknown regulator %s\n", node->name);
+		dev_err(dev, "Unknown regulator %pOFn\n", node);
 		return -EINVAL;
 	}
 
@@ -423,8 +423,8 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
 
 	vreg->addr = cmd_db_read_addr(rpmh_resource_name);
 	if (!vreg->addr) {
-		dev_err(dev, "%s: could not find RPMh address for resource %s\n",
-			node->name, rpmh_resource_name);
+		dev_err(dev, "%pOFn: could not find RPMh address for resource %s\n",
+			node, rpmh_resource_name);
 		return -ENODEV;
 	}
 
@@ -469,13 +469,13 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
 	rdev = devm_regulator_register(dev, &vreg->rdesc, &reg_config);
 	if (IS_ERR(rdev)) {
 		ret = PTR_ERR(rdev);
-		dev_err(dev, "%s: devm_regulator_register() failed, ret=%d\n",
-			node->name, ret);
+		dev_err(dev, "%pOFn: devm_regulator_register() failed, ret=%d\n",
+			node, ret);
 		return ret;
 	}
 
-	dev_dbg(dev, "%s regulator registered for RPMh resource %s @ 0x%05X\n",
-		node->name, rpmh_resource_name, vreg->addr);
+	dev_dbg(dev, "%pOFn regulator registered for RPMh resource %s @ 0x%05X\n",
+		node, rpmh_resource_name, vreg->addr);
 
 	return 0;
 }
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 667d16dc83ce..09a97a7093e8 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -447,15 +447,15 @@ static void s5m8767_regulator_config_ext_control(struct s5m8767_info *s5m8767,
 	}
 	if (mode != S5M8767_ENCTRL_USE_GPIO) {
 		dev_warn(s5m8767->dev,
-				"ext-control for %s: mismatched op_mode (%x), ignoring\n",
-				rdata->reg_node->name, mode);
+				"ext-control for %pOFn: mismatched op_mode (%x), ignoring\n",
+				rdata->reg_node, mode);
 		return;
 	}
 
 	if (!rdata->ext_control_gpiod) {
 		dev_warn(s5m8767->dev,
-				"ext-control for %s: GPIO not valid, ignoring\n",
-			 rdata->reg_node->name);
+				"ext-control for %pOFn: GPIO not valid, ignoring\n",
+			 rdata->reg_node);
 		return;
 	}
 
@@ -566,8 +566,8 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 
 		if (i == ARRAY_SIZE(regulators)) {
 			dev_warn(iodev->dev,
-			"don't know how to configure regulator %s\n",
-			reg_np->name);
+			"don't know how to configure regulator %pOFn\n",
+			reg_np);
 			continue;
 		}
 
-- 
2.18.0

