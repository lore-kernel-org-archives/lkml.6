Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162801-2-15378850405583148029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162800; b=fGQ/1Y3r0R5uPZPEFI98EGz9jWN6NAEedXW+S38cNkkrltxJVM
    TPQMv5+qkv1Gv1qL8wulhDnWuBsv42pv8VMtOur1vFdX07s/XISxB5drv0CM4DcM
    wPA3QKtGhKXPoceGK6hA84KFZVH5gY6Eb5gsKX8eEClV6zazDqmPqeSnFEWNyhVR
    XWmJTvc5WIA1d3J/65+QjpHa+6DQRlzbL1rUKKHthj0VV9wdEocvQYGBgFFu9cxX
    Qt4Tj21eHIqz4TYgqe6oYwyTp192VJQskrgq+RXwv1t+nmiDmLxtAqTTHypplc4G
    eXzksyL6MCu6FjPdE7Ns65zt6TvTuR1Mbz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162800; bh=0CEpkwr/ppqVsY+hjirdD4rxdmSwxG
    4TEh2lzVO6cEE=; b=Hds0JFcHJW5NQ3shYTlFJYa8OcioCCvpnttxPW11YNJJe2
    DbBow/vCm9ktarJdYg2ssBYOpNBghuxmRnpQ9VKDjbPwgafDsH8HPUsG2xh8rpyE
    ADujjOVQB+5JjYiXtyP89FqDXpJSIyyZ2ZepzVYT0mI84ZedYYGZ9aw8MPXCRFAV
    4HtkIEi2fRiUTiMJ33JgQPGSnJ5N7iEqvtV6tucdVijgLj9iW2VfRnoG0K7HWDd4
    LekO4zanzSBfW6N+IL6D+pR7CpqwFQBNUg+gVxjlo2ELuag9HrX4P38en67pcqRT
    Vd8CEAsVhCfAGdKrlVXCLTaqCpY++SjF4cIFAbmA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=TFkXbuWp x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=TFkXbuWp x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLndq6Ki9v6jCyz5txlkj0cI6wSDr5Zc6KBHQHFAQmHXd9p0oQcvT4ZYE4JGSxcVLxe7xgggZPYkvqiY1GhSbRFqg3SGurSTKOmCmvBXgzuu1rmYyKI4
    tMpJ5hUENGyNLgdostALCmx/Iz0301BmvdFPh/A17+Nyvj3tZ524AalvSZEGtKUBoYyr/sMuQTQR4386tJRRFarWv0QHfbm/4ef6s8F2833XXNNwNUJdEoQG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=HejVe6opIUS0hJEPyFcA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967109AbeEXLxR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966917AbeEXJq1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 79/92] s390/ftrace: use expoline for indirect branches
Date: Thu, 24 May 2018 11:38:56 +0200
Message-Id: <20180524093206.841974050@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
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

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit 23a4d7fd34856da8218c4cfc23dba7a6ec0a423a ]

The return from the ftrace_stub, _mcount, ftrace_caller and
return_to_handler functions is done with "br %r14" and "br %r1".
These are indirect branches as well and need to use execute
trampolines for CONFIG_EXPOLINE=y.

The ftrace_caller function is a special case as it returns to the
start of a function and may only use %r0 and %r1. For a pre z10
machine the standard execute trampoline uses a LARL + EX to do
this, but this requires *two* registers in the range %r1..%r15.
To get around this the 'br %r1' located in the lowcore is used,
then the EX instruction does not need an address register.
But the lowcore trick may only be used for pre z14 machines,
with noexec=on the mapping for the first page may not contain
instructions. The solution for that is an ALTERNATIVE in the
expoline THUNK generated by 'GEN_BR_THUNK %r1' to switch to
EXRL, this relies on the fact that a machine that supports
noexec=on has EXRL as well.

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/nospec-insn.h |   11 +++++++++++
 arch/s390/kernel/asm-offsets.c      |    1 +
 arch/s390/kernel/mcount.S           |   14 +++++++++-----
 3 files changed, 21 insertions(+), 5 deletions(-)

--- a/arch/s390/include/asm/nospec-insn.h
+++ b/arch/s390/include/asm/nospec-insn.h
@@ -2,6 +2,9 @@
 #ifndef _ASM_S390_NOSPEC_ASM_H
 #define _ASM_S390_NOSPEC_ASM_H
 
+#include <asm/alternative-asm.h>
+#include <asm/asm-offsets.h>
+
 #ifdef __ASSEMBLY__
 
 #ifdef CONFIG_EXPOLINE
@@ -76,13 +79,21 @@
 	.endm
 
 	.macro __THUNK_EX_BR reg,ruse
+	# Be very careful when adding instructions to this macro!
+	# The ALTERNATIVE replacement code has a .+10 which targets
+	# the "br \reg" after the code has been patched.
 #ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
 	exrl	0,555f
 	j	.
 #else
+	.ifc \reg,%r1
+	ALTERNATIVE "ex %r0,_LC_BR_R1", ".insn ril,0xc60000000000,0,.+10", 35
+	j	.
+	.else
 	larl	\ruse,555f
 	ex	0,0(\ruse)
 	j	.
+	.endif
 #endif
 555:	br	\reg
 	.endm
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -170,6 +170,7 @@ int main(void)
 	OFFSET(__LC_MACHINE_FLAGS, _lowcore, machine_flags);
 	OFFSET(__LC_GMAP, _lowcore, gmap);
 	OFFSET(__LC_PASTE, _lowcore, paste);
+	OFFSET(__LC_BR_R1, _lowcore, br_r1_trampoline);
 	/* software defined ABI-relevant lowcore locations 0xe00 - 0xe20 */
 	OFFSET(__LC_DUMP_REIPL, _lowcore, ipib);
 	/* hardware defined lowcore locations 0x1000 - 0x18ff */
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -8,12 +8,16 @@
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/ftrace.h>
+#include <asm/nospec-insn.h>
 #include <asm/ptrace.h>
 
+	GEN_BR_THUNK %r1
+	GEN_BR_THUNK %r14
+
 	.section .kprobes.text, "ax"
 
 ENTRY(ftrace_stub)
-	br	%r14
+	BR_EX	%r14
 
 #define STACK_FRAME_SIZE  (STACK_FRAME_OVERHEAD + __PT_SIZE)
 #define STACK_PTREGS	  (STACK_FRAME_OVERHEAD)
@@ -21,7 +25,7 @@ ENTRY(ftrace_stub)
 #define STACK_PTREGS_PSW  (STACK_PTREGS + __PT_PSW)
 
 ENTRY(_mcount)
-	br	%r14
+	BR_EX	%r14
 
 ENTRY(ftrace_caller)
 	.globl	ftrace_regs_caller
@@ -49,7 +53,7 @@ ENTRY(ftrace_caller)
 #endif
 	lgr	%r3,%r14
 	la	%r5,STACK_PTREGS(%r15)
-	basr	%r14,%r1
+	BASR_EX	%r14,%r1
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 # The j instruction gets runtime patched to a nop instruction.
 # See ftrace_enable_ftrace_graph_caller.
@@ -64,7 +68,7 @@ ftrace_graph_caller_end:
 #endif
 	lg	%r1,(STACK_PTREGS_PSW+8)(%r15)
 	lmg	%r2,%r15,(STACK_PTREGS_GPRS+2*8)(%r15)
-	br	%r1
+	BR_EX	%r1
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
@@ -77,6 +81,6 @@ ENTRY(return_to_handler)
 	aghi	%r15,STACK_FRAME_OVERHEAD
 	lgr	%r14,%r2
 	lmg	%r2,%r5,32(%r15)
-	br	%r14
+	BR_EX	%r14
 
 #endif
