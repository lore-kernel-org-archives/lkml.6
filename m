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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E001C65BAB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FEB2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMuoRPGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FEB2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJDC27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:28:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35485 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJDC26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:28:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id y19-v6so6457289edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DnDkdVlT4uEmccUEt9jQFZdRTiIQUnmLL0jvRMKg+cQ=;
        b=OMuoRPGcGpz8FkPZUZD3n2l6dG+9sat0wpTlDPyQbOzaV6hxR5SsKZzOdDGV/BCZIj
         fE0GjLFZqq6GAKRZWbc85enJQ1GE4QPjUYTpY8dXUqU+q2PdYyRnv6X2ssC+pZw1RrpR
         ac4lEYB4sSXt21a7Py7YxI6y0TTGmnMmmuTWBeHIkpA3IrYlcAv3vZ4VEQ47KxNk1t9n
         myexaSNdudU+NmBzM0M3BupfkNLiR+rr3dll1GWLXfqDJVsy/tKd8mxq/UrHkbl4V+Jl
         MaUfZJWT5nK1+SF6HACeBc4iLHtStwj7bykDFtJVGjoLmye2g6J6rtWUpkChB1QQpAgs
         y1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnDkdVlT4uEmccUEt9jQFZdRTiIQUnmLL0jvRMKg+cQ=;
        b=Hj8fmVp1Jz8t9a4gDM8KMnLbWgrUGIz58yA98O21JDY2mst3mpu5/ZrMZgsh/iGAqX
         3P+dyCDjlZie+Sj8jd8y/RmMAxRsJH4MHFEGN2lG7lo1LRcf6jZPk2mk1bKKfFjHS61O
         djOK42rqb1xUiVc/DaOOLbcFEGPeCYDLvC6ohFG/8cA0jNsiy7fS37NUC5Zp0mrbrRd5
         eYbOgS/gWS4XRbqQuv9Se4Lef24VFfbmS4Z3RxUWzQiUpYu6mHQet/bq+cH64ob/8OJU
         z/dwgVDomPs/hlZn7gXmvrEDvCQVkYIEMKzrQNvlqFMMmCBzHxRD/ZquA29Io+LEl/5c
         N0XA==
X-Gm-Message-State: ABuFfohqs+a0G+5Cw/1Us9nuLwjIv2J0NZMBTr0Irdz4odJpKga9mtGa
        QXLp4/QJr/yEqUINdR16XuM8MYMS
X-Google-Smtp-Source: ACcGV6075GGpNBx0WHCsskTfNRNm+H7LahjdxVToWrd5kMhEN6wzyk46yLBX12xo/TZn+14PLhIxYQ==
X-Received: by 2002:a17:906:344b:: with SMTP id d11-v6mr3402240ejb.130.1538595550814;
        Wed, 03 Oct 2018 12:39:10 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b49-v6sm765263eda.70.2018.10.03.12.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:39:09 -0700 (PDT)
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
Subject: [PATCH v5 6/8] mtd: maps: gpio-addr-flash: Convert to gpiod
Date:   Wed,  3 Oct 2018 21:38:57 +0200
Message-Id: <20181003193859.23928-6-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
References: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
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
 drivers/mtd/maps/gpio-addr-flash.c | 52 +++++++++++-------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 47b12a6fead4..9e370e3158cd 100644
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
@@ -182,18 +181,19 @@ static const char * const part_probe_types[] = {
  * The platform resource layout expected looks something like:
  * struct mtd_partition partitions[] = { ... };
  * struct physmap_flash_data flash_data = { ... };
- * unsigned flash_gpios[] = { GPIO_XX, GPIO_XX, ... };
+ * static struct gpiod_lookup_table addr_flash_gpios = {
+ *		.dev_id = "gpio-addr-flash.0",
+ *		.table = { .... );
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
@@ -205,29 +205,24 @@ static const char * const part_probe_types[] = {
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
+	state->gpios = devm_gpiod_get_array(&pdev->dev, NULL, GPIOD_OUT_LOW);
+	if (IS_ERR(state->gpios))
+		return PTR_ERR(state->gpios);
+
 	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
 
 	state->map.name       = DRIVER_NAME;
@@ -236,7 +231,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.write      = gf_write;
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
-	state->map.size       = BIT(state->win_order + state->gpio_count);
+	state->map.size       = BIT(state->win_order + state->gpios->ndescs);
 	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
 	if (IS_ERR(state->map.virt))
 		return PTR_ERR(state->map.virt);
@@ -246,17 +241,6 @@ static int gpio_flash_probe(struct platform_device *pdev)
 
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

