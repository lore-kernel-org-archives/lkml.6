Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E686EECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC45321473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC45321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeJRRDA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:03:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15177 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727969AbeJRRCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:02:47 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9I8wj5U030789;
        Thu, 18 Oct 2018 11:02:16 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n35u5ygkg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 18 Oct 2018 11:02:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31C6548;
        Thu, 18 Oct 2018 09:02:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E22A62771;
        Thu, 18 Oct 2018 09:02:14 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 18 Oct
 2018 11:02:14 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 18 Oct 2018 11:02:14 +0200
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
Subject: [PATCH v4 8/8] watchdog: stpmic1: add stpmic1 watchdog driver
Thread-Topic: [PATCH v4 8/8] watchdog: stpmic1: add stpmic1 watchdog driver
Thread-Index: AQHUZsFDQ3Gdf8Iq40GyidgZ/ej36Q==
Date:   Thu, 18 Oct 2018 09:02:14 +0000
Message-ID: <1539853324-29051-9-git-send-email-p.paillet@st.com>
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

The stpmic1 PMIC embeds a watchdog which is disabled by default. As soon
as the watchdog is started, it must be refreshed periodically otherwise
the PMIC goes off.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
changes in v4:
* fix stop watchdog function
* Kconfig: fix grammar issue

 drivers/watchdog/Kconfig       |  12 ++++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/stpmic1_wdt.c | 139 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/watchdog/stpmic1_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 5ea8909..6d2ffef 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -806,6 +806,18 @@ config STM32_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called stm32_iwdg.
 
+config STPMIC1_WATCHDOG
+	tristate "STPMIC1 PMIC watchdog support"
+	depends on MFD_STPMIC1
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include watchdog support embedded into STPMIC1 PMIC.
+	  If the watchdog timer expires, stpmic1 will shut down all its power
+	  supplies.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called spmic1_wdt.
+
 config UNIPHIER_WATCHDOG
 	tristate "UniPhier watchdog support"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index bf92e7b..2649cf3 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -217,3 +217,4 @@ obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
 obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
+obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
diff --git a/drivers/watchdog/stpmic1_wdt.c b/drivers/watchdog/stpmic1_wdt.c
new file mode 100644
index 0000000..a6cbc27
--- /dev/null
+++ b/drivers/watchdog/stpmic1_wdt.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) STMicroelectronics 2018
+// Author: Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+
+#include <linux/kernel.h>
+#include <linux/mfd/stpmic1.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/watchdog.h>
+
+/* WATCHDOG CONTROL REGISTER bit */
+#define WDT_START		BIT(0)
+#define WDT_PING		BIT(1)
+#define WDT_START_MASK		BIT(0)
+#define WDT_PING_MASK		BIT(1)
+#define WDT_STOP		0
+
+#define PMIC_WDT_MIN_TIMEOUT 1
+#define PMIC_WDT_MAX_TIMEOUT 256
+#define PMIC_WDT_DEFAULT_TIMEOUT 30
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+		"Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct stpmic1_wdt {
+	struct stpmic1 *pmic;
+	struct watchdog_device wdtdev;
+};
+
+static int pmic_wdt_start(struct watchdog_device *wdd)
+{
+	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	return regmap_update_bits(wdt->pmic->regmap,
+				  WCHDG_CR, WDT_START_MASK, WDT_START);
+}
+
+static int pmic_wdt_stop(struct watchdog_device *wdd)
+{
+	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	return regmap_update_bits(wdt->pmic->regmap,
+				  WCHDG_CR, WDT_START_MASK, WDT_STOP);
+}
+
+static int pmic_wdt_ping(struct watchdog_device *wdd)
+{
+	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	return regmap_update_bits(wdt->pmic->regmap,
+				  WCHDG_CR, WDT_PING_MASK, WDT_PING);
+}
+
+static int pmic_wdt_set_timeout(struct watchdog_device *wdd,
+				unsigned int timeout)
+{
+	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	wdd->timeout = timeout;
+	/* timeout is equal to register value + 1 */
+	return regmap_write(wdt->pmic->regmap, WCHDG_TIMER_CR, timeout - 1);
+}
+
+static const struct watchdog_info pmic_watchdog_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "STPMIC1 PMIC Watchdog",
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
+	struct stpmic1 *pmic;
+	struct stpmic1_wdt *wdt;
+
+	if (!pdev->dev.parent)
+		return -EINVAL;
+
+	pmic = dev_get_drvdata(pdev->dev.parent);
+	if (!pmic)
+		return -EINVAL;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(struct stpmic1_wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->pmic = pmic;
+
+	wdt->wdtdev.info = &pmic_watchdog_info;
+	wdt->wdtdev.ops = &pmic_watchdog_ops;
+	wdt->wdtdev.min_timeout = PMIC_WDT_MIN_TIMEOUT;
+	wdt->wdtdev.max_timeout = PMIC_WDT_MAX_TIMEOUT;
+
+	wdt->wdtdev.timeout = PMIC_WDT_DEFAULT_TIMEOUT;
+	watchdog_init_timeout(&wdt->wdtdev, 0, &pdev->dev);
+
+	watchdog_set_nowayout(&wdt->wdtdev, nowayout);
+	watchdog_set_drvdata(&wdt->wdtdev, wdt);
+
+	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdtdev);
+	if (ret)
+		return ret;
+
+	dev_dbg(wdt->pmic->dev, "PMIC Watchdog driver probed\n");
+	return 0;
+}
+
+static const struct of_device_id of_pmic_wdt_match[] = {
+	{ .compatible = "st,stpmic1-wdt" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, of_pmic_wdt_match);
+
+static struct platform_driver stpmic1_wdt_driver = {
+	.probe = pmic_wdt_probe,
+	.driver = {
+		.name = "stpmic1-wdt",
+		.of_match_table = of_pmic_wdt_match,
+	},
+};
+module_platform_driver(stpmic1_wdt_driver);
+
+MODULE_DESCRIPTION("Watchdog driver for STPMIC1 device");
+MODULE_AUTHOR("Pascal Paillet <p.paillet@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
