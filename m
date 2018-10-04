Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0437CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D432098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwK0R2OZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D432098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeJDTzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:55:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33816 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJDTys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:54:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id y10-v6so6712382lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t04/5xTYqJKjawPYGYipOMCnPHvhrwprfxMj3JMdytY=;
        b=nwK0R2OZSH5UwBEsGTDz2oT3Btz/yRnkX9VTpHuhJGNn4Tt5zkXj0nb2wJ8aFo4ovG
         FmTUjuQu+6PN37LR5phe790zzKjkxT9TEeEcova6fEuV+i98v+19wAZfudwXMYdyTH5k
         g3H0F8e1HQWOcfG7GO6PgvguzjjZWEZ3QG6Fp57HnbW2k4/k6EPc3sfS1R+Dqrv72z8d
         nqan44CBVi7Ny+OUu9ITvY1BXbX3q8gONXz/JCTX5Cv9xd32jlyLmuqLrWzwBf7E1szO
         5/q7ZxEjcobfWP0qdOXcrb5SvgLP2zv7YkPDDBFexVeYilLlhNamtUh6bOsPpnYtvkVX
         qasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t04/5xTYqJKjawPYGYipOMCnPHvhrwprfxMj3JMdytY=;
        b=AkROrWcg56Ubk7OoNsB7H1lA13vCoJthpJ2/SFnuq9OwgIwQ83skJCVdDmKjI3xCHs
         d05qsmu9KOdhQz6rQEOLyiaPD+JA7IFF49WzWOYTkFOfKPDuEaJ6KhtaJkzM2PQbHIr/
         3zfUO3l2DFPTFfDYkDj80SUZk+8KqqnR4LpYr3yqffAG4CVkdjagVeXYNLDgIjbgaadO
         TY8wVOwmAG8lcoBJOKDHqpFKxJJYBZQBCBejB2G52mslm4q/beBfxx1SrMeTg8ZlrF1m
         KG0cFF0kHEVP4xT35tx364vG9YgF3qJECNS6Qm9jn1KNE2wF9hLmW0E9JzEdi1F/yX/j
         +90Q==
X-Gm-Message-State: ABuFfohoDugXcvRzfH4PlOIb/pjJkcIyU5mxmlB79Qf/P+NTPCIlMBav
        gkj5n0+EmRkRyIGuEJexGxE=
X-Google-Smtp-Source: ACcGV61Z9+/eV4GeTsovZKdvE4zFKkssJHGGnj3psbDp3UKITW8OsC7yCqq/sDl8MyY7VL528hBNhg==
X-Received: by 2002:a19:518a:: with SMTP id g10-v6mr4039220lfl.63.1538658095799;
        Thu, 04 Oct 2018 06:01:35 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a1-v6sm421415lfk.63.2018.10.04.06.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:01:34 -0700 (PDT)
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
Subject: [PATCH v6 08/10] mtd: maps: gpio-addr-flash: Convert to gpiod
Date:   Thu,  4 Oct 2018 15:01:08 +0200
Message-Id: <20181004130110.8496-8-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert from legacy gpio API to gpiod.
Board files will have to use gpiod_lookup_tables.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 55 ++++++++++++------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 47b12a6fead4..a20e85aa770e 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -33,16 +34,14 @@
  * struct async_state - keep GPIO flash state
  *	@mtd:         MTD state for this mapping
  *	@map:         MTD map state for this flash
- *	@gpio_count:  number of GPIOs used to address
- *	@gpio_addrs:  array of GPIOs to twiddle
+ *	@gpios:       Struct containing the array of GPIO descriptors
  *	@gpio_values: cached GPIO values
  *	@win_order:   dedicated memory size (if no GPIOs)
  */
 struct async_state {
 	struct mtd_info *mtd;
 	struct map_info map;
-	size_t gpio_count;
-	unsigned *gpio_addrs;
+	struct gpio_descs *gpios;
 	unsigned int gpio_values;
 	unsigned int win_order;
 };
@@ -66,11 +65,11 @@ static void gf_set_gpios(struct async_state *state, unsigned long ofs)
 	if (ofs == state->gpio_values)
 		return;
 
-	for (i = 0; i < state->gpio_count; i++) {
+	for (i = 0; i < state->gpios->ndescs; i++) {
 		if ((ofs & BIT(i)) == (state->gpio_values & BIT(i)))
 			continue;
 
-		gpio_set_value(state->gpio_addrs[i], !!(ofs & BIT(i)));
+		gpiod_set_value(state->gpios->desc[i], !!(ofs & BIT(i)));
 	}
 
 	state->gpio_values = ofs;
@@ -182,18 +181,22 @@ static const char * const part_probe_types[] = {
  * The platform resource layout expected looks something like:
  * struct mtd_partition partitions[] = { ... };
  * struct physmap_flash_data flash_data = { ... };
- * unsigned flash_gpios[] = { GPIO_XX, GPIO_XX, ... };
+ * static struct gpiod_lookup_table addr_flash_gpios = {
+ *		.dev_id = "gpio-addr-flash.0",
+ *		.table = {
+ *		GPIO_LOOKUP_IDX("gpio.0", 15, "addr", 0, GPIO_ACTIVE_HIGH),
+ *		GPIO_LOOKUP_IDX("gpio.0", 16, "addr", 1, GPIO_ACTIVE_HIGH),
+ *		);
+ * };
+ * gpiod_add_lookup_table(&addr_flash_gpios);
+ *
  * struct resource flash_resource[] = {
  *	{
  *		.name  = "cfi_probe",
  *		.start = 0x20000000,
  *		.end   = 0x201fffff,
  *		.flags = IORESOURCE_MEM,
- *	}, {
- *		.start = (unsigned long)flash_gpios,
- *		.end   = ARRAY_SIZE(flash_gpios),
- *		.flags = IORESOURCE_IRQ,
- *	}
+ *	},
  * };
  * struct platform_device flash_device = {
  *	.name          = "gpio-addr-flash",
@@ -205,29 +208,24 @@ static const char * const part_probe_types[] = {
  */
 static int gpio_flash_probe(struct platform_device *pdev)
 {
-	size_t i;
 	struct physmap_flash_data *pdata;
 	struct resource *memory;
-	struct resource *gpios;
 	struct async_state *state;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	memory = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gpios = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 
-	if (!memory || !gpios || !gpios->end)
+	if (!memory)
 		return -EINVAL;
 
 	state = devm_kzalloc(&pdev->dev, sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
 
-	/*
-	 * We cast start/end to known types in the boards file, so cast
-	 * away their pointer types here to the known types (gpios->xxx).
-	 */
-	state->gpio_count     = gpios->end;
-	state->gpio_addrs     = (void *)(unsigned long)gpios->start;
+	state->gpios = devm_gpiod_get_array(&pdev->dev, "addr", GPIOD_OUT_LOW);
+	if (IS_ERR(state->gpios))
+		return PTR_ERR(state->gpios);
+
 	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
 
 	state->map.name       = DRIVER_NAME;
@@ -236,7 +234,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.write      = gf_write;
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
-	state->map.size       = BIT(state->win_order + state->gpio_count);
+	state->map.size       = BIT(state->win_order + state->gpios->ndescs);
 	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
 	if (IS_ERR(state->map.virt))
 		return PTR_ERR(state->map.virt);
@@ -246,17 +244,6 @@ static int gpio_flash_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, state);
 
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
 	state->mtd = do_map_probe(memory->name, &state->map);
-- 
2.19.0

