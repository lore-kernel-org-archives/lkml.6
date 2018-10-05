Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C790CC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FD82084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G925Ez54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FD82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeJEK7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 06:59:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36569 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbeJEK7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 06:59:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id b7-v6so4427459pfo.3;
        Thu, 04 Oct 2018 21:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sneRiApjkE2w/LYnauim2aX4bIqXkJ3JToZQnFGODZI=;
        b=G925Ez54V6JJWAef4ifohJatJCsxpMB3vmgzPXoleKdhs2SUZ1saufdVQb43Te9LG/
         VMP7duDIeynYhl/lRxVvlvTsDI3eBLW/rZJXFGtR9fSvrT/2nEtnHo5N2uF3ZSrDEpay
         irbzwETAEbj208oSKf+x8TPpIWjqIyVgi+9frgwQK2gFY33UZ/o/YPi+T/fSDzcwP9O9
         7XGwPRp78aymRSx8CjSetBbZ8BybVcDOeK8MVVfjSXYWvOb+uJ+bKL9fm4K3nTSNh+xk
         6kj5l/cYdt2TnnhV8OrsIES/odt1eMN+pa6HHkK8Lr+Vg+zR/ruKiHT7d/jMj2pvNlE6
         afxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sneRiApjkE2w/LYnauim2aX4bIqXkJ3JToZQnFGODZI=;
        b=fAdLnjr6zv8oICvJxLiGvkhg1MYF5JyL0JKx+JTr74ylagtJfVe9i2PGWXP4d8Be11
         4dIcE2KS3ec84KLiVd03QHGrbjyCsm6cUThlcjkFJPKDEa8Hz7KmAGxyZFfwJwIy1Olm
         HG9ydfgu6nmD7aIDHPEx2xqpZrP6A6Ii8w+Zyino3H3qaTUwQ42no9ux/Y96itCJ4ofK
         j+zpDylycEKwClW0P5hKGHZ7HjXTJeQJ5UhtDSWRRjzXRLIWUiNnXP3Xi+IuorTz0jOF
         T1bz3k/ce0JE7hMmfP/gCf9oAoNi6Xk8NWuNoUe3hgXcA9Tt8FZ4zmE25jLuf8kIE44r
         vtAQ==
X-Gm-Message-State: ABuFfohKjI2CDm6nt+4JkRveWNxNXFpTvCSc+zEj/QZ0zW5OAwQN++qx
        PT5kZn8aIVCgcc6vWTk3qq4=
X-Google-Smtp-Source: ACcGV63ud+uapXxy4ksvwJiP03+IcTue5DKxZxXzl98fY+QwOT06xFfAHVA5zn20RAqTInx/E6hdlA==
X-Received: by 2002:a62:2741:: with SMTP id n62-v6mr2718591pfn.138.1538712151684;
        Thu, 04 Oct 2018 21:02:31 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c2-v6sm8787899pfo.107.2018.10.04.21.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 21:02:30 -0700 (PDT)
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
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 2/3] mm: introduce put_user_page[s](), placeholder versions
Date:   Thu,  4 Oct 2018 21:02:24 -0700
Message-Id: <20181005040225.14292-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005040225.14292-1-jhubbard@nvidia.com>
References: <20181005040225.14292-1-jhubbard@nvidia.com>
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
as a replacement for release_pages(), for the same reasons.
These may be used for subsequent performance improvements,
via batching of pages to be released.

This prepares for eventually fixing the problem described
in [1], and is following a plan listed in [2], [3], [4].

[1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

[2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
    Proposed steps for fixing get_user_pages() + DMA problems.

[3]https://lkml.kernel.org/r/20180710082100.mkdwngdv5kkrcz6n@quack2.suse.cz
    Bounce buffers (otherwise [2] is not really viable).

[4] https://lkml.kernel.org/r/20181003162115.GG24030@quack2.suse.cz
    Follow-up discussions.

CC: Matthew Wilcox <willy@infradead.org>
CC: Michal Hocko <mhocko@kernel.org>
CC: Christopher Lameter <cl@linux.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Jan Kara <jack@suse.cz>
CC: Al Viro <viro@zeniv.linux.org.uk>
CC: Jerome Glisse <jglisse@redhat.com>
CC: Christoph Hellwig <hch@infradead.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a61ebe8ad4ca..1a9aae7c659f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -137,6 +137,8 @@ extern int overcommit_ratio_handler(struct ctl_table *, int, void __user *,
 				    size_t *, loff_t *);
 extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 				    size_t *, loff_t *);
+int set_page_dirty(struct page *page);
+int set_page_dirty_lock(struct page *page);
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
@@ -943,6 +945,44 @@ static inline void put_page(struct page *page)
 		__put_page(page);
 }
 
+/* Placeholder version, until all get_user_pages*() callers are updated. */
+static inline void put_user_page(struct page *page)
+{
+	put_page(page);
+}
+
+/* For get_user_pages*()-pinned pages, use these variants instead of
+ * release_pages():
+ */
+static inline void put_user_pages_dirty(struct page **pages,
+					unsigned long npages)
+{
+	while (npages) {
+		set_page_dirty(pages[npages]);
+		put_user_page(pages[npages]);
+		--npages;
+	}
+}
+
+static inline void put_user_pages_dirty_lock(struct page **pages,
+					     unsigned long npages)
+{
+	while (npages) {
+		set_page_dirty_lock(pages[npages]);
+		put_user_page(pages[npages]);
+		--npages;
+	}
+}
+
+static inline void put_user_pages(struct page **pages,
+				  unsigned long npages)
+{
+	while (npages) {
+		put_user_page(pages[npages]);
+		--npages;
+	}
+}
+
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define SECTION_IN_PAGE_FLAGS
 #endif
@@ -1534,8 +1574,6 @@ int redirty_page_for_writepage(struct writeback_control *wbc,
 void account_page_dirtied(struct page *page, struct address_space *mapping);
 void account_page_cleaned(struct page *page, struct address_space *mapping,
 			  struct bdi_writeback *wb);
-int set_page_dirty(struct page *page);
-int set_page_dirty_lock(struct page *page);
 void __cancel_dirty_page(struct page *page);
 static inline void cancel_dirty_page(struct page *page)
 {
-- 
2.19.0

