Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C35C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D5A222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="bCST9++F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N2TNvU/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393602AbfBOWJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:49 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46339 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393525AbfBOWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2050E329D;
        Fri, 15 Feb 2019 17:09:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=k7ZExxjAnB4ke
        DLSp3xQU/1nRGQzF8KzUQhggKQXhQA=; b=bCST9++F8XtSzpwjh7el976UwiLPi
        M7Tj8JRboCd0IwlnCEwtvDlYbyA8Rjpd9AeKVgoCIT5DSbK0F5OT5ThksiP9y5Fv
        gGUOCMAhWAnS5OrY9KmLJvxXKHo1+9vfT0FHiVvUevjxUVRUqZ1jfE5ADNrp63Eq
        /BSrH5lpf3BTEN5ouultEKnaUjtma934YpfHusNBt4taJWspaNRCAdRyHucXSagp
        oW5tMUYZxy4oRavKWNRO2QmLgry+kZrIic4ZFt7PkUj9qmE0XYNs8+wq+XNQLG3O
        8obrb2RuOt5RHrBgdH7qr7GXlFclhjXKS0B7bHOjn0H4N7EONBlfEZwMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=k7ZExxjAnB4keDLSp3xQU/1nRGQzF8KzUQhggKQXhQA=; b=N2TNvU/R
        jWTIXilhmDIXAMyLfIPdfFFt3yofQ6K/H+6duECZyb3D3Kn7KlO1wWA8/o5J0cUi
        OsigiqED0MnljUauXgN6wn4MUvpUVzfu+LgdOMgVv8w9KKh7Xv0wYYmRQmKAHzYf
        cCO7bZb5Ge+jT7dNlPLCNbPaE8Q39AgTa5QJorojhOadKrKZivu3BJA60YJgqGVT
        HQ05Kdd2LfbbRewAP7EjHdyMiFktvsgQp3edeAdrCfZf1Qkz6ICEWtIbuu6qMwSc
        fWDF8CwPOgTdGU3iA3GIk55JoI/68mEukzNu/fWChg9Z16Gteap7m0l7/pFTOnkF
        LKNxQ/mqa/zLXg==
X-ME-Sender: <xms:pThnXOfCEQkB3dIgkj-bbMV2P1V4xGb6tojk3NBiKXrJb_mY2F8arw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:pThnXFnvX2RCQtgh3ZjWLqa1Tl-Ct979ZmGI1JylyY4D9wVRCq7WHw>
    <xmx:pThnXJDvYISAyw_AffEAYhGrsIfIqU9D2WNAWn2oadnugtXdx5M6AA>
    <xmx:pThnXHMivLaeC6T-i5gH3Gkigvx4j52hR1mKCLFpYK1vV85T7_Skng>
    <xmx:pThnXOx4MgLnCxPGUL3fIhfGZQYUkftz2pQPbdWaEeEcR_zDnYDv4A>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2ABD2E4597;
        Fri, 15 Feb 2019 17:09:40 -0500 (EST)
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
Subject: [RFC PATCH 29/31] mm: madvise: add madvise options to split PMD and PUD THPs.
Date:   Fri, 15 Feb 2019 14:08:54 -0800
Message-Id: <20190215220856.29749-30-zi.yan@sent.com>
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

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/uapi/asm-generic/mman-common.h |  12 +++
 mm/madvise.c                           | 106 +++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index d1ec94a1970d..33db8b6a2ce0 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -69,6 +69,18 @@
 #define MADV_MEMDEFRAG	20		/* Worth backing with hugepages */
 #define MADV_NOMEMDEFRAG	21		/* Not worth backing with hugepages */
 
+#define MADV_SPLITHUGEPAGE	24		/* Split huge page in range once */
+#define MADV_PROMOTEHUGEPAGE	25		/* Promote range into huge page */
+
+#define MADV_SPLITHUGEMAP	26		/* Split huge page table entry in range once */
+#define MADV_PROMOTEHUGEMAP	27		/* Promote range into huge page table entry */
+
+#define MADV_SPLITHUGEPUDPAGE	28		/* Split huge page in range once */
+#define MADV_PROMOTEHUGEPUDPAGE	29		/* Promote range into huge page */
+
+#define MADV_SPLITHUGEPUDMAP	30		/* Split huge page table entry in range once */
+#define MADV_PROMOTEHUGEPUDMAP	31		/* Promote range into huge page table entry */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 9cef96d633e8..be3818c06e17 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -624,6 +624,95 @@ static long madvise_memdefrag(struct vm_area_struct *vma,
 	*prev = vma;
 	return memdefrag_madvise(vma, &vma->vm_flags, behavior);
 }
+
+static long madvise_split_promote_hugepage(struct vm_area_struct *vma,
+		     struct vm_area_struct **prev,
+		     unsigned long start, unsigned long end, int behavior)
+{
+	struct page *page;
+	unsigned long addr = start, haddr;
+	int ret = 0;
+	*prev = vma;
+
+	while (addr < end && !ret) {
+		switch (behavior) {
+		case MADV_SPLITHUGEMAP:
+			split_huge_pmd_address(vma, addr, false, NULL);
+			addr += HPAGE_PMD_SIZE;
+			break;
+		case MADV_SPLITHUGEPUDMAP:
+			split_huge_pud_address(vma, addr, false, NULL);
+			addr += HPAGE_PUD_SIZE;
+			break;
+		case MADV_SPLITHUGEPAGE:
+			page = follow_page(vma, addr, FOLL_GET);
+			if (page) {
+				lock_page(page);
+				if (split_huge_page(page)) {
+					pr_debug("%s: fail to split page\n", __func__);
+					ret = -EBUSY;
+				}
+				unlock_page(page);
+				put_page(page);
+			} else
+				ret = -ENODEV;
+			addr += HPAGE_PMD_SIZE;
+			break;
+		case MADV_SPLITHUGEPUDPAGE:
+			page = follow_page(vma, addr, FOLL_GET);
+			if (page) {
+				lock_page(page);
+				if (split_huge_pud_page(page)) {
+					pr_debug("%s: fail to split pud page\n", __func__);
+					ret = -EBUSY;
+				}
+				unlock_page(page);
+				put_page(page);
+			} else
+				ret = -ENODEV;
+			addr += HPAGE_PUD_SIZE;
+			break;
+		case MADV_PROMOTEHUGEMAP:
+			haddr = addr & HPAGE_PMD_MASK;
+			if (haddr >= start && (haddr + HPAGE_PMD_SIZE) <= end)
+				promote_huge_pmd_address(vma, haddr);
+			else
+				ret = -ENODEV;
+			addr += HPAGE_PMD_SIZE;
+			break;
+		case MADV_PROMOTEHUGEPUDMAP:
+			haddr = addr & HPAGE_PUD_MASK;
+			if (haddr >= start && (haddr + HPAGE_PUD_SIZE) <= end)
+				promote_huge_pud_address(vma, haddr);
+			else
+				ret = -ENODEV;
+			addr += HPAGE_PUD_SIZE;
+			break;
+		case MADV_PROMOTEHUGEPAGE:
+			haddr = addr & HPAGE_PMD_MASK;
+			if (haddr >= start && (haddr + HPAGE_PMD_SIZE) <= end)
+				promote_huge_page_address(vma, haddr);
+			else
+				ret = -ENODEV;
+			addr += HPAGE_PMD_SIZE;
+			break;
+		case MADV_PROMOTEHUGEPUDPAGE:
+			haddr = addr & HPAGE_PUD_MASK;
+			if (haddr >= start && (haddr + HPAGE_PUD_SIZE) <= end)
+				promote_huge_pud_page_address(vma, haddr);
+			else
+				ret = -ENODEV;
+			addr += HPAGE_PUD_SIZE;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 #ifdef CONFIG_MEMORY_FAILURE
 /*
  * Error injection support for memory error handling.
@@ -708,6 +797,15 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	case MADV_MEMDEFRAG:
 	case MADV_NOMEMDEFRAG:
 		return madvise_memdefrag(vma, prev, start, end, behavior);
+	case MADV_SPLITHUGEPAGE:
+	case MADV_PROMOTEHUGEPAGE:
+	case MADV_SPLITHUGEMAP:
+	case MADV_PROMOTEHUGEMAP:
+	case MADV_SPLITHUGEPUDPAGE:
+	case MADV_PROMOTEHUGEPUDPAGE:
+	case MADV_SPLITHUGEPUDMAP:
+	case MADV_PROMOTEHUGEPUDMAP:
+		return madvise_split_promote_hugepage(vma, prev, start, end, behavior);
 	default:
 		return madvise_behavior(vma, prev, start, end, behavior);
 	}
@@ -744,6 +842,14 @@ madvise_behavior_valid(int behavior)
 #endif
 	case MADV_MEMDEFRAG:
 	case MADV_NOMEMDEFRAG:
+	case MADV_SPLITHUGEPAGE:
+	case MADV_PROMOTEHUGEPAGE:
+	case MADV_SPLITHUGEMAP:
+	case MADV_PROMOTEHUGEMAP:
+	case MADV_SPLITHUGEPUDPAGE:
+	case MADV_PROMOTEHUGEPUDPAGE:
+	case MADV_SPLITHUGEPUDMAP:
+	case MADV_PROMOTEHUGEPUDMAP:
 		return true;
 
 	default:
-- 
2.20.1

