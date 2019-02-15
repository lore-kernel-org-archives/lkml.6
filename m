Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8CDC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3E8222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="VFUKyEKq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9R6iOLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393487AbfBOWJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:37 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34827 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393452AbfBOWJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3178C3058;
        Fri, 15 Feb 2019 17:09:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=Mql9ve4UDV93V
        XmSDRn0eYbPSMabzYnGVtBZe6Hc3wQ=; b=VFUKyEKqzz/0iG/0dF5ekrZ9RwQod
        gNG5oHcb2NvSIDd+Rl9isNZlF5VgGKlJ4Olj2aicC4M/9Sn+EoR7fV4DQl3SJUd2
        DgWLETjIDsPKPR0OUdEJEURAHMG0FexsIKnOZEuuAZtaZ+xk94F2LsZlJwoKiiMV
        UUR3X1EpJwT2JHKKicMLPPi6+H7Y3yvc2EZZLXndyFSkRwVsMwKGNOnxV6fldG4e
        DApV/ZDSmQmUpI90aeLEYN8aFquAr0SUpa0Swn8154uPWdbzgcyeXBQnYqf3tE1o
        kC5+4JN2B8jhE3zm9mTPJ9n7dgz3QEHhYXy4DI9j9Zmn4a5fH3nRfAKdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Mql9ve4UDV93VXmSDRn0eYbPSMabzYnGVtBZe6Hc3wQ=; b=L9R6iOLb
        +1fx/XQVSYC4Jd+HRI9FMFrNQAJ2x8avz1sCrPrCicNu0wDk/XmNq/CojPSXTl6X
        wmQUTCjl7MEjMlmBz2jvN95txuTU8IxNOVLmOhE9GJdpdevWQnli7p6mG0hudAu4
        vaOcgB6DH6XFpX0/6PGv1OM/aDZbokapTVvm/+wjJ8oz4DOvHKBYxpEzCp8SYAso
        6Li+nN4pM7dz9276IONc2xX7cfy3hx4fgp7dqL0RT14bIqQNLZxtjxKzxo15MD8t
        1r/EZwsP3oCmVrgSCsSYMwkmnr9SiNju/BV2HYNBSi4HVaBwle/5G/hqxWO7Fukd
        HCEMDHd5Idjofg==
X-ME-Sender: <xms:mjhnXMhAmy0Q38rW25Xj3yD_CdXtTRIyMbV7aSgKtcEqKd1EZipa4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpeduke
X-ME-Proxy: <xmx:mjhnXNSPK37oj3EgRoxtOjUP2sfkxTRERr3cZAwPTe7M5StISaUjyw>
    <xmx:mjhnXJ8FEkmO8r-0STCXp1RbnqXeNUgEeKLoeN6B3mS0BGOKgeM_aw>
    <xmx:mjhnXO9ap9nvDo3Vvs-bvZlmklcK8W48My1w-yOXp0rrTNqhJl5xdQ>
    <xmx:mjhnXCVsKR8ZuGMK0UBH_gWlspQx5BTgUE6eIRH1O7L2Og6W9NG07g>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 37CFEE46AD;
        Fri, 15 Feb 2019 17:09:29 -0500 (EST)
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
Subject: [RFC PATCH 21/31] mm: thp: 1GB zero page shrinker.
Date:   Fri, 15 Feb 2019 14:08:46 -0800
Message-Id: <20190215220856.29749-22-zi.yan@sent.com>
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

Remove 1GB zero page when we are under memory pressure.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bbdbc9ae06bf..41adc103ead1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -207,6 +207,32 @@ static struct shrinker huge_zero_page_shrinker = {
 	.seeks = DEFAULT_SEEKS,
 };
 
+static unsigned long shrink_huge_pud_zero_page_count(struct shrinker *shrink,
+					struct shrink_control *sc)
+{
+	/* we can free zero page only if last reference remains */
+	return atomic_read(&huge_pud_zero_refcount) == 1 ? HPAGE_PUD_NR : 0;
+}
+
+static unsigned long shrink_huge_pud_zero_page_scan(struct shrinker *shrink,
+				       struct shrink_control *sc)
+{
+	if (atomic_cmpxchg(&huge_pud_zero_refcount, 1, 0) == 1) {
+		struct page *zero_page = xchg(&huge_pud_zero_page, NULL);
+		BUG_ON(zero_page == NULL);
+		__free_pages(zero_page, compound_order(zero_page));
+		return HPAGE_PUD_NR;
+	}
+
+	return 0;
+}
+
+static struct shrinker huge_pud_zero_page_shrinker = {
+	.count_objects = shrink_huge_pud_zero_page_count,
+	.scan_objects = shrink_huge_pud_zero_page_scan,
+	.seeks = DEFAULT_SEEKS,
+};
+
 #ifdef CONFIG_SYSFS
 static ssize_t enabled_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *buf)
@@ -474,6 +500,9 @@ static int __init hugepage_init(void)
 	err = register_shrinker(&huge_zero_page_shrinker);
 	if (err)
 		goto err_hzp_shrinker;
+	err = register_shrinker(&huge_pud_zero_page_shrinker);
+	if (err)
+		goto err_hpzp_shrinker;
 	err = register_shrinker(&deferred_split_shrinker);
 	if (err)
 		goto err_split_shrinker;
@@ -496,6 +525,8 @@ static int __init hugepage_init(void)
 err_khugepaged:
 	unregister_shrinker(&deferred_split_shrinker);
 err_split_shrinker:
+	unregister_shrinker(&huge_pud_zero_page_shrinker);
+err_hpzp_shrinker:
 	unregister_shrinker(&huge_zero_page_shrinker);
 err_hzp_shrinker:
 	khugepaged_destroy();
-- 
2.20.1

