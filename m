Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D600C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D76220E20
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2HYunVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D76220E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeHURwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:52:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34437 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeHURwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:52:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id h1-v6so10787716eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Gk0RyL+JY4us236hlAyW7jZ/UezWkAaOTG9LaGHQ/U=;
        b=h2HYunVT0yPNzJXr7CBKkgXE1KoVin5/E7fg6E8FYRsMVj09CJXqSMQ+jQbrH52WOQ
         lMtAs3TvwfQ1vJ4HlVcjCgbj2JeQC1QpyI5kr11p204RG6AonHLJP6Gmx3RaCfVbHStx
         /pdhv3PVu9XvZ82ABDxNqG8TM2uvASSvzf/46ZSc3bkKGezA/Y9kgbcUetu7pX/C85C0
         z/vek1OB8adusgwPX7Bu8bFS+Iv5MHitYlIKaKRdsgiT5x3BQvMnJT747pF6RXIPMshV
         Lhl5p1M3MYHqoGTiP9518IIyJHbsAdNW2t5qzuEOIk2YU/1vdj9/v/IMwwRJ33qccVlp
         hLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Gk0RyL+JY4us236hlAyW7jZ/UezWkAaOTG9LaGHQ/U=;
        b=hMNr24oB9LSxLFa/KHsAeseJwuVzMtGVu+QZbGMzDRNJrzLAQIuS+1MK9JGzcpQZ2H
         yTEzeWy5UW6eKcMTpbsQqOot3Mom/yTm42ypVkIbM85CXzZE75c3PG9dLZCVtvFwkFba
         Xug+lt/grOlXUuHjYnyv/upwglhWPmMETW5U5xGkA3LzEBrYXAdZts9LdPnA4ylmHYlT
         UeIMSRpw/fTl/4YjErAy6ZrueSItOvm+z5ihJd3VF+5XfaGwS9e0DJxX5hUI6KGgKxR8
         tct1I8Jc7KPl1SEerBj7bF7fD35EXkqgGd6y+dVhQKq55ZIv8AEG92d2TZhnPgUe5W/K
         TWEA==
X-Gm-Message-State: APzg51AnkhH8M69ztNUCZNhW/2bMdatqgAhe/MbALgobJUidA1jHOhK4
        zpV08exGm59vZg53KhKNqjev7Gjo
X-Google-Smtp-Source: AA+uWPzyURC99hdaPJ2+MVok3VwOYL8DXwNLUGWZ6oEwGUwtsEL+lZ2GlmVEZVbdMc2TJsg/l3y4bA==
X-Received: by 2002:a50:97c8:: with SMTP id f8-v6mr8532691edb.28.1534861916955;
        Tue, 21 Aug 2018 07:31:56 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id n17-v6sm6766144edq.10.2018.08.21.07.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:31:55 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 1/8] mtd: maps: gpio-addr-flash: Replace custom printk
Date:   Tue, 21 Aug 2018 16:31:45 +0200
Message-Id: <20180821143152.32293-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred print methods dev_*

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 9d9723693217..17be47f72973 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -25,11 +25,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#define pr_devinit(fmt, args...) \
-	({ static const char __fmt[] = fmt; printk(__fmt, ## args); })
-
 #define DRIVER_NAME "gpio-addr-flash"
-#define PFX DRIVER_NAME ": "
 
 /**
  * struct async_state - keep GPIO flash state
@@ -250,7 +246,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	i = 0;
 	do {
 		if (gpio_request(state->gpio_addrs[i], DRIVER_NAME)) {
-			pr_devinit(KERN_ERR PFX "failed to request gpio %d\n",
+			dev_err(&pdev->dev, "failed to request gpio %d\n",
 				state->gpio_addrs[i]);
 			while (i--)
 				gpio_free(state->gpio_addrs[i]);
@@ -260,8 +256,8 @@ static int gpio_flash_probe(struct platform_device *pdev)
 		gpio_direction_output(state->gpio_addrs[i], 0);
 	} while (++i < state->gpio_count);
 
-	pr_devinit(KERN_NOTICE PFX "probing %d-bit flash bus\n",
-		state->map.bankwidth * 8);
+	dev_notice(&pdev->dev, "probing %d-bit flash bus\n",
+		   state->map.bankwidth * 8);
 	state->mtd = do_map_probe(memory->name, &state->map);
 	if (!state->mtd) {
 		for (i = 0; i < state->gpio_count; ++i)
-- 
2.18.0

