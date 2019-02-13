Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900BCC0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B47222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394676AbfBMU5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:57:55 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:43903 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389961AbfBMU5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:57:48 -0500
Received: from orion.localdomain ([77.7.10.70]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRk8w-1gWURf3jJq-00TBTN; Wed, 13 Feb 2019 21:57:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, andy@infradead.org,
        dvhart@infradead.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Subject: [PATCH 1/2] gpio: AMD G-Series PCH gpio driver
Date:   Wed, 13 Feb 2019 21:57:27 +0100
Message-Id: <1550091448-28578-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550091448-28578-1-git-send-email-info@metux.net>
References: <1550091448-28578-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:MASsjx/4TEoZXG8uBzdQ1kzYuAWqljfyEvr2otMsp7lEexUQCbP
 CtwOXi4k6xSE3JiduauTnmW5ztJx6OtI4aIK0gnQfY4CAogjJrQk+ZP3hwCqOlBdiljt7p2
 CyCTmXtSKpsk1aztNKOtVb5tfbsQc5cijyX7MmZCHD11maR1PYgl61ay2ZcSexSkpkt70Je
 4ou4PyqMBi05la8NcDp9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5GhQr3i/vTk=:W23404QgpP0fsDQMh1rpO8
 9gmX7B5da35W/0mRYPaZx5BY+utvYxGVZe6o82KBW5TjXWcgbhbeeD7oaQ35aaxvn10HlQvN6
 1sPKKdg+E1Z29+KiTmZu8L5yAtdv4FR3fxfYIzv7xe88URwKTBnyzLsTpXzv1zk1iBZzDwjZU
 VAkrit2UcUsSX+C5qTQgB3FUL/ealn8YysG//AhH+BenrJGy4ZwhAVBPPsYX7ziaO+7hPfBY2
 n5gb2UgIp9LT2DLYd9wqOnaEr1IxQB0Oyx0ia72HiLif/6B+Gd7b9tMWBY6WpGiJh84twMVsz
 Gj02HqlXYInG4U4yi2NYiIaL9wWWAoCeW4IqSscTLlP/utP4V2cHCsWVTKO9NiOafJssVGVUC
 9vgkae2+WGcgUYcSMtOV8g8Uvjm1BolDs/DENk8TExjvQhzxT+1aVTqb0+kQXBd0gb6AqcdmN
 /730mQR5jsDWWKM3EGiYxBc7fiqU4/t7C6lCuNIo4cnrjdQBzmFixiioOm20OTSHLzUhEKAyh
 1YqG9wt/ioRsKWAVAgAJ1ssgqtwsrCoBNQtsjprvMusVZQF9scPzrt874nVrog5uHoOYRly6A
 yi1FO4CbjODXjS7cRQCXFMhiCtdqbwOUVcKFjNkPsNjrFbtAfB44Ur8CADWge93WM2Aq1sNN5
 hJuaGG+No7ZOkS0gkK+91KJfqNHQzW7mrOqTKtNvaKYhSzihhk53ZwFKHrxDn6Brb56JFHSOj
 rpvzlSUg846zIo+L36TiM+JdEy9ypLAsE2d28g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO platform driver for the AMD G-series PCH (eg. on GX-412TC)

This driver doesn't registers itself automatically, as it needs to
be provided with platform specific configuration, provided by some
board driver setup code.

Didn't implement oftree probing yet, as it's rarely found on x86.

Cc: linux-gpio@vger.kernel.org
Cc: linus.walleij@linaro.org
Cc: bgolaszewski@baylibre.com
Cc: dvhart@infradead.org
Cc: andy@infradead.org
Cc: platform-driver-x86@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 MAINTAINERS                                     |   7 +
 drivers/gpio/Kconfig                            |  10 ++
 drivers/gpio/Makefile                           |   1 +
 drivers/gpio/gpio-amd-fch.c                     | 205 ++++++++++++++++++++++++
 include/linux/platform_data/gpio/gpio-amd-fch.h |  46 ++++++
 5 files changed, 269 insertions(+)
 create mode 100644 drivers/gpio/gpio-amd-fch.c
 create mode 100644 include/linux/platform_data/gpio/gpio-amd-fch.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 41ce5f4..d286e7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -766,6 +766,13 @@ S:	Supported
 F:	Documentation/hwmon/fam15h_power
 F:	drivers/hwmon/fam15h_power.c
 
+AMD FCH GPIO DRIVER
+M:	Enrico Weigelt, metux IT consult <info@metux.net>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	drivers/gpio/gpio-amd-fch.c
+F:	include/linux/platform_data/gpio/gpio-amd-fch.h
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
index 0000000..f31a8b4
--- /dev/null
+++ b/drivers/gpio/gpio-amd-fch.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * GPIO driver for the AMD G series FCH (eg. GX-412TC)
+ *
+ * Copyright (C) 2018 metux IT consult
+ * Author: Enrico Weigelt, metux IT consult <info@metux.net>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio/driver.h>
+#include <linux/platform_data/gpio/gpio-amd-fch.h>
+
+#define AMD_FCH_MMIO_BASE		0xFED80000
+#define AMD_FCH_GPIO_BANK0_BASE		0x1500
+#define AMD_FCH_GPIO_SIZE		0x0300
+
+#define AMD_FCH_GPIO_FLAG_DIRECTION	BIT(23)
+#define AMD_FCH_GPIO_FLAG_WRITE		BIT(22)
+#define AMD_FCH_GPIO_FLAG_READ		BIT(16)
+
+struct amd_fch_gpio_priv {
+	struct platform_device		*pdev;
+	struct gpio_chip		gc;
+	void __iomem			*base;
+	struct amd_fch_gpio_pdata	*pdata;
+};
+
+static void *amd_fch_gpio_addr(struct amd_fch_gpio_priv *priv,
+			       unsigned int gpio)
+{
+	if (unlikely(gpio > priv->pdata->gpio_num)) {
+		dev_err(&priv->pdev->dev,
+			"gpio number %d out of range\n", gpio);
+		return NULL;
+	}
+
+	return priv->base + priv->pdata->gpio_reg[gpio]*sizeof(u32);
+}
+
+static int amd_fch_gpio_direction_input(struct gpio_chip *gc,
+					unsigned int offset)
+{
+	unsigned long flags;
+	struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
+	void *ptr = amd_fch_gpio_addr(priv, offset);
+
+	if (unlikely(!ptr))
+		return -EINVAL;
+
+	spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+	writel_relaxed(readl_relaxed(ptr) & ~AMD_FCH_GPIO_FLAG_DIRECTION, ptr);
+	spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+
+	return 0;
+}
+
+static int amd_fch_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned int gpio, int value)
+{
+	unsigned long flags;
+	struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
+	void *ptr = amd_fch_gpio_addr(priv, gpio);
+
+	if (unlikely(!ptr))
+		return -EINVAL;
+
+	spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+	writel_relaxed(readl_relaxed(ptr) | AMD_FCH_GPIO_FLAG_DIRECTION, ptr);
+	spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+
+	return 0;
+}
+
+static int amd_fch_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
+{
+	int ret;
+	unsigned long flags;
+	struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
+	void *ptr = amd_fch_gpio_addr(priv, gpio);
+
+	if (unlikely(!ptr))
+		return -EINVAL;
+
+	spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+	ret = (readl_relaxed(ptr) & AMD_FCH_GPIO_FLAG_DIRECTION);
+	spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+
+	return ret;
+}
+
+static void amd_fch_gpio_set(struct gpio_chip *gc,
+			     unsigned int gpio, int value)
+{
+	unsigned long flags;
+	struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
+	void *ptr = amd_fch_gpio_addr(priv, gpio);
+
+	if (unlikely(!ptr))
+		return;
+
+	spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+
+	if (value)
+		writel_relaxed(readl_relaxed(ptr) | AMD_FCH_GPIO_FLAG_WRITE,
+			       ptr);
+	else
+		writel_relaxed(readl_relaxed(ptr) & ~AMD_FCH_GPIO_FLAG_WRITE,
+			       ptr);
+
+	spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+}
+
+static int amd_fch_gpio_get(struct gpio_chip *gc,
+			    unsigned int offset)
+{
+	unsigned long flags;
+	int ret;
+	struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
+	void *ptr = amd_fch_gpio_addr(priv, offset);
+
+	if (unlikely(!ptr))
+		return -EINVAL;
+
+	spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+	ret = (readl_relaxed(ptr) & AMD_FCH_GPIO_FLAG_READ);
+	spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+
+	return ret;
+}
+
+static int amd_fch_gpio_request(struct gpio_chip *chip,
+				unsigned int gpio_pin)
+{
+	if (likely(gpio_pin < chip->ngpio))
+		return 0;
+
+	return -EINVAL;
+}
+
+static int amd_fch_gpio_probe(struct platform_device *pdev)
+{
+	struct amd_fch_gpio_priv *priv;
+	struct amd_fch_gpio_pdata *pdata;
+	struct resource res = DEFINE_RES_MEM_NAMED(
+				AMD_FCH_MMIO_BASE + AMD_FCH_GPIO_BANK0_BASE,
+				AMD_FCH_GPIO_SIZE,
+				"amd-fch-gpio-iomem");
+
+	pdata = dev_get_platdata(&pdev->dev);
+
+	if (unlikely(pdata == NULL)) {
+		dev_err(&pdev->dev, "no platform_data\n");
+		return -ENOENT;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+
+	if (unlikely(priv == NULL))
+		return -ENOMEM;
+
+	priv->pdata	= pdata;
+	priv->pdev	= pdev;
+
+	priv->gc.owner			= THIS_MODULE;
+	priv->gc.parent			= &pdev->dev;
+	priv->gc.label			= dev_name(&pdev->dev);
+	priv->gc.ngpio			= priv->pdata->gpio_num;
+	priv->gc.names			= priv->pdata->gpio_names;
+	priv->gc.request		= amd_fch_gpio_request;
+	priv->gc.direction_input	= amd_fch_gpio_direction_input;
+	priv->gc.direction_output	= amd_fch_gpio_direction_output;
+	priv->gc.get_direction		= amd_fch_gpio_get_direction;
+	priv->gc.get			= amd_fch_gpio_get;
+	priv->gc.set			= amd_fch_gpio_set;
+
+	spin_lock_init(&priv->gc.bgpio_lock);
+
+	priv->base = devm_ioremap_resource(&pdev->dev, &res);
+	if (IS_ERR(priv->base))
+		return -ENXIO;
+
+	platform_set_drvdata(pdev, priv);
+
+	return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
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
+MODULE_ALIAS("platform:" AMD_FCH_GPIO_DRIVER_NAME);
diff --git a/include/linux/platform_data/gpio/gpio-amd-fch.h b/include/linux/platform_data/gpio/gpio-amd-fch.h
new file mode 100644
index 0000000..a867637
--- /dev/null
+++ b/include/linux/platform_data/gpio/gpio-amd-fch.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL+ */
+
+/*
+ * AMD FCH gpio driver platform-data
+ *
+ * Copyright (C) 2018 metux IT consult
+ * Author: Enrico Weigelt <info@metux.net>
+ *
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_GPIO_AMD_FCH_H
+#define __LINUX_PLATFORM_DATA_GPIO_AMD_FCH_H
+
+#define AMD_FCH_GPIO_DRIVER_NAME "gpio_amd_fch"
+
+/*
+ * gpio register index definitions
+ */
+#define AMD_FCH_GPIO_REG_GPIO49		0x40
+#define AMD_FCH_GPIO_REG_GPIO50		0x41
+#define AMD_FCH_GPIO_REG_GPIO51		0x42
+#define AMD_FCH_GPIO_REG_GPIO59_DEVSLP0	0x43
+#define AMD_FCH_GPIO_REG_GPIO57		0x44
+#define AMD_FCH_GPIO_REG_GPIO58		0x45
+#define AMD_FCH_GPIO_REG_GPIO59_DEVSLP1	0x46
+#define AMD_FCH_GPIO_REG_GPIO64		0x47
+#define AMD_FCH_GPIO_REG_GPIO68		0x48
+#define AMD_FCH_GPIO_REG_GPIO66_SPKR	0x5B
+#define AMD_FCH_GPIO_REG_GPIO71		0x4D
+#define AMD_FCH_GPIO_REG_GPIO32_GE1	0x59
+#define AMD_FCH_GPIO_REG_GPIO33_GE2	0x5A
+#define AMT_FCH_GPIO_REG_GEVT22		0x09
+
+/*
+ * struct amd_fch_gpio_pdata - GPIO chip platform data
+ * @gpio_num: number of entries
+ * @gpio_reg: array of gpio registers
+ * @gpio_names: array of gpio names
+ */
+struct amd_fch_gpio_pdata {
+	int			gpio_num;
+	int			*gpio_reg;
+	const char * const	*gpio_names;
+};
+
+#endif /* __LINUX_PLATFORM_DATA_GPIO_AMD_FCH_H */
-- 
1.9.1

