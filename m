Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70D3C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B3C218F9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="IFNJd+1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B3C218F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754342AbeFUSIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:08:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40694 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFUSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:08:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id n5-v6so7754081wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yZ1KaYr4sfx8XmylPrWjdKgJKJeTRgokO6NMECwmgKI=;
        b=IFNJd+1KarYurqC1sH9Lm/Rc3hSZcO0Is0WEYzdvZqpCLM/LoYIKIJ7xB2H19ydEOT
         yT7wJ2pEnpKhZp+UABaWBPderEoNZh0/kdAFnLiezFherpMNb8fLIHbMNu5YWTAgQTjf
         zedmCXtMFSj04ydbgyT50HZNL29TlO2cFSyDZBtIemh/rVFcoyPtlAHRzIDV37G+Rc6F
         SeX5nn2UyC6tFrxhgsNYOls1VJDYC+Rd2B14ozY3xzTQ8c/uhGnkYcuMs9M8rnBkcPlI
         ZOrQeAv2zkSPUq1WIKPRBFY/gARvflp92P7fm91K0mxROShYxgxtYTxcJJvXseYja8gV
         O2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yZ1KaYr4sfx8XmylPrWjdKgJKJeTRgokO6NMECwmgKI=;
        b=OREVFg9hIXGrUenDKINTvJa68OFZ8DmqOvMp9AxYbEF7OUU/jDUkNCO7bBJSUd4l19
         f+QrPOpXdJz5UMcVVkkbKRRjvbT/UMyvjPZpcQs8mm+XTL8wXwN+VrTsHkziIaRWgHjv
         KU/LGg2yVU9nR/eaFU10dbK8ShE2ytZuTvm0dfouw9A1gDueXeC91zqAImOKT/QYRaAh
         eI5cXwE3ceZNmpUTa8+qU1cP6Rlh7INATGHI6d6P6b4i6jCG7aOryQYmpULyTkuOu7rV
         iGzG785fJ6QgRX81ooO4C8fNQ+vIG7Z+s0+FpxpNQkr+2ou5CgPwCZVKF1bc15h5Vz7m
         +1tQ==
X-Gm-Message-State: APt69E0d8wo7z0DP0oH3Cmsd71PeUpb/R54AKC5Vrb5JVtW5b1cHwfVf
        5pu7eU3kkiUuOcPN0mdywBkzxgx/WW8=
X-Google-Smtp-Source: ADUXVKIynBQvK7jIFTJCTMZWh7RyIXaxhYZu7jEPbvoEnhLwE20uV25cPgR3yxWxh5Zu0uQ1bO92Lw==
X-Received: by 2002:a1c:454f:: with SMTP id s76-v6mr5827258wma.16.1529604506936;
        Thu, 21 Jun 2018 11:08:26 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 127-v6sm9165927wmk.45.2018.06.21.11.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 11:08:26 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [RFC 2/3] iommu/iova: Make free_iova() atomic
Date:   Thu, 21 Jun 2018 19:08:22 +0100
Message-Id: <20180621180823.805-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180621180823.805-1-dima@arista.com>
References: <20180621180823.805-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_iova() grabs rbtree's spinlock only for the search time.
Nothing guaranties that returned iova still exist for __free_iova().
Prevent potential use-after-free and double-free by holding the spinlock
all the time iova is being searched and freed.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/iova.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 4b38eb507670..4c63d92afaf7 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -382,11 +382,14 @@ EXPORT_SYMBOL_GPL(__free_iova);
 void
 free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
-	struct iova *iova = find_iova(iovad, pfn);
+	unsigned long flags;
+	struct iova *iova;
 
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = private_find_iova(iovad, pfn);
 	if (iova)
-		__free_iova(iovad, iova);
-
+		private_free_iova(iovad, iova);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 }
 EXPORT_SYMBOL_GPL(free_iova);
 
-- 
2.13.6

