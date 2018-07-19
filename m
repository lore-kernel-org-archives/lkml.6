Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B9DECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957F620684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957F620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeGTAXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:23:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37381 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbeGTAXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:23:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNampL2454507
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:36:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNam8H2454504;
        Thu, 19 Jul 2018 16:36:48 -0700
Date:   Thu, 19 Jul 2018 16:36:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-9bae3197e15dd5e03ce8e237db6fe4486b08a775@git.kernel.org>
Cc:     jpoimboe@redhat.com, dave.hansen@intel.com, dvlasenk@redhat.com,
        peterz@infradead.org, torvalds@linux-foundation.org,
        brgerst@gmail.com, llong@redhat.com, dhgutteridge@sympatico.ca,
        jgross@suse.com, pavel@ucw.cz, boris.ostrovsky@oracle.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, hpa@zytor.com,
        aarcange@redhat.com, eduval@amazon.com, bp@alien8.de,
        jroedel@suse.de, mingo@kernel.org, jkosina@suse.cz,
        will.deacon@arm.com, David.Laight@aculab.com,
        linux-kernel@vger.kernel.org, luto@kernel.org
Reply-To: David.Laight@aculab.com, will.deacon@arm.com, luto@kernel.org,
          linux-kernel@vger.kernel.org, eduval@amazon.com, jkosina@suse.cz,
          mingo@kernel.org, bp@alien8.de, jroedel@suse.de, hpa@zytor.com,
          aarcange@redhat.com, gregkh@linuxfoundation.org,
          tglx@linutronix.de, boris.ostrovsky@oracle.com,
          dhgutteridge@sympatico.ca, llong@redhat.com, brgerst@gmail.com,
          pavel@ucw.cz, jgross@suse.com, torvalds@linux-foundation.org,
          dvlasenk@redhat.com, peterz@infradead.org, dave.hansen@intel.com,
          jpoimboe@redhat.com
In-Reply-To: <1531906876-13451-36-git-send-email-joro@8bytes.org>
References: <1531906876-13451-36-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/ldt: Split out sanity check in map_ldt_struct()
Git-Commit-ID: 9bae3197e15dd5e03ce8e237db6fe4486b08a775
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

Commit-ID:  9bae3197e15dd5e03ce8e237db6fe4486b08a775
Gitweb:     https://git.kernel.org/tip/9bae3197e15dd5e03ce8e237db6fe4486b08a775
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:12 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:47 +0200

x86/ldt: Split out sanity check in map_ldt_struct()

This splits out the mapping sanity check and the actual mapping of the LDT
to user-space from the map_ldt_struct() function in a way so that it is
re-usable for PAE paging.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-36-git-send-email-joro@8bytes.org

---
 arch/x86/kernel/ldt.c | 82 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index e921b3d494d5..69af9a0d57b7 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -100,6 +100,49 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
 	return new_ldt;
 }
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+
+static void do_sanity_check(struct mm_struct *mm,
+			    bool had_kernel_mapping,
+			    bool had_user_mapping)
+{
+	if (mm->context.ldt) {
+		/*
+		 * We already had an LDT.  The top-level entry should already
+		 * have been allocated and synchronized with the usermode
+		 * tables.
+		 */
+		WARN_ON(!had_kernel_mapping);
+		if (static_cpu_has(X86_FEATURE_PTI))
+			WARN_ON(!had_user_mapping);
+	} else {
+		/*
+		 * This is the first time we're mapping an LDT for this process.
+		 * Sync the pgd to the usermode tables.
+		 */
+		WARN_ON(had_kernel_mapping);
+		if (static_cpu_has(X86_FEATURE_PTI))
+			WARN_ON(had_user_mapping);
+	}
+}
+
+static void map_ldt_struct_to_user(struct mm_struct *mm)
+{
+	pgd_t *pgd = pgd_offset(mm, LDT_BASE_ADDR);
+
+	if (static_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
+		set_pgd(kernel_to_user_pgdp(pgd), *pgd);
+}
+
+static void sanity_check_ldt_mapping(struct mm_struct *mm)
+{
+	pgd_t *pgd = pgd_offset(mm, LDT_BASE_ADDR);
+	bool had_kernel = (pgd->pgd != 0);
+	bool had_user   = (kernel_to_user_pgdp(pgd)->pgd != 0);
+
+	do_sanity_check(mm, had_kernel, had_user);
+}
+
 /*
  * If PTI is enabled, this maps the LDT into the kernelmode and
  * usermode tables for the given mm.
@@ -115,9 +158,8 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
 static int
 map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	bool is_vmalloc, had_top_level_entry;
 	unsigned long va;
+	bool is_vmalloc;
 	spinlock_t *ptl;
 	pgd_t *pgd;
 	int i;
@@ -131,13 +173,15 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	 */
 	WARN_ON(ldt->slot != -1);
 
+	/* Check if the current mappings are sane */
+	sanity_check_ldt_mapping(mm);
+
 	/*
 	 * Did we already have the top level entry allocated?  We can't
 	 * use pgd_none() for this because it doens't do anything on
 	 * 4-level page table kernels.
 	 */
 	pgd = pgd_offset(mm, LDT_BASE_ADDR);
-	had_top_level_entry = (pgd->pgd != 0);
 
 	is_vmalloc = is_vmalloc_addr(ldt->entries);
 
@@ -172,35 +216,25 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 		pte_unmap_unlock(ptep, ptl);
 	}
 
-	if (mm->context.ldt) {
-		/*
-		 * We already had an LDT.  The top-level entry should already
-		 * have been allocated and synchronized with the usermode
-		 * tables.
-		 */
-		WARN_ON(!had_top_level_entry);
-		if (static_cpu_has(X86_FEATURE_PTI))
-			WARN_ON(!kernel_to_user_pgdp(pgd)->pgd);
-	} else {
-		/*
-		 * This is the first time we're mapping an LDT for this process.
-		 * Sync the pgd to the usermode tables.
-		 */
-		WARN_ON(had_top_level_entry);
-		if (static_cpu_has(X86_FEATURE_PTI)) {
-			WARN_ON(kernel_to_user_pgdp(pgd)->pgd);
-			set_pgd(kernel_to_user_pgdp(pgd), *pgd);
-		}
-	}
+	/* Propagate LDT mapping to the user page-table */
+	map_ldt_struct_to_user(mm);
 
 	va = (unsigned long)ldt_slot_va(slot);
 	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, 0);
 
 	ldt->slot = slot;
-#endif
 	return 0;
 }
 
+#else /* !CONFIG_PAGE_TABLE_ISOLATION */
+
+static int
+map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
+{
+	return 0;
+}
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+
 static void free_ldt_pgtables(struct mm_struct *mm)
 {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
