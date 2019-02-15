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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D80C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C193222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="a2C8a6h+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6VerkcaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404357AbfBOWK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:10:26 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37955 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393480AbfBOWJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 941633058;
        Fri, 15 Feb 2019 17:09:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=zmEt0fRNgPgER
        4hv784eatILoHkzLDvws83cRovtJ3M=; b=a2C8a6h+OCVnJPyA6br24ZDIMtT/4
        HxsvOyPtTmxUhej0NWrj8rt94TobWnKwr8i4Md7CO2HPmwnerMDTFk1o5P8SIfxv
        HxzjphrsoTN5V81L9+pk5QjxVHROeA3ld4gR49ioThnIHf6bOtwFi3EeiiwyHWP0
        TJkbwrkXWupDYaMDi05+Ev+c1owX22MCiNiJ7xegdQArMic8wgRCZrWR0PdeKzmD
        UklSeXVbM7f8JlUQEp5YNMvRUpsMTIiw/P3ATRs2co8sTX/+QmHPnvUVI4ZPMT0F
        uZCjzsaR3Yd3liQlOYFC4JyhmH9kPMRK55oiJiif5qJwEuN9j2bZAqvJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=zmEt0fRNgPgER4hv784eatILoHkzLDvws83cRovtJ3M=; b=6VerkcaJ
        /F+cDmhrn9NoTNMMQDk3BJFpVT8oJ5+ZTIE4GO2xU68JAo3Kg+zl9e420DccEsjj
        pTyVBEJm56cXk9LMVVrkQBVd9zqsrZ88uGFgOfNnFS1kY7EU54OUfGrW/zklmEGU
        WqaCi3omLfW4LCeT25oGxRQKVMXW1mPt4QYzv1/q+X5Ze/KZyYbO0fSUmLXb5SUO
        TUrt6RU8UvHx1zH1CE3w8eD3ilAkesCO74XHolmnP7dugmWMrAq9cAU8jkNCrP5i
        s0ZoydUj+27s2X+Gs0iEJeExfBjyxbWg/wDOI/szFXFJTlDzkHNGlq7XY/edWfLe
        NZOe434CAAzRcw==
X-ME-Sender: <xms:njhnXK3zBT1zZylT8NrMYVLNr6jD753u4CVCpNj3LzTiJeiMReNgyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpedvvd
X-ME-Proxy: <xmx:nzhnXA2WwCIJLPRAzxTzwS8pdyGefH-hvz-TJ0b7-YHjFJCG757FXQ>
    <xmx:nzhnXCp-OkdIA6NfvIm5wjtInXfah7X4V3pxAk7jHoMotih2QMyBog>
    <xmx:nzhnXLKKBD7PJE1ywXa7E0qIEHaIVi_D-BoNcdZXiJQwIH440NuKgg>
    <xmx:nzhnXJfEqQCC5efTYdzkbDuTIHxWCXagvJKu0wkOj2rpcf_v8-J0RA>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4491BE46AD;
        Fri, 15 Feb 2019 17:09:33 -0500 (EST)
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
Subject: [RFC PATCH 24/31] sysctl: add an option to only print the head page virtual address.
Date:   Fri, 15 Feb 2019 14:08:49 -0800
Message-Id: <20190215220856.29749-25-zi.yan@sent.com>
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

It can help distinguish between PUD-mapped, PMD-mapped THPs, and
PTE-mapped THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/task_mmu.c |  7 +++++--
 kernel/sysctl.c    | 11 +++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ccf8ce760283..5106d5a07576 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -27,6 +27,9 @@
 
 #define SEQ_PUT_DEC(str, val) \
 		seq_put_decimal_ull_width(m, str, (val) << (PAGE_SHIFT-10), 8)
+
+int only_print_head_pfn;
+
 void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
 	unsigned long text, lib, swap, anon, file, shmem;
@@ -1308,7 +1311,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 				flags |= PM_SOFT_DIRTY;
 			if (pm->show_pfn)
 				frame = pmd_pfn(pmd) +
-					((addr & ~PMD_MASK) >> PAGE_SHIFT);
+					(only_print_head_pfn?0:((addr & ~PMD_MASK) >> PAGE_SHIFT));
 		}
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		else if (is_swap_pmd(pmd)) {
@@ -1394,7 +1397,7 @@ static int pagemap_pud_range(pud_t *pudp, unsigned long addr, unsigned long end,
 			flags |= PM_SOFT_DIRTY;
 		if (pm->show_pfn)
 			frame = pud_pfn(pud) +
-				((addr & ~PMD_MASK) >> PAGE_SHIFT);
+				(only_print_head_pfn?0:((addr & ~PUD_MASK) >> PAGE_SHIFT));
 	}
 
 	if (page && page_mapcount(page) == 1)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6bf0be1af7e0..762535a2c7d1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -122,6 +122,8 @@ extern int vma_no_repeat_defrag;
 extern int num_breakout_chunks;
 extern int defrag_size_threshold;
 
+extern int only_print_head_pfn;
+
 /* Constants used for minimum and  maximum */
 #ifdef CONFIG_LOCKUP_DETECTOR
 static int sixty = 60;
@@ -1750,6 +1752,15 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &zero,
 	},
+	{
+		.procname	= "only_print_head_pfn",
+		.data		= &only_print_head_pfn,
+		.maxlen		= sizeof(only_print_head_pfn),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
 	{ }
 };
 
-- 
2.20.1

