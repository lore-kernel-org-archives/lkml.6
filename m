Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F26DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE1E20883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk1YTnRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE1E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeKJSfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:35:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36518 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeKJSfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:35:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so3842864otk.3;
        Sat, 10 Nov 2018 00:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQzYRGwRvGy0wTzTibOwCgnjvzX67G4/Egjyof1ACX0=;
        b=Nk1YTnRFfBampYP+ABeK+Un57RtMYNfo/3F2nSHiwhJFjzIBleqVo+73lk8MB51Izy
         vHTKQSxOcRzd5GKuK+ZuneQVBj5LhakzxqRIWpcWkFsK+2Y4/6/HhKVCoCGjtTKnQme0
         mxw6kxocbuOt1uKg8Dou8OrX9zu7rmMpaGcQ1MHUNA17SCR+ZKPtd/dFtnDRolbMq+2y
         Iiz5jP3c5s1/Ro3JX46aJRWBJ02ZdoTR7tWR5TGujgjNh3n5geS07IGo7h7sMLjGRQx1
         zZQdIHUtZSCDAoH8wKvyNWNYcl+ub5HJWTS7RiuGA2HMdhyVSwUC1dNoYjeI4ovOahLJ
         uljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQzYRGwRvGy0wTzTibOwCgnjvzX67G4/Egjyof1ACX0=;
        b=WvA9m8MmJ4e+/Llx80FDNgrEAaHlXlwYUNOTmJvRGTtCoEszIC2LEDCnTiDZTRJ/7p
         Z9Wdm+GIDTdrCnqqmtmKXWXAVeHuCdwIzlprL+qzqT+3mVod7XBbNFTDqmjme8u4uAGS
         dFtzTeo96hjLds9V0PtQDOyKUFt48NITRFBZJJyFHediNACI8mMpURK1wh5iG1s7IdnH
         fD+iBhgkfQEyxllwk60hk6vP1Kvl3c4EFOJDlTjBUSR+EOOI/bn5ThlYkGZXeRoVI94T
         s0hJ6jMfjtGWtL3tU/yWEAkxAhb4gSfN3XJu4s2ad9DZ/j48/DYqJL/fOzef8FZSqZx2
         qaDg==
X-Gm-Message-State: AGRZ1gL6ptTSEQQ15XXWhj1vtssxhMfjTY/eNc2Bvu+GvsVc4Ltoesf2
        k5yY6YbZSb2wql9ekPpugVo=
X-Google-Smtp-Source: AJdET5dbJ+SB1VFV5aB20LOQEWX6sQwRwgnrBmEowRlNKiI9Q1/goHP0PZ9wPteUwvaSdCGeD64cZA==
X-Received: by 2002:a9d:2007:: with SMTP id n7mr6641465ota.157.1541839861680;
        Sat, 10 Nov 2018 00:51:01 -0800 (PST)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id c7-v6sm3908683oia.58.2018.11.10.00.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 00:51:00 -0800 (PST)
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
        Jan Kara <jack@suse.cz>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 4/6] mm: introduce page->dma_pinned_flags, _count
Date:   Sat, 10 Nov 2018 00:50:39 -0800
Message-Id: <20181110085041.10071-5-jhubbard@nvidia.com>
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

Add two struct page fields that, combined, are unioned with
struct page->lru. There is no change in the size of
struct page. These new fields are for type safety and clarity.

Also add page flag accessors to test, set and clear the new
page->dma_pinned_flags field.

The page->dma_pinned_count field will be used in upcoming
patches.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Christopher Lameter <cl@linux.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm_types.h   | 22 ++++++++++----
 include/linux/page-flags.h | 61 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 6 deletions(-)

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
index 50ce1bddaf56..3190b6b6a82f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -437,6 +437,67 @@ static __always_inline int __PageMovable(struct page *page)
 				PAGE_MAPPING_MOVABLE;
 }
 
+/*
+ * Because page->dma_pinned_flags is unioned with page->lru, any page that
+ * uses these flags must NOT be on an LRU. That's partly enforced by
+ * ClearPageDmaPinned, which gives the page back to LRU.
+ *
+ * PageDmaPinned is checked without knowing whether it is a tail page or a
+ * PageDmaPinned page. For that reason, PageDmaPinned avoids PageTail (the 0th
+ * bit in the first union of struct page), and instead uses bit 1 (0x2),
+ * rather than bit 0.
+ *
+ * PageDmaPinned can only be used if no other systems are using the same bit
+ * across the first struct page union. In this regard, it is similar to
+ * PageTail, and in fact, because of PageTail's constraint that bit 0 be left
+ * alone, bit 1 is also left alone so far: other union elements (ignoring tail
+ * pages) put pointers there, and pointer alignment leaves the lower two bits
+ * available.
+ *
+ * So, constraints include:
+ *
+ *     -- Only use PageDmaPinned on non-tail pages.
+ *     -- Remove the page from any LRU list first.
+ */
+#define PAGE_DMA_PINNED		0x2UL
+#define PAGE_DMA_PINNED_WAS_LRU	0x4UL
+
+static __always_inline int PageDmaPinned(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	return test_bit(PAGE_DMA_PINNED, &page->dma_pinned_flags);
+}
+
+static __always_inline void SetPageDmaPinned(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	set_bit(PAGE_DMA_PINNED, &page->dma_pinned_flags);
+}
+
+static __always_inline void ClearPageDmaPinned(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	clear_bit(PAGE_DMA_PINNED, &page->dma_pinned_flags);
+}
+
+static __always_inline int PageDmaPinnedWasLru(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	return test_bit(PAGE_DMA_PINNED_WAS_LRU, &page->dma_pinned_flags);
+}
+
+static __always_inline void SetPageDmaPinnedWasLru(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	set_bit(PAGE_DMA_PINNED_WAS_LRU, &page->dma_pinned_flags);
+}
+
+static __always_inline void ClearPageDmaPinnedWasLru(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	clear_bit(PAGE_DMA_PINNED_WAS_LRU, &page->dma_pinned_flags);
+}
+
 #ifdef CONFIG_KSM
 /*
  * A KSM page is one of those write-protected "shared pages" or "merged pages"
-- 
2.19.1

