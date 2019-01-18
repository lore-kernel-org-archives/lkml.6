Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD8EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BB52086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="flQ6VtVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfARNoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:44:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44489 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfARNnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:43:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so15073716wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wsnUGK4UHoSna5kTVgP08aV1SP3zq1Xo1uh/gsnCFl8=;
        b=flQ6VtVTEWW2m166wpDStmjiOvQ3K/ZbN8wg2/c8vM4oxscllSsKabuM/UTdSciXqn
         NXzob1l9h9TlRn3haTULILT5iqT3otsGgjV04fEHuZhWthM52sl+IhNYu+6xKYneAn45
         G2vJAtolWHJwEKUU/ksfze1PVdh3qaCdCYIkGv5hNLkRlJV2XyiKIYQK7LeRb3qwdwo3
         hTQCpH0DK9NdrN787QZ5jsVKiBmOx0zM8GqCVbUNEsL+bE19od/dB6Efd5bQsTLYkQ8b
         6h/Mpt+wPjD/bGhL0QBXGCpCBDaDbySfT1Un96zLEX3foBge/d7KO9f7vtULru9VlREe
         Oz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsnUGK4UHoSna5kTVgP08aV1SP3zq1Xo1uh/gsnCFl8=;
        b=YYZlavgZK/7bazooJYCIFpdA4fmD/3/SjyD1q0uvFlnAO9baraNMD3WIaADTOSKMzr
         nYli6n28IL1gxM4YMd4VW45O9OjL0S8DG9oambcq2+qQXKNp7fHSo88VCpVsHtOGlK8x
         8YyDsnkMK3QQNA7QFLld24XBslq6+Kf6Qxo1IGwEvJ58oHCvwCbRrg0lFwe378gSn8M8
         XQQL1YuGrhlDSXaEiWCEfYgbmRAVFfBMusWfdDux0uZngKUnbURuLXaFWSMpEiNWKem/
         DC30DjAukq/TQ3A3wEuiTC7S/+KyMYSWb9g+CMMl9xfimsGsfBAraxGmrRqsrBgKN06j
         kc0Q==
X-Gm-Message-State: AJcUukeCPfAQEAXapsaJONmd+eLSt80qyrRYzBy97E+AS4Zr/TnWd7Ei
        OsuHrnVY/e8031VRJHSE+Z1RfQ==
X-Google-Smtp-Source: ALg8bN7FnmhIuDR0RReKQBT9JxM5l7Oy4GIn0hLvwU7zvbzZg0KzMKdcFE2X2mxCnjx9/WZXAbzqLw==
X-Received: by 2002:adf:8c09:: with SMTP id z9mr16632824wra.301.1547818993411;
        Fri, 18 Jan 2019 05:43:13 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a132sm51033934wmh.5.2019.01.18.05.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:43:12 -0800 (PST)
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
Subject: [PATCH 07/13] mfd: max77650: new core mfd driver
Date:   Fri, 18 Jan 2019 14:42:38 +0100
Message-Id: <20190118134244.22253-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190118134244.22253-1-brgl@bgdev.pl>
References: <20190118134244.22253-1-brgl@bgdev.pl>
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
 drivers/mfd/max77650.c       | 212 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77650.h |  73 ++++++++++++
 4 files changed, 297 insertions(+)
 create mode 100644 drivers/mfd/max77650.c
 create mode 100644 include/linux/mfd/max77650.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8c5dfdce4326..dd4dcd97fe21 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -733,6 +733,17 @@ config MFD_MAX77620
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
index 000000000000..9c769570b491
--- /dev/null
+++ b/drivers/mfd/max77650.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 BayLibre SAS
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ *
+ * Core MFD driver for MAXIM 77650/77651 charger/power-supply.
+ */
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
+static const struct mfd_cell max77650_devs[] = {
+	{
+		.name		= "max77650-regulator",
+		.of_compatible	= "maxim,max77650-regulator",
+	},
+	{
+		.name		= "max77650-charger",
+		.of_compatible	= "maxim,max77650-charger",
+	},
+	{
+		.name		= "max77650-gpio",
+		.of_compatible	= "maxim,max77650-gpio",
+	},
+	{
+		.name		= "max77650-leds",
+		.of_compatible	= "maxim,max77650-leds",
+	},
+	{
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
+static struct regmap_irq_chip max77650_irq_chip = {
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
+	max77650_irq_chip.irq_drv_data = map;
+	rv = devm_regmap_add_irq_chip(dev, map, i2c->irq,
+				      IRQF_ONESHOT | IRQF_SHARED,
+				      -1, &max77650_irq_chip, &irq_data);
+	if (rv)
+		return rv;
+
+	i2c_set_clientdata(i2c, irq_data);
+
+	return devm_mfd_add_devices(dev, -1, max77650_devs,
+				    ARRAY_SIZE(max77650_devs), NULL, 0, NULL);
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
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/max77650.h b/include/linux/mfd/max77650.h
new file mode 100644
index 000000000000..841bbccdd5ad
--- /dev/null
+++ b/include/linux/mfd/max77650.h
@@ -0,0 +1,73 @@
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
+#endif /* MAX77650_H */
-- 
2.19.1

