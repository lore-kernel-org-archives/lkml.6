Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E89BC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40C12064D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRee/Yup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40C12064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJDC2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:28:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41033 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJDC2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:28:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so6430596edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=07UVT8AT/WIvxk7YqGQ2CULDktLqJYK6DbMGdKzq18o=;
        b=uRee/Yupj1+ZPGRaxOK2b8xZbnlW4WyQn8krI9eQW/rrerl/CfSaUPYUMF8nT/tmz+
         Ar1XEJSIZThRU1VbhNQ0em0qEC+8W4awQTOT1ytQYJgNvvH6uLT5yg1mto0zM9vIbmKF
         C4kGDaeYyRvIlsRlyONL4+OGEwtxKD105MTRm1tqvSe7ik4YTjZSP+EfhxcoJRWVUf6N
         Y/ez55i9NqbW7NjhtUOhfoA6x4Nk3FfhXVgKMchf0uwaGw0t6sEtzkd350UmvocD81Fd
         Q4+10gTghEK2Ql/pOpExDCkoxkxyX4LN9NVkCxItb7D4qmEBCBJfbjnPgOT3ouRv6nCo
         lDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=07UVT8AT/WIvxk7YqGQ2CULDktLqJYK6DbMGdKzq18o=;
        b=Dra2wUaL4u5h9TTnDZePqoFBrRbdkpYXd2O86YGptCouNvRaRESjbzCAIIkfcdUzm4
         uxmE/o2CLt0hK0WM28dY37BPOTUYHRsBQpZOzV1NsGMcTDJCE5/vnWqe0vbiY3lPvhRF
         PaHkZvtdFZL42R3tUzQ+EsrwgiWHBOWkiDXioZXcgNUS6iKEkIj8US9rey8NUqpzJOs+
         fGNMohBkrGh5Is7ArcnInHexoe5XJL47nPJkyRCceCdz7Een1m6CZZJ8wmMrVnBJJR10
         Ir1OqhvMBMhgvfqK3KlEVYrSHqn9WVpaErcpJQe7vJf4NPw28L5GXmVHqDqMh5/0FdFS
         sHcQ==
X-Gm-Message-State: ABuFfogR9uLAo9rtykgAM987rXA1OFatZv8Zz5zu0Azi4rZK/2a8YHHG
        +WBaPUIcxBn/6+/8N86qtd8=
X-Google-Smtp-Source: ACcGV61MxhDUVN6Mdt+0+VX0V9mRPjvMR7fRrSMKvaLzHTcDN/QVpmI49XCd8IAcMCo1WRtvxbRouA==
X-Received: by 2002:aa7:c406:: with SMTP id j6-v6mr4404678edq.134.1538595541851;
        Wed, 03 Oct 2018 12:39:01 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b49-v6sm765263eda.70.2018.10.03.12.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:39:00 -0700 (PDT)
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
Subject: [PATCH v5 1/8] mtd: maps: gpio-addr-flash: Replace custom printk
Date:   Wed,  3 Oct 2018 21:38:52 +0200
Message-Id: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
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

