Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4672C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DDF20684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4UgXGGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DDF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbeJATVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:21:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38851 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbeJATVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:21:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id c1-v6so4846150ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LeT24dYZEfQqGD1KSlFSc8NaX8++VQHhcHGYE0+u5s0=;
        b=h4UgXGGP3S18VJpc1hcNAsELpqs0BHseNg9cGEJZv5jKhYSogkkQOV3EClFOoyXjK7
         ASQig00QN0KCreo8c8NSb+YI77k2jehq+E0NWj0G4nRH4KWdxIOnNpYcDlqpTi7SgPC3
         /hXj1l7V+m0ZHoyjEOzjAIjqRYhp0EspaZzuv9ZMAi5++5gsDHOqaSecZymEkQDiwKhq
         29PK5AqGNLc60jJi05GtacXCqImQnGpJ7q2dFVE+g1s00B/VFGij/yx4C1X3twyKeZmv
         Zt6pJy/A/ZN6o++4UaO3egGgCCv1N44e9ZaxXO4noCGnmnk5KuJwD5sTOd/FqXoc+q91
         A4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeT24dYZEfQqGD1KSlFSc8NaX8++VQHhcHGYE0+u5s0=;
        b=OtQ4vXFWPs9Jgc7HhlPprELDK4VruWPW/JRXTnT9+EwMGkxB8jNgFqDdF/e4FiYzuD
         ZIHcXwsrGBs8+k+LKJk5QtKDAoIQtivozDUuW9fHk5kNHazNnJyXCkst+7TQmlWeEKFN
         DQKNxMZGXU+71Sp34wTGuBixJmvI0k4NAjcb7Ks35LDKqV3RyqO0K7S+ISUj4eDo66OU
         cKCycMsp2WC7bZQoKBdbcNgmZ/F/bO0jjhPKI3fddVF6gFdiaN/c67+6dOF+/QLu5eQc
         aP2CqWsDDlWetEdcDuE4l04vFTazMtFPG4nJfrxf6dXiYkItxs0SXeLnelOtB3E6ljTX
         qsdg==
X-Gm-Message-State: ABuFfogSRGnRmrICf6pPWpzLeF+xTUh0Ix20/yw7EWG/mWqhO6Ln/Jxt
        MfG2rq2u2w+u2HfzNMklcKI=
X-Google-Smtp-Source: ACcGV62tdDFV/5at0wSZVB/W3T97WLF9qnAmPImA9PH9uvv5wQ5n45YJZ2ni0CpUoHrLM6rnLDvBqg==
X-Received: by 2002:a17:906:b750:: with SMTP id fx16-v6mr14238697ejb.217.1538397849083;
        Mon, 01 Oct 2018 05:44:09 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h3-v6sm5278700ede.42.2018.10.01.05.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:44:07 -0700 (PDT)
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
Subject: [PATCH v4 8/8] mtd: maps: gpio-addr-flash: Add support for device-tree devices
Date:   Mon,  1 Oct 2018 14:43:51 +0200
Message-Id: <20181001124351.31615-8-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
References: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
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
 drivers/mtd/maps/gpio-addr-flash.c | 184 ++++++++++++++++++++++-------
 1 file changed, 144 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index c6fe1de33a82..afa9dce14f68 100644
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
@@ -171,8 +172,120 @@ static void gf_copy_to(struct map_info *map, unsigned long to,
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
+		state->gpios = devm_gpiod_get_array(&pdev->dev, NULL,
+						    GPIOD_OUT_LOW);
+		if (IS_ERR(state->gpios)) {
+			dev_err(&pdev->dev, "Error getting gpio array %ld\n",
+				   PTR_ERR(state->gpios));
+			return PTR_ERR(state->gpios);
+		}
+		return 0;
+	}
+
+	pdata = dev_get_platdata(&pdev->dev);
+	if (!pdata)
+		return -EINVAL;
+	gpios = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (IS_ERR(gpios) || !gpios->end)
+		return -EINVAL;
+
+	state->gpios = devm_kzalloc(&pdev->dev,
+				    sizeof(*state->gpios) +
+				    gpios->end * sizeof(state->gpios->desc[0]),
+				    GFP_KERNEL);
+	if (!state->gpios)
+		return -ENOMEM;
+
+	for (i = 0; i < gpios->end ; i++) {
+		unsigned int *gpio_id = (unsigned int *)gpios->start;
+
+		if (devm_gpio_request_one(&pdev->dev, gpio_id[i], GPIOD_OUT_LOW,
+					DRIVER_NAME)) {
+			dev_err(&pdev->dev, "failed to request gpio %d\n",
+				gpio_id[i]);
+			return -EBUSY;
+		}
+
+		state->gpios->desc[i] = gpio_to_desc(gpio_id[i]);
+		if (!state->gpios->desc[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 
 /**
  * gpio_flash_probe() - setup a mapping for a GPIO assisted flash
@@ -204,42 +317,42 @@ static const char * const part_probe_types[] = {
  */
 static int gpio_flash_probe(struct platform_device *pdev)
 {
-	size_t i;
 	struct physmap_flash_data *pdata;
 	struct resource *memory;
-	struct resource *gpios;
 	struct async_state *state;
+	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
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
 
-	state->gpios = devm_kzalloc(&pdev->dev,
-			sizeof(*state->gpios) +
-			gpios->end * sizeof(state->gpios->desc[0]),
-			GFP_KERNEL);
-	if (!state->gpios)
-		return -ENOMEM;
-	state->gpios->ndescs = gpios->end;
-
-	if (!state->gpios->desc)
-		return -ENOMEM;
+	ret = gpio_flash_probe_gpios(pdev, state);
+	if (ret < 0)
+		return ret;
 
 	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
-
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
 	state->map.size       = BIT(state->win_order + state->gpios->ndescs);
 	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
 	if (IS_ERR(state->map.virt))
@@ -248,33 +361,15 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.phys       = NO_XIP;
 	state->map.map_priv_1 = (unsigned long)state;
 
-	platform_set_drvdata(pdev, state);
-
-	i = 0;
-	do {
-		unsigned int *gpio_id = (unsigned int *)gpios->start;
-
-		if (devm_gpio_request_one(&pdev->dev, gpio_id[i], GPIOD_OUT_LOW,
-					DRIVER_NAME)) {
-			dev_err(&pdev->dev, "failed to request gpio %d\n",
-				gpio_id[i]);
-			return -EBUSY;
-		}
-
-		state->gpios->desc[i] = gpio_to_desc(gpio_id[i]);
-		if (!state->gpios->desc[i])
-			return -EINVAL;
-	} while (++i < state->gpios->ndescs);
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
@@ -288,11 +383,20 @@ static int gpio_flash_remove(struct platform_device *pdev)
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

