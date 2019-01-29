Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94BEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEA621473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AFx6YF6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfA2Ngs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:36:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35240 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbfA2NgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:36:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so17961698wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gB/PvlnxJ7cgc5ND9S5qMtcljY7I1sdDozrdVgxrOqg=;
        b=AFx6YF6z4O7RiTO3KaT2cj2HtMQDx13LcR8kqoyQLS9VkrMP6bpn8OpkixwWnU+Hcd
         ixN04Px5ugVuRnf5rXkiq003sX4Q/At+/Yn/FX/jjh0IsOAdQGIiqmsMuAXHsPmv1EZs
         5+rUwJ5rjLiF1qGvI2Dbg446icgN3dsFLeN+KgMmPi1lfivmS9iuXD1z9qC7t4+hdU80
         DOJP0XCSse2u6wyTkb5OjYWqcftHKPN527SUFd/CRO8JCv5kM8zWrsA3tvf/7eNk3dbx
         Q1QMKgW97tNNh76/E3ZJfq7iInO4MR2ztKo78fbzAkQf1nfGew+SL8yP1XOr5CBZALFj
         63Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gB/PvlnxJ7cgc5ND9S5qMtcljY7I1sdDozrdVgxrOqg=;
        b=om+lKWuATriXyus5m75/njlxIkjS8X9xpNh2cdzcW1z6Sr17Q7BoBXdRzSDlHou0zZ
         oZAYS+nq6CCPenUJWsY5T6TY9ZFxjWV39PXeNEayNo0BhGfBfh06C8qV3fy/ML4ehntj
         jTTsCaxAIbhRzLzxq+nc2SlO8dKyvDcqt9OCcI7hgPTAawFyzoEg1gjBdIGC/v8op18a
         z9v3E01f1x4Jw8+tPELCgfWxQgbJNuU1MHkkr8foI1c2CvanAxqz8WOKhFUe2qPQ6/mw
         V1WQ94WHDW5SzwI0UDhZIcZ+fUSztU6vzur0NzTJZCB1siFj8Z0AcPM+pwUhH/0Q8rDB
         ++1w==
X-Gm-Message-State: AJcUukdEzC7Y/JdlVeuyv5Z5VeDkcTnzYaJzTbFDfL+a3OfDCd63pFQ6
        G3pDX9hmIVM/q5/T15nzMYfgHQ==
X-Google-Smtp-Source: ALg8bN5+h4LQ1vlb7h1HcAtXVpRpaBxHzENelRpS1WInZc4UN8okjv6jZ4szwm4YqZj0xX0p0f5TIw==
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr20574721wmf.125.1548768967937;
        Tue, 29 Jan 2019 05:36:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:36:07 -0800 (PST)
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
Subject: [PATCH v2 11/13] leds: max77650: add LEDs support
Date:   Tue, 29 Jan 2019 14:35:43 +0100
Message-Id: <20190129133545.1931-13-brgl@bgdev.pl>
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

This adds basic support for LEDs for the max77650 PMIC. The device has
three current sinks for driving LEDs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/leds/Kconfig         |   6 ++
 drivers/leds/Makefile        |   1 +
 drivers/leds/leds-max77650.c | 152 +++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
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
index 000000000000..e3a3c0e79b7a
--- /dev/null
+++ b/drivers/leds/leds-max77650.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 BayLibre SAS
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+//
+// LED driver for MAXIM 77650/77651 charger/power-supply.
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
+struct max77650_led {
+	struct led_classdev cdev;
+	struct regmap *map;
+	unsigned int regA;
+	unsigned int regB;
+};
+
+static struct max77650_led *max77650_to_led(struct led_classdev *cdev)
+{
+	return container_of(cdev, struct max77650_led, cdev);
+}
+
+static int max77650_led_brightness_set(struct led_classdev *cdev,
+				       enum led_brightness brightness)
+{
+	struct max77650_led *led = max77650_to_led(cdev);
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
+	return regmap_update_bits(led->map, led->regA, mask, val);
+}
+
+static int max77650_led_probe(struct platform_device *pdev)
+{
+	struct device_node *of_node, *child;
+	struct max77650_led *leds, *led;
+	struct device *parent;
+	struct device *dev;
+	struct regmap *map;
+	const char *label;
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
+	leds = devm_kcalloc(dev, sizeof(*leds), MAX77650_NUM_LEDS, GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	map = dev_get_regmap(dev->parent, NULL);
+	if (!map)
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
+		led = &leds[reg];
+		led->map = map;
+		led->regA = MAX77650_LED_A_BASE + reg;
+		led->regB = MAX77650_LED_B_BASE + reg;
+		led->cdev.brightness_set_blocking = max77650_led_brightness_set;
+
+		label = of_get_property(child, "label", NULL);
+		if (!label) {
+			led->cdev.name = "max77650::";
+		} else {
+			led->cdev.name = devm_kasprintf(dev, GFP_KERNEL,
+							"max77650:%s", label);
+			if (!led->cdev.name)
+				return -ENOMEM;
+		}
+
+		of_property_read_string(child, "linux,default-trigger",
+					&led->cdev.default_trigger);
+
+		rv = devm_of_led_classdev_register(dev, child, &led->cdev);
+		if (rv)
+			return rv;
+
+		rv = regmap_write(map, led->regA, MAX77650_LED_A_DEFAULT);
+		if (rv)
+			return rv;
+
+		rv = regmap_write(map, led->regB, MAX77650_LED_B_DEFAULT);
+		if (rv)
+			return rv;
+	}
+
+	return regmap_write(map,
+			    MAX77650_REG_CNFG_LED_TOP,
+			    MAX77650_LED_TOP_DEFAULT);
+}
+
+static struct platform_driver max77650_led_driver = {
+	.driver = {
+		.name = "max77650-led",
+	},
+	.probe = max77650_led_probe,
+};
+module_platform_driver(max77650_led_driver);
+
+MODULE_DESCRIPTION("MAXIM 77650/77651 LED driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

