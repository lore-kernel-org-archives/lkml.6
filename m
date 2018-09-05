Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71C1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D75420869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd1syuML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D75420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeIETHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:07:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41739 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeIETHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:07:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so6262865edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qysgEDwCZBYrO7D/WpwgvxqwrchbKggI1k3d9jl/rJc=;
        b=cd1syuMLAy8aNvU1OBgX4bbTtPh/PUE4U2cPgom9USFM1CUOkenKxXuVG4RyLJduz7
         fpdu1V4C7l3ODyQMwBRnukGo8BZL5I5KwjrRyzGywyTl9Hfzsd6Z9egKsQCjD28w62zY
         f9BVcUnKMb/mernwcxd/FMzmxMGk4NJ+3432PEKmWd3iQEK5H2Oj11Fa6Fl+pER+avH9
         7rrnnQlVGPjO2Wc/+p/8qD8ROBbeMryfVJPPSbpHAs2AJslXdIfUy3P4wdIBb61Lf3bJ
         zENyRoe+PfkXc9W4FJGDE5lR0ux6foqxFndNk97LT50NOflA4m3dEhWC7dKM4rWnKakP
         TfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qysgEDwCZBYrO7D/WpwgvxqwrchbKggI1k3d9jl/rJc=;
        b=uP7QWPTOZM3LeUcGpXAbBrUMEjECAo+JmoTSj6CWQsTnGDwPv4g77SS0bNGes0agid
         gz3Wgb5Q1Drs0OFM8acXrezjGPb/qb/np6DAhdJHnJUdC9KxT+yWIflQCORF38y5cOBJ
         ho6MWDpxx/C/vCo3zohtruROYw9HKykR4f4lJ6sWyzAQaJfDnxj4D7JvdIH87q0AMFlf
         LPuPBDWlr07hwLkXwXGiX7yxVvi4zPeu7Sx5dsu/ktWDNZ3xDxDnLClGL3qjizJdpOJY
         4jBWGw22aqNfAsuuIBOsBToleY+gDm+2HMfxJt5njyNQIkFRLldZ3X6HNIYYVuYPza0l
         Ny6A==
X-Gm-Message-State: APzg51DPg8U3S5yUCYuWOZtsADUKobfmFrTjGE7EErWBT+UGOATqgDBK
        WvyACHJuhrH2MDXhuz1rWZw=
X-Google-Smtp-Source: ANB0VdaEqfQyPatAHDgPvAamxFH6SdgV0zyJmShcrrj5FMW8XBDa5p7lVzn48udvMxFyW6OyU5NImw==
X-Received: by 2002:a50:aa83:: with SMTP id q3-v6mr43017031edc.64.1536158223942;
        Wed, 05 Sep 2018 07:37:03 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id u53-v6sm1556413edm.51.2018.09.05.07.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:37:02 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list)
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 7/8] mtd: maps: gpio-addr-flash: Add support for device-tree devices
Date:   Wed,  5 Sep 2018 16:36:42 +0200
Message-Id: <20180905143643.9871-8-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow creating gpio-addr-flash via device-tree and not just via platform
data.

The gpio probing has been moved to a different function allowing
deferred probing if they are not ready.

Option parsing has been also moved to separated functions.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
Changelog v2:

From kbuild:
- Fix warnings

 drivers/mtd/maps/gpio-addr-flash.c | 186 +++++++++++++++++++++++------
 1 file changed, 147 insertions(+), 39 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 9455a8448064..fea1e3ae3745 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -7,6 +7,7 @@
  *
  * Copyright © 2000 Nicolas Pitre <nico@cam.org>
  * Copyright © 2005-2009 Analog Devices Inc.
+ * Copyright © 2018 Ricardo Ribalda <ricardo.ribalda@gmail.com>
  *
  * Enter bugs at http://blackfin.uclinux.org/
  *
@@ -24,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/of_gpio.h>
 
 #define win_mask(x) ((BIT(x)) - 1)
 
@@ -172,8 +174,121 @@ static void gf_copy_to(struct map_info *map, unsigned long to,
 	}
 }
 
-static const char * const part_probe_types[] = {
-	"cmdlinepart", "RedBoot", NULL };
+static int gf_bankwidth(struct platform_device *pdev)
+{
+	struct device_node *dn;
+	int ret;
+	u32 bankwidth;
+
+	dn = pdev->dev.of_node;
+	if (!dn) {
+		struct physmap_flash_data *pdata;
+
+		pdata = dev_get_platdata(&pdev->dev);
+		return pdata->width;
+	}
+
+	ret = of_property_read_u32(dn, "bank-width", &bankwidth);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get bank-width\n");
+		return -EINVAL;
+	}
+
+	return bankwidth;
+}
+
+static const char *gf_probe_type(struct platform_device *pdev)
+{
+	struct device_node *dn;
+	struct resource *memory;
+	const char *of_probe;
+
+	dn = pdev->dev.of_node;
+	if (!dn) {
+		memory = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		return memory->name;
+	}
+
+	of_probe = of_get_property(dn, "probe-type", NULL);
+	if (of_probe)
+		return of_probe;
+
+	return "cfi_probe";
+}
+
+static void gf_device_parse_register(struct platform_device *pdev,
+				     struct async_state *state)
+{
+	static const char * const part_probe_types[] = {
+		"cmdlinepart", "RedBoot", "ofpart", "ofoldpart", NULL };
+	struct device_node *dn;
+
+	dn = pdev->dev.of_node;
+	if (!dn) {
+		struct physmap_flash_data *pdata;
+
+		pdata = dev_get_platdata(&pdev->dev);
+		mtd_device_parse_register(state->mtd, part_probe_types, NULL,
+					  pdata->parts, pdata->nr_parts);
+		return;
+	}
+
+	mtd_device_parse_register(state->mtd, part_probe_types, NULL, NULL, 0);
+}
+
+static int gpio_flash_probe_gpios(struct platform_device *pdev,
+				  struct async_state *state)
+{
+	struct physmap_flash_data *pdata;
+	struct device_node *dn;
+	struct resource *gpios = NULL;
+	int i;
+
+	dn = pdev->dev.of_node;
+	if (dn) {
+		state->gpio_count = of_gpio_count(dn);
+	} else {
+		pdata = dev_get_platdata(&pdev->dev);
+		if (!pdata)
+			return -EINVAL;
+		gpios = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+		if (IS_ERR(gpios) || !gpios->end)
+			return -EINVAL;
+		state->gpio_count = gpios->end;
+	}
+
+	state->gpio_addrs = devm_kzalloc(&pdev->dev,
+					 sizeof(state->gpio_addrs[0])
+						* state->gpio_count,
+					 GFP_KERNEL);
+	if (!state->gpio_addrs)
+		return -ENOMEM;
+
+	for (i = 0; i < state->gpio_count; i++) {
+		long gpio;
+		int ret;
+
+		if (dn)
+			gpio = of_get_gpio(dn, i);
+		else
+			gpio = ((unsigned long *)gpios->start)[i];
+
+		if (gpio < 0)
+			return gpio;
+
+		ret =  devm_gpio_request(&pdev->dev, gpio, DRIVER_NAME);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to request gpio %ld\n",
+				gpio);
+			return ret;
+		}
+		state->gpio_addrs[i] = gpio;
+		gpio_direction_output(state->gpio_addrs[i], 0);
+	}
+
+	return 0;
+}
+
 
 /**
  * gpio_flash_probe() - setup a mapping for a GPIO assisted flash
@@ -205,74 +320,58 @@ static const char * const part_probe_types[] = {
  */
 static int gpio_flash_probe(struct platform_device *pdev)
 {
-	size_t i;
-	struct physmap_flash_data *pdata;
 	struct resource *memory;
-	struct resource *gpios;
 	struct async_state *state;
+	int ret;
 
-	pdata = dev_get_platdata(&pdev->dev);
 	memory = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gpios = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-
-	if (!memory || !gpios || !gpios->end)
+	if (!memory)
 		return -EINVAL;
 
+	if (!is_power_of_2(resource_size(memory))) {
+		dev_err(&pdev->dev, "Window size must be aligned\n");
+		return -EIO;
+	}
+
 	state = devm_kzalloc(&pdev->dev, sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
+	platform_set_drvdata(pdev, state);
 
-	/*
-	 * We cast start/end to known types in the boards file, so cast
-	 * away their pointer types here to the known types (gpios->xxx).
-	 */
-	state->gpio_count     = gpios->end;
-	state->gpio_addrs     = devm_kzalloc(&pdev->dev,
-					     sizeof(state->gpio_addrs[0]) *
-								gpios->end,
-					     GFP_KERNEL);
-	if (!state->gpio_addrs)
-		return -ENOMEM;
-	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
+	ret = gpio_flash_probe_gpios(pdev, state);
+	if (ret < 0)
+		return ret;
 
+	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
 	state->map.name       = DRIVER_NAME;
 	state->map.read       = gf_read;
 	state->map.copy_from  = gf_copy_from;
 	state->map.write      = gf_write;
 	state->map.copy_to    = gf_copy_to;
-	state->map.bankwidth  = pdata->width;
+
+	ret = gf_bankwidth(pdev);
+	if (ret < 0)
+		return ret;
+	state->map.bankwidth = ret;
+
 	state->map.size       = BIT(state->win_order + state->gpio_count);
 	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
 	if (IS_ERR(state->map.virt)) {
 		dev_err(&pdev->dev, "failed to map memory\n");
 		return PTR_ERR(state->map.virt);
 	}
-
 	state->map.phys       = NO_XIP;
 	state->map.map_priv_1 = (unsigned long)state;
 
-	platform_set_drvdata(pdev, state);
-
-	i = 0;
-	do {
-		if (devm_gpio_request(&pdev->dev, state->gpio_addrs[i],
-				      DRIVER_NAME)) {
-			dev_err(&pdev->dev, "failed to request gpio %d\n",
-				state->gpio_addrs[i]);
-			return -EBUSY;
-		}
-		gpio_direction_output(state->gpio_addrs[i], 0);
-	} while (++i < state->gpio_count);
-
 	dev_notice(&pdev->dev, "probing %d-bit flash bus\n",
 		   state->map.bankwidth * 8);
-	state->mtd = do_map_probe(memory->name, &state->map);
+	state->mtd = do_map_probe(gf_probe_type(pdev), &state->map);
 	if (!state->mtd)
 		return -ENXIO;
 	state->mtd->dev.parent = &pdev->dev;
+	mtd_set_of_node(state->mtd, pdev->dev.of_node);
 
-	mtd_device_parse_register(state->mtd, part_probe_types, NULL,
-				  pdata->parts, pdata->nr_parts);
+	gf_device_parse_register(pdev, state);
 
 	return 0;
 }
@@ -286,11 +385,20 @@ static int gpio_flash_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id gpio_flash_match[] = {
+	{
+		.compatible	= "cfi-gpio-addr-flash",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, gpio_flash_match);
+
 static struct platform_driver gpio_flash_driver = {
 	.probe		= gpio_flash_probe,
 	.remove		= gpio_flash_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
+		.of_match_table = gpio_flash_match,
 	},
 };
 
-- 
2.18.0

