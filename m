Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B730EC30E6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1402124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="t8QY0eld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1402124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbeGLTEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:04:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42785 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeGLTEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:04:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so3163612wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFHl/qb6kt+BdQRH7snwxI9/D15UmrVQxZQdfewdXGc=;
        b=t8QY0eld8yNUuANaSptk8e3g/o3f3BIBxDklLRi/kOHzmux3CIjCkgr3lEnHDSqr6C
         jju+2nEVWAp5TGvJyJiWxecRK5Pz9DXiJ3VAxtuhLztwGdoWusFQ8m2ALGIwwBk5b8P7
         4c5RKiBSo6To4Kto9h40RdHPZZ96t2Xf4E6bx+rL0Fv8bFr6vFvBjKs4yvH4mC8c+8r1
         rX/Vsi6/Yrl0mBU94dHmbxUee6AY7rG85aof7jlXAGVsZzdrGxsn2/Mcrjx/1UuxDQTy
         /OMTVRlf9fSUiYgsP8hvNI8XwD0eWDFMAXquhb0uF4UarDu1s4IlVMvBjZxc+OtQJsym
         Z7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oFHl/qb6kt+BdQRH7snwxI9/D15UmrVQxZQdfewdXGc=;
        b=lwyiZURqxWKl6sZDM31ibhR/TkGKix6PTtIAAUB6zEpOeZdVQoS1xYNRzsYHNcPaVS
         1Oh+7m/E/Kv9LLoejkpU3HI5SNlSpHShAT3DX8ppvc1QrJgp/F5vFZMt+WK5XaCeNS5R
         fdpRpiydJefJtQPir+o9dqZflfaBbLI5AdTfJsRePb2gFpdR2BT4F6hZSXSs9nUMpzER
         fQ19+fLxG6k5g42OnllslkTfPQP/ATIKM9el5/UO7HCg6C5DD8PrW4ACvXVCxwk4E2Lf
         j2qwc3TG6Z5zMgRWk5xilfDyJiIx7b4sp1fIjEiWd7BivCpDeLLk6MAcXHr459q+xD1v
         O3Dg==
X-Gm-Message-State: AOUpUlGxsy2c4DSwYSs0NzoYE43KPxBbtdoQAu9I/R6TRn88cEls0oy3
        WVq7TdJLX3woSoNIojLPi98O9g==
X-Google-Smtp-Source: AAOMgpfFKzZ7zey7ZGW1D24TXHgSq9JGl9WNPHuYmjpqC7TQSFINZgNIh2sJ4rrGXQxn9hMFVXLF/A==
X-Received: by 2002:adf:9086:: with SMTP id i6-v6mr89210wri.271.1531421593019;
        Thu, 12 Jul 2018 11:53:13 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:12 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 07/12] lib/rhashtable: simplify bucket_table_alloc()
Date:   Thu, 12 Jul 2018 20:52:36 +0200
Message-Id: <20180712185241.4017-8-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
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

