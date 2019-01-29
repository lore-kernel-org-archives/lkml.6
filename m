Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BABC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6788F21473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MKBtWMha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfA2NgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:36:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46907 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfA2NgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:36:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so22027894wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Uz4p5BRGBIxfLvmJ5JMoG8PgareAwliY2QrioAL/Kc=;
        b=MKBtWMhaI8R4QWIIc1WjLk+xItsC1ceZQosAG33RO77WhnavR2NTLQjsJik9AuL7oC
         f/3WkAM8iXqGkhgssZBVA9MpYcUtJcCWqbCnO0VqYlmnmuFqBjQ9WDlOVxK/KBDsJuMJ
         0yTzESA51Eg+/3EWuXoa6ftZwuBolVFmdw1K5Rk3PDb4yec62BeygisMH71KIg8wpm0j
         854POSMAxP/qekPGABoBtN7yrS2uOfCpitFfdeF5pVkx0H3b58AoJljd2HLbt4uOUOiI
         o9lGLrzxkphZm78rwwahuLqmBbsL5S2vYqOGBfyKt9xGYzTaooOkazW+LIf68ItMeVLj
         DFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Uz4p5BRGBIxfLvmJ5JMoG8PgareAwliY2QrioAL/Kc=;
        b=PQZyE1UbDK5DpFKB4ZzFZ3JgdDs+cWwDNHxEstb0VB+uBiuEjheJGttQfsGEXdQJwC
         I+FVQhA2tNDJoi7THZCivOzShj5MEVouUlr9Ou5dSC6HtZwRhDaOHM+mNvOs8dauN08q
         2m6dJqVp9tfRJU6QjjO+pp5E8XaBJs1OyNa0MMB4sYgtivC2ZTb6wFwJytFBMGZKQY7r
         WdBpMA3xJWPPhqqiD87lCQogK3gHHLx3cq8IKK0Trwr5j0FdX9qOTuLfhxy1bHE1Ovux
         HhSDAURXhFWf09oM7MyugRtyOdyKl8cUsar0axBk82oEtCsqBx9s5MzDbfJ7wFSKUyEu
         1s6g==
X-Gm-Message-State: AJcUukfzLyT3N6SFCJHqZOj8ksaJ51CNHeluZXl0/r9T3DSNcSaQRF2U
        42XejX55L7MwcWikFby3a4MONw==
X-Google-Smtp-Source: ALg8bN7jfQhMdgI5uT/m68NGLsMn1X/bfb3sP9FGG6DKm27VVvYqUAiZyRT2bY7PA++EUDJTdWlX1A==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr24692089wrj.91.1548768963584;
        Tue, 29 Jan 2019 05:36:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:36:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 08/13] regulator: max77650: add regulator support
Date:   Tue, 29 Jan 2019 14:35:40 +0100
Message-Id: <20190129133545.1931-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129133545.1931-1-brgl@bgdev.pl>
References: <20190129133545.1931-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add regulator support for max77650. We support all four variants of this
PMIC including non-linear voltage table for max77651 SBB1 rail.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/regulator/Kconfig              |   8 +
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max77650-regulator.c | 518 +++++++++++++++++++++++++
 3 files changed, 527 insertions(+)
 create mode 100644 drivers/regulator/max77650-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index ee60a222f5eb..514f094f9444 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -457,6 +457,14 @@ config REGULATOR_MAX77620
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
index b12e1c9b2118..7de79a12b0b7 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
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

