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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF9EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617B0222DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="h/T0x0Sg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BYpXmwnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393425AbfBOWJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:30 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44749 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393247AbfBOWJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:27 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BB191DC6;
        Fri, 15 Feb 2019 17:09:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=GfBeHwr04ORtg
        FLQqsnmzDHGaDVuFMi5ctYcK2NwUOA=; b=h/T0x0Sgnwu6ItOzFmOHDJZDiM14/
        vbHNXuL+4gSJ6PigtN6YNxm1GpjaxWOXwpXf1iShiLEP9fCEJZmBhEUJkblzLZ67
        PS1cAIjKw/DeJvmwIdbleMg7sfP82qDR9GoKTXr81fp3v2y+GSRmfz/lRX3zcMnj
        UMyR7/op89Haa3COGEiziTKkKAUUF5rMYfmDgy9hI0gu0Mw9AMhKkpGOKwF8ajyI
        +5ZaqbQ7tjXtDYh3bcvXz2SHehNb6wE9iKtxWGzbwt1oUIvQsRINodf1341VO97N
        VWI3cOLI+qBrAaQwStIf+NaohnTKKY1isq1H2jjq49pmXMeHMF59FZHQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=GfBeHwr04ORtgFLQqsnmzDHGaDVuFMi5ctYcK2NwUOA=; b=BYpXmwnx
        TrlidDSTsUGjyMtY5kDWNJ8bCQjZf5W6cEb/tUXA+huVciXtF1tadt/EUcckif9k
        qK7jrBRhmLDkOwogxn5OSu/4hji7B/gRUvPPzB1cJzZvfb7v47akaaZkIAZcg8/H
        spVRBd9VjFtSH0XGKqlVZzDB1AjnriIV8f+7RHw3+PBtoCEnEyNuW2RT6140Urx1
        kXPXTpP0yBwm0nB29l9Qm2H925HoddwlN/vLPWQCfsJhUx+0eUn6xsFTvO0dkBAF
        EA9UxypMExSavFefXMhyopv04NDNa6q3pyGtC7Oe1U4UGA/qg6J6c5DjqmZvYzdZ
        jeSCkvQZHh3MCw==
X-ME-Sender: <xms:lThnXPjYSIBnZ0WFJP1-Y39sfPiRqtebBPDYCVjVVqRN6Vf24kQI_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpedufe
X-ME-Proxy: <xmx:lThnXAQJOnIMUEYE_7vyspnlqB3-bybAWENPahIIKTebxqsrm7M6Zw>
    <xmx:lThnXCMTddYXSp6eN9WA9WgBdX8i9o-BKacWDwXsCtlDzIf_74-prw>
    <xmx:lThnXKnPMENzxbnUcaaO8VRYgKjJr43gx_-MDlYWSbNtTg_ktxitaw>
    <xmx:lThnXGM5c-J7WSliPisk0x0hCLjvKJHBWk9rrBU1dGRL8O_ccOktJQ>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id CAB2AE4597;
        Fri, 15 Feb 2019 17:09:23 -0500 (EST)
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
Subject: [RFC PATCH 17/31] mm: thp: split properly PMD-mapped PUD THP to PTE-mapped PUD THP.
Date:   Fri, 15 Feb 2019 14:08:42 -0800
Message-Id: <20190215220856.29749-18-zi.yan@sent.com>
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

Page count increase needs to goto the head of the PUD page.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5f83f4c5eac7..bbdbc9ae06bf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3198,7 +3198,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long haddr, bool freeze)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
+	struct page *page, *head;
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
 	bool young, write, soft_dirty, pmd_migration = false;
@@ -3285,7 +3285,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		soft_dirty = pmd_soft_dirty(old_pmd);
 	}
 	VM_BUG_ON_PAGE(!page_count(page), page);
-	page_ref_add(page, HPAGE_PMD_NR - 1);
+	head = compound_head(page);
+	page_ref_add(head, HPAGE_PMD_NR - 1);
 
 	/*
 	 * Withdraw the table only after we mark the pmd entry invalid.
-- 
2.20.1

