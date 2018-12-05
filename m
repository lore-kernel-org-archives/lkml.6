Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FD8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2940C20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2940C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeLESGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:06:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41195 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLESGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:06:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB5I5cPv1375408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Dec 2018 10:05:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB5I5blL1375405;
        Wed, 5 Dec 2018 10:05:37 -0800
Date:   Wed, 5 Dec 2018 10:05:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-0cebbb60f759a709dabb3c87b9704f9844878850@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, bigeasy@linutronix.de,
        kirill.shutemov@linux.intel.com, mingo@kernel.org,
        tglx@linutronix.de, luto@kernel.org, torvalds@linux-foundation.org,
        dan.j.williams@intel.com, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, riel@surriel.com, bp@alien8.de
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
          hpa@zytor.com, dan.j.williams@intel.com,
          linux-kernel@vger.kernel.org, bp@alien8.de, riel@surriel.com,
          kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
          bigeasy@linutronix.de, tglx@linutronix.de, luto@kernel.org,
          mingo@kernel.org
In-Reply-To: <154395943153.32119.1733586547359626311.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154395943153.32119.1733586547359626311.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] generic/pgtable: Introduce {p4d,pgd}_same()
Git-Commit-ID: 0cebbb60f759a709dabb3c87b9704f9844878850
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

Commit-ID:  0cebbb60f759a709dabb3c87b9704f9844878850
Gitweb:     https://git.kernel.org/tip/0cebbb60f759a709dabb3c87b9704f9844878850
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Tue, 4 Dec 2018 13:37:11 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 5 Dec 2018 09:03:06 +0100

generic/pgtable: Introduce {p4d,pgd}_same()

In preparation for introducing '_safe' versions of page table entry 'set'
helpers, introduce generic versions of p4d_same() and pgd_same().

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
Link: http://lkml.kernel.org/r/154395943153.32119.1733586547359626311.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/pgtable.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index eea50ef8b8cd..dae7f98babed 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -386,6 +386,20 @@ static inline int pud_same(pud_t pud_a, pud_t pud_b)
 }
 #endif
 
+#ifndef __HAVE_ARCH_P4D_SAME
+static inline int p4d_same(p4d_t p4d_a, p4d_t p4d_b)
+{
+	return p4d_val(p4d_a) == p4d_val(p4d_b);
+}
+#endif
+
+#ifndef __HAVE_ARCH_PGD_SAME
+static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
+{
+	return pgd_val(pgd_a) == pgd_val(pgd_b);
+}
+#endif
+
 #ifndef __HAVE_ARCH_DO_SWAP_PAGE
 /*
  * Some architectures support metadata associated with a page. When a
