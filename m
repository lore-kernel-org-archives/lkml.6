Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5AEC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D752087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548782196;
	bh=KcWTtaCEmauQ5AYLJbQCwn6U0pf3529HV12zOGo6RxQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=asK3pp7AGaj6De1Mk7GxYkmfLIIsvC8GvWnTFwauAI6W+RXzZ0m2DdMZOrwWlT40o
	 vBy2bVSt7+ROvGTMZFarRUf9W7nDaKEKmun2hTiSbi4bRJTxx/oEj8IzEjRYP7vhrY
	 syBPMx9no3suVhWckdMmsuXzofu6ynyO/3wJtuxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfA2RQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:16:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50630 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfA2RQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=14lOiFeer+tjSh7B5DHXZFWpL3apoSQWiReno59HtVM=; b=aqXhIcxL9ocG
        XmA52Llb6z8uwMo4+VsikR9xOMsriC5XeFHpG74+EQPxvqNuF5wGol5iJli+bdePV/y3XXNtGP3Jz
        FfcZA93R+ZEtGWy8oP//FraK13wVU5blyVnivPbKBTJOHE6Kl2vWPQtnr/DGtl5jzo23c++yPhdlH
        f/ihs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goWzo-0000js-HL; Tue, 29 Jan 2019 17:16:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 204E51127D50; Tue, 29 Jan 2019 17:16:24 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max77650: add regulator support" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190129171624.204E51127D50@debutante.sirena.org.uk>
Date:   Tue, 29 Jan 2019 17:16:24 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77650: add regulator support

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

From bcc61f1c44fd21ef0095c38553d2adfe9c1ccae1 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 29 Jan 2019 14:35:40 +0100
Subject: [PATCH] regulator: max77650: add regulator support

Add regulator support for max77650. We support all four variants of this
PMIC including non-linear voltage table for max77651 SBB1 rail.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig              |   8 +
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max77650-regulator.c | 518 +++++++++++++++++++++++++
 3 files changed, 527 insertions(+)
 create mode 100644 drivers/regulator/max77650-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 21dc3b59db19..b7f249ee5e68 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -468,6 +468,14 @@ config REGULATOR_MAX77620
 	  chip to control Step-Down DC-DC and LDOs. Say Y here to
 	  enable the regulator driver.
 
+config REGULATOR_MAX77650
+	tristate "Maxim MAX77650/77651 regulator support"
+	depends on MFD_MAX77650
+	help
+	  Regulator driver for MAX77650/77651 PMIC from Maxim
+	  Semiconductor. This device has a SIMO with three independent
+	  power rails and an LDO.
+
 config REGULATOR_MAX8649
 	tristate "Maxim 8649 voltage regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 960406952119..1169f8a27d91 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
+obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
 obj-$(CONFIG_REGULATOR_MAX8660) += max8660.o
 obj-$(CONFIG_REGULATOR_MAX8907) += max8907-regulator.o
diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
new file mode 100644
index 000000000000..474f2c02f2d5
--- /dev/null
+++ b/drivers/regulator/max77650-regulator.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 BayLibre SAS
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+//
+// Regulator driver for MAXIM 77650/77651 charger/power-supply.
+
+#include <linux/i2c.h>
+#include <linux/mfd/max77650.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+#define MAX77650_REGULATOR_EN_CTRL_MASK		GENMASK(3, 0)
+#define MAX77650_REGULATOR_EN_CTRL_BITS(_reg) \
+		((_reg) & MAX77650_REGULATOR_EN_CTRL_MASK)
+#define MAX77650_REGULATOR_ENABLED		GENMASK(2, 1)
+#define MAX77650_REGULATOR_DISABLED		BIT(2)
+
+#define MAX77650_REGULATOR_V_LDO_MASK		GENMASK(6, 0)
+#define MAX77650_REGULATOR_V_SBB_MASK		GENMASK(5, 0)
+
+#define MAX77650_REGULATOR_AD_MASK		BIT(3)
+#define MAX77650_REGULATOR_AD_DISABLED		0x00
+#define MAX77650_REGULATOR_AD_ENABLED		BIT(3)
+
+#define MAX77650_REGULATOR_CURR_LIM_MASK	GENMASK(7, 6)
+#define MAX77650_REGULATOR_CURR_LIM_BITS(_reg) \
+		(((_reg) & MAX77650_REGULATOR_CURR_LIM_MASK) >> 6)
+#define MAX77650_REGULATOR_CURR_LIM_SHIFT(_val)	((_val) << 6)
+
+enum {
+	MAX77650_REGULATOR_ID_LDO = 0,
+	MAX77650_REGULATOR_ID_SBB0,
+	MAX77650_REGULATOR_ID_SBB1,
+	MAX77650_REGULATOR_ID_SBB2,
+	MAX77650_REGULATOR_NUM_REGULATORS,
+};
+
+struct max77650_regulator_desc {
+	struct regulator_desc desc;
+	unsigned int regA;
+	unsigned int regB;
+};
+
+static const u32 max77651_sbb1_regulator_volt_table[] = {
+	2400000, 3200000, 4000000, 4800000,
+	2450000, 3250000, 4050000, 4850000,
+	2500000, 3300000, 4100000, 4900000,
+	2550000, 3350000, 4150000, 4950000,
+	2600000, 3400000, 4200000, 5000000,
+	2650000, 3450000, 4250000, 5050000,
+	2700000, 3500000, 4300000, 5100000,
+	2750000, 3550000, 4350000, 5150000,
+	2800000, 3600000, 4400000, 5200000,
+	2850000, 3650000, 4450000, 5250000,
+	2900000, 3700000, 4500000,       0,
+	2950000, 3750000, 4550000,       0,
+	3000000, 3800000, 4600000,       0,
+	3050000, 3850000, 4650000,       0,
+	3100000, 3900000, 4700000,       0,
+	3150000, 3950000, 4750000,       0,
+};
+
+#define MAX77651_REGULATOR_SBB1_SEL_DEC(_val) \
+		(((_val & 0x3c) >> 2) | ((_val & 0x03) << 4))
+#define MAX77651_REGULATOR_SBB1_SEL_ENC(_val) \
+		(((_val & 0x30) >> 4) | ((_val & 0x0f) << 2))
+
+#define MAX77650_REGULATOR_SBB1_SEL_DECR(_val)				\
+	do {								\
+		_val = MAX77651_REGULATOR_SBB1_SEL_DEC(_val);		\
+		_val--;							\
+		_val = MAX77651_REGULATOR_SBB1_SEL_ENC(_val);		\
+	} while (0)
+
+#define MAX77650_REGULATOR_SBB1_SEL_INCR(_val)				\
+	do {								\
+		_val = MAX77651_REGULATOR_SBB1_SEL_DEC(_val);		\
+		_val++;							\
+		_val = MAX77651_REGULATOR_SBB1_SEL_ENC(_val);		\
+	} while (0)
+
+static const int max77650_current_limit_table[] = {
+	1000000, 866000, 707000, 500000,
+};
+
+static int max77650_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct max77650_regulator_desc *rdesc;
+	struct regmap *map;
+	int val, rv, en;
+
+	rdesc = rdev_get_drvdata(rdev);
+	map = rdev_get_regmap(rdev);
+
+	rv = regmap_read(map, rdesc->regB, &val);
+	if (rv)
+		return rv;
+
+	en = MAX77650_REGULATOR_EN_CTRL_BITS(val);
+
+	return en != MAX77650_REGULATOR_DISABLED;
+}
+
+static int max77650_regulator_enable(struct regulator_dev *rdev)
+{
+	struct max77650_regulator_desc *rdesc;
+	struct regmap *map;
+
+	rdesc = rdev_get_drvdata(rdev);
+	map = rdev_get_regmap(rdev);
+
+	return regmap_update_bits(map, rdesc->regB,
+				  MAX77650_REGULATOR_EN_CTRL_MASK,
+				  MAX77650_REGULATOR_ENABLED);
+}
+
+static int max77650_regulator_disable(struct regulator_dev *rdev)
+{
+	struct max77650_regulator_desc *rdesc;
+	struct regmap *map;
+
+	rdesc = rdev_get_drvdata(rdev);
+	map = rdev_get_regmap(rdev);
+
+	return regmap_update_bits(map, rdesc->regB,
+				  MAX77650_REGULATOR_EN_CTRL_MASK,
+				  MAX77650_REGULATOR_DISABLED);
+}
+
+static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev,
+					      unsigned int sel)
+{
+	int rv = 0, curr, diff;
+	bool ascending;
+
+	/*
+	 * If the regulator is disabled, we can program the desired
+	 * voltage right away.
+	 */
+	if (!max77650_regulator_is_enabled(rdev))
+		return regulator_set_voltage_sel_regmap(rdev, sel);
+
+	/*
+	 * Otherwise we need to manually ramp the output voltage up/down
+	 * one step at a time.
+	 */
+
+	curr = regulator_get_voltage_sel_regmap(rdev);
+	if (curr < 0)
+		return curr;
+
+	diff = curr - sel;
+	if (diff == 0)
+		return 0; /* Already there. */
+	else if (diff > 0)
+		ascending = false;
+	else
+		ascending = true;
+
+	/*
+	 * Make sure we'll get to the right voltage and break the loop even if
+	 * the selector equals 0.
+	 */
+	for (ascending ? curr++ : curr--;; ascending ? curr++ : curr--) {
+		rv = regulator_set_voltage_sel_regmap(rdev, curr);
+		if (rv)
+			return rv;
+
+		if (curr == sel)
+			break;
+	}
+
+	return 0;
+}
+
+/*
+ * Special case: non-linear voltage table for max77651 SBB1 - software
+ * must ensure the voltage is ramped in 50mV increments.
+ */
+static int max77651_regulator_sbb1_set_voltage_sel(struct regulator_dev *rdev,
+						   unsigned int sel)
+{
+	int rv = 0, curr, vcurr, vdest, vdiff;
+
+	/*
+	 * If the regulator is disabled, we can program the desired
+	 * voltage right away.
+	 */
+	if (!max77650_regulator_is_enabled(rdev))
+		return regulator_set_voltage_sel_regmap(rdev, sel);
+
+	curr = regulator_get_voltage_sel_regmap(rdev);
+	if (curr < 0)
+		return curr;
+
+	if (curr == sel)
+		return 0; /* Already there. */
+
+	vcurr = max77651_sbb1_regulator_volt_table[curr];
+	vdest = max77651_sbb1_regulator_volt_table[sel];
+	vdiff = vcurr - vdest;
+
+	for (;;) {
+		if (vdiff > 0)
+			MAX77650_REGULATOR_SBB1_SEL_DECR(curr);
+		else
+			MAX77650_REGULATOR_SBB1_SEL_INCR(curr);
+
+		rv = regulator_set_voltage_sel_regmap(rdev, curr);
+		if (rv)
+			return rv;
+
+		if (curr == sel)
+			break;
+	};
+
+	return 0;
+}
+
+static int max77650_regulator_get_current_limit(struct regulator_dev *rdev)
+{
+	struct max77650_regulator_desc *rdesc;
+	struct regmap *map;
+	int val, rv, limit;
+
+	rdesc = rdev_get_drvdata(rdev);
+	map = rdev_get_regmap(rdev);
+
+	rv = regmap_read(map, rdesc->regA, &val);
+	if (rv)
+		return rv;
+
+	limit = MAX77650_REGULATOR_CURR_LIM_BITS(val);
+
+	return max77650_current_limit_table[limit];
+}
+
+static int max77650_regulator_set_current_limit(struct regulator_dev *rdev,
+						int min_uA, int max_uA)
+{
+	struct max77650_regulator_desc *rdesc;
+	struct regmap *map;
+	int rv, i, limit;
+
+	rdesc = rdev_get_drvdata(rdev);
+	map = rdev_get_regmap(rdev);
+
+	for (i = 0; i < ARRAY_SIZE(max77650_current_limit_table); i++) {
+		limit = max77650_current_limit_table[i];
+
+		if (limit >= min_uA && limit <= max_uA) {
+			rv = regmap_update_bits(map, rdesc->regA,
+					MAX77650_REGULATOR_CURR_LIM_MASK,
+					MAX77650_REGULATOR_CURR_LIM_SHIFT(i));
+			if (rv)
+				return rv;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct regulator_ops max77650_regulator_LDO_ops = {
+	.is_enabled		= max77650_regulator_is_enabled,
+	.enable			= max77650_regulator_enable,
+	.disable		= max77650_regulator_disable,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
+	.set_active_discharge	= regulator_set_active_discharge_regmap,
+};
+
+static const struct regulator_ops max77650_regulator_SBB_ops = {
+	.is_enabled		= max77650_regulator_is_enabled,
+	.enable			= max77650_regulator_enable,
+	.disable		= max77650_regulator_disable,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
+	.get_current_limit	= max77650_regulator_get_current_limit,
+	.set_current_limit	= max77650_regulator_set_current_limit,
+	.set_active_discharge	= regulator_set_active_discharge_regmap,
+};
+
+/* Special case for max77651 SBB1 - non-linear voltage mapping. */
+static const struct regulator_ops max77651_SBB1_regulator_ops = {
+	.is_enabled		= max77650_regulator_is_enabled,
+	.enable			= max77650_regulator_enable,
+	.disable		= max77650_regulator_disable,
+	.list_voltage		= regulator_list_voltage_table,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= max77651_regulator_sbb1_set_voltage_sel,
+	.get_current_limit	= max77650_regulator_get_current_limit,
+	.set_current_limit	= max77650_regulator_set_current_limit,
+	.set_active_discharge	= regulator_set_active_discharge_regmap,
+};
+
+static struct max77650_regulator_desc max77650_LDO_desc = {
+	.desc = {
+		.name			= "ldo",
+		.of_match		= of_match_ptr("ldo"),
+		.regulators_node	= of_match_ptr("regulators"),
+		.supply_name		= "in-ldo",
+		.id			= MAX77650_REGULATOR_ID_LDO,
+		.ops			= &max77650_regulator_LDO_ops,
+		.min_uV			= 1350000,
+		.uV_step		= 12500,
+		.n_voltages		= 128,
+		.vsel_mask		= MAX77650_REGULATOR_V_LDO_MASK,
+		.vsel_reg		= MAX77650_REG_CNFG_LDO_A,
+		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
+		.active_discharge_on	= MAX77650_REGULATOR_AD_ENABLED,
+		.active_discharge_mask	= MAX77650_REGULATOR_AD_MASK,
+		.active_discharge_reg	= MAX77650_REG_CNFG_LDO_B,
+		.enable_time		= 100,
+		.type			= REGULATOR_VOLTAGE,
+	},
+	.regA		= MAX77650_REG_CNFG_LDO_A,
+	.regB		= MAX77650_REG_CNFG_LDO_B,
+};
+
+static struct max77650_regulator_desc max77650_SBB0_desc = {
+	.desc = {
+		.name			= "sbb0",
+		.of_match		= of_match_ptr("sbb0"),
+		.regulators_node	= of_match_ptr("regulators"),
+		.supply_name		= "in-sbb0",
+		.id			= MAX77650_REGULATOR_ID_SBB0,
+		.ops			= &max77650_regulator_SBB_ops,
+		.min_uV			= 800000,
+		.uV_step		= 25000,
+		.n_voltages		= 64,
+		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
+		.vsel_reg		= MAX77650_REG_CNFG_SBB0_A,
+		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
+		.active_discharge_on	= MAX77650_REGULATOR_AD_ENABLED,
+		.active_discharge_mask	= MAX77650_REGULATOR_AD_MASK,
+		.active_discharge_reg	= MAX77650_REG_CNFG_SBB0_B,
+		.enable_time		= 100,
+		.type			= REGULATOR_VOLTAGE,
+	},
+	.regA		= MAX77650_REG_CNFG_SBB0_A,
+	.regB		= MAX77650_REG_CNFG_SBB0_B,
+};
+
+static struct max77650_regulator_desc max77650_SBB1_desc = {
+	.desc = {
+		.name			= "sbb1",
+		.of_match		= of_match_ptr("sbb1"),
+		.regulators_node	= of_match_ptr("regulators"),
+		.supply_name		= "in-sbb1",
+		.id			= MAX77650_REGULATOR_ID_SBB1,
+		.ops			= &max77650_regulator_SBB_ops,
+		.min_uV			= 800000,
+		.uV_step		= 12500,
+		.n_voltages		= 64,
+		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
+		.vsel_reg		= MAX77650_REG_CNFG_SBB1_A,
+		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
+		.active_discharge_on	= MAX77650_REGULATOR_AD_ENABLED,
+		.active_discharge_mask	= MAX77650_REGULATOR_AD_MASK,
+		.active_discharge_reg	= MAX77650_REG_CNFG_SBB1_B,
+		.enable_time		= 100,
+		.type			= REGULATOR_VOLTAGE,
+	},
+	.regA		= MAX77650_REG_CNFG_SBB1_A,
+	.regB		= MAX77650_REG_CNFG_SBB1_B,
+};
+
+static struct max77650_regulator_desc max77651_SBB1_desc = {
+	.desc = {
+		.name			= "sbb1",
+		.of_match		= of_match_ptr("sbb1"),
+		.regulators_node	= of_match_ptr("regulators"),
+		.supply_name		= "in-sbb1",
+		.id			= MAX77650_REGULATOR_ID_SBB1,
+		.ops			= &max77651_SBB1_regulator_ops,
+		.volt_table		= max77651_sbb1_regulator_volt_table,
+		.n_voltages = ARRAY_SIZE(max77651_sbb1_regulator_volt_table),
+		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
+		.vsel_reg		= MAX77650_REG_CNFG_SBB1_A,
+		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
+		.active_discharge_on	= MAX77650_REGULATOR_AD_ENABLED,
+		.active_discharge_mask	= MAX77650_REGULATOR_AD_MASK,
+		.active_discharge_reg	= MAX77650_REG_CNFG_SBB1_B,
+		.enable_time		= 100,
+		.type			= REGULATOR_VOLTAGE,
+	},
+	.regA		= MAX77650_REG_CNFG_SBB1_A,
+	.regB		= MAX77650_REG_CNFG_SBB1_B,
+};
+
+static struct max77650_regulator_desc max77650_SBB2_desc = {
+	.desc = {
+		.name			= "sbb2",
+		.of_match		= of_match_ptr("sbb2"),
+		.regulators_node	= of_match_ptr("regulators"),
+		.supply_name		= "in-sbb0",
+		.id			= MAX77650_REGULATOR_ID_SBB2,
+		.ops			= &max77650_regulator_SBB_ops,
+		.min_uV			= 800000,
+		.uV_step		= 50000,
+		.n_voltages		= 64,
+		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
+		.vsel_reg		= MAX77650_REG_CNFG_SBB2_A,
+		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
+		.active_discharge_on	= MAX77650_REGULATOR_AD_ENABLED,
+		.active_discharge_mask	= MAX77650_REGULATOR_AD_MASK,
+		.active_discharge_reg	= MAX77650_REG_CNFG_SBB2_B,
+		.enable_time		= 100,
+		.type			= REGULATOR_VOLTAGE,
+	},
+	.regA		= MAX77650_REG_CNFG_SBB2_A,
+	.regB		= MAX77650_REG_CNFG_SBB2_B,
+};
+
+static struct max77650_regulator_desc max77651_SBB2_desc = {
+	.desc = {
+		.name			= "sbb2",
+		.of_match		= of_match_ptr("sbb2"),
+		.regulators_node	= of_match_ptr("regulators"),
+		.supply_name		= "in-sbb0",
+		.id			= MAX77650_REGULATOR_ID_SBB2,
+		.ops			= &max77650_regulator_SBB_ops,
+		.min_uV			= 2400000,
+		.uV_step		= 50000,
+		.n_voltages		= 64,
+		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
+		.vsel_reg		= MAX77650_REG_CNFG_SBB2_A,
+		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
+		.active_discharge_on	= MAX77650_REGULATOR_AD_ENABLED,
+		.active_discharge_mask	= MAX77650_REGULATOR_AD_MASK,
+		.active_discharge_reg	= MAX77650_REG_CNFG_SBB2_B,
+		.enable_time		= 100,
+		.type			= REGULATOR_VOLTAGE,
+	},
+	.regA		= MAX77650_REG_CNFG_SBB2_A,
+	.regB		= MAX77650_REG_CNFG_SBB2_B,
+};
+
+static int max77650_regulator_probe(struct platform_device *pdev)
+{
+	struct max77650_regulator_desc **rdescs;
+	struct max77650_regulator_desc *rdesc;
+	struct regulator_config config = { };
+	struct device *dev, *parent;
+	struct regulator_dev *rdev;
+	struct regmap *map;
+	unsigned int val;
+	int i, rv;
+
+	dev = &pdev->dev;
+	parent = dev->parent;
+
+	if (!dev->of_node)
+		dev->of_node = parent->of_node;
+
+	rdescs = devm_kcalloc(dev, MAX77650_REGULATOR_NUM_REGULATORS,
+			      sizeof(*rdescs), GFP_KERNEL);
+	if (!rdescs)
+		return -ENOMEM;
+
+	map = dev_get_regmap(parent, NULL);
+	if (!map)
+		return -ENODEV;
+
+	rv = regmap_read(map, MAX77650_REG_CID, &val);
+	if (rv)
+		return rv;
+
+	rdescs[MAX77650_REGULATOR_ID_LDO] = &max77650_LDO_desc;
+	rdescs[MAX77650_REGULATOR_ID_SBB0] = &max77650_SBB0_desc;
+
+	switch (MAX77650_CID_BITS(val)) {
+	case MAX77650_CID_77650A:
+	case MAX77650_CID_77650C:
+		rdescs[MAX77650_REGULATOR_ID_SBB1] = &max77650_SBB1_desc;
+		rdescs[MAX77650_REGULATOR_ID_SBB2] = &max77650_SBB2_desc;
+		break;
+	case MAX77650_CID_77651A:
+	case MAX77650_CID_77651B:
+		rdescs[MAX77650_REGULATOR_ID_SBB1] = &max77651_SBB1_desc;
+		rdescs[MAX77650_REGULATOR_ID_SBB2] = &max77651_SBB2_desc;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	config.dev = parent;
+
+	for (i = 0; i < MAX77650_REGULATOR_NUM_REGULATORS; i++) {
+		rdesc = rdescs[i];
+		config.driver_data = rdesc;
+
+		rdev = devm_regulator_register(dev, &rdesc->desc, &config);
+		if (IS_ERR(rdev))
+			return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
+static struct platform_driver max77650_regulator_driver = {
+	.driver = {
+		.name = "max77650-regulator",
+	},
+	.probe = max77650_regulator_probe,
+};
+module_platform_driver(max77650_regulator_driver);
+
+MODULE_DESCRIPTION("MAXIM 77650/77651 regulator driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

