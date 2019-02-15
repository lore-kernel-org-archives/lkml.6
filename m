Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F876C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20C8222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="HSEJSvzK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IW1zIufo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392996AbfBOWJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:10 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55599 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390489AbfBOWJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:06 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id ED436321D;
        Fri, 15 Feb 2019 17:09:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=nAM+pSX97PAFy
        4Xg9SX78TGwNfne/lhBfg+g4IBK468=; b=HSEJSvzKRLMkcD5hknvApfMFk+Cn/
        HDJ7P16WBYgGG71vqLGXuw1xUu+Y8FQhUm6oonaWYIe1WyIo/StE1hDBWHLHo0Ye
        8q1vF6FsXAoCranG8VGu+yfTN6dnm2+B1H5PZ0klBa7jpEJbHKnJ3/yukLqlWSru
        h0rOg8pdHYdzmf9vHsrpAqnmhRPpd13DVFeOg5CMBLnIJC9bnvJOvCoNojouvMUr
        AvCkttqB9e7l3q+e6gCVE6epG7x1SP9cxOJ1nCuxC4y2F2luFF3FWS/86p43hEb9
        wRmjaTJ/YnSJ1rDC9W5UJzN50XngD8GbMuyaaCg46vLczVaEUuMGIAMsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=nAM+pSX97PAFy4Xg9SX78TGwNfne/lhBfg+g4IBK468=; b=IW1zIufo
        P1Rp8kuXE67Tqh3KSAYNhlYaB1Ycl2Q43Zc1/PrHudXg8HeBx3xW/xWanGcPMYTr
        b14z+AtBYrPr/RzAot96HpH8v2MfRpMBrPkyQImbuqiogLAVJ0Hc/+YIxdloFN6y
        B0a1+Pq4q4JU8xp68B9PQYervjKbqmL8E0he7Rz44dZh8+9TtWEE1EyaLXMDlhL1
        /iyDGgQgsNlDv1wANjkENUxTqbkynqwrZd0iFz6TKziR59XD23vBU535MOYHRxk6
        9FhvfOqjVBEXPY/a6BKDgBYGDntsZj7BhrSTNI2oD6fsYb88pCQwri8IUJv3aVB5
        vai1AtbF8ZHCrw==
X-ME-Sender: <xms:gDhnXPbQPnXETzhTqB0jBaw01sE4_ArLHqgeYCGxIXzdLG5jm9p8SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpedu
X-ME-Proxy: <xmx:gDhnXJa1lsIQXibQCjRPXNdYYO1KGPEDLfJFmUlqyhsExeEQxVeyqg>
    <xmx:gDhnXGaqW71NAc7aljBikLbTBOEGOhVMx6QC1fA4g1umhYdXKTSYYQ>
    <xmx:gDhnXGLbcSJYUQNsHSq-45R4YMXE8XWYzODNtrPZuqQpip2BD4SVdA>
    <xmx:gDhnXPV0quu7T2jNypLeayXvx-UAukc5OTJUuJJk2QgpbvPsD8iFog>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id DCB4CE462B;
        Fri, 15 Feb 2019 17:09:02 -0500 (EST)
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
Subject: [RFC PATCH 02/31] mm: migrate: Add THP exchange support.
Date:   Fri, 15 Feb 2019 14:08:27 -0800
Message-Id: <20190215220856.29749-3-zi.yan@sent.com>
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

Add support for exchange between two THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/exchange.c | 47 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/mm/exchange.c b/mm/exchange.c
index a607348cc6f4..8cf286fc0f10 100644
--- a/mm/exchange.c
+++ b/mm/exchange.c
@@ -48,7 +48,8 @@ struct page_flags {
 	unsigned int page_swapcache:1;
 	unsigned int page_writeback:1;
 	unsigned int page_private:1;
-	unsigned int __pad:3;
+	unsigned int page_doublemap:1;
+	unsigned int __pad:2;
 };
 
 
@@ -125,20 +126,23 @@ static void exchange_huge_page(struct page *dst, struct page *src)
 static void exchange_page_flags(struct page *to_page, struct page *from_page)
 {
 	int from_cpupid, to_cpupid;
-	struct page_flags from_page_flags, to_page_flags;
+	struct page_flags from_page_flags = {0}, to_page_flags = {0};
 	struct mem_cgroup *to_memcg = page_memcg(to_page),
 					  *from_memcg = page_memcg(from_page);
 
 	from_cpupid = page_cpupid_xchg_last(from_page, -1);
 
-	from_page_flags.page_error = TestClearPageError(from_page);
+	from_page_flags.page_error = PageError(from_page);
+	if (from_page_flags.page_error)
+		ClearPageError(from_page);
 	from_page_flags.page_referenced = TestClearPageReferenced(from_page);
 	from_page_flags.page_uptodate = PageUptodate(from_page);
 	ClearPageUptodate(from_page);
 	from_page_flags.page_active = TestClearPageActive(from_page);
 	from_page_flags.page_unevictable = TestClearPageUnevictable(from_page);
 	from_page_flags.page_checked = PageChecked(from_page);
-	ClearPageChecked(from_page);
+	if (from_page_flags.page_checked)
+		ClearPageChecked(from_page);
 	from_page_flags.page_mappedtodisk = PageMappedToDisk(from_page);
 	ClearPageMappedToDisk(from_page);
 	from_page_flags.page_dirty = PageDirty(from_page);
@@ -148,18 +152,22 @@ static void exchange_page_flags(struct page *to_page, struct page *from_page)
 	clear_page_idle(from_page);
 	from_page_flags.page_swapcache = PageSwapCache(from_page);
 	from_page_flags.page_writeback = test_clear_page_writeback(from_page);
+	from_page_flags.page_doublemap = PageDoubleMap(from_page);
 
 
 	to_cpupid = page_cpupid_xchg_last(to_page, -1);
 
-	to_page_flags.page_error = TestClearPageError(to_page);
+	to_page_flags.page_error = PageError(to_page);
+	if (to_page_flags.page_error)
+		ClearPageError(to_page);
 	to_page_flags.page_referenced = TestClearPageReferenced(to_page);
 	to_page_flags.page_uptodate = PageUptodate(to_page);
 	ClearPageUptodate(to_page);
 	to_page_flags.page_active = TestClearPageActive(to_page);
 	to_page_flags.page_unevictable = TestClearPageUnevictable(to_page);
 	to_page_flags.page_checked = PageChecked(to_page);
-	ClearPageChecked(to_page);
+	if (to_page_flags.page_checked)
+		ClearPageChecked(to_page);
 	to_page_flags.page_mappedtodisk = PageMappedToDisk(to_page);
 	ClearPageMappedToDisk(to_page);
 	to_page_flags.page_dirty = PageDirty(to_page);
@@ -169,6 +177,7 @@ static void exchange_page_flags(struct page *to_page, struct page *from_page)
 	clear_page_idle(to_page);
 	to_page_flags.page_swapcache = PageSwapCache(to_page);
 	to_page_flags.page_writeback = test_clear_page_writeback(to_page);
+	to_page_flags.page_doublemap = PageDoubleMap(to_page);
 
 	/* set to_page */
 	if (from_page_flags.page_error)
@@ -195,6 +204,8 @@ static void exchange_page_flags(struct page *to_page, struct page *from_page)
 		set_page_young(to_page);
 	if (from_page_flags.page_is_idle)
 		set_page_idle(to_page);
+	if (from_page_flags.page_doublemap)
+		SetPageDoubleMap(to_page);
 
 	/* set from_page */
 	if (to_page_flags.page_error)
@@ -221,6 +232,8 @@ static void exchange_page_flags(struct page *to_page, struct page *from_page)
 		set_page_young(from_page);
 	if (to_page_flags.page_is_idle)
 		set_page_idle(from_page);
+	if (to_page_flags.page_doublemap)
+		SetPageDoubleMap(from_page);
 
 	/*
 	 * Copy NUMA information to the new page, to prevent over-eager
@@ -280,6 +293,7 @@ static int exchange_page_move_mapping(struct address_space *to_mapping,
 
 	VM_BUG_ON_PAGE(to_mapping != page_mapping(to_page), to_page);
 	VM_BUG_ON_PAGE(from_mapping != page_mapping(from_page), from_page);
+	VM_BUG_ON(PageCompound(from_page) != PageCompound(to_page));
 
 	if (!to_mapping) {
 		/* Anonymous page without mapping */
@@ -600,7 +614,6 @@ static int unmap_and_exchange(struct page *from_page,
 	to_mapping = to_page->mapping;
 	from_index = from_page->index;
 	to_index = to_page->index;
-
 	/*
 	 * Corner case handling:
 	 * 1. When a new swap-cache page is read into, it is added to the LRU
@@ -691,6 +704,23 @@ static int unmap_and_exchange(struct page *from_page,
 	return rc;
 }
 
+static bool can_be_exchanged(struct page *from, struct page *to)
+{
+	if (PageCompound(from) != PageCompound(to))
+		return false;
+
+	if (PageHuge(from) != PageHuge(to))
+		return false;
+
+	if (PageHuge(from) || PageHuge(to))
+		return false;
+
+	if (compound_order(from) != compound_order(to))
+		return false;
+
+	return true;
+}
+
 /*
  * Exchange pages in the exchange_list
  *
@@ -751,9 +781,8 @@ static int exchange_pages(struct list_head *exchange_list,
 			continue;
 		}
 
-		/* TODO: compound page not supported */
 		/* to_page can be file-backed page  */
-		if (PageCompound(from_page) ||
+		if (!can_be_exchanged(from_page, to_page) ||
 			page_mapping(from_page)
 			) {
 			++failed;
-- 
2.20.1

