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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B8CC65BAA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CFB21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF7AzKxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CFB21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJDC26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:28:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33452 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeJDC24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:28:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id g26-v6so6463922edp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPXLWgPAM9TKQD8PmLyfoPaLlJmlL7ExTK2t4PzAkrc=;
        b=WF7AzKxAHmVg15NjPolfwQE6JFnpO4j0FXA1sBmAriTLE5SHA+HLC0KSB8wl8wl2jg
         15Ewc7v9sxanVs3vuc8/iz64MbP2rYzjwkOZXgR9FLOX5itNo//pMI8gS0mu6Ww4hjQk
         cQLBmv95XznI3VlXM7pkVni96JpiAt6H/qTBIvoHbNt5CxyplWxoi0XyU0yKY+1IpyP0
         uJyFliagf2xtDdvjEjTfb2BrrsfVnyIu9aL3V6dkHlSDVmFikhBtcchmpVS/HqFjBBmS
         uTXFvWDVYUtOrZz1Ks1e/M+Mhqwn1FPIbTpieAdp1dH8aPlLn3ibS5NP0MLDmduYeLeZ
         6+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPXLWgPAM9TKQD8PmLyfoPaLlJmlL7ExTK2t4PzAkrc=;
        b=X2e7Wm3Js7spu+ZwCqRxnKOk5RYebbUwTo8/aZ8U8Dxu0CigKACw/jprdC5wKdf/dg
         qFgWzFyBw2ddTN2PH96B0cTSVmmc7LvwEnzxeXD5wf5gukMA4qSTjhQCwJUlKyUl+9FB
         zXubRohs6dR+ozB1CGJgw9ejRyyGF4yDCMvwccbAoTbdJHMkMse3QUD0PBugIX9H73qZ
         3ekJ3LxIfmLMKY42PlfroN/QSi7sY3MFMWDE89BE1kKWtG+qNFK1AkcJIxnx3UM94y8+
         yGYekPbk51mQf065ZFmsVbK82ElKLYSBCXMf1tC5XE1wsFd9S7v5Vq+3urd46HHbCHmm
         pyhw==
X-Gm-Message-State: ABuFfojAA8uJdQ9wAnmB7Gcjm2qQUDWVeAJy2tdT2RnD+s7VaJcwCCDe
        2Efz+sibdZObnHKh4HhGKt4=
X-Google-Smtp-Source: ACcGV63mIaLRnWLzFzN7ZdLVqEIp7IZj6dG1qVQgRdbkYx947rO/v8gZXpjcWpwpu4GGAaY1q/XZYA==
X-Received: by 2002:aa7:d4c7:: with SMTP id t7-v6mr4213737edr.256.1538595549107;
        Wed, 03 Oct 2018 12:39:09 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b49-v6sm765263eda.70.2018.10.03.12.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:39:07 -0700 (PDT)
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
Subject: [PATCH v5 5/8] mtd: maps: gpio-addr-flash: Replace array with an integer
Date:   Wed,  3 Oct 2018 21:38:56 +0200
Message-Id: <20181003193859.23928-5-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
References: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By replacing the array with an integer we can avoid completely
the bit comparison loop if the value has not changed (by far
the most common case).

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 34 +++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 89cc8cce161b..47b12a6fead4 100644
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
@@ -202,7 +205,7 @@ static const char * const part_probe_types[] = {
  */
 static int gpio_flash_probe(struct platform_device *pdev)
 {
-	size_t i, arr_size;
+	size_t i;
 	struct physmap_flash_data *pdata;
 	struct resource *memory;
 	struct resource *gpios;
@@ -215,8 +218,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	if (!memory || !gpios || !gpios->end)
 		return -EINVAL;
 
-	arr_size = sizeof(int) * gpios->end;
-	state = devm_kzalloc(&pdev->dev, sizeof(*state) + arr_size, GFP_KERNEL);
+	state = devm_kzalloc(&pdev->dev, sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
 
@@ -226,9 +228,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	 */
 	state->gpio_count     = gpios->end;
 	state->gpio_addrs     = (void *)(unsigned long)gpios->start;
-	state->gpio_values    = (void *)(state + 1);
 	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
-	memset(state->gpio_values, 0xff, arr_size);
 
 	state->map.name       = DRIVER_NAME;
 	state->map.read       = gf_read;
-- 
2.19.0

