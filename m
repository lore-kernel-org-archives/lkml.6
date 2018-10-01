Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3569C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9928820684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXw1cxYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9928820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeJATVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:21:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37584 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbeJATVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:21:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id c22-v6so452122edc.4;
        Mon, 01 Oct 2018 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjA+sX8gLHXduyIAmFIqULLnywYjal55pxx0KrC3qkQ=;
        b=lXw1cxYYCtUrLg0YYrga2UDS1ZivVZ/ng+77GzCFIoU5hC75yEN2m3ejM3ke1IFZ75
         sNefg+NCULYlSiAUREggvFCnlKtanACvz6+NOKL/n6m5I8LmvQANWmxMFVny8fMUPdVr
         bIpkkBklIXxhiZ5XAZEF9wgdo71tJUSGQ3NHY+OfVpdBhF+AB6brGrKLT9mZRRHgn8EW
         Kb6h0NxjqooTcddC4+MPpytB7brfpnhjGWXzuTFO4H/4lXquXjuoOcYRsg55Pw2Zwv9r
         qvfTe/Xmw77Ytoe7wYJkpy2NCsfqhumQxIA6J5D5VdpZMbqunoa6nuRZOjTqpw1Fug5B
         7bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjA+sX8gLHXduyIAmFIqULLnywYjal55pxx0KrC3qkQ=;
        b=seFLmRau6turTXduPAwswe+7syhxoC1oDy1nz965RlsxH0QWImfYlZgXJH2GZ0vWQJ
         v18Swzn/9ZRR7wlFto3j9x4hnEOSmjiD2A4ljOGbnXqJUk/SO0LS93TXwPuxOXxnfedZ
         aFV1KtOmQmUnKXNZPBf+Lu5V0l0h1a2ImCi+Ss1Q12KXonbvm+rn9EgdjXnWnxFf2TXX
         r7UsQEn4wHsIo1uDpJ2eWW/SWR4LoaAxfX+iM8TX4CdlrBi8A+BhnK5l/uR2Qn1S5iyq
         6QUNiJ8BfLwzTgNXIpVoHUiI5hR94n450X3vjFpDQfMeQpNu/QDFLwjUs/2u2oe2xvx2
         nzeA==
X-Gm-Message-State: ABuFfoh1lyPdOfFvpuwD8EZToSMLbpGj6cpQmTqYP0vz5g3nVeuKJk0a
        CzS59GxXkefqTy5syN7FwLc=
X-Google-Smtp-Source: ACcGV60K3+7tzrHphfAUGoa3F57ZVBFbm8448yA8/lMfT6Chd5qqw6XdflxgV7mT9uMJY9PshKCO8w==
X-Received: by 2002:a50:a9a1:: with SMTP id n30-v6mr2853373edc.158.1538397836541;
        Mon, 01 Oct 2018 05:43:56 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h3-v6sm5278700ede.42.2018.10.01.05.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:43:55 -0700 (PDT)
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
Subject: [PATCH v4 2/8] mtd: maps: gpio-addr-flash: Fix ioremapped size
Date:   Mon,  1 Oct 2018 14:43:45 +0200
Message-Id: <20181001124351.31615-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
References: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
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

