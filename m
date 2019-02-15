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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA212C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C819222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="JGI4HvBY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7LBY7jFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393549AbfBOWJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:45 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53057 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393469AbfBOWJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:42 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BCE9F32A2;
        Fri, 15 Feb 2019 17:09:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=shCZ1iSGYyBc0
        QtOy4OOg2NHBqv6Cu7B1aYGh3Lj914=; b=JGI4HvBYMMqsmw33Ld98dJrsDB1V9
        eA5YY/5aymibWj3GCK2ZBnkSanqlVNR9KcGe5P7tk9qq5GnUifO5nV4HwD6wMY2O
        TnBHiA/MCr6o2UrwKCfJ1MXqTmx+l5fWXalUKXfMUFPf8VhAtmXWak99iVu9TCmW
        swFXWRKzblPSqu4RhbrqErajr+wH09P7q2M+A+vYMWc8eDq5sHwSy5Nls1Zj9DMU
        pLTQ4BJ+KVGl5yZ2h1mNF+O6I8Yb2HQJBTnPEYWC3PrA8UIOZSuddQGia+euS1EN
        9Y8hsOSKtNwrR0AbF5AB02bfXkPOSlxpwPs9qRxF6A+N1EtUy0T3cNyrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=shCZ1iSGYyBc0QtOy4OOg2NHBqv6Cu7B1aYGh3Lj914=; b=7LBY7jFR
        gIXY6xtbU8OGarWtbnuAaiWCo3dFDFVQQca/BX7rdBvGPfSMGieDPVc+0gFJYRs9
        Qk8EagwAb2TOX8lPvaaM1i7Zv2S+p9yD+OdQk2WNOEd0l+GygVYDeLLUwRlEcdYK
        dAKMV/snTNYp0A/YZpwmkWpklS6NzZ+ZLx3EwSwkMkDXYga01k5bYx8CD55L0dOW
        QtPUJ1HH95ud2bOfeHcsJTQmQJUqSw/NEOwWic2VVNl9VlbYiE7MTxwwVxpe1bxT
        JMUPhQJNgHOjFbuxVTcIk7lADUi6wNskAEv9KyWnh4lq25C388QU4nqzPjx2Iy5N
        y3GoeqFHYM4kAw==
X-ME-Sender: <xms:pDhnXKrRFL8VIJyRZvlNReKemazB5HYZmnQTlTaoi0qIfVNL28uiFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:pDhnXEFPihNU3cGKFL_WYX3erm0h-tMJQWfkASfvF-NaGWS2iPktvQ>
    <xmx:pDhnXCs474p7ILWXnQzXTpKEDTtNfZyJN_UBJt23OwcDFkfhLmH3Yg>
    <xmx:pDhnXOVyIkG9OELuH1C1tIRuLgok9u4U-bzZEVTCPBoCYMmKbu-91A>
    <xmx:pDhnXGsmXe54iYI0JhDwdCqtCbIiA5bNFcpnwa76Nop_ymZyuENOKQ>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id C30E4E4511;
        Fri, 15 Feb 2019 17:09:38 -0500 (EST)
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
Subject: [RFC PATCH 28/31] mm: vmstats: add page promotion stats.
Date:   Fri, 15 Feb 2019 14:08:53 -0800
Message-Id: <20190215220856.29749-29-zi.yan@sent.com>
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

Count all four types of page promotion.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/vm_event_item.h | 4 ++++
 mm/huge_memory.c              | 8 ++++++++
 mm/vmstat.c                   | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index df619262b1b4..f352e5cbfc9c 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -81,6 +81,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_SPLIT_PAGE_FAILED,
 		THP_DEFERRED_SPLIT_PAGE,
 		THP_SPLIT_PMD,
+		THP_PROMOTE_PMD,
+		THP_PROMOTE_PAGE,
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 		THP_FAULT_ALLOC_PUD,
 		THP_FAULT_FALLBACK_PUD,
@@ -89,6 +91,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_SPLIT_PUD_PAGE_FAILED,
 		THP_ZERO_PUD_PAGE_ALLOC,
 		THP_ZERO_PUD_PAGE_ALLOC_FAILED,
+		THP_PROMOTE_PUD,
+		THP_PROMOTE_PUD_PAGE,
 #endif
 		THP_ZERO_PAGE_ALLOC,
 		THP_ZERO_PAGE_ALLOC_FAILED,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 67fd1821f4dc..911463c98bcc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4403,6 +4403,8 @@ int promote_huge_pmd_address(struct vm_area_struct *vma, unsigned long haddr)
 out_unlock:
 	anon_vma_unlock_write(vma->anon_vma);
 out:
+	if (!ret)
+		count_vm_event(THP_PROMOTE_PMD);
 	return ret;
 }
 
@@ -4644,6 +4646,8 @@ int promote_list_to_huge_page(struct page *head, struct list_head *list)
 		put_anon_vma(anon_vma);
 	}
 out:
+	if (!ret)
+		count_vm_event(THP_PROMOTE_PAGE);
 	return ret;
 }
 
@@ -4842,6 +4846,8 @@ int promote_huge_pud_address(struct vm_area_struct *vma, unsigned long haddr)
 out_unlock:
 	anon_vma_unlock_write(vma->anon_vma);
 out:
+	if (!ret)
+		count_vm_event(THP_PROMOTE_PUD);
 	return ret;
 }
 
@@ -5169,6 +5175,8 @@ int promote_list_to_huge_pud_page(struct page *head, struct list_head *list)
 		unlock_page(p);
 		putback_lru_page(p);
 	}
+	if (!ret)
+		count_vm_event(THP_PROMOTE_PUD_PAGE);
 	return ret;
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1d185cf748a6..7dd1ff5805ef 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1259,6 +1259,8 @@ const char * const vmstat_text[] = {
 	"thp_split_page_failed",
 	"thp_deferred_split_page",
 	"thp_split_pmd",
+	"thp_promote_pmd",
+	"thp_promote_page",
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 	"thp_fault_alloc_pud",
 	"thp_fault_fallback_pud",
@@ -1267,6 +1269,8 @@ const char * const vmstat_text[] = {
 	"thp_split_pud_page_failed",
 	"thp_zero_pud_page_alloc",
 	"thp_zero_pud_page_alloc_failed",
+	"thp_promote_pud",
+	"thp_promote_pud_page",
 #endif
 	"thp_zero_page_alloc",
 	"thp_zero_page_alloc_failed",
-- 
2.20.1

