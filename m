Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C69C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F042077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8rKuVFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F042077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeIETHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:07:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39344 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeIETHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:07:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so6267994edi.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=44fsOrKDWVfx58fmV+sNI0c2GFQ2Hz2krxcXHva4qK0=;
        b=R8rKuVFRnCXj+Kft5NqLNsGIvXMMeqmNP9nJqXKOTELSBpubLBFU5ElKJrd3kxMeHa
         1xOuuvX7w6JSHHW5xYuccS/SKTOst0p8lyOe1CIp3DpSpmvf0+XFWuiFFxfPqL3HK/6D
         gsHoKmkSQ7BHrRXO3Q7b9zgqCQooTG5xbZL7RGj57CYYIplb0V16xbt9LyTT6SOuoTeZ
         1WK9eBIl9uzIkJHAgKYQ6engXwW79F3KE4p1sfKP6pEgfj5/T8Z+PmhF8a/GTJ+fNWY/
         mXNyDUk4nCM/JDsmI42GVzJv3yod2PMMw8my+1/JPZSqaPpU8BLZnbAiqjHKQ8UcuX/5
         cp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=44fsOrKDWVfx58fmV+sNI0c2GFQ2Hz2krxcXHva4qK0=;
        b=WEj3Hzb5qwlt2hHEahkBEtlUV56Wzlz+NZuVhhpzuGlMILvfOhf49ea70G4fvvIj/E
         LoxiLRo4Rwy7qRwWbQfpExHCOgJXkBmS2ptI9xQd9IiSHZvLBVJWPdlyJoPx+c7TRNH3
         XkDbW7ZvpxNwgoz6881br9aPLQFxmYPFS5JGVzsm7W5Z24LoQkajlkeGJ1gae2wb4r1g
         2Rc6pi73YfyOzJgLKQ1XPlwtDcHaDSJZtVb1g8qZy/sw38ab3ygnGNWroDCQMSys/5sa
         v1q99S+9vjZB20k1y6LpHuh7h2NTPhjDBa0CtFjCOnhBmibN36ACc9ftAUshqhl1BVq6
         1gsw==
X-Gm-Message-State: APzg51Bxn+PX3D3nVoPIt3A0GbF4abzOZUSoGO61M0TuZ3VmgMh4LtCx
        +GvD+fNslTTD1mH3fEkzKjU=
X-Google-Smtp-Source: ANB0Vdaee5uCcd9YHZKPQa9fguHdeAT3Gcc9jtgSgb66SKD6zf1piQCAs26gpzHM9PSpfb8Pxsa1WA==
X-Received: by 2002:a50:a402:: with SMTP id u2-v6mr41477867edb.237.1536158220659;
        Wed, 05 Sep 2018 07:37:00 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id u53-v6sm1556413edm.51.2018.09.05.07.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:36:58 -0700 (PDT)
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
Subject: [PATCH v2 5/8] mtd: maps: gpio-addr-flash: Replace array with an integer
Date:   Wed,  5 Sep 2018 16:36:40 +0200
Message-Id: <20180905143643.9871-6-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By replacing the array with an integer we can avoid completely
the bit comparison loop if the value has not changed (by far
the most common case).

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 31 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 22e100f07112..8f5e3dce9be3 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -43,7 +43,7 @@ struct async_state {
 	struct map_info map;
 	size_t gpio_count;
 	unsigned *gpio_addrs;
-	int *gpio_values;
+	unsigned int gpio_values;
 	unsigned int win_order;
 };
 #define gf_map_info_to_state(mi) ((struct async_state *)(mi)->map_priv_1)
@@ -55,22 +55,25 @@ struct async_state {
  *
  * Rather than call the GPIO framework every time, cache the last-programmed
  * value.  This speeds up sequential accesses (which are by far the most common
- * type).  We rely on the GPIO framework to treat non-zero value as high so
- * that we don't have to normalize the bits.
+ * type).
  */
 static void gf_set_gpios(struct async_state *state, unsigned long ofs)
 {
-	size_t i = 0;
-	int value;
+	int i;
 
 	ofs >>= state->win_order;
-	do {
-		value = ofs & (1 << i);
-		if (state->gpio_values[i] != value) {
-			gpio_set_value(state->gpio_addrs[i], value);
-			state->gpio_values[i] = value;
-		}
-	} while (++i < state->gpio_count);
+
+	if (ofs == state->gpio_values)
+		return;
+
+	for (i = 0; i < state->gpio_count; i++) {
+		if ((ofs & BIT(i)) == (state->gpio_values & BIT(i)))
+			continue;
+
+		gpio_set_value(state->gpio_addrs[i], !!(ofs & BIT(i)));
+	}
+
+	state->gpio_values = ofs;
 }
 
 /**
@@ -215,7 +218,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	if (!memory || !gpios || !gpios->end)
 		return -EINVAL;
 
-	arr_size = sizeof(int) * gpios->end;
+	arr_size = sizeof(state->gpio_addrs[0]) * gpios->end;
 	state = devm_kzalloc(&pdev->dev, sizeof(*state) + arr_size, GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
@@ -226,9 +229,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	 */
 	state->gpio_count     = gpios->end;
 	state->gpio_addrs     = (void *)(unsigned long)gpios->start;
-	state->gpio_values    = (void *)(state + 1);
 	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
-	memset(state->gpio_values, 0xff, arr_size);
 
 	state->map.name       = DRIVER_NAME;
 	state->map.read       = gf_read;
-- 
2.18.0

