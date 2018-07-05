Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40432C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D1F2156B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D1F2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeGEPPt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:15:49 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27958 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754335AbeGEPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:14:52 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w65F4RKS023275;
        Thu, 5 Jul 2018 17:14:26 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k0dr4hrxk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 17:14:26 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8C73D31;
        Thu,  5 Jul 2018 15:14:25 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5333626DC;
        Thu,  5 Jul 2018 15:14:25 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 17:14:25 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 5 Jul 2018 17:14:24 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 6/8] input: stpmu1: add stpmu1 onkey driver
Thread-Topic: [PATCH 6/8] input: stpmu1: add stpmu1 onkey driver
Thread-Index: AQHUFHLb9VeZCANeCka6TfM6xBddsA==
Date:   Thu, 5 Jul 2018 15:14:24 +0000
Message-ID: <1530803657-17684-7-git-send-email-p.paillet@st.com>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1530803657-17684-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

The stpmu1 pmic is able to manage an onkey button. This driver exposes
the stpmu1 onkey as an input device. It can also be configured to
shut-down the power supplies on a long key-press with an adjustable
duration.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 drivers/input/misc/Kconfig        |  11 ++
 drivers/input/misc/Makefile       |   2 +
 drivers/input/misc/stpmu1_onkey.c | 321 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+)
 create mode 100644 drivers/input/misc/stpmu1_onkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index c25606e..d020971 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -841,4 +841,15 @@ config INPUT_RAVE_SP_PWRBUTTON
 	  To compile this driver as a module, choose M here: the
 	  module will be called rave-sp-pwrbutton.
 
+config INPUT_STPMU1_ONKEY
+	tristate "STPMU1 PMIC Onkey support"
+	depends on MFD_STPMU1
+	help
+	  Say Y to enable support of onkey embedded into STPMU1 PMIC. onkey
+	  can be used to wakeup from low power modes and force a shut-down on
+	  long press.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stpmu1_onkey.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 72cde28..cc60dc1 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
 obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
+obj-$(CONFIG_INPUT_STPMU1_ONKEY)  	+= stpmu1_onkey.o
 obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
@@ -80,3 +81,4 @@ obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
 obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
 obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
 obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR)	+= ideapad_slidebar.o
+
diff --git a/drivers/input/misc/stpmu1_onkey.c b/drivers/input/misc/stpmu1_onkey.c
new file mode 100644
index 0000000..084a31f
--- /dev/null
+++ b/drivers/input/misc/stpmu1_onkey.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Philippe Peurichard <philippe.peurichard@st.com>,
+ * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+ */
+
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/stpmu1.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/**
+ * struct stpmu1_onkey - OnKey data
+ * @pmic:		pointer to STPMU1 PMIC device
+ * @input_dev:		pointer to input device
+ * @irq_falling:	irq that we are hooked on to
+ * @irq_rising:		irq that we are hooked on to
+ */
+struct stpmu1_onkey {
+	struct stpmu1_dev *pmic;
+	struct input_dev *input_dev;
+	int irq_falling;
+	int irq_rising;
+};
+
+/**
+ * struct pmic_onkey_config - configuration of pmic PONKEYn
+ * @turnoff_enabled:		value to enable turnoff condition
+ * @cc_flag_clear:		value to clear CC flag in case of PowerOff
+ * trigger by longkey press
+ * @onkey_pullup_val:		value of PONKEY PullUp (active or inactive)
+ * @long_press_time_val:	value for long press h/w shutdown event
+ */
+struct pmic_onkey_config {
+	bool turnoff_enabled;
+	bool cc_flag_clear;
+	u8 onkey_pullup_val;
+	u8 long_press_time_val;
+};
+
+/**
+ * onkey_falling_irq() - button press isr
+ * @irq:		irq
+ * @pmic_onkey:		onkey device
+ *
+ * Return: IRQ_HANDLED
+ */
+static irqreturn_t onkey_falling_irq(int irq, void *ponkey)
+{
+	struct stpmu1_onkey *onkey = ponkey;
+	struct input_dev *input_dev = onkey->input_dev;
+
+	input_report_key(input_dev, KEY_POWER, 1);
+	pm_wakeup_event(input_dev->dev.parent, 0);
+	input_sync(input_dev);
+
+	dev_dbg(&input_dev->dev, "Pwr Onkey Falling Interrupt received\n");
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * onkey_rising_irq() - button released isr
+ * @irq:		irq
+ * @pmic_onkey:		onkey device
+ *
+ * Return: IRQ_HANDLED
+ */
+static irqreturn_t onkey_rising_irq(int irq, void *ponkey)
+{
+	struct stpmu1_onkey *onkey = ponkey;
+	struct input_dev *input_dev = onkey->input_dev;
+
+	input_report_key(input_dev, KEY_POWER, 0);
+	pm_wakeup_event(input_dev->dev.parent, 0);
+	input_sync(input_dev);
+
+	dev_dbg(&input_dev->dev, "Pwr Onkey Rising Interrupt received\n");
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * stpmu1_onkey_dt_params() - device tree parameter parser
+ * @pdev:	platform device for the PONKEY
+ * @onkey:	pointer to onkey driver data
+ * @config:	configuration params to be filled up
+ */
+static int stpmu1_onkey_dt_params(struct platform_device *pdev,
+				  struct stpmu1_onkey *onkey,
+				  struct pmic_onkey_config *config)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np;
+	u32 val;
+
+	np = dev->of_node;
+	if (!np)
+		return -EINVAL;
+
+	onkey->irq_falling = platform_get_irq_byname(pdev, "onkey-falling");
+	if (onkey->irq_falling < 0) {
+		dev_err(dev, "failed: request IRQ onkey-falling %d",
+			onkey->irq_falling);
+		return onkey->irq_falling;
+	}
+
+	onkey->irq_rising = platform_get_irq_byname(pdev, "onkey-rising");
+	if (onkey->irq_rising < 0) {
+		dev_err(dev, "failed: request IRQ onkey-rising %d",
+			onkey->irq_rising);
+		return onkey->irq_rising;
+	}
+
+	if (!of_property_read_u32(np, "st,onkey-long-press-seconds", &val)) {
+		if (val >= 1 && val <= 16) {
+			config->long_press_time_val = (16 - val);
+		} else {
+			dev_warn(dev,
+				 "Invalid range of long key pressed timer %d (<16)\n\r",
+				 val);
+		}
+	}
+	if (of_get_property(np, "st,onkey-pwroff-enabled", NULL))
+		config->turnoff_enabled = true;
+
+	if (of_get_property(np, "st,onkey-clear-cc-flag", NULL))
+		config->cc_flag_clear = true;
+
+	if (of_get_property(np, "st,onkey-pu-inactive", NULL))
+		config->onkey_pullup_val = PONKEY_PU_ACTIVE;
+
+	dev_dbg(dev, "onkey-switch-off duration=%d seconds\n",
+		config->long_press_time_val);
+
+	return 0;
+}
+
+/**
+ * stpmu1_onkey_probe() - probe
+ * @pdev:	platform device for the PONKEY
+ *
+ * Return: 0 for successful probe else appropriate error
+ */
+static int stpmu1_onkey_probe(struct platform_device *pdev)
+{
+	struct stpmu1_dev *pmic = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct input_dev *input_dev;
+	struct stpmu1_onkey *onkey;
+	struct pmic_onkey_config config;
+	unsigned int val = 0;
+	int ret;
+
+	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
+
+	memset(&config, 0, sizeof(struct pmic_onkey_config));
+	ret = stpmu1_onkey_dt_params(pdev, onkey, &config);
+	if (ret < 0)
+		goto err;
+
+	input_dev = devm_input_allocate_device(dev);
+	if (!input_dev) {
+		dev_err(dev, "Can't allocate Pwr Onkey Input Device\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	input_dev->name = "pmic_onkey";
+	input_dev->phys = "pmic_onkey/input0";
+	input_dev->dev.parent = dev;
+
+	input_set_capability(input_dev, EV_KEY, KEY_POWER);
+
+	/* Setup Power Onkey Hardware parameters (long key press)*/
+	val = (config.long_press_time_val & PONKEY_TURNOFF_TIMER_MASK);
+	if (config.turnoff_enabled)
+		val |= PONKEY_PWR_OFF;
+	if (config.cc_flag_clear)
+		val |= PONKEY_CC_FLAG_CLEAR;
+	ret = regmap_update_bits(pmic->regmap, PKEY_TURNOFF_CR,
+				 PONKEY_TURNOFF_MASK, val);
+	if (ret) {
+		dev_err(dev, "LONG_PRESS_KEY_UPDATE failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = regmap_update_bits(pmic->regmap, PADS_PULL_CR,
+				 PONKEY_PU_ACTIVE,
+				 config.onkey_pullup_val);
+
+	if (ret) {
+		dev_err(dev, "ONKEY Pads configuration failed: %d\n", ret);
+		goto err;
+	}
+
+	onkey->pmic = pmic;
+	onkey->input_dev = input_dev;
+
+	ret = devm_request_threaded_irq(dev, onkey->irq_falling, NULL,
+					onkey_falling_irq,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					dev_name(dev), onkey);
+	if (ret) {
+		dev_err(dev, "Can't get IRQ for Onkey Falling edge: %d\n", ret);
+		goto err;
+	}
+
+	ret = devm_request_threaded_irq(dev, onkey->irq_rising, NULL,
+					onkey_rising_irq,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					dev_name(dev), onkey);
+	if (ret) {
+		dev_err(dev, "Can't get IRQ for Onkey Rising edge: %d\n", ret);
+		goto err;
+	}
+
+	ret = input_register_device(input_dev);
+	if (ret) {
+		dev_err(dev, "Can't register power button: %d\n", ret);
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, onkey);
+	device_init_wakeup(dev, true);
+
+	dev_dbg(dev, "PMIC Pwr Onkey driver probed\n");
+
+err:
+	return ret;
+}
+
+/**
+ * stpmu1_onkey_remove() - Cleanup on removal
+ * @pdev:	platform device for the button
+ *
+ * Return: 0
+ */
+static int stpmu1_onkey_remove(struct platform_device *pdev)
+{
+	struct stpmu1_onkey *onkey = platform_get_drvdata(pdev);
+
+	input_unregister_device(onkey->input_dev);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+
+/**
+ * pmic_onkey_suspend() - suspend handler
+ * @dev:	power button device
+ *
+ * Cancel all pending work items for the power button, setup irq for wakeup
+ *
+ * Return: 0
+ */
+static int __maybe_unused stpmu1_onkey_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct stpmu1_onkey *onkey = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(onkey->irq_falling);
+		enable_irq_wake(onkey->irq_rising);
+	}
+	return 0;
+}
+
+/**
+ * pmic_onkey_resume() - resume handler
+ * @dev:	power button device
+ *
+ * Just disable the wakeup capability of irq here.
+ *
+ * Return: 0
+ */
+static int __maybe_unused stpmu1_onkey_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct stpmu1_onkey *onkey = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(dev)) {
+		disable_irq_wake(onkey->irq_falling);
+		disable_irq_wake(onkey->irq_rising);
+	}
+	return 0;
+}
+
+#endif
+
+static SIMPLE_DEV_PM_OPS(stpmu1_onkey_pm,
+			 stpmu1_onkey_suspend,
+			 stpmu1_onkey_resume);
+
+static const struct of_device_id of_stpmu1_onkey_match[] = {
+	{ .compatible = "st,stpmu1-onkey" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, of_stpmu1_onkey_match);
+
+static struct platform_driver stpmu1_onkey_driver = {
+	.probe	= stpmu1_onkey_probe,
+	.remove	= stpmu1_onkey_remove,
+	.driver	= {
+		.name	= "stpmu1_onkey",
+		.of_match_table = of_match_ptr(of_stpmu1_onkey_match),
+		.pm	= &stpmu1_onkey_pm,
+	},
+};
+module_platform_driver(stpmu1_onkey_driver);
+
+MODULE_DESCRIPTION("Onkey driver for STPMU1");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("philippe.peurichard@st.com>");
-- 
1.9.1
