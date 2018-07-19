Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9D7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87DB20652
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87DB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbeGTAON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:14:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55497 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbeGTAON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:14:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNRoGK2453429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:27:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNRoov2453425;
        Thu, 19 Jul 2018 16:27:50 -0700
Date:   Thu, 19 Jul 2018 16:27:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-8372d66865deb45ee3ec21401a9c80f231b728c8@git.kernel.org>
Cc:     David.Laight@aculab.com, boris.ostrovsky@oracle.com, bp@alien8.de,
        peterz@infradead.org, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, mingo@kernel.org, pavel@ucw.cz,
        hpa@zytor.com, jpoimboe@redhat.com, dave.hansen@intel.com,
        will.deacon@arm.com, jkosina@suse.cz, jroedel@suse.de,
        jgross@suse.com, eduval@amazon.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, luto@kernel.org, llong@redhat.com,
        aarcange@redhat.com, dhgutteridge@sympatico.ca, brgerst@gmail.com,
        tglx@linutronix.de
Reply-To: dvlasenk@redhat.com, torvalds@linux-foundation.org,
          peterz@infradead.org, David.Laight@aculab.com,
          boris.ostrovsky@oracle.com, bp@alien8.de, jpoimboe@redhat.com,
          hpa@zytor.com, mingo@kernel.org, pavel@ucw.cz, jgross@suse.com,
          jroedel@suse.de, jkosina@suse.cz, gregkh@linuxfoundation.org,
          eduval@amazon.com, linux-kernel@vger.kernel.org,
          will.deacon@arm.com, dave.hansen@intel.com, tglx@linutronix.de,
          dhgutteridge@sympatico.ca, brgerst@gmail.com, llong@redhat.com,
          luto@kernel.org, aarcange@redhat.com
In-Reply-To: <1531906876-13451-19-git-send-email-joro@8bytes.org>
References: <1531906876-13451-19-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pgtable: Move pgdp kernel/user conversion
 functions to pgtable.h
Git-Commit-ID: 8372d66865deb45ee3ec21401a9c80f231b728c8
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

Commit-ID:  8372d66865deb45ee3ec21401a9c80f231b728c8
Gitweb:     https://git.kernel.org/tip/8372d66865deb45ee3ec21401a9c80f231b728c8
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:55 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:41 +0200

x86/pgtable: Move pgdp kernel/user conversion functions to pgtable.h

Make them available on 32 bit and clone_pgd_range() happy.

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
Link: https://lkml.kernel.org/r/1531906876-13451-19-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/pgtable.h    | 49 +++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/pgtable_64.h | 49 ---------------------------------------
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5715647fc4fe..eb474329d751 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1155,6 +1155,55 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+/*
+ * All top-level PAGE_TABLE_ISOLATION page tables are order-1 pages
+ * (8k-aligned and 8k in size).  The kernel one is at the beginning 4k and
+ * the user one is in the last 4k.  To switch between them, you
+ * just need to flip the 12th bit in their addresses.
+ */
+#define PTI_PGTABLE_SWITCH_BIT	PAGE_SHIFT
+
+/*
+ * This generates better code than the inline assembly in
+ * __set_bit().
+ */
+static inline void *ptr_set_bit(void *ptr, int bit)
+{
+	unsigned long __ptr = (unsigned long)ptr;
+
+	__ptr |= BIT(bit);
+	return (void *)__ptr;
+}
+static inline void *ptr_clear_bit(void *ptr, int bit)
+{
+	unsigned long __ptr = (unsigned long)ptr;
+
+	__ptr &= ~BIT(bit);
+	return (void *)__ptr;
+}
+
+static inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
+{
+	return ptr_set_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
+}
+
+static inline pgd_t *user_to_kernel_pgdp(pgd_t *pgdp)
+{
+	return ptr_clear_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
+}
+
+static inline p4d_t *kernel_to_user_p4dp(p4d_t *p4dp)
+{
+	return ptr_set_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
+}
+
+static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
+{
+	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
+}
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+
 /*
  * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
  *
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 9406c4fe1d38..4adba19c7bf6 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -132,55 +132,6 @@ static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 #endif
 }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-/*
- * All top-level PAGE_TABLE_ISOLATION page tables are order-1 pages
- * (8k-aligned and 8k in size).  The kernel one is at the beginning 4k and
- * the user one is in the last 4k.  To switch between them, you
- * just need to flip the 12th bit in their addresses.
- */
-#define PTI_PGTABLE_SWITCH_BIT	PAGE_SHIFT
-
-/*
- * This generates better code than the inline assembly in
- * __set_bit().
- */
-static inline void *ptr_set_bit(void *ptr, int bit)
-{
-	unsigned long __ptr = (unsigned long)ptr;
-
-	__ptr |= BIT(bit);
-	return (void *)__ptr;
-}
-static inline void *ptr_clear_bit(void *ptr, int bit)
-{
-	unsigned long __ptr = (unsigned long)ptr;
-
-	__ptr &= ~BIT(bit);
-	return (void *)__ptr;
-}
-
-static inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
-{
-	return ptr_set_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline pgd_t *user_to_kernel_pgdp(pgd_t *pgdp)
-{
-	return ptr_clear_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline p4d_t *kernel_to_user_p4dp(p4d_t *p4dp)
-{
-	return ptr_set_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
-{
-	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
-}
-#endif /* CONFIG_PAGE_TABLE_ISOLATION */
-
 /*
  * Page table pages are page-aligned.  The lower half of the top
  * level is used for userspace and the top half for the kernel.
