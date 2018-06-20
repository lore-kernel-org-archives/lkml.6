Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120A6C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B001D20883
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKhHbpQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B001D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933828AbeFTWmF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:42:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46950 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933803AbeFTWmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:42:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id q1-v6so481501pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 15:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QDrgQcbxtpv9rkSNMuo6ul0hIWy399jGiJTcOQHJxbw=;
        b=rKhHbpQ7e0xS+1n0GX57b09+YI8KeexFjVgkDPz39MEiOekRebzHWY4bIc7bsJ4HGg
         Ydkl2ct+4Zn5HEpHKJqwdtZO7+GJWBGiarFw90EK5d+LqPzb55KIAW6zs/P+vF0TuKhK
         8X5WU7TvtEIPs1m71nAs/JQjw0ui9aCtKFcQMdvz39+hvazGuLdCppmJ1WW09sA7VYwg
         aO4cHyGKyhYH72iGX65FRxm+N7ydf5OzfExGEKYSF/ucYV+RIuQBNYKEPIWaGIAAW1kg
         RJPabBYEPTuzjXyN+gNrmDw1g4G69NEg0Tyyw1IAopZWHjSnuNHd6h1edNyAS6G3Qam1
         vDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QDrgQcbxtpv9rkSNMuo6ul0hIWy399jGiJTcOQHJxbw=;
        b=Pt82Ja0FaCVNVCL9zZzXGLchWdkL/h2rJC8zyhgvgeOew57KVBKX3woQNKpjf1PvcP
         S8mAken3RoTDRu0jT5sR2zi9bwDoV/eWb2GCwA0Bp9zo42g58tW5upNknRkXcHsh0t4U
         /7VvxDIp/JPVEHYpJ4fgd6CMjytdT5f7YsJCzP6vrnR9RGN34TeU8cyc+rIIQA0iSdwR
         dKZtoP4OXWim4mq0/R0On1+47RkwHh9YBeDxu2fkR8iiu/xG62ZFfprHbm9jVN99IspX
         mFauLpqCpEEKmLCSvYPBtHMnCJJFcMYoMU3+0vJl2sjE8EOWC8Wn487z9si3VibByRLB
         wrRA==
X-Gm-Message-State: APt69E1hc4/D7bhcpDnHOA41lct5iLY30YKcFtTdzbgPO03+LhvCJDoF
        A1I7TPfagwWEgGgbyU+Ael8ZNA==
X-Google-Smtp-Source: ADUXVKLPu97K2ysi2SB9aswDYephaon763wamJq/ljKctzb9sUO2n4ttg7bNNF9YYIU1NXX4lcQpQQ==
X-Received: by 2002:a62:4b16:: with SMTP id y22-v6mr24722884pfa.214.1529534522566;
        Wed, 20 Jun 2018 15:42:02 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id e16-v6sm4713236pfn.46.2018.06.20.15.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 15:42:01 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        stable@vger.kernel.org
Subject: [PATCH] slub: track number of slabs irrespective of CONFIG_SLUB_DEBUG
Date:   Wed, 20 Jun 2018 15:41:47 -0700
Message-Id: <20180620224147.23777-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For !CONFIG_SLUB_DEBUG, SLUB does not maintain the number of slabs
allocated per node for a kmem_cache. Thus, slabs_node() in
__kmem_cache_empty(), __kmem_cache_shrink() and __kmem_cache_destroy()
will always return 0 for such config. This is wrong and can cause issues
for all users of these functions.

Infact in [1] Jason has reported a system crash while using SLUB without
CONFIG_SLUB_DEBUG. The reason was the usage of slabs_node() by
__kmem_cache_empty().

The right solution is to make slabs_node() work even for
!CONFIG_SLUB_DEBUG. The commit 0f389ec63077 ("slub: No need for per node
slab counters if !SLUB_DEBUG") had put the per node slab counter under
CONFIG_SLUB_DEBUG because it was only read through sysfs API and the
sysfs API was disabled on !CONFIG_SLUB_DEBUG. However the users of the
per node slab counter assumed that it will work in the absence of
CONFIG_SLUB_DEBUG. So, make the counter work for !CONFIG_SLUB_DEBUG.

Please note that commit f9e13c0a5a33 ("slab, slub: skip unnecessary
kasan_cache_shutdown()") exposed this issue but it is present even
before.

[1] http://lkml.kernel.org/r/CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com

Fixes: f9e13c0a5a33 ("slab, slub: skip unnecessary kasan_cache_shutdown()")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Suggested-by: David Rientjes <rientjes@google.com>
Reported-by: Jason A . Donenfeld <Jason@zx2c4.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org>
Cc: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
---
 mm/slab.h |  2 +-
 mm/slub.c | 80 +++++++++++++++++++++++++------------------------------
 2 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 68bdf498da3b..a6545332cc86 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -473,8 +473,8 @@ struct kmem_cache_node {
 #ifdef CONFIG_SLUB
 	unsigned long nr_partial;
 	struct list_head partial;
-#ifdef CONFIG_SLUB_DEBUG
 	atomic_long_t nr_slabs;
+#ifdef CONFIG_SLUB_DEBUG
 	atomic_long_t total_objects;
 	struct list_head full;
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index a3b8467c14af..c9c190d54687 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1030,42 +1030,6 @@ static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct
 	list_del(&page->lru);
 }
 
-/* Tracking of the number of slabs for debugging purposes */
-static inline unsigned long slabs_node(struct kmem_cache *s, int node)
-{
-	struct kmem_cache_node *n = get_node(s, node);
-
-	return atomic_long_read(&n->nr_slabs);
-}
-
-static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
-{
-	return atomic_long_read(&n->nr_slabs);
-}
-
-static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
-{
-	struct kmem_cache_node *n = get_node(s, node);
-
-	/*
-	 * May be called early in order to allocate a slab for the
-	 * kmem_cache_node structure. Solve the chicken-egg
-	 * dilemma by deferring the increment of the count during
-	 * bootstrap (see early_kmem_cache_node_alloc).
-	 */
-	if (likely(n)) {
-		atomic_long_inc(&n->nr_slabs);
-		atomic_long_add(objects, &n->total_objects);
-	}
-}
-static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
-{
-	struct kmem_cache_node *n = get_node(s, node);
-
-	atomic_long_dec(&n->nr_slabs);
-	atomic_long_sub(objects, &n->total_objects);
-}
-
 /* Object debug checks for alloc/free paths */
 static void setup_object_debug(struct kmem_cache *s, struct page *page,
 								void *object)
@@ -1321,16 +1285,46 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 
 #define disable_higher_order_debug 0
 
+#endif /* CONFIG_SLUB_DEBUG */
+
 static inline unsigned long slabs_node(struct kmem_cache *s, int node)
-							{ return 0; }
+{
+	struct kmem_cache_node *n = get_node(s, node);
+
+	return atomic_long_read(&n->nr_slabs);
+}
+
 static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
-							{ return 0; }
-static inline void inc_slabs_node(struct kmem_cache *s, int node,
-							int objects) {}
-static inline void dec_slabs_node(struct kmem_cache *s, int node,
-							int objects) {}
+{
+	return atomic_long_read(&n->nr_slabs);
+}
 
-#endif /* CONFIG_SLUB_DEBUG */
+static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
+{
+	struct kmem_cache_node *n = get_node(s, node);
+
+	/*
+	 * May be called early in order to allocate a slab for the
+	 * kmem_cache_node structure. Solve the chicken-egg
+	 * dilemma by deferring the increment of the count during
+	 * bootstrap (see early_kmem_cache_node_alloc).
+	 */
+	if (likely(n)) {
+		atomic_long_inc(&n->nr_slabs);
+#ifdef CONFIG_SLUB_DEBUG
+		atomic_long_add(objects, &n->total_objects);
+#endif
+	}
+}
+static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
+{
+	struct kmem_cache_node *n = get_node(s, node);
+
+	atomic_long_dec(&n->nr_slabs);
+#ifdef CONFIG_SLUB_DEBUG
+	atomic_long_sub(objects, &n->total_objects);
+#endif
+}
 
 /*
  * Hooks for other subsystems that check memory allocations. In a typical
-- 
2.18.0.rc1.244.gcf134e6275-goog

