Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC20AC4151A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0629217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erR1C1OB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfBDFVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 00:21:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33839 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfBDFVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 00:21:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so6240229pfg.1;
        Sun, 03 Feb 2019 21:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LF/TzZ/WRLL9Myw0MVf2WrKu+LcDjoN1OU7zLg250Lg=;
        b=erR1C1OBWNS5qrI/OIyE9npEK5/OLRiSj/2mITtoKWiMMnjr4dv6lDAnZLW+LvLtFI
         tcuWJAu6mGElvmfkzk1vufOemxz4525RTF5QjlLPpUIhRn5xw9jh/g9lRn6zeZgSVNux
         Vozp1biA9Pblsd95kcDUtCXT7Y1A8+h6VPFL4kSTMrrnqvcyWjatcxeVqyxk03RkGk/Z
         bX/J1EB03ldEIAaKshALGrWbWq1PIoVg655KMaJ1u3MS9pRPlnfrtoBVpNAdju5CHc3u
         qLUL/zvq1s4iHAaWHQlk+kKINL+J2ww6BeN8yRHoeE7GO1wJ21kjDbXBCUkvlP0crtqr
         3k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LF/TzZ/WRLL9Myw0MVf2WrKu+LcDjoN1OU7zLg250Lg=;
        b=lq05zi00pn4og0gDt9TpgKa40g+ia4P2rehlQ0g82gf54iRHKiwwzcMqWR4Ls6pNAO
         n+dESKVN3GD4xj3n1nYhyW61XpeCm+/ZQGqW06mO8lElPJfIxicELRFOfY68noAGha92
         zL8yyT9i5pOLBhSRuAiPeo6lMRCdjlUJSgPK2N6TqCRUKV7Omxy1JVqcp9epPdZL/WXm
         CJcn14YpfSP1BTx/VdENi+RewoW2GKRLHqVXm8v/cjl74AYjB1EUT3jNPM2sXcDvsskP
         hr9sTVD+ndL/Umt9thFxyewUUZQBYoQzvdkU0pguUNnGeqetXoiUrBAyTCUsvIfwKPiD
         N6LA==
X-Gm-Message-State: AJcUuke2AldNX6OOlO9dISGTr789rJ7GiMVLZk2MJOYYuHgKp91231BT
        yIE9rmbU2GP16Knlc64WZho=
X-Google-Smtp-Source: ALg8bN44bcAqnBx8wjHxW4Gr5Rk6YMgK+256/BhJrSguem/qNtdvi8Np1H0GzEFHvbP68PIpkX0gxw==
X-Received: by 2002:a62:1112:: with SMTP id z18mr49225009pfi.173.1549257706197;
        Sun, 03 Feb 2019 21:21:46 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id m9sm33428844pgd.32.2019.02.03.21.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 21:21:45 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/6] mm/gup: track gup-pinned pages
Date:   Sun,  3 Feb 2019 21:21:33 -0800
Message-Id: <20190204052135.25784-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204052135.25784-1-jhubbard@nvidia.com>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Now that all callers of get_user_pages*() have been updated to use
put_user_page(), instead of put_page(), add tracking of such
"gup-pinned" pages. The purpose of this tracking is to answer the
question "has this page been pinned by a call to get_user_pages()?"

In order to answer that, refcounting is required. get_user_pages() and all
its variants increment a reference count, and put_user_page() and its
variants decrement that reference count. If the net count is *effectively*
non-zero (see below), then the page is considered gup-pinned.

What to do in response to encountering such a page, is left to later
patchsets. There is discussion about this in [1], and in an upcoming patch
that adds:

   Documentation/vm/get_user_pages.rst

So, this patch simply adds tracking of such pages.  In order to achieve
this without using up any more bits or fields in struct page, the
page->_refcount field is overloaded.  gup pins are incremented by adding a
large chunk (1024) instead of 1.  This provides a way to say, "either this
page is gup-pinned, or you have a *lot* of references on it, and thus this
is a false positive".  False positives are generally OK, as long as they
are expected to be rare: taking action for a page that looks gup-pinned,
but is not, is not going to be a problem.  It's false negatives (failing
to detect a gup-pinned page) that would be a problem, and those won't
happen with this approach.

This takes advantage of two distinct, pre-existing lock-free algorithms:

a) get_user_pages() and things such as page_mkclean(), both operate on
   page table entries, without taking locks. This relies partly on just
   letting the CPU hardware (which of course also never takes locks to
   use its own page tables) just take page faults if something has changed.

b) page_cache_get_speculative(), called by get_user_pages(), is a way to
   avoid having pages get freed out from under get_user_pages() or other
   things that want to pin pages.

As a result, performance is expected to be unchanged in any noticeable
way, by this patch.

In order to test this, a lot of get_user_pages() call sites have to be
converted over to use put_user_page(), but I did that locally, and here
is an fio run on an NVMe drive, using this for the fio configuration file:

    [reader]
    direct=1
    ioengine=libaio
    blocksize=4096
    size=1g
    numjobs=1
    rw=read
    iodepth=64

reader: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B,
        (T) 4096B-4096B, ioengine=libaio, iodepth=64
fio-3.3
Starting 1 process
Jobs: 1 (f=1)
reader: (groupid=0, jobs=1): err= 0: pid=7011: Sun Feb  3 20:36:51 2019
   read: IOPS=190k, BW=741MiB/s (778MB/s)(1024MiB/1381msec)
    slat (nsec): min=2716, max=57255, avg=4048.14, stdev=1084.10
    clat (usec): min=20, max=12485, avg=332.63, stdev=191.77
     lat (usec): min=22, max=12498, avg=336.72, stdev=192.07
    clat percentiles (usec):
     |  1.00th=[  322],  5.00th=[  322], 10.00th=[  322], 20.00th=[  326],
     | 30.00th=[  326], 40.00th=[  326], 50.00th=[  326], 60.00th=[  326],
     | 70.00th=[  326], 80.00th=[  330], 90.00th=[  330], 95.00th=[  330],
     | 99.00th=[  478], 99.50th=[  717], 99.90th=[ 1074], 99.95th=[ 1090],
     | 99.99th=[12256]
   bw (  KiB/s): min=730152, max=776512, per=99.22%, avg=753332.00,
                 stdev=32781.47, samples=2
   iops        : min=182538, max=194128, avg=188333.00, stdev=8195.37,
                 samples=2
  lat (usec)   : 50=0.01%, 100=0.01%, 250=0.07%, 500=99.26%, 750=0.38%
  lat (usec)   : 1000=0.02%
  lat (msec)   : 2=0.24%, 20=0.02%
  cpu          : usr=15.07%, sys=84.13%, ctx=10, majf=0, minf=74
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%,
                 >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
                 >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%,
                 >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=741MiB/s (778MB/s), 741MiB/s-741MiB/s (778MB/s-778MB/s),
     io=1024MiB (1074MB), run=1381-1381msec

Disk stats (read/write):
  nvme0n1: ios=216966/0, merge=0/0, ticks=6112/0, in_queue=704, util=91.34%

[1] https://lwn.net/Articles/753027/ "The trouble with get_user_pages()"

Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Jérôme Glisse <jglisse@redhat.com>

Cc: Christian Benvenuti <benve@cisco.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christopher Lameter <cl@linux.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Tom Talpey <tom@talpey.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h      | 81 +++++++++++++++++++++++++++++------------
 include/linux/pagemap.h |  5 +++
 mm/gup.c                | 60 ++++++++++++++++++++++--------
 mm/swap.c               | 21 +++++++++++
 4 files changed, 128 insertions(+), 39 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 809b7397d41e..dcb01cf0a9de 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -965,6 +965,63 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 }
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
+/*
+ * GUP_PIN_COUNTING_BIAS, and the associated functions that use it, overload
+ * the page's refcount so that two separate items are tracked: the original page
+ * reference count, and also a new count of how many get_user_pages() calls were
+ * made against the page. ("gup-pinned" is another term for the latter).
+ *
+ * With this scheme, get_user_pages() becomes special: such pages are marked
+ * as distinct from normal pages. As such, the new put_user_page() call (and
+ * its variants) must be used in order to release gup-pinned pages.
+ *
+ * Choice of value:
+ *
+ * By making GUP_PIN_COUNTING_BIAS a power of two, debugging of page reference
+ * counts with respect to get_user_pages() and put_user_page() becomes simpler,
+ * due to the fact that adding an even power of two to the page refcount has
+ * the effect of using only the upper N bits, for the code that counts up using
+ * the bias value. This means that the lower bits are left for the exclusive
+ * use of the original code that increments and decrements by one (or at least,
+ * by much smaller values than the bias value).
+ *
+ * Of course, once the lower bits overflow into the upper bits (and this is
+ * OK, because subtraction recovers the original values), then visual inspection
+ * no longer suffices to directly view the separate counts. However, for normal
+ * applications that don't have huge page reference counts, this won't be an
+ * issue.
+ *
+ * This has to work on 32-bit as well as 64-bit systems. In the more constrained
+ * 32-bit systems, the 10 bit value of the bias value leaves 22 bits for the
+ * upper bits. Therefore, only about 4M calls to get_user_page() may occur for
+ * a page.
+ *
+ * Locking: the lockless algorithm described in page_cache_gup_pin_speculative()
+ * and page_cache_gup_pin_speculative() provides safe operation for
+ * get_user_pages and page_mkclean and other calls that race to set up page
+ * table entries.
+ */
+#define GUP_PIN_COUNTING_BIAS (1UL << 10)
+
+int get_gup_pin_page(struct page *page);
+
+void put_user_page(struct page *page);
+void put_user_pages_dirty(struct page **pages, unsigned long npages);
+void put_user_pages_dirty_lock(struct page **pages, unsigned long npages);
+void put_user_pages(struct page **pages, unsigned long npages);
+
+/**
+ * page_gup_pinned() - report if a page is gup-pinned (pinned by a call to
+ *			get_user_pages).
+ * @page:	pointer to page to be queried.
+ * @Returns:	True, if it is likely that the page has been "gup-pinned".
+ *		False, if the page is definitely not gup-pinned.
+ */
+static inline bool page_gup_pinned(struct page *page)
+{
+	return (page_ref_count(page)) > GUP_PIN_COUNTING_BIAS;
+}
+
 static inline void get_page(struct page *page)
 {
 	page = compound_head(page);
@@ -993,30 +1050,6 @@ static inline void put_page(struct page *page)
 		__put_page(page);
 }
 
-/**
- * put_user_page() - release a gup-pinned page
- * @page:            pointer to page to be released
- *
- * Pages that were pinned via get_user_pages*() must be released via
- * either put_user_page(), or one of the put_user_pages*() routines
- * below. This is so that eventually, pages that are pinned via
- * get_user_pages*() can be separately tracked and uniquely handled. In
- * particular, interactions with RDMA and filesystems need special
- * handling.
- *
- * put_user_page() and put_page() are not interchangeable, despite this early
- * implementation that makes them look the same. put_user_page() calls must
- * be perfectly matched up with get_user_page() calls.
- */
-static inline void put_user_page(struct page *page)
-{
-	put_page(page);
-}
-
-void put_user_pages_dirty(struct page **pages, unsigned long npages);
-void put_user_pages_dirty_lock(struct page **pages, unsigned long npages);
-void put_user_pages(struct page **pages, unsigned long npages);
-
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define SECTION_IN_PAGE_FLAGS
 #endif
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5c8a9b59cbdc..5f5b72ba595f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -209,6 +209,11 @@ static inline int page_cache_add_speculative(struct page *page, int count)
 	return __page_cache_add_speculative(page, count);
 }
 
+static inline int page_cache_gup_pin_speculative(struct page *page)
+{
+	return __page_cache_add_speculative(page, GUP_PIN_COUNTING_BIAS);
+}
+
 #ifdef CONFIG_NUMA
 extern struct page *__page_cache_alloc(gfp_t gfp);
 #else
diff --git a/mm/gup.c b/mm/gup.c
index 05acd7e2eb22..3291da342f9c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -25,6 +25,26 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
+/**
+ * get_gup_pin_page() - mark a page as being used by get_user_pages().
+ * @page:	pointer to page to be marked
+ * @Returns:	0 for success, -EOVERFLOW if the page refcount would have
+ *		overflowed.
+ *
+ */
+int get_gup_pin_page(struct page *page)
+{
+	page = compound_head(page);
+
+	if (page_ref_count(page) >= (UINT_MAX - GUP_PIN_COUNTING_BIAS)) {
+		WARN_ONCE(1, "get_user_pages pin count overflowed");
+		return -EOVERFLOW;
+	}
+
+	page_ref_add(page, GUP_PIN_COUNTING_BIAS);
+	return 0;
+}
+
 static struct page *no_page_table(struct vm_area_struct *vma,
 		unsigned int flags)
 {
@@ -157,8 +177,14 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto retry;
 	}
 
-	if (flags & FOLL_GET)
-		get_page(page);
+	if (flags & FOLL_GET) {
+		int ret = get_gup_pin_page(page);
+
+		if (ret) {
+			page = ERR_PTR(ret);
+			goto out;
+		}
+	}
 	if (flags & FOLL_TOUCH) {
 		if ((flags & FOLL_WRITE) &&
 		    !pte_dirty(pte) && !PageDirty(page))
@@ -497,7 +523,10 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 		if (is_device_public_page(*page))
 			goto unmap;
 	}
-	get_page(*page);
+
+	ret = get_gup_pin_page(*page);
+	if (ret)
+		goto unmap;
 out:
 	ret = 0;
 unmap:
@@ -1429,11 +1458,11 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		page = pte_page(pte);
 		head = compound_head(page);
 
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_gup_pin_speculative(head))
 			goto pte_unmap;
 
 		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
-			put_page(head);
+			put_user_page(head);
 			goto pte_unmap;
 		}
 
@@ -1488,7 +1517,11 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 		}
 		SetPageReferenced(page);
 		pages[*nr] = page;
-		get_page(page);
+		if (get_gup_pin_page(page)) {
+			undo_dev_pagemap(nr, nr_start, pages);
+			return 0;
+		}
+
 		(*nr)++;
 		pfn++;
 	} while (addr += PAGE_SIZE, addr != end);
@@ -1569,15 +1602,14 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	} while (addr += PAGE_SIZE, addr != end);
 
 	head = compound_head(pmd_page(orig));
-	if (!page_cache_add_speculative(head, refs)) {
+	if (!page_cache_gup_pin_speculative(head)) {
 		*nr -= refs;
 		return 0;
 	}
 
 	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
 		*nr -= refs;
-		while (refs--)
-			put_page(head);
+		put_user_page(head);
 		return 0;
 	}
 
@@ -1607,15 +1639,14 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	} while (addr += PAGE_SIZE, addr != end);
 
 	head = compound_head(pud_page(orig));
-	if (!page_cache_add_speculative(head, refs)) {
+	if (!page_cache_gup_pin_speculative(head)) {
 		*nr -= refs;
 		return 0;
 	}
 
 	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
 		*nr -= refs;
-		while (refs--)
-			put_page(head);
+		put_user_page(head);
 		return 0;
 	}
 
@@ -1644,15 +1675,14 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	} while (addr += PAGE_SIZE, addr != end);
 
 	head = compound_head(pgd_page(orig));
-	if (!page_cache_add_speculative(head, refs)) {
+	if (!page_cache_gup_pin_speculative(head)) {
 		*nr -= refs;
 		return 0;
 	}
 
 	if (unlikely(pgd_val(orig) != pgd_val(*pgdp))) {
 		*nr -= refs;
-		while (refs--)
-			put_page(head);
+		put_user_page(head);
 		return 0;
 	}
 
diff --git a/mm/swap.c b/mm/swap.c
index 7c42ca45bb89..39b0ddd35933 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -133,6 +133,27 @@ void put_pages_list(struct list_head *pages)
 }
 EXPORT_SYMBOL(put_pages_list);
 
+/**
+ * put_user_page() - release a gup-pinned page
+ * @page:            pointer to page to be released
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
+	page = compound_head(page);
+
+	VM_BUG_ON_PAGE(page_ref_count(page) < GUP_PIN_COUNTING_BIAS, page);
+
+	page_ref_sub(page, GUP_PIN_COUNTING_BIAS);
+}
+EXPORT_SYMBOL(put_user_page);
+
 typedef int (*set_dirty_func)(struct page *page);
 
 static void __put_user_pages_dirty(struct page **pages,
-- 
2.20.1

