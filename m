Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389A2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FB1206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNk43ufb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FB1206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJLNbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:31:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35320 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeJLNbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:31:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so5313681pgb.2;
        Thu, 11 Oct 2018 23:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gh0iMcWny3zvSFj5yeBKMay2lp+g5gk3KODm/Qj7ITs=;
        b=HNk43ufbmLiWrbq934PEnQKa5pQl5yxHoNNHbyzBh0vlNOW07XMAlxaq1ELX6DZpZr
         zd82cVQlG4M5ahqLMAw8uA0fFC94QAAQM2/1VkEfMl+5eP78RN30vgmBijluo92lfni6
         TylQ5wCZrHCTE31lOVMH2ID6khhot8SECkwpNf+u0zyxNs9tqPSF6KJor6D0CzD5N5pe
         1J8p+N1a6T5DHEZvGRQYFGySAcBFQ0o72NZrrVaVJxiUToixfYkA9DWzc3xqXTB2pFu9
         Pm9nBJTr+/43rjK8D7RZo9NheAydcKS0DPFltpC3/hCdJFCPTZzMP88AoCLHvukmCQ6u
         xNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gh0iMcWny3zvSFj5yeBKMay2lp+g5gk3KODm/Qj7ITs=;
        b=szhdQO+sRh/r1vEUUazrv+6F0Ly4SKFh/s7yy7y0zsF+LqkYHaRwwUn0xQdDDLZcvr
         CKSvId69PHqLyzIK1Xgt94oeR0vuC5e75TyNdHElzzYgR8r3yeHoBX8tFJcEVpmYxed5
         n8Qy0k8Dd+ZwkQ+64nSXm0VZTV4PEnCsL+4XBDTni8KrwZKfdI1K5UhRjhWM68gazogj
         33KKAOYcMW5alethWHiVTkKGuqs91AIxsSok4au2V5GdAyH0UKVIbJlmtirO/yruEcdn
         /ni2DnICTMkz/tM6ku8f/YMJ2a0Gu+lqfUuvHl4LUH5FXGzO6a42uVwwo4eo0bSRb2t9
         11MA==
X-Gm-Message-State: ABuFfoi24DzntqAsiyPG46B+Y+dbFYHMs0txAYQ+WWhoWgpYXpAohv0k
        3mpdtsH3y2xx1S5Jh+7Etks=
X-Google-Smtp-Source: ACcGV63gnU4EL5vvLLUMKJKEYNEP1I2/rD44xKSgl6Vt2wcq0ufr4HzfigzcCAy0DNUZXlQGQoCnrQ==
X-Received: by 2002:a63:c508:: with SMTP id f8-v6mr4290568pgd.412.1539324034160;
        Thu, 11 Oct 2018 23:00:34 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z3-v6sm368579pfm.150.2018.10.11.23.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 23:00:33 -0700 (PDT)
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
Subject: [PATCH 4/6] mm: introduce page->dma_pinned_flags, _count
Date:   Thu, 11 Oct 2018 23:00:12 -0700
Message-Id: <20181012060014.10242-5-jhubbard@nvidia.com>
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

Add two struct page fields that, combined, are unioned with
struct page->lru. There is no change in the size of
struct page. These new fields are for type safety and clarity.

Also add page flag accessors to test, set and clear the new
page->dma_pinned_flags field.

The page->dma_pinned_count field will be used in upcoming
patches

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm_types.h   | 22 +++++++++++++-----
 include/linux/page-flags.h | 47 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f6292a53..017ab82e36ca 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -78,12 +78,22 @@ struct page {
 	 */
 	union {
 		struct {	/* Page cache and anonymous pages */
-			/**
-			 * @lru: Pageout list, eg. active_list protected by
-			 * zone_lru_lock.  Sometimes used as a generic list
-			 * by the page owner.
-			 */
-			struct list_head lru;
+			union {
+				/**
+				 * @lru: Pageout list, eg. active_list protected
+				 * by zone_lru_lock.  Sometimes used as a
+				 * generic list by the page owner.
+				 */
+				struct list_head lru;
+				/* Used by get_user_pages*(). Pages may not be
+				 * on an LRU while these dma_pinned_* fields
+				 * are in use.
+				 */
+				struct {
+					unsigned long dma_pinned_flags;
+					atomic_t      dma_pinned_count;
+				};
+			};
 			/* See page-flags.h for PAGE_MAPPING_FLAGS */
 			struct address_space *mapping;
 			pgoff_t index;		/* Our offset within mapping. */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 74bee8cecf4c..81ed52c3caae 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -425,6 +425,53 @@ static __always_inline int __PageMovable(struct page *page)
 				PAGE_MAPPING_MOVABLE;
 }
 
+/*
+ * Because page->dma_pinned_flags is unioned with page->lru, any page that
+ * uses these flags must NOT be on an LRU. That's partly enforced by
+ * ClearPageDmaPinned, which gives the page back to LRU.
+ *
+ * PageDmaPinned also corresponds to PageTail (the 0th bit in the first union
+ * of struct page), and this flag is checked without knowing whether it is a
+ * tail page or a PageDmaPinned page. Therefore, start the flags at bit 1 (0x2),
+ * rather than bit 0.
+ */
+#define PAGE_DMA_PINNED		0x2
+#define PAGE_DMA_PINNED_FLAGS	(PAGE_DMA_PINNED)
+
+/*
+ * Because these flags are read outside of a lock, ensure visibility between
+ * different threads, by using READ|WRITE_ONCE.
+ */
+static __always_inline int PageDmaPinnedFlags(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	return (READ_ONCE(page->dma_pinned_flags) & PAGE_DMA_PINNED_FLAGS) != 0;
+}
+
+static __always_inline int PageDmaPinned(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	return (READ_ONCE(page->dma_pinned_flags) & PAGE_DMA_PINNED) != 0;
+}
+
+static __always_inline void SetPageDmaPinned(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	WRITE_ONCE(page->dma_pinned_flags, PAGE_DMA_PINNED);
+}
+
+static __always_inline void ClearPageDmaPinned(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	VM_BUG_ON_PAGE(!PageDmaPinnedFlags(page), page);
+
+	/* This does a WRITE_ONCE to the lru.next, which is also the
+	 * page->dma_pinned_flags field. So in addition to restoring page->lru,
+	 * this provides visibility to other threads.
+	 */
+	INIT_LIST_HEAD(&page->lru);
+}
+
 #ifdef CONFIG_KSM
 /*
  * A KSM page is one of those write-protected "shared pages" or "merged pages"
-- 
2.19.1

