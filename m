Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A48C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C985E206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eotUQ9nz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C985E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeJLNb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:31:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37783 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeJLNb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:31:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id u6-v6so2639013plz.4;
        Thu, 11 Oct 2018 23:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mio5E6AAn04E3CDvnsyyYWFtQZ3oBTMH05RInvMTmy0=;
        b=eotUQ9nzqS0sMUiu6wBL+tki9VFzeqzk95apOmNU3+kIsHo6a7siMkrCvROcBc0Y8b
         xhSW9g+b/WF7JXoJJaAHHfCdoXhx1EJ/shZiI1T1CWVIMMDUq2IFqNzOeRXviCMdN64x
         +lga058QRlO1LAYg6/s72G++FsUrhdWv0K/JE9WXcXLUAByC08aVY0AWbC9Xcvj9LLwV
         WHCs9Gma7AekiHafVDx1iCe98UpOwYB5dhGBZLXVAK78swGKXuncOTvscBPYZaIlCbK8
         Og9VMrWGhgRU41vqj3npVCb/WVfVtI3+NO0j61uQ/yZHuxHhWIMdvG7toGfn4xcwme57
         l/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mio5E6AAn04E3CDvnsyyYWFtQZ3oBTMH05RInvMTmy0=;
        b=ThByAWJ11PpaY9pOQ5mSLSmoAPKs2/Hr1f9uix4+xY/Ocdlu/o1DH+YJJqEj/xlDs7
         6x88Kb9s5rZomMFLMGPatnyjuOrrhhFnIFA7/pIdYZZKGuLKOKJsFBRegfHq/OmAs9Mc
         xEWS+b6C53pUm9I2l3EtqzuRjV++EO4UM3Ndqp+YPmcSxzPaQfdStOHiqVp7rRJA5oQr
         0TS421xFcjC/TjI7FoczPORHuuUiAervg3poLyHHJ0/9urxEenyPi6VvC8ETwL+vrhY9
         IKE5ZjNgI6iIRaWQE+8ryBcI7L2QLrERcK3MyDUNwaa16MfQU2wLjeEVvUicr5Bf+kzM
         RrCQ==
X-Gm-Message-State: ABuFfojAhlr57mPLkFi0UGASQE2Kl9UVe08GCQaqeigZoZrTvn6jVK2w
        hcVmlFyLYY4fs0364VSk+NI=
X-Google-Smtp-Source: ACcGV60B5C1zuvcSQDMS8Kd0c6ruRKBh+9H1nGnxn4M2HJSPu8qSOBanps0eNvNz8WMxtcjIG8uczw==
X-Received: by 2002:a17:902:8690:: with SMTP id g16-v6mr4377140plo.302.1539324037336;
        Thu, 11 Oct 2018 23:00:37 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z3-v6sm368579pfm.150.2018.10.11.23.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 23:00:36 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 6/6] mm: track gup pages with page->dma_pinned_* fields
Date:   Thu, 11 Oct 2018 23:00:14 -0700
Message-Id: <20181012060014.10242-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012060014.10242-1-jhubbard@nvidia.com>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
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

CC: Matthew Wilcox <willy@infradead.org>
CC: Jan Kara <jack@suse.cz>
CC: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 15 ++-----------
 mm/gup.c           | 56 ++++++++++++++++++++++++++++++++++++++++++++--
 mm/memcontrol.c    |  7 ++++++
 mm/swap.c          | 51 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 76d18aada9f8..44878d21e27b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -944,21 +944,10 @@ static inline void put_page(struct page *page)
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
index 05ee7c18e59a..fddbc30cde89 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -20,6 +20,51 @@
 
 #include "internal.h"
 
+static int pin_page_for_dma(struct page *page)
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
+	 * Therefore, the rules are: checking if any of the
+	 * PAGE_DMA_PINNED_FLAGS bits are set may be done while page->lru
+	 * is in use. However, setting those flags requires that
+	 * the page is both locked, and also, removed from the LRU.
+	 */
+	ret = isolate_lru_page(page);
+
+	if (ret == 0) {
+		/* Avoid problems later, when freeing the page: */
+		ClearPageActive(page);
+		ClearPageUnevictable(page);
+
+		/* counteract isolate_lru_page's effects: */
+		put_page(page);
+
+		atomic_set(&page->dma_pinned_count, 1);
+		SetPageDmaPinned(page);
+	}
+
+unlock_out:
+	spin_unlock(zone_gup_lock(zone));
+
+	return ret;
+}
+
 static struct page *no_page_table(struct vm_area_struct *vma,
 		unsigned int flags)
 {
@@ -659,7 +704,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned int gup_flags, struct page **pages,
 		struct vm_area_struct **vmas, int *nonblocking)
 {
-	long i = 0;
+	long i = 0, j;
 	int err = 0;
 	unsigned int page_mask;
 	struct vm_area_struct *vma = NULL;
@@ -764,6 +809,10 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	} while (nr_pages);
 
 out:
+	if (pages)
+		for (j = 0; j < i; j++)
+			pin_page_for_dma(pages[j]);
+
 	return i ? i : err;
 }
 
@@ -1841,7 +1890,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			struct page **pages)
 {
 	unsigned long addr, len, end;
-	int nr = 0, ret = 0;
+	int nr = 0, ret = 0, i;
 
 	start &= PAGE_MASK;
 	addr = start;
@@ -1862,6 +1911,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		ret = nr;
 	}
 
+	for (i = 0; i < nr; i++)
+		pin_page_for_dma(pages[i]);
+
 	if (nr < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
 		start += nr << PAGE_SHIFT;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e79cb59552d9..af9719756081 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2335,6 +2335,11 @@ static void lock_page_lru(struct page *page, int *isolated)
 	if (PageLRU(page)) {
 		struct lruvec *lruvec;
 
+		/* LRU and PageDmaPinned are mutually exclusive: they use the
+		 * same fields in struct page, but for different purposes.
+		 */
+		VM_BUG_ON_PAGE(PageDmaPinned(page), page);
+
 		lruvec = mem_cgroup_page_lruvec(page, zone->zone_pgdat);
 		ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_lru(page));
@@ -2352,6 +2357,8 @@ static void unlock_page_lru(struct page *page, int isolated)
 
 		lruvec = mem_cgroup_page_lruvec(page, zone->zone_pgdat);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
+		VM_BUG_ON_PAGE(PageDmaPinned(page), page);
+
 		SetPageLRU(page);
 		add_page_to_lru_list(page, lruvec, page_lru(page));
 	}
diff --git a/mm/swap.c b/mm/swap.c
index efab3a6b6f91..6b2b1a958a67 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -134,6 +134,46 @@ void put_pages_list(struct list_head *pages)
 }
 EXPORT_SYMBOL(put_pages_list);
 
+/*
+ * put_user_page() - release a page that had previously been acquired via
+ * a call to one of the get_user_pages*() functions.
+ *
+ * Pages that were pinned via get_user_pages*() must be released via
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
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+	VM_BUG_ON_PAGE(!PageDmaPinned(page), page);
+
+	if (atomic_dec_and_test(&page->dma_pinned_count)) {
+		spin_lock(zone_gup_lock(zone));
+
+		/* Re-check while holding the lock, because
+		 * pin_page_for_dma() or get_page() may have snuck in right
+		 * after the atomic_dec_and_test, and raised the count
+		 * above zero again. If so, just leave the flag set. And
+		 * because the atomic_dec_and_test above already got the
+		 * accounting correct, no other action is required.
+		 */
+		if (atomic_read(&page->dma_pinned_count) == 0)
+			ClearPageDmaPinned(page);
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
@@ -907,6 +947,11 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
 	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
+
+	/* LRU and PageDmaPinned are mutually exclusive: they use the
+	 * same fields in struct page, but for different purposes.
+	 */
+	VM_BUG_ON_PAGE(PageDmaPinned(page_tail), page);
 	VM_BUG_ON(NR_CPUS != 1 &&
 		  !spin_is_locked(&lruvec_pgdat(lruvec)->lru_lock));
 
@@ -946,6 +991,12 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	/* LRU and PageDmaPinned are mutually exclusive: they use the
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

