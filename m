Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0F6C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A92721470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="p9QXpWX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A92721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJMAel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:34:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47836 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMAek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fmk3s/jkhrvZ6MOxcYmoqP2PObM6FV5TA4daM/kOpJU=; b=p9QXpWX9nCro
        hVJUZR6iNcoMX4cQ5Tg5fMEvL/rFwE8Vaxyya71+fivv2q4OEn0GvxGiJ4ESATnIwcoyWocFu558M
        HIKpkZ64tzvI4hN1DVgH7XFa7NMBKAbw6Dn2g0Oavcsn82WNgleaUzyJCcnO0mD3WCmIYgcqJ3ZDY
        tpARY=;
Received: from [91.126.136.150] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gB0oJ-0006eI-Gx; Fri, 12 Oct 2018 17:01:11 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 19C1E440078; Fri, 12 Oct 2018 19:01:11 +0200 (CEST)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lochnagar: Add support for the Cirrus Logic Lochnagar" to the regulator tree
In-Reply-To: 
Message-Id: <20181012170111.19C1E440078@finisterre.ee.mobilebroadband>
Date:   Fri, 12 Oct 2018 19:01:11 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lochnagar: Add support for the Cirrus Logic Lochnagar

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

From bef9391cbec547351c6a13e52f3a26bb2d271ec7 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 8 Oct 2018 14:25:41 +0100
Subject: [PATCH] regulator: lochnagar: Add support for the Cirrus Logic
 Lochnagar

Lochnagar is an evaluation and development board for Cirrus
Logic Smart CODEC and Amp devices. It allows the connection of
most Cirrus Logic devices on mini-cards, as well as allowing
connection of various application processor systems to provide a
full evaluation platform. This driver supports the board
controller chip on the Lochnagar board.

The Lochnagar board provides power supplies for the attached
CODEC/Amp device. Currently this driver supports the microphone
supplies and the digital core voltage for the attached
device. There are some additional supplies that will be
added in time but these supplies are sufficient for most
systems/use-cases.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig               |   7 +
 drivers/regulator/Makefile              |   1 +
 drivers/regulator/lochnagar-regulator.c | 255 ++++++++++++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 drivers/regulator/lochnagar-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 026d480a7ac5..926cee0d0b5f 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -356,6 +356,13 @@ config REGULATOR_LM363X
 	  One boost output voltage is configurable and always on.
 	  Other LDOs are used for the display module.
 
+config REGULATOR_LOCHNAGAR
+	tristate "Cirrus Logic Lochnagar regulator driver"
+	depends on MFD_LOCHNAGAR
+	help
+	  This enables regulator support on the Cirrus Logic Lochnagar audio
+	  development board.
+
 config REGULATOR_LP3971
 	tristate "National Semiconductors LP3971 PMIC regulator driver"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 300bc4ce01d6..72488ef11b8a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_REGULATOR_HI655X) += hi655x-regulator.o
 obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
 obj-$(CONFIG_REGULATOR_ISL9305) += isl9305.o
 obj-$(CONFIG_REGULATOR_LM363X) += lm363x-regulator.o
+obj-$(CONFIG_REGULATOR_LOCHNAGAR) += lochnagar-regulator.o
 obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
 obj-$(CONFIG_REGULATOR_LP3972) += lp3972.o
 obj-$(CONFIG_REGULATOR_LP872X) += lp872x.o
diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
new file mode 100644
index 000000000000..54d791d20408
--- /dev/null
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lochnagar regulator driver
+ *
+ * Copyright (c) 2017-2018 Cirrus Logic, Inc. and
+ *                         Cirrus Logic International Semiconductor Ltd.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+#include <linux/mfd/lochnagar.h>
+
+static const struct regulator_ops lochnagar_micvdd_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+};
+
+static const struct regulator_linear_range lochnagar_micvdd_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1000000, 0,    0xC, 50000),
+	REGULATOR_LINEAR_RANGE(1700000, 0xD, 0x1F, 100000),
+};
+
+static int lochnagar_micbias_enable(struct regulator_dev *rdev)
+{
+	struct lochnagar *lochnagar = rdev_get_drvdata(rdev);
+	int ret;
+
+	mutex_lock(&lochnagar->analogue_config_lock);
+
+	ret = regulator_enable_regmap(rdev);
+	if (ret < 0)
+		goto err;
+
+	ret = lochnagar_update_config(lochnagar);
+
+err:
+	mutex_unlock(&lochnagar->analogue_config_lock);
+
+	return ret;
+}
+
+static int lochnagar_micbias_disable(struct regulator_dev *rdev)
+{
+	struct lochnagar *lochnagar = rdev_get_drvdata(rdev);
+	int ret;
+
+	mutex_lock(&lochnagar->analogue_config_lock);
+
+	ret = regulator_disable_regmap(rdev);
+	if (ret < 0)
+		goto err;
+
+	ret = lochnagar_update_config(lochnagar);
+
+err:
+	mutex_unlock(&lochnagar->analogue_config_lock);
+
+	return ret;
+}
+
+static const struct regulator_ops lochnagar_micbias_ops = {
+	.enable = lochnagar_micbias_enable,
+	.disable = lochnagar_micbias_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static const struct regulator_ops lochnagar_vddcore_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+};
+
+static const struct regulator_linear_range lochnagar_vddcore_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x8, 0x41, 12500),
+};
+
+enum lochnagar_regulators {
+	LOCHNAGAR_MICVDD,
+	LOCHNAGAR_MIC1VDD,
+	LOCHNAGAR_MIC2VDD,
+	LOCHNAGAR_VDDCORE,
+};
+
+static int lochnagar_micbias_of_parse(struct device_node *np,
+				      const struct regulator_desc *desc,
+				      struct regulator_config *config)
+{
+	struct lochnagar *lochnagar = config->driver_data;
+	int shift = (desc->id - LOCHNAGAR_MIC1VDD) *
+		    LOCHNAGAR2_P2_MICBIAS_SRC_SHIFT;
+	int mask = LOCHNAGAR2_P1_MICBIAS_SRC_MASK << shift;
+	unsigned int val;
+	int ret;
+
+	ret = of_property_read_u32(np, "cirrus,micbias-input", &val);
+	if (ret >= 0) {
+		mutex_lock(&lochnagar->analogue_config_lock);
+		ret = regmap_update_bits(lochnagar->regmap,
+					 LOCHNAGAR2_ANALOGUE_PATH_CTRL2,
+					 mask, val << shift);
+		mutex_unlock(&lochnagar->analogue_config_lock);
+		if (ret < 0) {
+			dev_err(lochnagar->dev,
+				"Failed to update micbias source: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct regulator_desc lochnagar_regulators[] = {
+	[LOCHNAGAR_MICVDD] = {
+		.name = "MICVDD",
+		.supply_name = "SYSVDD",
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 32,
+		.ops = &lochnagar_micvdd_ops,
+
+		.id = LOCHNAGAR_MICVDD,
+		.of_match = of_match_ptr("MICVDD"),
+
+		.enable_reg = LOCHNAGAR2_MICVDD_CTRL1,
+		.enable_mask = LOCHNAGAR2_MICVDD_REG_ENA_MASK,
+		.vsel_reg = LOCHNAGAR2_MICVDD_CTRL2,
+		.vsel_mask = LOCHNAGAR2_MICVDD_VSEL_MASK,
+
+		.linear_ranges = lochnagar_micvdd_ranges,
+		.n_linear_ranges = ARRAY_SIZE(lochnagar_micvdd_ranges),
+
+		.enable_time = 3000,
+		.ramp_delay = 1000,
+
+		.owner = THIS_MODULE,
+	},
+	[LOCHNAGAR_MIC1VDD] = {
+		.name = "MIC1VDD",
+		.supply_name = "MICBIAS1",
+		.type = REGULATOR_VOLTAGE,
+		.ops = &lochnagar_micbias_ops,
+
+		.id = LOCHNAGAR_MIC1VDD,
+		.of_match = of_match_ptr("MIC1VDD"),
+		.of_parse_cb = lochnagar_micbias_of_parse,
+
+		.enable_reg = LOCHNAGAR2_ANALOGUE_PATH_CTRL2,
+		.enable_mask = LOCHNAGAR2_P1_INPUT_BIAS_ENA_MASK,
+
+		.owner = THIS_MODULE,
+	},
+	[LOCHNAGAR_MIC2VDD] = {
+		.name = "MIC2VDD",
+		.supply_name = "MICBIAS2",
+		.type = REGULATOR_VOLTAGE,
+		.ops = &lochnagar_micbias_ops,
+
+		.id = LOCHNAGAR_MIC2VDD,
+		.of_match = of_match_ptr("MIC2VDD"),
+		.of_parse_cb = lochnagar_micbias_of_parse,
+
+		.enable_reg = LOCHNAGAR2_ANALOGUE_PATH_CTRL2,
+		.enable_mask = LOCHNAGAR2_P2_INPUT_BIAS_ENA_MASK,
+
+		.owner = THIS_MODULE,
+	},
+	[LOCHNAGAR_VDDCORE] = {
+		.name = "VDDCORE",
+		.supply_name = "SYSVDD",
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 57,
+		.ops = &lochnagar_vddcore_ops,
+
+		.id = LOCHNAGAR_VDDCORE,
+		.of_match = of_match_ptr("VDDCORE"),
+
+		.enable_reg = LOCHNAGAR2_VDDCORE_CDC_CTRL1,
+		.enable_mask = LOCHNAGAR2_VDDCORE_CDC_REG_ENA_MASK,
+		.vsel_reg = LOCHNAGAR2_VDDCORE_CDC_CTRL2,
+		.vsel_mask = LOCHNAGAR2_VDDCORE_CDC_VSEL_MASK,
+
+		.linear_ranges = lochnagar_vddcore_ranges,
+		.n_linear_ranges = ARRAY_SIZE(lochnagar_vddcore_ranges),
+
+		.enable_time = 3000,
+		.ramp_delay = 1000,
+
+		.owner = THIS_MODULE,
+	},
+};
+
+static int lochnagar_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct lochnagar *lochnagar = dev_get_drvdata(dev->parent);
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	int ret, i;
+
+	config.dev = lochnagar->dev;
+	config.regmap = lochnagar->regmap;
+	config.driver_data = lochnagar;
+
+	for (i = 0; i < ARRAY_SIZE(lochnagar_regulators); i++) {
+		const struct regulator_desc *desc = &lochnagar_regulators[i];
+
+		rdev = devm_regulator_register(dev, desc, &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
+			dev_err(dev, "Failed to register %s regulator: %d\n",
+				desc->name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static struct platform_driver lochnagar_regulator_driver = {
+	.driver = {
+		.name = "lochnagar-regulator",
+	},
+
+	.probe = lochnagar_regulator_probe,
+};
+module_platform_driver(lochnagar_regulator_driver);
+
+MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.cirrus.com>");
+MODULE_DESCRIPTION("Regulator driver for Cirrus Logic Lochnagar Board");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:lochnagar-regulator");
-- 
2.19.0

