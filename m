Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D02C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6305621473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QnNYqSJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfA2NgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:36:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42493 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfA2NgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:36:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so22076503wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yw2JjOZC85yn++yjg0WGas3pNLXh1Y0xaBxzic15/M0=;
        b=QnNYqSJWcAMCNPZ6V3guXHKuUCbnBT4Gfg8hkpxf4ZgLuBxC0DxUJ7sTmBbspBRwKJ
         EhAVup/2RGm8J7a3FxLiptO8rSUyzbAfIbmZnSHDqx9mnu6qKgjU346efm6bPuPnHpdZ
         hSSdqzQ2KIhx4nuoWJMZfa2jxtfzfm5FyaSo4vqbqYFXmSdwedBtfYIONypL/XSVeAfO
         8gw6fMz5aRQqMGvPJWqBCIwbh6s++kytPbSnwrvPoHhz6GoLPv3xycBDtKygqNxF+ZE+
         UCzz3uU5SfrAk4xAg6zvS3XjIKrwJ9AEJTej27UpZ91GGCUg6edywarXUwU2bppgM11U
         fLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yw2JjOZC85yn++yjg0WGas3pNLXh1Y0xaBxzic15/M0=;
        b=ZDz+ox4PwBzl9KHYUsNVNw0tsij/UteXb0VKa5v2Esl3eF85qH0B/epvqY6+VyNSzs
         RpvILS2Eb92ipvHBDjGj8SsudU8VLkTGnVcoz3cAdedB/86S2iZEwQ/asUVtFADafoNc
         zG0+PwXIt7UMVFUmHLvub6WwVbivuIuK7C+nY46LOahd38lvVGGdseYFhxT8u9aRdgqC
         VpRbBxZIebZmM+TlFxvG8fUq9ArltalkwFwNveqzZBUEKMJw4UW3EIN2BC5LQXzVEQIo
         Ak6yC27OzXsQfcQgJx84e1paP3HxydSK3rgmH4rNgEabeCWdK6ZwKkIBXU4SjPDvJHil
         mVHA==
X-Gm-Message-State: AJcUukc60miiB9a5pcRoGkJBhp7DR6fBDYdW0N0otxPwyVrqAegk/pWc
        E0HpRsv26wfau3aN5YrM7t6EAw==
X-Google-Smtp-Source: ALg8bN7roapfuin6hn6cDJ0NJA+4QlgC0ONSvS/uOcSqp01p/2lfebf/jmqz8o9hA/OX9O9Q6ujKsg==
X-Received: by 2002:adf:9083:: with SMTP id i3mr25670060wri.124.1548768962174;
        Tue, 29 Jan 2019 05:36:02 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:36:01 -0800 (PST)
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
Subject: [PATCH v2 07/13] mfd: max77650: new core mfd driver
Date:   Tue, 29 Jan 2019 14:35:39 +0100
Message-Id: <20190129133545.1931-9-brgl@bgdev.pl>
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

Add the core mfd driver for max77650 PMIC. We define five sub-devices
for which the drivers will be added in subsequent patches.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mfd/Kconfig          |  11 ++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/max77650.c       | 338 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77650.h |  59 ++++++
 4 files changed, 409 insertions(+)
 create mode 100644 drivers/mfd/max77650.c
 create mode 100644 include/linux/mfd/max77650.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f461460a2aeb..828fd193b4ee 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -734,6 +734,17 @@ config MFD_MAX77620
 	  provides common support for accessing the device; additional drivers
 	  must be enabled in order to use the functionality of the device.
 
+config MFD_MAX77650
+	tristate "Maxim MAX77650/77651 PMIC Support"
+	depends on I2C
+	depends on OF || COMPILE_TEST
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  Say yes here to add support for Maxim Semiconductor MAX77650 and
+	  MAX77651 Power Management ICs. This is the core multifunction
+	  driver for interacting with the device.
+
 config MFD_MAX77686
 	tristate "Maxim Semiconductor MAX77686/802 PMIC Support"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 12980a4ad460..3b912a4015d1 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -151,6 +151,7 @@ obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
 
 obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
 obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
+obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
 obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
 obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
 obj-$(CONFIG_MFD_MAX77843)	+= max77843.o
diff --git a/drivers/mfd/max77650.c b/drivers/mfd/max77650.c
new file mode 100644
index 000000000000..a89a5ea421f8
--- /dev/null
+++ b/drivers/mfd/max77650.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 BayLibre SAS
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+//
+// Core MFD driver for MAXIM 77650/77651 charger/power-supply.
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/max77650.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define MAX77650_INT_GPI_F_MSK		BIT(0)
+#define MAX77650_INT_GPI_R_MSK		BIT(1)
+#define MAX77650_INT_GPI_MSK \
+			(MAX77650_INT_GPI_F_MSK | MAX77650_INT_GPI_R_MSK)
+#define MAX77650_INT_nEN_F_MSK		BIT(2)
+#define MAX77650_INT_nEN_R_MSK		BIT(3)
+#define MAX77650_INT_TJAL1_R_MSK	BIT(4)
+#define MAX77650_INT_TJAL2_R_MSK	BIT(5)
+#define MAX77650_INT_DOD_R_MSK		BIT(6)
+
+#define MAX77650_INT_THM_MSK		BIT(0)
+#define MAX77650_INT_CHG_MSK		BIT(1)
+#define MAX77650_INT_CHGIN_MSK		BIT(2)
+#define MAX77650_INT_TJ_REG_MSK		BIT(3)
+#define MAX77650_INT_CHGIN_CTRL_MSK	BIT(4)
+#define MAX77650_INT_SYS_CTRL_MSK	BIT(5)
+#define MAX77650_INT_SYS_CNFG_MSK	BIT(6)
+
+#define MAX77650_INT_GLBL_OFFSET	0
+#define MAX77650_INT_CHG_OFFSET		1
+
+#define MAX77650_SBIA_LPM_MASK		BIT(5)
+#define MAX77650_SBIA_LPM_DISABLED	0x00
+
+#define MAX77650_INT_GPI		0
+#define MAX77650_INT_nEN_F		1
+#define MAX77650_INT_nEN_R		2
+#define MAX77650_INT_TJAL1_R		3
+#define MAX77650_INT_TJAL2_R		4
+#define MAX77650_INT_DOD_R		5
+#define MAX77650_INT_THM		6
+#define MAX77650_INT_CHG		7
+#define MAX77650_INT_CHGIN		8
+#define MAX77650_INT_TJ_REG		9
+#define MAX77650_INT_CHGIN_CTRL		10
+#define MAX77650_INT_SYS_CTRL		11
+#define MAX77650_INT_SYS_CNFG		12
+
+enum {
+	MAX77650_CELL_REGULATOR = 0,
+	MAX77650_CELL_CHARGER,
+	MAX77650_CELL_GPIO,
+	MAX77650_CELL_LED,
+	MAX77650_CELL_ONKEY,
+	MAX77650_NUM_CELLS,
+};
+
+struct max77650_irq_mapping {
+	int cell_num;
+	const int *irqs;
+	const char **irq_names;
+	unsigned int num_irqs;
+};
+
+static const int max77650_charger_irqs[] = {
+	MAX77650_INT_CHG,
+	MAX77650_INT_CHGIN,
+};
+
+static const int max77650_gpio_irqs[] = {
+	MAX77650_INT_GPI,
+};
+
+static const int max77650_onkey_irqs[] = {
+	MAX77650_INT_nEN_F,
+	MAX77650_INT_nEN_R,
+};
+
+static const char *max77650_charger_irq_names[] = {
+	"CHG",
+	"CHGIN",
+};
+
+static const char *max77650_gpio_irq_names[] = {
+	"GPI",
+};
+
+static const char *max77650_onkey_irq_names[] = {
+	"nEN_F",
+	"nEN_R",
+};
+
+static const struct max77650_irq_mapping max77650_irq_mapping_table[] = {
+	{
+		.cell_num	= MAX77650_CELL_CHARGER,
+		.irqs		= max77650_charger_irqs,
+		.irq_names	= max77650_charger_irq_names,
+		.num_irqs	= ARRAY_SIZE(max77650_charger_irqs),
+	},
+	{
+		.cell_num	= MAX77650_CELL_GPIO,
+		.irqs		= max77650_gpio_irqs,
+		.irq_names	= max77650_gpio_irq_names,
+		.num_irqs	= ARRAY_SIZE(max77650_gpio_irqs),
+	},
+	{
+		.cell_num	= MAX77650_CELL_ONKEY,
+		.irqs		= max77650_onkey_irqs,
+		.irq_names	= max77650_onkey_irq_names,
+		.num_irqs	= ARRAY_SIZE(max77650_onkey_irqs),
+	},
+};
+
+static const struct mfd_cell max77650_cells[] = {
+	[MAX77650_CELL_REGULATOR] = {
+		.name		= "max77650-regulator",
+		.of_compatible	= "maxim,max77650-regulator",
+	},
+	[MAX77650_CELL_CHARGER] = {
+		.name		= "max77650-charger",
+		.of_compatible	= "maxim,max77650-charger",
+	},
+	[MAX77650_CELL_GPIO] = {
+		.name		= "max77650-gpio",
+		.of_compatible	= "maxim,max77650-gpio",
+	},
+	[MAX77650_CELL_LED] = {
+		.name		= "max77650-led",
+		.of_compatible	= "maxim,max77650-led",
+	},
+	[MAX77650_CELL_ONKEY] = {
+		.name		= "max77650-onkey",
+		.of_compatible	= "maxim,max77650-onkey",
+	},
+};
+
+static const struct regmap_irq max77650_irqs[] = {
+	[MAX77650_INT_GPI] = {
+		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
+		.mask			= MAX77650_INT_GPI_MSK,
+		.type = {
+			.type_falling_val	= MAX77650_INT_GPI_F_MSK,
+			.type_rising_val	= MAX77650_INT_GPI_R_MSK,
+			.types_supported	= IRQ_TYPE_EDGE_BOTH,
+		},
+	},
+	[MAX77650_INT_nEN_F] = {
+		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
+		.mask			= MAX77650_INT_nEN_F_MSK,
+	},
+	[MAX77650_INT_nEN_R] = {
+		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
+		.mask			= MAX77650_INT_nEN_R_MSK,
+	},
+	[MAX77650_INT_TJAL1_R] = {
+		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
+		.mask			= MAX77650_INT_TJAL1_R_MSK,
+	},
+	[MAX77650_INT_TJAL2_R] = {
+		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
+		.mask			= MAX77650_INT_TJAL2_R_MSK,
+	},
+	[MAX77650_INT_DOD_R] = {
+		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
+		.mask			= MAX77650_INT_DOD_R_MSK,
+	},
+	[MAX77650_INT_THM] = {
+		.reg_offset		= MAX77650_INT_CHG_OFFSET,
+		.mask			= MAX77650_INT_THM_MSK,
+	},
+	[MAX77650_INT_CHG] = {
+		.reg_offset		= MAX77650_INT_CHG_OFFSET,
+		.mask			= MAX77650_INT_CHG_MSK,
+	},
+	[MAX77650_INT_CHGIN] = {
+		.reg_offset		= MAX77650_INT_CHG_OFFSET,
+		.mask			= MAX77650_INT_CHGIN_MSK,
+	},
+	[MAX77650_INT_TJ_REG] = {
+		.reg_offset		= MAX77650_INT_CHG_OFFSET,
+		.mask			= MAX77650_INT_TJ_REG_MSK,
+	},
+	[MAX77650_INT_CHGIN_CTRL] = {
+		.reg_offset		= MAX77650_INT_CHG_OFFSET,
+		.mask			= MAX77650_INT_CHGIN_CTRL_MSK,
+	},
+	[MAX77650_INT_SYS_CTRL] = {
+		.reg_offset		= MAX77650_INT_CHG_OFFSET,
+		.mask			= MAX77650_INT_SYS_CTRL_MSK,
+	},
+	[MAX77650_INT_SYS_CNFG] = {
+		.reg_offset		= MAX77650_INT_CHG_OFFSET,
+		.mask			= MAX77650_INT_SYS_CNFG_MSK,
+	},
+};
+
+static const struct regmap_irq_chip max77650_irq_chip = {
+	.name			= "max77650-irq",
+	.irqs			= max77650_irqs,
+	.num_irqs		= ARRAY_SIZE(max77650_irqs),
+	.num_regs		= 2,
+	.status_base		= MAX77650_REG_INT_GLBL,
+	.mask_base		= MAX77650_REG_INTM_GLBL,
+	.type_in_mask		= true,
+	.type_invert		= true,
+	.init_ack_masked	= true,
+	.clear_on_unmask	= true,
+};
+
+static const struct regmap_config max77650_regmap_config = {
+	.name		= "max77650",
+	.reg_bits	= 8,
+	.val_bits	= 8,
+};
+
+static int max77650_setup_irqs(struct device *dev, struct mfd_cell *cells)
+{
+	const struct max77650_irq_mapping *mapping;
+	struct regmap_irq_chip_data *irq_data;
+	struct i2c_client *i2c;
+	struct mfd_cell *cell;
+	struct resource *res;
+	struct regmap *map;
+	int i, j, irq, rv;
+
+	i2c = to_i2c_client(dev);
+
+	map = dev_get_regmap(dev, NULL);
+	if (!map)
+		return -ENODEV;
+
+	rv = devm_regmap_add_irq_chip(dev, map, i2c->irq,
+				      IRQF_ONESHOT | IRQF_SHARED, -1,
+				      &max77650_irq_chip, &irq_data);
+	if (rv)
+		return rv;
+
+	for (i = 0; i < ARRAY_SIZE(max77650_irq_mapping_table); i++) {
+		mapping = &max77650_irq_mapping_table[i];
+		cell = &cells[mapping->cell_num];
+
+		res = devm_kcalloc(dev, sizeof(*res),
+				   mapping->num_irqs, GFP_KERNEL);
+		if (!res)
+			return -ENOMEM;
+
+		cell->resources = res;
+		cell->num_resources = mapping->num_irqs;
+
+		for (j = 0; j < mapping->num_irqs; j++) {
+			irq = regmap_irq_get_virq(irq_data, mapping->irqs[j]);
+			if (irq < 0)
+				return irq;
+
+			res[j].start = res[j].end = irq;
+			res[j].flags = IORESOURCE_IRQ;
+			res[j].name = mapping->irq_names[j];
+		}
+	}
+
+	return 0;
+}
+
+static int max77650_i2c_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct mfd_cell *cells;
+	struct regmap *map;
+	unsigned int val;
+	int rv;
+
+	map = devm_regmap_init_i2c(i2c, &max77650_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	rv = regmap_read(map, MAX77650_REG_CID, &val);
+	if (rv)
+		return rv;
+
+	switch (MAX77650_CID_BITS(val)) {
+	case MAX77650_CID_77650A:
+	case MAX77650_CID_77650C:
+	case MAX77650_CID_77651A:
+	case MAX77650_CID_77651B:
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	/*
+	 * This IC has a low-power mode which reduces the quiescent current
+	 * consumption to ~5.6uA but is only suitable for systems consuming
+	 * less than ~2mA. Since this is not likely the case even on
+	 * linux-based wearables - keep the chip in normal power mode.
+	 */
+	rv = regmap_update_bits(map,
+				MAX77650_REG_CNFG_GLBL,
+				MAX77650_SBIA_LPM_MASK,
+				MAX77650_SBIA_LPM_DISABLED);
+	if (rv)
+		return rv;
+
+	cells = devm_kmemdup(dev, max77650_cells,
+			     sizeof(max77650_cells), GFP_KERNEL);
+	if (!cells)
+		return -ENOMEM;
+
+	rv = max77650_setup_irqs(dev, cells);
+	if (rv)
+		return rv;
+
+	return devm_mfd_add_devices(dev, -1, cells,
+				    MAX77650_NUM_CELLS, NULL, 0, NULL);
+}
+
+static const struct of_device_id max77650_of_match[] = {
+	{ .compatible = "maxim,max77650", },
+};
+
+static struct i2c_driver max77650_i2c_driver = {
+	.driver = {
+		.name = "max77650",
+		.of_match_table = of_match_ptr(max77650_of_match),
+	},
+	.probe_new = max77650_i2c_probe,
+};
+module_i2c_driver(max77650_i2c_driver);
+
+MODULE_DESCRIPTION("MAXIM 77650/77651 multi-function core driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/max77650.h b/include/linux/mfd/max77650.h
new file mode 100644
index 000000000000..c809e211a8cd
--- /dev/null
+++ b/include/linux/mfd/max77650.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 BayLibre SAS
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ *
+ * Common definitions for MAXIM 77650/77651 charger/power-supply.
+ */
+
+#ifndef MAX77650_H
+#define MAX77650_H
+
+#include <linux/bits.h>
+
+#define MAX77650_REG_INT_GLBL		0x00
+#define MAX77650_REG_INT_CHG		0x01
+#define MAX77650_REG_STAT_CHG_A		0x02
+#define MAX77650_REG_STAT_CHG_B		0x03
+#define MAX77650_REG_ERCFLAG		0x04
+#define MAX77650_REG_STAT_GLBL		0x05
+#define MAX77650_REG_INTM_GLBL		0x06
+#define MAX77650_REG_INTM_CHG		0x07
+#define MAX77650_REG_CNFG_GLBL		0x10
+#define MAX77650_REG_CID		0x11
+#define MAX77650_REG_CNFG_GPIO		0x12
+#define MAX77650_REG_CNFG_CHG_A		0x18
+#define MAX77650_REG_CNFG_CHG_B		0x19
+#define MAX77650_REG_CNFG_CHG_C		0x1a
+#define MAX77650_REG_CNFG_CHG_D		0x1b
+#define MAX77650_REG_CNFG_CHG_E		0x1c
+#define MAX77650_REG_CNFG_CHG_F		0x1d
+#define MAX77650_REG_CNFG_CHG_G		0x1e
+#define MAX77650_REG_CNFG_CHG_H		0x1f
+#define MAX77650_REG_CNFG_CHG_I		0x20
+#define MAX77650_REG_CNFG_SBB_TOP	0x28
+#define MAX77650_REG_CNFG_SBB0_A	0x29
+#define MAX77650_REG_CNFG_SBB0_B	0x2a
+#define MAX77650_REG_CNFG_SBB1_A	0x2b
+#define MAX77650_REG_CNFG_SBB1_B	0x2c
+#define MAX77650_REG_CNFG_SBB2_A	0x2d
+#define MAX77650_REG_CNFG_SBB2_B	0x2e
+#define MAX77650_REG_CNFG_LDO_A		0x38
+#define MAX77650_REG_CNFG_LDO_B		0x39
+#define MAX77650_REG_CNFG_LED0_A	0x40
+#define MAX77650_REG_CNFG_LED1_A	0x41
+#define MAX77650_REG_CNFG_LED2_A	0x42
+#define MAX77650_REG_CNFG_LED0_B	0x43
+#define MAX77650_REG_CNFG_LED1_B	0x44
+#define MAX77650_REG_CNFG_LED2_B	0x45
+#define MAX77650_REG_CNFG_LED_TOP	0x46
+
+#define MAX77650_CID_MASK		GENMASK(3, 0)
+#define MAX77650_CID_BITS(_reg)		(_reg & MAX77650_CID_MASK)
+
+#define MAX77650_CID_77650A		0x03
+#define MAX77650_CID_77650C		0x0a
+#define MAX77650_CID_77651A		0x06
+#define MAX77650_CID_77651B		0x08
+
+#endif /* MAX77650_H */
-- 
2.20.1

