Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FB2ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FFA21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FFA21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeJRRCr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:02:47 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40911 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727977AbeJRRCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:02:46 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9I8whSA030778;
        Thu, 18 Oct 2018 11:02:15 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n35u5ygkc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 18 Oct 2018 11:02:15 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5D85B3D;
        Thu, 18 Oct 2018 09:02:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F07442771;
        Thu, 18 Oct 2018 09:02:13 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 18 Oct
 2018 11:02:13 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 18 Oct 2018 11:02:13 +0200
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
Subject: [PATCH v4 6/8] input: stpmic1: add stpmic1 onkey driver
Thread-Topic: [PATCH v4 6/8] input: stpmic1: add stpmic1 onkey driver
Thread-Index: AQHUZsFCvnEZjcckq0aBst1glZqQuA==
Date:   Thu, 18 Oct 2018 09:02:13 +0000
Message-ID: <1539853324-29051-7-git-send-email-p.paillet@st.com>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1539853324-29051-1-git-send-email-p.paillet@st.com>
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-17_15:,,
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
changes in v4:
* remove remove function
* merge stpmic1_onkey_dt_params() in probe function
* suppresse struct pmic_onkey_config
* rename PONKEY_PU_ACTIVE to PONKEY_PU_INACTIVE

 drivers/input/misc/Kconfig         |  11 +++
 drivers/input/misc/Makefile        |   2 +
 drivers/input/misc/stpmic1_onkey.c | 197 +++++++++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100644 drivers/input/misc/stpmic1_onkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index ca59a2b..279fb02 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -851,4 +851,15 @@ config INPUT_SC27XX_VIBRA
 	  To compile this driver as a module, choose M here. The module will
 	  be called sc27xx_vibra.
 
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
index 9d0f9d1..1b44202 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
 obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
+obj-$(CONFIG_INPUT_STPMIC1_ONKEY)  	+= stpmic1_onkey.o
 obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
@@ -81,3 +82,4 @@ obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
 obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
 obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
 obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR)	+= ideapad_slidebar.o
+
diff --git a/drivers/input/misc/stpmic1_onkey.c b/drivers/input/misc/stpmic1_onkey.c
new file mode 100644
index 0000000..6a7f08b
--- /dev/null
+++ b/drivers/input/misc/stpmic1_onkey.c
@@ -0,0 +1,197 @@
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
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+/**
+ * struct stpmic1_onkey - OnKey data
+ * @input_dev:		pointer to input device
+ * @irq_falling:	irq that we are hooked on to
+ * @irq_rising:		irq that we are hooked on to
+ */
+struct stpmic1_onkey {
+	struct input_dev *input_dev;
+	int irq_falling;
+	int irq_rising;
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
+	return IRQ_HANDLED;
+}
+
+static int stpmic1_onkey_probe(struct platform_device *pdev)
+{
+	struct stpmic1 *pmic = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct input_dev *input_dev;
+	struct stpmic1_onkey *onkey;
+	unsigned int val, reg = 0;
+	int error;
+
+	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
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
+	if (!device_property_read_u32(dev, "power-off-time-sec", &val)) {
+		if ((val > 0) && (val <= 16)) {
+			dev_dbg(dev, "power-off-time=%d seconds\n", val);
+			reg |= PONKEY_PWR_OFF;
+			reg |= ((16 - val) & PONKEY_TURNOFF_TIMER_MASK);
+		} else {
+			dev_err(dev, "power-off-time-sec out of range\n");
+			return -EINVAL;
+		}
+	}
+
+	if (device_property_present(dev, "st,onkey-clear-cc-flag"))
+		reg |= PONKEY_CC_FLAG_CLEAR;
+
+	error = regmap_update_bits(pmic->regmap, PKEY_TURNOFF_CR,
+				   PONKEY_TURNOFF_MASK, reg);
+	if (error) {
+		dev_err(dev, "PKEY_TURNOFF_CR write failed: %d\n", error);
+		return error;
+	}
+
+	if (device_property_present(dev, "st,onkey-pu-inactive")) {
+		error = regmap_update_bits(pmic->regmap, PADS_PULL_CR,
+					   PONKEY_PU_INACTIVE,
+					   PONKEY_PU_INACTIVE);
+		if (error) {
+			dev_err(dev, "ONKEY Pads configuration failed: %d\n", error);
+			return error;
+		}
+	}
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
+	.driver	= {
+		.name	= "stpmic1_onkey",
+		.of_match_table = of_match_ptr(of_stpmic1_onkey_match),
+		.pm	= &stpmic1_onkey_pm,
+	},
+};
+module_platform_driver(stpmic1_onkey_driver);
+
+MODULE_DESCRIPTION("Onkey driver for STPMIC1");
+MODULE_AUTHOR("Pascal Paillet <p.paillet@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
