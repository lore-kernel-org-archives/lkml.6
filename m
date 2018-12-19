Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D834C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E395E217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDmYQL9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbeLSRiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:38:07 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39154 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbeLSRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:38:03 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so10451132itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kgDREch0uno6TnGn8VSgP/fbnyM+Daf0DWv6CA+Hm7o=;
        b=EDmYQL9hb4bDPQdcE93OZn3ioCoP52SxxzGFhz0zf5rH+Ox1gnqs8MluVRoJmSEdTh
         LqA2yOsLrmTl5fh4qGqZsGrmtNB6n7hKKXE6FOrjJTsDMZd6u5mHEz5L5lrpbI5Vbw3C
         LxSEWdQHUFV/QQLNWUYZoWCC9IbSy4pvLaSUl2fjHyEyWX+G9IntgwPmxsKXB+KO7KRD
         DK0BMk48t5EUbKJG+SkHp2mvjZqvR3/wETNBeh8AxjtrpXL+rPbHymphuU3XEggXK/vp
         Uta1GFKR2u5cwG6+tZ5DFmtiiH3WjrrJPqeoUTYad2daPOkmBZpSwVjspQBBk/Oy4FW7
         KmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kgDREch0uno6TnGn8VSgP/fbnyM+Daf0DWv6CA+Hm7o=;
        b=go8LSYbTlsJirDM7mfqgH6Jzq3v7Q1dy0v6r5gLyTc3jTyGrL5HFf9DTGt0PwFyFsG
         oSQRF5OVTmltc+NK54hEwCs+RTUY5bi8alIz9stA9Eg1kAHIGBwurpaq08+KEn9aRxbJ
         XFTtM+/UyWsinqPe1B80ZINpphWs39rpGMKHwPFpOd2YFMCfzAbC9zpKr7G8tNf+v4U4
         Tw6dcdd8fCxotME1OhiwWaLRfuvGxE1JczMlEHe4m+dcy6KV8T4rW0nkrAKsZALGjE7N
         zm37rDq4ymABaRQ/u0mYLsQgfG28Ov0bfQ+Ga8r0lVLQfETWvXKDjBjjYxm8NdEmQSJZ
         mRgg==
X-Gm-Message-State: AA+aEWZyt2SrEpcJIJg0rv2p3QyzE1/01OKRCD1aMFXV7L7B2A9J6zCh
        5e4dxBn2sv2xwgJBIJO3E1M=
X-Google-Smtp-Source: AFSGD/UQryS0JBeZSHy5Ve6NEwHMkAFotihqqp++wX/z/7Cpw+1p8Vn/QuZCOnyDhw7iwMUh4DCcGQ==
X-Received: by 2002:a24:8203:: with SMTP id t3mr7216765itd.151.1545241081846;
        Wed, 19 Dec 2018 09:38:01 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:bd3e])
        by smtp.gmail.com with ESMTPSA id a10sm3637728itc.3.2018.12.19.09.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 09:38:01 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: [PATCH 2/3] mm: separate memory allocation and actual work in alloc_vmap_area()
Date:   Wed, 19 Dec 2018 09:37:50 -0800
Message-Id: <20181219173751.28056-3-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219173751.28056-1-guro@fb.com>
References: <20181219173751.28056-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_vmap_area() is allocating memory for the vmap_area, and
performing the actual lookup of the vm area and vmap_area
initialization.

This prevents us from using a pre-allocated memory for the map_area
structure, which can be used in some cases to minimize the number
of required memory allocations.

Let's keep the memory allocation part in alloc_vmap_area() and
separate everything else into init_vmap_area().

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 mm/vmalloc.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7660e3ef4133..042175d7d95f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -395,16 +395,10 @@ static void purge_vmap_area_lazy(void);
 
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 
-/*
- * Allocate a region of KVA of the specified size and alignment, within the
- * vstart and vend.
- */
-static struct vmap_area *alloc_vmap_area(unsigned long size,
-				unsigned long align,
-				unsigned long vstart, unsigned long vend,
-				int node, gfp_t gfp_mask)
+static int init_vmap_area(struct vmap_area *va, unsigned long size,
+			  unsigned long align, unsigned long vstart,
+			  unsigned long vend, int node, gfp_t gfp_mask)
 {
-	struct vmap_area *va;
 	struct rb_node *n;
 	unsigned long addr;
 	int purged = 0;
@@ -416,11 +410,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 	might_sleep();
 
-	va = kmalloc_node(sizeof(struct vmap_area),
-			gfp_mask & GFP_RECLAIM_MASK, node);
-	if (unlikely(!va))
-		return ERR_PTR(-ENOMEM);
-
 	/*
 	 * Only scan the relevant parts containing pointers to other objects
 	 * to avoid false negatives.
@@ -512,7 +501,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	BUG_ON(va->va_start < vstart);
 	BUG_ON(va->va_end > vend);
 
-	return va;
+	return 0;
 
 overflow:
 	spin_unlock(&vmap_area_lock);
@@ -534,8 +523,35 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
 		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
 			size);
-	kfree(va);
-	return ERR_PTR(-EBUSY);
+
+	return -EBUSY;
+}
+
+/*
+ * Allocate a region of KVA of the specified size and alignment, within the
+ * vstart and vend.
+ */
+static struct vmap_area *alloc_vmap_area(unsigned long size,
+					 unsigned long align,
+					 unsigned long vstart,
+					 unsigned long vend,
+					 int node, gfp_t gfp_mask)
+{
+	struct vmap_area *va;
+	int ret;
+
+	va = kmalloc_node(sizeof(struct vmap_area),
+			gfp_mask & GFP_RECLAIM_MASK, node);
+	if (unlikely(!va))
+		return ERR_PTR(-ENOMEM);
+
+	ret = init_vmap_area(va, size, align, vstart, vend, node, gfp_mask);
+	if (ret) {
+		kfree(va);
+		return ERR_PTR(ret);
+	}
+
+	return va;
 }
 
 int register_vmap_purge_notifier(struct notifier_block *nb)
-- 
2.19.2

