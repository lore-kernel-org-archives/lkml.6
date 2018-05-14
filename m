Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-995127-1526312999-2-4796830385850350789
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526312998; b=U3ipsYKSmsEHYHR6igtAhD6udtl3bz99UkJO9tZAkEEve48HIz
    UDd26JFkmk4+1VvlgVmlwLCuBRGvfbCP2tXkGkKXBJjwQqPjPnqN9rugCwF/fj0y
    /uxC8wzEM92oS2ghre/0+BWTgxgqHQoky+LBhnprPfLRiUzaie4jNGWITse8EygQ
    xuTLZwHwmYOGu7QWKm7dg1VezGrvk9qPOFyGYsvANbHqYSnLYuoXPGMSNMra7xFV
    Ki5CLkllBnbwsGU2I2F2kV3dB0NUFVX3g4iPUgXFSR3gn6jsJiNNrMdLvkPAi7ro
    QGLdZLYWd0inHmNpitmWGYW1iVPWdE0051aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526312998;
    bh=MHKYFVdyrITEYUPvVfoMXiCuqgLxfOF8P2Qf8wEiUlg=; b=Pj0pZr8iMOl4
    HSzr+MF8WynzJzcj57kWbgDxJXJfFGSJvW5o6/kGgxkeIcDFiqFXR76pVeveEj+4
    mgADFLJMT5pXF+YfENdUuxPIjyIziWovLcl6TM42n/oXXS0O49IwnmjKkX+05Iia
    tXgoqmAIKr3yV1NNljf93Aiiny4ln9mme4mJETangn/03eYHCNIjcuzk8//BX8Fm
    MrmbUshzargiD8I5WbSEmFbmP0NYMafQTyEapoRoPAe5xHPs043tVQKPKuonjots
    eEuj58ZJLqq/tNvoThQ5x/Mz1luBtZdlPlyoYg05Q4WFJSdIyU/BaHdtTTdWVqUL
    g427FuIA/Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNdsDtVbXYMHtpqGwv7L/A7IRl+2jBDI6hK7owU7CZTCbmTF8u9sd/lByJHyQVVVVK0vNRrbGclPMeE1A0TkHTYx8+4AxFvpHyV7lcDTu7RoiP6gXE4K
    r/m2rKCyVzEp8GV9wPdtIMbnzJcSw/lN2Uxp7LgTwe+P5x3goyFwFRibmyVH0NMrml8sEsS6XrKVyeqyXqttiNfr2QPMxwSt9QrOrAPLfuCKKpHIWY0RIrAf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8dpCUCyp5n4A:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=ihlbdoeTe4OeCNZhIB8A:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeENPt4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 11:49:56 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:39779 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeENPtz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 11:49:55 -0400
Date: Mon, 14 May 2018 16:49:43 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: James Hogan <james.hogan@mips.com>
CC: Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses
 to o32 FGRs
Message-ID: <alpine.DEB.2.00.1805141537210.10896@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.96]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526312991-321457-24569-35339-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192979
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Check the TIF_32BIT_FPREGS task setting of the tracee rather than the 
tracer in determining the layout of floating-point general registers in 
the floating-point context, correcting access to odd-numbered registers 
for o32 tracees where the setting disagrees between the two processes.

Cc: stable@vger.kernel.org # 3.14+
Fixes: 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
Hi,

 These are not the usual requests used by GDB to access the floating-point 
context, which is likely why it went unnoticed so long.  They are only 
used as a fallback in the case where PTRACE_GETFPREGS and PTRACE_SETFPREGS 
requests are not supported, i.e. with ancient kernels.

 However to verify an unrelated GDB bug fix I have tweaked GDB to always 
use PTRACE_PEEKUSR and PTRACE_POKEUSR, and then discovered this issue in 
native GDB regression testing, as it showed regressions from corrupt FGR 
contents across numerous tests compared to the usual results.  This fix 
removed those regressions then.

 Not being typically used does not mean we ought to keep the interface 
broken.  Therefore please apply.

  Maciej
---
 arch/mips/kernel/ptrace.c   |    4 ++--
 arch/mips/kernel/ptrace32.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

linux-mips-ptrace-test-thread-flag.diff
Index: linux/arch/mips/kernel/ptrace.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace.c	2018-05-12 22:52:19.000000000 +0100
+++ linux/arch/mips/kernel/ptrace.c	2018-05-12 22:56:07.893993000 +0100
@@ -1059,7 +1059,7 @@ long arch_ptrace(struct task_struct *chi
 			fregs = get_fpu_regs(child);
 
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -1154,7 +1154,7 @@ long arch_ptrace(struct task_struct *chi
 
 			init_fp_ctx(child);
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
Index: linux-mipsswbrd038/arch/mips/kernel/ptrace32.c
===================================================================
--- linux-mipsswbrd038.orig/arch/mips/kernel/ptrace32.c	2018-05-12 22:52:19.000000000 +0100
+++ linux-mipsswbrd038/arch/mips/kernel/ptrace32.c	2018-05-12 22:55:20.906637000 +0100
@@ -99,7 +99,7 @@ long compat_arch_ptrace(struct task_stru
 				break;
 			}
 			fregs = get_fpu_regs(child);
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -212,7 +212,7 @@ long compat_arch_ptrace(struct task_stru
 				       sizeof(child->thread.fpu));
 				child->thread.fpu.fcr31 = 0;
 			}
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
