Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A778FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6584E20892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajwrcVRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6584E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbeKJSfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:35:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40900 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeKJSfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:35:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so3827611oth.7;
        Sat, 10 Nov 2018 00:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=byoN6dpxnS7IRdKUDH2AwtnUODkweYTe+330yUFTr7M=;
        b=ajwrcVRxs4El5+P9ZBzXqQSnZXvSJZXJ0XPA/y88FiBtBqDx8SJzEezYRSTApnfI+/
         iqOZyPx7wRadvTHkFjAzGMey7xzu4kZwLs1oI0dQ2nwGbSl8NX5bvcJGvNzrd+dtT64I
         CX4rui3+pIPAeVs51W5NomjzeWR+heJCV4eZIhEU5QFUu/nI+rOwE+ao9FZ3q1g68+ok
         QBRtVaUDfMK5Ra09GOATElnRZQSKHIdoIWRoaro0zDLa/LRBFNtXXCMGBJO+T4W4aF5u
         hXYjC18rgL/kwMDnfl5oJPjoUkjaZvvs3NosDVZtKR5CrjqPeUTdN+ooydbjQVr9Mcw6
         l9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=byoN6dpxnS7IRdKUDH2AwtnUODkweYTe+330yUFTr7M=;
        b=mrNRvqMg6Ulp73mztLru8oj2Qgo5c4ZkNdUXTgB6B3jTH/kPgbvcjuiSH6HYv3DNEt
         MTsT+Ip4f+oellwIfLjXQuQMGWJORRQF8OCdcIKuJpuGiyT3OZ0qzM+c60GblNZ7MQD8
         YxhWPiU/iGeznMzAj5nLpz21NoL3LGNAjZBbdadzyqHSPVwGdUDYXKYUhDO/G1euD7iB
         zL3pXIoAVnM3bTUH7IbKFg97N8OBuql3sUjPkCmqpCmKqiPN7AXGfuK3nAU+Xtg6q7pY
         NYXplaYybTQzzMPOJmBXNItsvkbOS0VvDBmp4q+tjT6wgr5G96UN3sEZSpWWCNduFzIA
         S+NQ==
X-Gm-Message-State: AGRZ1gIksZxf87aijMZHVK5EepJ1FU+QtDQIpc2U+2YYNvFbXHSAqBUk
        zK0vroUYSj2SqgFRQAfCsjw=
X-Google-Smtp-Source: AJdET5eggQJwTcmFckGe7+MlcXVrxUZdQlfakgJnHOgQqf3tQFCGsYBjwffIfp5nHHTMN0+yAqiuUQ==
X-Received: by 2002:a9d:7059:: with SMTP id x25mr7671591otj.35.1541839858309;
        Sat, 10 Nov 2018 00:50:58 -0800 (PST)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id c7-v6sm3908683oia.58.2018.11.10.00.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 00:50:57 -0800 (PST)
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
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 2/6] mm: introduce put_user_page*(), placeholder versions
Date:   Sat, 10 Nov 2018 00:50:37 -0800
Message-Id: <20181110085041.10071-3-jhubbard@nvidia.com>
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

Reviewed-by: Jan Kara <jack@suse.cz>
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
2.19.1

