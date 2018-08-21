Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8CCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C34920E20
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga9CpfkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C34920E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeHURw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:52:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34439 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeHURw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:52:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so10787889eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J4ouk3iykT2mn39Gd8ss+3/TZy8UL7E2wHb3dkOGvE8=;
        b=Ga9CpfkQ7pKmsPU4wuP8IXy8s4tqthHJRJqHz4PN2DOgNnU9EmfgccGmFDNTEi7wBA
         9vd4WvY+1c6WB891+gbDDHDWJhEXHHZOhY64LAVMeZKKo61zA3l1enzcFJj+naVDP1zM
         XiHylp2SMkHQ23npccNuNotNBEKVb9F/1ARCEJaoWUpZMP6je4R/eGHfJjAcY+xtNsNM
         bSMH1iVwdbIFh2uvF4q1auW0iP/YJkWQKsSmiNf73N/qCKpR0t91oE7rjuQ+QM5EKwub
         DF5mMwnQiSR4T8SWpab/PKBRdUsaf87+bSlmSYtv9SHPRCPHHKfc+MOtGE/J0Y5zKfJP
         UJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J4ouk3iykT2mn39Gd8ss+3/TZy8UL7E2wHb3dkOGvE8=;
        b=X/2l+MXj4fA+NlmTBzAR+V0fgDA+ymylHh2MsBOX9dGGAtvZ7w0WLSK7Wc2D1q9XgY
         rQidrX8aQCxZHts1P4ijn8DS5oRIoc5QRVx0cTRjrBVTch5QCHMzy7AkyhPECYOao6jm
         BB8XBPGm9yTk4+uGIMK2jxDgKFK2nnbS14/1q3wvImg88LADGckpqWTYHQdhj+YliaoO
         Kax6emabiifI02ywfl20C6zbFf5lUzoZ6sKJJDZVZNXUGwiPaLsZ7KMc4SD75R/u/4Ow
         vca1qU53TWj3SJMD5oQySIRFOw3b+jd+GMD+/3qZ8ufzipaSzx8bx0mh4fC15el8uGXL
         lK+g==
X-Gm-Message-State: AOUpUlE2oq3NR6uNkl/WIBPO9uC6DlhKqJUlFMP8iXHWF85qFTIDtfQv
        iWhF64YmXR62MPFccyH5kyU=
X-Google-Smtp-Source: AA+uWPzwdlIJHY1V/54K1vi5RHcjagKk3EgvD2/gTtpG3Jqr00QUKyCpAXb3sYBc/EntZt2nMOJtyQ==
X-Received: by 2002:aa7:c592:: with SMTP id g18-v6mr41823764edq.214.1534861922234;
        Tue, 21 Aug 2018 07:32:02 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id n17-v6sm6766144edq.10.2018.08.21.07.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:32:01 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 4/8] mtd: maps: gpio-addr-flash: Use order insted of size
Date:   Tue, 21 Aug 2018 16:31:48 +0200
Message-Id: <20180821143152.32293-5-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using the order of the window instead of the size, we can replace a
lot of expensive division and modulus on the code with simple bit
operations.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 39 ++++++++++++++++--------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 54a0d7d2365a..22e100f07112 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -25,6 +25,8 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#define win_mask(x) ((BIT(x)) - 1)
+
 #define DRIVER_NAME "gpio-addr-flash"
 
 /**
@@ -34,7 +36,7 @@
  *	@gpio_count:  number of GPIOs used to address
  *	@gpio_addrs:  array of GPIOs to twiddle
  *	@gpio_values: cached GPIO values
- *	@win_size:    dedicated memory size (if no GPIOs)
+ *	@win_order:   dedicated memory size (if no GPIOs)
  */
 struct async_state {
 	struct mtd_info *mtd;
@@ -42,7 +44,7 @@ struct async_state {
 	size_t gpio_count;
 	unsigned *gpio_addrs;
 	int *gpio_values;
-	unsigned long win_size;
+	unsigned int win_order;
 };
 #define gf_map_info_to_state(mi) ((struct async_state *)(mi)->map_priv_1)
 
@@ -60,7 +62,8 @@ static void gf_set_gpios(struct async_state *state, unsigned long ofs)
 {
 	size_t i = 0;
 	int value;
-	ofs /= state->win_size;
+
+	ofs >>= state->win_order;
 	do {
 		value = ofs & (1 << i);
 		if (state->gpio_values[i] != value) {
@@ -83,7 +86,7 @@ static map_word gf_read(struct map_info *map, unsigned long ofs)
 
 	gf_set_gpios(state, ofs);
 
-	word = readw(map->virt + (ofs % state->win_size));
+	word = readw(map->virt + (ofs & win_mask(state->win_order)));
 	test.x[0] = word;
 	return test;
 }
@@ -105,14 +108,14 @@ static void gf_copy_from(struct map_info *map, void *to, unsigned long from, ssi
 	int this_len;
 
 	while (len) {
-		if ((from % state->win_size) + len > state->win_size)
-			this_len = state->win_size - (from % state->win_size);
-		else
-			this_len = len;
+		this_len = from & win_mask(state->win_order);
+		this_len = BIT(state->win_order) - this_len;
+		this_len = min_t(int, len, this_len);
 
 		gf_set_gpios(state, from);
-		memcpy_fromio(to, map->virt + (from % state->win_size),
-			 this_len);
+		memcpy_fromio(to,
+			      map->virt + (from & win_mask(state->win_order)),
+			      this_len);
 		len -= this_len;
 		from += this_len;
 		to += this_len;
@@ -132,7 +135,7 @@ static void gf_write(struct map_info *map, map_word d1, unsigned long ofs)
 	gf_set_gpios(state, ofs);
 
 	d = d1.x[0];
-	writew(d, map->virt + (ofs % state->win_size));
+	writew(d, map->virt + (ofs & win_mask(state->win_order)));
 }
 
 /**
@@ -152,13 +155,13 @@ static void gf_copy_to(struct map_info *map, unsigned long to,
 	int this_len;
 
 	while (len) {
-		if ((to % state->win_size) + len > state->win_size)
-			this_len = state->win_size - (to % state->win_size);
-		else
-			this_len = len;
+		this_len = to & win_mask(state->win_order);
+		this_len = BIT(state->win_order) - this_len;
+		this_len = min_t(int, len, this_len);
 
 		gf_set_gpios(state, to);
-		memcpy_toio(map->virt + (to % state->win_size), from, len);
+		memcpy_toio(map->virt + (to & win_mask(state->win_order)),
+			    from, len);
 
 		len -= this_len;
 		to += this_len;
@@ -224,7 +227,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->gpio_count     = gpios->end;
 	state->gpio_addrs     = (void *)(unsigned long)gpios->start;
 	state->gpio_values    = (void *)(state + 1);
-	state->win_size       = resource_size(memory);
+	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
 	memset(state->gpio_values, 0xff, arr_size);
 
 	state->map.name       = DRIVER_NAME;
@@ -233,7 +236,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.write      = gf_write;
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
-	state->map.size       = state->win_size * (1 << state->gpio_count);
+	state->map.size       = BIT(state->win_order + state->gpio_count);
 	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
 	if (IS_ERR(state->map.virt)) {
 		dev_err(&pdev->dev, "failed to map memory\n");
-- 
2.18.0

