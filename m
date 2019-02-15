Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F1CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B71222DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="nJw98cFu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GOpffcTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404272AbfBOWJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:39 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59865 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393418AbfBOWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:35 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BC535329D;
        Fri, 15 Feb 2019 17:09:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=/AQEq7MFamEX+
        lef9TgIsa67uAqS6jJC4Tewj7KDxqE=; b=nJw98cFuoVjMJxVajB0ZbTFZLpH6k
        sVVoLvTUAiPL7hd5xY3ESJa3IMPWNrQCNVjU91ojIWudhbT17n/87KEacbDpxu8W
        jtliE8TiMSzwb5t4nQO0k4M/EEq+HmJbJ1pskDwGW7Zc2IouHjtYAT0vPYSYaf4l
        DAVR+7pY2Am1WWjJvMmLJwX5FmCqMwtihIhp2UxIefwPqB/M45D9IoEHoN3eE0Xl
        cgon6S8jKGzL27KQl9GcSQdOhPNFl9BqxkpAyjnM3IsB2fj/Dp6uzOBOauZktyom
        sFEghzxAP/zQQkx/C2r/6NrDqaUM9DWNFB88/jZ9hW2bIGdUNI3s4AybA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=/AQEq7MFamEX+lef9TgIsa67uAqS6jJC4Tewj7KDxqE=; b=GOpffcTO
        NWchByon5Enk/TsqQkBi5A4+w4CuF+l75DY7LnedtUcB8nDTnZxl1Ank6j9hjE/z
        oKJ7wGE6uuj5n9TVzaWmb2C2CDOnmUwSMchVy4rEFVjZszHU6ANu9NZACPrwa3lH
        5bozi5ZtjyOuAfOPhAKbOPIyRLF3Kg3DZEOQnDQTXpdR5cp86Hg8XGnZdfqfIrLV
        lXWCAaIC0Awos3rjugymqMDliKbtDhilxhy6HhGirCKINZPzCpuPv6gJEnF20cZY
        briSyliEBPO8sBBgSPXST3HE0sTv2Q7rSfToExy6iku3mANeY709e9K4ETAae1VK
        xNfzOLcCbOAmyQ==
X-ME-Sender: <xms:mzhnXA_veGd6T1c9iQcnC2FvouWA5OwEUO793_cYA6mtcbSdjb5uNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpeduke
X-ME-Proxy: <xmx:nDhnXM84ProuA7o-5QpwqgKhUdZJfUh3N7tJdPFN64ZDujWhHKgDdQ>
    <xmx:nDhnXBAXB9ZN-zeY_GWrw3jlQheJbBfS_MHcQg_TnqBR_luSDhtMpw>
    <xmx:nDhnXEw7fLEeHc5PgQLOFkXHezz6xXdHpqJvrhlaJT9t9zgIlJTuFg>
    <xmx:nDhnXI4SB6YxH-TGDDBOFO_An7XAWzxW6mbzDcclQ-_TjgWDkznHUw>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 93795E4680;
        Fri, 15 Feb 2019 17:09:30 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 22/31] mm: thp: 1GB THP follow_p*d_page() support.
Date:   Fri, 15 Feb 2019 14:08:47 -0800
Message-Id: <20190215220856.29749-23-zi.yan@sent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215220856.29749-1-zi.yan@sent.com>
References: <20190215220856.29749-1-zi.yan@sent.com>
Reply-To: ziy@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Add follow_page support for 1GB THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 11 +++++++
 mm/gup.c                | 60 ++++++++++++++++++++++++++++++++-
 mm/huge_memory.c        | 73 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index bd5cc5e65de8..b1acada9ce8c 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -20,6 +20,10 @@ extern int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 extern void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
 extern int do_huge_pud_anonymous_page(struct vm_fault *vmf);
 extern int do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud);
+extern struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
+					  unsigned long addr,
+					  pud_t *pud,
+					  unsigned int flags);
 #else
 static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 {
@@ -32,6 +36,13 @@ extern int do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud)
 {
 	return VM_FAULT_FALLBACK;
 }
+struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
+					  unsigned long addr,
+					  pud_t *pud,
+					  unsigned int flags)
+{
+	return NULL;
+}
 #endif
 
 extern vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
diff --git a/mm/gup.c b/mm/gup.c
index 05acd7e2eb22..0ad0509b03fc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -348,10 +348,68 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 		if (page)
 			return page;
 	}
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	if (likely(!pud_trans_huge(*pud))) {
+		if (unlikely(pud_bad(*pud)))
+			return no_page_table(vma, flags);
+		return follow_pmd_mask(vma, address, pud, flags, ctx);
+	}
+
+	ptl = pud_lock(mm, pud);
+
+	if (unlikely(!pud_trans_huge(*pud))) {
+		spin_unlock(ptl);
+		if (unlikely(pud_bad(*pud)))
+			return no_page_table(vma, flags);
+		return follow_pmd_mask(vma, address, pud, flags, ctx);
+	}
+
+	if (flags & FOLL_SPLIT) {
+		int ret;
+		pmd_t *pmd = NULL;
+
+		page = pud_page(*pud);
+		if (is_huge_zero_page(page)) {
+
+			spin_unlock(ptl);
+			ret = 0;
+			split_huge_pud(vma, pud, address);
+			pmd = pmd_offset(pud, address);
+			split_huge_pmd(vma, pmd, address);
+			if (pmd_trans_unstable(pmd))
+				ret = -EBUSY;
+		} else {
+			get_page(page);
+			spin_unlock(ptl);
+			lock_page(page);
+			ret = split_huge_pud_page(page);
+			if (!ret)
+				ret = split_huge_page(page);
+			else {
+				unlock_page(page);
+				put_page(page);
+				goto out;
+			}
+			unlock_page(page);
+			put_page(page);
+			if (pud_none(*pud))
+				return no_page_table(vma, flags);
+			pmd = pmd_offset(pud, address);
+		}
+out:
+		return ret ? ERR_PTR(ret) :
+			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+	}
+	page = follow_trans_huge_pud(vma, address, pud, flags);
+	spin_unlock(ptl);
+	ctx->page_mask = HPAGE_PUD_NR - 1;
+	return page;
+#else
 	if (unlikely(pud_bad(*pud)))
 		return no_page_table(vma, flags);
-
 	return follow_pmd_mask(vma, address, pud, flags, ctx);
+#endif
 }
 
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 41adc103ead1..191261771452 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1309,6 +1309,77 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 	return page;
 }
 
+/*
+ * FOLL_FORCE can write to even unwritable pmd's, but only
+ * after we've gone through a COW cycle and they are dirty.
+ */
+static inline bool can_follow_write_pud(pud_t pud, unsigned int flags)
+{
+	return pud_write(pud) ||
+	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pud_dirty(pud));
+}
+
+struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
+				   unsigned long addr,
+				   pud_t *pud,
+				   unsigned int flags)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct page *page = NULL;
+
+	assert_spin_locked(pud_lockptr(mm, pud));
+
+	if (flags & FOLL_WRITE && !can_follow_write_pud(*pud, flags))
+		goto out;
+
+	/* Avoid dumping huge zero page */
+	if ((flags & FOLL_DUMP) && is_huge_zero_pud(*pud))
+		return ERR_PTR(-EFAULT);
+
+	/* Full NUMA hinting faults to serialise migration in fault paths */
+	/*&& pud_protnone(*pmd)*/
+	if ((flags & FOLL_NUMA))
+		goto out;
+
+	page = pud_page(*pud);
+	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
+	if (flags & FOLL_TOUCH)
+		touch_pud(vma, addr, pud, flags);
+	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
+		/*
+		 * We don't mlock() pte-mapped THPs. This way we can avoid
+		 * leaking mlocked pages into non-VM_LOCKED VMAs.
+		 *
+		 * For anon THP:
+		 *
+		 * We do the same thing as PMD-level THP.
+		 *
+		 * For file THP:
+		 *
+		 * No support yet.
+		 *
+		 */
+
+		if (PageAnon(page) && compound_mapcount(page) != 1)
+			goto skip_mlock;
+		if (PagePUDDoubleMap(page) || !page->mapping)
+			goto skip_mlock;
+		if (!trylock_page(page))
+			goto skip_mlock;
+		lru_add_drain();
+		if (page->mapping && !PagePUDDoubleMap(page))
+			mlock_vma_page(page);
+		unlock_page(page);
+	}
+skip_mlock:
+	page += (addr & ~HPAGE_PUD_MASK) >> PAGE_SHIFT;
+	VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
+	if (flags & FOLL_GET)
+		get_page(page);
+
+out:
+	return page;
+}
 int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
 		  struct vm_area_struct *vma)
@@ -1991,7 +2062,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 		goto out;
 
 	page = pmd_page(*pmd);
-	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
+	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page) && !PMDPageInPUD(page), page);
 	if (flags & FOLL_TOUCH)
 		touch_pmd(vma, addr, pmd, flags);
 	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
-- 
2.20.1

