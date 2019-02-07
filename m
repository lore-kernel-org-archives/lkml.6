Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E82C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1681F2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBGROP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:14:15 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:60615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBGRON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:14:13 -0500
Received: from orion.localdomain ([77.2.6.87]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6KML-1hBvV42bUn-016elg; Thu, 07 Feb 2019 18:14:03 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, platform-driver-x86@vger.kernel.org,
        andy@infradead.org, dvhart@infradead.org
Subject: [PATCH 1/2] x86: gpio: AMD G-Series pch gpio platform driver
Date:   Thu,  7 Feb 2019 18:13:58 +0100
Message-Id: <1549559639-9447-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:PZTCHvzMI5rFSGAz4yqN9+oMw5RQUILs+IMDY1N97LAsGyMnlV6
 SVGFZVFCrRo3+cyIxLzN4Gm0vwuIqFsJPUORPIOumNHttzLkRN/KUzIj7OXzW7TlJNZoTEb
 DPgQPLX6MlalRnPCwgeHzwkJUGCPawxepGYc2C0sOUVBH0/kWW4xxG0n97NAfW3vZWmzlAL
 5dOEZluGSK8BlEk3xxdXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+qTOfjGqW8s=:qWmQowVZ+1H6Ssis2/di2H
 QYMGDoyAu9t+7QXY7Itd7FLWRQJrJzGf2hQU2IF+A/T8y0zQytsFNNRkovLCcehH8ventpM7p
 Za2luqeNPYm96HSPdgmCJ7RfO+uMueXkIAQMRrVSxZLsb60QpflZdMafyED1Txi7PiEefNZCf
 upXLDxJoN2HBC3bm1EkOQBkf22b0QIKUM8LxZtlhjsqnIii/I/kaRhZOrZD7FzUgNgdeBo9EG
 LfzRr+ZwAgsfHDlWooXcVSWDyFR/a9u3UobQ6/SM+ts5Xc+jdfGLy43BAFifMgWnjvq7x2zY3
 Jx0hbl0nyUltVXaPgCqwJzSippIecy7afVC5z7YPvmO3arHKv6mk7AepIW5tCUQcnUM3Vavj/
 nHUhCZ80LrfCzTMBLWxafRngMcEhnULSN9SvRnjn1L+clqlaMX/mFDpxhfl/ozjGgMfQcfv3D
 ueWdcfGj5JYVsKC5Jcegp7V7gK17D9WnPGGxDnCeNmOoPPvJy4O4orn/Q37U9VD8nv7QHmpp1
 I8fRUQhsNl7M/n0INRLqM9Rq30/0EV/eLIk3t/K9PdPA/EB9pIliFj0Ri00EsfTZT0h0n8TGR
 IOVvygCHzdIbPUHZ3FglqEQokbH7N3fFIXxjzkAv6gDqB+xRzVN8QTg2142svlE909NqL+mV0
 jLlGwv0bFMOTqmhSGBd0Zv+DNRnD/YlekGyAvsPdw5jlwwc+P23LyPLaiyI0JkBV7hBkW7fkC
 RRYjoUZBEqxHQLYbdy9vO6KtIlUaJVUOZaZIFA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO platform driver for the AMD G-series PCH (eg. on GX-412TC)

This driver doesn't registers itself automatically, as it needs to
be provided with platform specific configuration, provided by some
board driver setup code.

Didn't implement oftree probing yet, as it's rarely found on x86.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 MAINTAINERS                                        |   7 +
 drivers/gpio/Kconfig                               |  10 ++
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-amd-fch.c                        | 171 +++++++++++++++++++++
 .../linux/platform_data/x86/amd-fch-gpio-pdata.h   |  41 +++++
 5 files changed, 230 insertions(+)
 create mode 100644 drivers/gpio/gpio-amd-fch.c
 create mode 100644 include/linux/platform_data/x86/amd-fch-gpio-pdata.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c68de3c..a693f39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -766,6 +766,13 @@ S:	Supported
 F:	Documentation/hwmon/fam15h_power
 F:	drivers/hwmon/fam15h_power.c
 
+AMD FCH GPIO DRIVER
+M:	Enrico Weigelt, metux IT consult <info@metux.net>
+L:	linux-gpio@vger.kernel.org
+S:	Maintanced
+F:	drivers/gpio/gpio-amd-fch.c
+F:	include/linux/platform_data/x86/amd-fch-gpio-pdata.h
+
 AMD GEODE CS5536 USB DEVICE CONTROLLER DRIVER
 L:	linux-geode@lists.infradead.org (moderated for non-subscribers)
 S:	Orphan
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b5a2845..a3e47c8 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -654,6 +654,16 @@ config GPIO_LOONGSON1
 	help
 	  Say Y or M here to support GPIO on Loongson1 SoCs.
 
+config GPIO_AMD_FCH
+	tristate "GPIO support for AMD Fusion Controller Hub (G-series SOCs)"
+	select GPIO_GENERIC
+	help
+	  This option enables driver for GPIO on AMDs Fusion Controller Hub,
+	  as found on G-series SOCs (eg. GX-412TC)
+
+	  Note: This driver doesn't registers itself automatically, as it
+	  needs to be provided with platform specific configuration.
+	  (See eg. CONFIG_PCENGINES_APU2.)
 endmenu
 
 menu "Port-mapped I/O GPIO drivers"
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 37628f8..bb48fd2 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_GPIO_ADP5520)	+= gpio-adp5520.o
 obj-$(CONFIG_GPIO_ADP5588)	+= gpio-adp5588.o
 obj-$(CONFIG_GPIO_ALTERA)  	+= gpio-altera.o
 obj-$(CONFIG_GPIO_ALTERA_A10SR)	+= gpio-altera-a10sr.o
+obj-$(CONFIG_GPIO_AMD_FCH)	+= gpio-amd-fch.o
 obj-$(CONFIG_GPIO_AMD8111)	+= gpio-amd8111.o
 obj-$(CONFIG_GPIO_AMDPT)	+= gpio-amdpt.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
diff --git a/drivers/gpio/gpio-amd-fch.c b/drivers/gpio/gpio-amd-fch.c
new file mode 100644
index 0000000..8a002453
--- /dev/null
+++ b/drivers/gpio/gpio-amd-fch.c
@@ -0,0 +1,171 @@
+/*
+ * GPIO driver for the AMD G series FCH (eg. GX-412TC)
+ *
+ * Copyright (C) 2018 metux IT consult
+ * Author: Enrico Weigelt <info@metux.net>
+ *
+ * SPDX-License-Identifier: GPL+
+ */
+
+// FIXME: add spinlocks
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio/driver.h>
+#include <linux/platform_data/x86/amd-fch-gpio-pdata.h>
+
+
+#define GPIO_BIT_DIR		23
+#define GPIO_BIT_WRITE		22
+#define GPIO_BIT_READ		16
+
+
+struct amd_fch_gpio_priv {
+	struct platform_device		*pdev;
+	struct gpio_chip		gc;
+	void __iomem			*base;
+	struct amd_fch_gpio_pdata	*pdata;
+};
+
+static uint32_t *amd_fch_gpio_addr(struct gpio_chip *gc, unsigned gpio)
+{
+	struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
+
+	if (gpio > priv->pdata->gpio_num) {
+		dev_err(&priv->pdev->dev, "gpio number %d out of range\n", gpio);
+		return NULL;
+	}
+
+	return priv->base + priv->pdata->gpio_reg[gpio].reg*sizeof(u32);
+}
+
+static int amd_fch_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
+{
+	volatile uint32_t *ptr = amd_fch_gpio_addr(gc, offset);
+	if (!ptr) return -EINVAL;
+
+	*ptr &= ~(1 << GPIO_BIT_DIR);
+	return 0;
+}
+
+static int amd_fch_gpio_direction_output(struct gpio_chip *gc, unsigned gpio, int value)
+{
+	volatile uint32_t *ptr = amd_fch_gpio_addr(gc, gpio);
+	if (!ptr) return -EINVAL;
+
+	*ptr |= (1 << GPIO_BIT_DIR);
+	return 0;
+}
+
+static int amd_fch_gpio_get_direction(struct gpio_chip *gc, unsigned gpio)
+{
+	volatile uint32_t *ptr = amd_fch_gpio_addr(gc, gpio);
+	if (!ptr) return -EINVAL;
+
+	return (*ptr >> GPIO_BIT_DIR) & 1;
+}
+
+static void amd_fch_gpio_set(struct gpio_chip *gc, unsigned gpio, int value)
+{
+	volatile uint32_t *ptr = amd_fch_gpio_addr(gc, gpio);
+	if (!ptr) return;
+
+	if (value)
+		*ptr |= (1 << GPIO_BIT_WRITE);
+	else
+		*ptr &= ~(1 << GPIO_BIT_WRITE);
+}
+
+static int amd_fch_gpio_get(struct gpio_chip *gc, unsigned offset)
+{
+	volatile uint32_t *ptr = amd_fch_gpio_addr(gc, offset);
+	if (!ptr) return -EINVAL;
+
+	return ((*ptr) >> GPIO_BIT_READ) & 1;
+}
+
+static void amd_fch_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
+{
+	struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
+	(void)priv;
+
+	seq_printf(s, "debug info not implemented yet\n");
+}
+
+static int amd_fch_gpio_request(struct gpio_chip *chip, unsigned gpio_pin)
+{
+	if (gpio_pin < chip->ngpio)
+		return 0;
+
+	return -EINVAL;
+}
+
+static int amd_fch_gpio_probe(struct platform_device *pdev)
+{
+	struct amd_fch_gpio_priv *priv;
+	struct amd_fch_gpio_pdata *pdata = pdev->dev.platform_data;
+	int err;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform_data\n");
+		return -ENOENT;
+	}
+
+	if (!(priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL))) {
+		dev_err(&pdev->dev, "failed to allocate priv struct\n");
+		return -ENOMEM;
+	}
+
+	priv->pdata	= pdata;
+	priv->pdev	= pdev;
+
+	priv->gc.owner			= THIS_MODULE;
+	priv->gc.parent			= &pdev->dev;
+	priv->gc.label			= dev_name(&pdev->dev);
+	priv->gc.base			= priv->pdata->gpio_base;
+	priv->gc.ngpio			= priv->pdata->gpio_num;
+	priv->gc.request		= amd_fch_gpio_request;
+	priv->gc.direction_input	= amd_fch_gpio_direction_input;
+	priv->gc.direction_output	= amd_fch_gpio_direction_output;
+	priv->gc.get_direction		= amd_fch_gpio_get_direction;
+	priv->gc.get			= amd_fch_gpio_get;
+	priv->gc.set			= amd_fch_gpio_set;
+
+	spin_lock_init(&priv->gc.bgpio_lock);
+
+	if (IS_ERR(priv->base = devm_ioremap_resource(&pdev->dev, &priv->pdata->res))) {
+		dev_err(&pdev->dev, "failed to map iomem\n");
+		return -ENXIO;
+	}
+
+	dev_info(&pdev->dev, "initializing on my own II\n");
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		dev_info(&pdev->dev, "enabling debugfs\n");
+		priv->gc.dbg_show = amd_fch_gpio_dbg_show;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	err = devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
+	dev_info(&pdev->dev, "probe finished\n");
+	return err;
+}
+
+static struct platform_driver amd_fch_gpio_driver = {
+	.driver = {
+		.name = AMD_FCH_GPIO_DRIVER_NAME,
+	},
+	.probe = amd_fch_gpio_probe,
+};
+
+module_platform_driver(amd_fch_gpio_driver);
+
+MODULE_AUTHOR("Enrico Weigelt, metux IT consult <info@metux.net>");
+MODULE_DESCRIPTION("AMD G-series FCH GPIO driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:gpio_amd_fch");
diff --git a/include/linux/platform_data/x86/amd-fch-gpio-pdata.h b/include/linux/platform_data/x86/amd-fch-gpio-pdata.h
new file mode 100644
index 0000000..68c1730
--- /dev/null
+++ b/include/linux/platform_data/x86/amd-fch-gpio-pdata.h
@@ -0,0 +1,41 @@
+/*
+ * AMD FCH gpio driver platform-data
+ *
+ * Copyright (C) 2018 metux IT consult
+ * Author: Enrico Weigelt <info@metux.net>
+ *
+ * SPDX-License-Identifier: GPL
+ */
+
+#ifndef AMD_FCH_PDATA_H
+#define AMD_FCH_PDATA_H
+
+
+#include <linux/ioport.h>
+
+#define AMD_FCH_GPIO_DRIVER_NAME "gpio_amd_fch"
+
+/*
+ * struct amd_fch_gpio_reg - GPIO register definition
+ * @reg: register index
+ * @name: signal name
+ */
+struct amd_fch_gpio_reg {
+    int         reg;
+    const char* name;
+};
+
+/*
+ * struct amd_fch_gpio_pdata - GPIO chip platform data
+ * @resource: iomem range
+ * @gpio_reg: array of gpio registers
+ * @gpio_num: number of entries
+ */
+struct amd_fch_gpio_pdata {
+    struct resource          res;
+    int                      gpio_num;
+    struct amd_fch_gpio_reg *gpio_reg;
+    int                      gpio_base;
+};
+
+#endif /* AMD_FCH_PDATA_H */
-- 
1.9.1

