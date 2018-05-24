Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156219-2-6751394278866545791
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
    1527156216; b=YDetFok9uebPFIU9Sa3DA8pHTfIYPTcrnvllNgm3wVFVMneYfi
    N4K50zQDxuAhafGSTlSUOLOFnfqDdUyCHj7LhNII7PAwubQxDP0fcC9Gf00SixGS
    QBw7H2c2AKSJQipXm34edN8UTtjM7ZszgXbBsNUIkrNytrPV9gpePFLN3plc4Xh3
    w1dYumvhb+jTIM6CkO46qglQSo6KTpxs5PMsbzi9HofwimaIu8Ml3+mKxCDWSfe8
    o/WYjmC2JpbVYMhF7Ef0Md5S7uiqZOasJx1EcHSEEamf4rWbg7tSCCiEDO4YNJQB
    PQf5nUindmaedbTzIIoEdfQqtUdTT61lCK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156216; bh=VMNbnqksHNL/xfUw7c5zvxptdWyOTr
    NWNXf6GBHOfFk=; b=lxuUezj08uRKlinF3+GgnmsKmLGGh6bE18S8kngVMRUD8U
    ee9SF5Hy2EWd7ctahYHkM70mADIpmHmrnWQ7K8NIk81XuqZ0sc3zl9A3YJgF9e49
    4skKYymu6xrcNKQZYCOme3fFpALPFnNGJm+Mlu4B/nHJIavGrIy0Qh6VsiNprkyu
    Yf0ExAizoWEXWttVVb4ZrYxFHiSj4wmGvbmLKbP9577iPWRC9rUMrGfjW227/z0m
    wI++0ySFTMkArKzrWxYCkQKdxFdb9xGoGZTysB4p3lzn8ll/kHH+HPaY8Wfzwg1x
    SN9r4XZBfjwRh8IHmROMnjnFRmBD31ErqTttoL9A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=MVIRqfU6 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=MVIRqfU6 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEQ0FVdrWomh27/2yQCcMYPjWxp+bC5LC3gMtqd8qGPaj0eP4KcXuL2DsNNX4qr9zm4mIvsbIdUH0Pm0B0L8nnuJwsZD0Nz3NqIp2TlLxdbx4a0dyd43
    kdFKzSBP4naO1RgMWgJIVIqHeM91uldnDwCRvst8/WyDjFG1P13YVz8XNI219lfAOEFvhhedyvV5nqvRZ/cPE0Xd4Mzfexm2hweQM9z+ODvDwOjuMq9Uw6Ph
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=suPktWdsvX3gACQoSc8A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031281AbeEXKDc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030922AbeEXKD3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:03:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 4.16 060/161] s390/kernel: use expoline for indirect branches
Date: Thu, 24 May 2018 11:38:05 +0200
Message-Id: <20180524093025.685282107@linuxfoundation.org>
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
 arch/s390/kernel/swsusp.S |   10 ++++++----
 3 files changed, 25 insertions(+), 16 deletions(-)

--- a/arch/s390/kernel/base.S
+++ b/arch/s390/kernel/base.S
@@ -9,18 +9,22 @@
 
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
@@ -37,10 +41,10 @@ ENTRY(s390_base_ext_handler)
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
@@ -57,10 +61,10 @@ ENTRY(s390_base_pgm_handler)
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
@@ -117,7 +121,7 @@ ENTRY(diag308_reset)
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
@@ -7,8 +7,11 @@
 
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
 #include <asm/sigp.h>
 
+	GEN_BR_THUNK %r9
+
 #
 # Issue "store status" for the current CPU to its prefix page
 # and call passed function afterwards
@@ -67,9 +70,9 @@ ENTRY(store_status)
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
@@ -13,6 +13,7 @@
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
 #include <asm/sigp.h>
 
 /*
@@ -24,6 +25,8 @@
  * (see below) in the resume process.
  * This function runs with disabled interrupts.
  */
+	GEN_BR_THUNK %r14
+
 	.section .text
 ENTRY(swsusp_arch_suspend)
 	stmg	%r6,%r15,__SF_GPRS(%r15)
@@ -103,7 +106,7 @@ ENTRY(swsusp_arch_suspend)
 	spx	0x318(%r1)
 	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
 	lghi	%r2,0
-	br	%r14
+	BR_EX	%r14
 
 /*
  * Restore saved memory image to correct place and restore register context.
@@ -197,11 +200,10 @@ pgm_check_entry:
 	larl	%r15,init_thread_union
 	ahi	%r15,1<<(PAGE_SHIFT+THREAD_SIZE_ORDER)
 	larl	%r2,.Lpanic_string
-	larl	%r3,sclp_early_printk
 	lghi	%r1,0
 	sam31
 	sigp	%r1,%r0,SIGP_SET_ARCHITECTURE
-	basr	%r14,%r3
+	brasl	%r14,sclp_early_printk
 	larl	%r3,.Ldisabled_wait_31
 	lpsw	0(%r3)
 4:
@@ -267,7 +269,7 @@ restore_registers:
 	/* Return 0 */
 	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
 	lghi	%r2,0
-	br	%r14
+	BR_EX	%r14
 
 	.section .data..nosave,"aw",@progbits
 	.align	8
