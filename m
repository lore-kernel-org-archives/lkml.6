Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3F5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605F420684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS4nSUK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605F420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbeJATVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:21:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38817 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbeJATVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:21:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id c1-v6so4845479ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=07UVT8AT/WIvxk7YqGQ2CULDktLqJYK6DbMGdKzq18o=;
        b=lS4nSUK+9axwkqOaDUcnV2+Ck1T0K5nJB+f0Cz58Dn9pk6RpDib1FMa8Y5snr0bfBW
         FNk+IHi7AdNx/XwPkXnGjY/3b9VA+EvO06u0YAGf8iLZRzT1WKHnpueVUYAKwkEZMNVQ
         9CISNZrOsaSCvIdyolRkaeO3eT83p9SSL/KWcSh3s33dqe6W1SB1zp6KHQ7Qtb0eY7TO
         Yd3EQ1vR1XxisJJsidWYzI1dJXhW4SKFeT8IUepyP3NPzPRQ/yExk7UuklNVhSrafGmc
         27xl7zY8zP4RedLob9QsdylSRHkOhzARGYSQppT2+nqvD3HRMaYcRAETt4ToK9vRQV+S
         vYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=07UVT8AT/WIvxk7YqGQ2CULDktLqJYK6DbMGdKzq18o=;
        b=ESzS0fXilI9m6K1yJ6raLDlpJtWfLiVv4o1RVJiXbCQq/cihZLVybJgfDIkZ1EAtUJ
         QFPWkPSuYBeqvgwMfkBJ5zAoh9SAPj3s2JNieplOKQ3CAP2VqApKGZ88nBQAAdTS0ADo
         p4VfsbgSG50fH8C4kv1jR/6Mao2MMacMv6O3qTBGhWlNG9ZfkyACrhE0S1o0Nn8/h575
         yQuV64etxmYC1FCckpAambAzK8dsM4q4g/+7rtDzYjN7d0GB+/k+L0pm0b1oZDQkH3CT
         ns4sQDCcAhBFy6qHwPf4LobRQGRtdFNhMLBx0CKoy+Ynjmc34G+o4tqiRuwPs1ev31Hw
         6yRg==
X-Gm-Message-State: ABuFfogOWRZ/UuVa/6eB24tKUBODO78uhi6gp00vZQeoQVE/1JTl3qYp
        lVOO5ogrk26+I3zeNO79Muc=
X-Google-Smtp-Source: ACcGV62u/8XO1IZD8vky9A1A0eMz6qxvKKasRGkyEDaUh9Z6NNK0CQ63/RbvfJ2RMt/FTmSEDxmKOQ==
X-Received: by 2002:aa7:d694:: with SMTP id d20-v6mr1529753edr.209.1538397834703;
        Mon, 01 Oct 2018 05:43:54 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h3-v6sm5278700ede.42.2018.10.01.05.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:43:53 -0700 (PDT)
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
Subject: [PATCH v4 1/8] mtd: maps: gpio-addr-flash: Replace custom printk
Date:   Mon,  1 Oct 2018 14:43:44 +0200
Message-Id: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
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

