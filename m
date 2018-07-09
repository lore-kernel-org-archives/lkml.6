Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4402AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015FF2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="MZmi7cIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015FF2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeGIPMZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:12:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37358 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933406AbeGIPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so11375154wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFHl/qb6kt+BdQRH7snwxI9/D15UmrVQxZQdfewdXGc=;
        b=MZmi7cIoiodab3iisrWELPT8EII5FUalU7OXEvUVrWwHRufAJiQOxak5xZ07jv77OZ
         b/ogxpuQr+m7HrRhBVeMvqnUgPThl+Kyl/U5muK+otbbW1gmujVvJtigkKp6oI8Xr8cl
         Ge5f3BsTCyTamyjxqA5X9+1yWkPmmRjPWoZkvspANyzrR68e1lHDw/nJZW4TGCkE/AhG
         /WRm0isdYrDqdCeYXNGT8OVNRGRKdewrA7UBrGPg2CBCU2bnKc1RAu55HKJ8+NKFDrce
         Zdh6j65akWZq/ly0luTF582U8qTy+vJF854psYz06tap1GQT/nM5fhhJIyD3Ng5sXw5O
         JIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oFHl/qb6kt+BdQRH7snwxI9/D15UmrVQxZQdfewdXGc=;
        b=eywOHrSRHrzZrMkzqGk1zBwmPDF41aKw73fbUPvrDwfaQGlLBx+iP6VlAoRih1w8ph
         b6ElBXKlRp6PqZZIUqPKBBui1mF7K3mRoqoJATv8TvY57gfrDvUgtGcbdH6idFLSfUSZ
         urL1OLdC2p3bxeU6ZWkO6tVWnOGt0+h74aQYnfJHey8ciUM5fC3rUd6VQZmQoXoT6bWW
         pejE//4vRgw8PGlliZU2onIBQKUz/b14BOrHKalCvod6j/52kemB6BLioCCd6J/7iWah
         sS9WwzylWH6ulA/fqNflsycc/y0cpHqVI02BSfsbcsWocOtf/pbFwMlgaftWSoZuYyEI
         ZxMA==
X-Gm-Message-State: AOUpUlE9GFn0EMW3rVVCZuaHbQq+XJxYvHaW4kKDpt7N/zj9xadxqQ8D
        WUz816+xDRKQSaLXFm4n533/YA==
X-Google-Smtp-Source: AAOMgpcts4dmipIvHXOCERh8A7yQYeoT0y+iOwzRkc9B2Z1V+2WT35nxe4NCCZtfpJbnWmIcl92Utw==
X-Received: by 2002:adf:80c9:: with SMTP id 67-v6mr6210531wrl.95.1531149038792;
        Mon, 09 Jul 2018 08:10:38 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:38 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 08/12] lib/rhashtable: simplify bucket_table_alloc()
Date:   Mon,  9 Jul 2018 17:10:15 +0200
Message-Id: <20180709151019.1336-9-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

As of commit ce91f6ee5b3b ("mm: kvmalloc does not fallback to vmalloc for
incompatible gfp flags") we can simplify the caller and trust kvzalloc() to
just do the right thing. For the case of the GFP_ATOMIC context, we can
drop the __GFP_NORETRY flag for obvious reasons, and for the __GFP_NOWARN
case, however, it is changed such that the caller passes the flag instead
of making bucket_table_alloc() handle it.

This slightly changes the gfp flags passed on to nested_table_alloc() as
it will now also use GFP_ATOMIC | __GFP_NOWARN. However, I consider this a
positive consequence as for the same reasons we want nowarn semantics in
bucket_table_alloc().

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>

(commit id extended to 12 digits, line wraps updated)
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 lib/rhashtable.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 9427b5766134..083f871491a1 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -175,10 +175,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	int i;
 
 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
-	if (gfp != GFP_KERNEL)
-		tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
-	else
-		tbl = kvzalloc(size, gfp);
+	tbl = kvzalloc(size, gfp);
 
 	size = nbuckets;
 
@@ -459,7 +456,7 @@ static int rhashtable_insert_rehash(struct rhashtable *ht,
 
 	err = -ENOMEM;
 
-	new_tbl = bucket_table_alloc(ht, size, GFP_ATOMIC);
+	new_tbl = bucket_table_alloc(ht, size, GFP_ATOMIC | __GFP_NOWARN);
 	if (new_tbl == NULL)
 		goto fail;
 
-- 
2.17.1

