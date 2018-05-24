Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527159701-2-2338093886419803206
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159700; b=GblmtELA+jgvSvfgypCgzW1143864jXXpGN4yDkvCiOfCYhZuD
    mvLqoL/EDhlkni7FverO9EBIN/3cwgfp0osZz84AnnBL8sfRXP71X2RStnNlvRnY
    JCeC8KXeSft7waf/4NYSnWWK3TXmRBlLOgl78qc62op5UUCEIQ+u8AaVKoi6DHS9
    bzxCA2iyRaKBI4HH4t79ClVD8y3+EYEo5pXelq0R5YR/PMx6MECh1trYO7GvDeUp
    L8EP0XuTwM4ScdCiioNtnzYLaetJ4E85jvptzLZ72h4B6L8op+o7e3li2+UbnfIx
    V9smCTmZCux3jcx4m0iiiw50RdZ/ppWEJkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527159700; bh=
    y3w8eScN4lxtyT3z7XHbhOnj+1vGU47bcYyMVyLFHLc=; b=F27OljhLPOMUfBUH
    C8JP8uj1RH7Ckj4U1AfH1Rz/YdLF21iFELxoryOH98Yhl5VdSdgWpZfCtqApfXQx
    k32g4Yt0ygFNaeNKywt9nGqIcjlJOAASAI86I0YlzHZkNGpeGrtx7KV6f1NHzfoU
    Im3EMtdZHk8RK0Qf2eew/A7L5KLxd6NLzkC2LFNERajvLvu9uMqZwSp/Vd83fbXx
    9BYGZzU7jnK4bjY+bbvqe3HYSMMSbmHo2y3sYxsZbQGp3Oz3VpYWTpe05PI9oKei
    G4QuWI8RL1oJJfVnBbcB5uyt3NmgIKEf/iEF2NlunGxYBbx+bhvnatwDSkmU+3ZA
    HlY87Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPhvfmxUmct6KEO8W3bwULHgt4LUslJYLYCHItlpmshtm0Yh3OeXa8kANWvIEOBPFmLxTKcy0DRlrWkx+6R7ExaIMfuXPv9c3+6GlSn3ue+1WkWyr8hM
    2eZhW/Hi+Ja+T0LaIbF2QOdKw6x9DBaWCghQ0/ZhpYlNjkEXaWKC5X+HPhDqlb8XHJ0IWW1r/FXHsPf1qQcu1u6nRWfyspPPwlqT/3mRqYwmDvVMbAQU9H26
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=7ZGo-G6aAMffxmB9R_UA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030246AbeEXLBi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:01:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:36151 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030230AbeEXLAY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 May 2018 07:00:24 -0400
From: Vlastimil Babka <vbabka@suse.cz>
To: linux-mm@kvack.org
Cc: Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC PATCH 1/5] mm, slab/slub: introduce kmalloc-reclaimable caches
Date: Thu, 24 May 2018 13:00:07 +0200
Message-Id: <20180524110011.1940-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524110011.1940-1-vbabka@suse.cz>
References: <20180524110011.1940-1-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kmem caches can be created with a SLAB_RECLAIM_ACCOUNT flag, which indicates
they contain objects which can be reclaimed under memory pressure (typically
through a shrinker). This makes the slab pages accounted as NR_SLAB_RECLAIMABLE
in vmstat, which is reflected also the MemAvailable meminfo counter and in
overcommit decisions. The slab pages are also allocated with __GFP_RECLAIMABLE,
which is good for anti-fragmentation through grouping pages by mobility.

The generic kmalloc-X caches are created without this flag, but sometimes are
used also for objects that can be reclaimed, which due to varying size cannot
have a dedicated kmem cache with SLAB_RECLAIM_ACCOUNT flag. A prominent example
are dcache external names, which prompted the creation of a new, manually
managed vmstat counter NR_INDIRECTLY_RECLAIMABLE_BYTES in commit f1782c9bc547
("dcache: account external names as indirectly reclaimable memory").

To better handle this and any other similar cases, this patch introduces
SLAB_RECLAIM_ACCOUNT variants of kmalloc caches, named kmalloc-reclaimable-X.
They are used whenever the kmalloc() call passes __GFP_RECLAIMABLE among gfp
flags. The kmalloc_caches[size_idx] array is extended to a two-dimensional
array kmalloc_caches[reclaimable][size_idx] to avoid an extra branch testing
for the flag.

This change only applies to SLAB and SLUB, not SLOB. This is fine, since SLOB's
target are tiny system and this patch does add some overhead of kmem management
objects.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 17 ++++++++++----
 mm/slab.c            |  4 ++--
 mm/slab_common.c     | 56 ++++++++++++++++++++++++++++++--------------
 mm/slub.c            | 12 +++++-----
 4 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9ebe659bd4a5..5bff0571b360 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -296,11 +296,16 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
                                (KMALLOC_MIN_SIZE) : 16)
 
 #ifndef CONFIG_SLOB
-extern struct kmem_cache *kmalloc_caches[KMALLOC_SHIFT_HIGH + 1];
+extern struct kmem_cache *kmalloc_caches[2][KMALLOC_SHIFT_HIGH + 1];
 #ifdef CONFIG_ZONE_DMA
 extern struct kmem_cache *kmalloc_dma_caches[KMALLOC_SHIFT_HIGH + 1];
 #endif
 
+static __always_inline unsigned int kmalloc_reclaimable(gfp_t flags)
+{
+	return !!(flags & __GFP_RECLAIMABLE);
+}
+
 /*
  * Figure out which kmalloc slab an allocation of a certain size
  * belongs to.
@@ -536,12 +541,13 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
 #ifndef CONFIG_SLOB
 		if (!(flags & GFP_DMA)) {
 			unsigned int index = kmalloc_index(size);
+			unsigned int recl = kmalloc_reclaimable(flags);
 
 			if (!index)
 				return ZERO_SIZE_PTR;
 
-			return kmem_cache_alloc_trace(kmalloc_caches[index],
-					flags, size);
+			return kmem_cache_alloc_trace(
+				kmalloc_caches[recl][index], flags, size);
 		}
 #endif
 	}
@@ -588,12 +594,13 @@ static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
 	if (__builtin_constant_p(size) &&
 		size <= KMALLOC_MAX_CACHE_SIZE && !(flags & GFP_DMA)) {
 		unsigned int i = kmalloc_index(size);
+		unsigned int recl = kmalloc_reclaimable(flags);
 
 		if (!i)
 			return ZERO_SIZE_PTR;
 
-		return kmem_cache_alloc_node_trace(kmalloc_caches[i],
-						flags, node, size);
+		return kmem_cache_alloc_node_trace(
+			kmalloc_caches[recl][i], flags, node, size);
 	}
 #endif
 	return __kmalloc_node(size, flags, node);
diff --git a/mm/slab.c b/mm/slab.c
index c1fe8099b3cd..8d7e1f06127b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1290,7 +1290,7 @@ void __init kmem_cache_init(void)
 	 * Initialize the caches that provide memory for the  kmem_cache_node
 	 * structures first.  Without this, further allocations will bug.
 	 */
-	kmalloc_caches[INDEX_NODE] = create_kmalloc_cache(
+	kmalloc_caches[0][INDEX_NODE] = create_kmalloc_cache(
 				kmalloc_info[INDEX_NODE].name,
 				kmalloc_size(INDEX_NODE), ARCH_KMALLOC_FLAGS,
 				0, kmalloc_size(INDEX_NODE));
@@ -1306,7 +1306,7 @@ void __init kmem_cache_init(void)
 		for_each_online_node(nid) {
 			init_list(kmem_cache, &init_kmem_cache_node[CACHE_CACHE + nid], nid);
 
-			init_list(kmalloc_caches[INDEX_NODE],
+			init_list(kmalloc_caches[0][INDEX_NODE],
 					  &init_kmem_cache_node[SIZE_NODE + nid], nid);
 		}
 	}
diff --git a/mm/slab_common.c b/mm/slab_common.c
index b0dd9db1eb2f..d9a66095de0d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -938,7 +938,11 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
 	return s;
 }
 
-struct kmem_cache *kmalloc_caches[KMALLOC_SHIFT_HIGH + 1] __ro_after_init;
+/*
+ * kmalloc_caches[0][] - kmalloc caches for non-reclaimable allocations
+ * kmalloc_caches[1][] - kmalloc caches for __GFP_RECLAIMABLE allocations
+ */
+struct kmem_cache *kmalloc_caches[2][KMALLOC_SHIFT_HIGH + 1] __ro_after_init;
 EXPORT_SYMBOL(kmalloc_caches);
 
 #ifdef CONFIG_ZONE_DMA
@@ -1010,7 +1014,7 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 		return kmalloc_dma_caches[index];
 
 #endif
-	return kmalloc_caches[index];
+	return kmalloc_caches[kmalloc_reclaimable(flags)][index];
 }
 
 /*
@@ -1082,9 +1086,21 @@ void __init setup_kmalloc_cache_index_table(void)
 	}
 }
 
-static void __init new_kmalloc_cache(int idx, slab_flags_t flags)
+static void __init
+new_kmalloc_cache(int idx, int reclaimable, slab_flags_t flags)
 {
-	kmalloc_caches[idx] = create_kmalloc_cache(kmalloc_info[idx].name,
+	const char * name;
+
+	if (reclaimable) {
+		flags |= SLAB_RECLAIM_ACCOUNT;
+		name = kasprintf(GFP_NOWAIT, "kmalloc-reclaimable-%u",
+						kmalloc_info[idx].size);
+		BUG_ON(!name);
+	} else {
+		name = kmalloc_info[idx].name;
+	}
+
+	kmalloc_caches[reclaimable][idx] = create_kmalloc_cache(name,
 					kmalloc_info[idx].size, flags, 0,
 					kmalloc_info[idx].size);
 }
@@ -1096,21 +1112,25 @@ static void __init new_kmalloc_cache(int idx, slab_flags_t flags)
  */
 void __init create_kmalloc_caches(slab_flags_t flags)
 {
-	int i;
+	int i, reclaimable;
 
-	for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
-		if (!kmalloc_caches[i])
-			new_kmalloc_cache(i, flags);
+	for (reclaimable = 0; reclaimable <= 1; reclaimable++) {
+		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
+			if (!kmalloc_caches[reclaimable][i])
+				new_kmalloc_cache(i, reclaimable, flags);
 
-		/*
-		 * Caches that are not of the two-to-the-power-of size.
-		 * These have to be created immediately after the
-		 * earlier power of two caches
-		 */
-		if (KMALLOC_MIN_SIZE <= 32 && !kmalloc_caches[1] && i == 6)
-			new_kmalloc_cache(1, flags);
-		if (KMALLOC_MIN_SIZE <= 64 && !kmalloc_caches[2] && i == 7)
-			new_kmalloc_cache(2, flags);
+			/*
+			 * Caches that are not of the two-to-the-power-of size.
+			 * These have to be created immediately after the
+			 * earlier power of two caches
+			 */
+			if (KMALLOC_MIN_SIZE <= 32 && i == 6 &&
+						!kmalloc_caches[reclaimable][1])
+				new_kmalloc_cache(1, reclaimable, flags);
+			if (KMALLOC_MIN_SIZE <= 64 && i == 7 &&
+						!kmalloc_caches[reclaimable][2])
+				new_kmalloc_cache(2, reclaimable, flags);
+		}
 	}
 
 	/* Kmalloc array is now usable */
@@ -1118,7 +1138,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 
 #ifdef CONFIG_ZONE_DMA
 	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
-		struct kmem_cache *s = kmalloc_caches[i];
+		struct kmem_cache *s = kmalloc_caches[0][i];
 
 		if (s) {
 			unsigned int size = kmalloc_size(i);
diff --git a/mm/slub.c b/mm/slub.c
index 48f75872c356..c7d7b83f20c2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4707,7 +4707,7 @@ static void __init resiliency_test(void)
 	pr_err("\n1. kmalloc-16: Clobber Redzone/next pointer 0x12->0x%p\n\n",
 	       p + 16);
 
-	validate_slab_cache(kmalloc_caches[4]);
+	validate_slab_cache(kmalloc_caches[0][4]);
 
 	/* Hmmm... The next two are dangerous */
 	p = kzalloc(32, GFP_KERNEL);
@@ -4716,33 +4716,33 @@ static void __init resiliency_test(void)
 	       p);
 	pr_err("If allocated object is overwritten then not detectable\n\n");
 
-	validate_slab_cache(kmalloc_caches[5]);
+	validate_slab_cache(kmalloc_caches[0][5]);
 	p = kzalloc(64, GFP_KERNEL);
 	p += 64 + (get_cycles() & 0xff) * sizeof(void *);
 	*p = 0x56;
 	pr_err("\n3. kmalloc-64: corrupting random byte 0x56->0x%p\n",
 	       p);
 	pr_err("If allocated object is overwritten then not detectable\n\n");
-	validate_slab_cache(kmalloc_caches[6]);
+	validate_slab_cache(kmalloc_caches[0][6]);
 
 	pr_err("\nB. Corruption after free\n");
 	p = kzalloc(128, GFP_KERNEL);
 	kfree(p);
 	*p = 0x78;
 	pr_err("1. kmalloc-128: Clobber first word 0x78->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[7]);
+	validate_slab_cache(kmalloc_caches[0][7]);
 
 	p = kzalloc(256, GFP_KERNEL);
 	kfree(p);
 	p[50] = 0x9a;
 	pr_err("\n2. kmalloc-256: Clobber 50th byte 0x9a->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[8]);
+	validate_slab_cache(kmalloc_caches[0][8]);
 
 	p = kzalloc(512, GFP_KERNEL);
 	kfree(p);
 	p[512] = 0xab;
 	pr_err("\n3. kmalloc-512: Clobber redzone 0xab->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[9]);
+	validate_slab_cache(kmalloc_caches[0][9]);
 }
 #else
 #ifdef CONFIG_SYSFS
-- 
2.17.0

