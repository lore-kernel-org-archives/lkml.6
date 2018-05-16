Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-454347-1526485243-2-18269918780053090465
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526485243; b=JKFkwrXeB6CS6AMDjp1zxBwrV1s3NvRsqz11wekpySRy6zDeaq
    CheyZYXGlwdR5g8hjq+ZHA/UHJeqn0aElG1ymxggcG5pHblK+Yh0DbNG/qutB6ag
    JrFMLAwmqeG/lVt7nLOx4JIqBCuHxvS2MFYAjDaqp5JL1GQ8RdcaRgOzYNGVjf/I
    zOj/MSHk3FJPzRYaWGiZ3fI0S1zTXnlsUk8YEL5A/KMJzQSWjJIwnpnXZCL02ltu
    WMr5Ocmwvq4qLqes+LX3MLJvogd2m7kfQs/ANj/IKo0LnNYkAKSXZrRkfcr4/SRz
    JOy8HCPOKJ+lpmqbQ0Jcyt5rU+XP2ycjV5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526485243;
    bh=q/mgq8o8e+LYCa7DTifz/zeg+zshgIDqfaLQymDt+Rs=; b=a/wuNwMpSfu7
    4GAhyTU4MhCTm6Yywv4MJPWaEwfd3YzbwNFr/8jdRpUtQduXcCGtTBy6KRxPPOSu
    jWaN7cGGZ8yJbMLirOR2RL6qF22Oi1DeoBSEZlEoiB414TYok2s/lDjZTTMkPfyR
    WSWstK9JW50QT2xiB7WWiERGOPlnTpI+aBWyXn074IneqPZQTNKssXhDpFEeVWI4
    nhVrm7iAaSQ5PNvEEBc8HTJd09qABZ8VztnuwiyWYSiC318imJPpfz1x/srTYHJi
    qNNdQoMVSYiIs/UcirUcOiQhMa3SPzcqQA7Z47MeXqaUe+0woEKsqdILbRhp60md
    tlO/2Mrmwg==
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
X-CM-Envelope: MS4wfEXQoMrdyE9gulbkcpjb31aHnSzZ/yHot42BW0/0N35+Pz/7JSSmmuLSMGv6HHVPWxgD4JyFggxeL8ZFyKHMIFEBadQtj87mZpUIer2+8Bj+/cGIFzRT
    8xNscOPDj8Szy59LBJIfdaI3HEV4IubnaB4d3i+d3QN6P5B98ZRNA2TXQX2iw36XTuNsdkL4jDuoa8m+QYDlrpUZuK6G+o9eydOl629mDJPGQCCohvihQhe/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=MnutdA4GRmYA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=xcAPybBRfT6FVLe-inYA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750772AbeEPPkl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 11:40:41 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:39203 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEPPkk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 May 2018 11:40:40 -0400
Date: Wed, 16 May 2018 16:39:58 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
Message-ID: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.133]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526485207-637138-23749-67371-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193036
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use 64-bit accesses for 64-bit floating-point general registers with 
PTRACE_PEEKUSR, removing the truncation of their upper halves in the 
FR=1 mode, caused by commit bbd426f542cb ("MIPS: Simplify FP context 
access"), which inadvertently switched them to using 32-bit accesses.

The PTRACE_POKEUSR side is fine as it's never been broken and continues 
using 64-bit accesses.

Cc: <stable@vger.kernel.org> # 3.19+
Fixes: bbd426f542cb ("MIPS: Simplify FP context access")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
Hi,

 Here's another one, spotted in the course of GDB PR gdb/22286 regression 
testing with the n64 ABI.  Please apply.

  Maciej
---
 arch/mips/kernel/ptrace.c   |    2 +-
 arch/mips/kernel/ptrace32.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

linux-mips-ptrace-peekusr-fp64.diff
Index: linux/arch/mips/kernel/ptrace.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace.c	2018-05-15 17:44:25.000000000 +0100
+++ linux/arch/mips/kernel/ptrace.c	2018-05-16 11:22:00.714605000 +0100
@@ -1070,7 +1070,7 @@ long arch_ptrace(struct task_struct *chi
 				break;
 			}
 #endif
-			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;
Index: linux/arch/mips/kernel/ptrace32.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace32.c	2018-05-15 17:45:16.000000000 +0100
+++ linux/arch/mips/kernel/ptrace32.c	2018-05-16 11:22:16.313698000 +0100
@@ -109,7 +109,7 @@ long compat_arch_ptrace(struct task_stru
 						addr & 1);
 				break;
 			}
-			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;
