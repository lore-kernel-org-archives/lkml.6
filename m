Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3334576-1526423716-2-14178165499739141122
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526423716; b=gcoRrMKRWR9EEojlXaH21VZV4su4gJffWKmPCSBL2R5PkppdFD
    vl2Kh2pclnX4faiQno8kEQZvr/muAbzcllNpDmhD8JkFJ45/G83BL+ZGQpq+CR3W
    sZ/ovMkPXEr1RTscfspLvKCPB41ufbcQgQM+73EGd/rAbdIFmbFq3z3b7xXMlfAo
    bnVbITc0fYotMJgStbxye+EVXYDk+zzCl0VTLjTTpWaBmM7Ax+RSYA0frbs3Xd7M
    /njsT+/YHsKBo75vhsB+m2wc9AdY7z+YJr6lIeEM8DQbvUt2pkK3C1Ru1zlKk5qL
    z22Qg9LoIANJOTqrf/NNXi0G+zDk3c86uSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1526423716; bh=jlfZb67cMAA29Qmyd+Uemw2NTO4mYYqWwQfb9sG
    N4pc=; b=nArB0LRdMP2Qj80sAmOd19SWrZxVb9kLfz6B3bz/Yws5dKJPTVfbLkl
    F4g0qPjVOopiQjXWsFzGnzMVTVgpDYOqG0GoVKfVulCm7EJ0XZZ88D+e8FuTInOB
    79hfwBNtIML9de+2ErYu6x+uzZNpjVDnIeRCWMqu5jwWMGD3KrndsUb20hGXOLl7
    9pAn4cjIHEZvzSCsy02+ykBvTEBTx/i5xT7ZJAVsYNy9uJviqouCk5VfQOY14UBF
    jWYUDEhdan11ACT6frQD1ta1VKPKM6QZuBLxK+PGfKB8SitUfuGBH43l+ls5yY3I
    ylTDVW9LMGI5qGUexhSttD7/3FqJLLg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfPaMCf++VE3PRCer305OFikL4IzaMsPpJFPxNsmIK/Rn8B0W5E7uMWJWDju1p4BCRRUsIudOF1JN4lEMYIhoPHbglMu2QQTixG/UUeNPtaGGH0C9eelb
    qByPv6jSweunLRDHlRSZsuMAhFXiZPnngO0uSzH3y3xZpWl4uTFeNU0SpcfUvIcfEEziKBNltdLTVjxXgsaNUULNYLY5v82gYqFclTg9ZMszig7DJOHOqSnN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=iAo7guES1noA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=CCpqsmhAAAAA:8
    a=Rs_4mCeelu54jMY9XRwA:9 a=gamYa0m_NF07U3O0:21 a=YVCosNZAHfRQtSEZ:21
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
    a=ul9cdbp4aOFLsgKbc677:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeEOWfM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 18:35:12 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:58653 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbeEOWfJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 18:35:09 -0400
Date: Tue, 15 May 2018 23:33:26 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 2/3] MIPS: Correct the 64-bit DSP accumulator register size
In-Reply-To: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1805102026260.10896@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526423657-637138-23752-17153-2
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193020
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

Use the `unsigned long' rather than `__u32' type for DSP accumulator 
registers, like with the regular MIPS multiply/divide accumulator and 
general-purpose registers, as all are 64-bit in 64-bit implementations 
and using a 32-bit data type leads to contents truncation on context 
saving.

Update `arch_ptrace' and `compat_arch_ptrace' accordingly, removing 
casts that are similarly not used with multiply/divide accumulator or 
general-purpose register accesses.

Cc: stable@vger.kernel.org # 2.6.15+
Fixes: e50c0a8fa60d ("Support the MIPS32 / MIPS64 DSP ASE.")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
Hi,

 I have no 64-bit DSP hardware handy to verify this change, however some 
surely exists and is used to run Linux, as indicated by GDB PR gdb/22286, 
<https://sourceware.org/bugzilla/show_bug.cgi?id=22286>, so we better get 
it right before people start screaming.

  Maciej
---
 arch/mips/include/asm/processor.h |    2 +-
 arch/mips/kernel/ptrace.c         |    2 +-
 arch/mips/kernel/ptrace32.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

linux-mips-dsp64.diff
Index: linux-jhogan-test/arch/mips/include/asm/processor.h
===================================================================
--- linux-jhogan-test.orig/arch/mips/include/asm/processor.h	2018-03-21 17:13:52.000000000 +0000
+++ linux-jhogan-test/arch/mips/include/asm/processor.h	2018-05-09 22:35:33.248559000 +0100
@@ -141,7 +141,7 @@ struct mips_fpu_struct {
 
 #define NUM_DSP_REGS   6
 
-typedef __u32 dspreg_t;
+typedef unsigned long dspreg_t;
 
 struct mips_dsp_state {
 	dspreg_t	dspr[NUM_DSP_REGS];
Index: linux-jhogan-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-jhogan-test.orig/arch/mips/kernel/ptrace.c	2018-05-09 22:34:00.000000000 +0100
+++ linux-jhogan-test/arch/mips/kernel/ptrace.c	2018-05-09 22:37:45.416608000 +0100
@@ -856,7 +856,7 @@ long arch_ptrace(struct task_struct *chi
 				goto out;
 			}
 			dregs = __get_dsp_regs(child);
-			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
+			tmp = dregs[addr - DSP_BASE];
 			break;
 		}
 		case DSP_CONTROL:
Index: linux-jhogan-test/arch/mips/kernel/ptrace32.c
===================================================================
--- linux-jhogan-test.orig/arch/mips/kernel/ptrace32.c	2018-03-21 17:13:52.000000000 +0000
+++ linux-jhogan-test/arch/mips/kernel/ptrace32.c	2018-05-09 22:45:50.924418000 +0100
@@ -142,7 +142,7 @@ long compat_arch_ptrace(struct task_stru
 				goto out;
 			}
 			dregs = __get_dsp_regs(child);
-			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
+			tmp = dregs[addr - DSP_BASE];
 			break;
 		}
 		case DSP_CONTROL:
