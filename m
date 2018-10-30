Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2CBC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5002080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5002080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJ3Ry2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:54:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45333 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3Ry1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:54:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9U91TYk1906836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Oct 2018 02:01:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9U91SsH1906833;
        Tue, 30 Oct 2018 02:01:28 -0700
Date:   Tue, 30 Oct 2018 02:01:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-7847c7be0481558f17e3ef3b03f573677fd30d29@git.kernel.org>
Cc:     hpa@zytor.com, jgross@suse.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          peterz@infradead.org, hpa@zytor.com, jgross@suse.com
In-Reply-To: <20181030063301.15054-1-jgross@suse.com>
References: <20181030063301.15054-1-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/paravirt: Remove unused _paravirt_ident_32
Git-Commit-ID: 7847c7be0481558f17e3ef3b03f573677fd30d29
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

Commit-ID:  7847c7be0481558f17e3ef3b03f573677fd30d29
Gitweb:     https://git.kernel.org/tip/7847c7be0481558f17e3ef3b03f573677fd30d29
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 30 Oct 2018 07:33:01 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Oct 2018 09:55:31 +0100

x86/paravirt: Remove unused _paravirt_ident_32

There is no user of _paravirt_ident_32 left in the tree. Remove it
together with the related paravirt_patch_ident_32().

paravirt_patch_ident_64() can be moved inside CONFIG_PARAVIRT_XXL=y.

Signed-off-by: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akataria@vmware.com
Cc: boris.ostrovsky@oracle.com
Cc: rusty@rustcorp.com.au
Cc: virtualization@lists.linux-foundation.org
Cc: xen-devel@lists.xenproject.org
Link: http://lkml.kernel.org/r/20181030063301.15054-1-jgross@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/paravirt_types.h |  2 --
 arch/x86/kernel/paravirt.c            | 26 +++++++-------------------
 arch/x86/kernel/paravirt_patch_32.c   | 18 ++++++------------
 arch/x86/kernel/paravirt_patch_64.c   | 20 ++++++--------------
 4 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fba54ca23b2a..26942ad63830 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -361,7 +361,6 @@ extern struct paravirt_patch_template pv_ops;
 	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
 	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
 
-unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len);
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
 unsigned paravirt_patch_default(u8 type, void *insnbuf,
 				unsigned long addr, unsigned len);
@@ -651,7 +650,6 @@ void paravirt_leave_lazy_mmu(void);
 void paravirt_flush_lazy_mmu(void);
 
 void _paravirt_nop(void);
-u32 _paravirt_ident_32(u32);
 u64 _paravirt_ident_64(u64);
 
 #define paravirt_nop	((void *)_paravirt_nop)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 45123b116c05..c0e0101133f3 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -56,17 +56,6 @@ asm (".pushsection .entry.text, \"ax\"\n"
      ".type _paravirt_nop, @function\n\t"
      ".popsection");
 
-/* identity function, which can be inlined */
-u32 notrace _paravirt_ident_32(u32 x)
-{
-	return x;
-}
-
-u64 notrace _paravirt_ident_64(u64 x)
-{
-	return x;
-}
-
 void __init default_banner(void)
 {
 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
@@ -102,6 +91,12 @@ static unsigned paravirt_patch_call(void *insnbuf, const void *target,
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
+/* identity function, which can be inlined */
+u64 notrace _paravirt_ident_64(u64 x)
+{
+	return x;
+}
+
 static unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
 				   unsigned long addr, unsigned len)
 {
@@ -146,13 +141,11 @@ unsigned paravirt_patch_default(u8 type, void *insnbuf,
 	else if (opfunc == _paravirt_nop)
 		ret = 0;
 
+#ifdef CONFIG_PARAVIRT_XXL
 	/* identity functions just return their single argument */
-	else if (opfunc == _paravirt_ident_32)
-		ret = paravirt_patch_ident_32(insnbuf, len);
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insnbuf, len);
 
-#ifdef CONFIG_PARAVIRT_XXL
 	else if (type == PARAVIRT_PATCH(cpu.iret) ||
 		 type == PARAVIRT_PATCH(cpu.usergs_sysret64))
 		/* If operation requires a jmp, then jmp */
@@ -309,13 +302,8 @@ struct pv_info pv_info = {
 #endif
 };
 
-#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
-/* 32-bit pagetable entries */
-#define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_32)
-#else
 /* 64-bit pagetable entries */
 #define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_64)
-#endif
 
 struct paravirt_patch_template pv_ops = {
 	/* Init ops. */
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index 6368c22fa1fa..de138d3912e4 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -10,24 +10,18 @@ DEF_NATIVE(cpu, iret, "iret");
 DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
 DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
 DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");
-#endif
-
-#if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
-DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
-#endif
-
-unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
-{
-	/* arg in %eax, return in %eax */
-	return 0;
-}
 
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 {
 	/* arg in %edx:%eax, return in %edx:%eax */
 	return 0;
 }
+#endif
+
+#if defined(CONFIG_PARAVIRT_SPINLOCKS)
+DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
+DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
+#endif
 
 extern bool pv_is_native_spin_unlock(void);
 extern bool pv_is_native_vcpu_is_preempted(void);
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 7ca9cb726f4d..9d9e04b31077 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -15,27 +15,19 @@ DEF_NATIVE(cpu, wbinvd, "wbinvd");
 
 DEF_NATIVE(cpu, usergs_sysret64, "swapgs; sysretq");
 DEF_NATIVE(cpu, swapgs, "swapgs");
-#endif
-
-DEF_NATIVE(, mov32, "mov %edi, %eax");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
 
-#if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%rdi)");
-DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
-#endif
-
-unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
-{
-	return paravirt_patch_insns(insnbuf, len,
-				    start__mov32, end__mov32);
-}
-
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 {
 	return paravirt_patch_insns(insnbuf, len,
 				    start__mov64, end__mov64);
 }
+#endif
+
+#if defined(CONFIG_PARAVIRT_SPINLOCKS)
+DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%rdi)");
+DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
+#endif
 
 extern bool pv_is_native_spin_unlock(void);
 extern bool pv_is_native_vcpu_is_preempted(void);
