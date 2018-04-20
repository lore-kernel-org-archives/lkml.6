Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223491-1524186829-2-1586784770350707167
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524186828; b=XTpHyrWKtSh9XogZbULbdnan2aDJCxlT4r5qRtN7uDJ7Ani7gK
    De43oNvi9D5kRPxfIizOstk5g4K23uCEojStsn8uY5VBRDeDdh/jj1RDx7yhMgfF
    bFi4SUgLH6XgpgjbSfZIpR/3dqcrnzvMar5BjXpT5g4Gh68MiDfrINqOXC2TP0D9
    x/7xSlRyWngEhINMcNft4w3l+YwSlS44nOia/6crVfODUv1R/lNGPX0XTZ6Q8Nvu
    OSV7jD/iiDIMM8VeQObmy58n0mufDbP0Ej0VXHeRiJzHoBPNnzdsxolPEYXZ6whD
    mw6BJi0InArlzMo9Y1Q9VKA/HCnonqctZ4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186828; bh=mur1
    JLgV3CKfiqZ1IZIcSydZFx8vbc//+PMChse7sEI=; b=ssEGDYWc58/6wJmOgeiJ
    guBsCuqTaDzSrUBty7mU6HgJU32/53tKOKspAmipcGOvWHqhqbf1wAynggIQaqBA
    LKvnShkNka6EtPsdqKTPxN1jUU2ECNCSJJLEBr35kERqpvasGC74+otUxRG5yUk8
    SiqqeyxTeuLMuyhCFLaav03fXbgKigZ15y4VUxNz6pH4kvFaSrhsrV924rEcrdGx
    M1U6Pq7VrdiQBjPxRXgIjZNIT8sDZnwXrCcKDI+6qZ7OJg1R6EwE78hPd4uc07cu
    iwrhtmbc/INkjzksmIqOfThmC44fJPBTdtOtwyfUmym328XjMWvbqCABhLtOMTR3
    yA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMlcsDFtPGKc3FSStWyskdKe+1/X3mSTHo1I5QHOgtdmxAnnBZMYSmAPD1+TNDxxeTFYUWUyMtGf7JHP2IPwQkcoV7p0KdNYEkyZ25ocbn1F/mXYBvw9
    BrqnlqADgRhGte9tXasUICTFppg+tuRPfKa2E5kmwiYtMImKMH8teP3s5iCwWkF7wfwStoT+8ZAvmBORmD0ncmrZwbJA41dO/FEERukSgnko8x/zU80+sxI1
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=rWkr9Ua9AAAA:8
    a=tOO0nKmCAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=PtDNVHqPAAAA:8
    a=NwaC7gLdFL_5klieUeQA:9 a=x8gzFH9gYPwA:10 a=Qv-QrLrHZjTXZfLJ-zom:22
    a=Gz67Kf0DkuxJ4rqyVRET:22 a=AjGcO6oz07-iQ99wixmX:22 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeDTBMJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:12:09 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50399 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753703AbeDTBMH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:12:07 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Helge Deller <deller@gmx.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Date: Thu, 19 Apr 2018 20:04:07 -0500
Message-Id: <20180420010408.24438-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KXL-00014u-MB;;;mid=<20180420010408.24438-16-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/VcfOrzdcsTZKfmtm2RLyb/iYedTos050=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15030 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.9 (0.0%), b_tie_ro: 1.96 (0.0%), parse: 0.79 (0.0%),
        extract_message_metadata: 18 (0.1%), get_uri_detail_list: 2.2 (0.0%),
        tests_pri_-1000: 3.0 (0.0%), tests_pri_-950: 1.22 (0.0%), tests_pri_-900:
        1.02 (0.0%), tests_pri_-400: 24 (0.2%), check_bayes: 23 (0.1%), b_tokenize: 8
        (0.1%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.2 (0.0%), b_tok_touch_all:
        3.3 (0.0%), b_finish: 0.60 (0.0%), tests_pri_0: 178 (1.2%),
        check_dkim_signature: 0.52 (0.0%), check_dkim_adsp: 3.2 (0.0%),
        tests_pri_500: 14799 (98.5%), poll_dns_idle: 14787 (98.4%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 16/17] signal/alpha:  Replace TRAP_FIXME with TRAP_UNK
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using an si_code of 0 that aliases with SI_USER is clearly the wrong
thing to do, and causes problems in interesting ways.

For it really is not clear to me if using TRAP_UNK bugcheck or
the default case of gentrap is really the best way to handle
things.  There is certainly enough information that that a more
specific si_code could potentially be used.  That said TRAP_UNK
is definitely an improvement over 0 as it removes the ambiguiuty
of what si_code of 0 with SIGTRAP means on alpha.

Recent history suggests no actually cares about crazy corner cases of
the kernel behavior like this so I don't expect any regressions from
changing this.  However if something does happen this change is easy
to revert.

Cc: Helge Deller <deller@gmx.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Fixes: 0a635c7a84cf ("Fill in siginfo_t.")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/include/uapi/asm/siginfo.h | 7 -------
 arch/alpha/kernel/traps.c             | 4 ++--
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/siginfo.h b/arch/alpha/include/uapi/asm/siginfo.h
index 3ebbb1e17902..db3f0138536f 100644
--- a/arch/alpha/include/uapi/asm/siginfo.h
+++ b/arch/alpha/include/uapi/asm/siginfo.h
@@ -7,11 +7,4 @@
 
 #include <asm-generic/siginfo.h>
 
-/*
- * SIGTRAP si_codes
- */
-#ifdef __KERNEL__
-#define TRAP_FIXME	0	/* Broken dup of SI_USER */
-#endif /* __KERNEL__ */
-
 #endif
diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 422b676b28f2..242c83d86ace 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -288,7 +288,7 @@ do_entIF(unsigned long type, struct pt_regs *regs)
 	      case 1: /* bugcheck */
 		info.si_signo = SIGTRAP;
 		info.si_errno = 0;
-		info.si_code = TRAP_FIXME;
+		info.si_code = TRAP_UNK;
 		info.si_addr = (void __user *) regs->pc;
 		info.si_trapno = 0;
 		send_sig_info(SIGTRAP, &info, current);
@@ -350,7 +350,7 @@ do_entIF(unsigned long type, struct pt_regs *regs)
 		case GEN_SUBRNG7:
 		default:
 			signo = SIGTRAP;
-			code = TRAP_FIXME;
+			code = TRAP_UNK;
 			break;
 		}
 
-- 
2.14.1

