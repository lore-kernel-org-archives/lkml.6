Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEB1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5348F2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfAYLGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:06:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46793 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYLGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:06:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so7996348ljh.13;
        Fri, 25 Jan 2019 03:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J5DY9JE5xtg3hKje1YdVfyM5hb/HtMr8ifhsvQgDaWg=;
        b=lf27b9PsG+ZkdvE06SzuDaL9LtS2NlxtH6s/6vME3wy1F3u8TBLO3Lv6Lt7WzZSagF
         MWaa7ZZhGJUQzKZ33QuoyBdMtt0fZDu4hzDwgeD9PTj3NWAycg/Ua03vr4f2BjsX6DAm
         eBJ9ODqemFhPYXpT/ySlDufYYVM/mMLMmKbxKVoEOz2lE0NXWgTb6SDTusxNRkE0nCBC
         A1aUdU90gWwPRYd7DoscmaARlSzwX4zn6wg0ZX24XX7I3VrbPjOXuzmHuDoqqkTkRzE6
         3Sv/4ezjAYqQw7MFCpy0/jR2yAQwpIiPOYTYaI3RQQVFMHtneIcG5OrelJS5/XZJ2hOE
         yRMA==
X-Gm-Message-State: AJcUukfbjF9lO4UwvYi9RWAvFex16YBpZmjPBI1NkxarCkK/eY1oKDSH
        LXcBNxLRkHyaXAMrkTuMQ74=
X-Google-Smtp-Source: ALg8bN4h0uKpOV0hldBSCTXukgisx7ccI9QeFWVWf/qBIs/ar/xKL9EI1imFP4/dIz4QbWdsrmmlWQ==
X-Received: by 2002:a2e:551:: with SMTP id 78-v6mr8632048ljf.82.1548414399083;
        Fri, 25 Jan 2019 03:06:39 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1432276ljc.10.2019.01.25.03.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:06:38 -0800 (PST)
Date:   Fri, 25 Jan 2019 13:06:25 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH v2 10/10] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Message-ID: <20190125110625.GA29348@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for watchdog block included in ROHM BD70528
power management IC.

Configurations for low power states are still to be checked.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/watchdog/Kconfig       |  12 +++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/bd70528_wdt.c | 183 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 drivers/watchdog/bd70528_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 57f017d74a97..f30e3a3e886e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -90,6 +90,18 @@ config SOFT_WATCHDOG_PRETIMEOUT
 	  watchdog. Be aware that governors might affect the watchdog because it
 	  is purely software, e.g. the panic governor will stall it!
 
+config BD70528_WATCHDOG
+	tristate "ROHM BD70528 PMIC Watchdog"
+	depends on MFD_ROHM_BD70528
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog in the ROHM BD70528 PMIC. Watchdog trigger
+	  cause system reset.
+
+	  Say Y here to include support for the ROHM BD70528 watchdog.
+	  Alternatively say M to compile the driver as a module,
+	  which will be called bd70528_wdt.
+
 config DA9052_WATCHDOG
 	tristate "Dialog DA9052 Watchdog"
 	depends on PMIC_DA9052 || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index a0917ef28e07..1ce87a3b1172 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -204,6 +204,7 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
 obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 
 # Architecture Independent
+obj-$(CONFIG_BD70528_WATCHDOG) += bd70528_wdt.o
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
 obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
 obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
diff --git a/drivers/watchdog/bd70528_wdt.c b/drivers/watchdog/bd70528_wdt.c
new file mode 100644
index 000000000000..347339683cb9
--- /dev/null
+++ b/drivers/watchdog/bd70528_wdt.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// ROHM BD70528MWV watchdog driver
+
+#include <linux/bcd.h>
+#include <linux/kernel.h>
+#include <linux/mfd/rohm-bd70528.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/watchdog.h>
+
+struct wdtbd70528 {
+	struct bd70528 *bd;
+	struct device *dev;
+};
+
+static int bd70528_wdt_set(struct bd70528 *bd70528, int enable)
+{
+	int ret;
+
+	mutex_lock(&bd70528->rtc_timer_lock);
+	ret = bd70528->wdt_set(bd70528, enable, NULL);
+	mutex_unlock(&bd70528->rtc_timer_lock);
+
+	return ret;
+}
+
+static int bd70528_wdt_start(struct watchdog_device *wdt)
+{
+	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
+
+	dev_dbg(w->dev, "WDT ping...\n");
+	return bd70528_wdt_set(w->bd, 1);
+}
+
+static int bd70528_wdt_stop(struct watchdog_device *wdt)
+{
+	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
+
+	dev_dbg(w->dev, "WDT stopping...\n");
+	return bd70528_wdt_set(w->bd, 0);
+}
+
+static int bd70528_wdt_set_timeout(struct watchdog_device *wdt,
+				    unsigned int timeout)
+{
+	unsigned int hours;
+	unsigned int minutes;
+	unsigned int seconds;
+	int ret;
+	struct bd70528 *bd70528;
+	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
+
+	bd70528 = w->bd;
+	seconds = timeout;
+	hours = timeout / (60 * 60);
+	/* Maximum timeout is 1h 59m 59s => hours is 1 or 0 */
+	if (hours)
+		seconds -= (60 * 60);
+	minutes = seconds / 60;
+	seconds = seconds % 60;
+
+	mutex_lock(&bd70528->rtc_timer_lock);
+
+	ret = bd70528->wdt_set(bd70528, 0, NULL);
+	if (ret)
+		goto out_unlock;
+
+	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_HOUR,
+				 BD70528_MASK_WDT_HOUR, hours);
+	if (ret) {
+		dev_err(w->dev, "Failed to set WDT hours\n");
+		goto out_en_unlock;
+	}
+	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_MINUTE,
+				 BD70528_MASK_WDT_MINUTE, bin2bcd(minutes));
+	if (ret) {
+		dev_err(w->dev, "Failed to set WDT minutes\n");
+		goto out_en_unlock;
+	}
+	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_SEC,
+				 BD70528_MASK_WDT_SEC, bin2bcd(seconds));
+	if (ret)
+		dev_err(w->dev, "Failed to set WDT seconds\n");
+	else
+		dev_dbg(w->dev, "WDT tmo set to %u\n", timeout);
+
+out_en_unlock:
+	ret = bd70528->wdt_set(bd70528, 1, NULL);
+out_unlock:
+	mutex_unlock(&bd70528->rtc_timer_lock);
+
+	return ret;
+}
+
+static const struct watchdog_info bd70528_wdt_info = {
+	.identity = "bd70528-wdt",
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops bd70528_wdt_ops = {
+	.start		= bd70528_wdt_start,
+	.stop		= bd70528_wdt_stop,
+	.set_timeout	= bd70528_wdt_set_timeout,
+};
+
+/* Max time we can set is 1 hour, 59 minutes and 59 seconds */
+#define WDT_MAX_MS ((2 * 60 * 60 - 1) * 1000)
+/* Minimum time is 1 second */
+#define WDT_MIN_MS 1000
+#define DEFAULT_TIMEOUT 60
+
+static int bd70528_wdt_probe(struct platform_device *pdev)
+{
+	struct bd70528 *bd70528;
+	struct wdtbd70528 *w;
+	int ret;
+	unsigned int reg;
+	struct watchdog_device *wdt;
+
+	bd70528 = dev_get_drvdata(pdev->dev.parent);
+	if (!bd70528) {
+		dev_err(&pdev->dev, "No MFD driver data\n");
+		return -EINVAL;
+	}
+	w = devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
+	if (!w)
+		return -ENOMEM;
+	w->bd = bd70528;
+	w->dev = &pdev->dev;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->info = &bd70528_wdt_info;
+	wdt->ops =  &bd70528_wdt_ops;
+	wdt->min_hw_heartbeat_ms = WDT_MIN_MS;
+	wdt->max_hw_heartbeat_ms = WDT_MAX_MS;
+	wdt->parent = pdev->dev.parent;
+	wdt->timeout = DEFAULT_TIMEOUT;
+	watchdog_set_drvdata(wdt, w);
+	watchdog_init_timeout(wdt, 0, pdev->dev.parent);
+
+	ret = bd70528_wdt_set_timeout(wdt, wdt->timeout);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set the watchdog timeout\n");
+		return ret;
+	}
+
+	mutex_lock(&bd70528->rtc_timer_lock);
+	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &reg);
+	mutex_unlock(&bd70528->rtc_timer_lock);
+
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to get the watchdog state\n");
+		return ret;
+	}
+	if (reg & BD70528_MASK_WDT_EN) {
+		dev_dbg(&pdev->dev, "watchdog was running during probe\n");
+		set_bit(WDOG_HW_RUNNING, &wdt->status);
+	}
+
+	ret = devm_watchdog_register_device(&pdev->dev, wdt);
+	if (ret < 0)
+		dev_err(&pdev->dev, "watchdog registration failed: %d\n", ret);
+
+	return ret;
+}
+static struct platform_driver bd70528_wdt = {
+	.driver = {
+		.name = "bd70528-wdt"
+	},
+	.probe = bd70528_wdt_probe,
+};
+
+module_platform_driver(bd70528_wdt);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD70528 watchdog driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
