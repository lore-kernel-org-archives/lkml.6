Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2C6C65BD0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D683E21479
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZT62M2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D683E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeJFJv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 05:51:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39913 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeJFJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 05:51:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so7626849plp.6;
        Fri, 05 Oct 2018 19:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=01DDUSyuajCXizBTsypEqSwY2/MJLvR3TICruWaqIVc=;
        b=gZT62M2H6Q36uwqP8UJt98SnxUmEe0yrjAmJ2xll4EC9dRr78DoAkNM4Bsvi+vH0ug
         yGvv//ICP4M0GjxzxoA9O/8lCppksEoFyonWiBtBpHDx4apadIU56gbXr6qwB9+SgNM5
         oeAK+/uFC2WaE9hVjy8f5GLT+X3NwJBMIJA2KTrzh2Z/C2m7PQH3OJlrD+VPM8lZsq0e
         SPC5HneuopMYVZxZzzJ2DfZXllsm3L6UGySg0xVB/BLB6EcewLjyFfBDT2hZhMsHZuiM
         Ig2I60+7M9LHpPByDDeqPTx9cDPFzkJM4mAnJZfgruICN+xh2KZsYmZlqj9j5e9M66Q6
         mwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01DDUSyuajCXizBTsypEqSwY2/MJLvR3TICruWaqIVc=;
        b=T/SYxfy9Q0Y/yosPdgBaR3zKaYRfP0dmP6Y2zLhPchqSHDQJXQSBPlnSwsYWFPN8K/
         qQJ/ZTURyEHH7UndLUaHEPs7vtcPxmaqkwjDoqRilw2Lt3YkaeAUYLv8qSsA5tQs0CIk
         KUI7+YiuBz815h6ofw3AFrzckiWFZoSxSoDXk4bf6ruNMxAEhGLMMACRVD8Jzr7pSMuX
         0BlMgzZIiqddamWZPJGQNm4ThZfQe3izkLcpj7xefqUMnt/R+QtYR/Ukd4qXa1YomrLF
         2AtL+ZzeORz/uP2eugOU32WB6ufhey0OmGTJdiLWWm6o9nplcARPkfunxUNbPPwYrv0Z
         /+JQ==
X-Gm-Message-State: ABuFfoh0Kc2tC+3Jg7YKPIOLFdCM3hljNVOmusOQvfENrDoWZA2iside
        TuWNe34DXZH0kdq4G/qdk1o=
X-Google-Smtp-Source: ACcGV61qFbcFaNDprDERpWbkRlyDNawmPGj+nXn0xCRdARDugWyI37vkT6XxOYW+se4JH8oMqeQVSA==
X-Received: by 2002:a17:902:6b06:: with SMTP id o6-v6mr13810554plk.6.1538794195317;
        Fri, 05 Oct 2018 19:49:55 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id n63-v6sm3962785pfn.9.2018.10.05.19.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 19:49:54 -0700 (PDT)
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
Subject: [PATCH v3 2/3] mm: introduce put_user_page*(), placeholder versions
Date:   Fri,  5 Oct 2018 19:49:48 -0700
Message-Id: <20181006024949.20691-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181006024949.20691-1-jhubbard@nvidia.com>
References: <20181006024949.20691-1-jhubbard@nvidia.com>
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
CC: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 48 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0416a7204be3..305b206e6851 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -137,6 +137,8 @@ extern int overcommit_ratio_handler(struct ctl_table *, int, void __user *,
 				    size_t *, loff_t *);
 extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 				    size_t *, loff_t *);
+int set_page_dirty(struct page *page);
+int set_page_dirty_lock(struct page *page);
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
@@ -943,6 +945,50 @@ static inline void put_page(struct page *page)
 		__put_page(page);
 }
 
+/* Pages that were pinned via get_user_pages*() should be released via
+ * either put_user_page(), or one of the put_user_pages*() routines
+ * below.
+ */
+static inline void put_user_page(struct page *page)
+{
+	put_page(page);
+}
+
+static inline void put_user_pages_dirty(struct page **pages,
+					unsigned long npages)
+{
+	unsigned long index;
+
+	for (index = 0; index < npages; index++) {
+		if (!PageDirty(pages[index]))
+			set_page_dirty(pages[index]);
+
+		put_user_page(pages[index]);
+	}
+}
+
+static inline void put_user_pages_dirty_lock(struct page **pages,
+					     unsigned long npages)
+{
+	unsigned long index;
+
+	for (index = 0; index < npages; index++) {
+		if (!PageDirty(pages[index]))
+			set_page_dirty_lock(pages[index]);
+
+		put_user_page(pages[index]);
+	}
+}
+
+static inline void put_user_pages(struct page **pages,
+				  unsigned long npages)
+{
+	unsigned long index;
+
+	for (index = 0; index < npages; index++)
+		put_user_page(pages[index]);
+}
+
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define SECTION_IN_PAGE_FLAGS
 #endif
@@ -1534,8 +1580,6 @@ int redirty_page_for_writepage(struct writeback_control *wbc,
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

