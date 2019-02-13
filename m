Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF62C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8942220836
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4gWTZtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389930AbfBMN7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:59:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53846 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbfBMN6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:58:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so2562437wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1MEkkxvqC9R885OkIU7HQfuqGvidJi6l2IAbLfaU7c=;
        b=p4gWTZtrw9t1J2YewM74IoZolPi7VQOnG/RK8ZQZiZ/MwIJe/QojBdLDC0S26B8FQG
         sJ4Fc7OS2U+qrzDTtBlUkcxXKRCWNf1c5K/bS7z16u9lokG1ooOi7P77c7/vamnDG7Df
         2d918grgBusikS9jEYCuEuUdFT/Necs62nCZY3mg2ogWOz/b528vJ27LAPrsdjujFfzC
         S36qTciiQccAXgi+hQRaoQrYY5G/+zZLgQq10wBRmjFy+iVN02dNNsOk8FgKCjX97iFc
         cA1T6HSt+VFQ0dTj0xVahAedsFj4iI5IeV6B7tiQWfAl9TJtccR3FaUza3yCVly+NVX7
         V90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1MEkkxvqC9R885OkIU7HQfuqGvidJi6l2IAbLfaU7c=;
        b=Yt9a62RUl9NlZhv39AOYfGvDaPX8LZ0GxTkRutVL+L/MZPeFtS9PL3331MtHetDxOh
         lFQPWhVOBg7NF2kfLBoJ7C5CbMacjtkH9cYJl0OmYyWBpZETprpa3rGTK1zs45Zcdygn
         YMjzszSsxP/r868i/sz2R3oHP7BWgpEir7vSGPmrZ4E7r6ZsKXKz9uCdgvQURx2REVvS
         OuExmXMzqQDcZYgryRnZp8FtaNJ8nJUPiBRddYNiRHHTmZmdsuTdGnHMPu9PeeogZNnv
         GRXxyURaLUOczWQfea8WoUns2OCSLlKSvb5K61fbYEPvGFNEkJ+K6n66/6tX2kpxXkGo
         HlSQ==
X-Gm-Message-State: AHQUAuZHYO/5tlvMJZzNBzYuqTZ3M9PD7O29Tadxh6vCuVwroRbiwGfC
        /1GE947bsndu2WvXroapTTd2uw==
X-Google-Smtp-Source: AHgI3IaTRjRBOpfqDQyCSkM0FCxrdwo/Gj5shg1xg359f+Atts3bPUEzKs/gM3ivkCgMfSuFGNws2w==
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr494171wmb.18.1550066321635;
        Wed, 13 Feb 2019 05:58:41 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id v9sm11195866wrt.82.2019.02.13.05.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:58:40 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 3/5] kmemleak: account for tagged pointers when calculating pointer range
Date:   Wed, 13 Feb 2019 14:58:28 +0100
Message-Id: <16e887d442986ab87fe87a755815ad92fa431a5f.1550066133.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <cover.1550066133.git.andreyknvl@google.com>
References: <cover.1550066133.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak keeps two global variables, min_addr and max_addr, which store
the range of valid (encountered by kmemleak) pointer values, which it
later uses to speed up pointer lookup when scanning blocks.

With tagged pointers this range will get bigger than it needs to be.
This patch makes kmemleak untag pointers before saving them to min_addr
and max_addr and when performing a lookup.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kmemleak.c    | 10 +++++++---
 mm/slab.h        |  1 +
 mm/slab_common.c |  1 +
 mm/slub.c        |  1 +
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index f9d9dc250428..707fa5579f66 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -574,6 +574,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	unsigned long flags;
 	struct kmemleak_object *object, *parent;
 	struct rb_node **link, *rb_parent;
+	unsigned long untagged_ptr;
 
 	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
 	if (!object) {
@@ -619,8 +620,9 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 
 	write_lock_irqsave(&kmemleak_lock, flags);
 
-	min_addr = min(min_addr, ptr);
-	max_addr = max(max_addr, ptr + size);
+	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
+	min_addr = min(min_addr, untagged_ptr);
+	max_addr = max(max_addr, untagged_ptr + size);
 	link = &object_tree_root.rb_node;
 	rb_parent = NULL;
 	while (*link) {
@@ -1333,6 +1335,7 @@ static void scan_block(void *_start, void *_end,
 	unsigned long *start = PTR_ALIGN(_start, BYTES_PER_POINTER);
 	unsigned long *end = _end - (BYTES_PER_POINTER - 1);
 	unsigned long flags;
+	unsigned long untagged_ptr;
 
 	read_lock_irqsave(&kmemleak_lock, flags);
 	for (ptr = start; ptr < end; ptr++) {
@@ -1347,7 +1350,8 @@ static void scan_block(void *_start, void *_end,
 		pointer = *ptr;
 		kasan_enable_current();
 
-		if (pointer < min_addr || pointer >= max_addr)
+		untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
+		if (untagged_ptr < min_addr || untagged_ptr >= max_addr)
 			continue;
 
 		/*
diff --git a/mm/slab.h b/mm/slab.h
index 638ea1b25d39..384105318779 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -438,6 +438,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 	flags &= gfp_allowed_mask;
 	for (i = 0; i < size; i++) {
 		p[i] = kasan_slab_alloc(s, p[i], flags);
+		/* As p[i] might get tagged, call kmemleak hook after KASAN. */
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);
 	}
diff --git a/mm/slab_common.c b/mm/slab_common.c
index fe524c8d0246..f9d89c1b5977 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1229,6 +1229,7 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	page = alloc_pages(flags, order);
 	ret = page ? page_address(page) : NULL;
 	ret = kasan_kmalloc_large(ret, size, flags);
+	/* As ret might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ret, size, 1, flags);
 	return ret;
 }
diff --git a/mm/slub.c b/mm/slub.c
index 4a3d7686902f..f5a451c49190 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1375,6 +1375,7 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
 static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
 {
 	ptr = kasan_kmalloc_large(ptr, size, flags);
+	/* As ptr might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ptr, size, 1, flags);
 	return ptr;
 }
-- 
2.20.1.791.gb4d0f1c61a-goog

