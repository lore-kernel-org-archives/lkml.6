Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3155980-1517855154-2-5867209687423950088
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855153; b=M5/d/MMpq/+dLGpn8vmoRyqYWODw8FjeWVtVNd+p9wCqm5o
    5HNGTB5dPVRjWltL0U4RVzGBkGufsnXQdmgISkDRqwC9CYG8C/ToyNRW34aRl7Op
    Oj68w9Fg/pRtWzS0o9HKpqST7cFOdxONM8X013KUTmAuNmUeMaOp5hgNnh0dLk7V
    pc7tLrlJX8GqpEXCUjXQcRF1w3KqbTpugqIO9B4LLxfN/mpjQhMkpWHKVLErPEbu
    uoe70eQKUJRLg4iWl39HDAttn2WDEk1ym+fLEOdeF6nneOpkQaPGph73DTF3fP46
    MkWgrmN6nYWchKUhpOTE24ll0/IFo1Y6NZLMjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855153; bh=pzwpw7ZAF7h/GZlAUNwVp/B34l
    C1MC2YgbMXpzr4cL8=; b=IwXoZPT0+mugb+V9hk57+1ibNUDU7bPNuk1eCgHNxC
    hZz0ZoH1t0RlKKH0+v+AnoanXFOcTAReHJZl0wtWGlKm9yIackrSjvIXJ6d2jNNZ
    FgRk9aZKn7Y24YX+yFyBmQua7GWvtrZEWgp9mpn6Ftre9Byt7X66BEOwAslL5URO
    4xfQhleQEvMQS+1GaztIF+X2kptIq2LtQY/O2ZiXvDQw6OZ3ZY+Wu+CmxgYh7Rx9
    VZpP4/1/qP1JX1F7iRO9AoIpAeAQqP3NygXeM6YGIsSVaSnktVDMg2m8yWVX3vuC
    QoN1Uf409vCvocygTKBBgah90KsfDvnoev5nKR4pK02w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753788AbeBESZm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:25:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52602 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753459AbeBESZ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:25:27 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, ak@linux.intel.com,
        dave.hansen@intel.com, karahmed@amazon.de, arjan@linux.intel.com,
        torvalds@linux-foundation.org, peterz@infradead.org, bp@alien8.de,
        pbonzini@redhat.com, tim.c.chen@linux.intel.com,
        gregkh@linux-foundation.org
Subject: [PATCH 4.15 16/60] x86/retpoline: Simplify vmexit_fill_RSB()
Date: Mon,  5 Feb 2018 10:22:49 -0800
Message-Id: <20180205182214.592329449@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov bp@alien8.de

commit 1dde7415e99933bb7293d6b2843752cbdb43ec11

Simplify it to call an asm-function instead of pasting 41 insn bytes at
every call site. Also, add alignment to the macro as suggested here:

  https://support.google.com/faqs/answer/7625886

[dwmw2: Clean up comments, let it clobber %ebx and just tell the compiler]

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1517070274-12128-3-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/entry/entry_32.S             |    3 -
 arch/x86/entry/entry_64.S             |    3 -
 arch/x86/include/asm/asm-prototypes.h |    3 +
 arch/x86/include/asm/nospec-branch.h  |   70 +++-------------------------------
 arch/x86/lib/Makefile                 |    1 
 arch/x86/lib/retpoline.S              |   56 +++++++++++++++++++++++++++
 6 files changed, 71 insertions(+), 65 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -252,7 +252,8 @@ ENTRY(__switch_to_asm)
 	 * exist, overwrite the RSB with entries which capture
 	 * speculative execution to prevent attack.
 	 */
-	FILL_RETURN_BUFFER %ebx, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
+	/* Clobbers %ebx */
+	FILL_RETURN_BUFFER RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
 #endif
 
 	/* restore callee-saved registers */
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -499,7 +499,8 @@ ENTRY(__switch_to_asm)
 	 * exist, overwrite the RSB with entries which capture
 	 * speculative execution to prevent attack.
 	 */
-	FILL_RETURN_BUFFER %r12, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
+	/* Clobbers %rbx */
+	FILL_RETURN_BUFFER RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
 #endif
 
 	/* restore callee-saved registers */
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -38,4 +38,7 @@ INDIRECT_THUNK(dx)
 INDIRECT_THUNK(si)
 INDIRECT_THUNK(di)
 INDIRECT_THUNK(bp)
+asmlinkage void __fill_rsb(void);
+asmlinkage void __clear_rsb(void);
+
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -7,50 +7,6 @@
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
 
-/*
- * Fill the CPU return stack buffer.
- *
- * Each entry in the RSB, if used for a speculative 'ret', contains an
- * infinite 'pause; lfence; jmp' loop to capture speculative execution.
- *
- * This is required in various cases for retpoline and IBRS-based
- * mitigations for the Spectre variant 2 vulnerability. Sometimes to
- * eliminate potentially bogus entries from the RSB, and sometimes
- * purely to ensure that it doesn't get empty, which on some CPUs would
- * allow predictions from other (unwanted!) sources to be used.
- *
- * We define a CPP macro such that it can be used from both .S files and
- * inline assembly. It's possible to do a .macro and then include that
- * from C via asm(".include <asm/nospec-branch.h>") but let's not go there.
- */
-
-#define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
-#define RSB_FILL_LOOPS		16	/* To avoid underflow */
-
-/*
- * Google experimented with loop-unrolling and this turned out to be
- * the optimal version — two calls, each with their own speculation
- * trap should their return address end up getting used, in a loop.
- */
-#define __FILL_RETURN_BUFFER(reg, nr, sp)	\
-	mov	$(nr/2), reg;			\
-771:						\
-	call	772f;				\
-773:	/* speculation trap */			\
-	pause;					\
-	lfence;					\
-	jmp	773b;				\
-772:						\
-	call	774f;				\
-775:	/* speculation trap */			\
-	pause;					\
-	lfence;					\
-	jmp	775b;				\
-774:						\
-	dec	reg;				\
-	jnz	771b;				\
-	add	$(BITS_PER_LONG/8) * nr, sp;
-
 #ifdef __ASSEMBLY__
 
 /*
@@ -121,17 +77,10 @@
 #endif
 .endm
 
- /*
-  * A simpler FILL_RETURN_BUFFER macro. Don't make people use the CPP
-  * monstrosity above, manually.
-  */
-.macro FILL_RETURN_BUFFER reg:req nr:req ftr:req
+/* This clobbers the BX register */
+.macro FILL_RETURN_BUFFER nr:req ftr:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE "jmp .Lskip_rsb_\@",				\
-		__stringify(__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP))	\
-		\ftr
-.Lskip_rsb_\@:
+	ALTERNATIVE "", "call __clear_rsb", \ftr
 #endif
 .endm
 
@@ -206,15 +155,10 @@ extern char __indirect_thunk_end[];
 static inline void vmexit_fill_RSB(void)
 {
 #ifdef CONFIG_RETPOLINE
-	unsigned long loops;
-
-	asm volatile (ANNOTATE_NOSPEC_ALTERNATIVE
-		      ALTERNATIVE("jmp 910f",
-				  __stringify(__FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1)),
-				  X86_FEATURE_RETPOLINE)
-		      "910:"
-		      : "=r" (loops), ASM_CALL_CONSTRAINT
-		      : : "memory" );
+	alternative_input("",
+			  "call __fill_rsb",
+			  X86_FEATURE_RETPOLINE,
+			  ASM_NO_INPUT_CLOBBER(_ASM_BX, "memory"));
 #endif
 }
 
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -27,6 +27,7 @@ lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) +=
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
+OBJECT_FILES_NON_STANDARD_retpoline.o :=y
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -7,6 +7,7 @@
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/bitsperlong.h>
 
 .macro THUNK reg
 	.section .text.__x86.indirect_thunk
@@ -46,3 +47,58 @@ GENERATE_THUNK(r13)
 GENERATE_THUNK(r14)
 GENERATE_THUNK(r15)
 #endif
+
+/*
+ * Fill the CPU return stack buffer.
+ *
+ * Each entry in the RSB, if used for a speculative 'ret', contains an
+ * infinite 'pause; lfence; jmp' loop to capture speculative execution.
+ *
+ * This is required in various cases for retpoline and IBRS-based
+ * mitigations for the Spectre variant 2 vulnerability. Sometimes to
+ * eliminate potentially bogus entries from the RSB, and sometimes
+ * purely to ensure that it doesn't get empty, which on some CPUs would
+ * allow predictions from other (unwanted!) sources to be used.
+ *
+ * Google experimented with loop-unrolling and this turned out to be
+ * the optimal version - two calls, each with their own speculation
+ * trap should their return address end up getting used, in a loop.
+ */
+.macro STUFF_RSB nr:req sp:req
+	mov	$(\nr / 2), %_ASM_BX
+	.align 16
+771:
+	call	772f
+773:						/* speculation trap */
+	pause
+	lfence
+	jmp	773b
+	.align 16
+772:
+	call	774f
+775:						/* speculation trap */
+	pause
+	lfence
+	jmp	775b
+	.align 16
+774:
+	dec	%_ASM_BX
+	jnz	771b
+	add	$((BITS_PER_LONG/8) * \nr), \sp
+.endm
+
+#define RSB_FILL_LOOPS		16	/* To avoid underflow */
+
+ENTRY(__fill_rsb)
+	STUFF_RSB RSB_FILL_LOOPS, %_ASM_SP
+	ret
+END(__fill_rsb)
+EXPORT_SYMBOL_GPL(__fill_rsb)
+
+#define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
+
+ENTRY(__clear_rsb)
+	STUFF_RSB RSB_CLEAR_LOOPS, %_ASM_SP
+	ret
+END(__clear_rsb)
+EXPORT_SYMBOL_GPL(__clear_rsb)
