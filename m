Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 88550C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332E92089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU5i1jzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332E92089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935267AbeFLDPK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:15:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39744 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934958AbeFLDPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:15:08 -0400
Received: by mail-pl0-f65.google.com with SMTP id f1-v6so13517686plt.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 20:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GG3zVFMiu3Jz0YuRpJSyBvqtBSRol/XgVgxuDZDIlY8=;
        b=oU5i1jzHL17nepEXmHNAERYR0oLYrH0dsJ/oHftd7N4IZV5RocuTLTofOmybdGGDa0
         KzjLrWqV89uk8WFYyXjXeK7sZErchDox2iYO2SNgwTR9Bd/FxPutft5Q8C0sPbDJVjL2
         0HnqYwhWyF3Jgix9pUsraZ5cKrC9EtDmW/vTIp003NUkPYMmZNJ0k+zOp18wIC/qE3/g
         7VC3kogv9s78yrweuXXLSBaaOLowf8CHVT6noqwzWkDOoj0A0VQSAPUZRz1Oq/q3sJyb
         S4F6CRJZjItAc4E7M7bfnAHRnq1j3ZBVIbemsW74d470ZhsNmmeuKsZKHn/k4/hZt1J0
         DiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GG3zVFMiu3Jz0YuRpJSyBvqtBSRol/XgVgxuDZDIlY8=;
        b=rRacdWmOTOwmBUOZ8E/toTzqotUFjE8IfpG2D3NpQWSGKmZQS0Ean8pP9YiF5YbLAT
         yuPLQzidFEnAckZrW3eWXmd/V9uK2u3zKJhQotn5Ak9lwL4SPlm+eJQyLpr5/lGXyctK
         8cLE0vpFw4evcSfbrVK3LAyKh5WAvCSCMsjjoJ4HocpFjeJXkUX7FvYAnUlx1iC1JAVB
         b1nJRWAGQt5WWLl6BmAIpGN0FMEaABUloBXJ6kDoMciLEolnEwiZti6aVY5+HcbUsLwN
         AMi/nhJ+0uSkJjlhyyJ7IGdkzmkK/XnhqjXdQDCwkA1RP688mfnZHRkPymOi6gOGDR1B
         4h5w==
X-Gm-Message-State: APt69E1klYLhgvjoUD7G53IyQOXJcuq4Xi40HIomokzgPI4K+D0tInQG
        a88+mpDo7T9GBL13SgLFzhU=
X-Google-Smtp-Source: ADUXVKL+hm47R+f/41iakVvKDeSkP1hWjVolfgzsaKSsp+aip29HhI4d0YS/zE145xxdvaOvltzByg==
X-Received: by 2002:a17:902:570f:: with SMTP id k15-v6mr1963870pli.17.1528773308483;
        Mon, 11 Jun 2018 20:15:08 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id h124-v6sm30706446pfc.100.2018.06.11.20.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:15:08 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: gpio_flash: add error handling for ioremap_nocache
Date:   Tue, 12 Jun 2018 11:15:00 +0800
Message-Id: <1528773302-37265-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ioremap_nocache fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling ioremap_nocache.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 385305e..7fbba02 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -242,6 +242,9 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.phys       = NO_XIP;
 	state->map.map_priv_1 = (unsigned long)state;
 
+	if (!state->map.virt)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, state);
 
 	i = 0;
-- 
2.7.4

