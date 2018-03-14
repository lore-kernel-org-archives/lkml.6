Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeCNQcD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:32:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44697 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeCNQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:32:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH 1/2] mtd: maps: remove bfin-async-flash driver
Date: Wed, 14 Mar 2018 17:30:22 +0100
Message-Id: <20180314163106.375231-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:hNEz6c5V5ZM4uVrKjHmp3sng9ILEM7F8GmnF/vCR2ZriqF5MbNp
 iQahc/IGTt5u7FqRmRCzGpVALeNKxdYdsBGt8oqJZd3dFqJMi6cXTVGJLRoOoZ4vJjUIL0o
 H0Lgsk5FyfwnZ1cHkIoU/1EPvuY1Vvx0Y/6/FFjZbCfq/hj4PnOJp9EkJ0LndPv7CroWCFY
 yrqC+faZcOcEsvs0q3JUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o+sy+2qW+z8=:d7maai+VYniwVQpMjXwPAB
 BUkeVbYNWNJwe4ZtbfaTEyUnVBIkKgtyJuKoO2n6iZgPi/uGTaBKw+YiXd+allVteXtHuQ/do
 qhRSfVibn9QttYR3cVgfkZWRsks6aMFpH17Urq9dyM7QhD4YSXUf+WXh7FJrxr2xsKVtCKv6a
 PgEo96r9Cnkyq3PtJgeWW/k06ZHFVBvrQpGA5sy5YRMaqj9nH8nSUFIJb07vb6iM7LiskM9Ah
 9bYLER/NYs9GOjK/Jf3SNVrxR0CIBAdUcAIY5/YvRmqloDSCC1LREcnrXDMcv5F1CSImMD8fE
 QR2m9SbOo5qMiJOldz+3+ERIW4Wq1p7FZ5REOBKqE3lxuDtFxwnZ5Mu2t4WBDcexJ1agAhj1m
 BSjBOhVLVXJfaUsgmnjkesHWD4wenIhh4q0i79JSeqM29gwmScs8LQTZD5fQrFTXa8fFXE+vo
 sFepPd3UcchV48gKBAPQf3kSklpJjg7iKBF6jy2wUTfYaikX3os2AsYGVKTU6AGigqSqK+nPI
 m5/0tv5AR59x4H9XCF7igBJ56EJnqFO4y6fZv4I8H1b3UUYKkNAr887thJABwDCQEA23smt6h
 SMDiCLgIfoXKIcjbeQw3kLKA7whhXjQE0SOQGNTW4VMlghr90+bPu7qcE8OzOzVi+g8FELRSn
 te/t2LTmlWiCawOCE4N7rpb/f95L5DUeDUgbWxSDt6Nx6K7op1KzhoANR022GmceO6Nt5vU8b
 txpz3n5CY0lQMKzB2R/Hz17XZW3BQ/+TPkUt2w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so this driver
has become obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/maps/Kconfig            |  10 --
 drivers/mtd/maps/Makefile           |   1 -
 drivers/mtd/maps/bfin-async-flash.c | 196 ------------------------------------
 3 files changed, 207 deletions(-)
 delete mode 100644 drivers/mtd/maps/bfin-async-flash.c
---
Sending these two patches separately, as the NAND driver patch
has a nasty conflict with the directory move. Please pick
up both into the mtd tree.
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 542fdf8e81fa..bdc1283f30fb 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -334,16 +334,6 @@ config MTD_PCMCIA_ANONYMOUS
 
 	  If unsure, say N.
 
-config MTD_BFIN_ASYNC
-	tristate "Blackfin BF533-STAMP Flash Chip Support"
-	depends on BFIN533_STAMP && MTD_CFI && MTD_COMPLEX_MAPPINGS
-	default y
-	help
-	  Map driver which allows for simultaneous utilization of
-	  ethernet and CFI parallel flash.
-
-	  If compiled as a module, it will be called bfin-async-flash.
-
 config MTD_GPIO_ADDR
 	tristate "GPIO-assisted Flash Chip Support"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index b849aaf85c34..51acf1fec19b 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -42,7 +42,6 @@ obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
 obj-$(CONFIG_MTD_IXP4XX)	+= ixp4xx.o
 obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
-obj-$(CONFIG_MTD_BFIN_ASYNC)	+= bfin-async-flash.o
 obj-$(CONFIG_MTD_RBTX4939)	+= rbtx4939-flash.o
 obj-$(CONFIG_MTD_VMU)		+= vmu-flash.o
 obj-$(CONFIG_MTD_GPIO_ADDR)	+= gpio-addr-flash.o
diff --git a/drivers/mtd/maps/bfin-async-flash.c b/drivers/mtd/maps/bfin-async-flash.c
deleted file mode 100644
index 41730feeace8..000000000000
--- a/drivers/mtd/maps/bfin-async-flash.c
+++ /dev/null
@@ -1,196 +0,0 @@
-/*
- * drivers/mtd/maps/bfin-async-flash.c
- *
- * Handle the case where flash memory and ethernet mac/phy are
- * mapped onto the same async bank.  The BF533-STAMP does this
- * for example.  All board-specific configuration goes in your
- * board resources file.
- *
- * Copyright 2000 Nicolas Pitre <nico@fluxnic.net>
- * Copyright 2005-2008 Analog Devices Inc.
- *
- * Enter bugs at http://blackfin.uclinux.org/
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-
-#include <asm/blackfin.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-#include <asm/unaligned.h>
-
-#define pr_devinit(fmt, args...) \
-		({ static const char __fmt[] = fmt; printk(__fmt, ## args); })
-
-#define DRIVER_NAME "bfin-async-flash"
-
-struct async_state {
-	struct mtd_info *mtd;
-	struct map_info map;
-	int enet_flash_pin;
-	uint32_t flash_ambctl0, flash_ambctl1;
-	uint32_t save_ambctl0, save_ambctl1;
-	unsigned long irq_flags;
-};
-
-static void switch_to_flash(struct async_state *state)
-{
-	local_irq_save(state->irq_flags);
-
-	gpio_set_value(state->enet_flash_pin, 0);
-
-	state->save_ambctl0 = bfin_read_EBIU_AMBCTL0();
-	state->save_ambctl1 = bfin_read_EBIU_AMBCTL1();
-	bfin_write_EBIU_AMBCTL0(state->flash_ambctl0);
-	bfin_write_EBIU_AMBCTL1(state->flash_ambctl1);
-	SSYNC();
-}
-
-static void switch_back(struct async_state *state)
-{
-	bfin_write_EBIU_AMBCTL0(state->save_ambctl0);
-	bfin_write_EBIU_AMBCTL1(state->save_ambctl1);
-	SSYNC();
-
-	gpio_set_value(state->enet_flash_pin, 1);
-
-	local_irq_restore(state->irq_flags);
-}
-
-static map_word bfin_flash_read(struct map_info *map, unsigned long ofs)
-{
-	struct async_state *state = (struct async_state *)map->map_priv_1;
-	uint16_t word;
-	map_word test;
-
-	switch_to_flash(state);
-
-	word = readw(map->virt + ofs);
-
-	switch_back(state);
-
-	test.x[0] = word;
-	return test;
-}
-
-static void bfin_flash_copy_from(struct map_info *map, void *to, unsigned long from, ssize_t len)
-{
-	struct async_state *state = (struct async_state *)map->map_priv_1;
-
-	switch_to_flash(state);
-
-	memcpy(to, map->virt + from, len);
-
-	switch_back(state);
-}
-
-static void bfin_flash_write(struct map_info *map, map_word d1, unsigned long ofs)
-{
-	struct async_state *state = (struct async_state *)map->map_priv_1;
-	uint16_t d;
-
-	d = d1.x[0];
-
-	switch_to_flash(state);
-
-	writew(d, map->virt + ofs);
-	SSYNC();
-
-	switch_back(state);
-}
-
-static void bfin_flash_copy_to(struct map_info *map, unsigned long to, const void *from, ssize_t len)
-{
-	struct async_state *state = (struct async_state *)map->map_priv_1;
-
-	switch_to_flash(state);
-
-	memcpy(map->virt + to, from, len);
-	SSYNC();
-
-	switch_back(state);
-}
-
-static const char * const part_probe_types[] = {
-	"cmdlinepart", "RedBoot", NULL };
-
-static int bfin_flash_probe(struct platform_device *pdev)
-{
-	struct physmap_flash_data *pdata = dev_get_platdata(&pdev->dev);
-	struct resource *memory = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct resource *flash_ambctl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	struct async_state *state;
-
-	state = kzalloc(sizeof(*state), GFP_KERNEL);
-	if (!state)
-		return -ENOMEM;
-
-	state->map.name       = DRIVER_NAME;
-	state->map.read       = bfin_flash_read;
-	state->map.copy_from  = bfin_flash_copy_from;
-	state->map.write      = bfin_flash_write;
-	state->map.copy_to    = bfin_flash_copy_to;
-	state->map.bankwidth  = pdata->width;
-	state->map.size       = resource_size(memory);
-	state->map.virt       = (void __iomem *)memory->start;
-	state->map.phys       = memory->start;
-	state->map.map_priv_1 = (unsigned long)state;
-	state->enet_flash_pin = platform_get_irq(pdev, 0);
-	state->flash_ambctl0  = flash_ambctl->start;
-	state->flash_ambctl1  = flash_ambctl->end;
-
-	if (gpio_request(state->enet_flash_pin, DRIVER_NAME)) {
-		pr_devinit(KERN_ERR DRIVER_NAME ": Failed to request gpio %d\n", state->enet_flash_pin);
-		kfree(state);
-		return -EBUSY;
-	}
-	gpio_direction_output(state->enet_flash_pin, 1);
-
-	pr_devinit(KERN_NOTICE DRIVER_NAME ": probing %d-bit flash bus\n", state->map.bankwidth * 8);
-	state->mtd = do_map_probe(memory->name, &state->map);
-	if (!state->mtd) {
-		gpio_free(state->enet_flash_pin);
-		kfree(state);
-		return -ENXIO;
-	}
-
-	mtd_device_parse_register(state->mtd, part_probe_types, NULL,
-				  pdata->parts, pdata->nr_parts);
-
-	platform_set_drvdata(pdev, state);
-
-	return 0;
-}
-
-static int bfin_flash_remove(struct platform_device *pdev)
-{
-	struct async_state *state = platform_get_drvdata(pdev);
-	gpio_free(state->enet_flash_pin);
-	mtd_device_unregister(state->mtd);
-	map_destroy(state->mtd);
-	kfree(state);
-	return 0;
-}
-
-static struct platform_driver bfin_flash_driver = {
-	.probe		= bfin_flash_probe,
-	.remove		= bfin_flash_remove,
-	.driver		= {
-		.name	= DRIVER_NAME,
-	},
-};
-
-module_platform_driver(bfin_flash_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MTD map driver for Blackfins with flash/ethernet on same async bank");
-- 
2.9.0
