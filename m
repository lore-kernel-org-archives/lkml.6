Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA26C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13E620892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrbWgS2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13E620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbeKJSfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:35:19 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34766 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbeKJSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:35:18 -0500
Received: by mail-oi1-f194.google.com with SMTP id i138-v6so3500230oib.1;
        Sat, 10 Nov 2018 00:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXmLqSl7vjU942tWhcIZCYX/+Qp74X6Yd3cKgefpOnw=;
        b=FrbWgS2QEE+TB9o6JyFuYT73qSCMRjA3WZExodEe8mdryPVTDMFyCZ/bLzKZJlu+wP
         2N3fIEy7a3IGEEHZ/YrqnGf4Ah0L54ni4twq5EmqNnXq3BXR8y8E/Uvfp1xpeO1I+hgh
         na3qwQV6++og6sCq+XADjyI96QGr4/KKazyXiseKySONc2drT3m1Eng3sz2Vi2q8VNis
         nfp2Mm8zU/oc5M8CaYSVnQY+gUC065vqh/jkdPA7fqxIma6BPvS+5UPreMFnwYkWEdM3
         /c/KUZg/h3OhSeIMPHf5kImpwNjM3DrAxKVEq/1Sq4y7rVAlgAgVvO0ArRwJjb13g3+S
         3yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXmLqSl7vjU942tWhcIZCYX/+Qp74X6Yd3cKgefpOnw=;
        b=LptdaKtSisXDZWkR+IXDfDagNm834HfmiNw93rRHdSvqWgI8QZwpJ/SPhr9hUZzEjC
         SMEukVPm5oQD84GdZQ3ohYo9nkPJzGvQqTBYzqT/PirbIT+V067MQbvF6g8vTI4CqYnr
         D3J/cv1wLCSMm4J8Amcoc10lxk1tHjHPwv0vCW7vUXE9nrfTHH2sSe/KW4Gq1kOAFy7E
         Hvt++ddh/02WRr/o59opPG4u4LdFkSAKdOTvj/wK4L90aY2LMT50LKVJaJhyJTk5EymV
         veuY7/JFVMQeKM5ElTqokgdWEArxN99PQHBSsH4lHWCV5u+lC1nIFlkWc0XLw8wfCfUZ
         aciA==
X-Gm-Message-State: AGRZ1gL5zV/jnGIGWBcFdhfA0laPp9xvnkEd+ZfWtZF7K9A3FfKJ49aG
        qYbx/Xnz65YDKo2ijC21UL8MdKCp
X-Google-Smtp-Source: AJdET5e/0eTaqwWi1VEStKksMo8NgdzCKNmf/6AwIBN86+mXORyVzdE3KtE6bgyC95KVmCRiDQIPYg==
X-Received: by 2002:aca:5784:: with SMTP id l126-v6mr6376247oib.329.1541839864979;
        Sat, 10 Nov 2018 00:51:04 -0800 (PST)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id c7-v6sm3908683oia.58.2018.11.10.00.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 00:51:04 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 6/6] mm: track gup pages with page->dma_pinned_* fields
Date:   Sat, 10 Nov 2018 00:50:41 -0800
Message-Id: <20181110085041.10071-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181110085041.10071-1-jhubbard@nvidia.com>
References: <20181110085041.10071-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

This patch sets and restores the new page->dma_pinned_flags and
page->dma_pinned_count fields, but does not actually use them for
anything yet.

In order to use these fields at all, the page must be removed from
any LRU list that it's on. The patch also adds some precautions that
prevent the page from getting moved back onto an LRU, once it is
in this state.

This is in preparation to fix some problems that came up when using
devices (NICs, GPUs, for example) that set up direct access to a chunk
of system (CPU) memory, so that they can DMA to/from that memory.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Christopher Lameter <cl@linux.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 19 +++++----------
 mm/gup.c           | 55 +++++++++++++++++++++++++++++++++++++++++--
 mm/memcontrol.c    |  8 +++++++
 mm/swap.c          | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 09fbb2c81aba..6c64b1e0b777 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -950,6 +950,10 @@ static inline void put_page(struct page *page)
 {
 	page = compound_head(page);
 
+	VM_BUG_ON_PAGE(PageDmaPinned(page) &&
+		       page_ref_count(page) <
+				atomic_read(&page->dma_pinned_count),
+		       page);
 	/*
 	 * For devmap managed pages we need to catch refcount transition from
 	 * 2 to 1, when refcount reach one it means the page is free and we
@@ -964,21 +968,10 @@ static inline void put_page(struct page *page)
 }
 
 /*
- * put_user_page() - release a page that had previously been acquired via
- * a call to one of the get_user_pages*() functions.
- *
  * Pages that were pinned via get_user_pages*() must be released via
- * either put_user_page(), or one of the put_user_pages*() routines
- * below. This is so that eventually, pages that are pinned via
- * get_user_pages*() can be separately tracked and uniquely handled. In
- * particular, interactions with RDMA and filesystems need special
- * handling.
+ * one of these put_user_pages*() routines:
  */
-static inline void put_user_page(struct page *page)
-{
-	put_page(page);
-}
-
+void put_user_page(struct page *page);
 void put_user_pages_dirty(struct page **pages, unsigned long npages);
 void put_user_pages_dirty_lock(struct page **pages, unsigned long npages);
 void put_user_pages(struct page **pages, unsigned long npages);
diff --git a/mm/gup.c b/mm/gup.c
index 55a41dee0340..ec1b26591532 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -25,6 +25,50 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
+static void pin_page_for_dma(struct page *page)
+{
+	int ret = 0;
+	struct zone *zone;
+
+	page = compound_head(page);
+	zone = page_zone(page);
+
+	spin_lock(zone_gup_lock(zone));
+
+	if (PageDmaPinned(page)) {
+		/* Page was not on an LRU list, because it was DMA-pinned. */
+		VM_BUG_ON_PAGE(PageLRU(page), page);
+
+		atomic_inc(&page->dma_pinned_count);
+		goto unlock_out;
+	}
+
+	/*
+	 * Note that page->dma_pinned_flags is unioned with page->lru.
+	 * The rules are: reading PageDmaPinned(page) is allowed even if
+	 * PageLRU(page) is true. That works because of pointer alignment:
+	 * the PageDmaPinned bit is less than the pointer alignment, so
+	 * either the page is on an LRU, or (maybe) the PageDmaPinned
+	 * bit is set.
+	 *
+	 * However, SetPageDmaPinned requires that the page is both locked,
+	 * and also, removed from the LRU.
+	 *
+	 * The other flag, PageDmaPinnedWasLru, is not used for
+	 * synchronization, and so is only read or written after we are
+	 * certain that the full page->dma_pinned_flags field is available.
+	 */
+	ret = isolate_lru_page(page);
+	if (ret == 0)
+		SetPageDmaPinnedWasLru(page);
+
+	atomic_set(&page->dma_pinned_count, 1);
+	SetPageDmaPinned(page);
+
+unlock_out:
+	spin_unlock(zone_gup_lock(zone));
+}
+
 static struct page *no_page_table(struct vm_area_struct *vma,
 		unsigned int flags)
 {
@@ -670,7 +714,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned int gup_flags, struct page **pages,
 		struct vm_area_struct **vmas, int *nonblocking)
 {
-	long ret = 0, i = 0;
+	long ret = 0, i = 0, j;
 	struct vm_area_struct *vma = NULL;
 	struct follow_page_context ctx = { NULL };
 
@@ -774,6 +818,10 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		nr_pages -= page_increm;
 	} while (nr_pages);
 out:
+	if (pages)
+		for (j = 0; j < i; j++)
+			pin_page_for_dma(pages[j]);
+
 	if (ctx.pgmap)
 		put_dev_pagemap(ctx.pgmap);
 	return i ? i : ret;
@@ -1852,7 +1900,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			struct page **pages)
 {
 	unsigned long addr, len, end;
-	int nr = 0, ret = 0;
+	int nr = 0, ret = 0, i;
 
 	start &= PAGE_MASK;
 	addr = start;
@@ -1873,6 +1921,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		ret = nr;
 	}
 
+	for (i = 0; i < nr; i++)
+		pin_page_for_dma(pages[i]);
+
 	if (nr < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
 		start += nr << PAGE_SHIFT;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6e1469b80cb7..fbe61d13036f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2335,6 +2335,12 @@ static void lock_page_lru(struct page *page, int *isolated)
 	if (PageLRU(page)) {
 		struct lruvec *lruvec;
 
+		/*
+		 * LRU and PageDmaPinned are mutually exclusive: they use the
+		 * same fields in struct page, but for different purposes.
+		 */
+		VM_BUG_ON_PAGE(PageDmaPinned(page), page);
+
 		lruvec = mem_cgroup_page_lruvec(page, zone->zone_pgdat);
 		ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_lru(page));
@@ -2352,6 +2358,8 @@ static void unlock_page_lru(struct page *page, int isolated)
 
 		lruvec = mem_cgroup_page_lruvec(page, zone->zone_pgdat);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
+		VM_BUG_ON_PAGE(PageDmaPinned(page), page);
+
 		SetPageLRU(page);
 		add_page_to_lru_list(page, lruvec, page_lru(page));
 	}
diff --git a/mm/swap.c b/mm/swap.c
index bb8c32595e5f..79f874ce78c3 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -151,6 +151,51 @@ static void __put_user_pages_dirty(struct page **pages,
 	}
 }
 
+/*
+ * put_user_page() - release a page that had previously been acquired via
+ * a call to one of the get_user_pages*() functions.
+ *
+ * Usage: Pages that were pinned via get_user_pages*() must be released via
+ * either put_user_page(), or one of the put_user_pages*() routines
+ * below. This is so that eventually, pages that are pinned via
+ * get_user_pages*() can be separately tracked and uniquely handled. In
+ * particular, interactions with RDMA and filesystems need special
+ * handling.
+ */
+void put_user_page(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+
+	page = compound_head(page);
+
+	if (atomic_dec_and_test(&page->dma_pinned_count)) {
+		spin_lock(zone_gup_lock(zone));
+		/* Re-check while holding the lock, because
+		 * pin_page_for_dma() or get_page() may have snuck in right
+		 * after the atomic_dec_and_test, and raised the count
+		 * above zero again. If so, just leave the flag set. And
+		 * because the atomic_dec_and_test above already got the
+		 * accounting correct, no other action is required.
+		 */
+		VM_BUG_ON_PAGE(PageLRU(page), page);
+		VM_BUG_ON_PAGE(!PageDmaPinned(page), page);
+
+		if (atomic_read(&page->dma_pinned_count) == 0) {
+			ClearPageDmaPinned(page);
+
+			if (PageDmaPinnedWasLru(page)) {
+				ClearPageDmaPinnedWasLru(page);
+				putback_lru_page(page);
+			}
+		}
+
+		spin_unlock(zone_gup_lock(zone));
+	}
+
+	put_page(page);
+}
+EXPORT_SYMBOL(put_user_page);
+
 /*
  * put_user_pages_dirty() - for each page in the @pages array, make
  * that page (or its head page, if a compound page) dirty, if it was
@@ -903,6 +948,12 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
 	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
+
+	/*
+	 * LRU and PageDmaPinned are mutually exclusive: they use the
+	 * same fields in struct page, but for different purposes.
+	 */
+	VM_BUG_ON_PAGE(PageDmaPinned(page_tail), page);
 	VM_BUG_ON(NR_CPUS != 1 &&
 		  !spin_is_locked(&lruvec_pgdat(lruvec)->lru_lock));
 
@@ -942,6 +993,13 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	/*
+	 * LRU and PageDmaPinned are mutually exclusive: they use the
+	 * same fields in struct page, but for different purposes.
+	 */
+	if (PageDmaPinned(page))
+		return;
+
 	SetPageLRU(page);
 	/*
 	 * Page becomes evictable in two ways:
-- 
2.19.1

