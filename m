Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220351-1523981555-2-9055882314590446814
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
    1523981555; b=I0LcOnv+eXtT0z0kfzRtsyjAL+9SL92Qbcd2ZCGcmOT/y/jHw/
    bkJavRRihzOLknSwtt8SQRHzKcJycNZ75HlMImZCDJYUKRDkcNr4ZwbcPsaqTnzS
    2/igRqdnyTtq2B2A2FSdYJedwH9sGNLSiXSPc7DFhSPhJe188BfN6pVKPpWvJlhU
    Rz3IdG7I6FhyX2uysHYuRPonGAI547aipfGjrIextJEoBT+EbeZcWZJf7n3PcN1b
    tB0YOt3a8bSKLJILKbh32CGCyJipiEnAJIg1dJqCKlD/2LLtY+BGKUPov58OtWCp
    QAlUy2TknzSd+Rffb04qzjfoUewDgxULDj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981555; bh=I8PygovQDsuPNY0pIM8/RnCYTZ+ZuK
    Dsp3FBHHhP2zE=; b=FnAm6c1F03+ibn/4EoCfhzzgIPvJ04OMGXvcPS1e3lvD3S
    wxHm53/kUXdt/8hqftzjTcVCMwqLA85zLZFskET7lOflB6O1eTXPutrv+hxC9Hh5
    B3fTu3zJo4nFqpPUhk2wkq7A+nZlAGqcNdb8k2E3wkEBOTeRHlleNYcR048GnCq4
    EKiop0WYtX/p59UD7wb49snpRpmlkNWjLhFnOWKfKIx6psS2UACWbzwutN3j3A5w
    iWyxDvlOU05gHMGrv58F/coWiaqQFJLzn7OgEXAh0xtOTFoga6SFWRB2qyBOtcGi
    9tYbJa3GyQmNTmvi18Tvo8O4/vSNC/GJNd41mD1Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfI0/3eRpBxxUbAg61lK9oWf7BkOf+Rrcxj1sbp6WHQmvFa6j1DLMaeiUjpvCkpReBj8CpGARiS6YxU0bHvZZUAJrqBF+QbVaI00vbuqTDICHPVf318sx
    788smxP5MwmhGKdyTkWmjvOuTQet8oHTO9RbSCleph8/5J2dJRLNWHG+27eaMgoVxXkTNVGs7qGwkfE3hhnlo3hILyu7s+ZKKD5nNEaHx0pPprqS7SGnUhHC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8 a=UWyJlIVFYVef6a9CwZAA:9
    a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755343AbeDQQMV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:12:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755298AbeDQQMT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:12:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.9 10/66] arm64: barrier: Add CSDB macros to control data-value prediction
Date: Tue, 17 Apr 2018 17:58:43 +0200
Message-Id: <20180417155646.280705889@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
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

From: Mark Rutland <mark.rutland@arm.com>


From: Will Deacon <will.deacon@arm.com>

commit 669474e772b952b14f4de4845a1558fd4c0414a4 upstream.

For CPUs capable of data value prediction, CSDB waits for any outstanding
predictions to architecturally resolve before allowing speculative execution
to continue. Provide macros to expose it to the arch code.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |    7 +++++++
 arch/arm64/include/asm/barrier.h   |    2 ++
 2 files changed, 9 insertions(+)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -87,6 +87,13 @@
 	.endm
 
 /*
+ * Value prediction barrier
+ */
+	.macro	csdb
+	hint	#20
+	.endm
+
+/*
  * NOP sequence
  */
 	.macro	nops, num
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -31,6 +31,8 @@
 #define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 
+#define csdb()		asm volatile("hint #20" : : : "memory")
+
 #define mb()		dsb(sy)
 #define rmb()		dsb(ld)
 #define wmb()		dsb(st)
