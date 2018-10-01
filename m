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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C47C0044B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D03120684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mACUNn18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D03120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbeJATVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:21:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44627 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbeJATVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:21:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id t11-v6so14043891edq.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPXLWgPAM9TKQD8PmLyfoPaLlJmlL7ExTK2t4PzAkrc=;
        b=mACUNn18Ky2W8FDSUPahbae8krLe3WGzpfzh1fvuHvaeqhiirNzHBgdjLSBYV2nA6s
         EMHqMbUYROmDvXxsjfPxW0iXFAu/OrSBhld04+aaTV9kAXXu83O6beIjKhBjeiE6ZXyT
         CHiMUX4bconTCmLc0b/8oGcvUo0nYv9u/cgNW5tjIt1z2UmNXauC31QW5LwezVvBtNzU
         J0QZIsQfn2Rrf3A2xCgqDT3TiH9o1enltFH/n1Q79RUAmSkca+xhdGGdT6l4bGKX8Q1J
         YL7e6S9+qR/0u9Iv1e4Rxs8stjvdQHrxCmtj0l815PbRZx7AvMO1+odKOiRPjDDrfDRp
         EHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPXLWgPAM9TKQD8PmLyfoPaLlJmlL7ExTK2t4PzAkrc=;
        b=JA5yge+KkR4/Dfi0dkWBE+fq0xZ1LOagETI5m2mAv8Puu7/cYN3FpAunZevMpAstVx
         ZZz5BFMxNrIXpFe9fp08jNU/7s58iShn1T8gOII6XxDh1iBF/3TkSG013UYmrdTgnxMn
         td2sl8Kl3X4cNWSbocrNrvxCq2xgk4isZpNN/yxpNO9TdUmL5ih6yUi2CcLdu2RHTBkl
         8E+WYbfXYSG0jvV2gjiSDByZeDnZ1LTJrmdHIvbw1Uu4nFGIlSL5a8RbGbvYxoXatYww
         rWiuiSkZD32uC5WleupHAzl3XQ06RvexPj5Q1/jPEoDY76z9D3qSS7oj8md1W7TGjDwI
         rBew==
X-Gm-Message-State: ABuFfohxz/1Ta9uQa9PJTSbqXlTygNjm7u7wQRlT4iV1zxxYMHrgZO8l
        kV9+GlL8vOU8yL5zKoWNBSoFU/uE
X-Google-Smtp-Source: ACcGV60buRmH+KwK/huQDB+4QcNqOMmI1sjXmhssqi+TJQROedwXoSAaUvwHhWRhqOqdY8KkIhCwYA==
X-Received: by 2002:a50:9949:: with SMTP id l9-v6mr17051120edb.277.1538397842150;
        Mon, 01 Oct 2018 05:44:02 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h3-v6sm5278700ede.42.2018.10.01.05.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:44:00 -0700 (PDT)
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
Subject: [PATCH v4 5/8] mtd: maps: gpio-addr-flash: Replace array with an integer
Date:   Mon,  1 Oct 2018 14:43:48 +0200
Message-Id: <20181001124351.31615-5-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
References: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
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

