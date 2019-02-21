Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18641C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB52E214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550749340;
	bh=WRQSCl9DpxEu4urozH/qcvn5rllnob1/rym+hX//fsU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Jlk9XN0L92YL//Q8erZE8nKNMNRxGndY4duYP6A06osFFCfWKa9iIgdUtqkGvhifU
	 xhqFy+nSn9VokDH/1r4qMRp0gPiblAojJ8GmlTstXzclSQ/yM+6jKi8uT9HimNIv1k
	 /MBcwU3Fp1dYZTyqaJEa3qHncnJt+LHIyGA85/yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfBULmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:42:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43382 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBULmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ksjUnBJjklDOaLoVOUwKGDXG6sOaQbeZrg2/hSQkE7E=; b=h9eOeFRzK0M3
        3hJYyRyB1XfF4LJLpQzrcJe0XVhrquRT+tNy/NRZbOh0awJkFtdskeLSdDW3jhsYN80jfPpIZcRnY
        HFNC31SsygxU9E0Zmt3cKnWRR8hdPExHRLzwUk9Ca8fycUjT6jQm1Kq5nLef2bXyFjc6iOxMGMzxl
        2LLTY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwmk3-00039l-1q; Thu, 21 Feb 2019 11:42:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6B3B61122744; Thu, 21 Feb 2019 11:42:14 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: fan53555: Add support for FAN53526" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190221114214.6B3B61122744@debutante.sirena.org.uk>
Date:   Thu, 21 Feb 2019 11:42:14 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fan53555: Add support for FAN53526

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

From f2a9eb975ab2e848af68db26646793f5d9d097e8 Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Wed, 20 Feb 2019 16:43:03 -0800
Subject: [PATCH] regulator: fan53555: Add support for FAN53526

The FAN53526 differs from the FAN53555 only in that the mode bit in
VSEL0/VSEL1 is moved to the CONTROL register, the voltage selector mask
is extended by 1 bit and the step is different.

So extend the existing fan53555 driver to support FAN53526 as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/fan53555.txt           |   3 +-
 drivers/regulator/fan53555.c                  | 101 ++++++++++++++++--
 2 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fan53555.txt b/Documentation/devicetree/bindings/regulator/fan53555.txt
index 54a3f2c80e3a..e7fc045281d1 100644
--- a/Documentation/devicetree/bindings/regulator/fan53555.txt
+++ b/Documentation/devicetree/bindings/regulator/fan53555.txt
@@ -1,7 +1,8 @@
 Binding for Fairchild FAN53555 regulators
 
 Required properties:
-  - compatible: one of "fcs,fan53555", "silergy,syr827", "silergy,syr828"
+  - compatible: one of "fcs,fan53555", "fcs,fan53526", "silergy,syr827" or
+		"silergy,syr828"
   - reg: I2C address
 
 Optional properties:
diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index a3bc8037153e..d7142352f6bc 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -40,7 +40,6 @@
 /* VSEL bit definitions */
 #define VSEL_BUCK_EN	(1 << 7)
 #define VSEL_MODE		(1 << 6)
-#define VSEL_NSEL_MASK	0x3F
 /* Chip ID and Verison */
 #define DIE_ID		0x0F	/* ID1 */
 #define DIE_REV		0x0F	/* ID2 */
@@ -49,14 +48,26 @@
 #define CTL_SLEW_MASK		(0x7 << 4)
 #define CTL_SLEW_SHIFT		4
 #define CTL_RESET			(1 << 2)
+#define CTL_MODE_VSEL0_MODE	BIT(0)
+#define CTL_MODE_VSEL1_MODE	BIT(1)
 
 #define FAN53555_NVOLTAGES	64	/* Numbers of voltages */
+#define FAN53526_NVOLTAGES	128
 
 enum fan53555_vendor {
-	FAN53555_VENDOR_FAIRCHILD = 0,
+	FAN53526_VENDOR_FAIRCHILD = 0,
+	FAN53555_VENDOR_FAIRCHILD,
 	FAN53555_VENDOR_SILERGY,
 };
 
+enum {
+	FAN53526_CHIP_ID_01 = 1,
+};
+
+enum {
+	FAN53526_CHIP_REV_08 = 8,
+};
+
 /* IC Type */
 enum {
 	FAN53555_CHIP_ID_00 = 0,
@@ -94,8 +105,12 @@ struct fan53555_device_info {
 	/* Voltage range and step(linear) */
 	unsigned int vsel_min;
 	unsigned int vsel_step;
+	unsigned int vsel_count;
 	/* Voltage slew rate limiting */
 	unsigned int slew_rate;
+	/* Mode */
+	unsigned int mode_reg;
+	unsigned int mode_mask;
 	/* Sleep voltage cache */
 	unsigned int sleep_vol_cache;
 };
@@ -111,7 +126,7 @@ static int fan53555_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 	if (ret < 0)
 		return ret;
 	ret = regmap_update_bits(di->regmap, di->sleep_reg,
-					VSEL_NSEL_MASK, ret);
+				 di->desc.vsel_mask, ret);
 	if (ret < 0)
 		return ret;
 	/* Cache the sleep voltage setting.
@@ -143,11 +158,11 @@ static int fan53555_set_mode(struct regulator_dev *rdev, unsigned int mode)
 
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-		regmap_update_bits(di->regmap, di->vol_reg,
-				VSEL_MODE, VSEL_MODE);
+		regmap_update_bits(di->regmap, di->mode_reg,
+				   di->mode_mask, di->mode_mask);
 		break;
 	case REGULATOR_MODE_NORMAL:
-		regmap_update_bits(di->regmap, di->vol_reg, VSEL_MODE, 0);
+		regmap_update_bits(di->regmap, di->vol_reg, di->mode_mask, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -161,10 +176,10 @@ static unsigned int fan53555_get_mode(struct regulator_dev *rdev)
 	unsigned int val;
 	int ret = 0;
 
-	ret = regmap_read(di->regmap, di->vol_reg, &val);
+	ret = regmap_read(di->regmap, di->mode_reg, &val);
 	if (ret < 0)
 		return ret;
-	if (val & VSEL_MODE)
+	if (val & di->mode_mask)
 		return REGULATOR_MODE_FAST;
 	else
 		return REGULATOR_MODE_NORMAL;
@@ -219,6 +234,34 @@ static const struct regulator_ops fan53555_regulator_ops = {
 	.set_suspend_disable = fan53555_set_suspend_disable,
 };
 
+static int fan53526_voltages_setup_fairchild(struct fan53555_device_info *di)
+{
+	/* Init voltage range and step */
+	switch (di->chip_id) {
+	case FAN53526_CHIP_ID_01:
+		switch (di->chip_rev) {
+		case FAN53526_CHIP_REV_08:
+			di->vsel_min = 600000;
+			di->vsel_step = 6250;
+			break;
+		default:
+			dev_err(di->dev,
+				"Chip ID %d with rev %d not supported!\n",
+				di->chip_id, di->chip_rev);
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(di->dev,
+			"Chip ID %d not supported!\n", di->chip_id);
+		return -EINVAL;
+	}
+
+	di->vsel_count = FAN53526_NVOLTAGES;
+
+	return 0;
+}
+
 static int fan53555_voltages_setup_fairchild(struct fan53555_device_info *di)
 {
 	/* Init voltage range and step */
@@ -257,6 +300,8 @@ static int fan53555_voltages_setup_fairchild(struct fan53555_device_info *di)
 		return -EINVAL;
 	}
 
+	di->vsel_count = FAN53555_NVOLTAGES;
+
 	return 0;
 }
 
@@ -274,6 +319,8 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 		return -EINVAL;
 	}
 
+	di->vsel_count = FAN53555_NVOLTAGES;
+
 	return 0;
 }
 
@@ -302,7 +349,35 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 		return -EINVAL;
 	}
 
+	/* Setup mode control register */
+	switch (di->vendor) {
+	case FAN53526_VENDOR_FAIRCHILD:
+		di->mode_reg = FAN53555_CONTROL;
+
+		switch (pdata->sleep_vsel_id) {
+		case FAN53555_VSEL_ID_0:
+			di->mode_mask = CTL_MODE_VSEL1_MODE;
+			break;
+		case FAN53555_VSEL_ID_1:
+			di->mode_mask = CTL_MODE_VSEL0_MODE;
+			break;
+		}
+		break;
+	case FAN53555_VENDOR_FAIRCHILD:
+	case FAN53555_VENDOR_SILERGY:
+		di->mode_reg = di->vol_reg;
+		di->mode_mask = VSEL_MODE;
+		break;
+	default:
+		dev_err(di->dev, "vendor %d not supported!\n", di->vendor);
+		return -EINVAL;
+	}
+
+	/* Setup voltage range */
 	switch (di->vendor) {
+	case FAN53526_VENDOR_FAIRCHILD:
+		ret = fan53526_voltages_setup_fairchild(di);
+		break;
 	case FAN53555_VENDOR_FAIRCHILD:
 		ret = fan53555_voltages_setup_fairchild(di);
 		break;
@@ -326,13 +401,13 @@ static int fan53555_regulator_register(struct fan53555_device_info *di,
 	rdesc->supply_name = "vin";
 	rdesc->ops = &fan53555_regulator_ops;
 	rdesc->type = REGULATOR_VOLTAGE;
-	rdesc->n_voltages = FAN53555_NVOLTAGES;
+	rdesc->n_voltages = di->vsel_count;
 	rdesc->enable_reg = di->vol_reg;
 	rdesc->enable_mask = VSEL_BUCK_EN;
 	rdesc->min_uV = di->vsel_min;
 	rdesc->uV_step = di->vsel_step;
 	rdesc->vsel_reg = di->vol_reg;
-	rdesc->vsel_mask = VSEL_NSEL_MASK;
+	rdesc->vsel_mask = di->vsel_count - 1;
 	rdesc->owner = THIS_MODULE;
 
 	di->rdev = devm_regulator_register(di->dev, &di->desc, config);
@@ -368,6 +443,9 @@ static struct fan53555_platform_data *fan53555_parse_dt(struct device *dev,
 
 static const struct of_device_id fan53555_dt_ids[] = {
 	{
+		.compatible = "fcs,fan53526",
+		.data = (void *)FAN53526_VENDOR_FAIRCHILD,
+	}, {
 		.compatible = "fcs,fan53555",
 		.data = (void *)FAN53555_VENDOR_FAIRCHILD
 	}, {
@@ -467,6 +545,9 @@ static int fan53555_regulator_probe(struct i2c_client *client,
 
 static const struct i2c_device_id fan53555_id[] = {
 	{
+		.name = "fan53526",
+		.driver_data = FAN53526_VENDOR_FAIRCHILD
+	}, {
 		.name = "fan53555",
 		.driver_data = FAN53555_VENDOR_FAIRCHILD
 	}, {
-- 
2.20.1

