Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D769C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116CF27A73
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMotlqLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116CF27A73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936301AbeF1XzM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:55:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34107 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeF1XzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:55:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so586680wmc.1;
        Thu, 28 Jun 2018 16:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jJ0HvTuii/tj87M4Greg6e4RuT0tIJ3zCHzr8ED8vI8=;
        b=pMotlqLFxc8OLEZltEF7pLDWf+QKva5zcsSr4SqlSSPOFU9LRL9EbTkVN+AO29diXz
         6HAVL70jzF0CR7syE+OpUATWzzTxLf5AGuzrAoRWjZZpepRRw+Q29z5aMd2qhHjNbaoR
         fxGJBlku5WCMYHaak6E9Ek0R72WnpncFWdte04t4V2SfX1NTTBU995NLZCN/LLnB/WJ2
         IGFa7Z/5aEBy7dsXLfCbk0a8/TPfDwNb7xVl6XI5x2lL3z+iXxkU/R5qS8CSGNii6a0B
         uUaXRIXjk1evyZs+p2oTwzxeGRTnyFiAYiD4NdsrlpWpjdWwODO/BNHeLoQB9EKaTt07
         uEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jJ0HvTuii/tj87M4Greg6e4RuT0tIJ3zCHzr8ED8vI8=;
        b=gAqxc4LfEUsujyEaOmNZpOfeBcwOWAGocaF4JlE6UU6bhuZB0CSJyOYTZ/q+M3VCbQ
         A/Jyf+4aAh0YpSmr7XhL1fw4FaUL2cA8QowaLMu6299gNORpdCHR3aLpxQmAX7R9s3uT
         IjOAzfEO76YAw5ebbKjM/1DykgUgEoSp5jGfenJwujslbMxsX1otnnroW/fuE0VsPRxM
         +3BCKHUpfFm6vCP0GOaFpFZmYqSWz3HxQ7siFsdOv8ztBo4aekRPofvLHjmz1lC2URHm
         c9V8VhntBR5qjO5ulukfh5XPhW13iMZ4yQVK5pBt1QX/l93yD3lUQtbTuuQac48Di0dC
         LzLA==
X-Gm-Message-State: APt69E23nw+E6NbjMKGwXBdbWtilG6GdMY/l3HrvXLfkTHbXMb6X9UvD
        PXAHQuMiGlU/BkgbSKNKrEU=
X-Google-Smtp-Source: AAOMgpeNbfBKLF5XrinHn0nLUKbk4MSWYp+JmJzMYfCySgN13f3QCs8DEO4b6pcIGrjw11waj/LBNQ==
X-Received: by 2002:a1c:d483:: with SMTP id l125-v6mr33213wmg.98.1530230109163;
        Thu, 28 Jun 2018 16:55:09 -0700 (PDT)
Received: from localhost.localdomain ([156.219.234.99])
        by smtp.gmail.com with ESMTPSA id v10-v6sm1305820wrm.80.2018.06.28.16.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 16:55:08 -0700 (PDT)
From:   Karim Eshapa <karim.eshapa@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] staging:iio:adc:ad7280a: Use GFP_ATOMIC in interrupt handler
Date:   Fri, 29 Jun 2018 01:55:03 +0200
Message-Id: <20180628235503.4464-1-karim.eshapa@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GFP_ATOMIC rather GFP_KERNEL in interrupt handler,
as GFP_KERNEL may sleep according to slab allocator.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index b736275c10f5..25c4fbc303f7 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -692,7 +692,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 	unsigned int *channels;
 	int i, ret;
 
-	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
+	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_ATOMIC);
 	if (!channels)
 		return IRQ_HANDLED;
 
-- 
2.17.1

