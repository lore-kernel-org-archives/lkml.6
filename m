Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACED4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E2D206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxjBpuU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E2D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeJLNbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:31:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46789 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeJLNbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:31:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id a5-v6so5293907pgv.13;
        Thu, 11 Oct 2018 23:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRLJEVzK4rsJUyTaYZycnmpQ7/ZKK3lTkLVUuw5INZ4=;
        b=AxjBpuU766mXdfyjN2OWatg/Liyw5N/oXhRLqPL+Nea76E0Yzy1MgfO84O4EzWeeiP
         oi22kXoWmdGZxPlEnnYij0mmjuRufJnkPRzR4KYBSY4zzXEoRr4uxr7vNZtlgYnCNLjN
         BVvEdojqkPAs49gvT8Dv1RqdoHGHgslQvI/XZ0jVWoAJh1gfcGx8LDaE914XLoSuRZ+p
         YkqooFuTP7VvwBfNuI/qxdmG84sQMrUST3zCyiqPe1VVSSPe89mOCTq4hTCXnjpXFe16
         b81Xk2Cy1FyCaDZDKs2l02kxmjtwUVSIdNzaschO1LzG6skPNbCMA/40ETOV6/2ejZyK
         SWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRLJEVzK4rsJUyTaYZycnmpQ7/ZKK3lTkLVUuw5INZ4=;
        b=nNbK9hFoqQIZujrLCM8KYoL8H95TKIkZiTPfZEFPulA/I2+4sFEjafnNsZgVbw7zA1
         8oShlBzUp+9BU3+A3St8mzA1XbZuQeD6OklRKmvznqmSx0Ui0m4LZ5bIs+xRiYoIkNE/
         F3ldkvI/dbWmNl7c74o+h/d8vrt/n5zHttRcsK4tj89QUEKlHsbGpBLJer9Y03nwLywn
         xSuH2+9+RG+KsgCMl6xHec6vzG9GoWIWZmE+X9QhyXNXbcXd3yyGh3NjqbF5LXKMzJwh
         uCCrhz8f5B7FcKsbxFay1NpRquTJQxeOGyhCRKGAhP2SwKu8zRqbH+rlZmobE4m9F+NJ
         GbuA==
X-Gm-Message-State: ABuFfohecsXqvhb+Jz/nXZf9x07N+4geBDThNX315SNMmFPnfsgSeEfs
        9uTdXGRZ81fp6JNS1gj24/A=
X-Google-Smtp-Source: ACcGV62EXQmQtfK5+BRwRVu50/Z/i04Ym+nAuFReKL1rL6Ze0ikGwYEOKoKFATe2a/sSVbyyXmsnlw==
X-Received: by 2002:a63:6a86:: with SMTP id f128-v6mr4298418pgc.165.1539324030884;
        Thu, 11 Oct 2018 23:00:30 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z3-v6sm368579pfm.150.2018.10.11.23.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 23:00:29 -0700 (PDT)
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
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 2/6] mm: introduce put_user_page*(), placeholder versions
Date:   Thu, 11 Oct 2018 23:00:10 -0700
Message-Id: <20181012060014.10242-3-jhubbard@nvidia.com>
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

