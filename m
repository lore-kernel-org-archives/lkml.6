Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276252-1524186826-2-17201674274477396530
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524186826; b=eoJlWs7FLKdSCzeLrrK3lDAtTesATjHkYpaRCUHnigRxcuky6H
    8iS/Ursfkn1VbS79h0Ias08oZMZE7LKQZ+A5Y3VGa1h3UqzGZUbWZd5RvSqtKO6i
    4JqHBAnp4txR9iMmB0pTSEQOvgVa0XJPdowX3WSTe9pZU6Ain+V2G9JBlOpxZNVI
    h9P97802fTyX8LuKMHxLGEfOp6o2SUs+9Gupk3BiEpd9ZnqzaReqEIEObALS6x5s
    7cnKgB3zT7+eHfwLDJ7wJF6waKPLiCZ95Io9QimDdvOfmwQiOiWUm9VhbKZP5PlT
    Ft3Md/S4VDNM8kTiJ0CfqCRUrPB+fj3lTUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186826; bh=zv2K
    2tS3XZ9T/CzYS+9eKAEEWCG+tnOQVuLxKAlxS0E=; b=hDfOyn4+3pLswjm0Y6sc
    /EKtUMI3F+iBk0TA0Ettwt2s2iCUrsuTmWLTQTt7qSHsF52xCD6HVogoe9TW9wR/
    GCTy4K6Fm7DEL5cMij8+2z9nWRdaOtUjGBQQ3KjjDXqbL4J65f+NnzHnfCfNJV+P
    w2X6Lor8gEE6FwXhD6awYuXsRFUdKzy3RRb8Cchc9esYuBQjIBMESDFaILfxpd0L
    0toUnVeVdRG8tH6k2LFdpoiR36O7LmCNCmoqUxCa45m17cjwHPkcEql4Lmg0LhYr
    Eajp/X/OwMLZ1Hgb1b8uklWeG2qugjEAOVQjcab2ttyyQCSagkwwPJleko706UhC
    Mg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfDEKl/BRIEluq4pFFZPG07ddsX3rgfNJjP9XTGTbKyDT89FCr5u0bXoHT94RV9tymUqKn68syf0HJBAr/KEJH17lE2brZbEJMHhH8JiU71fU8PvBYWiA
    Dg8QtgdBMd/MOrpQe4ZOonPij0ey/C5vamYaYIbzKwxpJ4i6c4TT5BDezyTZz0AZmOWXfV2FmaRM1WRrbvgMAgLnP2pdAh+jdt8/Ay0LwNQYMMssT+8cy3DK
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=PtDNVHqPAAAA:8 a=NwaC7gLdFL_5klieUeQA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753966AbeDTBMM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:12:12 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50406 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeDTBMI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:12:08 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Date: Thu, 19 Apr 2018 20:04:03 -0500
Message-Id: <20180420010408.24438-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KWx-00014u-Di;;;mid=<20180420010408.24438-12-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19vZBpn6kCxvpe0qopXYf36MWa/zEEJYac=
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
        *      [score: 0.4976]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15032 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 3.9 (0.0%), b_tie_ro: 2.6 (0.0%), parse: 1.23 (0.0%),
        extract_message_metadata: 16 (0.1%), get_uri_detail_list: 2.2 (0.0%),
        tests_pri_-1000: 3.1 (0.0%), tests_pri_-950: 1.28 (0.0%), tests_pri_-900:
        1.03 (0.0%), tests_pri_-400: 20 (0.1%), check_bayes: 19 (0.1%), b_tokenize: 7
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.98 (0.0%), b_tok_touch_all:
        2.7 (0.0%), b_finish: 0.67 (0.0%), tests_pri_0: 164 (1.1%),
        check_dkim_signature: 0.51 (0.0%), check_dkim_adsp: 4.0 (0.0%),
        tests_pri_500: 14818 (98.6%), poll_dns_idle: 14806 (98.5%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 12/17] signal/ia64: Replace FPE_FIXME with FPE_FLTUNK
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

Given recent experience in this area odds are it will not
break anything.  Fixing it removes a hazard to kernel maintenance.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Fixes: 987159266c45 ("Linux version 2.3.48")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/include/uapi/asm/siginfo.h | 7 -------
 arch/ia64/kernel/traps.c             | 4 ++--
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/include/uapi/asm/siginfo.h b/arch/ia64/include/uapi/asm/siginfo.h
index 5aa454ed89db..52b5af424511 100644
--- a/arch/ia64/include/uapi/asm/siginfo.h
+++ b/arch/ia64/include/uapi/asm/siginfo.h
@@ -27,11 +27,4 @@
 #define __ISR_VALID_BIT	0
 #define __ISR_VALID	(1 << __ISR_VALID_BIT)
 
-/*
- * SIGFPE si_codes
- */
-#ifdef __KERNEL__
-#define FPE_FIXME	0	/* Broken dup of SI_USER */
-#endif /* __KERNEL__ */
-
 #endif /* _UAPI_ASM_IA64_SIGINFO_H */
diff --git a/arch/ia64/kernel/traps.c b/arch/ia64/kernel/traps.c
index 972873ed1ae5..c6f4932073a1 100644
--- a/arch/ia64/kernel/traps.c
+++ b/arch/ia64/kernel/traps.c
@@ -353,7 +353,7 @@ handle_fpu_swa (int fp_fault, struct pt_regs *regs, unsigned long isr)
 			clear_siginfo(&siginfo);
 			siginfo.si_signo = SIGFPE;
 			siginfo.si_errno = 0;
-			siginfo.si_code = FPE_FIXME;	/* default code */
+			siginfo.si_code = FPE_FLTUNK;	/* default code */
 			siginfo.si_addr = (void __user *) (regs->cr_iip + ia64_psr(regs)->ri);
 			if (isr & 0x11) {
 				siginfo.si_code = FPE_FLTINV;
@@ -380,7 +380,7 @@ handle_fpu_swa (int fp_fault, struct pt_regs *regs, unsigned long isr)
 			clear_siginfo(&siginfo);
 			siginfo.si_signo = SIGFPE;
 			siginfo.si_errno = 0;
-			siginfo.si_code = FPE_FIXME;	/* default code */
+			siginfo.si_code = FPE_FLTUNK;	/* default code */
 			siginfo.si_addr = (void __user *) (regs->cr_iip + ia64_psr(regs)->ri);
 			if (isr & 0x880) {
 				siginfo.si_code = FPE_FLTOVF;
-- 
2.14.1

