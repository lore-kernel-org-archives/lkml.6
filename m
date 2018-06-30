Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F17C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC9A25053
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PutVY5QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC9A25053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934198AbeF3Itq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 04:49:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46507 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeF3Ith (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 04:49:37 -0400
Received: by mail-wr0-f193.google.com with SMTP id s11-v6so1638076wra.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wS5Q+na8IaZCXzgj+RvOH8yJ4xQke9vx+ucUkiHGvP0=;
        b=PutVY5QPw+MgQKpmiTQiH8I3Z8Lki2EwjYKofYcOqTRp8f9SddVqT6bvHTiTF913xm
         7jBG38C8CXQ03/ebcpwWw4i6nNdNRrKJVlmuHxgaaNqp0MpXGLEOhgsLnwVORaRULZ3L
         8v41MEr171QppWHvGnl7gtRX5uOMVzlr/pW6uUr6RZCYyi9jAY8KLMwAT7Wg73IJzJxd
         4j369YZd9jncQ1opv09Y/8CNHN7hniBWM1ToUQjKiUk7++Thv23Wvk5lEMmHUM1dQfX3
         MS0SgPUNm8kuhumX4SBtOQatzXMwfptJ8f9BLiX+4gX/SCII3dUyWdeHRa0bt+A2Ctpm
         yVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=wS5Q+na8IaZCXzgj+RvOH8yJ4xQke9vx+ucUkiHGvP0=;
        b=iFRD2hbQIvhNFZedljn0F4DFCRK+bNQe75MImePJFvXxQPjR97nLcKGhP3VYQXI8su
         usMoWBJ0Gr3Fiw6Tuu1aXRaGAdJUPOqeLAOApuM3e3ffBdnTMjFN7Ms4GOSX6q/6Oqb9
         mh6T6SgbmGVP+H7LdY6VRwI+23Ua1uFKextYXvGTIGCF8brOY/i7Cne09ppyWAKngSD/
         7HH/idyGhIPHmUkCxRS7aUzfAH3OxN8nOQLZsrBEwg7A7qdcjqKgmbp4TtQPcfhAdX0+
         LxN85fAdyQhoyby9KMr6hcVi9bQIPzC4UMGR6TzeHxdTpcZ4dzSZaGUkevvQoX+w8sTB
         kEyg==
X-Gm-Message-State: APt69E1BivHly0A799Xqo2BLrHasTS/78gqCLNgNugJZ3voA7Ara6z4Z
        MJANh9/Nu4fkseG6F+npCnw=
X-Google-Smtp-Source: AAOMgpf+BMLWrIRziWYYY9a7DtEXTkUbobQ/HSXX/nFD9WIc0ZtOqU+JKICCLacgn3lcrddfnwPPsA==
X-Received: by 2002:adf:93c6:: with SMTP id 64-v6mr14427444wrp.119.1530348576106;
        Sat, 30 Jun 2018 01:49:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n23-v6sm2559080wmh.6.2018.06.30.01.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 01:49:35 -0700 (PDT)
Date:   Sat, 30 Jun 2018 10:49:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20180630084933.GA15210@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: d79d0d8ad0cb3d782b41631dfeac8eb05e414bcd x86/mm: Clean up the printk()s in show_fault_oops()

The biggest diffstat comes from self-test updates, plus there's entry code fixes, 
5-level paging related fixes, console debug output fixes, plus misc fixes.

  out-of-topic modifications in x86-urgent-for-linus:
  -----------------------------------------------------
  tools/testing/selftests/x86/sigreturn.c# e8a445dea219: selftests/x86/sigreturn: Do 
                                   # ec3480205660: selftests/x86/sigreturn/64: 

 Thanks,

	Ingo

------------------>
Andrey Ryabinin (1):
      x86/mm: Don't free P4D table when it is folded at runtime

Andy Lutomirski (3):
      x86/entry/64/compat: Fix "x86/entry/64/compat: Preserve r8-r11 in int $0x80"
      selftests/x86/sigreturn/64: Fix spurious failures on AMD CPUs
      selftests/x86/sigreturn: Do minor cleanups

Dmitry Vyukov (2):
      x86/mm: Get rid of KERN_CONT in show_fault_oops()
      x86/mm: Clean up the printk()s in show_fault_oops()

Jan Beulich (1):
      x86/entry/32: Add explicit 'l' instruction suffix

Kirill A. Shutemov (2):
      x86/efi: Fix efi_call_phys_epilog() with CONFIG_X86_5LEVEL=y
      x86/mm: Drop unneeded __always_inline for p4d page table helpers


 arch/x86/entry/entry_32.S               |  2 +-
 arch/x86/entry/entry_64_compat.S        | 16 ++++-----
 arch/x86/include/asm/pgalloc.h          |  3 ++
 arch/x86/include/asm/pgtable.h          |  2 +-
 arch/x86/include/asm/pgtable_64.h       |  4 +--
 arch/x86/mm/fault.c                     | 21 ++++--------
 arch/x86/platform/efi/efi_64.c          |  4 +--
 tools/testing/selftests/x86/sigreturn.c | 59 ++++++++++++++++++++-------------
 8 files changed, 60 insertions(+), 51 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2582881d19ce..c371bfee137a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -477,7 +477,7 @@ ENTRY(entry_SYSENTER_32)
 	 * whereas POPF does not.)
 	 */
 	addl	$PT_EFLAGS-PT_DS, %esp	/* point esp at pt_regs->flags */
-	btr	$X86_EFLAGS_IF_BIT, (%esp)
+	btrl	$X86_EFLAGS_IF_BIT, (%esp)
 	popfl
 
 	/*
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 9de7f1e1dede..7d0df78db727 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -84,13 +84,13 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	%rdx			/* pt_regs->dx */
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   %r8			/* pt_regs->r8 */
+	pushq   $0			/* pt_regs->r8  = 0 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   %r9			/* pt_regs->r9 */
+	pushq   $0			/* pt_regs->r9  = 0 */
 	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   %r10			/* pt_regs->r10 */
+	pushq   $0			/* pt_regs->r10 = 0 */
 	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   %r11			/* pt_regs->r11 */
+	pushq   $0			/* pt_regs->r11 = 0 */
 	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
@@ -374,13 +374,13 @@ ENTRY(entry_INT80_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	xorl	%ecx, %ecx		/* nospec   cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   $0			/* pt_regs->r8  = 0 */
+	pushq   %r8			/* pt_regs->r8 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   $0			/* pt_regs->r9  = 0 */
+	pushq   %r9			/* pt_regs->r9 */
 	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   $0			/* pt_regs->r10 = 0 */
+	pushq   %r10			/* pt_regs->r10*/
 	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   $0			/* pt_regs->r11 = 0 */
+	pushq   %r11			/* pt_regs->r11 */
 	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index ada6410fd2ec..fbd578daa66e 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -184,6 +184,9 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
+	if (!pgtable_l5_enabled())
+		return;
+
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
 	free_page((unsigned long)p4d);
 }
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 99ecde23c3ec..5715647fc4fe 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -898,7 +898,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
 #define pgd_page(pgd)	pfn_to_page(pgd_pfn(pgd))
 
 /* to find an entry in a page-table-directory. */
-static __always_inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
+static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 {
 	if (!pgtable_l5_enabled())
 		return (p4d_t *)pgd;
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 0fdcd21dadbd..3c5385f9a88f 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -216,7 +216,7 @@ static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
 }
 #endif
 
-static __always_inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
+static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
 
@@ -230,7 +230,7 @@ static __always_inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 	*p4dp = native_make_p4d(native_pgd_val(pgd));
 }
 
-static __always_inline void native_p4d_clear(p4d_t *p4d)
+static inline void native_p4d_clear(p4d_t *p4d)
 {
 	native_set_p4d(p4d, native_make_p4d(0));
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9a84a0d08727..2aafa6ab6103 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -641,11 +641,6 @@ static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
 	return 0;
 }
 
-static const char nx_warning[] = KERN_CRIT
-"kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n";
-static const char smep_warning[] = KERN_CRIT
-"unable to execute userspace code (SMEP?) (uid: %d)\n";
-
 static void
 show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address)
@@ -664,20 +659,18 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		pte = lookup_address_in_pgd(pgd, address, &level);
 
 		if (pte && pte_present(*pte) && !pte_exec(*pte))
-			printk(nx_warning, from_kuid(&init_user_ns, current_uid()));
+			pr_crit("kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n",
+				from_kuid(&init_user_ns, current_uid()));
 		if (pte && pte_present(*pte) && pte_exec(*pte) &&
 				(pgd_flags(*pgd) & _PAGE_USER) &&
 				(__read_cr4() & X86_CR4_SMEP))
-			printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
+			pr_crit("unable to execute userspace code (SMEP?) (uid: %d)\n",
+				from_kuid(&init_user_ns, current_uid()));
 	}
 
-	printk(KERN_ALERT "BUG: unable to handle kernel ");
-	if (address < PAGE_SIZE)
-		printk(KERN_CONT "NULL pointer dereference");
-	else
-		printk(KERN_CONT "paging request");
-
-	printk(KERN_CONT " at %px\n", (void *) address);
+	pr_alert("BUG: unable to handle kernel %s at %px\n",
+		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
+		 (void *)address);
 
 	dump_pagetable(address);
 }
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e01f7ceb9e7a..77873ce700ae 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -166,14 +166,14 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
 		pgd = pgd_offset_k(pgd_idx * PGDIR_SIZE);
 		set_pgd(pgd_offset_k(pgd_idx * PGDIR_SIZE), save_pgd[pgd_idx]);
 
-		if (!(pgd_val(*pgd) & _PAGE_PRESENT))
+		if (!pgd_present(*pgd))
 			continue;
 
 		for (i = 0; i < PTRS_PER_P4D; i++) {
 			p4d = p4d_offset(pgd,
 					 pgd_idx * PGDIR_SIZE + i * P4D_SIZE);
 
-			if (!(p4d_val(*p4d) & _PAGE_PRESENT))
+			if (!p4d_present(*p4d))
 				continue;
 
 			pud = (pud_t *)p4d_page_vaddr(*p4d);
diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 246145b84a12..4d9dc3f2fd70 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -610,21 +610,41 @@ static int test_valid_sigreturn(int cs_bits, bool use_16bit_ss, int force_ss)
 	 */
 	for (int i = 0; i < NGREG; i++) {
 		greg_t req = requested_regs[i], res = resulting_regs[i];
+
 		if (i == REG_TRAPNO || i == REG_IP)
 			continue;	/* don't care */
-		if (i == REG_SP) {
-			printf("\tSP: %llx -> %llx\n", (unsigned long long)req,
-			       (unsigned long long)res);
 
+		if (i == REG_SP) {
 			/*
-			 * In many circumstances, the high 32 bits of rsp
-			 * are zeroed.  For example, we could be a real
-			 * 32-bit program, or we could hit any of a number
-			 * of poorly-documented IRET or segmented ESP
-			 * oddities.  If this happens, it's okay.
+			 * If we were using a 16-bit stack segment, then
+			 * the kernel is a bit stuck: IRET only restores
+			 * the low 16 bits of ESP/RSP if SS is 16-bit.
+			 * The kernel uses a hack to restore bits 31:16,
+			 * but that hack doesn't help with bits 63:32.
+			 * On Intel CPUs, bits 63:32 end up zeroed, and, on
+			 * AMD CPUs, they leak the high bits of the kernel
+			 * espfix64 stack pointer.  There's very little that
+			 * the kernel can do about it.
+			 *
+			 * Similarly, if we are returning to a 32-bit context,
+			 * the CPU will often lose the high 32 bits of RSP.
 			 */
-			if (res == (req & 0xFFFFFFFF))
-				continue;  /* OK; not expected to work */
+
+			if (res == req)
+				continue;
+
+			if (cs_bits != 64 && ((res ^ req) & 0xFFFFFFFF) == 0) {
+				printf("[NOTE]\tSP: %llx -> %llx\n",
+				       (unsigned long long)req,
+				       (unsigned long long)res);
+				continue;
+			}
+
+			printf("[FAIL]\tSP mismatch: requested 0x%llx; got 0x%llx\n",
+			       (unsigned long long)requested_regs[i],
+			       (unsigned long long)resulting_regs[i]);
+			nerrs++;
+			continue;
 		}
 
 		bool ignore_reg = false;
@@ -654,25 +674,18 @@ static int test_valid_sigreturn(int cs_bits, bool use_16bit_ss, int force_ss)
 #endif
 
 		/* Sanity check on the kernel */
-		if (i == REG_CX && requested_regs[i] != resulting_regs[i]) {
+		if (i == REG_CX && req != res) {
 			printf("[FAIL]\tCX (saved SP) mismatch: requested 0x%llx; got 0x%llx\n",
-			       (unsigned long long)requested_regs[i],
-			       (unsigned long long)resulting_regs[i]);
+			       (unsigned long long)req,
+			       (unsigned long long)res);
 			nerrs++;
 			continue;
 		}
 
-		if (requested_regs[i] != resulting_regs[i] && !ignore_reg) {
-			/*
-			 * SP is particularly interesting here.  The
-			 * usual cause of failures is that we hit the
-			 * nasty IRET case of returning to a 16-bit SS,
-			 * in which case bits 16:31 of the *kernel*
-			 * stack pointer persist in ESP.
-			 */
+		if (req != res && !ignore_reg) {
 			printf("[FAIL]\tReg %d mismatch: requested 0x%llx; got 0x%llx\n",
-			       i, (unsigned long long)requested_regs[i],
-			       (unsigned long long)resulting_regs[i]);
+			       i, (unsigned long long)req,
+			       (unsigned long long)res);
 			nerrs++;
 		}
 	}
