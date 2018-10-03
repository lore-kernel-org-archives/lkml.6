Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60043C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256592064D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfvOGDgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256592064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJDC2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:28:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44734 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeJDC2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:28:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id z21-v6so2011158edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZUbn50UsHuR5ct+6gyJtPRAN067Ky0FADOBnmfRKwk=;
        b=XfvOGDgVDnLcs/IOZQoaIjspO/jdgu0VXcHCSb/NfZyJ6gUALMY21KoSfkSKfLP87y
         TZTHfLzMKYwq70iB4pcbufv2tXbjsieshc31Je/enNmfxUwJLcU4/6r7TFRgUbwAtFo6
         xfClP5QflIjCmvwa2N0FwXlkW+1MGd4KJmTzlT5dioChjzBgjouctW5KFvMbe/sFlAZz
         GeNqxfc+fytHL9BCRtDbQY8wqf0YjJ31cYO9wfJoUvACMQEStVh63GzaEagCQsaWawUX
         S98CaGXyy28obSY2z5owgOwU1XxhONBm/xNzVGKBfHPqcOJ015jlkNJ80pjYx4C48KXh
         iUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZUbn50UsHuR5ct+6gyJtPRAN067Ky0FADOBnmfRKwk=;
        b=IuBS3VBbRgZAMx1SsiMvHNkw8ZZWLZvDEpPJdszfyBwPcsXv999XNJZq8EB5G3EdeL
         2FiAb/vhKxJt+l3+bPzAhCc+3ZLaBhdNNRXi6JBC4ABevVdRkibFM/B818SDT0RYQHDa
         jR0pGg0DqsjGk9+iv54odrfw8BcXJkUAFmoMt0U72YXvdGQLJ4EQ/rZWMiTDysLcKUuA
         zZtqHWwm1CHJgy4SlI+TrEZjVSd8n1a218SW0Avc043UroQIUNapRpXsQohEkpOu+I1S
         y9BbbKcPXJYhEbMZ/xWboix0Tp9vmFRsr5FxOzJ2CW9hKh7HIndsaZtS2TLCLuPVxF0G
         KXWw==
X-Gm-Message-State: ABuFfoj0IxXQz/FuLRZs7gycJTfzPQEEhMIRJ6I7fLweYUtKBO8iul2n
        BYcFSCgXSDBtb7ejkIXB1eJ9VLfY
X-Google-Smtp-Source: ACcGV605BhK38pwwP7PTKy74FZNewQxPiUagHNwacKxE7pu7dJedW2iJKh/f2zXpGC9KevpkzuCpeg==
X-Received: by 2002:a17:906:e0d5:: with SMTP id gl21-v6mr3364691ejb.92.1538595545425;
        Wed, 03 Oct 2018 12:39:05 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b49-v6sm765263eda.70.2018.10.03.12.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:39:03 -0700 (PDT)
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
Subject: [PATCH v5 3/8] mtd: maps: gpio-addr-flash: Use devm_* functions
Date:   Wed,  3 Oct 2018 21:38:54 +0200
Message-Id: <20181003193859.23928-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
References: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using devm functions we can make the code cleaner.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 6de16e81994c..84404dcc7824 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -213,7 +213,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	arr_size = sizeof(int) * gpios->end;
-	state = kzalloc(sizeof(*state) + arr_size, GFP_KERNEL);
+	state = devm_kzalloc(&pdev->dev, sizeof(*state) + arr_size, GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
 
@@ -234,9 +234,9 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
 	state->map.size       = state->win_size * (1 << state->gpio_count);
-	state->map.virt       = ioremap_nocache(memory->start, state->win_size);
-	if (!state->map.virt)
-		return -ENOMEM;
+	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
+	if (IS_ERR(state->map.virt))
+		return PTR_ERR(state->map.virt);
 
 	state->map.phys       = NO_XIP;
 	state->map.map_priv_1 = (unsigned long)state;
@@ -245,12 +245,10 @@ static int gpio_flash_probe(struct platform_device *pdev)
 
 	i = 0;
 	do {
-		if (gpio_request(state->gpio_addrs[i], DRIVER_NAME)) {
+		if (devm_gpio_request(&pdev->dev, state->gpio_addrs[i],
+				      DRIVER_NAME)) {
 			dev_err(&pdev->dev, "failed to request gpio %d\n",
 				state->gpio_addrs[i]);
-			while (i--)
-				gpio_free(state->gpio_addrs[i]);
-			kfree(state);
 			return -EBUSY;
 		}
 		gpio_direction_output(state->gpio_addrs[i], 0);
@@ -259,12 +257,8 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	dev_notice(&pdev->dev, "probing %d-bit flash bus\n",
 		   state->map.bankwidth * 8);
 	state->mtd = do_map_probe(memory->name, &state->map);
-	if (!state->mtd) {
-		for (i = 0; i < state->gpio_count; ++i)
-			gpio_free(state->gpio_addrs[i]);
-		kfree(state);
+	if (!state->mtd)
 		return -ENXIO;
-	}
 	state->mtd->dev.parent = &pdev->dev;
 
 	mtd_device_parse_register(state->mtd, part_probe_types, NULL,
@@ -276,13 +270,9 @@ static int gpio_flash_probe(struct platform_device *pdev)
 static int gpio_flash_remove(struct platform_device *pdev)
 {
 	struct async_state *state = platform_get_drvdata(pdev);
-	size_t i = 0;
-	do {
-		gpio_free(state->gpio_addrs[i]);
-	} while (++i < state->gpio_count);
+
 	mtd_device_unregister(state->mtd);
 	map_destroy(state->mtd);
-	kfree(state);
 	return 0;
 }
 
-- 
2.19.0

