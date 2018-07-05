Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F779C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2AD2156B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2AD2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754430AbeGEPPC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:15:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56782 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754375AbeGEPO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:14:57 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w65F8YM0009591;
        Thu, 5 Jul 2018 17:14:27 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k0dnx1sbb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 17:14:27 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 74D1738;
        Thu,  5 Jul 2018 15:14:26 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50EB726D4;
        Thu,  5 Jul 2018 15:14:26 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 17:14:25 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 5 Jul 2018 17:14:25 +0200
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
Subject: [PATCH 8/8] watchdog: stpmu1: add stpmu1 watchdog driver
Thread-Topic: [PATCH 8/8] watchdog: stpmu1: add stpmu1 watchdog driver
Thread-Index: AQHUFHLcHOpxc71DYUy13Bvlg5YAOA==
Date:   Thu, 5 Jul 2018 15:14:25 +0000
Message-ID: <1530803657-17684-9-git-send-email-p.paillet@st.com>
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

The stpmu1 PMIC embeds a watchdog which is disabled by default. As soon
as the watchdog is started, it must be refreshed periodically otherwise
the PMIC goes off.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 drivers/watchdog/Kconfig      |  12 +++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/stpmu1_wdt.c | 177 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/watchdog/stpmu1_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9af07fd..2155f4d 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -796,6 +796,18 @@ config STM32_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called stm32_iwdg.
 
+config STPMU1_WATCHDOG
+	tristate "STPMU1 PMIC watchdog support"
+	depends on MFD_STPMU1
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include watchdog support embedded into STPMU1 PMIC.
+	  If the watchdog timer expires, stpmu1 shut-down all its power
+	  supplies.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called spmu1_wdt.
+
 config UNIPHIER_WATCHDOG
 	tristate "UniPhier watchdog support"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 1d3c6b0..c9eba94 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -216,3 +216,4 @@ obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
+obj-$(CONFIG_STPMU1_WATCHDOG) += stpmu1_wdt.o
diff --git a/drivers/watchdog/stpmu1_wdt.c b/drivers/watchdog/stpmu1_wdt.c
new file mode 100644
index 0000000..57e0afa
--- /dev/null
+++ b/drivers/watchdog/stpmu1_wdt.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Philippe Peurichard <philippe.peurichard@st.com>,
+ * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/stpmu1.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/watchdog.h>
+
+/* WATCHDOG CONTROL REGISTER bit */
+#define WDT_START		BIT(0)
+#define WDT_PING		BIT(1)
+#define WDT_START_MASK		BIT(0)
+#define WDT_PING_MASK		BIT(1)
+
+#define PMIC_WDT_MIN_TIMEOUT 1
+#define PMIC_WDT_MAX_TIMEOUT 256
+
+struct stpmu1_wdt {
+	struct stpmu1_dev *pmic;
+	struct watchdog_device wdtdev;
+	struct notifier_block restart_handler;
+};
+
+static int pmic_wdt_start(struct watchdog_device *wdd)
+{
+	struct stpmu1_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	return regmap_update_bits(wdt->pmic->regmap,
+				  WCHDG_CR, WDT_START_MASK, WDT_START);
+}
+
+static int pmic_wdt_stop(struct watchdog_device *wdd)
+{
+	struct stpmu1_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	return regmap_update_bits(wdt->pmic->regmap,
+				  WCHDG_CR, WDT_START_MASK, ~WDT_START);
+}
+
+static int pmic_wdt_ping(struct watchdog_device *wdd)
+{
+	struct stpmu1_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	return regmap_update_bits(wdt->pmic->regmap,
+				  WCHDG_CR, WDT_PING_MASK, WDT_PING);
+	return ret;
+}
+
+static int pmic_wdt_set_timeout(struct watchdog_device *wdd,
+				unsigned int timeout)
+{
+	struct stpmu1_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	ret = regmap_write(wdt->pmic->regmap, WCHDG_TIMER_CR, timeout);
+	if (ret)
+		dev_err(wdt->pmic->dev,
+			"Failed to set watchdog timeout (err = %d)\n", ret);
+	else
+		wdd->timeout = PMIC_WDT_MAX_TIMEOUT;
+
+	return ret;
+}
+
+static int pmic_wdt_restart_handler(struct notifier_block *this,
+				    unsigned long mode, void *cmd)
+{
+	struct stpmu1_wdt *wdt = container_of(this,
+						   struct stpmu1_wdt,
+						   restart_handler);
+
+	dev_info(wdt->pmic->dev,
+		 "PMIC Watchdog Elapsed (timeout %d), shutdown of PMIC initiated\n",
+		 wdt->wdtdev.timeout);
+
+	return NOTIFY_DONE;
+}
+
+static const struct watchdog_info pmic_watchdog_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "STPMU1 PMIC Watchdog",
+};
+
+static const struct watchdog_ops pmic_watchdog_ops = {
+	.owner = THIS_MODULE,
+	.start = pmic_wdt_start,
+	.stop = pmic_wdt_stop,
+	.ping = pmic_wdt_ping,
+	.set_timeout = pmic_wdt_set_timeout,
+};
+
+static int pmic_wdt_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct stpmu1_dev *pmic;
+	struct stpmu1_wdt *wdt;
+
+	if (!pdev->dev.parent)
+		return -EINVAL;
+
+	pmic = dev_get_drvdata(pdev->dev.parent);
+	if (!pmic)
+		return -EINVAL;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(struct stpmu1_wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->pmic = pmic;
+
+	wdt->wdtdev.info = &pmic_watchdog_info;
+	wdt->wdtdev.ops = &pmic_watchdog_ops;
+	wdt->wdtdev.min_timeout = PMIC_WDT_MIN_TIMEOUT;
+	wdt->wdtdev.max_timeout = PMIC_WDT_MAX_TIMEOUT;
+	wdt->wdtdev.timeout = PMIC_WDT_MAX_TIMEOUT;
+
+	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+
+	watchdog_set_drvdata(&wdt->wdtdev, wdt);
+	dev_set_drvdata(&pdev->dev, wdt);
+
+	ret = watchdog_register_device(&wdt->wdtdev);
+	if (ret)
+		return ret;
+
+	wdt->restart_handler.notifier_call = pmic_wdt_restart_handler;
+	wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&wdt->restart_handler);
+	if (ret) {
+		dev_err(wdt->pmic->dev, "failed to register restart handler\n");
+		return ret;
+	}
+
+	dev_dbg(wdt->pmic->dev, "PMIC Watchdog driver probed\n");
+	return 0;
+}
+
+static int pmic_wdt_remove(struct platform_device *pdev)
+{
+	struct stpmu1_wdt *wdt = dev_get_drvdata(&pdev->dev);
+
+	unregister_restart_handler(&wdt->restart_handler);
+	watchdog_unregister_device(&wdt->wdtdev);
+
+	return 0;
+}
+
+static const struct of_device_id of_pmic_wdt_match[] = {
+	{ .compatible = "st,stpmu1-wdt" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, of_pmic_wdt_match);
+
+static struct platform_driver stpmu1_wdt_driver = {
+	.probe = pmic_wdt_probe,
+	.remove = pmic_wdt_remove,
+	.driver = {
+		.name = "stpmu1-wdt",
+		.of_match_table = of_pmic_wdt_match,
+	},
+};
+module_platform_driver(stpmu1_wdt_driver);
+
+MODULE_AUTHOR("philippe.peurichard@st.com>");
+MODULE_DESCRIPTION("Watchdog driver for STPMU1 device");
+MODULE_LICENSE("GPL");
-- 
1.9.1
