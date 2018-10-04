Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5087C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3712084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/rqbKWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3712084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeJDTyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:54:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46864 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJDTyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:54:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so8253084ljj.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07UVT8AT/WIvxk7YqGQ2CULDktLqJYK6DbMGdKzq18o=;
        b=N/rqbKWOjv4JZB2KzozopLDsUfVYb2X7N+HYHiYIL9sCkIp/UBzjQwlbOhIW5PQAvE
         1qsRUxPIMoYtRXpYKCuoRjBJkhakRjr5qzxhP5MUramb0rcVo/9TxWq138GcSLblYzZ+
         s/QNuTvOqYFpqtPgZ/FlmC56A6yM5YLCpIJEUGsKlx4FE+SDn+Zxy0j1JM9a4gRvLRW0
         bWi+smC3xkcD9PB+u8WitHxyO/HwWi5XkYnirDTV5CthLdhV6P5VFpEIWTrKgB0qp5uV
         GP/3UoHf5ioxuXosjfUcxFVNDYNaaVxgTdZyJsT/RagOyCy8TPoDvEWaIad9oAMW/j+D
         /OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07UVT8AT/WIvxk7YqGQ2CULDktLqJYK6DbMGdKzq18o=;
        b=ufzSGvtztvg5Gqhj0W5MX4I8dCBCsvPHo4Bnt4JAvYqIiKS6XHIlXDfIBoL8Nqtxa6
         OYbqMFXIQj25JdM/YLWmtE2RUbV1dq0e6vtosxy6grVVWNWGj7lQgwV3gCZv5EHW4MNy
         uoz8khEbW5jVkrZdKul28+EHqFh9X/NPRMFTVxYu8IiZUSrhS/b0GGpKsxHBQFvYkOoV
         mheI5TypuWl2DPIP6rHNrxxPzGlUDx7/utDgdv2Gg/x5u8L3XI7ed+9SwRlZspxn5Uvl
         eI28H32hj7gQ6uyoTXkZT0rho+Q8YU9L2z+CWDdzpOG0R+FxvuVd0KPnRZ0G0CPZQZYc
         n/ZQ==
X-Gm-Message-State: ABuFfoiQvpdhsa9rXB1DH4DaJ6I+FrW2qrMQZfY50pMhLJ/8B41BiBGN
        RmYG+con+f0266w8YOwo3u4=
X-Google-Smtp-Source: ACcGV63YpbB3H7z/WHChEGvBSmPLyEzmsEEMfZK7GaCwK7YSjv4FDXJMYT+wIl1nOfKViZ+/0qtayA==
X-Received: by 2002:a2e:5859:: with SMTP id x25-v6mr3012996ljd.7.1538658086969;
        Thu, 04 Oct 2018 06:01:26 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a1-v6sm421415lfk.63.2018.10.04.06.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:01:25 -0700 (PDT)
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
Subject: [PATCH v6 03/10] mtd: maps: gpio-addr-flash: Replace custom printk
Date:   Thu,  4 Oct 2018 15:01:03 +0200
Message-Id: <20181004130110.8496-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.19.0

