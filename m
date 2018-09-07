Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33960C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73F82075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73F82075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbeIGRlL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:41:11 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52090 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729066AbeIGRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:41:10 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w87Cx8gb028051;
        Fri, 7 Sep 2018 14:59:46 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mbpnv948f-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 14:59:46 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F0F431;
        Fri,  7 Sep 2018 12:59:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0190A2D4A;
        Fri,  7 Sep 2018 12:59:46 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 7 Sep
 2018 14:59:46 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 7 Sep 2018 14:59:45 +0200
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
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH V2 6/8] input: stpmic1: add stpmic1 onkey driver
Thread-Topic: [PATCH V2 6/8] input: stpmic1: add stpmic1 onkey driver
Thread-Index: AQHURqqmk2rxPe8flEiyU5gsj+jEjg==
Date:   Fri, 7 Sep 2018 12:59:45 +0000
Message-ID: <1536325173-16617-7-git-send-email-p.paillet@st.com>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1536325173-16617-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

The stpmic1 pmic is able to manage an onkey button. This driver exposes
the stpmic1 onkey as an input device. It can also be configured to
shut-down the power supplies on a long key-press with an adjustable
duration.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
changes in v2:
* the hardware component has been renamed from stpmu1 to stpmic1 !
* change headers
* handle remarks from Dmitry
* the irq is threaded because is is nested in a thread; I have added a comment.
Dmitry, I'm sorry, but I did not catch your comment regarding usage of 
"generic device property API.". could you tell more ? 

 drivers/input/misc/Kconfig         |  11 ++
 drivers/input/misc/Makefile        |   2 +
 drivers/input/misc/stpmic1_onkey.c | 257 +++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+)
 create mode 100644 drivers/input/misc/stpmic1_onkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index c25606e..cc82dad 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -841,4 +841,15 @@ config INPUT_RAVE_SP_PWRBUTTON
 	  To compile this driver as a module, choose M here: the
 	  module will be called rave-sp-pwrbutton.
 
+config INPUT_STPMIC1_ONKEY
+	tristate "STPMIC1 PMIC Onkey support"
+	depends on MFD_STPMIC1
+	help
+	  Say Y to enable support of onkey embedded into STPMIC1 PMIC. onkey
+	  can be used to wakeup from low power modes and force a shut-down on
+	  long press.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stpmic1_onkey.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 72cde28..f0e11b0 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
 obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
+obj-$(CONFIG_INPUT_STPMIC1_ONKEY)  	+= stpmic1_onkey.o
 obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
@@ -80,3 +81,4 @@ obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
 obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
 obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
 obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR)	+= ideapad_slidebar.o
+
diff --git a/drivers/input/misc/stpmic1_onkey.c b/drivers/input/misc/stpmic1_onkey.c
new file mode 100644
index 0000000..170d879
--- /dev/null
+++ b/drivers/input/misc/stpmic1_onkey.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) STMicroelectronics 2018
+// Author: Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/stpmic1.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/**
+ * struct stpmic1_onkey - OnKey data
+ * @pmic:		pointer to STPMIC1 PMIC device
+ * @input_dev:		pointer to input device
+ * @irq_falling:	irq that we are hooked on to
+ * @irq_rising:		irq that we are hooked on to
+ */
+struct stpmic1_onkey {
+	struct stpmic1_dev *pmic;
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
+static irqreturn_t onkey_falling_irq(int irq, void *ponkey)
+{
+	struct stpmic1_onkey *onkey = ponkey;
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
+static irqreturn_t onkey_rising_irq(int irq, void *ponkey)
+{
+	struct stpmic1_onkey *onkey = ponkey;
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
+static int stpmic1_onkey_dt_params(struct platform_device *pdev,
+				   struct stpmic1_onkey *onkey,
+				   struct pmic_onkey_config *config)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np;
+	u32 val;
+
+	np = dev->of_node;
+
+	onkey->irq_falling = platform_get_irq_byname(pdev, "onkey-falling");
+	if (onkey->irq_falling < 0) {
+		dev_err(dev, "failed: request IRQ onkey-falling %d\n",
+			onkey->irq_falling);
+		return onkey->irq_falling;
+	}
+
+	onkey->irq_rising = platform_get_irq_byname(pdev, "onkey-rising");
+	if (onkey->irq_rising < 0) {
+		dev_err(dev, "failed: request IRQ onkey-rising %d\n",
+			onkey->irq_rising);
+		return onkey->irq_rising;
+	}
+
+	if (!of_property_read_u32(np, "st,onkey-long-press-seconds", &val)) {
+		if (val >= 1 && val <= 16) {
+			config->long_press_time_val = (16 - val);
+		} else {
+			dev_warn(dev,
+				 "Invalid range of long key pressed timer %d (<16)\n",
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
+static int stpmic1_onkey_probe(struct platform_device *pdev)
+{
+	struct stpmic1_dev *pmic = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct input_dev *input_dev;
+	struct stpmic1_onkey *onkey;
+	struct pmic_onkey_config config;
+	unsigned int val = 0;
+	int error;
+
+	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
+
+	memset(&config, 0, sizeof(struct pmic_onkey_config));
+	error = stpmic1_onkey_dt_params(pdev, onkey, &config);
+	if (error)
+		return error;
+
+	input_dev = devm_input_allocate_device(dev);
+	if (!input_dev) {
+		dev_err(dev, "Can't allocate Pwr Onkey Input Device\n");
+		return -ENOMEM;
+	}
+
+	input_dev->name = "pmic_onkey";
+	input_dev->phys = "pmic_onkey/input0";
+
+	input_set_capability(input_dev, EV_KEY, KEY_POWER);
+
+	/* Setup Power Onkey Hardware parameters (long key press)*/
+	val = (config.long_press_time_val & PONKEY_TURNOFF_TIMER_MASK);
+	if (config.turnoff_enabled)
+		val |= PONKEY_PWR_OFF;
+	if (config.cc_flag_clear)
+		val |= PONKEY_CC_FLAG_CLEAR;
+	error = regmap_update_bits(pmic->regmap, PKEY_TURNOFF_CR,
+				   PONKEY_TURNOFF_MASK, val);
+	if (error) {
+		dev_err(dev, "LONG_PRESS_KEY_UPDATE failed: %d\n", error);
+		return error;
+	}
+
+	error = regmap_update_bits(pmic->regmap, PADS_PULL_CR,
+				   PONKEY_PU_ACTIVE,
+				   config.onkey_pullup_val);
+	if (error) {
+		dev_err(dev, "ONKEY Pads configuration failed: %d\n", error);
+		return error;
+	}
+
+	onkey->pmic = pmic;
+	onkey->input_dev = input_dev;
+
+	/* interrupt is nested in a thread */
+	error = devm_request_threaded_irq(dev, onkey->irq_falling, NULL,
+					  onkey_falling_irq, IRQF_ONESHOT,
+					  dev_name(dev), onkey);
+	if (error) {
+		dev_err(dev, "Can't get IRQ Onkey Falling: %d\n", error);
+		return error;
+	}
+
+	error = devm_request_threaded_irq(dev, onkey->irq_rising, NULL,
+					  onkey_rising_irq, IRQF_ONESHOT,
+					  dev_name(dev), onkey);
+	if (error) {
+		dev_err(dev, "Can't get IRQ Onkey Rising: %d\n", error);
+		return error;
+	}
+
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(dev, "Can't register power button: %d\n", error);
+		return error;
+	}
+
+	platform_set_drvdata(pdev, onkey);
+	device_init_wakeup(dev, true);
+
+	return 0;
+}
+
+static int stpmic1_onkey_remove(struct platform_device *pdev)
+{
+	struct stpmic1_onkey *onkey = platform_get_drvdata(pdev);
+
+	input_unregister_device(onkey->input_dev);
+	return 0;
+}
+
+static int __maybe_unused stpmic1_onkey_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct stpmic1_onkey *onkey = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(onkey->irq_falling);
+		enable_irq_wake(onkey->irq_rising);
+	}
+	return 0;
+}
+
+static int __maybe_unused stpmic1_onkey_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct stpmic1_onkey *onkey = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(dev)) {
+		disable_irq_wake(onkey->irq_falling);
+		disable_irq_wake(onkey->irq_rising);
+	}
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(stpmic1_onkey_pm,
+			 stpmic1_onkey_suspend,
+			 stpmic1_onkey_resume);
+
+static const struct of_device_id of_stpmic1_onkey_match[] = {
+	{ .compatible = "st,stpmic1-onkey" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, of_stpmic1_onkey_match);
+
+static struct platform_driver stpmic1_onkey_driver = {
+	.probe	= stpmic1_onkey_probe,
+	.remove	= stpmic1_onkey_remove,
+	.driver	= {
+		.name	= "stpmic1_onkey",
+		.of_match_table = of_match_ptr(of_stpmic1_onkey_match),
+		.pm	= &stpmic1_onkey_pm,
+	},
+};
+module_platform_driver(stpmic1_onkey_driver);
+
+MODULE_DESCRIPTION("Onkey driver for STPMIC1");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Pascal Paillet");
-- 
1.9.1
