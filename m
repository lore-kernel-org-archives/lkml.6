Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7FBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E72820892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E72820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeLESFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:05:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLESFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:05:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB5I53Ie1375357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Dec 2018 10:05:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB5I53Wr1375354;
        Wed, 5 Dec 2018 10:05:03 -0800
Date:   Wed, 5 Dec 2018 10:05:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-c683c37cd13246941924c48f6c6a9863425e0cec@git.kernel.org>
Cc:     dan.j.williams@intel.com, bp@alien8.de, mingo@kernel.org,
        tglx@linutronix.de, riel@surriel.com, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, torvalds@linux-foundation.org,
        bigeasy@linutronix.de, luto@kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, peterz@infradead.org
Reply-To: hpa@zytor.com, luto@kernel.org, kirill.shutemov@linux.intel.com,
          peterz@infradead.org, mingo@kernel.org, dan.j.williams@intel.com,
          bp@alien8.de, bigeasy@linutronix.de, riel@surriel.com,
          linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
          torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <154395942644.32119.10238934183949418128.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154395942644.32119.10238934183949418128.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] generic/pgtable: Make {pmd, pud}_same()
 unconditionally available
Git-Commit-ID: c683c37cd13246941924c48f6c6a9863425e0cec
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

Commit-ID:  c683c37cd13246941924c48f6c6a9863425e0cec
Gitweb:     https://git.kernel.org/tip/c683c37cd13246941924c48f6c6a9863425e0cec
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Tue, 4 Dec 2018 13:37:06 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 5 Dec 2018 09:03:05 +0100

generic/pgtable: Make {pmd, pud}_same() unconditionally available

In preparation for {pmd,pud}_same() to be used outside of transparent
huge page code paths, make them unconditionally available. This enables
them to be used in the definition of a new family of
set_{pte,pmd,pud,p4d,pgd}_safe() helpers.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154395942644.32119.10238934183949418128.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/pgtable.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 359fb935ded6..eea50ef8b8cd 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -375,7 +375,6 @@ static inline int pte_unused(pte_t pte)
 #endif
 
 #ifndef __HAVE_ARCH_PMD_SAME
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 {
 	return pmd_val(pmd_a) == pmd_val(pmd_b);
@@ -385,19 +384,6 @@ static inline int pud_same(pud_t pud_a, pud_t pud_b)
 {
 	return pud_val(pud_a) == pud_val(pud_b);
 }
-#else /* CONFIG_TRANSPARENT_HUGEPAGE */
-static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
-{
-	BUILD_BUG();
-	return 0;
-}
-
-static inline int pud_same(pud_t pud_a, pud_t pud_b)
-{
-	BUILD_BUG();
-	return 0;
-}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
 #ifndef __HAVE_ARCH_DO_SWAP_PAGE
