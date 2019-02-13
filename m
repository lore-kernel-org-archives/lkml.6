Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ACEC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F26222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WRJp4292"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391332AbfBMNoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:44:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43814 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391211AbfBMNoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:44:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id r2so2518788wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+vwDcYDMNaEM9X+6Hq4e58zhVSF+acGNIMoeTvXQQHM=;
        b=WRJp4292P8ftHO1weosDSB+sYorAXl2Wgc6t1La/R9i/mCwbY7lpq8fB+fHpLCBAmc
         cvz4LaTaU8XqJQh5CLb0HxRsuAAd+mTr9+LjzDxnopjNFVP0gmTMdinyT72BN0HNzH3t
         uOivS/ubSiJh/JFsKGEt+22XiiqvjiPng0mbwnrr+ViT/5YN/fH9rwpKS2RSjtOVU74r
         oS+LYIb5WzWxzT8poowAkCewGaznU9NlXCu9RBTe/X7ZEd92lfRXDBu/CPxz1oHgk+hh
         zBRk9AEqjlQ2OnhyU4G6ZTsDVQtynqCJP86tCLfS3yCSpeKwGaq/h7oifueyZBITJn/6
         PrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vwDcYDMNaEM9X+6Hq4e58zhVSF+acGNIMoeTvXQQHM=;
        b=E9U9K3aZIOKnYnjWYEuIfc50eqIVrHHNxOEQPq12osPJmXV4S1F8Ox1WDMOkJkakdF
         Im5lXdAgC4CovJqQ1pt91X94MICH/QStBahJ+1IBl5EzYc1b1hkUkOeFHc8ydZRSVP46
         K1UkoeeOB6FdiW9VNA4Njbb4lZNy5/Nzuaw1tQdEZOZwd8S3a1WN65PMLGTfC7X3kNAr
         RizsuxuIzWNkfJ7gSJuCjhRkgh34d/ZH5gYwCANgC26HrmroO5NJeiEYb4fgTo1uwEq/
         m32BTzal3faW08p/wiqBy7epV1PKcWdUdPwbq2ZEh4Dd5+6KzqVHqU9vh+mzDe9dxXV/
         AuNg==
X-Gm-Message-State: AHQUAua9QUl42L62qnH41xsHq9OmcaMfCSI378Rme4xYrFReCFGJmY0y
        wBMSHEGzFvbIb8LQZHjXTchHqg==
X-Google-Smtp-Source: AHgI3Iadx6QBxMVtVKD+zy9LA9362p0pGm4eMszZ1/mlEjbEcVqguxZ0aW46jRwzS1KlifkNj7jBQw==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr464254wrq.31.1550065443139;
        Wed, 13 Feb 2019 05:44:03 -0800 (PST)
Received: from debian-brgl.home (amontpellier-652-1-54-116.w109-210.abo.wanadoo.fr. [109.210.45.116])
        by smtp.gmail.com with ESMTPSA id e7sm2046720wrw.35.2019.02.13.05.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:44:02 -0800 (PST)
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
Subject: [PATCH v5 10/11] input: max77650: add onkey support
Date:   Wed, 13 Feb 2019 14:43:34 +0100
Message-Id: <20190213134335.10838-11-brgl@bgdev.pl>
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

Add support for the push- and slide-button events for max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/Kconfig          |   9 ++
 drivers/input/misc/Makefile         |   1 +
 drivers/input/misc/max77650-onkey.c | 131 ++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
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
index 000000000000..4605c18b37ca
--- /dev/null
+++ b/drivers/input/misc/max77650-onkey.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 BayLibre SAS
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+//
+// ONKEY driver for MAXIM 77650/77651 charger/power-supply.
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
+static irqreturn_t max77650_onkey_falling(int irq, void *data)
+{
+	struct max77650_onkey *onkey = data;
+
+	input_report_key(onkey->input, onkey->code, 0);
+	input_sync(onkey->input);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t max77650_onkey_rising(int irq, void *data)
+{
+	struct max77650_onkey *onkey = data;
+
+	input_report_key(onkey->input, onkey->code, 1);
+	input_sync(onkey->input);
+
+	return IRQ_HANDLED;
+}
+
+static int max77650_onkey_probe(struct platform_device *pdev)
+{
+	int irq_r, irq_f, error, mode;
+	struct max77650_onkey *onkey;
+	struct device *dev, *parent;
+	const char *mode_prop;
+	struct regmap *map;
+	unsigned int type;
+
+	dev = &pdev->dev;
+	parent = dev->parent;
+
+	map = dev_get_regmap(parent, NULL);
+	if (!map)
+		return -ENODEV;
+
+	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
+
+	error = device_property_read_u32(dev, "linux,code", &onkey->code);
+	if (error)
+		onkey->code = KEY_POWER;
+
+	error = device_property_read_string(dev,
+					    "maxim,onkey-mode", &mode_prop);
+	if (error) {
+		mode_prop = "push";
+		type = EV_KEY;
+	}
+
+	if (strcmp(mode_prop, "push") == 0) {
+		mode = MAX77650_ONKEY_MODE_PUSH;
+		type = EV_KEY;
+	} else if (strcmp(mode_prop, "slide") == 0) {
+		mode = MAX77650_ONKEY_MODE_SLIDE;
+		type = EV_SW;
+	} else {
+		return -EINVAL;
+	}
+
+	error = regmap_update_bits(map, MAX77650_REG_CNFG_GLBL,
+				   MAX77650_ONKEY_MODE_MASK, mode);
+	if (error)
+		return error;
+
+	irq_f = platform_get_irq_byname(pdev, "nEN_F");
+	if (irq_f < 0)
+		return irq_f;
+
+	irq_r = platform_get_irq_byname(pdev, "nEN_R");
+	if (irq_r < 0)
+		return irq_r;
+
+	onkey->input = devm_input_allocate_device(dev);
+	if (!onkey->input)
+		return -ENOMEM;
+
+	onkey->input->name = "max77650_onkey";
+	onkey->input->phys = "max77650_onkey/input0";
+	onkey->input->id.bustype = BUS_I2C;
+	input_set_capability(onkey->input, type, onkey->code);
+
+	error = devm_request_any_context_irq(dev, irq_f, max77650_onkey_falling,
+					     IRQF_ONESHOT, "onkey-down", onkey);
+	if (error < 0)
+		return error;
+
+	error = devm_request_any_context_irq(dev, irq_r, max77650_onkey_rising,
+					     IRQF_ONESHOT, "onkey-up", onkey);
+	if (error < 0)
+		return error;
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
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

