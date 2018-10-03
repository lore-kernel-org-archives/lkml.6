Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AA0C65BA7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC552064D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsgHgBey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC552064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeJDC3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:29:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46698 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeJDC3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:29:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id g32-v6so6400673edg.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOAyhQZ1kpINFprCvoK5uIYCA/Vz9KwRzR3zRWEAurw=;
        b=JsgHgBey89jArTKnLa7apugLwk9m+e+IHoQnZVpkLYEpydSYwCgSDCwiz+qMKZikhZ
         nVMGdGwytlUkziJD5f6iXLPDq4PwvHWO3Rag1e+WveBgxCpp04m06cqoyecFU5R92/4h
         h/34siZKzTrs3h/u4bx8RZfMy9+3Vbjk0ihnDQi+3dXxlgw+iQYnxSJgpmc0E7xLjweP
         ZPnGV9bMVHYikDzSEHvoD/0IdlB/vswAyJBhg/nUQPPgo72LUehjDkNlnJRN9jpCykz2
         5ilnw4q8XFLSgcg22LR8hlEGhe97OiN1u9omxPwp0Q50LunknmEqjWsT5k76kpWC8Rdh
         p2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOAyhQZ1kpINFprCvoK5uIYCA/Vz9KwRzR3zRWEAurw=;
        b=e2RL8z+zpEsOrcgbSjx3r8IKky+S05jUAbVsHBzwy93K/h1fY852VxDZksdlDv1Awi
         kK+n7qTEQUiqybCHWP9PZwxYymLnwJjMrZbnVs5wEHmUxtKjb3Ia55+EgkF4V6htG1/y
         L5wt2ks4EJaRzy6c0Opi+7/aMPH3XM01CV3wIzBg9Ij3prxJWVeFqvWF2UpNUuaS0KxT
         nD0Uj+U0UeCjScQnaZbWSBC05oBfG5ho8fp/egjy/tSnQwCZJ37NHZDIZRT3IHsOhkY9
         UnplnaAlFGP3Ua2Jfb3QRvkAp1BVPIcJeObPqAF/uDBZHLcKjEJz/1RGcKnjISMCdzyd
         MxKw==
X-Gm-Message-State: ABuFfoji2FcYdiJgnnN6y6THaUtodSSjl4IYBR6dEQOnymMAYOCSy7KQ
        7MWg72MEyFDC9hOInJp1kD8=
X-Google-Smtp-Source: ACcGV62aIpF9hYseQ8f72T4GjQMMy3kbAcqWoRxiS7BZ1CHc3fFuS5wkxxFSyG/LXpnKghWjkCL7ew==
X-Received: by 2002:a17:906:1e45:: with SMTP id i5-v6mr3460567ejj.146.1538595555505;
        Wed, 03 Oct 2018 12:39:15 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b49-v6sm765263eda.70.2018.10.03.12.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:39:14 -0700 (PDT)
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
Subject: [PATCH v5 8/8] mtd: maps: gpio-addr-flash: Add support for device-tree devices
Date:   Wed,  3 Oct 2018 21:38:59 +0200
Message-Id: <20181003193859.23928-8-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
References: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow creating gpio-addr-flash via device-tree and not just via platform
data.

Option parsing has been moved to separated functions.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 95 +++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 9e370e3158cd..1be2df81087a 100644
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
@@ -171,8 +172,67 @@ static void gf_copy_to(struct map_info *map, unsigned long to,
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
 
 /**
  * gpio_flash_probe() - setup a mapping for a GPIO assisted flash
@@ -208,6 +268,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	struct physmap_flash_data *pdata;
 	struct resource *memory;
 	struct async_state *state;
+	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	memory = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -215,9 +276,15 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	if (!memory)
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
 
 	state->gpios = devm_gpiod_get_array(&pdev->dev, NULL, GPIOD_OUT_LOW);
 	if (IS_ERR(state->gpios))
@@ -230,7 +297,12 @@ static int gpio_flash_probe(struct platform_device *pdev)
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
 	state->map.size       = BIT(state->win_order + state->gpios->ndescs);
 	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
 	if (IS_ERR(state->map.virt))
@@ -239,17 +311,15 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.phys       = NO_XIP;
 	state->map.map_priv_1 = (unsigned long)state;
 
-	platform_set_drvdata(pdev, state);
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
@@ -263,11 +333,20 @@ static int gpio_flash_remove(struct platform_device *pdev)
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
2.19.0

