Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE52DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92346222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="hFnIT5Aa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z2stXGOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393730AbfBOWKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:10:34 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33589 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393430AbfBOWJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:31 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E1B5F3016;
        Fri, 15 Feb 2019 17:09:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=FiyxBlqHBRuB2
        dgup3XVTlpHV28/2P36o4TG2N7q4n0=; b=hFnIT5Aat3OtrEQ7DS0ABokwDm7No
        icKjz/BCt4fW+B1LJ53VLZSVtGhx2aG21Ih+xGdu3cBOeP+aNsa6Ltg3S0b/Eifq
        BAM7u0GnDA/GCY5jdC1FxPfjAudYFw5krumJHia8w1KMtT79XeF4XArd3qLciYug
        NHUmio3kvhCaYEhvBLET1sr/O2TJ+AYaKglEqFeyv+q8Y3OyBJfs/MmG1s11HvvE
        Qp9E18dNYbA6G3yvEm2bRBWpGY3C70hpMIiqOK79Rq4Ds8JRrb1qEZnNnb6w7T0i
        sfpxQteCPfRvQNNveQ6HtH9DJRzc8Ad119wrS8k+hntA535W1Dx2YryCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=FiyxBlqHBRuB2dgup3XVTlpHV28/2P36o4TG2N7q4n0=; b=Z2stXGOb
        xyQ1GRz0Xeoz+I9aOw0h8VR+Trx0R8H8QeDTCpaSKrOh4qRuSIKzrtbycQvB+zGC
        ohXuOdMde935KPdEXb30mdfJO8RRbL4FM3h8m6IPZJQ9piyMKj+LBlSXnHkKHIC2
        Gah9RCajQGpw5xGxy+lImBmALr/jeGhxTIiwCSnTsgVX5N9XzYSFyqi3D6s0cQg5
        KOjDmbtBKjIR1TLHXRFOXoqacLhQLVGRQAErPPUkKuLgCDdlnyspfSUVqqejgI0Q
        wud5qwmWHG0qNtyIWvcVNUXt/0rm70V8rHobvUFksSdmzi15BFYnxifYNT5hI5rS
        7hghfTL5RfIuFQ==
X-ME-Sender: <xms:mThnXDYKynMq3H5k2tdVpbnREZQ0UG6CKgeLodIoyTFNNXSvL-gBPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpeduke
X-ME-Proxy: <xmx:mThnXJjjlz2YUjyApg7fmZy5ZAMo-uTdwyjpAARqwLL1kTlF5l4xAw>
    <xmx:mThnXIRO3hM9wiMK6fHtE014tEJxjs6TWZlM0yN9_ubctT5t6ql9kg>
    <xmx:mThnXCapI6MrrUcQyHLkdXnw1NLgXc9C3rAMM9wdkcS-vbL6T1I74g>
    <xmx:mThnXOGKx--YjXMjd1YuyRbvbXhPghtY6QwFrxsScUj-OWWjTWAO0w>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id D59AAE462B;
        Fri, 15 Feb 2019 17:09:27 -0500 (EST)
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
Subject: [RFC PATCH 20/31] mm: thp: split 1GB THPs at page reclaim.
Date:   Fri, 15 Feb 2019 14:08:45 -0800
Message-Id: <20190215220856.29749-21-zi.yan@sent.com>
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

We cannot swap 1GB THPs, so split them before swap them out.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/swap_slots.c |  2 ++
 mm/vmscan.c     | 55 ++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 63a7b4563a57..797c804ff905 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -315,6 +315,8 @@ swp_entry_t get_swap_page(struct page *page)
 	entry.val = 0;
 
 	if (PageTransHuge(page)) {
+		if (compound_order(page) == HPAGE_PUD_ORDER)
+			return entry;
 		if (IS_ENABLED(CONFIG_THP_SWAP))
 			get_swap_pages(1, &entry, HPAGE_PMD_NR);
 		goto out;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a714c4f800e9..a2a91c1d3dae 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1288,25 +1288,47 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				if (!(sc->gfp_mask & __GFP_IO))
 					goto keep_locked;
 				if (PageTransHuge(page)) {
-					/* cannot split THP, skip it */
-					if (!can_split_huge_page(page, NULL))
-						goto activate_locked;
-					/*
-					 * Split pages without a PMD map right
-					 * away. Chances are some or all of the
-					 * tail pages can be freed without IO.
-					 */
-					if (!compound_mapcount(page) &&
-					    split_huge_page_to_list(page,
-								    page_list))
+					if (compound_order(page) == HPAGE_PUD_ORDER) {
+						/* cannot split THP, skip it */
+						if (!can_split_huge_pud_page(page, NULL))
+							goto activate_locked;
+						/*
+						 * Split pages without a PMD map right
+						 * away. Chances are some or all of the
+						 * tail pages can be freed without IO.
+						 */
+						if (!compound_mapcount(page) &&
+							split_huge_pud_page_to_list(page,
+										page_list))
+							goto activate_locked;
+					}
+					if (compound_order(page) == HPAGE_PMD_ORDER) {
+						/* cannot split THP, skip it */
+						if (!can_split_huge_page(page, NULL))
+							goto activate_locked;
+						/*
+						 * Split pages without a PMD map right
+						 * away. Chances are some or all of the
+						 * tail pages can be freed without IO.
+						 */
+						if (!compound_mapcount(page) &&
+							split_huge_page_to_list(page,
+										page_list))
+							goto activate_locked;
+					}
+				}
+				if (compound_order(page) == HPAGE_PUD_ORDER) {
+					if (split_huge_pud_page_to_list(page,
+									page_list))
 						goto activate_locked;
 				}
 				if (!add_to_swap(page)) {
 					if (!PageTransHuge(page))
 						goto activate_locked;
 					/* Fallback to swap normal pages */
+					VM_BUG_ON_PAGE(compound_order(page) != HPAGE_PMD_ORDER, page);
 					if (split_huge_page_to_list(page,
-								    page_list))
+									page_list))
 						goto activate_locked;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 					count_vm_event(THP_SWPOUT_FALLBACK);
@@ -1321,6 +1343,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				mapping = page_mapping(page);
 			}
 		} else if (unlikely(PageTransHuge(page))) {
+			VM_BUG_ON_PAGE(compound_order(page) != HPAGE_PMD_ORDER, page);
 			/* Split file THP */
 			if (split_huge_page_to_list(page, page_list))
 				goto keep_locked;
@@ -1333,8 +1356,12 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		if (page_mapped(page)) {
 			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
 
-			if (unlikely(PageTransHuge(page)))
-				flags |= TTU_SPLIT_HUGE_PMD;
+			if (unlikely(PageTransHuge(page))) {
+				if (compound_order(page) == HPAGE_PMD_ORDER)
+					flags |= TTU_SPLIT_HUGE_PMD;
+				else if (compound_order(page) == HPAGE_PUD_ORDER)
+					flags |= TTU_SPLIT_HUGE_PUD;
+			}
 			if (!try_to_unmap(page, flags)) {
 				nr_unmap_fail++;
 				goto activate_locked;
-- 
2.20.1

