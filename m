Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF72C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A177D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AsjDt5QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfARNnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:43:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41626 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfARNnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:43:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so15078851wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JzjlLjy/nWMhxG251aRaszEIhdqIXSv7BiOJCo7Sexg=;
        b=AsjDt5QAFNR+xCqfIkCuMW272Xe2luLJhO4IrSfvVkcqkRNRs3uuBwzED1cW5+QQAb
         0UXjM3Blm4enRmTVq6j/fV9si6HJCHv0JJ1uAIcADZlIzXnY5b+9vYICHJXXZumvh8Ox
         Z1UUaBVnpXRGKN6uFtWngWFapd+oBgE0Wk4A77tUUExN5KxDiJQyUOMKxz9KjyCCm0p+
         hOJYKwpzXHK/99HT3YhRc7O3Q5N82ym7I1UUUzDAQ4QpDNPzQ4Sxs3tKI7NRczk6PQzT
         2xuSUC5S9N76CUfG87MxEDujOXbGL3+Fw7eJJliVPo0yA6iA4izqv8l7TnNvSZwpB4OU
         rKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JzjlLjy/nWMhxG251aRaszEIhdqIXSv7BiOJCo7Sexg=;
        b=QrnoZfkqjq2Q5459PxENnKAGtHKyDwW8yqVfz0hRl7Nx5GSmRUYVpBynGL1UdZAq5I
         GVafToMGRrXsg4bwmORtdF/AfVnx2dJt7u4FrW9bpZvseu5hmlzpwGSzFU5UijB5n30S
         oekzIEtuuEFLfdcQnOqPSI8Ap2hNm1dbUvn5wHj4nmBE9sNvRdlVI99Be4mxZqqmRNjA
         NiYDBagL16wpfHAIk7ftlPx0NLJoYpB6HH6JK0DnNog2QHZY2fTIl6qNDGjy5FS1dviR
         g79DA5LYSdXaaBtmFT6HfWWou5zWGNxf4QVc397fEH0LztZVI94S0RT4F3j9q+FcKbbo
         Z4Jg==
X-Gm-Message-State: AJcUukfyMU+TVkGwrWM/cm1LD9fe7VEgFt4+cwS6MAFcJ+ZZXTg44xxg
        BCqvxnYt3Spdz/VoDFVxKWHlDg==
X-Google-Smtp-Source: ALg8bN5xMhx99PrmKexuFBJof7nvZjYvGA2hsbv0dp7NKP0Y93q32NlT2uqvo4WNRd8Nkiy7sl2gug==
X-Received: by 2002:a5d:47d1:: with SMTP id l17mr16314659wrs.319.1547819000244;
        Fri, 18 Jan 2019 05:43:20 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a132sm51033934wmh.5.2019.01.18.05.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:43:19 -0800 (PST)
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
Subject: [PATCH 12/13] input: max77650: add onkey support
Date:   Fri, 18 Jan 2019 14:42:43 +0100
Message-Id: <20190118134244.22253-13-brgl@bgdev.pl>
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

Add support for the push- and slide-button events for max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/input/misc/Kconfig          |   9 ++
 drivers/input/misc/Makefile         |   1 +
 drivers/input/misc/max77650-onkey.c | 135 ++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 drivers/input/misc/max77650-onkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index ca59a2be9bc5..bb9c45c1269e 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -180,6 +180,15 @@ config INPUT_M68K_BEEP
 	tristate "M68k Beeper support"
 	depends on M68K
 
+config INPUT_MAX77650_ONKEY
+	tristate "Maxim MAX77650 ONKEY support"
+	depends on MFD_MAX77650
+	help
+	  Support the ONKEY of the MAX77650 PMIC as an input device.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called max77650-onkey.
+
 config INPUT_MAX77693_HAPTIC
 	tristate "MAXIM MAX77693/MAX77843 haptic controller support"
 	depends on (MFD_MAX77693 || MFD_MAX77843) && PWM
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 9d0f9d1ff68f..5bd53590ce60 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
 obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
+obj-$(CONFIG_INPUT_MAX77650_ONKEY)	+= max77650-onkey.o
 obj-$(CONFIG_INPUT_MAX77693_HAPTIC)	+= max77693-haptic.o
 obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
 obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+= max8997_haptic.o
diff --git a/drivers/input/misc/max77650-onkey.c b/drivers/input/misc/max77650-onkey.c
new file mode 100644
index 000000000000..cc7e83f589cd
--- /dev/null
+++ b/drivers/input/misc/max77650-onkey.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 BayLibre SAS
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ *
+ * ONKEY driver for MAXIM 77650/77651 charger/power-supply.
+ */
+
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max77650.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MAX77650_ONKEY_MODE_MASK	BIT(3)
+#define MAX77650_ONKEY_MODE_PUSH	0x00
+#define MAX77650_ONKEY_MODE_SLIDE	BIT(3)
+
+struct max77650_onkey {
+	struct input_dev *input;
+	unsigned int code;
+};
+
+static irqreturn_t
+max77650_onkey_report(struct max77650_onkey *onkey, int value)
+{
+	input_report_key(onkey->input, onkey->code, value);
+	input_sync(onkey->input);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t max77650_onkey_falling(int irq, void *data)
+{
+	struct max77650_onkey *onkey = data;
+
+	return max77650_onkey_report(onkey, 0);
+}
+
+static irqreturn_t max77650_onkey_rising(int irq, void *data)
+{
+	struct max77650_onkey *onkey = data;
+
+	return max77650_onkey_report(onkey, 1);
+}
+
+static int max77650_onkey_probe(struct platform_device *pdev)
+{
+	struct regmap_irq_chip_data *irq_data;
+	struct max77650_onkey *onkey;
+	struct device *dev, *parent;
+	int irq_r, irq_f, rv, mode;
+	struct i2c_client *i2c;
+	const char *mode_prop;
+	struct regmap *map;
+
+	dev = &pdev->dev;
+	parent = dev->parent;
+	i2c = to_i2c_client(parent);
+	irq_data = i2c_get_clientdata(i2c);
+
+	map = dev_get_regmap(parent, NULL);
+	if (!map)
+		return -ENODEV;
+
+	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
+
+	rv = device_property_read_u32(dev, "linux,code", &onkey->code);
+	if (rv)
+		onkey->code = KEY_POWER;
+
+	rv = device_property_read_string(dev, "maxim,onkey-mode", &mode_prop);
+	if (rv)
+		mode_prop = "push";
+
+	if (strcmp(mode_prop, "push") == 0)
+		mode = MAX77650_ONKEY_MODE_PUSH;
+	else if (strcmp(mode_prop, "slide") == 0)
+		mode = MAX77650_ONKEY_MODE_SLIDE;
+	else
+		return -EINVAL;
+
+	rv = regmap_update_bits(map, MAX77650_REG_CNFG_GLBL,
+				MAX77650_ONKEY_MODE_MASK, mode);
+	if (rv)
+		return rv;
+
+	irq_f = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_F);
+	if (irq_f <= 0)
+		return -EINVAL;
+
+	irq_r = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_R);
+	if (irq_r <= 0)
+		return -EINVAL;
+
+	onkey->input = devm_input_allocate_device(dev);
+	if (!onkey->input)
+		return -ENOMEM;
+
+	onkey->input->name = "max77650_onkey";
+	onkey->input->phys = "max77650_onkey/input0";
+	onkey->input->id.bustype = BUS_I2C;
+	onkey->input->dev.parent = dev;
+	input_set_capability(onkey->input, EV_KEY, onkey->code);
+
+	rv = devm_request_threaded_irq(dev, irq_f, NULL,
+				       max77650_onkey_falling,
+				       IRQF_ONESHOT, "onkey-down", onkey);
+	if (rv)
+		return rv;
+
+	rv = devm_request_threaded_irq(dev, irq_r, NULL,
+				       max77650_onkey_rising,
+				       IRQF_ONESHOT, "onkey-up", onkey);
+	if (rv)
+		return rv;
+
+	return input_register_device(onkey->input);
+}
+
+static struct platform_driver max77650_onkey_driver = {
+	.driver = {
+		.name = "max77650-onkey",
+	},
+	.probe = max77650_onkey_probe,
+};
+module_platform_driver(max77650_onkey_driver);
+
+MODULE_DESCRIPTION("MAXIM 77650/77651 ONKEY driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_LICENSE("GPL");
-- 
2.19.1

