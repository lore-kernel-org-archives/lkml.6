Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A1BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664CD2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RIdN+WK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfBAJsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:48:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40932 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbfBAJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:48:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so5447155wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/NtEr31RJV4ToQ2tRfAYSzVrKcKJn/WGW2NzkW9zf+0=;
        b=RIdN+WK00O78Aibr+mUycx0HaeoNy7dQWR26etQajKml+Aalju/RRfjFDQoaQQCJB9
         xjTGTWgwLARnIPCdVzNUsJ9OOISV/YUfgNdXO6IKu5pYUN1AwspPicORHZbUqhFLQTDp
         w3EPbmOmRsdX5rh/w24MnI/OP0NzAHZX+6DpT28GogpnV8VIer09RGictpCwPPin/thr
         W96AxmcTZDr70taezMLfSD4VBlf5u6xiUegMMmkb9UVjaLR15N2wObwtg0xnqPymqM3t
         1iLcrPgeFIKK5mLdKSIvpD3WH0PH6MNYJnUCNdYUz0/sOEmgOhgrmhsXgUm+FELJXRir
         xFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/NtEr31RJV4ToQ2tRfAYSzVrKcKJn/WGW2NzkW9zf+0=;
        b=ZR3lS41v/Eo9G5321KR0MZwGdaailCynYOsqc4py0KJNYdXvJMOivDBg0c9Mu+357E
         ED/az5hkq4JTLsY1dh4UbPk8zRPo3YkBpq3WgzFifXJuPMQaTjvYjnGfjys29AgbwPGB
         ZnfDQAX7gk9NfCfAmeNaZnO+dEbtju6cawd2ML10Qto4wsyjgBpXgObcG6asVXeyhLTC
         xB++Gt+rEfP+K8AYDX0u68us6CU301TimHEnOEsFh/E5IUgnqgd85/km7AlkQ3IjLzj8
         azgadqbikpZkd1iHLCPhTJEeoHQ3PVa3dsf24Jt307xDFPWTLV2XiSL6XzVIhqKQkmvC
         vftw==
X-Gm-Message-State: AHQUAuZzZgMPyXX0SI0dBHDv5GIcZcqiZfuKlyOk+ZPRisBqLV+paAt9
        6kUEYrpkgHa2PSL/smU1x8m+XA==
X-Google-Smtp-Source: AHgI3IbOjULTcs5pVqaJDeaNlVC/gVjrggBrASrjUskl64ylyxKwYmpUPCykpgoXw9wNewZlPBoATA==
X-Received: by 2002:a1c:e046:: with SMTP id x67mr1575463wmg.122.1549014492820;
        Fri, 01 Feb 2019 01:48:12 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m15sm9648970wrr.95.2019.02.01.01.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:48:12 -0800 (PST)
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
Subject: [PATCH v3 08/11] gpio: max77650: add GPIO support
Date:   Fri,  1 Feb 2019 10:47:33 +0100
Message-Id: <20190201094736.32057-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201094736.32057-1-brgl@bgdev.pl>
References: <20190201094736.32057-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add GPIO support for max77650 mfd device. This PMIC exposes a single
GPIO line.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/Kconfig         |   7 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-max77650.c | 189 +++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+)
 create mode 100644 drivers/gpio/gpio-max77650.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b5a2845347ec..fb297fe5bfec 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1095,6 +1095,13 @@ config GPIO_MAX77620
 	  driver also provides interrupt support for each of the gpios.
 	  Say yes here to enable the max77620 to be used as gpio controller.
 
+config GPIO_MAX77650
+	tristate "Maxim MAX77650/77651 GPIO support"
+	depends on MFD_MAX77650
+	help
+	  GPIO driver for MAX77650/77651 PMIC from Maxim Semiconductor.
+	  These chips have a single pin that can be configured as GPIO.
+
 config GPIO_MSIC
 	bool "Intel MSIC mixed signal gpio support"
 	depends on (X86 || COMPILE_TEST) && MFD_INTEL_MSIC
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 37628f8dbf70..8bdad50db822 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
 obj-$(CONFIG_GPIO_MAX7301)	+= gpio-max7301.o
 obj-$(CONFIG_GPIO_MAX732X)	+= gpio-max732x.o
 obj-$(CONFIG_GPIO_MAX77620)	+= gpio-max77620.o
+obj-$(CONFIG_GPIO_MAX77650)	+= gpio-max77650.o
 obj-$(CONFIG_GPIO_MB86S7X)	+= gpio-mb86s7x.o
 obj-$(CONFIG_GPIO_MENZ127)	+= gpio-menz127.o
 obj-$(CONFIG_GPIO_MERRIFIELD)	+= gpio-merrifield.o
diff --git a/drivers/gpio/gpio-max77650.c b/drivers/gpio/gpio-max77650.c
new file mode 100644
index 000000000000..8382dd85c548
--- /dev/null
+++ b/drivers/gpio/gpio-max77650.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 BayLibre SAS
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+//
+// GPIO driver for MAXIM 77650/77651 charger/power-supply.
+
+#include <linux/gpio/driver.h>
+#include <linux/i2c.h>
+#include <linux/mfd/max77650.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MAX77650_GPIO_DIR_MASK		BIT(0)
+#define MAX77650_GPIO_INVAL_MASK	BIT(1)
+#define MAX77650_GPIO_DRV_MASK		BIT(2)
+#define MAX77650_GPIO_OUTVAL_MASK	BIT(3)
+#define MAX77650_GPIO_DEBOUNCE_MASK	BIT(4)
+
+#define MAX77650_GPIO_DIR_OUT		0x00
+#define MAX77650_GPIO_DIR_IN		BIT(0)
+#define MAX77650_GPIO_OUT_LOW		0x00
+#define MAX77650_GPIO_OUT_HIGH		BIT(3)
+#define MAX77650_GPIO_DRV_OPEN_DRAIN	0x00
+#define MAX77650_GPIO_DRV_PUSH_PULL	BIT(2)
+#define MAX77650_GPIO_DEBOUNCE		BIT(4)
+
+#define MAX77650_GPIO_DIR_BITS(_reg) \
+		((_reg) & MAX77650_GPIO_DIR_MASK)
+#define MAX77650_GPIO_INVAL_BITS(_reg) \
+		(((_reg) & MAX77650_GPIO_INVAL_MASK) >> 1)
+
+struct max77650_gpio_chip {
+	struct regmap *map;
+	struct gpio_chip gc;
+};
+
+static int max77650_gpio_direction_input(struct gpio_chip *gc,
+					 unsigned int offset)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+
+	return regmap_update_bits(chip->map,
+				  MAX77650_REG_CNFG_GPIO,
+				  MAX77650_GPIO_DIR_MASK,
+				  MAX77650_GPIO_DIR_IN);
+}
+
+static int max77650_gpio_direction_output(struct gpio_chip *gc,
+					  unsigned int offset, int value)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	int mask, regval;
+
+	mask = MAX77650_GPIO_DIR_MASK | MAX77650_GPIO_OUTVAL_MASK;
+	regval = value ? MAX77650_GPIO_OUT_HIGH : MAX77650_GPIO_OUT_LOW;
+	regval |= MAX77650_GPIO_DIR_OUT;
+
+	return regmap_update_bits(chip->map,
+				  MAX77650_REG_CNFG_GPIO, mask, regval);
+}
+
+static void max77650_gpio_set_value(struct gpio_chip *gc,
+				    unsigned int offset, int value)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	int rv, regval;
+
+	regval = value ? MAX77650_GPIO_OUT_HIGH : MAX77650_GPIO_OUT_LOW;
+
+	rv = regmap_update_bits(chip->map, MAX77650_REG_CNFG_GPIO,
+				MAX77650_GPIO_OUTVAL_MASK, regval);
+	if (rv)
+		dev_err(gc->parent, "cannot set GPIO value: %d\n", rv);
+}
+
+static int max77650_gpio_get_value(struct gpio_chip *gc,
+				   unsigned int offset)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	unsigned int val;
+	int rv;
+
+	rv = regmap_read(chip->map, MAX77650_REG_CNFG_GPIO, &val);
+	if (rv)
+		return rv;
+
+	return MAX77650_GPIO_INVAL_BITS(val);
+}
+
+static int max77650_gpio_get_direction(struct gpio_chip *gc,
+				       unsigned int offset)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	unsigned int val;
+	int rv;
+
+	rv = regmap_read(chip->map, MAX77650_REG_CNFG_GPIO, &val);
+	if (rv)
+		return rv;
+
+	return MAX77650_GPIO_DIR_BITS(val);
+}
+
+static int max77650_gpio_set_config(struct gpio_chip *gc,
+				    unsigned int offset, unsigned long cfg)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+
+	switch (pinconf_to_config_param(cfg)) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		return regmap_update_bits(chip->map,
+					  MAX77650_REG_CNFG_GPIO,
+					  MAX77650_GPIO_DRV_MASK,
+					  MAX77650_GPIO_DRV_OPEN_DRAIN);
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		return regmap_update_bits(chip->map,
+					  MAX77650_REG_CNFG_GPIO,
+					  MAX77650_GPIO_DRV_MASK,
+					  MAX77650_GPIO_DRV_PUSH_PULL);
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		return regmap_update_bits(chip->map,
+					  MAX77650_REG_CNFG_GPIO,
+					  MAX77650_GPIO_DEBOUNCE_MASK,
+					  MAX77650_GPIO_DEBOUNCE);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int max77650_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
+{
+	/*
+	 * TODO Add interrupt support.
+	 *
+	 * We first need to properly support hierarchical irqs in gpiolib
+	 * and regmap irq_chip.
+	 */
+	return -EOPNOTSUPP;
+}
+
+static int max77650_gpio_probe(struct platform_device *pdev)
+{
+	struct max77650_gpio_chip *chip;
+	struct device *dev, *parent;
+	struct i2c_client *i2c;
+
+	dev = &pdev->dev;
+	parent = dev->parent;
+	i2c = to_i2c_client(parent);
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->map = dev_get_regmap(parent, NULL);
+	if (!chip->map)
+		return -ENODEV;
+
+	chip->gc.base = -1;
+	chip->gc.ngpio = 1;
+	chip->gc.label = i2c->name;
+	chip->gc.parent = dev;
+	chip->gc.owner = THIS_MODULE;
+	chip->gc.can_sleep = true;
+
+	chip->gc.direction_input = max77650_gpio_direction_input;
+	chip->gc.direction_output = max77650_gpio_direction_output;
+	chip->gc.set = max77650_gpio_set_value;
+	chip->gc.get = max77650_gpio_get_value;
+	chip->gc.get_direction = max77650_gpio_get_direction;
+	chip->gc.set_config = max77650_gpio_set_config;
+	chip->gc.to_irq = max77650_gpio_to_irq;
+
+	return devm_gpiochip_add_data(dev, &chip->gc, chip);
+}
+
+static struct platform_driver max77650_gpio_driver = {
+	.driver = {
+		.name = "max77650-gpio",
+	},
+	.probe = max77650_gpio_probe,
+};
+module_platform_driver(max77650_gpio_driver);
+
+MODULE_DESCRIPTION("MAXIM 77650/77651 GPIO driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

