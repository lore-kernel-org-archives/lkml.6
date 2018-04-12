Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx48aCI0vc/eCNjiOHhXIYfiG/I8YmG1DGF7s1Hd3fpKDffLXFyENXfzAwq1G6g2tCzJlDTmB
ARC-Seal: i=1; a=rsa-sha256; t=1523519634; cv=none;
        d=google.com; s=arc-20160816;
        b=Tkb4k05eekuiZ2eIdM2lBQMczvWgxBmxcjsuIOc0k4aaR2qiTvXP7ZlZ+ycOm72Mt7
         Cs46uysi33TPvKyqpN5GAi5k3K8PXOzJYxZOHOoGbRM+DUKVt8IuiG2Aou3d/1v58acv
         GIEsCb6woCfr7APNLSqIHYJz8iKbL/UB2Zjrr30fNCqA6FByYPO9EC3kEbximcLmq0oz
         PZW8GsFqLDNYdRxqED5DSrynG9mleUvcd4qjCFSK1Ee9tVasE6G7EqNOPWt21/ywwUVl
         yPoerbhGGnGjEpWzHJgNyGSCKJIJ5tWex4KsiUjrZSZhQCrUVj9ZvIrLk9cCqwsHX3wI
         F69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=UToqSsi/uZdR/EaqtC32Y+Gyh6vL55gKGarkor+w3VA=;
        b=uHoF6NNwDNyOUGlUED+BAvfRMoFR1cyoJhGd+jBME3/j//kQOYpLa3+XuXBtTh0nOS
         z4zUS49cPH78TLeHRB8+xKqd5tUf97M9gp0/XyvkQQ3/mdCV7IChd6rxh5l3ijC9rsN6
         Rx+y4wjGZ3BtOg0Hf/7LdFAaQKwtkd99R/3cG9uqX6xePR9eDzgpNczEpn3mDlQCVqV7
         e4QBoYYuYCYRMN3ZkdVTfH99h+lcDAp1U/kJuRD7PpgazXtlYeETdYAD2oF5XZPGCx2x
         FWSgIQE2alyKscww4hd4YcoEtx9pbKG+6OVZGgK8pZaBTZnQb3/IgM/No5VJHBRNbGwt
         p5hQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Thu, 12 Apr 2018 00:52:23 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-e3e288121408c3abeed5af60b87b95c847143845@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, dhgutteridge@sympatico.ca,
        llong@redhat.com, David.Laight@aculab.com, tglx@linutronix.de,
        dave.hansen@intel.com, jgross@suse.com, aarcange@redhat.com,
        brgerst@gmail.com, jroedel@suse.de, jpoimboe@redhat.com, hpa@zytor.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        will.deacon@arm.com, peterz@infradead.org, dvlasenk@redhat.com,
        boris.ostrovsky@oracle.com, luto@kernel.org, eduval@amazon.com,
        pavel@ucw.cz, joro@8bytes.org, bp@alien8.de, jkosina@suse.cz
Reply-To: jgross@suse.com, aarcange@redhat.com, brgerst@gmail.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        David.Laight@aculab.com, dave.hansen@intel.com,
        dhgutteridge@sympatico.ca, llong@redhat.com, peterz@infradead.org,
        will.deacon@arm.com, dvlasenk@redhat.com, pavel@ucw.cz,
        eduval@amazon.com, luto@kernel.org, boris.ostrovsky@oracle.com,
        jkosina@suse.cz, bp@alien8.de, joro@8bytes.org, jroedel@suse.de,
        jpoimboe@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org
In-Reply-To: <20180411152437.GC15462@8bytes.org>
References: <20180411152437.GC15462@8bytes.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pgtable: Don't set huge PUD/PMD on non-leaf
 entries
Git-Commit-ID: e3e288121408c3abeed5af60b87b95c847143845
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597526124453622811?=
X-GMAIL-MSGID: =?utf-8?q?1597526124453622811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  e3e288121408c3abeed5af60b87b95c847143845
Gitweb:     https://git.kernel.org/tip/e3e288121408c3abeed5af60b87b95c847143845
Author:     Joerg Roedel <joro@8bytes.org>
AuthorDate: Wed, 11 Apr 2018 17:24:38 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 12 Apr 2018 09:41:41 +0200

x86/pgtable: Don't set huge PUD/PMD on non-leaf entries

The pmd_set_huge() and pud_set_huge() functions are used from
the generic ioremap() code to establish large mappings where this
is possible.

But the generic ioremap() code does not check whether the
PMD/PUD entries are already populated with a non-leaf entry,
so that any page-table pages these entries point to will be
lost.

Further, on x86-32 with SHARED_KERNEL_PMD=0, this causes a
BUG_ON() in vmalloc_sync_one() when PMD entries are synced
from swapper_pg_dir to the current page-table. This happens
because the PMD entry from swapper_pg_dir was promoted to a
huge-page entry while the current PGD still contains the
non-leaf entry. Because both entries are present and point
to a different page, the BUG_ON() triggers.

This was actually triggered with pti-x32 enabled in a KVM
virtual machine by the graphics driver.

A real and better fix for that would be to improve the
page-table handling in the generic ioremap() code. But that is
out-of-scope for this patch-set and left for later work.

Reported-by: David H. Gutteridge <dhgutteridge@sympatico.ca>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <llong@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180411152437.GC15462@8bytes.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pgtable.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index d10a40aceeaa..ffc8c13c50e4 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm.h>
 #include <linux/gfp.h>
+#include <linux/hugetlb.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/tlb.h>
@@ -639,6 +640,10 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 	    (mtrr != MTRR_TYPE_WRBACK))
 		return 0;
 
+	/* Bail out if we are we on a populated non-leaf entry: */
+	if (pud_present(*pud) && !pud_huge(*pud))
+		return 0;
+
 	prot = pgprot_4k_2_large(prot);
 
 	set_pte((pte_t *)pud, pfn_pte(
@@ -667,6 +672,10 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 		return 0;
 	}
 
+	/* Bail out if we are we on a populated non-leaf entry: */
+	if (pmd_present(*pmd) && !pmd_huge(*pmd))
+		return 0;
+
 	prot = pgprot_4k_2_large(prot);
 
 	set_pte((pte_t *)pmd, pfn_pte(
