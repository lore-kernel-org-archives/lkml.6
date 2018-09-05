Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9530C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9E52077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwcLa7nI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9E52077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIETHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:07:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44493 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:07:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id s10-v6so6250408edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Gk0RyL+JY4us236hlAyW7jZ/UezWkAaOTG9LaGHQ/U=;
        b=JwcLa7nIGzBKw7IWoK/LwBCqY1Hx9qaXkP7S9je7EBr83IoXS/uL/I3M0t1BC6pJmn
         /1ok5a+4/LS/NTGWuJnwIzHAemPkLqPptFHBQDaJ8nQ4vzpRA8514hPBKT9FgJq1YsUt
         lYpqRjDbrGj0ZaY6STxsHoIpXOCIXxYCYlDVtnMzed5el3T2GZ5BhyHi92g+RD0Ii1BU
         If1bt+AvslHi7EEWxHunYuDUh6TQj1tYz8VrThpQbm+pLvCNgnLlJxWYga9o1VcpfO1Y
         30IYiZfD1Bnc/xPMd+Mrg/lcdQ9LyVMkOdwpFHR6WwlS4aylTFGqrnO+tEYyjOEBGMAU
         t+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Gk0RyL+JY4us236hlAyW7jZ/UezWkAaOTG9LaGHQ/U=;
        b=nB43h7aaSq4m2wgLmVleG7gW3BTooiPntJDH3GL5H/S8VRA7a6x02VIXCuzQLEpO4f
         5bAd+KIDZ5UOcg7HWstod+RV4oe3lijPSQiII2GQq2AP05GmDojtBMY3gJYYCWB2qg49
         yhsOPcO9oVhNAJHTDQagP2dJjWJkQDWB+gWYLJQLUlys8Q3aDuRfHbpIATW/Eo64/zQC
         V0r1oloks/HN+m4ZAyCRziUYZ19hgNsZ4PDHUQvMrxrf0/JqXmo6uLUGYNKdiwQJ2cLr
         T2BDtW6g7yaAR06r0Ter7e/Ps7Fuodv5zDat2uA6q391MRfoGfEaPi4ial4XUaR/Kk3p
         ac3w==
X-Gm-Message-State: APzg51AYR9m9xD5dxM4SZuQ576Bqg2R0Sb9s+sOhAMQ57+eCo+7+76Xk
        WojqzWDGjtsEXP6Q/ga9fRAzNSwe
X-Google-Smtp-Source: ANB0Vdbgo5c/do+IYNn/fh/BpRga29VgRvK+JQie/WEMXqqDEnQN5D5alPAyeRZ2HUuLYGAtM15SMQ==
X-Received: by 2002:a50:8c06:: with SMTP id p6-v6mr27542503edp.282.1536158213368;
        Wed, 05 Sep 2018 07:36:53 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id u53-v6sm1556413edm.51.2018.09.05.07.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:36:52 -0700 (PDT)
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
Subject: [PATCH v2 1/8] mtd: maps: gpio-addr-flash: Replace custom printk
Date:   Wed,  5 Sep 2018 16:36:36 +0200
Message-Id: <20180905143643.9871-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
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

