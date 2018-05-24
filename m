Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162711-2-12663997232181298856
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
    1527162710; b=dmKRJqHWXXtkDAsQrwTqIHuniwjuUoyHHaFRQe6ODUGu28VZIU
    EJRwbfwrmL7ZsvWmivlOkpxL04b5NUi6+FE1NaUao5bRF2SCKCZg3zZSMxsGQ2uS
    /mauNWERUrcauzwgBLZb6GhSe/IayxjmlVzaKhPZwOVh3I06j88VZxEegBW/lIAn
    vsaMXvXe4ZXnl48jN6yJh3R5FtbP0Y6Phih6av1jtkdG11pv+DgrrEhTUx4hIW9y
    D/GLGK7Spx2tZ5GttErlY/9/uTmCZ544OL0VZHmZ231TIO/DSPWHwzIwv64gFe/w
    E6x9zWIwKUjdWYtAsBs1hMpa3nyuZxhFE5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162710; bh=Xxhh5Z7hRYbs01dSaHxS7tsFZ7tvmm
    inVqqFKCfkUnQ=; b=XilxoF/qSPuO6AXo+M9i2Wid8X0KDbVY5S8t+BPAykIe7A
    jfAfkmwTqSoag81J8tVG8+gtPn8N37TmmupxLiLgvePUZmbDabZVzURs9rBzML0B
    dgNiyGf3WevBRgVPbMeAE0xxHSJPG4SBjiV9vdakSUKYoiqQs5oG6EYYIazlI9hz
    zDyrX9McXLIhYGyjgJF6KXMqaD1yNgznrH16yBzfWSHKvgpHJrr4eX9V62FPpNrP
    MPqC1ZhWLgXi71FvRsdB0j3xNJ9fDOSxsWpH4Ak+/YIEPA3aUZ7QjmhXqj89VAm4
    fiioymzYMdD4J63j3+Y3/KQUWJjPUJoL5xM2DFXw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=L98m3s8H x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=L98m3s8H x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfO6UrXiQljRSz4TR/dGWdIyvqfwUh5Z61mVgKANHK6V915tI3jaFYpmOJw9mxwxJJLlGhJg0yevBroJScuUoJQD0OG5caLleQtAjdqV+ydBAUTYyMFhY
    b7fdIGyj5GMZaUAMyZuBTQhiGf3rwq8wLiXrf2S1UioCDRSD5TUrPhu5iqswDaWffHfUlbEUUpiMzXTIAMRNNH6in+tT1Tas6cnuWU9ZG9TlokZrYFBZRpq0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=VIz4TFLUqtGzUdz3HiIA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969286AbeEXLvj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966958AbeEXJqr (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 82/92] s390: extend expoline to BC instructions
Date: Thu, 24 May 2018 11:38:59 +0200
Message-Id: <20180524093207.128843941@linuxfoundation.org>
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

[ Upstream commit 6deaa3bbca804b2a3627fd685f75de64da7be535 ]

The BPF JIT uses a 'b <disp>(%r<x>)' instruction in the definition
of the sk_load_word and sk_load_half functions.

Add support for branch-on-condition instructions contained in the
thunk code of an expoline.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/nospec-insn.h |   57 ++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/nospec-branch.c    |   25 ++++++++++++---
 2 files changed, 77 insertions(+), 5 deletions(-)

--- a/arch/s390/include/asm/nospec-insn.h
+++ b/arch/s390/include/asm/nospec-insn.h
@@ -32,10 +32,18 @@
 	__THUNK_PROLOG_NAME __s390x_indirect_jump_r\r2\()use_r\r1
 	.endm
 
+	.macro __THUNK_PROLOG_BC d0,r1,r2
+	__THUNK_PROLOG_NAME __s390x_indirect_branch_\d0\()_\r2\()use_\r1
+	.endm
+
 	.macro __THUNK_BR r1,r2
 	jg	__s390x_indirect_jump_r\r2\()use_r\r1
 	.endm
 
+	.macro __THUNK_BC d0,r1,r2
+	jg	__s390x_indirect_branch_\d0\()_\r2\()use_\r1
+	.endm
+
 	.macro __THUNK_BRASL r1,r2,r3
 	brasl	\r1,__s390x_indirect_jump_r\r3\()use_r\r2
 	.endm
@@ -78,6 +86,23 @@
 	.endif
 	.endm
 
+	.macro	__DECODE_DRR expand,disp,reg,ruse
+	.set __decode_fail,1
+	.irp r1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \reg,%r\r1
+	.irp r2,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \ruse,%r\r2
+	\expand \disp,\r1,\r2
+	.set __decode_fail,0
+	.endif
+	.endr
+	.endif
+	.endr
+	.if __decode_fail == 1
+	.error "__DECODE_DRR failed"
+	.endif
+	.endm
+
 	.macro __THUNK_EX_BR reg,ruse
 	# Be very careful when adding instructions to this macro!
 	# The ALTERNATIVE replacement code has a .+10 which targets
@@ -98,12 +123,30 @@
 555:	br	\reg
 	.endm
 
+	.macro __THUNK_EX_BC disp,reg,ruse
+#ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
+	exrl	0,556f
+	j	.
+#else
+	larl	\ruse,556f
+	ex	0,0(\ruse)
+	j	.
+#endif
+556:	b	\disp(\reg)
+	.endm
+
 	.macro GEN_BR_THUNK reg,ruse=%r1
 	__DECODE_RR __THUNK_PROLOG_BR,\reg,\ruse
 	__THUNK_EX_BR \reg,\ruse
 	__THUNK_EPILOG
 	.endm
 
+	.macro GEN_B_THUNK disp,reg,ruse=%r1
+	__DECODE_DRR __THUNK_PROLOG_BC,\disp,\reg,\ruse
+	__THUNK_EX_BC \disp,\reg,\ruse
+	__THUNK_EPILOG
+	.endm
+
 	.macro BR_EX reg,ruse=%r1
 557:	__DECODE_RR __THUNK_BR,\reg,\ruse
 	.pushsection .s390_indirect_branches,"a",@progbits
@@ -111,6 +154,13 @@
 	.popsection
 	.endm
 
+	 .macro B_EX disp,reg,ruse=%r1
+558:	__DECODE_DRR __THUNK_BC,\disp,\reg,\ruse
+	.pushsection .s390_indirect_branches,"a",@progbits
+	.long	558b-.
+	.popsection
+	.endm
+
 	.macro BASR_EX rsave,rtarget,ruse=%r1
 559:	__DECODE_RRR __THUNK_BRASL,\rsave,\rtarget,\ruse
 	.pushsection .s390_indirect_branches,"a",@progbits
@@ -122,10 +172,17 @@
 	.macro GEN_BR_THUNK reg,ruse=%r1
 	.endm
 
+	.macro GEN_B_THUNK disp,reg,ruse=%r1
+	.endm
+
 	 .macro BR_EX reg,ruse=%r1
 	br	\reg
 	.endm
 
+	 .macro B_EX disp,reg,ruse=%r1
+	b	\disp(\reg)
+	.endm
+
 	.macro BASR_EX rsave,rtarget,ruse=%r1
 	basr	\rsave,\rtarget
 	.endm
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -94,7 +94,6 @@ static void __init_or_module __nospec_re
 	s32 *epo;
 
 	/* Second part of the instruction replace is always a nop */
-	memcpy(insnbuf + 2, (char[]) { 0x47, 0x00, 0x00, 0x00 }, 4);
 	for (epo = start; epo < end; epo++) {
 		instr = (u8 *) epo + *epo;
 		if (instr[0] == 0xc0 && (instr[1] & 0x0f) == 0x04)
@@ -115,18 +114,34 @@ static void __init_or_module __nospec_re
 			br = thunk + (*(int *)(thunk + 2)) * 2;
 		else
 			continue;
-		if (br[0] != 0x07 || (br[1] & 0xf0) != 0xf0)
+		/* Check for unconditional branch 0x07f? or 0x47f???? */
+		if ((br[0] & 0xbf) != 0x07 || (br[1] & 0xf0) != 0xf0)
 			continue;
+
+		memcpy(insnbuf + 2, (char[]) { 0x47, 0x00, 0x07, 0x00 }, 4);
 		switch (type) {
 		case BRCL_EXPOLINE:
-			/* brcl to thunk, replace with br + nop */
 			insnbuf[0] = br[0];
 			insnbuf[1] = (instr[1] & 0xf0) | (br[1] & 0x0f);
+			if (br[0] == 0x47) {
+				/* brcl to b, replace with bc + nopr */
+				insnbuf[2] = br[2];
+				insnbuf[3] = br[3];
+			} else {
+				/* brcl to br, replace with bcr + nop */
+			}
 			break;
 		case BRASL_EXPOLINE:
-			/* brasl to thunk, replace with basr + nop */
-			insnbuf[0] = 0x0d;
 			insnbuf[1] = (instr[1] & 0xf0) | (br[1] & 0x0f);
+			if (br[0] == 0x47) {
+				/* brasl to b, replace with bas + nopr */
+				insnbuf[0] = 0x4d;
+				insnbuf[2] = br[2];
+				insnbuf[3] = br[3];
+			} else {
+				/* brasl to br, replace with basr + nop */
+				insnbuf[0] = 0x0d;
+			}
 			break;
 		}
 
