Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2188AC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AC420851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRHptAnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AC420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeLDARa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:17:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45102 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:17:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so7304375plm.12;
        Mon, 03 Dec 2018 16:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XzA73EqE8Ltz+Bmvg4LIrynYRpRmJP+rG0bPVB2uNWI=;
        b=qRHptAnxSmY0SV7pTLD0P+JxP2qf/CoGd2JSoAg8lb0oOJ8/vswldPL6YwN9D5Iy+g
         tGBjq3O4Oh+Ycz5WDc/ybZHNt1S7p2c4tt61hFDgBjIthRQF5bVJVeqwxnKCBHVhJpqI
         x5xT9PDGpZq260jDIC+mb35DFYhhoAiCwivBoyZlzK960q0eF939KalKQ6a733DgIP/A
         GcHRW6dFklUb1zfrM8dA0lqUdxFNJr90maY+jKBs9URiKnM24VGngAVb9N8gLajyNJGT
         l2eQ1DcWQTiFgb2cgO6+53eYfpDc5T3L6mXSLMxknbBRvpl5vcQNWZYq6y3nTczVmQX+
         dfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzA73EqE8Ltz+Bmvg4LIrynYRpRmJP+rG0bPVB2uNWI=;
        b=bH87peFB2/fQCkqtOuz8A1JDVd87svjcWP20SNlmMvHyslNbZlA2YB9IdTcJKoeOrf
         GZHvDvHXSWNRmwpv+S6J2mJuf1vaP69K0+RIMv0UzYnI3GWvqd8//vQh/pVhohLJhE0S
         dWPNuIFVuD+Mbd0kO3j2RpyQS1Wi7KKcPfiClTULaEn+aNhiG12AOAyUg7nuGZ8pjc04
         UuGHuKsJ5FRafn++sHF3RiHgqisVt9p1AE35kZs01A/lK9SqmzYXUQWQIZvkx7PKdVgG
         z/SFsmCknPI9KCt+TGZ6BN2wnQSxBwLtQcxOJzrpliZ3+fXzaBFH4m24t/4pOFo/7Und
         9TCw==
X-Gm-Message-State: AA+aEWYAClg41nYUzsQHhdEVmLpj4nyR3gXE573lc2qO7zmdSjw8Nwf9
        QnDfHusctIHgHiFeoKcVWBg=
X-Google-Smtp-Source: AFSGD/XZ2IX9Gr12rMvn+Gle/ds7bHz6CGJlgl2qe1W1dmyW/pbSa/y0VamDlEIdGHq91r7QKb4qQw==
X-Received: by 2002:a17:902:47aa:: with SMTP id r39mr17855076pld.219.1543882646874;
        Mon, 03 Dec 2018 16:17:26 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y12sm21733332pfk.70.2018.12.03.16.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 16:17:26 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Jan Kara <jack@suse.cz>, Tom Talpey <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Date:   Mon,  3 Dec 2018 16:17:19 -0800
Message-Id: <20181204001720.26138-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204001720.26138-1-jhubbard@nvidia.com>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
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
   call sites, and will take some time.

3) After (2) is complete, use get_user_pages*() and put_user_page*() to
   implement tracking of these pages. This tracking will be separate from
   the existing struct page refcounting.

4) Use the tracking and identification of these pages, to implement
   special handling (especially in writeback paths) when the pages are
   backed by a filesystem. Again, [1] provides details as to why that is
   desirable.

[1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

Reviewed-by: Jan Kara <jack@suse.cz>

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Christopher Lameter <cl@linux.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 20 ++++++++++++
 mm/swap.c          | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5411de93a363..09fbb2c81aba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -963,6 +963,26 @@ static inline void put_page(struct page *page)
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
index aa483719922e..bb8c32595e5f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -133,6 +133,86 @@ void put_pages_list(struct list_head *pages)
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
+	__put_user_pages_dirty(pages, npages, set_page_dirty);
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
+	__put_user_pages_dirty(pages, npages, set_page_dirty_lock);
+}
+EXPORT_SYMBOL(put_user_pages_dirty_lock);
+
+/*
+ * put_user_pages() - for each page in the @pages array, release the page
+ * using put_user_page().
+ *
+ * Please see the put_user_page() documentation for details.
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
2.19.2

