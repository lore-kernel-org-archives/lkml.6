Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B008C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55902086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Lw6XqOoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfARNnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:43:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46230 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfARNnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:43:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so15045698wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KkzVP3QcY5pUSFATtiQjGoFup8VMxpPvK5ZMUkSUxAM=;
        b=Lw6XqOoN9YcTWqwlXeTVIirP3LSYGHzAAX8XE3Q3Yegj6j7vGygj+/tZg9ZZ9cWnPt
         BaeUhe7ccvQZDdvKf1Qx2LoNKx9qycmsoEnJBmJzbVovZu+uBj438to/O1kFJdQocUHV
         qJ7QJcS/W03Wym7gboncZnIu8a38oiuVmGuPNZGOvRp8qNCib8ET3XNsp2DZLUa2qi61
         MN8xSDXWBmUnmGM4TV049bdtYEVd7uTCBifcAvjcPbDPhUOWZSY4JqBjkps2/utQmf1Y
         zG792rFuBv/9QMegBHiQ11tljtwtn8OrsAEVBl07VK/tOQ7ngOJUI15bkwsrlDUCxAtb
         b4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KkzVP3QcY5pUSFATtiQjGoFup8VMxpPvK5ZMUkSUxAM=;
        b=sW31vSbTDBcMVdRpwXNbMmg7TpXKEyEVSq2ACpoHL28piA3g3R2j7yWNBmceh41RqK
         yCgPS5Z3uWIKEGVTMHZLaUv68WGv6Mk3HwVRlZzaek7PFET7SRuYABgnNV46g4vPoAZT
         ReSLahr3QtUtiHZxb9fSZXKtreJtkft9WXZ8t1qZaR5QU2CDmCJUkRsrXVKOjgIT224L
         TT9hCA2F/yjw5xlYG6K7jnU/vccqfJmrS22uz0XKwPsbXz8oPYAtJaqi75mA2HQfaEjE
         yj+Ka0BI1WjG8oJNfLRaCuwayzwB3T7tufbRIXSmml9jJyLP4OPe6vlyaDtlQuRmfbUe
         NmCA==
X-Gm-Message-State: AJcUukcHahUqSdvdmRvnRy9knwuRlFlPJEfPoIQkvuHA35WiKXpyrxh/
        VncH0ZmP6OqDTyx3/d13H3P38g==
X-Google-Smtp-Source: ALg8bN4J0ZA9v9dtSVKwDj7dxnczDgJiqTwEgLyT/iQwggz7WXQX2/rNBQdF9u8Mgbo6rA4wXvDx1Q==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr16425427wro.29.1547818998916;
        Fri, 18 Jan 2019 05:43:18 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a132sm51033934wmh.5.2019.01.18.05.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:43:18 -0800 (PST)
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
Subject: [PATCH 11/13] leds: max77650: add LEDs support
Date:   Fri, 18 Jan 2019 14:42:42 +0100
Message-Id: <20190118134244.22253-12-brgl@bgdev.pl>
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

This adds basic support for LEDs for the max77650 PMIC. The device has
three current sinks for driving LEDs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/leds/Kconfig         |   6 ++
 drivers/leds/Makefile        |   1 +
 drivers/leds/leds-max77650.c | 162 +++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/leds/leds-max77650.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a72f97fca57b..6e7a8f51eccc 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -608,6 +608,12 @@ config LEDS_TLC591XX
 	  This option enables support for Texas Instruments TLC59108
 	  and TLC59116 LED controllers.
 
+config LEDS_MAX77650
+	tristate "LED support for Maxim MAX77650 PMIC"
+	depends on MFD_MAX77650
+	help
+	  LEDs driver for MAX77650 family of PMICs from Maxim Integrated."
+
 config LEDS_MAX77693
 	tristate "LED support for MAX77693 Flash"
 	depends on LEDS_CLASS_FLASH
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4c1b0054f379..f48b2404dbb7 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
 obj-$(CONFIG_LEDS_NS2)			+= leds-ns2.o
 obj-$(CONFIG_LEDS_NETXBIG)		+= leds-netxbig.o
 obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
+obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
 obj-$(CONFIG_LEDS_MAX77693)		+= leds-max77693.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_LM355x)		+= leds-lm355x.o
diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650.c
new file mode 100644
index 000000000000..be2bb1c60448
--- /dev/null
+++ b/drivers/leds/leds-max77650.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 BayLibre SAS
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ *
+ * LEDS driver for MAXIM 77650/77651 charger/power-supply.
+ */
+
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/mfd/max77650.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MAX77650_NUM_LEDS		3
+
+#define MAX77650_LED_A_BASE		0x40
+#define MAX77650_LED_B_BASE		0x43
+
+#define MAX77650_LED_BR_MASK		GENMASK(4, 0)
+#define MAX77650_LED_EN_MASK		GENMASK(7, 6)
+
+/* Enable EN_LED_MSTR. */
+#define MAX77650_LED_TOP_DEFAULT	BIT(0)
+
+#define MAX77650_LED_ENABLE		GENMASK(7, 6)
+#define MAX77650_LED_DISABLE		0x00
+
+#define MAX77650_LED_A_DEFAULT		MAX77650_LED_DISABLE
+/* 100% on duty */
+#define MAX77650_LED_B_DEFAULT		GENMASK(3, 0)
+
+struct max77650_leds;
+
+struct max77650_led {
+	struct led_classdev cdev;
+	struct max77650_leds *parent;
+	unsigned int regA;
+	unsigned int regB;
+};
+
+struct max77650_leds {
+	struct regmap *map;
+	struct max77650_led leds[MAX77650_NUM_LEDS];
+};
+
+static struct max77650_led *max77650_to_led(struct led_classdev *cdev)
+{
+	return container_of(cdev, struct max77650_led, cdev);
+}
+
+static int max77650_leds_brightness_set(struct led_classdev *cdev,
+					enum led_brightness brightness)
+{
+	struct max77650_led *led = max77650_to_led(cdev);
+	struct regmap *regmap = led->parent->map;
+	int val, mask;
+
+	mask = MAX77650_LED_BR_MASK | MAX77650_LED_EN_MASK;
+
+	if (brightness == LED_OFF) {
+		val = MAX77650_LED_DISABLE;
+	} else {
+		val = MAX77650_LED_ENABLE;
+		/*
+		 * We can set the brightness with 5-bit resolution.
+		 *
+		 * For brightness == 1, the bits we're writing will be 0, but
+		 * since we keep LED_FS0 set to 12.8mA full-scale range, the
+		 * LED will be lit slightly.
+		 */
+		val |= brightness / 8;
+	}
+
+	return regmap_update_bits(regmap, led->regA, mask, val);
+}
+
+static int max77650_leds_probe(struct platform_device *pdev)
+{
+	struct device_node *of_node, *child;
+	struct max77650_leds *leds;
+	struct max77650_led *led;
+	struct device *parent;
+	struct device *dev;
+	int rv, num_leds;
+	u32 reg;
+
+	dev = &pdev->dev;
+	parent = dev->parent;
+	of_node = dev->of_node;
+
+	if (!of_node)
+		return -ENODEV;
+
+	leds = devm_kzalloc(dev, sizeof(*leds), GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	leds->map = dev_get_regmap(dev->parent, NULL);
+	if (!leds->map)
+		return -ENODEV;
+
+	num_leds = of_get_child_count(of_node);
+	if (!num_leds || num_leds > MAX77650_NUM_LEDS)
+		return -ENODEV;
+
+	for_each_child_of_node(of_node, child) {
+		rv = of_property_read_u32(child, "reg", &reg);
+		if (rv || reg >= MAX77650_NUM_LEDS)
+			return -EINVAL;
+
+		led = &leds->leds[reg];
+
+		led->parent = leds;
+		led->regA = MAX77650_LED_A_BASE + reg;
+		led->regB = MAX77650_LED_B_BASE + reg;
+		led->cdev.brightness_set_blocking
+					= max77650_leds_brightness_set;
+
+		led->cdev.name = of_get_property(child, "label", NULL);
+		if (!led->cdev.name)
+			led->cdev.name = child->name;
+
+		of_property_read_string(child, "linux,default-trigger",
+					&led->cdev.default_trigger);
+
+		rv = devm_of_led_classdev_register(dev, child, &led->cdev);
+		if (rv)
+			return rv;
+
+		rv = regmap_write(leds->map, led->regA,
+				  MAX77650_LED_A_DEFAULT);
+		if (rv)
+			return rv;
+
+		rv = regmap_write(leds->map, led->regB,
+				  MAX77650_LED_B_DEFAULT);
+		if (rv)
+			return rv;
+	}
+
+	rv = regmap_write(leds->map,
+			  MAX77650_REG_CNFG_LED_TOP,
+			  MAX77650_LED_TOP_DEFAULT);
+	if (rv)
+		return rv;
+
+	return 0;
+}
+
+static struct platform_driver max77650_leds_driver = {
+	.driver = {
+		.name = "max77650-leds",
+	},
+	.probe = max77650_leds_probe,
+};
+module_platform_driver(max77650_leds_driver);
+
+MODULE_DESCRIPTION("MAXIM 77650/77651 LED driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_LICENSE("GPL");
-- 
2.19.1

