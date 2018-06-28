Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB34BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744B427A81
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOPJMIjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744B427A81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967368AbeF1XvW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:51:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36724 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967125AbeF1XvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:51:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id u18-v6so244344wmc.1;
        Thu, 28 Jun 2018 16:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jJ0HvTuii/tj87M4Greg6e4RuT0tIJ3zCHzr8ED8vI8=;
        b=vOPJMIjIxgYysNTA4DOcMDN5aUk8U14J7pxvIZhR5tMzEB76KmvOoVsz9T9fT2zGrm
         FT7Woh5jPK2YyZHuWAesV6cddtR6nw/QSH7CGevDGG9e2V+1CflsntKLxH9t6IJls+J3
         Neft3JT18W4djrVnU4H+kpyWCqhtCDoJR7q56KwhL0uIOCwZtU/P4Lo9prOVjBo0dEML
         R7IRlQOsfAvEy7b1lkarnjWFfbs0MPdOyN3D5fKPB7NVSwN57ySWrNTxYfT8xzndGdPz
         INdxIUkvB8RWuOAfRxez9QabPfwsK0o0R6f9miV4rDt0mUF7Qf1QVQp9Z1G1v3uaHyCv
         Efpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jJ0HvTuii/tj87M4Greg6e4RuT0tIJ3zCHzr8ED8vI8=;
        b=reDhrysMfS/DrX5hRurQF3aEyR7XMP0RiAp+L7qt+XUpBwanZJP6SAORRwxhrlO69H
         AMgoGsUS+Xel8wlZbmVK6Z75V+G/OPYo1m9lKzZEblxHl5GK9alAhKgWcc9/qV9DW0We
         VEeKliKid6nR68KrkCfvx45ZDujQNpOaFf7gvylJUapXb65piO8OdjbTnVt3iDUwvLu/
         tTIqJStKphUQf0LeNYNL8ZXPeH1eAg4c17jGwucLRbMPH2B91PwS7uRN5FnGXf4GA2jX
         m2hDpZFf6YAsIkjGOaE1ZUBzKexAZXXX2h53IlzPvw1lPCw2NqTnTSAoKrXvUx29G48S
         gabQ==
X-Gm-Message-State: APt69E37kjd46YqplSI4/8Ktk4IhDxXVGg6HsLLYdKgTEO6DsYRj76pK
        +kmHCpOo0nt4ZUwRIlOIv1c=
X-Google-Smtp-Source: AAOMgpffiLV/vGiTfNgsMu/7vRpjx0m20fCpEjbnc6L/Gnw9GZJHPkNUYYnz7BjPdTcFm42PJLfiQg==
X-Received: by 2002:a1c:7fc1:: with SMTP id a184-v6mr14065wmd.161.1530229878542;
        Thu, 28 Jun 2018 16:51:18 -0700 (PDT)
Received: from localhost.localdomain ([156.219.234.99])
        by smtp.gmail.com with ESMTPSA id z14-v6sm9561863wrm.49.2018.06.28.16.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 16:51:17 -0700 (PDT)
From:   Karim Eshapa <karim.eshapa@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] staging:iio:adc:ad7280a: Use GFP_ATOMIC in interrupt handler
Date:   Fri, 29 Jun 2018 01:51:00 +0200
Message-Id: <20180628235100.4294-1-karim.eshapa@gmail.com>
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

