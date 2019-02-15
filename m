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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1C6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04214222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="H7QS7MH5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="COCQw14/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393117AbfBOWJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:16 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:60311 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392904AbfBOWJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:13 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B9B8F3299;
        Fri, 15 Feb 2019 17:09:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=YB7G8kYGI8bRn
        BYacSSGAZcz9slxKgMGLPhOLzrEt8M=; b=H7QS7MH59u8xwucq0Z1GHNPXlaQRC
        FHeYGCF1tAMxxXP403wg/3pcu+/Qod0JH10zVxAksBVNfZokneF7fPoWXeikvNBF
        iH6blrzJNdL3s1JvOgRHKdzOfP/PgsVcoIjflgyuzwwG++f7WuSfQUXjy9KO5GND
        WV0oWxdRZqahNjyVEPk0miHYhtF9HcRWQuQ1uxn+filUOUAf24WLtoBGwqU5+IHv
        bGptQory6nGB3qjJGbu30AcQ94zmv4OegwV/mOo5oO7imkgnh6W/yVzHlthZ7Qij
        l+Yn6h5uDHJDeuUM0kJZJdlQ3LiBkTGODdWgnaKTvxpQ2Tgc0KP/xAhrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=YB7G8kYGI8bRnBYacSSGAZcz9slxKgMGLPhOLzrEt8M=; b=COCQw14/
        OnB2gMlAGBaEv2afOVWzIFuk76BGlb4G/8ob3jmC8kdWDb3wM/OULj/7wB2jRCRl
        DWsRFMwU71vAmreUChlz7cUU8S+4CYjlwNnXBRS/B/9agl6rlHaF72VmKkOtSIUi
        ca6bFjH0vbxC+jHeE5+alLiihoAMbp0WnVysOCB71tJx2l86dXNFbq4NnB1rHfnz
        +0RwROQ4V/xM1lKxz3zE1SyW5lZvMDJKjJQVIjIuLIQqihCEcNHAoVEKgnuI/0pZ
        chLn0SG84GIKVqYSCApaFt2y5ulkKk7q0f4OA9gWEf7DkuMUpJdSfe7IlX5lm0m7
        z4JhtXzq2GAmEw==
X-ME-Sender: <xms:hzhnXL69dlxmbrI0m-3ynuD-L0T_lazgElZ9QPDNlOYUJpRwicB9cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpeeh
X-ME-Proxy: <xmx:hzhnXHPGmE_54ehQ-iGCAsWDrmx7-rGWr1beaU4hfP-RzIfOhcWoAA>
    <xmx:hzhnXIdG6MMGeTPFrAQQyrVmbufoybYBS7ixtxxIF82DFQUI9eJ54A>
    <xmx:hzhnXJfys44KqfuFyUXK5plLS1mgiUfijyZv_Cl5DXm1e72rOLLBIg>
    <xmx:hzhnXPDoRW4G0LxQxWr34JfiqChaalxhp-aIEVl1mRYAp9uc9WUsyg>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id C8156E4680;
        Fri, 15 Feb 2019 17:09:09 -0500 (EST)
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
Subject: [RFC PATCH 07/31] mm: deallocate pages with order > MAX_ORDER.
Date:   Fri, 15 Feb 2019 14:08:32 -0800
Message-Id: <20190215220856.29749-8-zi.yan@sent.com>
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

When MAX_ORDER is not set to allocate 1GB pages and 1GB THPs are created
from in-place promotion, we need this to properly free 1GB THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ba2cdc320f2..cfa99bb54bd6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1287,6 +1287,24 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 	}
 }
 
+static void destroy_compound_gigantic_page(struct page *page,
+					unsigned int order)
+{
+	int i;
+	int nr_pages = 1 << order;
+	struct page *p = page + 1;
+
+	atomic_set(compound_mapcount_ptr(page), 0);
+	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
+		clear_compound_head(p);
+		set_page_refcounted(p);
+	}
+
+	set_compound_order(page, 0);
+	__ClearPageHead(page);
+	set_page_refcounted(page);
+}
+
 static void __free_pages_ok(struct page *page, unsigned int order)
 {
 	unsigned long flags;
@@ -1296,11 +1314,16 @@ static void __free_pages_ok(struct page *page, unsigned int order)
 	if (!free_pages_prepare(page, order, true))
 		return;
 
-	migratetype = get_pfnblock_migratetype(page, pfn);
-	local_irq_save(flags);
-	__count_vm_events(PGFREE, 1 << order);
-	free_one_page(page_zone(page), page, pfn, order, migratetype);
-	local_irq_restore(flags);
+	if (order > MAX_ORDER) {
+		destroy_compound_gigantic_page(page, order);
+		free_contig_range(page_to_pfn(page), 1 << order);
+	} else {
+		migratetype = get_pfnblock_migratetype(page, pfn);
+		local_irq_save(flags);
+		__count_vm_events(PGFREE, 1 << order);
+		free_one_page(page_zone(page), page, pfn, order, migratetype);
+		local_irq_restore(flags);
+	}
 }
 
 static void __init __free_pages_boot_core(struct page *page, unsigned int order)
@@ -8281,6 +8304,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	return ret;
 }
 
+#endif
+
 void free_contig_range(unsigned long pfn, unsigned nr_pages)
 {
 	unsigned int count = 0;
@@ -8293,7 +8318,6 @@ void free_contig_range(unsigned long pfn, unsigned nr_pages)
 	}
 	WARN(count != 0, "%d pages are still in use!\n", count);
 }
-#endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
-- 
2.20.1

