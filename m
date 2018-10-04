Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF332C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A447821470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blfNUV8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A447821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeJDTyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:54:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33812 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeJDTyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:54:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id y10-v6so6712276lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPXLWgPAM9TKQD8PmLyfoPaLlJmlL7ExTK2t4PzAkrc=;
        b=blfNUV8Li7VdqR7yIcIf84B8bEzopdp6zO2+jdYMtxaUWeE7vPvRwfRC1XZyR+EdlM
         Ji+D2LCET+bp//Ij4ln9k5E97+2Frp+5i/7xNuHiEnBdGQTzy7oFelCamYNnudUUJycY
         vduc0vY3MypB4oRiB18EG/p8eKzVRdvWmQNNDbGvDdZeciSCObexH3xCSfcFAhqKLh5x
         k5JR3HAlvoznDl20rZJDh9hhSH4HQgJOsWt6c+lwIJFDpVZGWXy5bYqRX8hZkc5HFs5R
         NEM3gsbxV5FQLGBATofBbMagLoWvO7077Qvm3X/lz7KSIKaKbWbaGF9Zyc0vE+Btc8gy
         pGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPXLWgPAM9TKQD8PmLyfoPaLlJmlL7ExTK2t4PzAkrc=;
        b=Pyr0IpeODh+eSLLh1CQdkVJY5HOEQkPA9szAfxN7YPlF/2dF/o0K3LZlv2LvtHHJFS
         /eaaUZn1RQXVDVmujVuwhw0Snt9FpWTaT3HSXH/iYrpGAp7+Z4FSB9M5MHgop8hacfCu
         C9ncO98z1fETLQriAZs1NKlMJKeiDexqIkq8MsgnnY7mKatibDVFbAEkBsFiB/0d5KoX
         mC5Xgz6jM5qrDv+P8gWu/jTQVDeBxYdMryGx4BD+oaEbkNCE9r/0n1x8bmiaAxGJHWm8
         DtUQnUGProtndSYQVJFe/AVPSEZkimDHuukbOtZF6b/WNdkqZu+oyHcBNYw0vEoinFWs
         zpHQ==
X-Gm-Message-State: ABuFfoiTJZvITtKVnbusNf+cV75Gr7NXE+88+1oYrbIOM5g51ruRHIHy
        56lOjP8SjkU1hU8YAw9l2G0=
X-Google-Smtp-Source: ACcGV609Jy+l/OyYktqEvlJthDghglfBx6OE1g1UivdMySWUnjLRyZDbcjD1CE0nHb+QjUMtNKUH8Q==
X-Received: by 2002:a19:964e:: with SMTP id y75-v6mr3763927lfd.58.1538658094203;
        Thu, 04 Oct 2018 06:01:34 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a1-v6sm421415lfk.63.2018.10.04.06.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:01:32 -0700 (PDT)
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
Subject: [PATCH v6 07/10] mtd: maps: gpio-addr-flash: Replace array with an integer
Date:   Thu,  4 Oct 2018 15:01:07 +0200
Message-Id: <20181004130110.8496-7-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
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

