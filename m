Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E03C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0690A2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfBVJyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:54:44 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:50311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfBVJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:54:38 -0500
Received: from orion.localdomain ([77.7.125.227]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBUuP-1gkEZu0Vyh-00CwST; Fri, 22 Feb 2019 10:54:29 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, dvhart@infradead.org,
        andy@infradead.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 1/2] gpio: AMD G-Series PCH gpio driver
Date:   Fri, 22 Feb 2019 10:54:15 +0100
Message-Id: <1550829256-8831-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550829256-8831-1-git-send-email-info@metux.net>
References: <1550181897-2596-1-git-send-email-info@metux.net>
 <1550829256-8831-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Iwo7A8N3y2V92txH27QZLkP4JKXjhjSSkayCm8Ppm7oty7gefr8
 LnL4aMm4BohOOj5kNCFGutg6b6nwaY9RGphS+k1uTctykk9/Ltlc+wsnxAAtZouf8pby8h+
 fIifFbw/NQN3QwdUw4YegAGU6HJbZzMnbjKfs0BQoq1SDZ/UlD4JBUzR6DwEs9j4R0KGMXx
 HxQWg24lhqraWs5DIow7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/po9OoAAWkE=:ZvyxNMyegEMbFXcOgiSOMB
 GubPo9X0e46ShXdTZAWrbDbdrmSgmKstLpVkCym+vJR+TCuiK1rxoQffhAk/y8wmTPAvVH8rZ
 xqn1nWVBgpCUIj3I6SIP1XhMTCNrBJLRs2VfKDBUQQN/8Jd1HZEs7oVNHsTvwun+c+yR09BsP
 qRM0NgqbYryx/YxWfgxn7lwLHYF0fduJrqUZtugxbfZfOsS9nu1HXPy5KZFNu+5WLirUrb/m4
 i+/uomvuLv3QqbJeAql0ZV9Fm6Dhvnj5frPbNE0SQvPjZTNZG+VEe+uk1Tmn0wVW7H0MlhmWy
 a8bqfjeS5AHFZGmeOa0sitWoO5wj4wsM3f+lFK4wqx5id3MNJTeuX1CJOVYjH6szghZsXND5t
 m1KvSD2HfWf7G48txZ5nL6NUa+4MEoAS4skuSR5/78lw48hn5f71OLr2jCI9bB9GJJBh5uoJ7
 uP/gQoJ4gVF5yX0f0fDq1xTDvQlLP9cK86+kdfekX36EaB4Er80YTUk1cIboiXRRPif+ZGTpm
 dTRs3hrnGUuMKFy3SSwmDed1A8DKxDyk0NCCq+/TNia6kq9VryZ7oNRQGrnRwJxhQI8eiAVFV
 c7AJk2Gjjvx0H26PZmAmUxr1cWiqHjeTGuw99PCHglg4ZyKsQdxsmURL3WEzr7CT23livnq9Z
 CwQdVqSLJ+CjxGW7nZnTn5rccRBlZzoROzHeImG7991N8O6blB6+NtirJy7GStKsXNAwdV8SN
 Xy13NtCEvFTrYOOMG0IQEn1DszCra/dzZmjqiw==
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 MAINTAINERS                                     |   7 +
 drivers/gpio/Kconfig                            |   9 ++
 drivers/gpio/Makefile                           |   1 +
 drivers/gpio/gpio-amd-fch.c                     | 185 ++++++++++++++++++++++++
 include/linux/platform_data/gpio/gpio-amd-fch.h |  46 ++++++
 5 files changed, 248 insertions(+)
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
index b5a2845..cc976b0 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -654,6 +654,15 @@ config GPIO_LOONGSON1
 	help
 	  Say Y or M here to support GPIO on Loongson1 SoCs.
 
+config GPIO_AMD_FCH
+	tristate "GPIO support for AMD Fusion Controller Hub (G-series SOCs)"
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
index 0000000..3b4fdce
--- /dev/null
+++ b/drivers/gpio/gpio-amd-fch.c
@@ -0,0 +1,185 @@
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
+#include <linux/spinlock.h>
+
+#define AMD_FCH_MMIO_BASE		0xFED80000
+#define AMD_FCH_GPIO_BANK0_BASE		0x1500
+#define AMD_FCH_GPIO_SIZE		0x0300
+
+#define AMD_FCH_GPIO_FLAG_DIRECTION	BIT(23)
+#define AMD_FCH_GPIO_FLAG_WRITE		BIT(22)
+#define AMD_FCH_GPIO_FLAG_READ		BIT(16)
+
+static const struct resource amd_fch_gpio_iores =
+	DEFINE_RES_MEM_NAMED(
+		AMD_FCH_MMIO_BASE + AMD_FCH_GPIO_BANK0_BASE,
+		AMD_FCH_GPIO_SIZE,
+		"amd-fch-gpio-iomem");
+
+struct amd_fch_gpio_priv {
+	struct platform_device		*pdev;
+	struct gpio_chip		gc;
+	void __iomem			*base;
+	struct amd_fch_gpio_pdata	*pdata;
+	spinlock_t			lock;
+};
+
+static void *amd_fch_gpio_addr(struct amd_fch_gpio_priv *priv,
+			       unsigned int gpio)
+{
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
+	spin_lock_irqsave(&priv->lock, flags);
+	writel_relaxed(readl_relaxed(ptr) & ~AMD_FCH_GPIO_FLAG_DIRECTION, ptr);
+	spin_unlock_irqrestore(&priv->lock, flags);
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
+	spin_lock_irqsave(&priv->lock, flags);
+	writel_relaxed(readl_relaxed(ptr) | AMD_FCH_GPIO_FLAG_DIRECTION, ptr);
+	spin_unlock_irqrestore(&priv->lock, flags);
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
+	spin_lock_irqsave(&priv->lock, flags);
+	ret = (readl_relaxed(ptr) & AMD_FCH_GPIO_FLAG_DIRECTION);
+	spin_unlock_irqrestore(&priv->lock, flags);
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
+	u32 mask;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	mask = readl_relaxed(ptr);
+	if (value)
+		mask |= AMD_FCH_GPIO_FLAG_WRITE;
+	else
+		mask &= ~AMD_FCH_GPIO_FLAG_WRITE;
+	writel_relaxed(mask, ptr);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
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
+	spin_lock_irqsave(&priv->lock, flags);
+	ret = (readl_relaxed(ptr) & AMD_FCH_GPIO_FLAG_READ);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
+static int amd_fch_gpio_request(struct gpio_chip *chip,
+				unsigned int gpio_pin)
+{
+	return 0;
+}
+
+static int amd_fch_gpio_probe(struct platform_device *pdev)
+{
+	struct amd_fch_gpio_priv *priv;
+	struct amd_fch_gpio_pdata *pdata;
+
+	pdata = dev_get_platdata(&pdev->dev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform_data\n");
+		return -ENOENT;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
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
+	priv->gc.base			= -1;
+	priv->gc.request		= amd_fch_gpio_request;
+	priv->gc.direction_input	= amd_fch_gpio_direction_input;
+	priv->gc.direction_output	= amd_fch_gpio_direction_output;
+	priv->gc.get_direction		= amd_fch_gpio_get_direction;
+	priv->gc.get			= amd_fch_gpio_get;
+	priv->gc.set			= amd_fch_gpio_set;
+
+	spin_lock_init(&priv->lock);
+
+	priv->base = devm_ioremap_resource(&pdev->dev, &amd_fch_gpio_iores);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
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

