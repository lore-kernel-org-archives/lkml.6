Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F115ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B480320673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B480320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbeGTAPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:15:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36047 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbeGTAPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:15:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNSrKH2453528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:28:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNSrmw2453524;
        Thu, 19 Jul 2018 16:28:53 -0700
Date:   Thu, 19 Jul 2018 16:28:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-76e258add7b653b60037ee4b25ebc40da6a35c4a@git.kernel.org>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, torvalds@linux-foundation.org, bp@alien8.de,
        dhgutteridge@sympatico.ca, jgross@suse.com,
        boris.ostrovsky@oracle.com, tglx@linutronix.de, jkosina@suse.cz,
        aarcange@redhat.com, jpoimboe@redhat.com, pavel@ucw.cz,
        hpa@zytor.com, luto@kernel.org, gregkh@linuxfoundation.org,
        David.Laight@aculab.com, jroedel@suse.de, peterz@infradead.org,
        brgerst@gmail.com, will.deacon@arm.com, eduval@amazon.com,
        llong@redhat.com, dvlasenk@redhat.com
Reply-To: gregkh@linuxfoundation.org, luto@kernel.org,
          David.Laight@aculab.com, jkosina@suse.cz, jpoimboe@redhat.com,
          pavel@ucw.cz, aarcange@redhat.com, hpa@zytor.com,
          eduval@amazon.com, dvlasenk@redhat.com, llong@redhat.com,
          jroedel@suse.de, brgerst@gmail.com, peterz@infradead.org,
          will.deacon@arm.com, bp@alien8.de, dhgutteridge@sympatico.ca,
          jgross@suse.com, tglx@linutronix.de, boris.ostrovsky@oracle.com,
          dave.hansen@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <1531906876-13451-21-git-send-email-joro@8bytes.org>
References: <1531906876-13451-21-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pgtable: Move two more functions from
 pgtable_64.h to pgtable.h
Git-Commit-ID: 76e258add7b653b60037ee4b25ebc40da6a35c4a
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

Commit-ID:  76e258add7b653b60037ee4b25ebc40da6a35c4a
Gitweb:     https://git.kernel.org/tip/76e258add7b653b60037ee4b25ebc40da6a35c4a
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:57 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:42 +0200

x86/pgtable: Move two more functions from pgtable_64.h to pgtable.h

These two functions are required for PTI on 32 bit:

	* pgdp_maps_userspace()
	* pgd_large()

Also re-implement pgdp_maps_userspace() so that it will work on 64 and 32
bit kernels.

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
Link: https://lkml.kernel.org/r/1531906876-13451-21-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/pgtable-2level_types.h |  3 +++
 arch/x86/include/asm/pgtable-3level_types.h |  1 +
 arch/x86/include/asm/pgtable.h              | 15 ++++++++++++
 arch/x86/include/asm/pgtable_32.h           |  2 --
 arch/x86/include/asm/pgtable_64.h           | 36 -----------------------------
 arch/x86/include/asm/pgtable_64_types.h     |  2 ++
 6 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
index f982ef808e7e..6deb6cd236e3 100644
--- a/arch/x86/include/asm/pgtable-2level_types.h
+++ b/arch/x86/include/asm/pgtable-2level_types.h
@@ -35,4 +35,7 @@ typedef union {
 
 #define PTRS_PER_PTE	1024
 
+/* This covers all VMSPLIT_* and VMSPLIT_*_OPT variants */
+#define PGD_KERNEL_START	(CONFIG_PAGE_OFFSET >> PGDIR_SHIFT)
+
 #endif /* _ASM_X86_PGTABLE_2LEVEL_DEFS_H */
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 78038e057876..858358a82b14 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -46,5 +46,6 @@ typedef union {
 #define PTRS_PER_PTE	512
 
 #define MAX_POSSIBLE_PHYSMEM_BITS	36
+#define PGD_KERNEL_START	(CONFIG_PAGE_OFFSET >> PGDIR_SHIFT)
 
 #endif /* _ASM_X86_PGTABLE_3LEVEL_DEFS_H */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index cc117161f13d..e39088cb59ab 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1177,6 +1177,21 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 	}
 }
 #endif
+/*
+ * Page table pages are page-aligned.  The lower half of the top
+ * level is used for userspace and the top half for the kernel.
+ *
+ * Returns true for parts of the PGD that map userspace and
+ * false for the parts that map the kernel.
+ */
+static inline bool pgdp_maps_userspace(void *__ptr)
+{
+	unsigned long ptr = (unsigned long)__ptr;
+
+	return (((ptr & ~PAGE_MASK) / sizeof(pgd_t)) < PGD_KERNEL_START);
+}
+
+static inline int pgd_large(pgd_t pgd) { return 0; }
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 88a056b01db4..b3ec519e3982 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -34,8 +34,6 @@ static inline void check_pgt_cache(void) { }
 void paging_init(void);
 void sync_initial_page_table(void);
 
-static inline int pgd_large(pgd_t pgd) { return 0; }
-
 /*
  * Define this if things work differently on an i386 and an i486:
  * it will (on an i486) warn about kernel memory accesses that are
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 4adba19c7bf6..acb6970e7bcf 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -132,41 +132,6 @@ static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 #endif
 }
 
-/*
- * Page table pages are page-aligned.  The lower half of the top
- * level is used for userspace and the top half for the kernel.
- *
- * Returns true for parts of the PGD that map userspace and
- * false for the parts that map the kernel.
- */
-static inline bool pgdp_maps_userspace(void *__ptr)
-{
-	unsigned long ptr = (unsigned long)__ptr;
-
-	return (ptr & ~PAGE_MASK) < (PAGE_SIZE / 2);
-}
-
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd);
-
-/*
- * Take a PGD location (pgdp) and a pgd value that needs to be set there.
- * Populates the user and returns the resulting PGD that must be set in
- * the kernel copy of the page tables.
- */
-static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
-{
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		return pgd;
-	return __pti_set_user_pgtbl(pgdp, pgd);
-}
-#else
-static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
-{
-	return pgd;
-}
-#endif
-
 static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
@@ -206,7 +171,6 @@ extern void sync_global_pgds(unsigned long start, unsigned long end);
 /*
  * Level 4 access.
  */
-static inline int pgd_large(pgd_t pgd) { return 0; }
 #define mk_kernel_pgd(address) __pgd((address) | _KERNPG_TABLE)
 
 /* PUD - Level3 access */
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 054765ab2da2..066e0ab9ffab 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -153,4 +153,6 @@ extern unsigned int ptrs_per_p4d;
 
 #define EARLY_DYNAMIC_PAGE_TABLES	64
 
+#define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
+
 #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
