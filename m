Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDDAC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7567F208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR/Dh//7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7567F208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbeJATVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:21:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38829 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbeJATVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:21:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so4845721ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ls+XcqdmHnBV0GS3bS8NGlkMVyhd9AxDVYAww4RmSug=;
        b=OR/Dh//7FK7FCuZwaJFwUXMzeNLCBAJ9RLdsEfhU3Sztja9Ue4KjXhpA6d7m59ttLh
         KKaxryoI2H30xOvNGky049PN5HXK1H4NUHJtvoAb2aeaQBNX7VDxsZFQZA0GhGNOxdru
         sDO7SXAEGERSZt4lJlUWia0rAXjIQ3fQ3ly2D+YxkHW2WAqGBzqqvxyksC/7awXsqSaa
         Be7TNjlQtApE21/690C7ybyOyJGJ+yhntKK0+qvFbeCL+0jmVF1wf7bxSpbOKH5ERdrM
         2QW5Jxdw0f/lRojEEDPY6wC9DWF95tCSbym/AmQL76xIT2tiWazkl2pVuhFT9MgbOWra
         HWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ls+XcqdmHnBV0GS3bS8NGlkMVyhd9AxDVYAww4RmSug=;
        b=RyUIBXOdWFIJpZS8Ns3rWzr+eUQvLRmyZy+bFd/JaX0s/txntwnbhCSrDSLymmec1r
         qxdLIk8pyd/TTV0DqXHO3AuA2S5TmngVE6MAhV3LcZPcvt8C8yyTXX6o5nZMU0VrdUr6
         xR2GD5pAAGPao7C+075MFPk4QA5Y1tRQjqaOe0lk40yIYYthu+r+qFpr2LgcCY6YWvDs
         CtP8nfaPjhYxksDsdtS3zD/SdHhJCU6F3CFcVS2tA9gGsDP9RGYVLVXp2iWneW5XYpTT
         mWddpSQeG7laJPHCdTXcRns8gLtZ1mGFwzDvyiCZP1AtNxtRSQEB42mTEs5AB4nMsvKq
         RlXg==
X-Gm-Message-State: ABuFfogpfNQZEJMAUI0WWfbjfHP2ewexiXTIhpOPaUOkga6SG7oKdXVm
        7DRbKKSV11q75M+Ql/O+Okc=
X-Google-Smtp-Source: ACcGV60ihhhwj/Fwz5a8HDmrsXZiXkcS8488isJ+tNPWbZFg8QFA8w0PS5Y8fp8nGpmR794br6814g==
X-Received: by 2002:a50:eb42:: with SMTP id z2-v6mr17509621edp.126.1538397840270;
        Mon, 01 Oct 2018 05:44:00 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h3-v6sm5278700ede.42.2018.10.01.05.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:43:58 -0700 (PDT)
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
Subject: [PATCH v4 4/8] mtd: maps: gpio-addr-flash: Use order insted of size
Date:   Mon,  1 Oct 2018 14:43:47 +0200
Message-Id: <20181001124351.31615-4-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
References: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 84404dcc7824..89cc8cce161b 100644
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
 	if (IS_ERR(state->map.virt))
 		return PTR_ERR(state->map.virt);
-- 
2.19.0

