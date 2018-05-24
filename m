Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159757-2-17108341030543995470
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
    1527159756; b=Asn2aIuqFHwsBkgmZNJ3xMbc67zv0EXGQcDEfy7atJ+MNnTU/o
    1Za3hcsN1w/R4o+fezviA0lJdgdXTge2xlJ4wWL2kGqXo3+SfzUSbg517Y+/3380
    PmPAid8H2xLdx/zRthu7/92Oq/LSjpoexmCKsG+YenC+M53D+zMgYjDH12MhGf1m
    9UiOyCPbBDu4OUJxSgmfnc2YBdZwF78TayDiNselLzgiRSyg1fVm+ujAMzFJAgaL
    foJqJENCq6rosA8sXF2eLlMsDL7rPNnhSHYgrdHm+X4qDU6FemZv12zFDbVSGqk2
    UIrH+hB2rm4m8xjJDpG+7g9zK7GhJWxvXhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527159756; bh=
    AUrda3o+++WB+DYNP6BcPmfdrtUrPLTS7wmYqu06CXU=; b=MPkzsYtOa7WAMzK1
    6KMJrCcaDKRQP99qZRqelGUg+JrfitU07YSBy44K1JS4hH5lZWnxKfHfFCOnWKQt
    4/QLpZHJXX/Zh1UyV+gRBr8UOTkCDX4zK1nXwlyTa55zZQIgvRNYIKo1G/F/jYUG
    lhfDKHx4fzkt0IyTRiiJFdagc9oqBX8kY4KIqvHBu8GkQXauaD++AHTqIsnhXemX
    XKlLQvh+fTDiFzSH8+wrrRn6uJHFO0nlxx95yuLjtPcplnGVtzl/zwiXO3PiWJQM
    kZqWTbBw/SUsopajHcGI96iv1iaRcs9Lks6zYOvFwQvOuiT5v+neoVu/Xk7bysvo
    jbBrYw==
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
X-CM-Envelope: MS4wfGQc9GE7hVLtB4TyZFC9f2YqxwzEiRx/P8MwfsgX2r2QAUxLNdRCm/ItMAototeKpIad2Aj8F+0GRTT6VcqWrfvvK02mFxH9uTIlo8ZIgDZVHve/3Gnu
    +pR5tqI5SldKcEc/jaq7dJw2OsIpDqIrPKRxSL3eVg/hFeLJv3vSgmaePIBJsA63XaTl+xjjxcTS3Kfw5oWvMZMZNXiD4MqzBFQUVEg6swLQb8O1EZNm9UKL
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=t3s9vAEjhCXjWVLMcuIA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032811AbeEXLBf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:01:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:36171 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030247AbeEXLAZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 May 2018 07:00:25 -0400
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
Subject: [RFC PATCH 4/5] mm: rename and change semantics of nr_indirectly_reclaimable_bytes
Date: Thu, 24 May 2018 13:00:10 +0200
Message-Id: <20180524110011.1940-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524110011.1940-1-vbabka@suse.cz>
References: <20180524110011.1940-1-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The vmstat counter NR_INDIRECTLY_RECLAIMABLE_BYTES was introduced by commit
eb59254608bc ("mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES") with the goal of
accounting objects that can be reclaimed, but cannot be allocated via a
SLAB_RECLAIM_ACCOUNT cache. This is now possible via kmalloc() with
__GFP_RECLAIMABLE flag, and the dcache external names user is converted.

The counter is however still useful for accounting direct page allocations
(i.e. not slab) with a shrinker, such as the ION page pool. So keep it, and:

- change granularity to pages to be more like other counters; sub-page
  allocations should be able to use kmalloc
- rename the counter to NR_RECLAIMABLE
- expose the counter again in vmstat as "nr_reclaimable"; we can again remove
  the check for not printing "hidden" counters
- make the counter include also SLAB_RECLAIM_ACCOUNT, so it covers all
  shrinker-based (i.e. not page cache) reclaimable pages

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/staging/android/ion/ion_page_pool.c |  4 ++--
 include/linux/mmzone.h                      |  2 +-
 mm/page_alloc.c                             | 15 ++++-----------
 mm/slab.c                                   | 12 ++++++++----
 mm/util.c                                   | 16 +++++-----------
 mm/vmstat.c                                 |  6 +-----
 6 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 9bc56eb48d2a..11e6e694f425 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -33,8 +33,8 @@ static void ion_page_pool_add(struct ion_page_pool *pool, struct page *page)
 		pool->low_count++;
 	}
 
-	mod_node_page_state(page_pgdat(page), NR_INDIRECTLY_RECLAIMABLE_BYTES,
-			    (1 << (PAGE_SHIFT + pool->order)));
+	mod_node_page_state(page_pgdat(page), NR_RECLAIMABLE,
+							1 << pool->order);
 	mutex_unlock(&pool->mutex);
 }
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 32699b2dc52a..4343948f33e5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -180,7 +180,7 @@ enum node_stat_item {
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
 	NR_DIRTIED,		/* page dirtyings since bootup */
 	NR_WRITTEN,		/* page writings since bootup */
-	NR_INDIRECTLY_RECLAIMABLE_BYTES, /* measured in bytes */
+	NR_RECLAIMABLE,         /* all reclaimable pages, including slab */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 249546393bd6..6f22fec0df54 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4708,6 +4708,7 @@ long si_mem_available(void)
 	unsigned long pagecache;
 	unsigned long wmark_low = 0;
 	unsigned long pages[NR_LRU_LISTS];
+	unsigned long reclaimable;
 	struct zone *zone;
 	int lru;
 
@@ -4733,19 +4734,11 @@ long si_mem_available(void)
 	available += pagecache;
 
 	/*
-	 * Part of the reclaimable slab consists of items that are in use,
+	 * Part of the reclaimable pages consists of items that are in use,
 	 * and cannot be freed. Cap this estimate at the low watermark.
 	 */
-	available += global_node_page_state(NR_SLAB_RECLAIMABLE) -
-		     min(global_node_page_state(NR_SLAB_RECLAIMABLE) / 2,
-			 wmark_low);
-
-	/*
-	 * Part of the kernel memory, which can be released under memory
-	 * pressure.
-	 */
-	available += global_node_page_state(NR_INDIRECTLY_RECLAIMABLE_BYTES) >>
-		PAGE_SHIFT;
+	reclaimable = global_node_page_state(NR_RECLAIMABLE);
+	available += reclaimable - min(reclaimable / 2,  wmark_low);
 
 	if (available < 0)
 		available = 0;
diff --git a/mm/slab.c b/mm/slab.c
index 4dd7d73a1972..a2a8c0802253 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1420,10 +1420,12 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
 	}
 
 	nr_pages = (1 << cachep->gfporder);
-	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
+	if (cachep->flags & SLAB_RECLAIM_ACCOUNT) {
 		mod_lruvec_page_state(page, NR_SLAB_RECLAIMABLE, nr_pages);
-	else
+		mod_node_page_state(page_pgdat(page), NR_RECLAIMABLE, nr_pages);
+	} else {
 		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE, nr_pages);
+	}
 
 	__SetPageSlab(page);
 	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
@@ -1441,10 +1443,12 @@ static void kmem_freepages(struct kmem_cache *cachep, struct page *page)
 	int order = cachep->gfporder;
 	unsigned long nr_freed = (1 << order);
 
-	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
+	if (cachep->flags & SLAB_RECLAIM_ACCOUNT) {
 		mod_lruvec_page_state(page, NR_SLAB_RECLAIMABLE, -nr_freed);
-	else
+		mod_node_page_state(page_pgdat(page), NR_RECLAIMABLE, -nr_freed);
+	} else {
 		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE, -nr_freed);
+	}
 
 	BUG_ON(!PageSlab(page));
 	__ClearPageSlabPfmemalloc(page);
diff --git a/mm/util.c b/mm/util.c
index 98180a994895..3ffd92a9778a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -662,19 +662,13 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 		free += get_nr_swap_pages();
 
 		/*
-		 * Any slabs which are created with the
+		 * Pages accounted as reclaimable.
+		 * This includes any slabs which are created with the
 		 * SLAB_RECLAIM_ACCOUNT flag claim to have contents
-		 * which are reclaimable, under pressure.  The dentry
-		 * cache and most inode caches should fall into this
+		 * which are reclaimable, under pressure. The dentry
+		 * cache and most inode caches should fall into this.
 		 */
-		free += global_node_page_state(NR_SLAB_RECLAIMABLE);
-
-		/*
-		 * Part of the kernel memory, which can be released
-		 * under memory pressure.
-		 */
-		free += global_node_page_state(
-			NR_INDIRECTLY_RECLAIMABLE_BYTES) >> PAGE_SHIFT;
+		free += global_node_page_state(NR_RECLAIMABLE);
 
 		/*
 		 * Leave reserved pages. The pages are not for anonymous pages.
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 75eda9c2b260..21d571da9d5a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1161,7 +1161,7 @@ const char * const vmstat_text[] = {
 	"nr_vmscan_immediate_reclaim",
 	"nr_dirtied",
 	"nr_written",
-	"", /* nr_indirectly_reclaimable */
+	"nr_reclaimable",
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
@@ -1704,10 +1704,6 @@ static int vmstat_show(struct seq_file *m, void *arg)
 	unsigned long *l = arg;
 	unsigned long off = l - (unsigned long *)m->private;
 
-	/* Skip hidden vmstat items. */
-	if (*vmstat_text[off] == '\0')
-		return 0;
-
 	seq_puts(m, vmstat_text[off]);
 	seq_put_decimal_ull(m, " ", *l);
 	seq_putc(m, '\n');
-- 
2.17.0

