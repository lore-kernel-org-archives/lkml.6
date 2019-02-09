Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E190C282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 22:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181B52192C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 22:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zlac4OzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfBIWQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 17:16:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50989 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfBIWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 17:16:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id z5so10100808wmf.0;
        Sat, 09 Feb 2019 14:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2gPaufdL64MDAbZcmDSI2htKT/ZxS0HZwAQSJ2zRAk=;
        b=Zlac4OzUMDHjfX8p/1W+H9G18kAbLLVx+Obr1zh41isEOLw7rSt0icgJ4WneRnU59L
         +He6b93hcQwHLN8zfSxkdm4oBDevtYakX9NFtmRXCfYBoBSEnDDDPQeXkkDiak0S1Rgf
         UfTCKZp3dTyNJ7fJQ8o9VKtt/BMMjv/B4CvTfgnRcg6YyjGnunPEA/A/JHJrYrJeRxjA
         UCZuZF4IW+IDadpVN9W+ocU4WUDWBeqZuEpx4UHf0rh/RyMffB4kmjBcvo2dpm8GqAJS
         iTAH3qNKiJ45Snf0dTfWxNhaWy0Bi61+qYE0ujdrm5Ut/7Y4xO6ZqHsqM+XW5Z4zZCMq
         f1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2gPaufdL64MDAbZcmDSI2htKT/ZxS0HZwAQSJ2zRAk=;
        b=m7HtUZIuwtd/o9L8MCfQHrCBe8hf1O8Kd5b3j5+5fNfPKgHP4u0CMbnD+fCuQYPqhD
         NshDNbZvlcXzSuQZVITDDyXh83fAl04z8Ra1kqiTXzkEvKBoxRyz8+RWZVK6lQ9KzoAb
         Dxgkc9RSutPmDmVrS7g31ubVodfkyk0/MRgt8ImLn2EJ6R9N/vJBqwebWcIQ34/GqPVs
         R8VOlRZ9EIJG0Zta3kYNuXakLm5k77XhcHjGFHMT/NZUL4Zlbha6s3LoFXLKKmISlB43
         scB4JCj6qVpMYguvDd/dtAQOlbOkzV0qrq++c99gSaIXCnVbc3KFu743zA9RlXZ9WhyE
         gwRg==
X-Gm-Message-State: AHQUAuYk4oolblmZcFhYRlowGjQett2NnkYjeVOKXVfDYeI1dU+uX3WL
        0lu5euZUGM+oiE3Xdvbv+rl0B+Rm
X-Google-Smtp-Source: AHgI3IZd5nC5taLxLRuC/CK66+JnSkzZLI23b8KfSIOmT+75s2WEpPwVfCyBAD84bPV0YZk/LiYiuw==
X-Received: by 2002:adf:e38e:: with SMTP id e14mr23045692wrm.142.1549750612473;
        Sat, 09 Feb 2019 14:16:52 -0800 (PST)
Received: from localhost.localdomain ([46.216.193.21])
        by smtp.gmail.com with ESMTPSA id c202sm14979837wmd.40.2019.02.09.14.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 14:16:51 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gsava-0006Ry-D4; Sun, 10 Feb 2019 01:16:50 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC LEDs
Date:   Sun, 10 Feb 2019 01:12:13 +0300
Message-Id: <20190209221213.24052-2-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190209221213.24052-1-jekhor@gmail.com>
References: <20190209221213.24052-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for LEDs connected to the Intel Cherry Trail Whiskey Cove
PMIC. Charger and general-purpose leds are supported. Hardware blinking
is implemented, breathing is not.

This driver was tested with Lenovo Yoga Book notebook.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/leds/Kconfig          |  11 ++
 drivers/leds/Makefile         |   1 +
 drivers/leds/leds-cht-wcove.c | 278 ++++++++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+)
 create mode 100644 drivers/leds/leds-cht-wcove.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a72f97fca57b..8f50f38af57e 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -106,6 +106,17 @@ config LEDS_BCM6358
 	  This option enables support for LEDs connected to the BCM6358
 	  LED HW controller accessed via MMIO registers.
 
+config LEDS_CHT_WCOVE
+	tristate "LED support for Intel Cherry Trail Whiskey Cove PMIC"
+	depends on LEDS_CLASS
+	depends on INTEL_SOC_PMIC_CHTWC
+	help
+	  This option enables support for charger and general purpose LEDs
+	  connected to the Intel Cherrytrail Whiskey Cove PMIC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-cht-wcove.
+
 config LEDS_CPCAP
 	tristate "LED Support for Motorola CPCAP"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4c1b0054f379..1c1995d3441c 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
 obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
 obj-$(CONFIG_LEDS_BD2802)		+= leds-bd2802.o
+obj-$(CONFIG_LEDS_CHT_WCOVE)		+= leds-cht-wcove.o
 obj-$(CONFIG_LEDS_CPCAP)		+= leds-cpcap.o
 obj-$(CONFIG_LEDS_LOCOMO)		+= leds-locomo.o
 obj-$(CONFIG_LEDS_LM3530)		+= leds-lm3530.o
diff --git a/drivers/leds/leds-cht-wcove.c b/drivers/leds/leds-cht-wcove.c
new file mode 100644
index 000000000000..82ed0845bf72
--- /dev/null
+++ b/drivers/leds/leds-cht-wcove.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for LEDs connected to the Intel Cherry Trail Whiskey Cove PMIC
+ *
+ * Copyright 2019 Yauhen Kharuzhy <jekhor@gmail.com>
+ *
+ * Based on Lenovo Yoga Book Android kernel sources
+ */
+#include <linux/kernel.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define CHT_WC_LED1_CTRL		0x5e1f
+#define CHT_WC_LED1_FSM			0x5e20
+#define CHT_WC_LED1_PWM			0x5e21
+
+#define CHT_WC_LED2_CTRL		0x4fdf
+#define CHT_WC_LED2_FSM			0x4fe0
+#define CHT_WC_LED2_PWM			0x4fe1
+
+/* HW or SW control of charging led */
+#define CHT_WC_LED1_SWCTL		BIT(0)
+#define CHT_WC_LED1_ON			BIT(1)
+
+#define CHT_WC_LED2_ON			BIT(0)
+#define CHT_WC_LED_I_MA2_5		(2 << 2)
+/* LED current limit */
+#define CHT_WC_LED_I_MASK		GENMASK(3, 2)
+
+#define CHT_WC_LED_F_1_4_HZ		(0 << 4)
+#define CHT_WC_LED_F_1_2_HZ		(1 << 4)
+#define CHT_WC_LED_F_1_HZ		(2 << 4)
+#define CHT_WC_LED_F_2_HZ		(3 << 4)
+#define CHT_WC_LED_F_MASK		0x30
+
+#define CHT_WC_LED_EFF_ON		BIT(1)
+#define CHT_WC_LED_EFF_BLINKING		BIT(2)
+#define CHT_WC_LED_EFF_BREATHING	BIT(3)
+#define CHT_WC_LED_EFF_MASK		0x06
+
+struct cht_wc_led {
+	struct led_classdev cdev;
+	struct intel_soc_pmic *pmic;
+	const char *name;
+	u16	ctrl_reg;
+	u8	enable_mask;
+	u16	fsm_reg;
+	u16	pwm_reg;
+};
+
+static struct cht_wc_led cht_wc_leds[] = {
+	{
+		.name = "pmic::charge",
+		.ctrl_reg = CHT_WC_LED1_CTRL,
+		.fsm_reg = CHT_WC_LED1_FSM,
+		.pwm_reg = CHT_WC_LED1_PWM,
+		.enable_mask = CHT_WC_LED1_ON,
+	},
+	{
+		.name = "pmic::gpled",
+		.ctrl_reg = CHT_WC_LED2_CTRL,
+		.fsm_reg = CHT_WC_LED2_FSM,
+		.pwm_reg = CHT_WC_LED2_PWM,
+		.enable_mask = CHT_WC_LED2_ON,
+	},
+};
+
+static int cht_wc_leds_brightness_set(struct led_classdev *cdev,
+				      enum led_brightness value)
+{
+	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
+	int ret;
+
+	if (!value) {
+		ret = regmap_update_bits(led->pmic->regmap, led->ctrl_reg,
+					 led->enable_mask, 0);
+		if (ret)
+			dev_err(cdev->dev, "Failed to turn off: %d\n", ret);
+
+		ret = regmap_update_bits(led->pmic->regmap, led->fsm_reg,
+					 CHT_WC_LED_EFF_MASK,
+					 CHT_WC_LED_EFF_ON);
+		if (ret < 0)
+			dev_err(cdev->dev,
+				"Failed to update LED FSM reg: %d\n", ret);
+	} else {
+		ret = regmap_write(led->pmic->regmap, led->pwm_reg, value);
+		if (ret)
+			dev_err(cdev->dev,
+				"Failed to set brightness: %d\n", ret);
+
+		ret = regmap_update_bits(led->pmic->regmap, led->ctrl_reg,
+					 led->enable_mask, led->enable_mask);
+		if (ret)
+			dev_err(cdev->dev, "Failed to turn on: %d\n", ret);
+	}
+	return ret;
+}
+
+enum led_brightness cht_wc_leds_brightness_get(struct led_classdev *cdev)
+{
+	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(led->pmic->regmap, led->ctrl_reg, &val);
+	if (ret < 0) {
+		dev_err(cdev->dev, "Failed to read LED CTRL reg: %d\n", ret);
+		return LED_OFF;
+	}
+
+	val &= led->enable_mask;
+
+	if (!val)
+		return LED_OFF;
+
+	ret = regmap_read(led->pmic->regmap, led->pwm_reg, &val);
+	if (ret < 0) {
+		dev_err(cdev->dev, "Failed to read LED PWM reg: %d\n", ret);
+		return LED_ON;
+	}
+
+	return val;
+}
+
+/* Return blinking period for given CTRL reg value */
+static unsigned long cht_wc_leds_get_period(int ctrl)
+{
+	ctrl &= CHT_WC_LED_F_MASK;
+
+	switch (ctrl) {
+	case CHT_WC_LED_F_1_4_HZ:
+		return 1000 * 4;
+	case CHT_WC_LED_F_1_2_HZ:
+		return 1000 * 2;
+	case CHT_WC_LED_F_1_HZ:
+		return 1000;
+	case CHT_WC_LED_F_2_HZ:
+		return 1000 / 2;
+	};
+
+	return 0;
+}
+
+/*
+ * Find suitable hardware blink mode for given period.
+ * period < 750 ms - select 2 HZ
+ * 750 ms <= period < 1500 ms - select 1 HZ
+ * 1500 ms <= period < 3000 ms - select 1/2 HZ
+ * 3000 ms <= period < 5000 ms - select 1/4 HZ
+ * 5000 ms <= period - return -1
+ */
+static int cht_wc_leds_find_freq(unsigned long period)
+{
+	if (period < 750)
+		return CHT_WC_LED_F_2_HZ;
+	else if (period < 1500)
+		return CHT_WC_LED_F_1_HZ;
+	else if (period < 3000)
+		return CHT_WC_LED_F_1_2_HZ;
+	else if (period < 5000)
+		return CHT_WC_LED_F_1_4_HZ;
+	else
+		return -1;
+}
+
+static int cht_wc_leds_blink_set(struct led_classdev *cdev,
+				 unsigned long *delay_on,
+				 unsigned long *delay_off)
+{
+	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
+	unsigned int ctrl;
+	int ret;
+
+	if (!*delay_on && !*delay_off) {
+		/* Return current settings */
+		ret = regmap_read(led->pmic->regmap, led->ctrl_reg, &ctrl);
+
+		if (ret < 0) {
+			dev_err(cdev->dev,
+				"Failed to read LED CTRL reg: %d\n", ret);
+			return ret;
+		}
+
+		*delay_off = *delay_on = cht_wc_leds_get_period(ctrl) / 2;
+
+		return 0;
+	}
+
+	ctrl = cht_wc_leds_find_freq(*delay_on + *delay_off);
+	if (ctrl < 0) {
+		/* Disable HW blinking */
+		ret = regmap_update_bits(led->pmic->regmap, led->fsm_reg,
+					 CHT_WC_LED_EFF_MASK,
+					 CHT_WC_LED_EFF_ON);
+		if (ret < 0)
+			dev_err(cdev->dev,
+				"Failed to update LED FSM reg: %d\n", ret);
+
+		/* Fallback to software timer */
+		*delay_on = *delay_off = 0;
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(led->pmic->regmap, led->fsm_reg,
+				 CHT_WC_LED_EFF_MASK, CHT_WC_LED_EFF_BLINKING);
+	if (ret < 0)
+		dev_err(cdev->dev,
+			"Failed to update LED FSM reg: %d\n", ret);
+
+	ret = regmap_update_bits(led->pmic->regmap, led->ctrl_reg,
+				 CHT_WC_LED_F_MASK, ctrl);
+	if (ret < 0)
+		dev_err(cdev->dev,
+			"Failed to update LED CTRL reg: %d\n", ret);
+
+	*delay_off = *delay_on = cht_wc_leds_get_period(ctrl) / 2;
+
+	return 0;
+}
+
+static int cht_wc_leds_probe(struct platform_device *pdev)
+{
+	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cht_wc_leds); i++) {
+		struct cht_wc_led *led = &cht_wc_leds[i];
+
+		led->pmic = pmic;
+		led->cdev.name = cht_wc_leds[i].name;
+		led->cdev.brightness_set_blocking = cht_wc_leds_brightness_set;
+		led->cdev.brightness_get = cht_wc_leds_brightness_get;
+		led->cdev.blink_set = cht_wc_leds_blink_set;
+		led->cdev.max_brightness = 255;
+
+		ret = devm_led_classdev_register(&pdev->dev, &led->cdev);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = regmap_update_bits(pmic->regmap, CHT_WC_LED1_CTRL,
+				 CHT_WC_LED1_SWCTL, 1);
+
+	if (ret)
+		dev_err(&pdev->dev,
+			"Failed to set SW control bit for charger LED: %d\n",
+			ret);
+
+	platform_set_drvdata(pdev, cht_wc_leds);
+
+	return 0;
+}
+
+static const struct platform_device_id cht_wc_leds_table[] = {
+	{ .name = "cht_wcove_leds" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, cht_wc_leds_table);
+
+static struct platform_driver cht_wc_leds_driver = {
+	.probe = cht_wc_leds_probe,
+	.id_table = cht_wc_leds_table,
+	.driver = {
+		.name = "cht_wcove_leds",
+	},
+};
+module_platform_driver(cht_wc_leds_driver);
+
+MODULE_DESCRIPTION("Intel Cherrytrail Whiskey Cove PMIC LEDs driver");
+MODULE_AUTHOR("Yauhen Kharuzhy <jekhor@gmail.com>");
+MODULE_LICENSE("GPL");
+
-- 
2.20.1

