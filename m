Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C37217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548266273;
	bh=TYOoH5DqNOlFfr+LaH3IMh7+ohbocy0DxdFZj5NLyak=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=D84ylwSEyYXnfkcuwepwA1/whRe0frO/MUjSiA+hHp22RL2jzS45hzomKNODS2YQt
	 3KaGWyjuUeB8i2+3cuH4IAxLJZTGNPXO9aleh9n9H8FW1Du6i0Bf247VFrnUZZCYh2
	 uM90mWWpU84+en4Y52h2pJH7s70tx3wGbYAmS2tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfAWR5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:57:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45646 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfAWR5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=K3gEBRjhCkLEHVM8PtCqTLeKYYLN9Si1VSwwDw2PYsU=; b=dLT7mQOGZl7h
        Jk7nrMWfSLsk+TwVnoiOJfMaDX4pTo2KRVrv5qGX4TN8ZoXslb82lzg2cPALDBmC3tTvAFWtZNnrx
        tL596T13rwwp+65KY0QF7OCTGOOMWKK4l4YJWx0CNnbj+Yf+ETfayL0muZcav/EDMP8+EZ62pujsR
        w6wnA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmMmW-0006qP-MX; Wed, 23 Jan 2019 17:57:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 085C91127ABA; Wed, 23 Jan 2019 17:57:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd70528: Support ROHM BD70528 regulator block" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190123175744.085C91127ABA@debutante.sirena.org.uk>
Date:   Wed, 23 Jan 2019 17:57:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd70528: Support ROHM BD70528 regulator block

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

From 99ea37bd1e7d727bb54c0c4a46708b3e6aa01180 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Tue, 22 Jan 2019 11:46:08 +0200
Subject: [PATCH] regulator: bd70528: Support ROHM BD70528 regulator block

BD70528MWV is an ultra-low Iq general purpose single-chip power
management IC for battery-powered portable devices.

Add support for controlling 3 bucks and 3 LDOs present in
ROHM BD70528.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig             |  11 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/bd70528-regulator.c | 290 ++++++++++++++++++++++++++
 3 files changed, 302 insertions(+)
 create mode 100644 drivers/regulator/bd70528-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 7fc1f88e27e7..21dc3b59db19 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -180,6 +180,17 @@ config REGULATOR_BCM590XX
 	  BCM590xx PMUs. This will enable support for the software
 	  controllable LDO/Switching regulators.
 
+config REGULATOR_BD70528
+	tristate "ROHM BD70528 Power Regulator"
+	depends on MFD_ROHM_BD70528
+	help
+	  This driver supports voltage regulators on ROHM BD70528 PMIC.
+	  This will enable support for the software controllable buck
+	  and LDO regulators.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called bd70528-regulator.
+
 config REGULATOR_BD718XX
 	tristate "ROHM BD71837 Power Regulator"
 	depends on MFD_ROHM_BD718XX
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b12e1c9b2118..960406952119 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
 obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
+obj-$(CONFIG_REGULATOR_BD70528) += bd70528-regulator.o
 obj-$(CONFIG_REGULATOR_BD718XX) += bd718x7-regulator.o
 obj-$(CONFIG_REGULATOR_BD9571MWV) += bd9571mwv-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
new file mode 100644
index 000000000000..0cf261c469b9
--- /dev/null
+++ b/drivers/regulator/bd70528-regulator.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// bd70528-regulator.c ROHM BD70528MWV regulator driver
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/rohm-bd70528.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/slab.h>
+
+#define BUCK_RAMPRATE_250MV 0
+#define BUCK_RAMPRATE_125MV 1
+#define BUCK_RAMP_MAX 250
+
+static struct regulator_linear_range bd70528_buck1_volts[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 600000),
+	REGULATOR_LINEAR_RANGE(2750000, 0x2, 0xf, 50000),
+};
+static struct regulator_linear_range bd70528_buck2_volts[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 300000),
+	REGULATOR_LINEAR_RANGE(1550000, 0x2, 0xd, 50000),
+	REGULATOR_LINEAR_RANGE(3000000, 0xe, 0xf, 300000),
+};
+static struct regulator_linear_range bd70528_buck3_volts[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0x00, 0xd, 50000),
+	REGULATOR_LINEAR_RANGE(1800000, 0xe, 0xf, 0),
+};
+
+/* All LDOs have same voltage ranges */
+static struct regulator_linear_range bd70528_ldo_volts[] = {
+	REGULATOR_LINEAR_RANGE(1650000, 0x0, 0x07, 50000),
+	REGULATOR_LINEAR_RANGE(2100000, 0x8, 0x0f, 100000),
+	REGULATOR_LINEAR_RANGE(2850000, 0x10, 0x19, 50000),
+	REGULATOR_LINEAR_RANGE(3300000, 0x19, 0x1f, 0),
+};
+
+/* Also both LEDs support same voltages */
+static const unsigned int led_volts[] = {
+	20000, 30000
+};
+
+static int bd70528_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
+{
+	if (ramp_delay > 0 && ramp_delay <= BUCK_RAMP_MAX) {
+		unsigned int ramp_value = BUCK_RAMPRATE_250MV;
+
+		if (ramp_delay <= 125)
+			ramp_value = BUCK_RAMPRATE_125MV;
+
+		return regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
+				  BD70528_MASK_BUCK_RAMP,
+				  ramp_value << BD70528_SIFT_BUCK_RAMP);
+	}
+	dev_err(&rdev->dev, "%s: ramp_delay: %d not supported\n",
+		rdev->desc->name, ramp_delay);
+	return -EINVAL;
+}
+
+static int bd70528_led_set_voltage_sel(struct regulator_dev *rdev,
+				       unsigned int sel)
+{
+	int ret;
+
+	ret = regulator_is_enabled_regmap(rdev);
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0)
+		return regulator_set_voltage_sel_regmap(rdev, sel);
+
+	dev_err(&rdev->dev,
+		"LED voltage change not allowed when led is enabled\n");
+
+	return -EBUSY;
+}
+
+static struct regulator_ops bd70528_buck_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay = bd70528_set_ramp_delay,
+};
+
+static struct regulator_ops bd70528_ldo_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay = bd70528_set_ramp_delay,
+};
+
+static struct regulator_ops bd70528_led_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = bd70528_led_set_voltage_sel,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+
+static struct regulator_desc bd70528_desc[] = {
+	{
+		.name = "buck1",
+		.of_match = of_match_ptr("BUCK1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_BUCK1,
+		.ops = &bd70528_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_buck1_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_buck1_volts),
+		.n_voltages = BD70528_BUCK_VOLTS,
+		.enable_reg = BD70528_REG_BUCK1_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_BUCK1_VOLT,
+		.vsel_mask = BD70528_MASK_BUCK_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "buck2",
+		.of_match = of_match_ptr("BUCK2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_BUCK2,
+		.ops = &bd70528_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_buck2_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_buck2_volts),
+		.n_voltages = BD70528_BUCK_VOLTS,
+		.enable_reg = BD70528_REG_BUCK2_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_BUCK2_VOLT,
+		.vsel_mask = BD70528_MASK_BUCK_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "buck3",
+		.of_match = of_match_ptr("BUCK3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_BUCK3,
+		.ops = &bd70528_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_buck3_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_buck3_volts),
+		.n_voltages = BD70528_BUCK_VOLTS,
+		.enable_reg = BD70528_REG_BUCK3_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_BUCK3_VOLT,
+		.vsel_mask = BD70528_MASK_BUCK_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "ldo1",
+		.of_match = of_match_ptr("LDO1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_LDO1,
+		.ops = &bd70528_ldo_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_ldo_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_ldo_volts),
+		.n_voltages = BD70528_LDO_VOLTS,
+		.enable_reg = BD70528_REG_LDO1_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_LDO1_VOLT,
+		.vsel_mask = BD70528_MASK_LDO_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "ldo2",
+		.of_match = of_match_ptr("LDO2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_LDO2,
+		.ops = &bd70528_ldo_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_ldo_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_ldo_volts),
+		.n_voltages = BD70528_LDO_VOLTS,
+		.enable_reg = BD70528_REG_LDO2_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_LDO2_VOLT,
+		.vsel_mask = BD70528_MASK_LDO_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "ldo3",
+		.of_match = of_match_ptr("LDO3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_LDO3,
+		.ops = &bd70528_ldo_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = bd70528_ldo_volts,
+		.n_linear_ranges = ARRAY_SIZE(bd70528_ldo_volts),
+		.n_voltages = BD70528_LDO_VOLTS,
+		.enable_reg = BD70528_REG_LDO3_EN,
+		.enable_mask = BD70528_MASK_RUN_EN,
+		.vsel_reg = BD70528_REG_LDO3_VOLT,
+		.vsel_mask = BD70528_MASK_LDO_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "ldo_led1",
+		.of_match = of_match_ptr("LDO_LED1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_LED1,
+		.ops = &bd70528_led_ops,
+		.type = REGULATOR_VOLTAGE,
+		.volt_table = &led_volts[0],
+		.n_voltages = ARRAY_SIZE(led_volts),
+		.enable_reg = BD70528_REG_LED_EN,
+		.enable_mask = BD70528_MASK_LED1_EN,
+		.vsel_reg = BD70528_REG_LED_VOLT,
+		.vsel_mask = BD70528_MASK_LED1_VOLT,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "ldo_led2",
+		.of_match = of_match_ptr("LDO_LED2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = BD70528_LED2,
+		.ops = &bd70528_led_ops,
+		.type = REGULATOR_VOLTAGE,
+		.volt_table = &led_volts[0],
+		.n_voltages = ARRAY_SIZE(led_volts),
+		.enable_reg = BD70528_REG_LED_EN,
+		.enable_mask = BD70528_MASK_LED2_EN,
+		.vsel_reg = BD70528_REG_LED_VOLT,
+		.vsel_mask = BD70528_MASK_LED2_VOLT,
+		.owner = THIS_MODULE,
+	},
+
+};
+
+static int bd70528_probe(struct platform_device *pdev)
+{
+	struct bd70528 *bd70528;
+	int i;
+	struct regulator_config config = {
+		.dev = pdev->dev.parent,
+	};
+
+	bd70528 = dev_get_drvdata(pdev->dev.parent);
+	if (!bd70528) {
+		dev_err(&pdev->dev, "No MFD driver data\n");
+		return -EINVAL;
+	}
+
+	config.regmap = bd70528->chip.regmap;
+
+	for (i = 0; i < ARRAY_SIZE(bd70528_desc); i++) {
+		struct regulator_dev *rdev;
+
+		rdev = devm_regulator_register(&pdev->dev, &bd70528_desc[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev,
+				"failed to register %s regulator\n",
+				bd70528_desc[i].name);
+			return PTR_ERR(rdev);
+		}
+	}
+	return 0;
+}
+
+static struct platform_driver bd70528_regulator = {
+	.driver = {
+		.name = "bd70528-pmic"
+	},
+	.probe = bd70528_probe,
+};
+
+module_platform_driver(bd70528_regulator);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD70528 voltage regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1

