Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26122C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C113C20E20
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezd63hLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C113C20E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeHURwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:52:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34456 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeHURwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:52:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id h1-v6so10788363eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AijsPaBcv58gZaSBmHxMu3VCbXrb2TltD+j2xJZEU0Y=;
        b=ezd63hLRpYMAX5KAGiXFizeNiQ8sgMcStSG4hlcPs++8dd11TnXBzFfn0kaf5FUFVb
         EPXXf88CIt+lAjBRENNwroNpAccTAn6VtRCRcdJMsDZr6N1VRjuyNHAJb9KUofn6A2on
         7311nBjCEFunNaD+4/pUfWcF5swXCrVotbFjEVjG0uLwxMT66ir5tx5G2SNiWBMWsRkO
         K7ofxTf1KxjeWe/eiUqjKWC9Mpm6B99ZH/iCttMBORiDrKk6ykC5x0mm7bYYFXB8pZhj
         xkckT+Ba39R2MONQA1SIUBNTR+i0E+/HdjHbMd8Y5/Fks3i5xlEZYA+L1NWTWkLkT7dr
         7Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AijsPaBcv58gZaSBmHxMu3VCbXrb2TltD+j2xJZEU0Y=;
        b=KYq7AjQI1Sm3XLrSJCr+xHUdWQZaNnY7kTjoAnS8Lf9H95Tb5zIjNsIGJgav78GFSX
         qDWX4o5lLYeRph2RWcyr37lu0LnDCikm12KgQGE8rBa9e5xDQXTrQ2S3PBfYCu1mLT67
         Qiu3q0eZ4zXvtqZXXmli33LPmNVASO0cNVL+j1t4TzSXTESF7UzpnmcUBL/EQ0dHt4+F
         qHp/ljZ4XHggnTdHOwjnmGcncJs0QcwPwRRCLXZQJ9+MdX5U20Ue0DWu+dRC+RDHuY0C
         /Vkmhmp5ITupjHKfiqSDyWkexVqiyBTFXOTTUGwovhRw/kYWKSWrLRTHddnfsoBeifru
         jadw==
X-Gm-Message-State: APzg51BsGXWUQFQ29VOCWk6Pz9pk3OHQOnZ49WkB2xW+h4KOBlUh3Qai
        Ee6TjN9yoeekhBLtQGn7DBw=
X-Google-Smtp-Source: ANB0VdYPuXoVmeQ8KFp5RrAsScgYPhcP+/c/+rH5t+xkrfqwfhdge3+2sP30yJY2eLCX6tR7ctNXgg==
X-Received: by 2002:a50:f709:: with SMTP id g9-v6mr3808839edn.37.1534861934218;
        Tue, 21 Aug 2018 07:32:14 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id n17-v6sm6766144edq.10.2018.08.21.07.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:32:08 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 7/8] mtd: maps: gpio-addr-flash: Add support for device-tree devices
Date:   Tue, 21 Aug 2018 16:31:51 +0200
Message-Id: <20180821143152.32293-8-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
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
 drivers/mtd/maps/gpio-addr-flash.c | 187 +++++++++++++++++++++++------
 1 file changed, 148 insertions(+), 39 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 9455a8448064..b44011987137 100644
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
 
@@ -172,8 +174,122 @@ static void gf_copy_to(struct map_info *map, unsigned long to,
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
+	struct resource *gpios;
+	int i;
+
+	dn = pdev->dev.of_node;
+	if (!dn) {
+		pdata = dev_get_platdata(&pdev->dev);
+		if (!pdata)
+			return -EINVAL;
+		gpios = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+		if (IS_ERR(gpios) || !gpios->end)
+			return -EINVAL;
+	}
+
+	if (dn)
+		state->gpio_count = of_gpio_count(dn);
+	else
+		state->gpio_count = gpios->end;
+
+	state->gpio_addrs = devm_kzalloc(&pdev->dev,
+					 sizeof(state->gpio_addrs[0])
+						* state->gpio_count,
+					 GFP_KERNEL);
+	if (!state->gpio_addrs)
+		return -ENOMEM;
+
+	for (i = 0; i < state->gpio_count; i++) {
+		int gpio, ret;
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
+			dev_err(&pdev->dev, "failed to request gpio %d\n",
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
@@ -205,74 +321,58 @@ static const char * const part_probe_types[] = {
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
@@ -286,11 +386,20 @@ static int gpio_flash_remove(struct platform_device *pdev)
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

