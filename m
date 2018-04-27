Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-288473-1524837841-2-4961832260977225016
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524837840; b=YwAIAmM2RWxc2LGtulODXjDosFLaGKOgGoSC4a9/3vedZv/l10
    TAQHR5e9XnzQhBUKavNCKanzw+AHDSXQBWtRy5yKZxpd9m/m6pNZJH8EmVrFp/Wc
    XTVU33lOec8ctSSvFvS9+2JzYbv72DQD7UWFyL969o+18K5M45JGirTRV0Je9odL
    rhdZEZTkkD7d5ZuFQ/+H8Qr9qtdFgRT3tL8BcVMT3ajBIyVZfsQirUIpkRaj74Xd
    ieNZr2bgDEqRTGr5xBbs4OHI2kTJfaP6C8IuHH4pXNKY8cf8bNOnNJuwGcF0anT0
    UnLgumI7H1Tc3SzPUuaVQbKP+ii33hBRN0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837840; bh=6lo5lR5hHH+GZYH4Z2HPWw4nW/1arQ
    93JTkYHUb1VeQ=; b=nTRYCXwd05wQ3DuHZxp2/aYNzlHalpLQh0jerbzMeSjdGG
    0CTYCNMZM2l9FxXu4a3rPwlnl0r5Dnyg217Qc5q3GVEIHAsvF3992OXqg33zPMXN
    nknzqghNp+D92X4IVV/Uqr4iv8UKo3gXFKutnUwdIvaKwTLwTVsvXjm1nQq/9rGK
    iQvjLh+2ZN5XJ/HXKbsUMvxLKZRwdbmLXfnYzPzVclHW1vjREHpqLMzBszRi/R1q
    QSnpahIzivNl/g511hNIjVZG5QrRBzVNx6h9m9hfc33CH6sBsIhzV6YZqmH9ixSZ
    Se7pDOM6Fkiywakj/vJe5xPtONuklyzrgtVP8T9Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfG2LDi2jTLLVaMslFclSC6DMHy+o2NGzSFw7u5dkCSMaFzmM1VTvqi5SORM6zPMzL1UhFfsHCXZZeBKVHMJzDhMsSeV0yO9DVivXAWS6OGVosLpXRzVA
    LyNJ57VmgQRch+pN+S7M3m30Wwn8/hrF2zMHVigtYsoLUpF1VWlqOTKAJ5odr1rIFaVLwBOdQ894AuH2CLRYUgDkmxH+Os99GYFvZpEWuQc7Asx604dmj5F5
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=XH7PKExuMGqO0J9mnHIA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeD0ODr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933188AbeD0ODp (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:03:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE5D2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.9 31/74] s390: scrub registers on kernel entry and KVM exit
Date: Fri, 27 Apr 2018 15:58:21 +0200
Message-Id: <20180427135711.222188812@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
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


[ Upstream commit 7041d28115e91f2144f811ffe8a195c696b1e1d0 ]

Clear all user space registers on entry to the kernel and all KVM guest
registers on KVM guest exit if the register does not contain either a
parameter or a result value.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/entry.S |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -255,6 +255,12 @@ ENTRY(sie64a)
 sie_exit:
 	lg	%r14,__SF_EMPTY+8(%r15)		# load guest register save area
 	stmg	%r0,%r13,0(%r14)		# save guest gprs 0-13
+	xgr	%r0,%r0				# clear guest registers to
+	xgr	%r1,%r1				# prevent speculative use
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
 	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
 	lg	%r2,__SF_EMPTY+16(%r15)		# return exit reason code
 	br	%r14
@@ -290,6 +296,8 @@ ENTRY(system_call)
 .Lsysc_vtime:
 	UPDATE_VTIME %r10,%r13,__LC_SYNC_ENTER_TIMER
 	stmg	%r0,%r7,__PT_R0(%r11)
+	# clear user controlled register to prevent speculative use
+	xgr	%r0,%r0
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
 	mvc	__PT_PSW(16,%r11),__LC_SVC_OLD_PSW
 	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
@@ -517,6 +525,15 @@ ENTRY(pgm_check_handler)
 	mvc	__THREAD_trap_tdb(256,%r14),0(%r13)
 3:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
 	stmg	%r0,%r7,__PT_R0(%r11)
+	# clear user controlled registers to prevent speculative use
+	xgr	%r0,%r0
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_INT_CODE(4,%r11),__LC_PGM_ILC
@@ -580,6 +597,16 @@ ENTRY(io_int_handler)
 	lmg	%r8,%r9,__LC_IO_OLD_PSW
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_ENTER_TIMER
 	stmg	%r0,%r7,__PT_R0(%r11)
+	# clear user controlled registers to prevent speculative use
+	xgr	%r0,%r0
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
+	xgr	%r10,%r10
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_ASYNC
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_INT_CODE(12,%r11),__LC_SUBCHANNEL_ID
@@ -755,6 +782,16 @@ ENTRY(ext_int_handler)
 	lmg	%r8,%r9,__LC_EXT_OLD_PSW
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_ENTER_TIMER
 	stmg	%r0,%r7,__PT_R0(%r11)
+	# clear user controlled registers to prevent speculative use
+	xgr	%r0,%r0
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
+	xgr	%r10,%r10
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_ASYNC
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	lghi	%r1,__LC_EXT_PARAMS2
@@ -925,6 +962,16 @@ ENTRY(mcck_int_handler)
 .Lmcck_skip:
 	lghi	%r14,__LC_GPREGS_SAVE_AREA+64
 	stmg	%r0,%r7,__PT_R0(%r11)
+	# clear user controlled registers to prevent speculative use
+	xgr	%r0,%r0
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
+	xgr	%r10,%r10
 	mvc	__PT_R8(64,%r11),0(%r14)
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
