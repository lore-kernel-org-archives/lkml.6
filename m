Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2669103-1524408516-2-11177231564269826689
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524408515; b=IPe5gh3l2HWfLWpGGr+nd2+kp5jZegztG3YFllDDL6jnt+JDb8
    M8vxyazRR+Ty3sCfsZwwlDiv1UiO69Xy6xa4vtHAnwhUc8rZ/cIH6x/39kml2p3a
    zh7YF0bUFbdRY3YXYzxjQXqZY5MKXOmq0gmEsWmdMQed0z5mFmLs3LXMQZfECcp0
    6yNxL1j1Hn2zbuNVtSNCrFWttDki4A98st95ymI5vMQjRbDsjBdbaGZaTCxs3E4N
    WDPrL/nAitqAdpkXvnItp21QujIFXvZWTKe/h2MYCMsL72scFfHN9p1zJcEM+zMA
    vsBO8YHGMiV0FUSlxd0ZOsAEfgPu1x7joXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408515; bh=tY0vJ0LOZm/DcshbjD5K4CVzuYq63q
    ABwlUDzBhVFnM=; b=B1pstG1nqOaJmlFz976visJjmAUPIFPR7lNxGUHzXOwItL
    vSIFmF3veyzvo7nNHMDPk37rMlYR+xPMu3UvjWH5NLPdn63SRig9t16opqL1DVWz
    3RUDe7/iZkQt7xthxhl1kiEpeCWCqHnEgjBTYa2bn0ex4nfsVBSfDOXcjEUZuumB
    NlpwO4nLONeXXFlA6CCH2NYf3SBoFjinsC/vRYYoZ+b1C/FM+oFnR1KEQKmS/lXk
    T5nhlV/0aXV+UMVu+JG9tS1nrUojflSoi2tSBnaSNWZ3rNy7zCqO5Lwgi1vOJFKO
    Vkgwzaz+G24QfrIkFKUT5Rmz76S0WXrzox9xfd5g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFuZPtTilmbqD4M3X3v0+/cdlh6VfxOZlrqUaCTMOTN2Ezd+qgXZPXE9VxnCH0ceWEUlR+gNgwzQjq7U2qjE8eBJjzivOZjkeI4Ezp1uXG9YBejNI+EI
    yteR/mv+iV6305XJr36CqpnDs39SWAPgst85j+CQTDAogoO1o0wi+I6Toy+S2QlqIgmHbFZRDdZUBu72CB0fkHGdIkhHFMn9jTVJUXIn4YjPZg33rD2XVEdC
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=oGMlB6cnAAAA:8 a=JfrnYn6hAAAA:8 a=SOq6UgPBAAAA:8 a=pGLkceISAAAA:8
    a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
    a=ag1SF4gXAAAA:8 a=IV3m5VcIyq9bLZ6TerIA:9 a=692pNG4cfxfqRZD7:21
    a=dV-ap3tHUIG2xZiJ:21 a=QEXdDO2ut3YA:10 a=92Q717GQZsEA:10
    a=NdAtdrkLVvyUPsUoGJp4:22 a=1CNFftbPRP8L7MoqJWF3:22 a=3hv5r9HjGAh9o5iR9qwG:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbeDVOsL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:48:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbeDVOPz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:15:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 4.4 19/97] x86/hweight: Get rid of the special calling convention
Date: Sun, 22 Apr 2018 15:52:57 +0200
Message-Id: <20180422135305.695475552@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit f5967101e9de12addcda4510dfbac66d7c5779c3 upstream.

People complained about ARCH_HWEIGHT_CFLAGS and how it throws a wrench
into kcov, lto, etc, experimentations.

Add asm versions for __sw_hweight{32,64}() and do explicit saving and
restoring of clobbered registers. This gets rid of the special calling
convention. We get to call those functions on !X86_FEATURE_POPCNT CPUs.

We still need to hardcode POPCNT and register operands as some old gas
versions which we support, do not know about POPCNT.

Btw, remove redundant REX prefix from 32-bit POPCNT because alternatives
can do padding now.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1464605787-20603-1-git-send-email-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/Kconfig                    |    5 --
 arch/x86/include/asm/arch_hweight.h |   24 ++++-------
 arch/x86/kernel/i386_ksyms_32.c     |    2 
 arch/x86/kernel/x8664_ksyms_64.c    |    3 +
 arch/x86/lib/Makefile               |    2 
 arch/x86/lib/hweight.S              |   77 ++++++++++++++++++++++++++++++++++++
 lib/Makefile                        |    2 
 lib/hweight.c                       |    4 +
 8 files changed, 97 insertions(+), 22 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -280,11 +280,6 @@ config X86_32_LAZY_GS
 	def_bool y
 	depends on X86_32 && !CC_STACKPROTECTOR
 
-config ARCH_HWEIGHT_CFLAGS
-	string
-	default "-fcall-saved-ecx -fcall-saved-edx" if X86_32
-	default "-fcall-saved-rdi -fcall-saved-rsi -fcall-saved-rdx -fcall-saved-rcx -fcall-saved-r8 -fcall-saved-r9 -fcall-saved-r10 -fcall-saved-r11" if X86_64
-
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -2,8 +2,8 @@
 #define _ASM_X86_HWEIGHT_H
 
 #ifdef CONFIG_64BIT
-/* popcnt %edi, %eax -- redundant REX prefix for alignment */
-#define POPCNT32 ".byte 0xf3,0x40,0x0f,0xb8,0xc7"
+/* popcnt %edi, %eax */
+#define POPCNT32 ".byte 0xf3,0x0f,0xb8,0xc7"
 /* popcnt %rdi, %rax */
 #define POPCNT64 ".byte 0xf3,0x48,0x0f,0xb8,0xc7"
 #define REG_IN "D"
@@ -15,19 +15,15 @@
 #define REG_OUT "a"
 #endif
 
-/*
- * __sw_hweightXX are called from within the alternatives below
- * and callee-clobbered registers need to be taken care of. See
- * ARCH_HWEIGHT_CFLAGS in <arch/x86/Kconfig> for the respective
- * compiler switches.
- */
+#define __HAVE_ARCH_SW_HWEIGHT
+
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
-	unsigned int res = 0;
+	unsigned int res;
 
 	asm (ALTERNATIVE("call __sw_hweight32", POPCNT32, X86_FEATURE_POPCNT)
-		     : "="REG_OUT (res)
-		     : REG_IN (w));
+			 : "="REG_OUT (res)
+			 : REG_IN (w));
 
 	return res;
 }
@@ -51,11 +47,11 @@ static inline unsigned long __arch_hweig
 #else
 static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
-	unsigned long res = 0;
+	unsigned long res;
 
 	asm (ALTERNATIVE("call __sw_hweight64", POPCNT64, X86_FEATURE_POPCNT)
-		     : "="REG_OUT (res)
-		     : REG_IN (w));
+			 : "="REG_OUT (res)
+			 : REG_IN (w));
 
 	return res;
 }
--- a/arch/x86/kernel/i386_ksyms_32.c
+++ b/arch/x86/kernel/i386_ksyms_32.c
@@ -42,3 +42,5 @@ EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(___preempt_schedule);
 EXPORT_SYMBOL(___preempt_schedule_notrace);
 #endif
+
+EXPORT_SYMBOL(__sw_hweight32);
--- a/arch/x86/kernel/x8664_ksyms_64.c
+++ b/arch/x86/kernel/x8664_ksyms_64.c
@@ -42,6 +42,9 @@ EXPORT_SYMBOL(clear_page);
 
 EXPORT_SYMBOL(csum_partial);
 
+EXPORT_SYMBOL(__sw_hweight32);
+EXPORT_SYMBOL(__sw_hweight64);
+
 /*
  * Export string functions. We normally rely on gcc builtin for most of these,
  * but gcc sometimes decides not to inline them.
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -23,7 +23,7 @@ lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) +=
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
 
-obj-y += msr.o msr-reg.o msr-reg-export.o
+obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 
 ifeq ($(CONFIG_X86_32),y)
         obj-y += atomic64_32.o
--- /dev/null
+++ b/arch/x86/lib/hweight.S
@@ -0,0 +1,77 @@
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+
+/*
+ * unsigned int __sw_hweight32(unsigned int w)
+ * %rdi: w
+ */
+ENTRY(__sw_hweight32)
+
+#ifdef CONFIG_X86_64
+	movl %edi, %eax				# w
+#endif
+	__ASM_SIZE(push,) %__ASM_REG(dx)
+	movl %eax, %edx				# w -> t
+	shrl %edx				# t >>= 1
+	andl $0x55555555, %edx			# t &= 0x55555555
+	subl %edx, %eax				# w -= t
+
+	movl %eax, %edx				# w -> t
+	shrl $2, %eax				# w_tmp >>= 2
+	andl $0x33333333, %edx			# t	&= 0x33333333
+	andl $0x33333333, %eax			# w_tmp &= 0x33333333
+	addl %edx, %eax				# w = w_tmp + t
+
+	movl %eax, %edx				# w -> t
+	shrl $4, %edx				# t >>= 4
+	addl %edx, %eax				# w_tmp += t
+	andl  $0x0f0f0f0f, %eax			# w_tmp &= 0x0f0f0f0f
+	imull $0x01010101, %eax, %eax		# w_tmp *= 0x01010101
+	shrl $24, %eax				# w = w_tmp >> 24
+	__ASM_SIZE(pop,) %__ASM_REG(dx)
+	ret
+ENDPROC(__sw_hweight32)
+
+ENTRY(__sw_hweight64)
+#ifdef CONFIG_X86_64
+	pushq   %rdx
+
+	movq    %rdi, %rdx                      # w -> t
+	movabsq $0x5555555555555555, %rax
+	shrq    %rdx                            # t >>= 1
+	andq    %rdx, %rax                      # t &= 0x5555555555555555
+	movabsq $0x3333333333333333, %rdx
+	subq    %rax, %rdi                      # w -= t
+
+	movq    %rdi, %rax                      # w -> t
+	shrq    $2, %rdi                        # w_tmp >>= 2
+	andq    %rdx, %rax                      # t     &= 0x3333333333333333
+	andq    %rdi, %rdx                      # w_tmp &= 0x3333333333333333
+	addq    %rdx, %rax                      # w = w_tmp + t
+
+	movq    %rax, %rdx                      # w -> t
+	shrq    $4, %rdx                        # t >>= 4
+	addq    %rdx, %rax                      # w_tmp += t
+	movabsq $0x0f0f0f0f0f0f0f0f, %rdx
+	andq    %rdx, %rax                      # w_tmp &= 0x0f0f0f0f0f0f0f0f
+	movabsq $0x0101010101010101, %rdx
+	imulq   %rdx, %rax                      # w_tmp *= 0x0101010101010101
+	shrq    $56, %rax                       # w = w_tmp >> 56
+
+	popq    %rdx
+	ret
+#else /* CONFIG_X86_32 */
+	/* We're getting an u64 arg in (%eax,%edx): unsigned long hweight64(__u64 w) */
+	pushl   %ecx
+
+	call    __sw_hweight32
+	movl    %eax, %ecx                      # stash away result
+	movl    %edx, %eax                      # second part of input
+	call    __sw_hweight32
+	addl    %ecx, %eax                      # result
+
+	popl    %ecx
+	ret
+#endif
+ENDPROC(__sw_hweight64)
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -58,8 +58,6 @@ obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
-GCOV_PROFILE_hweight.o := n
-CFLAGS_hweight.o = $(subst $(quote),,$(CONFIG_ARCH_HWEIGHT_CFLAGS))
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 
 obj-$(CONFIG_BTREE) += btree.o
--- a/lib/hweight.c
+++ b/lib/hweight.c
@@ -9,6 +9,7 @@
  * The Hamming Weight of a number is the total number of bits set in it.
  */
 
+#ifndef __HAVE_ARCH_SW_HWEIGHT
 unsigned int __sw_hweight32(unsigned int w)
 {
 #ifdef CONFIG_ARCH_HAS_FAST_MULTIPLIER
@@ -25,6 +26,7 @@ unsigned int __sw_hweight32(unsigned int
 #endif
 }
 EXPORT_SYMBOL(__sw_hweight32);
+#endif
 
 unsigned int __sw_hweight16(unsigned int w)
 {
@@ -43,6 +45,7 @@ unsigned int __sw_hweight8(unsigned int
 }
 EXPORT_SYMBOL(__sw_hweight8);
 
+#ifndef __HAVE_ARCH_SW_HWEIGHT
 unsigned long __sw_hweight64(__u64 w)
 {
 #if BITS_PER_LONG == 32
@@ -65,3 +68,4 @@ unsigned long __sw_hweight64(__u64 w)
 #endif
 }
 EXPORT_SYMBOL(__sw_hweight64);
+#endif
