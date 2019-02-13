Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436AFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D62218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VS/0rvWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392203AbfBMNod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:44:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38382 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391184AbfBMNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:44:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so2474076wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rid5NHIG80nLcE6uFZueY/kV3eRNwnsH4FJvdPXPfKI=;
        b=VS/0rvWpE5WL4w0JUcpXFlH98nF06Wp2vQAS3/NqiQfsGK23Sx8UxnWRRglbgqKF3C
         eRTKsni0+53Y21GNlnF8TKJGxSOHT4zEsSE4E0mpqddIYLcqqD6Tkp1nPqO9T3rddOxk
         ioBy2whT+JQxbkJ2KmjbBHycofBWRa4x9jQV+UbjcwYh5Po/Lukxh2qZ+5cqaSaztYDK
         J7OywdZc8pGCNtI4HGVPdZnzEWRtGrHfXuH3J8RhBBDEmmcDh3p+VLimkrDf8nPTerVU
         JS3zpc58tH7+k7Xa9OkTiXDuS+vjEfDL7snIUrQ5Ofg6VNw6/aa9UDee7K98Iq0E7xck
         XXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rid5NHIG80nLcE6uFZueY/kV3eRNwnsH4FJvdPXPfKI=;
        b=s2tG4PYYnbhplbqP8eAA+wXemKGfjKbAhFtRgSZZSeAuDAW7h/8eGVfX0fvJhsBQSY
         /JeqfM0yuaFu6XwLpZOo2o8njOCQ+UxTb+6H6SVH2xgwkjWQLml+3u0DvRkhzEpTZPUe
         V/faKtXELwDTuXRydVBeYz9B926V5V3bekKCLmaMQX2ULoYKb5id1rIWefx0YvK4CxvH
         qbozfhrq3OUamZUe1uk4ft4liG/YRz9Z0U12zEIz55/G0DEfAvQCCF4WbUMZw+A60KZT
         TgOlyV5nrBLq0gYcIqSpo2SvyLmtE7cjIaCtLtOF6OA0GhjQAax7qXIX2GLx8eyLlvTf
         ECEQ==
X-Gm-Message-State: AHQUAuZmL0hW+iLIHBMXI6zarapwcYXfrBiclljs3Y19NJ+DgiKiUZEX
        HhIhNCTFv6gOgsvXt1AhC8cL8bmzn3I=
X-Google-Smtp-Source: AHgI3IYCT8NW+7pzWz0iML5mjoYS+I88AYQR+YTkAsDvZJcZRDctnO0Kmq1bWpg+Mq62qX8Y6WuDOQ==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr382782wmi.140.1550065437529;
        Wed, 13 Feb 2019 05:43:57 -0800 (PST)
Received: from debian-brgl.home (amontpellier-652-1-54-116.w109-210.abo.wanadoo.fr. [109.210.45.116])
        by smtp.gmail.com with ESMTPSA id e7sm2046720wrw.35.2019.02.13.05.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:43:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 06/11] mfd: max77650: new core mfd driver
Date:   Wed, 13 Feb 2019 14:43:30 +0100
Message-Id: <20190213134335.10838-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213134335.10838-1-brgl@bgdev.pl>
References: <20190213134335.10838-1-brgl@bgdev.pl>
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
 drivers/mfd/Kconfig          |  14 +++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/max77650.c       | 234 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77650.h |  59 +++++++++
 4 files changed, 308 insertions(+)
 create mode 100644 drivers/mfd/max77650.c
 create mode 100644 include/linux/mfd/max77650.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 76f9909cf396..8965b52a8235 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -734,6 +734,20 @@ config MFD_MAX77620
 	  provides common support for accessing the device; additional drivers
 	  must be enabled in order to use the functionality of the device.
 
+config MFD_MAX77650
+	tristate "Maxim MAX77650/77651 PMIC Support"
+	depends on I2C
+	depends on OF || COMPILE_TEST
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  Say Y here to add support for Maxim Semiconductor MAX77650 and
+	  MAX77651 Power Management ICs. This is the core multifunction
+	  driver for interacting with the device. The module name is
+	  'max77650'. Additional drivers can be enabled in order to use
+	  the following functionalities of the device: GPIO, regulator,
+	  charger, LED, onkey.
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
index 000000000000..7a6c0a5cf602
--- /dev/null
+++ b/drivers/mfd/max77650.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 BayLibre SAS
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+//
+// Core MFD driver for MAXIM 77650/77651 charger/power-supply.
+// Programming manual: https://pdfserv.maximintegrated.com/en/an/AN6428.pdf
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/max77650.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
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
+enum {
+	MAX77650_INT_GPI,
+	MAX77650_INT_nEN_F,
+	MAX77650_INT_nEN_R,
+	MAX77650_INT_TJAL1_R,
+	MAX77650_INT_TJAL2_R,
+	MAX77650_INT_DOD_R,
+	MAX77650_INT_THM,
+	MAX77650_INT_CHG,
+	MAX77650_INT_CHGIN,
+	MAX77650_INT_TJ_REG,
+	MAX77650_INT_CHGIN_CTRL,
+	MAX77650_INT_SYS_CTRL,
+	MAX77650_INT_SYS_CNFG,
+};
+
+static const struct resource max77650_charger_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MAX77650_INT_CHG, "CHG"),
+	DEFINE_RES_IRQ_NAMED(MAX77650_INT_CHGIN, "CHGIN"),
+};
+
+static const struct resource max77650_gpio_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MAX77650_INT_GPI, "GPI"),
+};
+
+static const struct resource max77650_onkey_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MAX77650_INT_nEN_F, "nEN_F"),
+	DEFINE_RES_IRQ_NAMED(MAX77650_INT_nEN_R, "nEN_R"),
+};
+
+static const struct mfd_cell max77650_cells[] = {
+	{
+		.name		= "max77650-regulator",
+		.of_compatible	= "maxim,max77650-regulator",
+	},
+	{
+		.name		= "max77650-charger",
+		.of_compatible	= "maxim,max77650-charger",
+		.resources	= max77650_charger_resources,
+		.num_resources	= ARRAY_SIZE(max77650_charger_resources),
+	},
+	{
+		.name		= "max77650-gpio",
+		.of_compatible	= "maxim,max77650-gpio",
+		.resources	= max77650_gpio_resources,
+		.num_resources	= ARRAY_SIZE(max77650_gpio_resources),
+	},
+	{
+		.name		= "max77650-led",
+		.of_compatible	= "maxim,max77650-led",
+	},
+	{
+		.name		= "max77650-onkey",
+		.of_compatible	= "maxim,max77650-onkey",
+		.resources	= max77650_onkey_resources,
+		.num_resources	= ARRAY_SIZE(max77650_onkey_resources),
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
+	REGMAP_IRQ_REG(MAX77650_INT_nEN_F,
+		       MAX77650_INT_GLBL_OFFSET, MAX77650_INT_nEN_F_MSK),
+	REGMAP_IRQ_REG(MAX77650_INT_nEN_R,
+		       MAX77650_INT_GLBL_OFFSET, MAX77650_INT_nEN_R_MSK),
+	REGMAP_IRQ_REG(MAX77650_INT_TJAL1_R,
+		       MAX77650_INT_GLBL_OFFSET, MAX77650_INT_TJAL1_R_MSK),
+	REGMAP_IRQ_REG(MAX77650_INT_TJAL2_R,
+		       MAX77650_INT_GLBL_OFFSET, MAX77650_INT_TJAL2_R_MSK),
+	REGMAP_IRQ_REG(MAX77650_INT_DOD_R,
+		       MAX77650_INT_GLBL_OFFSET, MAX77650_INT_DOD_R_MSK),
+	REGMAP_IRQ_REG(MAX77650_INT_THM,
+		       MAX77650_INT_CHG_OFFSET, MAX77650_INT_THM_MSK),
+	REGMAP_IRQ_REG(MAX77650_INT_CHG,
+		       MAX77650_INT_CHG_OFFSET, MAX77650_INT_CHG_MSK),
+	REGMAP_IRQ_REG(MAX77650_INT_CHGIN,
+		       MAX77650_INT_CHG_OFFSET, MAX77650_INT_CHGIN_MSK),
+	REGMAP_IRQ_REG(MAX77650_INT_TJ_REG,
+		       MAX77650_INT_CHG_OFFSET, MAX77650_INT_TJ_REG_MSK),
+	REGMAP_IRQ_REG(MAX77650_INT_CHGIN_CTRL,
+		       MAX77650_INT_CHG_OFFSET, MAX77650_INT_CHGIN_CTRL_MSK),
+	REGMAP_IRQ_REG(MAX77650_INT_SYS_CTRL,
+		       MAX77650_INT_CHG_OFFSET, MAX77650_INT_SYS_CTRL_MSK),
+	REGMAP_IRQ_REG(MAX77650_INT_SYS_CNFG,
+		       MAX77650_INT_CHG_OFFSET, MAX77650_INT_SYS_CNFG_MSK),
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
+static int max77650_i2c_probe(struct i2c_client *i2c)
+{
+	struct regmap_irq_chip_data *irq_data;
+	struct device *dev = &i2c->dev;
+	struct irq_domain *domain;
+	struct regmap *map;
+	unsigned int val;
+	int rv;
+
+	map = devm_regmap_init_i2c(i2c, &max77650_regmap_config);
+	if (IS_ERR(map)) {
+		dev_err(dev, "unable to initialize i2c regmap\n");
+		return PTR_ERR(map);
+	}
+
+	rv = regmap_read(map, MAX77650_REG_CID, &val);
+	if (rv) {
+		dev_err(dev, "unable to read the CID from device\n");
+		return rv;
+	}
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
+	if (rv) {
+		dev_err(dev, "unable to change the power mode\n");
+		return rv;
+	}
+
+	rv = devm_regmap_add_irq_chip(dev, map, i2c->irq,
+				      IRQF_ONESHOT | IRQF_SHARED, 0,
+				      &max77650_irq_chip, &irq_data);
+	if (rv) {
+		dev_err(dev, "unable to add the regmap irq chip\n");
+		return rv;
+	}
+
+	domain = regmap_irq_get_domain(irq_data);
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				    max77650_cells, ARRAY_SIZE(max77650_cells),
+				    NULL, 0, domain);
+}
+
+static const struct of_device_id max77650_of_match[] = {
+	{ .compatible = "maxim,max77650" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77650_of_match);
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

