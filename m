Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75784C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420C92084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8lIBzK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfBYUar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:30:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45608 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfBYUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:30:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id r14so5002336pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 12:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDU7hPspNg25hPl2OvBKS7YvtxIGkNRnjLg+s4xyhDM=;
        b=J8lIBzK4OGjvyRLjyJ+K5FObPBndm+0ToM32Stvzi+qPGf0dK7DMb6YKcWHEJk15VI
         jjWzfZB48rp8XU62MCONpYbeMnpSC+ukUGhNelx/qceEx/NAoeEFW1txjnVcRmrVu7iQ
         ZPJxLzSpuRkjRsmthUHap8hJWs4A+PNiDmZPa7noyHzHTbM2NRLV0ZAvOQyCXhAJfDW4
         7fwjC9R9Xn9G/wakNy2rfVXDMoyjf/TQAvQNSytbqFCE+f2e/uFJKS3Abzcwf8bIOb8V
         OJTDbZ9MNzunNpPuJ94ypgYbFj2Y0gQTfHPStBmF3IvVlNT374CDfU9284rKLf4F2Qpm
         N59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDU7hPspNg25hPl2OvBKS7YvtxIGkNRnjLg+s4xyhDM=;
        b=JWPTBZxNu3QshWBY1lzpiHkXo/bi6uKzuG59aO89vUXeN0zkHOh+kXPp9I0NJ+67T7
         AFyc45WhHr4/NK2DPnJ30pVxxUKfrLA1npAGUYnGSIVZzaCLd5Yi6EN3NhQwFyuKk6+v
         atDh1R/JDSWDStNvxHJ1qwXfa1Nk9S4tJxqYMtY3Fyg1/a2i0JNMd0BJFb52cjU8rU1R
         YscTptp52Vgus8LBG45qBLZsTkYZK/az/xKen5zHkoIAq3zpj9AIMCyfD2Ogs3isI+Zq
         Fe8teBrJl1ZqbInkKXm1crQORN1TKONhkyv9KjXZKMlexvUxRDexNW8wfOC0ypOguGaB
         iaaw==
X-Gm-Message-State: AHQUAuY0MWgm/EpkQnbHTj6a35IZ92Ggs/ougwQ7gzdARZnRhrh+wrsC
        p5O+fsNBlwmTwqRkHqgHJ8rQWlKRDno=
X-Google-Smtp-Source: AHgI3Ibqg5a8LKjDQQHis1IjRnXTK+LyQiMK038WjKg7XCtvXxwlfbV648hzZIlvDGKgU82xIQurdA==
X-Received: by 2002:a17:902:e090:: with SMTP id cb16mr21482907plb.32.1551126644333;
        Mon, 25 Feb 2019 12:30:44 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::2:d960])
        by smtp.gmail.com with ESMTPSA id s4sm6189885pfe.16.2019.02.25.12.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 12:30:43 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH 2/3] mm: separate memory allocation and actual work in alloc_vmap_area()
Date:   Mon, 25 Feb 2019 12:30:36 -0800
Message-Id: <20190225203037.1317-3-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225203037.1317-1-guro@fb.com>
References: <20190225203037.1317-1-guro@fb.com>
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
index 8f0179895fb5..f1f19d1105c4 100644
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
@@ -516,7 +505,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	BUG_ON(va->va_start < vstart);
 	BUG_ON(va->va_end > vend);
 
-	return va;
+	return 0;
 
 overflow:
 	spin_unlock(&vmap_area_lock);
@@ -538,8 +527,35 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
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
2.20.1

