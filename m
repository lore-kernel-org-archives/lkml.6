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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EA2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B20B222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="LMQQ6Foj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OIv/vxn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393779AbfBOWLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:11:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36083 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393204AbfBOWJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:19 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7BBD7310A;
        Fri, 15 Feb 2019 17:09:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=s+M9Q1Dn/74r7
        Hqs3gLQcg1STi/Xk0kU2xFV7ZybJ5M=; b=LMQQ6FojPBEWUxYcZyupLkHS7Gi6/
        lCmVLgDcfuWz9E42THOfhFiodqUK9AGh/8qXtf2Oz92BOz8GBlswGNkO10eAsI8p
        MnPC+Z6phDvGEVAQJx3NS0hZBEIrm+Zykik8xVKRicMjNuMx/Q5Pseh/BkMkdOPE
        mVyJTbEZepYPiFmRSwzOYwIyafdxqPSjfy8tMAvmCxtYnm+Y5m7FfyqLmSfsD7be
        gHmAJQ+E9QlOo7671DKVipxixMf2koJcueOM/TJhVPBR2JG35KIyWX93ehf6wXz+
        HmTH5oKrFuZVcMTORI4XtdgikLmA6D3ixeLcAvtgo6XjQ+Wyo8Olt3AEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=s+M9Q1Dn/74r7Hqs3gLQcg1STi/Xk0kU2xFV7ZybJ5M=; b=OIv/vxn8
        z8uHrE0XwEs5J3iyx9QT7uKYL6ToBVMAWN5DFv8SVn3iTZNUSJa8TdtF/FnfxOuW
        ydrpe04VTkGrfL2oJenrQ5PVE1XQ0mc5KNg3vxskG6exsbG63ILI6X+rRapRgWHH
        WaHKW16CkiQF1x7giugKKyZPqsUr9bh2OQTSCV7JPYHe/CwzqTd+aNnYtMASt+vs
        HLA4JPfbL8CjOvnHUBvbESMGVjEzXx4Ar7HNpQl+4aggb0Gyi2rJXOu0E8F2cZ1T
        4tU6/j3coPB5+DfUjENijh2Nd+dv0CucbaI06/1vRIFVfLjSTxVRasibOPW5C5gr
        OLmyU8z8PTtlAg==
X-ME-Sender: <xms:jDhnXBCcq1om_2qetgpMaysLFy25EP24mNfLi1FrawSH3G4DmaAtZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpeel
X-ME-Proxy: <xmx:jDhnXJlFYof067REGB9rlsC2amOjXGIKIobFc_GXDpJeS29aY-Lvlw>
    <xmx:jDhnXLozpyq_wKigPm5JLVtE3CgxRON_INRvmMBAWUCvE6vxgHJINQ>
    <xmx:jDhnXD6VjRIjEv5oawlrTA6Zchmp3QzFpVexlg8959mVhH7F6-2KqQ>
    <xmx:jThnXNZATm-XiCR9VxyMSGa5OKynws_2l_gCJuikAmxKVfn9sgPIEQ>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 922BBE4511;
        Fri, 15 Feb 2019 17:09:15 -0500 (EST)
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
Subject: [RFC PATCH 11/31] mm: debug: print compound page order in dump_page().
Date:   Fri, 15 Feb 2019 14:08:36 -0800
Message-Id: <20190215220856.29749-12-zi.yan@sent.com>
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

Since we have more than just PMD-level THPs, printing compound page
order is helpful to check the actual compound page sizes.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/debug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 0abb987dad9b..21d211d7776c 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -68,8 +68,12 @@ void __dump_page(struct page *page, const char *reason)
 	pr_warn("page:%px count:%d mapcount:%d mapping:%px index:%#lx",
 		  page, page_ref_count(page), mapcount,
 		  page->mapping, page_to_pgoff(page));
-	if (PageCompound(page))
-		pr_cont(" compound_mapcount: %d", compound_mapcount(page));
+	if (PageCompound(page)) {
+		struct page *head = compound_head(page);
+
+		pr_cont(" compound_mapcount: %d, order: %d", compound_mapcount(page),
+				compound_order(head));
+	}
 	pr_cont("\n");
 	if (PageAnon(page))
 		pr_warn("anon ");
-- 
2.20.1

