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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA83C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69707222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="GQS/bI26";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s6OKUXHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393382AbfBOWJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:28 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48985 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393322AbfBOWJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:26 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6A54F31CA;
        Fri, 15 Feb 2019 17:09:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=r9i3vSlxWDPju
        GqrZdOfoK2Xh9axnIDanzNb86muQ/I=; b=GQS/bI26wmmBEUSWTQc1KDie06qmf
        dHHS6bcITudgOzKWqJm+bTQa3Yn9q/a8KZZie2M7okmXpoNg4mPOmHJnTgZEapT4
        BgXIhIm7O+Lxd+tFgWjRjyP2bFFU0X80GNp5O0liDYXW1PmjqBctKETvUOk/IQli
        oZ39kVtke9F4FjDhff4fN2MeHyDTPMN8V1P9kNVhs1G5HR0RD7IC1f+Dbmj6iONa
        +BoWnCBMscCLCtTJF34/l8cKOadaYaJp3bRsCGvfZB+NYghl07+fuNL1KTPUdzxZ
        6B8Kn245uznBC8SaduoZVmlsGRYOVR+WTD8si2rtIZe4oY1a1+RKQsMrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=r9i3vSlxWDPjuGqrZdOfoK2Xh9axnIDanzNb86muQ/I=; b=s6OKUXHN
        jGHg3CnPH6ajnJDQiWl02z+FyKMZpcL3YW6nPFe0amZCViM856OiTgK5pKfVti7r
        yqzFmInVcouPviwuKTx0+TdplJVscLvUVrUFEcHm5LezqdWiznR32XB6XeKF8kld
        YOoT/HYs1pnx3VlLFcUm8qT0Qt96R1JHEPwyvZXcfgZQPWEe9juedl+5bh3xVeCG
        5W5lAYTWYuFwc1DwqPXI8gRPD+PdVcklgNhWCcQke7AovVLMaz/JklW5MCjf5cVP
        9q6EQN3eNeKRoJjGnCeLLXuvF7C6o/YdyEtuW88Nac7btKprHbwSCXQa5+7FXEV5
        /9xgaAJ/UhxJ1Q==
X-ME-Sender: <xms:kzhnXCGkeqKF5j47MmAuN2m-J83awpjWIjiTX_b1Gc7sy1WFAQ3Qwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpedufe
X-ME-Proxy: <xmx:kzhnXE2k4AtCSNnuNV3Zhg1DQEwcjp5Wk7DoHituV80d34A1BW-axQ>
    <xmx:kzhnXEyxV9R5CCP_oaOtKRTx-4nItHPNyA_MxS0hz-ep32kM0a88qg>
    <xmx:kzhnXOHXCdL6FoORRs_bxd70H253rk2Aznc6BD1NNASr6RIzaJgvVw>
    <xmx:lDhnXI4zKei7BqJSiy7WUR3Sx2LXfGihVcj7xrDm9FFEJwpvou0eEA>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 74384E462B;
        Fri, 15 Feb 2019 17:09:22 -0500 (EST)
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
Subject: [RFC PATCH 16/31] mm: thp: check compound_mapcount of PMD-mapped PUD THPs at free time.
Date:   Fri, 15 Feb 2019 14:08:41 -0800
Message-Id: <20190215220856.29749-17-zi.yan@sent.com>
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

PMD mappings on a PUD THP should be zero when the page is freed.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dbcccc022b30..b87a2ca0a97c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1007,8 +1007,10 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 		/* sub_compound_map_ptr store here */
 		if (compound_order(head_page) == HPAGE_PUD_ORDER &&
 			(page - head_page) % HPAGE_PMD_NR == 3) {
-			if (unlikely(atomic_read(&page->compound_mapcount) != -1))
+			if (unlikely(atomic_read(&page->compound_mapcount) != -1)) {
+				pr_err("sub_compound_mapcount: %d\n", atomic_read(&page->compound_mapcount) + 1);
 				bad_page(page, "nonzero sub_compound_mapcount", 0);
+			}
 			break;
 		}
 		if (page->mapping != TAIL_MAPPING) {
-- 
2.20.1

