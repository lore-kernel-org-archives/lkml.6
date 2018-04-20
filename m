Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223491-1524186742-2-2031966791927478763
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524186741; b=ldqkXlVaMPfEfjSSHz/PFQdhxd+Ze40raYTP+qGthU+gN1+Cft
    56lJEB95GWIX8hLAtzuVV5/1T1/a/3ogqhwsVeL8Pxvp7oTErthMiDLgmEIhQl8k
    4h1xPxWw5btcUOq0tLhVIVDI2Vg5t+ChcIYLwYzdZb54vgVZAUTPkzWUQ8oFvYnZ
    lqcTdy7VkzVIH0579VszbSgwFi4Jwu1f0XZaaggdYR5+CAG3ZjneTPRsb2Mjevvp
    XJm0q45GJjqkwUmxs8lNFoGU69b03dNgB/PNMeDkO+bimY7P/8EeSyV+sY25Kgvs
    bdinUNC84ehy17ZVRV7NOvR9/iRgsyAcmsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186741; bh=qY8D
    VQCBlMGpgUC2uKHBgZ5LuTgx9WJng7GasWqGYP8=; b=ZNuRQAuC7QJpcZ9WJBtP
    imSlUdva1laTE/F36VPt/6UuhL7/t5io716OSZl/yFvDI7ihEusqBxUxzfUnEfxR
    DL7vGB5jH+HNslaPMereyGccqaeH+OA7K2BtVlw/GMh81PoEvojf7dZI1Telsf6a
    O5cu1KiblJ2RJrCAuaStJ2Lc50q/RdMMFu6auDSm/34FUZRsKZBeugkW/LRjxvd+
    gUH+0XSh9dlQDNfopNgD+OZ30Ox2gqzXV+4Tjl6xSV8YPHfarxK4opy+TU3KR9TO
    ISk0tZkJB+7+vaccpHE36db3WBvZMp2gmSKV8A/7fe5KybaIGOdbLX62B6mJPbB0
    4w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfMm7pY2dJmfrUQ+A1fJeNAHqzq+VsaEhZsRykyRsMbCk6CMJYId9U/Xc9576DY72plu2LEksaeOJ1jQXNtXG+wl3AhvLja3zC0BEjdDcBZWeW93yP0bh
    5RS/vUAqr2nhmYLrqbNMd3nwStU/cZCJxo72wzH47WytQBER4+B3Jg8YQ+hyN0Zz/li0d+WwEKfJXp6WWiic0W6bMVUta9p0Al4BeZzP+ISNuDom0NpiSvv5
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=rWkr9Ua9AAAA:8
    a=tOO0nKmCAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=PtDNVHqPAAAA:8
    a=YV59-HsJ764DQurnoHwA:9 a=x8gzFH9gYPwA:10 a=Qv-QrLrHZjTXZfLJ-zom:22
    a=Gz67Kf0DkuxJ4rqyVRET:22 a=AjGcO6oz07-iQ99wixmX:22 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754112AbeDTBMS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:12:18 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36115 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753857AbeDTBMJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:12:09 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Helge Deller <deller@gmx.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Date: Thu, 19 Apr 2018 20:04:02 -0500
Message-Id: <20180420010408.24438-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KWg-00014u-IC;;;mid=<20180420010408.24438-11-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18U2bBvwMe0brnPMZgtc9Vr1yAVFAZdUZk=
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
X-Remote-Spam-Timing: total 15036 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.2 (0.0%), b_tie_ro: 2.1 (0.0%), parse: 1.01 (0.0%),
        extract_message_metadata: 21 (0.1%), get_uri_detail_list: 3.0 (0.0%),
        tests_pri_-1000: 3.0 (0.0%), tests_pri_-950: 1.24 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 26 (0.2%), check_bayes: 25 (0.2%), b_tokenize:
        10 (0.1%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.4 (0.0%), b_tok_touch_all:
        2.9 (0.0%), b_finish: 0.64 (0.0%), tests_pri_0: 171 (1.1%),
        check_dkim_signature: 0.43 (0.0%), check_dkim_adsp: 2.4 (0.0%),
        tests_pri_500: 14806 (98.5%), poll_dns_idle: 14791 (98.4%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 11/17] signal/alpha: Replace FPE_FIXME with FPE_FLTUNK
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using an si_code of 0 that aliases with SI_USER is clearly the wrong
thing todo, and causes problems in interesting ways.

The newly defined FPE_FLTUNK semantically appears to fit the bill so
use it instead.

Given recent experience in this area odds are it will not break
anything.  Fixing it removes a hazard to kernel maintenance.

Cc: Helge Deller <deller@gmx.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Fixes: 0a635c7a84cf ("Fill in siginfo_t.")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/include/uapi/asm/siginfo.h | 7 -------
 arch/alpha/kernel/osf_sys.c           | 2 +-
 arch/alpha/kernel/traps.c             | 2 +-
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/siginfo.h b/arch/alpha/include/uapi/asm/siginfo.h
index 0cf3b527b274..3ebbb1e17902 100644
--- a/arch/alpha/include/uapi/asm/siginfo.h
+++ b/arch/alpha/include/uapi/asm/siginfo.h
@@ -7,13 +7,6 @@
 
 #include <asm-generic/siginfo.h>
 
-/*
- * SIGFPE si_codes
- */
-#ifdef __KERNEL__
-#define FPE_FIXME	0	/* Broken dup of SI_USER */
-#endif /* __KERNEL__ */
-
 /*
  * SIGTRAP si_codes
  */
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index f5f154942aab..bb3619118926 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -872,7 +872,7 @@ SYSCALL_DEFINE5(osf_setsysinfo, unsigned long, op, void __user *, buffer,
 		fex = (exc >> IEEE_STATUS_TO_EXCSUM_SHIFT) & swcr;
  		if (fex) {
 			siginfo_t info;
-			int si_code = FPE_FIXME;
+			int si_code = FPE_FLTUNK;
 
 			if (fex & IEEE_TRAP_ENABLE_DNO) si_code = FPE_FLTUND;
 			if (fex & IEEE_TRAP_ENABLE_INE) si_code = FPE_FLTRES;
diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 91636765dd6d..422b676b28f2 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -328,7 +328,7 @@ do_entIF(unsigned long type, struct pt_regs *regs)
 			break;
 		case GEN_ROPRAND:
 			signo = SIGFPE;
-			code = FPE_FIXME;
+			code = FPE_FLTUNK;
 			break;
 
 		case GEN_DECOVF:
-- 
2.14.1

