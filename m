Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76DDC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E18D21477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvRF2GUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E18D21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJDTyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:54:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37778 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeJDTyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:54:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id 63-v6so8297373ljs.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHQLBfV+yfk3eYHXazJUVHPKq/BnSdiyfyS6/G9izco=;
        b=gvRF2GUOUGY1LCejxNnxrNqRPwqM9c4nPMyo4L153JtPbon3RvbQpdt2te1CcC229I
         CgYWalhTe1CfzEL411QYSkYhR5TVx+hF5va3d2Sim0vH+I3IyTiC4Jdsa3CFCNtEkAh3
         SGZLtB3e1487mE9g+LMycsOsD/SM444PCX092N8FBLZkXoy2vyRi8ffUEL2vGE2xdfzW
         VZq3gnvoXwbLDE5BcGGwkHMOxSheuv6T/Ht6KYHhsMAS4ppYVA1g8r8O/RRVNQhf9i2i
         9O57/1j635LljEbapGMocqgj1kMdy1Nj5rTvrylkkC2ItsijKT1pWL4y+jliFaYhVpw0
         o/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHQLBfV+yfk3eYHXazJUVHPKq/BnSdiyfyS6/G9izco=;
        b=B7wTKyWej0oG9y6m8CJdh5hyejS6JxbCx4NDydorTdhi58HZLC74kgBzQO/ZRH6ryt
         NcsucYVHDk7av+eYWmGIAtIRxwRrBTvR63EuLLH+lPXsp7yDzKRoAeHK1+aOPOHbuAZL
         n0dU4g/n5SoY20g6w/s7L5CdVXaXDvNDsP4GVdM/ZSgqRE+F24v+WeBHB8qnOhaXjhzJ
         Jf1wvy9O9zoW8Z5LjKTYRzGRQhkMhzURh12LodqNzS9xCxU69Ac3XF0j27PdJo4NY5OS
         tqstHPNKWm9rreyEEvjaFdwS9qfVC5L6dsk/f/TWlcrztO5TCPmrOR+/Xd4a75Vv0LIX
         +VJg==
X-Gm-Message-State: ABuFfogeL5z5TTWCg8vQ7D4jJvPBhZ3DwANzyapQwl36pOk0AXHbDi9a
        f+h/qAdyi/vqp7wZQf0MRvM=
X-Google-Smtp-Source: ACcGV63/e0l2F+urYHzklIkwOZg4CfGhDn7umQtndhXvfaCQH48zDChsmZrxv2BGGs+Ps4OswtpjLg==
X-Received: by 2002:a2e:1642:: with SMTP id 2-v6mr4216219ljw.56.1538658099664;
        Thu, 04 Oct 2018 06:01:39 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a1-v6sm421415lfk.63.2018.10.04.06.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:01:38 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v6 10/10] mtd: maps: gpio-addr-flash: Add support for device-tree devices
Date:   Thu,  4 Oct 2018 15:01:10 +0200
Message-Id: <20181004130110.8496-10-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow creating gpio-addr-flash via device-tree and not just via platform
data.

Mimic what physmap_of_versatile and physmap_of_gemini does to reduce
code duplicity.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/Kconfig           |  8 +++
 drivers/mtd/maps/Makefile          |  3 +-
 drivers/mtd/maps/gpio-addr-flash.c | 91 ++++++++++++++++++------------
 drivers/mtd/maps/gpio-addr-flash.h | 31 ++++++++++
 drivers/mtd/maps/physmap_of_core.c |  7 +++
 drivers/mtd/maps/physmap_of_gpio.c | 24 ++++++++
 6 files changed, 127 insertions(+), 37 deletions(-)
 create mode 100644 drivers/mtd/maps/gpio-addr-flash.h
 create mode 100644 drivers/mtd/maps/physmap_of_gpio.c

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index afb36bff13a7..427143d42168 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -94,6 +94,14 @@ config MTD_PHYSMAP_OF_GEMINI
 	  platforms, some detection and setting up parallel mode on the
 	  external interface.
 
+config MTD_PHYSMAP_OF_GPIO
+	bool "GPIO-assisted OF-based physical memory map handling"
+	depends on MTD_PHYSMAP_OF
+	depends on MTD_GPIO_ADDR
+	help
+	  This provides some extra DT physmap parsing for flashes that are
+	  partially physically addressed and assisted by GPIOs.
+
 config MTD_PMC_MSP_EVM
 	tristate "CFI Flash device mapped on PMC-Sierra MSP"
 	depends on PMC_MSP && MTD_CFI
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 51acf1fec19b..c232ccf05bee 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_MTD_PHYSMAP)	+= physmap.o
 physmap_of-objs-y		+= physmap_of_core.o
 physmap_of-objs-$(CONFIG_MTD_PHYSMAP_OF_VERSATILE) += physmap_of_versatile.o
 physmap_of-objs-$(CONFIG_MTD_PHYSMAP_OF_GEMINI) += physmap_of_gemini.o
+physmap_of-objs-$(CONFIG_MTD_PHYSMAP_OF_GPIO) += physmap_of_gpio.o
 physmap_of-objs			:= $(physmap_of-objs-y)
 obj-$(CONFIG_MTD_PHYSMAP_OF)	+= physmap_of.o
 obj-$(CONFIG_MTD_PISMO)		+= pismo.o
@@ -44,6 +45,6 @@ obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
 obj-$(CONFIG_MTD_RBTX4939)	+= rbtx4939-flash.o
 obj-$(CONFIG_MTD_VMU)		+= vmu-flash.o
-obj-$(CONFIG_MTD_GPIO_ADDR)	+= gpio-addr-flash.o
+obj-$(CONFIG_MTD_GPIO_ADDR)    += gpio-addr-flash.o
 obj-$(CONFIG_MTD_LATCH_ADDR)	+= latch-addr-flash.o
 obj-$(CONFIG_MTD_LANTIQ)	+= lantiq-flash.o
diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index a20e85aa770e..7837fc7b8de8 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -25,25 +25,25 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include "gpio-addr-flash.h"
 
 #define win_mask(x) ((BIT(x)) - 1)
 
 #define DRIVER_NAME "gpio-addr-flash"
 
+#define gf_map_info_to_state(mi) ((struct async_state *)(mi)->map_priv_1)
+
 /**
- * struct async_state - keep GPIO flash state
+ * struct async_state_pdev - Async state platform device
  *	@mtd:         MTD state for this mapping
  *	@map:         MTD map state for this flash
  *	@gpios:       Struct containing the array of GPIO descriptors
- *	@gpio_values: cached GPIO values
- *	@win_order:   dedicated memory size (if no GPIOs)
+ *	@state:       GPIO flash state
  */
-struct async_state {
+struct async_state_pdev {
 	struct mtd_info *mtd;
 	struct map_info map;
-	struct gpio_descs *gpios;
-	unsigned int gpio_values;
-	unsigned int win_order;
+	struct async_state state;
 };
 #define gf_map_info_to_state(mi) ((struct async_state *)(mi)->map_priv_1)
 
@@ -174,6 +174,31 @@ static void gf_copy_to(struct map_info *map, unsigned long to,
 static const char * const part_probe_types[] = {
 	"cmdlinepart", "RedBoot", NULL };
 
+int gpio_flash_probe_common(struct device *dev, struct async_state *state,
+			    struct map_info *map)
+{
+	if (!is_power_of_2(map->size)) {
+		dev_err(dev, "Window size must be aligned\n");
+		return -EIO;
+	}
+
+	state->gpios = devm_gpiod_get_array(dev, "addr", GPIOD_OUT_LOW);
+	if (IS_ERR(state->gpios))
+		return PTR_ERR(state->gpios);
+
+	state->win_order  = get_bitmask_order(map->size) - 1;
+	map->read       = gf_read;
+	map->copy_from  = gf_copy_from;
+	map->write      = gf_write;
+	map->copy_to    = gf_copy_to;
+	map->size       = BIT(state->win_order + state->gpios->ndescs);
+	map->phys	= NO_XIP;
+	map->map_priv_1 = (unsigned long)state;
+
+	return 0;
+}
+EXPORT_SYMBOL(gpio_flash_probe_common);
+
 /**
  * gpio_flash_probe() - setup a mapping for a GPIO assisted flash
  *	@pdev: platform device
@@ -210,7 +235,8 @@ static int gpio_flash_probe(struct platform_device *pdev)
 {
 	struct physmap_flash_data *pdata;
 	struct resource *memory;
-	struct async_state *state;
+	struct async_state_pdev *state_pdev;
+	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	memory = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -218,40 +244,33 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	if (!memory)
 		return -EINVAL;
 
-	state = devm_kzalloc(&pdev->dev, sizeof(*state), GFP_KERNEL);
-	if (!state)
+	state_pdev = devm_kzalloc(&pdev->dev, sizeof(*state_pdev), GFP_KERNEL);
+	if (!state_pdev)
 		return -ENOMEM;
 
-	state->gpios = devm_gpiod_get_array(&pdev->dev, "addr", GPIOD_OUT_LOW);
-	if (IS_ERR(state->gpios))
-		return PTR_ERR(state->gpios);
-
-	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
+	state_pdev->map.virt = devm_ioremap_resource(&pdev->dev, memory);
+	if (IS_ERR(state_pdev->map.virt))
+		return PTR_ERR(state_pdev->map.virt);
 
-	state->map.name       = DRIVER_NAME;
-	state->map.read       = gf_read;
-	state->map.copy_from  = gf_copy_from;
-	state->map.write      = gf_write;
-	state->map.copy_to    = gf_copy_to;
-	state->map.bankwidth  = pdata->width;
-	state->map.size       = BIT(state->win_order + state->gpios->ndescs);
-	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
-	if (IS_ERR(state->map.virt))
-		return PTR_ERR(state->map.virt);
+	state_pdev->map.name       = DRIVER_NAME;
+	state_pdev->map.bankwidth  = pdata->width;
+	state_pdev->map.size       = resource_size(memory);
 
-	state->map.phys       = NO_XIP;
-	state->map.map_priv_1 = (unsigned long)state;
+	ret = gpio_flash_probe_common(&pdev->dev, &state_pdev->state,
+				      &state_pdev->map);
+	if (ret)
+		return ret;
 
-	platform_set_drvdata(pdev, state);
+	platform_set_drvdata(pdev, state_pdev);
 
 	dev_notice(&pdev->dev, "probing %d-bit flash bus\n",
-		   state->map.bankwidth * 8);
-	state->mtd = do_map_probe(memory->name, &state->map);
-	if (!state->mtd)
+		   state_pdev->map.bankwidth * 8);
+	state_pdev->mtd = do_map_probe(memory->name, &state_pdev->map);
+	if (!state_pdev->mtd)
 		return -ENXIO;
-	state->mtd->dev.parent = &pdev->dev;
+	state_pdev->mtd->dev.parent = &pdev->dev;
 
-	mtd_device_parse_register(state->mtd, part_probe_types, NULL,
+	mtd_device_parse_register(state_pdev->mtd, part_probe_types, NULL,
 				  pdata->parts, pdata->nr_parts);
 
 	return 0;
@@ -259,10 +278,10 @@ static int gpio_flash_probe(struct platform_device *pdev)
 
 static int gpio_flash_remove(struct platform_device *pdev)
 {
-	struct async_state *state = platform_get_drvdata(pdev);
+	struct async_state_pdev *state_pdev = platform_get_drvdata(pdev);
 
-	mtd_device_unregister(state->mtd);
-	map_destroy(state->mtd);
+	mtd_device_unregister(state_pdev->mtd);
+	map_destroy(state_pdev->mtd);
 	return 0;
 }
 
diff --git a/drivers/mtd/maps/gpio-addr-flash.h b/drivers/mtd/maps/gpio-addr-flash.h
new file mode 100644
index 000000000000..46d97a8031eb
--- /dev/null
+++ b/drivers/mtd/maps/gpio-addr-flash.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/of.h>
+#include <linux/mtd/map.h>
+
+/**
+ * struct async_state - keep GPIO flash state
+ *	@gpios:       Struct containing the array of GPIO descriptors
+ *	@gpio_values: cached GPIO values
+ *	@win_order:   dedicated memory size (if no GPIOs)
+ */
+struct async_state {
+	struct gpio_descs *gpios;
+	unsigned int gpio_values;
+	unsigned int win_order;
+};
+
+int gpio_flash_probe_common(struct device *dev,
+				   struct async_state *state,
+				   struct map_info *map);
+
+#ifdef CONFIG_MTD_PHYSMAP_OF_GPIO
+int of_flash_probe_gpio(struct platform_device *pdev, struct device_node *np,
+			struct map_info *map);
+#else
+static inline
+int of_flash_probe_gpio(struct platform_device *pdev, struct device_node *np,
+			struct map_info *map)
+{
+	return 0;
+}
+#endif
diff --git a/drivers/mtd/maps/physmap_of_core.c b/drivers/mtd/maps/physmap_of_core.c
index 062add8b3a6e..19a300232969 100644
--- a/drivers/mtd/maps/physmap_of_core.c
+++ b/drivers/mtd/maps/physmap_of_core.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include "physmap_of_gemini.h"
 #include "physmap_of_versatile.h"
+#include "gpio-addr-flash.h"
 
 struct of_flash_list {
 	struct mtd_info *mtd;
@@ -257,6 +258,12 @@ static int of_flash_probe(struct platform_device *dev)
 
 		simple_map_init(&info->list[i].map);
 
+		err = of_flash_probe_gpio(dev, dp, &info->list[i].map);
+		if (err){
+			iounmap(info->list[i].map.virt);
+			goto err_out;
+		}
+
 		/*
 		 * On some platforms (e.g. MPC5200) a direct 1:1 mapping
 		 * may cause problems with JFFS2 usage, as the local bus (LPB)
diff --git a/drivers/mtd/maps/physmap_of_gpio.c b/drivers/mtd/maps/physmap_of_gpio.c
new file mode 100644
index 000000000000..97e02737ed67
--- /dev/null
+++ b/drivers/mtd/maps/physmap_of_gpio.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Qtechnology A/S
+ *
+ * Ricardo Ribalda <ricardo.ribalda@gmail.com>
+ *
+ */
+#include <linux/platform_device.h>
+#include "gpio-addr-flash.h"
+
+int of_flash_probe_gpio(struct platform_device *pdev, struct device_node *np,
+			struct map_info *map)
+{
+	struct async_state *state;
+
+	if (!of_device_is_compatible(np, "mtd,gpio-addr-flash"))
+		return 0;
+
+	state = devm_kzalloc(&pdev->dev, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	return gpio_flash_probe_common(&pdev->dev, state, map);
+}
-- 
2.19.0

