Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691124-1527155211-2-14234624281888492490
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
    1527155210; b=chLFjNxTNrlnbeI10PXziNp2qjit1iBXMPfUL8xWpDjPFn8Z0e
    P8QQCe3F03xuX2vWS+YB+TbZHWmtF4cYrtrpgaPdq6xEPbAQU7o2Ljlz18FcY8jb
    adTeOWTPntNpOMBjqdbQeV0bELNhmaTPp0T5YfR33K2wAPwqbzXh+p/NsCP9ENxq
    qVuhtQUcZHfgQIprnvc2ja9K81Rpb8MzLxt82vzdTqSLJxU15ZfJ2KLPD7FBdaAF
    7IFDxosfnfPFMTZzRQOeBreLJ3e5Q2OD/E1Tasf1fDa5ibez8kWWcwmeOZ3oHfFD
    Z0mfaqxwAuOh1HYuTJKL94cDwTMiWzu5kWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155210; bh=Nq3tZDaueWqTuwuKS93yQ99nnRDPHQ
    yPZMIEf9coJjA=; b=FxxGfpx88ZNa2ussgITac6E4OwXsBRb3gjVoA2Wj/0XZT6
    ++y9gJU1jhkaGEXQoYTaqyZ7s7h/myhgRTQsevo6oDvhEgWxBL1Dux/6l8LIgrKN
    pBx7IxdsxJZNLK5c2xY016JMCtZWOX2naeYnY3CJC2mZEjCWgERF6wge5ksAT4yv
    cxZa3slyP6H/gCZhmFPHEeuVhZLEWEiLICHIUiSxKc8FxLbCoPFL2Zcchu8EYShH
    ncKMcEsZ3b3lmoftfR5Hkoc0PxaTYcqN1lG1PL4E3SMO4BGm05LjxcqG/pbheZk/
    y+H8jkDP+U0mGpwNd9KLHhjLVXzyyvxg/8ZXUkYA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=BWeSOYJl x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=BWeSOYJl x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMGv3KuKVDk0oQlB/4nIHX60yZq+Nf8UoA6Eud4dAZ8k4gp/Yh2LHRqLrtqQ5ZqKQnwbgFhRiCerYi8Xr4I4qNGiXXWPI/vPtA421zerBgkfOxCj/5PZ
    V55dwsEMo0FiE9h0wx0mKZqBJ1CGOH5U37HNGeyXnyZsyZcEHKBvUhbkfzeYavpfCDS617h873I3eQ8CJU4b0ALVKkylyUaZznF3tZ4zsRvmXbr/U6O3LLEu
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=aaA79tPBc2EpFUhZeY0A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966956AbeEXJqr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966941AbeEXJqm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 4.4 80/92] s390/kernel: use expoline for indirect branches
Date: Thu, 24 May 2018 11:38:57 +0200
Message-Id: <20180524093206.932186509@linuxfoundation.org>
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
 arch/s390/kernel/reipl.S  |    5 ++++-
 arch/s390/kernel/swsusp.S |   10 ++++++----
 3 files changed, 24 insertions(+), 15 deletions(-)

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
 
+	GEN_BR_THUNK %r14
+
 #
 # store_status
 #
@@ -62,7 +65,7 @@ ENTRY(store_status)
 	st	%r3,__LC_PSW_SAVE_AREA-SAVE_AREA_BASE + 4(%r1)
 	larl	%r2,store_status
 	stg	%r2,__LC_PSW_SAVE_AREA-SAVE_AREA_BASE + 8(%r1)
-	br	%r14
+	BR_EX	%r14
 
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
@@ -196,11 +199,10 @@ pgm_check_entry:
 	larl	%r15,init_thread_union
 	ahi	%r15,1<<(PAGE_SHIFT+THREAD_ORDER)
 	larl	%r2,.Lpanic_string
-	larl	%r3,_sclp_print_early
 	lghi	%r1,0
 	sam31
 	sigp	%r1,%r0,SIGP_SET_ARCHITECTURE
-	basr	%r14,%r3
+	brasl	%r14,_sclp_print_early
 	larl	%r3,.Ldisabled_wait_31
 	lpsw	0(%r3)
 4:
@@ -266,7 +268,7 @@ restore_registers:
 	/* Return 0 */
 	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
 	lghi	%r2,0
-	br	%r14
+	BR_EX	%r14
 
 	.section .data..nosave,"aw",@progbits
 	.align	8
