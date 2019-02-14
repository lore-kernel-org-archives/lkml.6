Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAB82229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CI0TT+kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439086AbfBNOA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:00:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38464 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439047AbfBNOAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:00:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so6200491wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8oXAiWrsYd6mGXFuXDQIsjG/KmbZDNABDRW5e27Vn8=;
        b=CI0TT+kSW5GBqB6UWu5JaABUCI59PrjBmsIYr+7S08NsXy+lLMAO2EstNoeDyZIjTr
         kB0eAitRN1Mc/doRA3eSPN4zBozGtI/9FslxMWVXQZZM1s4LETmO7RQ6q1WRnnEJ2ys2
         ZTgQnXoLv8iNfRmfTlWlhvIrLi3Y6fF/DGie3WRHJY6iuifax6GIbETiLVf45FKslfoq
         GTYPDc2EKgQJYmUMfWQgggx/YZA6fAkO7sHbyMMOv4nOd4Co+yMfLkn92nyYnuRRmLCT
         11L+XDrzMc0yPMnmwYynML2/QVvc14bFTn3gU1OoIcquaD3geNjiTYXkeh9Y29qhvvMD
         vtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8oXAiWrsYd6mGXFuXDQIsjG/KmbZDNABDRW5e27Vn8=;
        b=NM60G/cn4D6MAoHcQTGNIJty7bwhwrpubjRQm6wdJ9KfeXYWCfio65o6s7W4F+bfVp
         IsVoGChRMbmJ5LUUQHZdCsqC0WEquJ+sOgl93NqXazkSg/6EJGTmPGhXBBGQFBxal+U/
         X68DcsP9HwyvXM4qu9QOHAesasNWlCHJHdT4fE0CEerI6ESFltIt5oni66PmBXNEbqpE
         yAnCWD9M/qNXqLJPQjLQxqkvr7cU2WZIcTlSa3X7vvXOI3YBOuF4ZZ+lZtOgpBu0ub0s
         9wrCd9Io0etKdbBclWrtkMgx98fHpVmenZLCWKaCoMoSlC4iQsV4sm02bM+pb2lCNgip
         hNYw==
X-Gm-Message-State: AHQUAubdbg/pJA5mHpTsdnUcWLZic+0V6BubWFygpqpxC6XyyFeQGjpi
        MRx/OtlfsSQC3Q+Ih8GhpPYYag==
X-Google-Smtp-Source: AHgI3IZDJurSf2oR5nbMqoth/C1sQzKc/qCHoEAN6WZR5Mz9m8jnrrYwXkAWUEO2SLlYiJ7tMLBedQ==
X-Received: by 2002:a1c:eb1a:: with SMTP id j26mr1378087wmh.127.1550152850998;
        Thu, 14 Feb 2019 06:00:50 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h142sm3395677wme.33.2019.02.14.06.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:00:50 -0800 (PST)
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
Subject: [PATCH v6 10/11] input: max77650: add onkey support
Date:   Thu, 14 Feb 2019 15:00:21 +0100
Message-Id: <20190214140022.19201-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214140022.19201-1-brgl@bgdev.pl>
References: <20190214140022.19201-1-brgl@bgdev.pl>
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
 drivers/input/misc/Kconfig          |   9 +++
 drivers/input/misc/Makefile         |   1 +
 drivers/input/misc/max77650-onkey.c | 121 ++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)
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
index 000000000000..fbf6caab7217
--- /dev/null
+++ b/drivers/input/misc/max77650-onkey.c
@@ -0,0 +1,121 @@
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
+	if (device_property_read_bool(dev, "maxim,onkey-slide")) {
+		mode = MAX77650_ONKEY_MODE_SLIDE;
+		type = EV_SW;
+	} else {
+		mode = MAX77650_ONKEY_MODE_PUSH;
+		type = EV_KEY;
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

