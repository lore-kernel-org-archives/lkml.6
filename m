Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C360C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F6F2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob37Nx0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F6F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJJLb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:31:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35614 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJLb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:31:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so1862367pgb.2;
        Tue, 09 Oct 2018 21:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRLJEVzK4rsJUyTaYZycnmpQ7/ZKK3lTkLVUuw5INZ4=;
        b=Ob37Nx0ZLR4qV7aU515TbRP68PjRwW3qbHfe+HztguUShHTzm+Sq5ep+wmDgtTIgyt
         15FILkiYgrCHyDKmo3NrkyepA7GlCRHJMHvpAJ2Rmd2eDm/c/Xxx0x9652Kf8Lfnb1pQ
         zfmWW5ySZiLNa9ank1pUt1Ya2pQMVqgG8hYfrAguq0FP0qlXt8HfadpOTQJLQr2irJd7
         AOOuIA4FzpiGdj80JNOTMb8zHi2jd5/zaFsemJIIf4adKvhLDkt85xIHnayzk4++G/8a
         o/8ZwxvYMQg3/j/lAcwGxShVtiU4BMeoyyw9y/nZOgJUaYjhQdfDfJLg/DGHBqo3IsdA
         V8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRLJEVzK4rsJUyTaYZycnmpQ7/ZKK3lTkLVUuw5INZ4=;
        b=piNNlKyrGpPsLYykSDhVnmDwNKxRwsTugmWl250dNugSh+3RRMN592iAf0EkHgap1z
         iKx9whQAFIX+/5rT9znuFra8/Ad7LL/WdQghNrU4Tnn+5sIvGUDwRCcvktU+dFJjYlXB
         lek2+6+2kmbHDXgi6ElIdJSeSHtDFAWv0M6qB0sX1Hi7UA5LE8It6pGdqFmBVhPVACR3
         NC4KphSXiZJdMAaVZlNgDw/mXSI9GlQ3rA2IVyeiCOvmhV+Jehmbvg+yxszFB8M8pIDH
         t8C3iYr30woK856kOPyYhMDHz7xdBwSRqCx3usi0RhSMDbVMA9ii8M/1azwtirs0i4Z0
         v3ZQ==
X-Gm-Message-State: ABuFfojncl+xfuUE51vvQO8imSRSh6sPY6h9Wf47EA167M1a3PvgHb6g
        qzcPlwd5JpvvvRT/+tLOAaU=
X-Google-Smtp-Source: ACcGV62wmHqVq1j1owFDRY8i0rp1o8ZqNF8AR5SxSHWRQuJIuMtFz1CzOqtzXwZtM8hgoNOwdzqnHQ==
X-Received: by 2002:a62:6414:: with SMTP id y20-v6mr33073690pfb.213.1539144704161;
        Tue, 09 Oct 2018 21:11:44 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id o133-v6sm50045619pfg.86.2018.10.09.21.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 21:11:43 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v5 2/3] mm: introduce put_user_page*(), placeholder versions
Date:   Tue,  9 Oct 2018 21:11:33 -0700
Message-Id: <20181010041134.14096-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181010041134.14096-1-jhubbard@nvidia.com>
References: <20181010041134.14096-1-jhubbard@nvidia.com>
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

This is the first step of fixing the problem described in [1]. The steps
are:

1) (This patch): provide put_user_page*() routines, intended to be used
   for releasing pages that were pinned via get_user_pages*().

2) Convert all of the call sites for get_user_pages*(), to
   invoke put_user_page*(), instead of put_page(). This involves dozens of
   call sites, any will take some time.

3) After (2) is complete, use get_user_pages*() and put_user_page*() to
   implement tracking of these pages. This tracking will be separate from
   the existing struct page refcounting.

4) Use the tracking and identification of these pages, to implement
   special handling (especially in writeback paths) when the pages are
   backed by a filesystem. Again, [1] provides details as to why that is
   desirable.

[1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

CC: Matthew Wilcox <willy@infradead.org>
CC: Michal Hocko <mhocko@kernel.org>
CC: Christopher Lameter <cl@linux.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Jan Kara <jack@suse.cz>
CC: Al Viro <viro@zeniv.linux.org.uk>
CC: Jerome Glisse <jglisse@redhat.com>
CC: Christoph Hellwig <hch@infradead.org>
CC: Ralph Campbell <rcampbell@nvidia.com>

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 20 +++++++++++
 mm/swap.c          | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0416a7204be3..76d18aada9f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -943,6 +943,26 @@ static inline void put_page(struct page *page)
 		__put_page(page);
 }
 
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
index 26fc9b5f1b6c..efab3a6b6f91 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -134,6 +134,89 @@ void put_pages_list(struct list_head *pages)
 }
 EXPORT_SYMBOL(put_pages_list);
 
+/*
+ * put_user_pages_dirty() - for each page in the @pages array, make
+ * that page (or its head page, if a compound page) dirty, if it was
+ * previously listed as clean. Then, release the page using
+ * put_user_page().
+ *
+ * Please see the put_user_page() documentation for details.
+ *
+ * set_page_dirty(), which does not lock the page, is used here.
+ * Therefore, it is the caller's responsibility to ensure that this is
+ * safe. If not, then put_user_pages_dirty_lock() should be called instead.
+ *
+ * @pages:  array of pages to be marked dirty and released.
+ * @npages: number of pages in the @pages array.
+ *
+ */
+void put_user_pages_dirty(struct page **pages, unsigned long npages)
+{
+	unsigned long index;
+
+	for (index = 0; index < npages; index++) {
+		struct page *page = compound_head(pages[index]);
+
+		if (!PageDirty(page))
+			set_page_dirty(page);
+
+		put_user_page(page);
+	}
+}
+EXPORT_SYMBOL(put_user_pages_dirty);
+
+/*
+ * put_user_pages_dirty_lock() - for each page in the @pages array, make
+ * that page (or its head page, if a compound page) dirty, if it was
+ * previously listed as clean. Then, release the page using
+ * put_user_page().
+ *
+ * Please see the put_user_page() documentation for details.
+ *
+ * This is just like put_user_pages_dirty(), except that it invokes
+ * set_page_dirty_lock(), instead of set_page_dirty().
+ *
+ * @pages:  array of pages to be marked dirty and released.
+ * @npages: number of pages in the @pages array.
+ *
+ */
+void put_user_pages_dirty_lock(struct page **pages, unsigned long npages)
+{
+	unsigned long index;
+
+	for (index = 0; index < npages; index++) {
+		struct page *page = compound_head(pages[index]);
+
+		if (!PageDirty(page))
+			set_page_dirty_lock(page);
+
+		put_user_page(page);
+	}
+}
+EXPORT_SYMBOL(put_user_pages_dirty_lock);
+
+/*
+ * put_user_pages() - for each page in the @pages array, release the page
+ * using put_user_page().
+ *
+ * Please see the put_user_page() documentation for details.
+ *
+ * This is just like put_user_pages_dirty(), except that it invokes
+ * set_page_dirty_lock(), instead of set_page_dirty().
+ *
+ * @pages:  array of pages to be marked dirty and released.
+ * @npages: number of pages in the @pages array.
+ *
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
2.19.1

