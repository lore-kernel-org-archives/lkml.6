Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757396-1527157675-2-11046022764258927677
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
    1527157675; b=kqfvjPnhNYjEGUdVns68rbaEpOgNysjGMSJo8H5t6wnHY9QE2H
    LFugSkz3+kxBVUBAL8AJh8FmQUIwlLFw3l2fH2PkYicRuTHKiqbUtqWzlSRSgEUE
    kG+4nu+SmrNvFLozW99KTlhJ55W1uQXetETYshZ+B4eOJFHbNqGwN9ah8LZQvzzw
    xZH6sWPf7ieEWV7Vd1FaDiCvh0jiRETJ7/YH9TQWVy60s3XHkINqVYF6LwJlJHVJ
    I7RSCvlT3gjTnYff7Cpz5AHsoSA8iKeVRqEwLGQdxEy5thB6wTwTUrdRCjl5L+gn
    lYyv+v8Xo0MI+Un0XPJfnO545k2Um01ghOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157675; bh=8YpkYYLIHkX8K1ul0ahdpSRyE5Ilq/
    vRQHbjlSw+9Tk=; b=W7BSrA1epcSfqqxvKNfu2u84fsi41hyztB43zfkVc5USRt
    YTVhG1HTGIzOgTUJPMD781S+zosoHL8/1CUT8qxzx/GwbvHAMLzLBNTyZpiM5u2Z
    acr8H/Tla+zW7RfUa4UO1tx3Opc6EVvrKlMNbRkp6NgMDy6K+nPNbMP6M+YEAHm/
    07jlz9rzFfzDfZtX2Q2SubARweUHuQb/S8XqASEy3WS9hklcRx6dua9VcduepJzg
    GbGfvQNiK5ohY/LDvwh2zWxtHvTfXnymDr6sBuskPEHcgqDbkZJG1IhtvEfUm9vO
    NipBOKsVYNVDkHeESzEf3yReMW+tazEIbfCkO49w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=gp0JsMCk x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=gp0JsMCk x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfBtCFd1T2l2VTswZNE6IygaE2SEbJbszbwyAIH3x3i6X2Gqh54zefJyuvZgj2POFobay0+z0IVWq7I83z4nDZmzsNbovpGeL9Xo4Yly+cQUmoN+eCHN9
    2U5QsrP46YZBRdw3IaQp3NfAavYepXSUzcl2ULU8bR7lkxy1/uyP2anHh72+SQq79f2vCpm2bCtB7UPViqykAk10CI0ULkoaorDn6PJWNyxEQlgNpt6qY8vV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=1jzKh_6GKXueggxyDnkA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030808AbeEXKBg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030959AbeEXKBb (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 059/161] s390/ftrace: use expoline for indirect branches
Date: Thu, 24 May 2018 11:38:04 +0200
Message-Id: <20180524093025.565807040@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 arch/s390/include/asm/nospec-insn.h |   12 ++++++++++++
 arch/s390/kernel/asm-offsets.c      |    1 +
 arch/s390/kernel/mcount.S           |   14 +++++++++-----
 3 files changed, 22 insertions(+), 5 deletions(-)

--- a/arch/s390/include/asm/nospec-insn.h
+++ b/arch/s390/include/asm/nospec-insn.h
@@ -2,12 +2,16 @@
 #ifndef _ASM_S390_NOSPEC_ASM_H
 #define _ASM_S390_NOSPEC_ASM_H
 
+#include <asm/alternative-asm.h>
+#include <asm/asm-offsets.h>
 #include <asm/dwarf.h>
 
 #ifdef __ASSEMBLY__
 
 #ifdef CONFIG_EXPOLINE
 
+_LC_BR_R1 = __LC_BR_R1
+
 /*
  * The expoline macros are used to create thunks in the same format
  * as gcc generates them. The 'comdat' section flag makes sure that
@@ -78,13 +82,21 @@
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
@@ -179,6 +179,7 @@ int main(void)
 	OFFSET(__LC_MACHINE_FLAGS, lowcore, machine_flags);
 	OFFSET(__LC_PREEMPT_COUNT, lowcore, preempt_count);
 	OFFSET(__LC_GMAP, lowcore, gmap);
+	OFFSET(__LC_BR_R1, lowcore, br_r1_trampoline);
 	/* software defined ABI-relevant lowcore locations 0xe00 - 0xe20 */
 	OFFSET(__LC_DUMP_REIPL, lowcore, ipib);
 	/* hardware defined lowcore locations 0x1000 - 0x18ff */
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -9,13 +9,17 @@
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/ftrace.h>
+#include <asm/nospec-insn.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
 
+	GEN_BR_THUNK %r1
+	GEN_BR_THUNK %r14
+
 	.section .kprobes.text, "ax"
 
 ENTRY(ftrace_stub)
-	br	%r14
+	BR_EX	%r14
 
 #define STACK_FRAME_SIZE  (STACK_FRAME_OVERHEAD + __PT_SIZE)
 #define STACK_PTREGS	  (STACK_FRAME_OVERHEAD)
@@ -23,7 +27,7 @@ ENTRY(ftrace_stub)
 #define STACK_PTREGS_PSW  (STACK_PTREGS + __PT_PSW)
 
 ENTRY(_mcount)
-	br	%r14
+	BR_EX	%r14
 
 EXPORT_SYMBOL(_mcount)
 
@@ -53,7 +57,7 @@ ENTRY(ftrace_caller)
 #endif
 	lgr	%r3,%r14
 	la	%r5,STACK_PTREGS(%r15)
-	basr	%r14,%r1
+	BASR_EX	%r14,%r1
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 # The j instruction gets runtime patched to a nop instruction.
 # See ftrace_enable_ftrace_graph_caller.
@@ -68,7 +72,7 @@ ftrace_graph_caller_end:
 #endif
 	lg	%r1,(STACK_PTREGS_PSW+8)(%r15)
 	lmg	%r2,%r15,(STACK_PTREGS_GPRS+2*8)(%r15)
-	br	%r1
+	BR_EX	%r1
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
@@ -81,6 +85,6 @@ ENTRY(return_to_handler)
 	aghi	%r15,STACK_FRAME_OVERHEAD
 	lgr	%r14,%r2
 	lmg	%r2,%r5,32(%r15)
-	br	%r14
+	BR_EX	%r14
 
 #endif
