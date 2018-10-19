Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01097ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997E520645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997E520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeJSRzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:55:35 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60374 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbeJSRzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:55:35 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9J9nq6q018797;
        Fri, 19 Oct 2018 04:50:05 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2n3es40mhc-1;
        Fri, 19 Oct 2018 04:50:05 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 1A6BD611C8B8;
        Fri, 19 Oct 2018 04:52:56 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Oct 2018
 10:50:03 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9J9o3p1015276; Fri,
 19 Oct 2018 10:50:04 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH v3 4/5] regulator: lochnagar: Add support for the Cirrus Logic Lochnagar
Date:   Fri, 19 Oct 2018 10:50:02 +0100
Message-ID: <20181019095003.26046-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181019095003.26046-1-ckeepax@opensource.cirrus.com>
References: <20181019095003.26046-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810190090
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

The Lochnagar board provides power supplies for the attached
CODEC/Amp device. Currently this driver supports the microphone
supplies and the digital core voltage for the attached
device. There are some additional supplies that will be
added in time but these supplies are sufficient for most
systems/use-cases.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

Thanks,
Charles

 drivers/regulator/Kconfig               |   7 +
 drivers/regulator/Makefile              |   1 +
 drivers/regulator/lochnagar-regulator.c | 255 ++++++++++++++++++++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 drivers/regulator/lochnagar-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 329cdd33ed624..3eda02afdcdeb 100644
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
index 801d9a34a2037..0c715fa77bd62 100644
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
index 0000000000000..54d791d204080
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
2.11.0

