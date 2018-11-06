Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A75BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393BC206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393BC206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbeKGGIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:08:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52913 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeKGGIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:08:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6KexId947565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 12:40:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6Kex3t947561;
        Tue, 6 Nov 2018 12:40:59 -0800
Date:   Tue, 6 Nov 2018 12:40:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-b082f2dd80612015cd6d9d84e52099734ec9a0e1@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        luto@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          kirill.shutemov@linux.intel.com, luto@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181026122856.66224-4-kirill.shutemov@linux.intel.com>
References: <20181026122856.66224-4-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/ldt: Remove unused variable in
 map_ldt_struct()
Git-Commit-ID: b082f2dd80612015cd6d9d84e52099734ec9a0e1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b082f2dd80612015cd6d9d84e52099734ec9a0e1
Gitweb:     https://git.kernel.org/tip/b082f2dd80612015cd6d9d84e52099734ec9a0e1
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 26 Oct 2018 15:28:56 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 6 Nov 2018 21:35:11 +0100

x86/ldt: Remove unused variable in map_ldt_struct()

Splitting out the sanity check in map_ldt_struct() moved page table syncing
into a separate function, which made the pgd variable unused. Remove it.

[ tglx: Massaged changelog ]

Fixes: 9bae3197e15d ("x86/ldt: Split out sanity check in map_ldt_struct()")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: dave.hansen@linux.intel.com
Cc: peterz@infradead.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: bhe@redhat.com
Cc: willy@infradead.org
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181026122856.66224-4-kirill.shutemov@linux.intel.com

---
 arch/x86/kernel/ldt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 18e4525c5933..6135ae8ce036 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -207,7 +207,6 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	bool is_vmalloc;
 	spinlock_t *ptl;
 	int i, nr_pages;
-	pgd_t *pgd;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return 0;
@@ -221,13 +220,6 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	/* Check if the current mappings are sane */
 	sanity_check_ldt_mapping(mm);
 
-	/*
-	 * Did we already have the top level entry allocated?  We can't
-	 * use pgd_none() for this because it doens't do anything on
-	 * 4-level page table kernels.
-	 */
-	pgd = pgd_offset(mm, LDT_BASE_ADDR);
-
 	is_vmalloc = is_vmalloc_addr(ldt->entries);
 
 	nr_pages = DIV_ROUND_UP(ldt->nr_entries * LDT_ENTRY_SIZE, PAGE_SIZE);
