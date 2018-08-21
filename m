Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CBDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA3320E20
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TureFM6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA3320E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeHURwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:52:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43149 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeHURw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:52:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id j21-v6so10755943edp.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=44fsOrKDWVfx58fmV+sNI0c2GFQ2Hz2krxcXHva4qK0=;
        b=TureFM6XuEiWuY/Bkj9QWy52n0JEuGjKSwf7RlimF/A+f+aHVtugg8XZo6tNbvLQfy
         L9TtR6qJuNnPKxIBhTx7JwKbR9Jqh8KGFWf4SsQKceTHK4/LR/zrlnizwLERaq2EEeDL
         NBlbDNz6Ne/vTIi96V2OuGPuaXgOMgbxA9QO2qGyypMgLSX63cWEoF2aN5KtPJBB3hh7
         zb80wCwH8FEADvrGc/KlDmbAIpcMuiwJoG8PpWmW/KIXNeTSJLLEj3Hf4B0msxJjVV3Q
         RQacGc+kyJJFoHYhvV9uedRhSE3+sGIpFqp/DcfY5Uy5727I1iFCLFewbut3CVFypYCa
         keFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=44fsOrKDWVfx58fmV+sNI0c2GFQ2Hz2krxcXHva4qK0=;
        b=IR7BLFGyzyxMDOkQl9plXHZGoXNhx20PJLK9xspLPegye+cufkEGMzRQh/ZkODP+Hr
         ql+U8oA3pPvVboz/R23VFVESfl9E2mSvpuvfK2U5vKLOtfc6sk8AAJ5wOo4kep2j3uEy
         4SyyMZHh2Ta+BmuK1M0vkQWV1+i+jn3kuYdbRP+zOZ/KdYrh6x5ybCrv+BBlnpOFBxZy
         s4AGHGOjNnbkrN2RQUKVBfZVMruPt2rCrFWwhf4CzpjhRoAZs9oQDKV4t5RW5MzKfAsJ
         nFrzz11V51X38ew8KWxLqehy4L0sGmLOYlPxA5PoqICevYgaeUjwEwmVu+7Aaw8etrQb
         ZTwA==
X-Gm-Message-State: AOUpUlEmJTMFNI5TZHmwEhQoWEM5/XC3yxAgJuLFVD/jVxFBpfASveR8
        SEX8iavXGSar77Quht9N8Ks=
X-Google-Smtp-Source: AA+uWPysAwueP07JGJMVMTyKV6frmoURXSUM9kJKPea7491L39tehO3Rkc/2ifoA/A9iWwW0rwOhEg==
X-Received: by 2002:a50:a6c7:: with SMTP id f7-v6mr61217318edc.225.1534861925625;
        Tue, 21 Aug 2018 07:32:05 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id n17-v6sm6766144edq.10.2018.08.21.07.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:32:02 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 5/8] mtd: maps: gpio-addr-flash: Replace array with an integer
Date:   Tue, 21 Aug 2018 16:31:49 +0200
Message-Id: <20180821143152.32293-6-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
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

