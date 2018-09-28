Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45232C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB21C2150D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="oUDNMvg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB21C2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeI1U3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:29:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54706 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeI1U3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lq2iX+LfOv573zrO5+49U+vit187l/xoW63aLGBkvjU=; b=oUDNMvg/Gxxi
        vXU8Mdt4YIoFJjB/AARUhBLldVZ3zNddmdA25HsWdInTKhbzONvZWJHEYD+eNUj3cNmOV+1vHFWlE
        CMfBHat9nMtHj6zYvyDTPq0tE19pWDp2GGDZ2vRgiAXKUE5gMwJl3SJrMJoGJXsuZM4pHCQQFrp4i
        gGch4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5tO8-0008WF-ID; Fri, 28 Sep 2018 14:05:00 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1D6BC440078; Fri, 28 Sep 2018 15:05:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Support regulators where voltage ranges are selectable" to the regulator tree
In-Reply-To: 
Message-Id: <20180928140500.1D6BC440078@finisterre.ee.mobilebroadband>
Date:   Fri, 28 Sep 2018 15:05:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Support regulators where voltage ranges are selectable

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

From 18e4b55fbd2069cee51ef9660b35c65ec13bee6d Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Fri, 14 Sep 2018 11:31:36 +0300
Subject: [PATCH] regulator: Support regulators where voltage ranges are
 selectable

For example ROHM BD71837 and ROHM BD71847 Power management ICs have
regulators which provide multiple linear ranges. Ranges can be
selected by individual non contagious bit in vsel register. Add
regmap helper functions for selecting ranges.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c         |   5 +
 drivers/regulator/helpers.c      | 232 +++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  20 ++-
 3 files changed, 256 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9577d8941846..4b1755a8ef00 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2783,6 +2783,11 @@ static int regulator_map_voltage(struct regulator_dev *rdev, int min_uV,
 	if (desc->ops->list_voltage == regulator_list_voltage_linear_range)
 		return regulator_map_voltage_linear_range(rdev, min_uV, max_uV);
 
+	if (desc->ops->list_voltage ==
+		regulator_list_voltage_pickable_linear_range)
+		return regulator_map_voltage_pickable_linear_range(rdev,
+							min_uV, max_uV);
+
 	return regulator_map_voltage_iterate(rdev, min_uV, max_uV);
 }
 
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 2ae7c3ac5940..d2b9fc359318 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -103,6 +103,128 @@ int regulator_disable_regmap(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(regulator_disable_regmap);
 
+static int regulator_range_selector_to_index(struct regulator_dev *rdev,
+					     unsigned int rval)
+{
+	int i;
+
+	if (!rdev->desc->linear_range_selectors)
+		return -EINVAL;
+
+	rval &= rdev->desc->vsel_range_mask;
+
+	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
+		if (rdev->desc->linear_range_selectors[i] == rval)
+			return i;
+	}
+	return -EINVAL;
+}
+
+/**
+ * regulator_get_voltage_sel_pickable_regmap - pickable range get_voltage_sel
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O and use pickable
+ * ranges can set the vsel_reg, vsel_mask, vsel_range_reg and vsel_range_mask
+ * fields in their descriptor and then use this as their get_voltage_vsel
+ * operation, saving some code.
+ */
+int regulator_get_voltage_sel_pickable_regmap(struct regulator_dev *rdev)
+{
+	unsigned int r_val;
+	int range;
+	unsigned int val;
+	int ret, i;
+	unsigned int voltages_in_range = 0;
+
+	if (!rdev->desc->linear_ranges)
+		return -EINVAL;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &val);
+	if (ret != 0)
+		return ret;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->vsel_range_reg, &r_val);
+	if (ret != 0)
+		return ret;
+
+	val &= rdev->desc->vsel_mask;
+	val >>= ffs(rdev->desc->vsel_mask) - 1;
+
+	range = regulator_range_selector_to_index(rdev, r_val);
+	if (range < 0)
+		return -EINVAL;
+
+	for (i = 0; i < range; i++)
+		voltages_in_range += (rdev->desc->linear_ranges[i].max_sel -
+				     rdev->desc->linear_ranges[i].min_sel) + 1;
+
+	return val + voltages_in_range;
+}
+EXPORT_SYMBOL_GPL(regulator_get_voltage_sel_pickable_regmap);
+
+/**
+ * regulator_set_voltage_sel_pickable_regmap - pickable range set_voltage_sel
+ *
+ * @rdev: regulator to operate on
+ * @sel: Selector to set
+ *
+ * Regulators that use regmap for their register I/O and use pickable
+ * ranges can set the vsel_reg, vsel_mask, vsel_range_reg and vsel_range_mask
+ * fields in their descriptor and then use this as their set_voltage_vsel
+ * operation, saving some code.
+ */
+int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
+					      unsigned int sel)
+{
+	unsigned int range;
+	int ret, i;
+	unsigned int voltages_in_range = 0;
+
+	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
+		voltages_in_range = (rdev->desc->linear_ranges[i].max_sel -
+				     rdev->desc->linear_ranges[i].min_sel) + 1;
+		if (sel < voltages_in_range)
+			break;
+		sel -= voltages_in_range;
+	}
+
+	if (i == rdev->desc->n_linear_ranges)
+		return -EINVAL;
+
+	sel <<= ffs(rdev->desc->vsel_mask) - 1;
+	sel += rdev->desc->linear_ranges[i].min_sel;
+
+	range = rdev->desc->linear_range_selectors[i];
+
+	if (rdev->desc->vsel_reg == rdev->desc->vsel_range_reg) {
+		ret = regmap_update_bits(rdev->regmap,
+					 rdev->desc->vsel_reg,
+					 rdev->desc->vsel_range_mask |
+					 rdev->desc->vsel_mask, sel | range);
+	} else {
+		ret = regmap_update_bits(rdev->regmap,
+					 rdev->desc->vsel_range_reg,
+					 rdev->desc->vsel_range_mask, range);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
+				  rdev->desc->vsel_mask, sel);
+	}
+
+	if (ret)
+		return ret;
+
+	if (rdev->desc->apply_bit)
+		ret = regmap_update_bits(rdev->regmap, rdev->desc->apply_reg,
+					 rdev->desc->apply_bit,
+					 rdev->desc->apply_bit);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regulator_set_voltage_sel_pickable_regmap);
+
 /**
  * regulator_get_voltage_sel_regmap - standard get_voltage_sel for regmap users
  *
@@ -336,6 +458,76 @@ int regulator_map_voltage_linear_range(struct regulator_dev *rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_map_voltage_linear_range);
 
+/**
+ * regulator_map_voltage_pickable_linear_range - map_voltage, pickable ranges
+ *
+ * @rdev: Regulator to operate on
+ * @min_uV: Lower bound for voltage
+ * @max_uV: Upper bound for voltage
+ *
+ * Drivers providing pickable linear_ranges in their descriptor can use
+ * this as their map_voltage() callback.
+ */
+int regulator_map_voltage_pickable_linear_range(struct regulator_dev *rdev,
+						int min_uV, int max_uV)
+{
+	const struct regulator_linear_range *range;
+	int ret = -EINVAL;
+	int voltage, i;
+	unsigned int selector = 0;
+
+	if (!rdev->desc->n_linear_ranges) {
+		BUG_ON(!rdev->desc->n_linear_ranges);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
+		int linear_max_uV;
+
+		range = &rdev->desc->linear_ranges[i];
+		linear_max_uV = range->min_uV +
+			(range->max_sel - range->min_sel) * range->uV_step;
+
+		if (!(min_uV <= linear_max_uV && max_uV >= range->min_uV)) {
+			selector += (range->max_sel - range->min_sel + 1);
+			continue;
+		}
+
+		if (min_uV <= range->min_uV)
+			min_uV = range->min_uV;
+
+		/* range->uV_step == 0 means fixed voltage range */
+		if (range->uV_step == 0) {
+			ret = 0;
+		} else {
+			ret = DIV_ROUND_UP(min_uV - range->min_uV,
+					   range->uV_step);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret += selector;
+
+		voltage = rdev->desc->ops->list_voltage(rdev, ret);
+
+		/*
+		 * Map back into a voltage to verify we're still in bounds.
+		 * We may have overlapping voltage ranges. Hence we don't
+		 * exit but retry until we have checked all ranges.
+		 */
+		if (voltage < min_uV || voltage > max_uV)
+			selector += (range->max_sel - range->min_sel + 1);
+		else
+			break;
+	}
+
+	if (i == rdev->desc->n_linear_ranges)
+		return -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regulator_map_voltage_pickable_linear_range);
+
 /**
  * regulator_list_voltage_linear - List voltages with simple calculation
  *
@@ -360,6 +552,46 @@ int regulator_list_voltage_linear(struct regulator_dev *rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_list_voltage_linear);
 
+/**
+ * regulator_list_voltage_pickable_linear_range - pickable range list voltages
+ *
+ * @rdev: Regulator device
+ * @selector: Selector to convert into a voltage
+ *
+ * list_voltage() operation, intended to be used by drivers utilizing pickable
+ * ranges helpers.
+ */
+int regulator_list_voltage_pickable_linear_range(struct regulator_dev *rdev,
+						 unsigned int selector)
+{
+	const struct regulator_linear_range *range;
+	int i;
+	unsigned int all_sels = 0;
+
+	if (!rdev->desc->n_linear_ranges) {
+		BUG_ON(!rdev->desc->n_linear_ranges);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
+		unsigned int sels_in_range;
+
+		range = &rdev->desc->linear_ranges[i];
+
+		sels_in_range = range->max_sel - range->min_sel;
+
+		if (all_sels + sels_in_range >= selector) {
+			selector -= all_sels;
+			return range->min_uV + (range->uV_step * selector);
+		}
+
+		all_sels += (sels_in_range + 1);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(regulator_list_voltage_pickable_linear_range);
+
 /**
  * regulator_list_voltage_linear_range - List voltages for linear ranges
  *
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 0fd8fbb74763..a9c030192147 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -271,9 +271,16 @@ enum regulator_type {
  * @ramp_delay: Time to settle down after voltage change (unit: uV/us)
  * @min_dropout_uV: The minimum dropout voltage this regulator can handle
  * @linear_ranges: A constant table of possible voltage ranges.
- * @n_linear_ranges: Number of entries in the @linear_ranges table.
+ * @linear_range_selectors: A constant table of voltage range selectors.
+ *			    If pickable ranges are used each range must
+ *			    have corresponding selector here.
+ * @n_linear_ranges: Number of entries in the @linear_ranges (and in
+ *		     linear_range_selectors if used) table(s).
  * @volt_table: Voltage mapping table (if table based mapping)
  *
+ * @vsel_range_reg: Register for range selector when using pickable ranges
+ *		    and regulator_regmap_X_voltage_X_pickable functions.
+ * @vsel_range_mask: Mask for register bitfield used for range selector
  * @vsel_reg: Register for selector when using regulator_regmap_X_voltage_
  * @vsel_mask: Mask for register bitfield used for selector
  * @csel_reg: Register for TPS65218 LS3 current regulator
@@ -338,10 +345,14 @@ struct regulator_desc {
 	int min_dropout_uV;
 
 	const struct regulator_linear_range *linear_ranges;
+	const unsigned int *linear_range_selectors;
+
 	int n_linear_ranges;
 
 	const unsigned int *volt_table;
 
+	unsigned int vsel_range_reg;
+	unsigned int vsel_range_mask;
 	unsigned int vsel_reg;
 	unsigned int vsel_mask;
 	unsigned int csel_reg;
@@ -498,18 +509,25 @@ int regulator_mode_to_status(unsigned int);
 
 int regulator_list_voltage_linear(struct regulator_dev *rdev,
 				  unsigned int selector);
+int regulator_list_voltage_pickable_linear_range(struct regulator_dev *rdev,
+						   unsigned int selector);
 int regulator_list_voltage_linear_range(struct regulator_dev *rdev,
 					unsigned int selector);
 int regulator_list_voltage_table(struct regulator_dev *rdev,
 				  unsigned int selector);
 int regulator_map_voltage_linear(struct regulator_dev *rdev,
 				  int min_uV, int max_uV);
+int regulator_map_voltage_pickable_linear_range(struct regulator_dev *rdev,
+						  int min_uV, int max_uV);
 int regulator_map_voltage_linear_range(struct regulator_dev *rdev,
 				       int min_uV, int max_uV);
 int regulator_map_voltage_iterate(struct regulator_dev *rdev,
 				  int min_uV, int max_uV);
 int regulator_map_voltage_ascend(struct regulator_dev *rdev,
 				  int min_uV, int max_uV);
+int regulator_get_voltage_sel_pickable_regmap(struct regulator_dev *rdev);
+int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
+						unsigned int sel);
 int regulator_get_voltage_sel_regmap(struct regulator_dev *rdev);
 int regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned sel);
 int regulator_is_enabled_regmap(struct regulator_dev *rdev);
-- 
2.19.0

