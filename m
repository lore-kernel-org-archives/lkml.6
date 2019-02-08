Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E944DC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D1D21919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOeYqfUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfBHH5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:57:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34878 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfBHH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:56:56 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so1315190pfi.2;
        Thu, 07 Feb 2019 23:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=33aqc7VxCmQrf2zs2FpPkA7KtnfR/GRdMJWgpUgJpEM=;
        b=oOeYqfUtXBNrVgo+VeodEVVR034PVDJLhgzdbme81C0PIxX2ttKG4gV4sD+b5UGM6n
         xpO2VvX1Wq6ajdWaoT2zI7Sw2gCqnmz1FeklNnKA1Lnqko7hzAwP99nbtTJax/xZpbMx
         K6kNidvmaJuQ1QVoKxxOPw2EBhE8Pz/cuYxoN5xYyebzyDJZRAx6eZ2uoZN8MasOZWrh
         0b734phPIp3ld30v/CXZnD8ZXHmtmgTRmTq+aRRt+cV1BBn34gN+7jX+pqEGPQzuVhUr
         uazvaGrsI5gxRaaW8hnzecpNaEWJ/JctpA9szJ+xEeyX9mrdfJyddmqisjabYbTjlSKn
         m3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=33aqc7VxCmQrf2zs2FpPkA7KtnfR/GRdMJWgpUgJpEM=;
        b=W75eSR75flAHDuvM00JedhdBRxupAiytNKMmmeeHhWe2pLaq0uRt2kdwnDayxlyNSy
         e9o/w+EoX8X5XjWcyGSEuJAwJRgEFl4fiRWEVrfULylKmX2Pf1NxqbPIx5P7gb0NIVNP
         6G4VV9vXR77t9OnO313A81asYHa1zCttMrQtr9jss05a8ZYUn+1oh2gBB+S7c2BD0FdW
         dxyERny7r1GvjR41Lyckx4EhpjJvl4yM0WYyBhh2akHTQHOdSOjfsBsHPXK2Pwn2FZ6q
         OEZlc/3yYIP2Z8WUhj79z+9BQgx4h0kYR0GXUw7NjhDFGusYzt4GOq7gTeJBXqF1ZS8O
         cXWg==
X-Gm-Message-State: AHQUAua/gEGkKVpkxSbg+JW+9jOiM48U7s4rlXc+0doDq5QXD4JITPze
        J3zkVkKXE3/t0fSbhBu31KiyrAmQ
X-Google-Smtp-Source: AHgI3IYo9MNT56RXdhRr+J3mZ3gjZXndch8d3O7H0eXplSlfFA8QPMUsfVhX1gtcwwJ3Gse7G9c1+g==
X-Received: by 2002:a63:c56:: with SMTP id 22mr4014447pgm.44.1549612614688;
        Thu, 07 Feb 2019 23:56:54 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id h64sm2642610pfc.142.2019.02.07.23.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 23:56:53 -0800 (PST)
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
Subject: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Date:   Thu,  7 Feb 2019 23:56:48 -0800
Message-Id: <20190208075649.3025-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208075649.3025-1-jhubbard@nvidia.com>
References: <20190208075649.3025-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Introduces put_user_page(), which simply calls put_page().
This provides a way to update all get_user_pages*() callers,
so that they call put_user_page(), instead of put_page().

Also introduces put_user_pages(), and a few dirty/locked variations,
as a replacement for release_pages(), and also as a replacement
for open-coded loops that release multiple pages.
These may be used for subsequent performance improvements,
via batching of pages to be released.

This is the first step of fixing a problem (also described in [1] and
[2]) with interactions between get_user_pages ("gup") and filesystems.

Problem description: let's start with a bug report. Below, is what happens
sometimes, under memory pressure, when a driver pins some pages via gup,
and then marks those pages dirty, and releases them. Note that the gup
documentation actually recommends that pattern. The problem is that the
filesystem may do a writeback while the pages were gup-pinned, and then the
filesystem believes that the pages are clean. So, when the driver later
marks the pages as dirty, that conflicts with the filesystem's page
tracking and results in a BUG(), like this one that I experienced:

    kernel BUG at /build/linux-fQ94TU/linux-4.4.0/fs/ext4/inode.c:1899!
    backtrace:
        ext4_writepage
        __writepage
        write_cache_pages
        ext4_writepages
        do_writepages
        __writeback_single_inode
        writeback_sb_inodes
        __writeback_inodes_wb
        wb_writeback
        wb_workfn
        process_one_work
        worker_thread
        kthread
        ret_from_fork

...which is due to the file system asserting that there are still buffer
heads attached:

        ({                                                      \
                BUG_ON(!PagePrivate(page));                     \
                ((struct buffer_head *)page_private(page));     \
        })

Dave Chinner's description of this is very clear:

    "The fundamental issue is that ->page_mkwrite must be called on every
    write access to a clean file backed page, not just the first one.
    How long the GUP reference lasts is irrelevant, if the page is clean
    and you need to dirty it, you must call ->page_mkwrite before it is
    marked writeable and dirtied. Every. Time."

This is just one symptom of the larger design problem: filesystems do not
actually support get_user_pages() being called on their pages, and letting
hardware write directly to those pages--even though that patter has been
going on since about 2005 or so.

The steps are to fix it are:

1) (This patch): provide put_user_page*() routines, intended to be used
   for releasing pages that were pinned via get_user_pages*().

2) Convert all of the call sites for get_user_pages*(), to
   invoke put_user_page*(), instead of put_page(). This involves dozens of
   call sites, and will take some time.

3) After (2) is complete, use get_user_pages*() and put_user_page*() to
   implement tracking of these pages. This tracking will be separate from
   the existing struct page refcounting.

4) Use the tracking and identification of these pages, to implement
   special handling (especially in writeback paths) when the pages are
   backed by a filesystem.

[1] https://lwn.net/Articles/774411/ : "DMA and get_user_pages()"
[2] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christopher Lameter <cl@linux.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 24 ++++++++++++++
 mm/swap.c          | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80bb6408fe73..809b7397d41e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -993,6 +993,30 @@ static inline void put_page(struct page *page)
 		__put_page(page);
 }
 
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
+ *
+ * put_user_page() and put_page() are not interchangeable, despite this early
+ * implementation that makes them look the same. put_user_page() calls must
+ * be perfectly matched up with get_user_page() calls.
+ */
+static inline void put_user_page(struct page *page)
+{
+	put_page(page);
+}
+
+void put_user_pages_dirty(struct page **pages, unsigned long npages);
+void put_user_pages_dirty_lock(struct page **pages, unsigned long npages);
+void put_user_pages(struct page **pages, unsigned long npages);
+
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define SECTION_IN_PAGE_FLAGS
 #endif
diff --git a/mm/swap.c b/mm/swap.c
index 4929bc1be60e..7c42ca45bb89 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -133,6 +133,88 @@ void put_pages_list(struct list_head *pages)
 }
 EXPORT_SYMBOL(put_pages_list);
 
+typedef int (*set_dirty_func)(struct page *page);
+
+static void __put_user_pages_dirty(struct page **pages,
+				   unsigned long npages,
+				   set_dirty_func sdf)
+{
+	unsigned long index;
+
+	for (index = 0; index < npages; index++) {
+		struct page *page = compound_head(pages[index]);
+
+		if (!PageDirty(page))
+			sdf(page);
+
+		put_user_page(page);
+	}
+}
+
+/**
+ * put_user_pages_dirty() - release and dirty an array of gup-pinned pages
+ * @pages:  array of pages to be marked dirty and released.
+ * @npages: number of pages in the @pages array.
+ *
+ * "gup-pinned page" refers to a page that has had one of the get_user_pages()
+ * variants called on that page.
+ *
+ * For each page in the @pages array, make that page (or its head page, if a
+ * compound page) dirty, if it was previously listed as clean. Then, release
+ * the page using put_user_page().
+ *
+ * Please see the put_user_page() documentation for details.
+ *
+ * set_page_dirty(), which does not lock the page, is used here.
+ * Therefore, it is the caller's responsibility to ensure that this is
+ * safe. If not, then put_user_pages_dirty_lock() should be called instead.
+ *
+ */
+void put_user_pages_dirty(struct page **pages, unsigned long npages)
+{
+	__put_user_pages_dirty(pages, npages, set_page_dirty);
+}
+EXPORT_SYMBOL(put_user_pages_dirty);
+
+/**
+ * put_user_pages_dirty_lock() - release and dirty an array of gup-pinned pages
+ * @pages:  array of pages to be marked dirty and released.
+ * @npages: number of pages in the @pages array.
+ *
+ * For each page in the @pages array, make that page (or its head page, if a
+ * compound page) dirty, if it was previously listed as clean. Then, release
+ * the page using put_user_page().
+ *
+ * Please see the put_user_page() documentation for details.
+ *
+ * This is just like put_user_pages_dirty(), except that it invokes
+ * set_page_dirty_lock(), instead of set_page_dirty().
+ *
+ */
+void put_user_pages_dirty_lock(struct page **pages, unsigned long npages)
+{
+	__put_user_pages_dirty(pages, npages, set_page_dirty_lock);
+}
+EXPORT_SYMBOL(put_user_pages_dirty_lock);
+
+/**
+ * put_user_pages() - release an array of gup-pinned pages.
+ * @pages:  array of pages to be marked dirty and released.
+ * @npages: number of pages in the @pages array.
+ *
+ * For each page in the @pages array, release the page using put_user_page().
+ *
+ * Please see the put_user_page() documentation for details.
+ */
+void put_user_pages(struct page **pages, unsigned long npages)
+{
+	unsigned long index;
+
+	for (index = 0; index < npages; index++)
+		put_user_page(pages[index]);
+}
+EXPORT_SYMBOL(put_user_pages);
+
 /*
  * get_kernel_pages() - pin kernel pages in memory
  * @kiov:	An array of struct kvec structures
-- 
2.20.1

