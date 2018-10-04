Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199EBC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48632098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaC08QwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48632098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJDTym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:54:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44347 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJDTym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:54:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id v6-v6so8268119ljc.11;
        Thu, 04 Oct 2018 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjA+sX8gLHXduyIAmFIqULLnywYjal55pxx0KrC3qkQ=;
        b=DaC08QwAwE2cTfCAxrM3F28jYNckLgd4bT6mvCs6SzyUnE4Z+snHTMWUQyBVzz824t
         yFGiDNK4pL5N545rt2WiyO3uEQKEE63uQFYHakxUF0jDDcbxsHhZd3bmOc+0W5VWToQg
         4Nhom2t70glWhW8zmlkPmZ9zXWr9jvgJ2SWRxhE1+PuGzpqv9fwMmModxGj4rEApomQc
         XWILzzApBGS2doFsZk7W3/RNfFFatADTGCbnXOuoyd6VBKIKpay14f/qdsm0VRiTipnp
         Ncwlfv38+s1MjdU9a7OiN0EqofBFeFpZNo1Zi+VJU8Lt4ElV1U6S4Q5XNGd1Z+w+SN17
         1rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjA+sX8gLHXduyIAmFIqULLnywYjal55pxx0KrC3qkQ=;
        b=XPIy4roH79hoTZX9cT/aM4baoSSriTkm02m4nVuJR8KdKTEJaDpyirckqjMp3QYPlC
         XUbB4bmYKgIxljFUKo90nUL3rIppCCLRRtd7JmwjnqlSKBZySkq3AOT+MM5dxvvnUiw/
         PS8Elp61WfGMV/Tg5pqU/rnvK6RrIkjqBlhw9IkTkO6t1GdnwilXkj1pFbtN8WCTx1fN
         +pVW5OkukwXjcKTMNVosoegiB1YrQ/ZcWj8TmN9Jb930D+a47+0Y8pcraKPDjvENuAGN
         4mlyAMxAZ0MuZvKNVzDNh2LSP+JeJ2Mvn1g6ooPQSGscpSMuyQZr6ve1dx0BQApXVKdv
         4X/Q==
X-Gm-Message-State: ABuFfoieMEGUkHw+dOELRtDbAZnikLYQsq6rQ2Mm6vEF5sBU6qa9XbUE
        AgmlLt1rknFbdWdejEP37bY=
X-Google-Smtp-Source: ACcGV63otuM/988L9WVIeBq2XXb69tMNyC4D3iy2/jVGNACq1D9+NGbP1hYxpHGJVJyvjNLRWtkscQ==
X-Received: by 2002:a2e:3918:: with SMTP id g24-v6mr4093315lja.113.1538658088406;
        Thu, 04 Oct 2018 06:01:28 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a1-v6sm421415lfk.63.2018.10.04.06.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:01:27 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v6 04/10] mtd: maps: gpio-addr-flash: Fix ioremapped size
Date:   Thu,  4 Oct 2018 15:01:04 +0200
Message-Id: <20181004130110.8496-4-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should only iomap the area of the chip that is memory mapped.
Otherwise we could be mapping devices beyond the memory space or that
belong to other devices.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Fixes: ebd71e3a4861 ("mtd: maps: gpio-addr-flash: fix warnings and make more portable")
Cc: <stable@vger.kernel.org>
---
 drivers/mtd/maps/gpio-addr-flash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 17be47f72973..6de16e81994c 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -234,7 +234,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
 	state->map.size       = state->win_size * (1 << state->gpio_count);
-	state->map.virt       = ioremap_nocache(memory->start, state->map.size);
+	state->map.virt       = ioremap_nocache(memory->start, state->win_size);
 	if (!state->map.virt)
 		return -ENOMEM;
 
-- 
2.19.0

