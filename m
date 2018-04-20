Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223491-1524186495-2-5920332910225878708
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
    1524186495; b=noyarlAnPN65A9WoVbfGFas1FDoSPdcC2GrTF/T2OTJKgDnHFt
    yPYyOSa8GypmcEGIAbnmbZrhLdb0peLrG3oeCATAmRfRzHcw9LZpWYVFssng9Zfz
    2BZ7SDv1kQrLrJteBHTmBg+1MFNWlG4tsIllNli4TNQsJvLlB5s5g4DT3NJwPU9E
    e1Zd5XMYJ/5hXsWmVauF3LfnEanFa8bxcv23EuwiOOP3R6KYLo1QrMX7ol0WDK8s
    OPMCTMGff1KX3etogvoRyEylO3yjyuVDrFr94q1gXmAB13Uk7qnXot6s5x6Yzqpr
    nj72FBkeAGZHY8rgDwbN6UCVChOyFXwFeWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186495; bh=qrdH
    TpSFtux8QYAVrQoNracwp5m3uJdby2RCNjmyKBI=; b=aUMcugZBhAR78aJhNEKT
    ahQ+df99LE7kY/BA9f+G1IDJIopAdHu5KtH5KEH0r+gW829C4ZbvKMI98FPLIrVl
    jzkWkPSvCmgr5aXg799Y5A1kAmsCCW94jV3PMjRldX+GkDV2c7Hf0KMUABei7U2U
    PUSRx4VwngYkC0aqiR7CkTzkfZldxCL7znTvpOG7yACXAmtK9niS0MfLKgqycOsX
    S6JchFgL4zubV4bM2Yv77xWNmVsKJI0dZTVtFaGIPAdiKZSY5xkNrf1OIYEotW0j
    rlFrl5QSrY/JXB3rDhKKOSJHiMF1HI4h6IBYHgEIF9MM3CPix/9fhLjIPT2nIYAH
    4Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEuGr20wQgRA8ky8aTv1ZPl6PPeBwBqk90DgOZ86v7dsHymqO65/yav/RkKoPxnTl0Ve6YFUDsljohjMFoAB/XVUL6orSf3OOVSSiv061ND73/hGOEN1
    Q6qU8C2Z/4L3xq39jPV5pNsOLZJCvwNjtlpF/mVpHnz7MySe2ItGY7MOgDRlZqNFsVDKCjjlv016vac8fMNHOwXCI8RUjmQxswjLh9/3WUPovpVXLBmSQzA+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=PtDNVHqPAAAA:8
    a=VwQbUJbxAAAA:8 a=JBZmWCEZv-DXLvYYKGQA:9 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeDTBHr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:07:47 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44677 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754035AbeDTBHp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:07:45 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Thu, 19 Apr 2018 20:04:01 -0500
Message-Id: <20180420010408.24438-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KWP-00014u-JP;;;mid=<20180420010408.24438-10-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18af6b2EsMQtR/b4U8JISa5vhZpeSY2NhQ=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4981]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15020 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.2 (0.0%), b_tie_ro: 1.54 (0.0%), parse: 0.71 (0.0%),
        extract_message_metadata: 10 (0.1%), get_uri_detail_list: 1.83 (0.0%),
        tests_pri_-1000: 2.7 (0.0%), tests_pri_-950: 1.18 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 20 (0.1%), check_bayes: 19 (0.1%), b_tokenize: 8
        (0.1%), b_tok_get_all: 5 (0.0%), b_comp_prob: 1.43 (0.0%), b_tok_touch_all:
        2.6 (0.0%), b_finish: 0.56 (0.0%), tests_pri_0: 196 (1.3%),
        check_dkim_signature: 0.46 (0.0%), check_dkim_adsp: 3.6 (0.0%),
        tests_pri_500: 14784 (98.4%), poll_dns_idle: 14777 (98.4%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 10/17] signal: Remove ifdefs for BUS_MCEERR_AR and BUS_MCEERR_AO
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With the recent architecture cleanups these si_codes are always
defined so there is no need to test for them.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/signalfd.c   | 15 ++-------------
 kernel/signal.c | 24 ++++++++----------------
 2 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index d2187a813376..ff302bf50be4 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -117,26 +117,15 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 #ifdef __ARCH_SI_TRAPNO
 		err |= __put_user(kinfo->si_trapno, &uinfo->ssi_trapno);
 #endif
-#ifdef BUS_MCEERR_AO
 		/*
 		 * Other callers might not initialize the si_lsb field,
 		 * so check explicitly for the right codes here.
 		 */
 		if (kinfo->si_signo == SIGBUS &&
-		     kinfo->si_code == BUS_MCEERR_AO)
+		    ((kinfo->si_code == BUS_MCEERR_AR) ||
+		     (kinfo->si_code == BUS_MCEERR_AO)))
 			err |= __put_user((short) kinfo->si_addr_lsb,
 					  &uinfo->ssi_addr_lsb);
-#endif
-#ifdef BUS_MCEERR_AR
-		/*
-		 * Other callers might not initialize the si_lsb field,
-		 * so check explicitly for the right codes here.
-		 */
-		if (kinfo->si_signo == SIGBUS &&
-		    kinfo->si_code == BUS_MCEERR_AR)
-			err |= __put_user((short) kinfo->si_addr_lsb,
-					  &uinfo->ssi_addr_lsb);
-#endif
 		break;
 	case SIL_CHLD:
 		err |= __put_user(kinfo->si_pid, &uinfo->ssi_pid);
diff --git a/kernel/signal.c b/kernel/signal.c
index a6d55a6e9915..b87a9c21f698 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1539,7 +1539,6 @@ int send_sig_fault(int sig, int code, void __user *addr
 	return send_sig_info(info.si_signo, &info, t);
 }
 
-#if defined(BUS_MCEERR_AO) && defined(BUS_MCEERR_AR)
 int force_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *t)
 {
 	struct siginfo info;
@@ -1568,7 +1567,6 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
 	return send_sig_info(info.si_signo, &info, t);
 }
 EXPORT_SYMBOL(send_sig_mceerr);
-#endif
 
 int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
 {
@@ -2880,14 +2878,11 @@ int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
 #ifdef __ARCH_SI_TRAPNO
 		new.si_trapno = from->si_trapno;
 #endif
-#ifdef BUS_MCEERR_AR
-		if ((from->si_signo == SIGBUS) && (from->si_code == BUS_MCEERR_AR))
-			new.si_addr_lsb = from->si_addr_lsb;
-#endif
-#ifdef BUS_MCEERR_AO
-		if ((from->si_signo == SIGBUS) && (from->si_code == BUS_MCEERR_AO))
+		if ((from->si_signo == SIGBUS) &&
+		    ((from->si_code == BUS_MCEERR_AR) ||
+		     (from->si_code == BUS_MCEERR_AO)))
 			new.si_addr_lsb = from->si_addr_lsb;
-#endif
+
 		if ((from->si_signo == SIGSEGV) &&
 		    (from->si_code == SEGV_BNDERR)) {
 			new.si_lower = ptr_to_compat(from->si_lower);
@@ -2964,14 +2959,11 @@ int copy_siginfo_from_user32(struct siginfo *to,
 #ifdef __ARCH_SI_TRAPNO
 		to->si_trapno = from.si_trapno;
 #endif
-#ifdef BUS_MCEERR_AR
-		if ((from.si_signo == SIGBUS) && (from.si_code == BUS_MCEERR_AR))
+		if ((from.si_signo == SIGBUS) &&
+		    ((from.si_code == BUS_MCEERR_AR) ||
+		     (from.si_code == BUS_MCEERR_AO)))
 			to->si_addr_lsb = from.si_addr_lsb;
-#endif
-#ifdef BUS_MCEER_AO
-		if ((from.si_signo == SIGBUS) && (from.si_code == BUS_MCEERR_AO))
-			to->si_addr_lsb = from.si_addr_lsb;
-#endif
+
 		if ((from.si_signo == SIGSEGV) && (from.si_code == SEGV_BNDERR)) {
 			to->si_lower = compat_ptr(from.si_lower);
 			to->si_upper = compat_ptr(from.si_upper);
-- 
2.14.1

