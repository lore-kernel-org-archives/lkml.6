Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2BFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406C6208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406C6208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934107AbeGJPVQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:21:16 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33573 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeGJPVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:21:14 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LqD3Y-1gGNzW3VD6-00dl2u; Tue, 10 Jul 2018 17:20:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NeilBrown <neil@brown.name>, John Crispin <blogic@openwrt.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] staging: mt7621-gpio: remove driver
Date:   Tue, 10 Jul 2018 17:18:48 +0200
Message-Id: <20180710151915.2282622-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180710151915.2282622-1-arnd@arndb.de>
References: <20180710151915.2282622-1-arnd@arndb.de>
X-Provags-ID: V03:K1:6bfxg8T33khO2egeUlFOYeveYbpFZnZ5d0De/k1mtts3hkCgHYS
 +BwQ2UKyiJB5BvVhLvzwlS2da+4mM3RhmrHwtScAbayyy4cXq6/5VgVvafDxI7JPM/64VK6
 BB5wrYv2OfVuV86yobXRNPz4g8nRpAeCzyH//Bccsk+bcyPEZtcJObYgdH3b01pxbWraknX
 KzWEWOCxKvZkNWt2u5NSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KSReERMPq1o=:2AY0pWPxAcP/kM/2n2TJ4L
 m3AJUTXdShmrRb/mQZ/OMuIvDeYvoXIkJrOOFSTiVXHMIyQOkZ5vKEa+Z45lCLNNesZbxEC7+
 /u8SzKz+y/wQL5TWu2lEegAs3KqaZ5pwxndLwc72yY5aWtY1jF3UCT9ljTHqhlbmGqmPa1xEU
 UPeNpLzdS3KGE9BIbKOOgxuMRSJNuw8QHbGmd2OCInfatba7o0+O9ztpIA5DBz7I7W4ziuQRd
 dJBZtUszjnHcCWG6UYEiw5DMY1sS8FMkW2+p0yQn/rMbUdTkwaaqCarN+QBPJ+mSCaj2+PfYu
 DACmOlbbwYPm96krLihzC/6ZKozqyntjAzq8p+v4/6mpv708sWAglVehNaFBN91UjRPnnNgAL
 uvzxzDcxK5OwypNpvrxM6lIIWDhYPWvKbi6SP5b/Ee84/4rVPpIWNYwVKwCaDnZ7+18bvEg/L
 9SD1Nm6EdnavHFKboF4W72uFSFQ+6EdQyfG1gV4pcL8pYaBfSR4Nd5j9aeoHzcfCs5pjxy3cA
 6i+HGsBuREaMvbMP4QFgUga76rie5HHa3Ck4JeCKqM2dTINUYrkwpX3B7Ud86nJqSJ1gBADmi
 NTUHGbq+QQEM3nMDBwNPjGNvsWTLZ/qIg6r+5dcfbgdLZIowPYYFWXn0dvgJ1KnNXIVgAdBv3
 zSj9qDdz+OkSm8FroTN6KCLjzL/ajcRrFTrI5vgUAwmlyOLBPjFDMgENBJKMS7OJjwLc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio-mt7621 driver has graduated out of staging and got accepted
into the gpio tree. Since they both use the same Kconfig symbol,
we could run into conflicts, e.g. I got this failure when the staging
driver got enabled with the other one being unavailable but using the
same Kconfig symbol:

drivers/gpio/gpio-mt7621.c: In function 'mediatek_gpio_bank_probe':
drivers/gpio/gpio-mt7621.c:228:10: error: 'struct gpio_chip' has no member named 'of_node'
  rg->chip.of_node = node;
          ^
drivers/gpio/gpio-mt7621.c:243:10: error: 'struct gpio_chip' has no member named 'of_gpio_n_cells'
  rg->chip.of_gpio_n_cells = 2;
          ^
drivers/gpio/gpio-mt7621.c:244:10: error: 'struct gpio_chip' has no member named 'of_xlate'
  rg->chip.of_xlate = mediatek_gpio_xlate;

It would be trivial to rename the Kconfig symbol to avoid that problem,
but there is also seems to be little value in keeping the staging driver
around now.

Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/Kconfig                            |   2 -
 drivers/staging/Makefile                           |   1 -
 drivers/staging/mt7621-gpio/Kconfig                |   8 -
 drivers/staging/mt7621-gpio/Makefile               |   3 -
 drivers/staging/mt7621-gpio/TODO                   |   3 -
 drivers/staging/mt7621-gpio/gpio-mt7621.c          | 331 ---------------------
 .../staging/mt7621-gpio/mediatek,mt7621-gpio.txt   |  35 ---
 7 files changed, 383 deletions(-)
 delete mode 100644 drivers/staging/mt7621-gpio/Kconfig
 delete mode 100644 drivers/staging/mt7621-gpio/Makefile
 delete mode 100644 drivers/staging/mt7621-gpio/TODO
 delete mode 100644 drivers/staging/mt7621-gpio/gpio-mt7621.c
 delete mode 100644 drivers/staging/mt7621-gpio/mediatek,mt7621-gpio.txt

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 9339af2fb51e..bbb0232c7f8e 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -110,8 +110,6 @@ source "drivers/staging/pi433/Kconfig"
 
 source "drivers/staging/mt7621-pinctrl/Kconfig"
 
-source "drivers/staging/mt7621-gpio/Kconfig"
-
 source "drivers/staging/mt7621-spi/Kconfig"
 
 source "drivers/staging/mt7621-dma/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index aa40b1f4cea4..9b381e037e54 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -46,7 +46,6 @@ obj-$(CONFIG_DRM_VBOXVIDEO)	+= vboxvideo/
 obj-$(CONFIG_PI433)		+= pi433/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-pci/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-pinctrl/
-obj-$(CONFIG_SOC_MT7621)	+= mt7621-gpio/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-spi/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dma/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-mmc/
diff --git a/drivers/staging/mt7621-gpio/Kconfig b/drivers/staging/mt7621-gpio/Kconfig
deleted file mode 100644
index 5485dd2d9b61..000000000000
--- a/drivers/staging/mt7621-gpio/Kconfig
+++ /dev/null
@@ -1,8 +0,0 @@
-config GPIO_MT7621
-	bool "Mediatek MT7621 GPIO Support"
-	depends on SOC_MT7620 || SOC_MT7621 || COMPILE_TEST
-	select GPIO_GENERIC
-	select GPIOLIB_IRQCHIP
-	select ARCH_REQUIRE_GPIOLIB
-	help
-	  Say yes here to support the Mediatek MT7621 SoC GPIO device
diff --git a/drivers/staging/mt7621-gpio/Makefile b/drivers/staging/mt7621-gpio/Makefile
deleted file mode 100644
index e269ab1b8717..000000000000
--- a/drivers/staging/mt7621-gpio/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-$(CONFIG_GPIO_MT7621)	+= gpio-mt7621.o
-
-ccflags-y += -I$(srctree)/$(src)/include
diff --git a/drivers/staging/mt7621-gpio/TODO b/drivers/staging/mt7621-gpio/TODO
deleted file mode 100644
index 674930a10716..000000000000
--- a/drivers/staging/mt7621-gpio/TODO
+++ /dev/null
@@ -1,3 +0,0 @@
-- general code review and clean up
-
-Cc:  NeilBrown <neil@brown.name>
diff --git a/drivers/staging/mt7621-gpio/gpio-mt7621.c b/drivers/staging/mt7621-gpio/gpio-mt7621.c
deleted file mode 100644
index d7256b56e621..000000000000
--- a/drivers/staging/mt7621-gpio/gpio-mt7621.c
+++ /dev/null
@@ -1,331 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/err.h>
-#include <linux/gpio/driver.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of_irq.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
-
-#define MTK_BANK_CNT	3
-#define MTK_BANK_WIDTH	32
-
-#define GPIO_BANK_WIDE	0x04
-#define GPIO_REG_CTRL	0x00
-#define GPIO_REG_POL	0x10
-#define GPIO_REG_DATA	0x20
-#define GPIO_REG_DSET	0x30
-#define GPIO_REG_DCLR	0x40
-#define GPIO_REG_REDGE	0x50
-#define GPIO_REG_FEDGE	0x60
-#define GPIO_REG_HLVL	0x70
-#define GPIO_REG_LLVL	0x80
-#define GPIO_REG_STAT	0x90
-#define GPIO_REG_EDGE	0xA0
-
-struct mtk_gc {
-	struct gpio_chip chip;
-	spinlock_t lock;
-	int bank;
-	u32 rising;
-	u32 falling;
-	u32 hlevel;
-	u32 llevel;
-};
-
-/**
- * struct mtk_data - state container for
- * data of the platform driver. It is 3
- * separate gpio-chip each one with its
- * own irq_chip.
- * @dev: device instance
- * @gpio_membase: memory base address
- * @gpio_irq: irq number from the device tree
- * @gc_map: array of the gpio chips
- */
-struct mtk_data {
-	struct device *dev;
-	void __iomem *gpio_membase;
-	int gpio_irq;
-	struct mtk_gc gc_map[MTK_BANK_CNT];
-};
-
-static inline struct mtk_gc *
-to_mediatek_gpio(struct gpio_chip *chip)
-{
-	return container_of(chip, struct mtk_gc, chip);
-}
-
-static inline void
-mtk_gpio_w32(struct mtk_gc *rg, u32 offset, u32 val)
-{
-	struct gpio_chip *gc = &rg->chip;
-	struct mtk_data *gpio_data = gpiochip_get_data(gc);
-
-	offset = (rg->bank * GPIO_BANK_WIDE) + offset;
-	gc->write_reg(gpio_data->gpio_membase + offset, val);
-}
-
-static inline u32
-mtk_gpio_r32(struct mtk_gc *rg, u32 offset)
-{
-	struct gpio_chip *gc = &rg->chip;
-	struct mtk_data *gpio_data = gpiochip_get_data(gc);
-
-	offset = (rg->bank * GPIO_BANK_WIDE) + offset;
-	return gc->read_reg(gpio_data->gpio_membase + offset);
-}
-
-static irqreturn_t
-mediatek_gpio_irq_handler(int irq, void *data)
-{
-	struct gpio_chip *gc = data;
-	struct mtk_gc *rg = to_mediatek_gpio(gc);
-	irqreturn_t ret = IRQ_NONE;
-	unsigned long pending;
-	int bit;
-
-	pending = mtk_gpio_r32(rg, GPIO_REG_STAT);
-
-	for_each_set_bit(bit, &pending, MTK_BANK_WIDTH) {
-		u32 map = irq_find_mapping(gc->irq.domain, bit);
-
-		generic_handle_irq(map);
-		mtk_gpio_w32(rg, GPIO_REG_STAT, BIT(bit));
-		ret |= IRQ_HANDLED;
-	}
-
-	return ret;
-}
-
-static void
-mediatek_gpio_irq_unmask(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct mtk_gc *rg = to_mediatek_gpio(gc);
-	int pin = d->hwirq;
-	unsigned long flags;
-	u32 rise, fall, high, low;
-
-	spin_lock_irqsave(&rg->lock, flags);
-	rise = mtk_gpio_r32(rg, GPIO_REG_REDGE);
-	fall = mtk_gpio_r32(rg, GPIO_REG_FEDGE);
-	high = mtk_gpio_r32(rg, GPIO_REG_HLVL);
-	low = mtk_gpio_r32(rg, GPIO_REG_LLVL);
-	mtk_gpio_w32(rg, GPIO_REG_REDGE, rise | (BIT(pin) & rg->rising));
-	mtk_gpio_w32(rg, GPIO_REG_FEDGE, fall | (BIT(pin) & rg->falling));
-	mtk_gpio_w32(rg, GPIO_REG_HLVL, high | (BIT(pin) & rg->hlevel));
-	mtk_gpio_w32(rg, GPIO_REG_LLVL, low | (BIT(pin) & rg->llevel));
-	spin_unlock_irqrestore(&rg->lock, flags);
-}
-
-static void
-mediatek_gpio_irq_mask(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct mtk_gc *rg = to_mediatek_gpio(gc);
-	int pin = d->hwirq;
-	unsigned long flags;
-	u32 rise, fall, high, low;
-
-	spin_lock_irqsave(&rg->lock, flags);
-	rise = mtk_gpio_r32(rg, GPIO_REG_REDGE);
-	fall = mtk_gpio_r32(rg, GPIO_REG_FEDGE);
-	high = mtk_gpio_r32(rg, GPIO_REG_HLVL);
-	low = mtk_gpio_r32(rg, GPIO_REG_LLVL);
-	mtk_gpio_w32(rg, GPIO_REG_FEDGE, fall & ~BIT(pin));
-	mtk_gpio_w32(rg, GPIO_REG_REDGE, rise & ~BIT(pin));
-	mtk_gpio_w32(rg, GPIO_REG_HLVL, high & ~BIT(pin));
-	mtk_gpio_w32(rg, GPIO_REG_LLVL, low & ~BIT(pin));
-	spin_unlock_irqrestore(&rg->lock, flags);
-}
-
-static int
-mediatek_gpio_irq_type(struct irq_data *d, unsigned int type)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct mtk_gc *rg = to_mediatek_gpio(gc);
-	int pin = d->hwirq;
-	u32 mask = BIT(pin);
-
-	if (type == IRQ_TYPE_PROBE) {
-		if ((rg->rising | rg->falling |
-		     rg->hlevel | rg->llevel) & mask)
-			return 0;
-
-		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
-	}
-
-	rg->rising &= ~mask;
-	rg->falling &= ~mask;
-	rg->hlevel &= ~mask;
-	rg->llevel &= ~mask;
-
-	switch (type & IRQ_TYPE_SENSE_MASK) {
-	case IRQ_TYPE_EDGE_BOTH:
-		rg->rising |= mask;
-		rg->falling |= mask;
-		break;
-	case IRQ_TYPE_EDGE_RISING:
-		rg->rising |= mask;
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		rg->falling |= mask;
-		break;
-	case IRQ_TYPE_LEVEL_HIGH:
-		rg->hlevel |= mask;
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-		rg->llevel |= mask;
-		break;
-	}
-
-	return 0;
-}
-
-static struct irq_chip mediatek_gpio_irq_chip = {
-	.irq_unmask		= mediatek_gpio_irq_unmask,
-	.irq_mask		= mediatek_gpio_irq_mask,
-	.irq_mask_ack		= mediatek_gpio_irq_mask,
-	.irq_set_type		= mediatek_gpio_irq_type,
-};
-
-static int
-mediatek_gpio_xlate(struct gpio_chip *chip,
-		    const struct of_phandle_args *spec, u32 *flags)
-{
-	int gpio = spec->args[0];
-	struct mtk_gc *rg = to_mediatek_gpio(chip);
-
-	if (rg->bank != gpio / MTK_BANK_WIDTH)
-		return -EINVAL;
-
-	if (flags)
-		*flags = spec->args[1];
-
-	return gpio % MTK_BANK_WIDTH;
-}
-
-static int
-mediatek_gpio_bank_probe(struct platform_device *pdev,
-			 struct device_node *node, int bank)
-{
-	struct mtk_data *gpio = dev_get_drvdata(&pdev->dev);
-	struct mtk_gc *rg;
-	void __iomem *dat, *set, *ctrl, *diro;
-	int ret;
-
-	rg = &gpio->gc_map[bank];
-	memset(rg, 0, sizeof(*rg));
-
-	spin_lock_init(&rg->lock);
-	rg->chip.of_node = node;
-	rg->bank = bank;
-
-	dat = gpio->gpio_membase + GPIO_REG_DATA + (rg->bank * GPIO_BANK_WIDE);
-	set = gpio->gpio_membase + GPIO_REG_DSET + (rg->bank * GPIO_BANK_WIDE);
-	ctrl = gpio->gpio_membase + GPIO_REG_DCLR + (rg->bank * GPIO_BANK_WIDE);
-	diro = gpio->gpio_membase + GPIO_REG_CTRL + (rg->bank * GPIO_BANK_WIDE);
-
-	ret = bgpio_init(&rg->chip, &pdev->dev, 4,
-			 dat, set, ctrl, diro, NULL, 0);
-	if (ret) {
-		dev_err(&pdev->dev, "bgpio_init() failed\n");
-		return ret;
-	}
-
-	rg->chip.of_gpio_n_cells = 2;
-	rg->chip.of_xlate = mediatek_gpio_xlate;
-	rg->chip.label = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-bank%d",
-					dev_name(&pdev->dev), bank);
-
-	ret = devm_gpiochip_add_data(&pdev->dev, &rg->chip, gpio);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Could not register gpio %d, ret=%d\n",
-			rg->chip.ngpio, ret);
-		return ret;
-	}
-
-	if (gpio->gpio_irq) {
-		/*
-		 * Manually request the irq here instead of passing
-		 * a flow-handler to gpiochip_set_chained_irqchip,
-		 * because the irq is shared.
-		 */
-		ret = devm_request_irq(&pdev->dev, gpio->gpio_irq,
-				       mediatek_gpio_irq_handler, IRQF_SHARED,
-				       rg->chip.label, &rg->chip);
-
-		if (ret) {
-			dev_err(&pdev->dev, "Error requesting IRQ %d: %d\n",
-				gpio->gpio_irq, ret);
-			return ret;
-		}
-
-		ret = gpiochip_irqchip_add(&rg->chip, &mediatek_gpio_irq_chip,
-					   0, handle_simple_irq, IRQ_TYPE_NONE);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to add gpiochip_irqchip\n");
-			return ret;
-		}
-
-		gpiochip_set_chained_irqchip(&rg->chip, &mediatek_gpio_irq_chip,
-					     gpio->gpio_irq, NULL);
-	}
-
-	/* set polarity to low for all gpios */
-	mtk_gpio_w32(rg, GPIO_REG_POL, 0);
-
-	dev_info(&pdev->dev, "registering %d gpios\n", rg->chip.ngpio);
-
-	return 0;
-}
-
-static int
-mediatek_gpio_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct mtk_data *gpio_data;
-	int i;
-
-	gpio_data = devm_kzalloc(&pdev->dev, sizeof(*gpio_data), GFP_KERNEL);
-	if (!gpio_data)
-		return -ENOMEM;
-
-	gpio_data->gpio_membase = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(gpio_data->gpio_membase))
-		return PTR_ERR(gpio_data->gpio_membase);
-
-	gpio_data->gpio_irq = irq_of_parse_and_map(np, 0);
-	gpio_data->dev = &pdev->dev;
-	platform_set_drvdata(pdev, gpio_data);
-	mediatek_gpio_irq_chip.name = dev_name(&pdev->dev);
-
-	for (i = 0; i < MTK_BANK_CNT; i++)
-		mediatek_gpio_bank_probe(pdev, np, i);
-
-	return 0;
-}
-
-static const struct of_device_id mediatek_gpio_match[] = {
-	{ .compatible = "mediatek,mt7621-gpio" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, mediatek_gpio_match);
-
-static struct platform_driver mediatek_gpio_driver = {
-	.probe = mediatek_gpio_probe,
-	.driver = {
-		.name = "mt7621_gpio",
-		.of_match_table = mediatek_gpio_match,
-	},
-};
-
-builtin_platform_driver(mediatek_gpio_driver);
diff --git a/drivers/staging/mt7621-gpio/mediatek,mt7621-gpio.txt b/drivers/staging/mt7621-gpio/mediatek,mt7621-gpio.txt
deleted file mode 100644
index ba455589f869..000000000000
--- a/drivers/staging/mt7621-gpio/mediatek,mt7621-gpio.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Mediatek MT7621 SoC GPIO controller bindings
-
-The IP core used inside these SoCs has 3 banks of 32 GPIOs each.
-The registers of all the banks are interwoven inside one single IO range.
-We load one GPIO controller instance per bank. Also the GPIO controller can receive
-interrupts on any of the GPIOs, either edge or level. It then interrupts the CPU
-using GIC INT12.
-
-Required properties for the top level node:
-- #gpio-cells : Should be two. The first cell is the GPIO pin number and the
-   second cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
-   Only the GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
-- #interrupt-cells : Specifies the number of cells needed to encode an
-   interrupt. Should be 2. The first cell defines the interrupt number,
-   the second encodes the triger flags encoded as described in
-   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-- compatible:
-  - "mediatek,mt7621-gpio" for Mediatek controllers
-- reg : Physical base address and length of the controller's registers
-- interrupt-parent : phandle of the parent interrupt controller.
-- interrupts : Interrupt specifier for the controllers interrupt.
-- interrupt-controller : Mark the device node as an interrupt controller.
-- gpio-controller : Marks the device node as a GPIO controller.
-
-Example:
-	gpio@600 {
-		#gpio-cells = <2>;
-		#interrupt-cells = <2>;
-		compatible = "mediatek,mt7621-gpio";
-		gpio-controller;
-		interrupt-controller;
-		reg = <0x600 0x100>;
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_SHARED 12 IRQ_TYPE_LEVEL_HIGH>;
-	};
-- 
2.9.0

