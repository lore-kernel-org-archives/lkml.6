Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893D2C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300DC2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="RiIGiFma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300DC2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933534AbeGIPMX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:12:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36509 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933422AbeGIPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so11380706wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5jQgELfyD7VNwzfhRyNUzqx6eCK+QCKeBT5JYYC3SAs=;
        b=RiIGiFmaPB9Gqa5d+selNYCZGgKEm5eWTXmEFuqM24zXGs+0VIYgnr0xk0oktMosWC
         QWCeOb369TDV0qtOvvrgD1DoSyq3S29WLfeIjF+NaPBcy4u5sMYG43zUSBBz5l6Kk8aa
         tB6PS9XjPzbSyNL/BIARChannH8UEzRGhff3U0EbID5Onn3oRqL2vFdtM0luWLA8Au3s
         goC5/YJq1X5ctS5qMKvYcan8ZnCjql34o7JeWMTWv6uGFB7Xc9KqTs1lh/12AWT/im0P
         ojDjbxAsjz5mlSFOHI4Ezz3qRyc+AU5p97iRUe2NPSdyp+cpB0n945OZt+6ULa/phorl
         pp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5jQgELfyD7VNwzfhRyNUzqx6eCK+QCKeBT5JYYC3SAs=;
        b=lcD4qiVMLB4L3bLwEV2Fia58t4LA4YtV/8M0r8knWvNyetM6RUhb9a2Tf5VTyDcvI4
         oLJmRQlCzNbRYlWdq+sKOCoyOm5MW4KgKoTPvuqzC1FGkRHZt2TNQGz5naq2fU+zXYH+
         ig8CNAJvTzQ4TIHTIxy+SpfprGoRgLEVzdbBZVzcIk+fCJTu+69MUlMTSnXKXa3aWFYa
         ofvMHhBQC3ynhwfL0ABbGQuZNkkXTbsZNWnm+FiNFEMGh0N63oaKP5JDCZmCcEq2jxo7
         26wic5tKO8GuGrfT8fOgsFRfx1J5uuI8vfWyHIFRoRQpgE/uZEMyzGcr80X+p8ntG7NH
         IIkA==
X-Gm-Message-State: AOUpUlF7Nw9lTJukw9JpWHi/UxvM3sHHmJwVCJ6+1TWjXgAmwEhlyqK8
        +DrJQF0L0Y2nBSjLX320bP+SUA==
X-Google-Smtp-Source: AAOMgpckqRhP87xn2PrjzMKxffcDefH6NSVhnCZHruxmvOVSd/1wpqMOjOc6C3+f/d7yBNXf5e9HcQ==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr6287610wrd.273.1531149039829;
        Mon, 09 Jul 2018 08:10:39 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:39 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 09/12] lib/rhashtable: guarantee initial hashtable allocation
Date:   Mon,  9 Jul 2018 17:10:16 +0200
Message-Id: <20180709151019.1336-10-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

rhashtable_init() may fail due to -ENOMEM, thus making the
entire api unusable. This patch removes this scenario,
however unlikely. In order to guarantee memory allocation,
this patch always ends up doing GFP_KERNEL|__GFP_NOFAIL
for both the tbl as well as alloc_bucket_spinlocks().

Upon the first table allocation failure, we shrink the
size to the smallest value that makes sense and retry with
__GFP_NOFAIL semantics. With the defaults, this means that
from 64 buckets, we retry with only 4. Any later issues
regarding performance due to collisions or larger table
resizing (when more memory becomes available) is the least
of our problems.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 lib/rhashtable.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 083f871491a1..0026cf3e3f27 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -179,10 +179,11 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 
 	size = nbuckets;
 
-	if (tbl == NULL && gfp != GFP_KERNEL) {
+	if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
 		tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);
 		nbuckets = 0;
 	}
+
 	if (tbl == NULL)
 		return NULL;
 
@@ -1065,9 +1066,16 @@ int rhashtable_init(struct rhashtable *ht,
 		}
 	}
 
+	/*
+	 * This is api initialization and thus we need to guarantee the
+	 * initial rhashtable allocation. Upon failure, retry with the
+	 * smallest possible size with __GFP_NOFAIL semantics.
+	 */
 	tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
-	if (tbl == NULL)
-		return -ENOMEM;
+	if (unlikely(tbl == NULL)) {
+		size = max_t(u16, ht->p.min_size, HASH_MIN_SIZE);
+		tbl = bucket_table_alloc(ht, size, GFP_KERNEL | __GFP_NOFAIL);
+	}
 
 	atomic_set(&ht->nelems, 0);
 
-- 
2.17.1

