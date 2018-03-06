Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2968864-1520296109-2-15737436947692125008
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520296108; b=dY2rReTpSqGPsy727H9s1dLUbJK13oPss91pE46q0t2/iI+
    KoxGUKqMcz8xpkkW2dZkNY2E4YFGcDvpCNPJcXgVt5MieLkqlq41+knmeRBF+mtz
    YMMgZr+C2PZiYl3OKMswqi3KI6jUGP1oOGUlBiLDZrS7fVf6nqHfH9YiLePDiwrz
    GKab8dMZgtirA+grvxeyuVplZ4U8Lv00ILUNjyg++yfJJuzCvxHILucB4qPhKP/J
    2N6FwtJWjE2izbXQtzEpgJTmbWu9ueSP/9Q6TVw9GKbctuamZNcCX26yY28Psr+J
    uH74UROHJiKGUOEDzNxHmQZmqIzJDHCcyTmmDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520296108;
    bh=UxT7w88bHRQIvBxMzsMsQjMlmMfTEbyhEu91F1UAeuo=; b=UnzHNeNw4Psy
    1XCPOG6C89SK90q2eDdUiXhP7lEKUX3eqV15755Sqcdwr3LPxWKXNOZgNN49cH3N
    mT2K81voRg/YHdH0UsbXtwRJVsoN2mOVhJfWMo15bXhT9WfxDBhpMZEN5UNLttui
    0J3dYMIEqD8Ep72T5GK46igacjBJvFJ1SxQ1oF5C3/DYUke7RDAV8v09BVXcTbU/
    0BODpdlWHtCy7LtxhE+Txwg/jeKYcpITePKT4fdHAlOWep5k0ymKyujPAolpF77X
    Mhlg2TTu0ld0D+yt6k6XkmdH9DSkXHwFQ6slaprGyhJl3EQ9yfwIQHmW0RZBYNoK
    bgaxmsELig==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=KisnfeKB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=KisnfeKB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932926AbeCFA15 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:27:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43184 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933539AbeCFA1A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:27:00 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 60/65] KPTI: Rename to PAGE_TABLE_ISOLATION
Date: Mon,  5 Mar 2018 19:25:33 -0500
Message-Id: <20180306002538.1761-61-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060005
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>

This renames CONFIG_KAISER to CONFIG_PAGE_TABLE_ISOLATION.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 3e1457d6bf26d9ec300781f84cd0057e44deb45d)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/entry/entry_64.S (not in this tree)
	arch/x86/kernel/entry_64.S (patched instead of that)
---
 arch/x86/boot/compressed/misc.h           |  2 +-
 arch/x86/include/asm/cpufeature.h         |  2 +-
 arch/x86/include/asm/kaiser.h             | 12 ++++++------
 arch/x86/include/asm/pgtable.h            |  4 ++--
 arch/x86/include/asm/pgtable_64.h         |  4 ++--
 arch/x86/include/asm/pgtable_types.h      |  2 +-
 arch/x86/include/asm/tlbflush.h           |  2 +-
 arch/x86/kernel/cpu/perf_event_intel_ds.c |  4 ++--
 arch/x86/kernel/entry_64.S                | 12 ++++++------
 arch/x86/kernel/head_64.S                 |  2 +-
 arch/x86/mm/Makefile                      |  2 +-
 include/linux/kaiser.h                    |  6 +++---
 include/linux/percpu-defs.h               |  2 +-
 security/Kconfig                          |  2 +-
 14 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index cbaa2ebfa88d..6d92220983e6 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -9,7 +9,7 @@
  */
 #undef CONFIG_PARAVIRT
 #undef CONFIG_PARAVIRT_SPINLOCKS
-#undef CONFIG_KAISER
+#undef CONFIG_PAGE_TABLE_ISOLATION
 #undef CONFIG_KASAN
 
 #include <linux/linkage.h>
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 8effe086de27..a22aa8c5903c 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -202,7 +202,7 @@
 #define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_KAISER w/o nokaiser */
 
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
-#define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_KAISER w/o nokaiser */
+#define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_PAGE_TABLE_ISOLATION w/o nokaiser */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW  ( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index b5e46aa683f4..802bbbdfe143 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -20,7 +20,7 @@
 #define KAISER_SHADOW_PGD_OFFSET 0x1000
 
 #ifdef __ASSEMBLY__
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 
 .macro _SWITCH_TO_KERNEL_CR3 reg
 movq %cr3, \reg
@@ -69,7 +69,7 @@ movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 8:
 .endm
 
-#else /* CONFIG_KAISER */
+#else /* CONFIG_PAGE_TABLE_ISOLATION */
 
 .macro SWITCH_KERNEL_CR3
 .endm
@@ -78,11 +78,11 @@ movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 .macro SWITCH_KERNEL_CR3_NO_STACK
 .endm
 
-#endif /* CONFIG_KAISER */
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
 #else /* __ASSEMBLY__ */
 
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
  * Upon kernel/user mode switch, it may happen that the address
  * space has to be switched before the registers have been
@@ -100,10 +100,10 @@ extern void __init kaiser_check_boottime_disable(void);
 #else
 #define kaiser_enabled	0
 static inline void __init kaiser_check_boottime_disable(void) {}
-#endif /* CONFIG_KAISER */
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
 /*
- * Kaiser function prototypes are needed even when CONFIG_KAISER is not set,
+ * Kaiser function prototypes are needed even when CONFIG_PAGE_TABLE_ISOLATION is not set,
  * so as to build with tests on kaiser_enabled instead of #ifdefs.
  */
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index af9713487b36..4f971f28a7ec 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -18,7 +18,7 @@
 #ifndef __ASSEMBLY__
 #include <asm/x86_init.h>
 
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 extern int kaiser_enabled;
 #else
 #define kaiser_enabled 0
@@ -845,7 +845,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 static inline void clone_pgd_range(pgd_t *dst, pgd_t *src, int count)
 {
 	memcpy(dst, src, count * sizeof(pgd_t));
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 	if (kaiser_enabled) {
 		/* Clone the shadow pgd part as well */
 		memcpy(native_get_shadow_pgd(dst),
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 233d19c9f22e..c810226e741a 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -106,7 +106,7 @@ static inline void native_pud_clear(pud_t *pud)
 	native_set_pud(pud, native_make_pud(0));
 }
 
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 extern pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp, pgd_t pgd);
 
 static inline pgd_t *native_get_shadow_pgd(pgd_t *pgdp)
@@ -127,7 +127,7 @@ static inline pgd_t *native_get_shadow_pgd(pgd_t *pgdp)
 	BUILD_BUG_ON(1);
 	return NULL;
 }
-#endif /* CONFIG_KAISER */
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index d5b89550fb53..ea03e53e3c07 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -109,7 +109,7 @@
 #define X86_CR3_PCID_MASK       (X86_CR3_PCID_NOFLUSH | X86_CR3_PCID_ASID_MASK)
 #define X86_CR3_PCID_ASID_KERN  (_AC(0x0,UL))
 
-#if defined(CONFIG_KAISER) && defined(CONFIG_X86_64)
+#if defined(CONFIG_PAGE_TABLE_ISOLATION) && defined(CONFIG_X86_64)
 /* Let X86_CR3_PCID_ASID_USER be usable for the X86_CR3_PCID_NOFLUSH bit */
 #define X86_CR3_PCID_ASID_USER	(_AC(0x80,UL))
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 73865b174090..a691b66cc40a 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -135,7 +135,7 @@ static inline void cr4_set_bits_and_update_boot(unsigned long mask)
  * Declare a couple of kaiser interfaces here for convenience,
  * to avoid the need for asm/kaiser.h in unexpected places.
  */
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 extern int kaiser_enabled;
 extern void kaiser_setup_pcid(void);
 extern void kaiser_flush_tlb_on_return_to_user(void);
diff --git a/arch/x86/kernel/cpu/perf_event_intel_ds.c b/arch/x86/kernel/cpu/perf_event_intel_ds.c
index e4f109a7ed9a..c0fbb9393628 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_ds.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_ds.c
@@ -252,7 +252,7 @@ static DEFINE_PER_CPU(void *, insn_buffer);
 
 static void *dsalloc(size_t size, gfp_t flags, int node)
 {
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 	unsigned int order = get_order(size);
 	struct page *page;
 	unsigned long addr;
@@ -273,7 +273,7 @@ static void *dsalloc(size_t size, gfp_t flags, int node)
 
 static void dsfree(const void *buffer, size_t size)
 {
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 	if (!buffer)
 		return;
 	kaiser_remove_mapping((unsigned long)buffer, size);
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index f681e3bc6c22..95b57f4393b7 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1319,7 +1319,7 @@ ENTRY(paranoid_entry)
 	SWAPGS
 	xorl %ebx,%ebx
 1:
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 	/*
 	 * We might have come in between a swapgs and a SWITCH_KERNEL_CR3
 	 * on entry, or between a SWITCH_USER_CR3 and a swapgs on exit.
@@ -1360,7 +1360,7 @@ ENTRY(paranoid_exit)
 	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF_DEBUG
 	TRACE_IRQS_IRETQ_DEBUG
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 	/* No ALTERNATIVE for X86_FEATURE_KAISER: paranoid_entry sets %ebx */
 	testl   $2, %ebx			/* SWITCH_USER_CR3 needed? */
 	jz      paranoid_exit_no_switch
@@ -1564,7 +1564,7 @@ ENTRY(nmi)
 	 */
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 	/* Unconditionally use kernel CR3 for do_nmi() */
 	/* %rax is saved above, so OK to clobber here */
 	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_KAISER
@@ -1577,7 +1577,7 @@ ENTRY(nmi)
 2:
 #endif
 	call	do_nmi
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 	/*
 	 * Unconditionally restore CR3.  I know we return to
 	 * kernel code that needs user CR3, but do we ever return
@@ -1803,7 +1803,7 @@ end_repeat_nmi:
 1:
 	movq    %rsp, %rdi
 	movq    $-1, %rsi
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 	/* Unconditionally use kernel CR3 for do_nmi() */
 	/* %rax is saved above, so OK to clobber here */
 	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_KAISER
@@ -1819,7 +1819,7 @@ end_repeat_nmi:
 
 	/* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
 	call do_nmi
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 	/*
 	 * Unconditionally restore CR3.  We might be returning to
 	 * kernel code that needs user CR3, like just just before
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 0d89f538efb6..53ef274d2a89 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -441,7 +441,7 @@ early_idt_ripmsg:
 	.balign	PAGE_SIZE; \
 GLOBAL(name)
 
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
  * Each PGD needs to be 8k long and 8k aligned.  We do not
  * ever go out to userspace with these, so we do not
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 4c15b80bf7df..3fbf7de9e9bd 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -32,4 +32,4 @@ obj-$(CONFIG_ACPI_NUMA)		+= srat.o
 obj-$(CONFIG_NUMA_EMU)		+= numa_emulation.o
 
 obj-$(CONFIG_X86_INTEL_MPX)	+= mpx.o
-obj-$(CONFIG_KAISER)		+= kaiser.o
+obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= kaiser.o
diff --git a/include/linux/kaiser.h b/include/linux/kaiser.h
index 4a4d6d911a14..58c55b1589d0 100644
--- a/include/linux/kaiser.h
+++ b/include/linux/kaiser.h
@@ -1,7 +1,7 @@
 #ifndef _LINUX_KAISER_H
 #define _LINUX_KAISER_H
 
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 #include <asm/kaiser.h>
 
 static inline int kaiser_map_thread_stack(void *stack)
@@ -24,7 +24,7 @@ static inline void kaiser_unmap_thread_stack(void *stack)
 #else
 
 /*
- * These stubs are used whenever CONFIG_KAISER is off, which
+ * These stubs are used whenever CONFIG_PAGE_TABLE_ISOLATION is off, which
  * includes architectures that support KAISER, but have it disabled.
  */
 
@@ -48,5 +48,5 @@ static inline void kaiser_unmap_thread_stack(void *stack)
 {
 }
 
-#endif /* !CONFIG_KAISER */
+#endif /* !CONFIG_PAGE_TABLE_ISOLATION */
 #endif /* _LINUX_KAISER_H */
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 7cecbdbf5c25..7c2f5bb9e0e9 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -35,7 +35,7 @@
 
 #endif
 
-#ifdef CONFIG_KAISER
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 #define USER_MAPPED_SECTION "..user_mapped"
 #else
 #define USER_MAPPED_SECTION ""
diff --git a/security/Kconfig b/security/Kconfig
index ae44b94d63b2..b6e47c9d1a7e 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -31,7 +31,7 @@ config SECURITY
 
 	  If you are unsure how to answer this question, answer N.
 
-config KAISER
+config PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
 	default y
 	depends on X86_64 && SMP
-- 
2.16.2
