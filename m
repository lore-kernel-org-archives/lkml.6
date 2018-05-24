Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162515-4-10781412359756281890
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162514; b=hkXH+kMY5Jp7z67PRA+zVxqRuGh5XHWUceAvNDX8W9IjMPlJmf
    u2ZYNC+//gqwDuGBSnZ3i0C1A7zod9uJ+VlgmTHR2sdVIoxvVv8I2NqYXOqqgdha
    80YPHI+36bkRjffRgH0PQRGRIgoikzjZWCvd9YTjyuZv/GhMjA/7bIFO1TSp+8Dm
    Oq6ii4yuSWkdok70SlvtocaQkVOKkw24nrEAA4gL5UTOqlHtBh3Dg4I++cfvGqZa
    9JiRLDvqLxKWvTIIr/Sln1REAgx6n+DiLabnL2HZ2NTwaibBRkFCdB9HGUNsFj7L
    54WnaOD+RzutH7ZRd5eXj1vKWl9EM2LVZwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162514; bh=6sIC4eKMdCpiympq4I1ZBUjOC6WLJX
    kaUgV0vWU9w7A=; b=Gd7Vff0HeJ0xqKee0pWrLISN9ALeaFowwNaVitGAC0E7gn
    ycLkvJjHbwMxUOXx8wXC5zjlUcG00qgMsAmLwsugOlLQEUzbMVjZPrujeO3Btt8X
    akTjGKe0xWzwlVud98K7gYR0apn82WM3H7BrG8RVAAvrGfm+kRE1k0xr6j7ZhiOR
    Y+ZoF1MKDCxiJ5VtN5hWl4hg29lCsV02lxSWs10TfIRnp7dr64i+aw3Xj7JkcZ8I
    r/GVHqZXBX8KTA1/VPgPEk8rEddThzdLxJzLXKIqnpSyXOlVI65PCPwBdg6I/U32
    SBWY+I7uMpCjm76ORGb1FgRodFg58awksEA2y3eA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=f0SaSoW2 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=f0SaSoW2 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNCbd03aCvbRqpml7kn6t/FM79pyE/T8FtCLEkDkG7ITCuuku0VibY7D7sk3y0EcRTj8OfW6KmBbDqS3D4tBneiMYn0N181M+JqQhNXjJq/SxFdZXdUR
    FQuEGEzj5xApTT+Nd4gY7lTtML29OErmm1hgWOyz7OjvPtSpZvu3BgDf8mPd6zy9L3FDVrUJlqDjSQ7Uj1MHqIDA0XjIzIThqfEgYxnJQUXmh3bGHi3yvfbG
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=4AVweTjIB319inlOEd8A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967218AbeEXLsR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966609AbeEXJrU (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 4.9 14/96] s390/kernel: use expoline for indirect branches
Date: Thu, 24 May 2018 11:37:57 +0200
Message-Id: <20180524093606.388094392@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit c50c84c3ac4d5db683904bdb3257798b6ef980ae ]

The assember code in arch/s390/kernel uses a few more indirect branches
which need to be done with execute trampolines for CONFIG_EXPOLINE=y.

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/base.S   |   24 ++++++++++++++----------
 arch/s390/kernel/reipl.S  |    7 +++++--
 arch/s390/kernel/swsusp.S |    9 ++++++---
 3 files changed, 25 insertions(+), 15 deletions(-)

--- a/arch/s390/kernel/base.S
+++ b/arch/s390/kernel/base.S
@@ -8,18 +8,22 @@
 
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
 #include <asm/ptrace.h>
 #include <asm/sigp.h>
 
+	GEN_BR_THUNK %r9
+	GEN_BR_THUNK %r14
+
 ENTRY(s390_base_mcck_handler)
 	basr	%r13,0
 0:	lg	%r15,__LC_PANIC_STACK	# load panic stack
 	aghi	%r15,-STACK_FRAME_OVERHEAD
 	larl	%r1,s390_base_mcck_handler_fn
-	lg	%r1,0(%r1)
-	ltgr	%r1,%r1
+	lg	%r9,0(%r1)
+	ltgr	%r9,%r9
 	jz	1f
-	basr	%r14,%r1
+	BASR_EX	%r14,%r9
 1:	la	%r1,4095
 	lmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)
 	lpswe	__LC_MCK_OLD_PSW
@@ -36,10 +40,10 @@ ENTRY(s390_base_ext_handler)
 	basr	%r13,0
 0:	aghi	%r15,-STACK_FRAME_OVERHEAD
 	larl	%r1,s390_base_ext_handler_fn
-	lg	%r1,0(%r1)
-	ltgr	%r1,%r1
+	lg	%r9,0(%r1)
+	ltgr	%r9,%r9
 	jz	1f
-	basr	%r14,%r1
+	BASR_EX	%r14,%r9
 1:	lmg	%r0,%r15,__LC_SAVE_AREA_ASYNC
 	ni	__LC_EXT_OLD_PSW+1,0xfd	# clear wait state bit
 	lpswe	__LC_EXT_OLD_PSW
@@ -56,10 +60,10 @@ ENTRY(s390_base_pgm_handler)
 	basr	%r13,0
 0:	aghi	%r15,-STACK_FRAME_OVERHEAD
 	larl	%r1,s390_base_pgm_handler_fn
-	lg	%r1,0(%r1)
-	ltgr	%r1,%r1
+	lg	%r9,0(%r1)
+	ltgr	%r9,%r9
 	jz	1f
-	basr	%r14,%r1
+	BASR_EX	%r14,%r9
 	lmg	%r0,%r15,__LC_SAVE_AREA_SYNC
 	lpswe	__LC_PGM_OLD_PSW
 1:	lpswe	disabled_wait_psw-0b(%r13)
@@ -116,7 +120,7 @@ ENTRY(diag308_reset)
 	larl	%r4,.Lcontinue_psw	# Restore PSW flags
 	lpswe	0(%r4)
 .Lcontinue:
-	br	%r14
+	BR_EX	%r14
 .align 16
 .Lrestart_psw:
 	.long	0x00080000,0x80000000 + .Lrestart_part2
--- a/arch/s390/kernel/reipl.S
+++ b/arch/s390/kernel/reipl.S
@@ -6,8 +6,11 @@
 
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
 #include <asm/sigp.h>
 
+	GEN_BR_THUNK %r9
+
 #
 # Issue "store status" for the current CPU to its prefix page
 # and call passed function afterwards
@@ -66,9 +69,9 @@ ENTRY(store_status)
 	st	%r4,0(%r1)
 	st	%r5,4(%r1)
 	stg	%r2,8(%r1)
-	lgr	%r1,%r2
+	lgr	%r9,%r2
 	lgr	%r2,%r3
-	br	%r1
+	BR_EX	%r9
 
 	.section .bss
 	.align	8
--- a/arch/s390/kernel/swsusp.S
+++ b/arch/s390/kernel/swsusp.S
@@ -12,6 +12,7 @@
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
 #include <asm/sigp.h>
 
 /*
@@ -23,6 +24,8 @@
  * (see below) in the resume process.
  * This function runs with disabled interrupts.
  */
+	GEN_BR_THUNK %r14
+
 	.section .text
 ENTRY(swsusp_arch_suspend)
 	stmg	%r6,%r15,__SF_GPRS(%r15)
@@ -102,7 +105,7 @@ ENTRY(swsusp_arch_suspend)
 	spx	0x318(%r1)
 	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
 	lghi	%r2,0
-	br	%r14
+	BR_EX	%r14
 
 /*
  * Restore saved memory image to correct place and restore register context.
@@ -200,7 +203,7 @@ pgm_check_entry:
 	lghi	%r1,0
 	sam31
 	sigp	%r1,%r0,SIGP_SET_ARCHITECTURE
-	basr	%r14,%r3
+	brasl	%r14,_sclp_print_early
 	larl	%r3,.Ldisabled_wait_31
 	lpsw	0(%r3)
 4:
@@ -266,7 +269,7 @@ restore_registers:
 	/* Return 0 */
 	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
 	lghi	%r2,0
-	br	%r14
+	BR_EX	%r14
 
 	.section .data..nosave,"aw",@progbits
 	.align	8
