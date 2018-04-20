Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276252-1524186410-2-14281621174721693056
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524186409; b=YL2K7olP3zMy2a9q385YOrB3wrj7A/eH6FEQXRAfkNh5Xbuw6B
    za9Ztaknz/kURkpJ3xwZJGrPzhXDXdBV2fmietpXWJtOJkKloT03fVhltJKdk4rr
    iiCicQkBbA4+RqfZC42WCjLnHgmR/ah52BENzt26UbQCwubJ4iP4uagn02C3bbaY
    Ms3J9cypZ+2DjMTAftiAISeeMCSUidjiz9imDAOHwr/SiN7ak+JXH6mzYS9EyDg+
    GqKrIsk4XUiH2dSPcARMgM8e5DBXbwoj1jONT0iDDFaPeNYj3TceadMR9j53sxmc
    m8tncF6S3kjk8Kyg3be0Zi+4YqJnlRES1Ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186409; bh=n+v2
    9CeHTyvo53Bmk7wYOK4BasTI9Z/Ow4FHiA2In84=; b=aJkvmKj5fy9Vc0/KjVVa
    /OnEIVwbPBGAwWroN9I2hXDQxaHhuVRWygNwakDRFDrvyrGJATtXyK0MccuOhwCn
    le3F7u7VEozQm/nXYhhRpjj6TMwFyAN3x3CE4mW0N+ZRT5GIGpy3uQaydJIEUVtv
    +epKcZ84DorqCUDEH3c82Su8j/seNqi7USJw4vshrfvEGfruWc6bBeksccaFd4Qa
    ZUfXPl6wBCo3n4SKKoT0d1J1GQg04Onp97oLOQCAgYtuSTqChmnVrKKs9gxSqD67
    ZNJB7xBDYyU1LDGk08VhX0qklm5m2pr2GquIHNWTRbzIH/vcYOS19xzefUQOoVPh
    IQ==
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
X-CM-Envelope: MS4wfLg7ROABbkw+90FIaHQfUt7fCyM8s9op6e0Wwqrr/MD2xNADSl4KQdoqlgj9GwgNaGmLOOU3HyExlWuCvGJFS8dBzVEgFm78byLUm6S0GCjL7kvZk2oi
    UqSprosA9xoEhHZsMrpXsUhuPunEPeEzcCm+zaN6Hdz4hqPU9a+pf0+UnTpu5SmknyLDiHl1vXGmccemZuC15UhEPv4Lk57XTDN96wLsU58TprMBdTJXfa4V
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=bH78PYQqAAAA:8
    a=NEAV23lmAAAA:8 a=J1Y8HTJGAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=PtDNVHqPAAAA:8 a=R5dTVfdzx5mT-OIY39QA:9 a=x8gzFH9gYPwA:10
    a=TrXR8j8ql9YpJ1_1srv2:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
    a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754049AbeDTBGq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:06:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50077 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeDTBGo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:06:44 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>
Date: Thu, 19 Apr 2018 20:03:53 -0500
Message-Id: <20180420010408.24438-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KVO-00014u-I5;;;mid=<20180420010408.24438-2-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Bp/mkLY/hd/JB2fRH+gwyNpyh0/nTNPk=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15031 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.2 (0.0%), b_tie_ro: 2.3 (0.0%), parse: 0.75 (0.0%),
        extract_message_metadata: 18 (0.1%), get_uri_detail_list: 2.5 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.25 (0.0%), tests_pri_-900:
        0.97 (0.0%), tests_pri_-400: 23 (0.2%), check_bayes: 22 (0.1%), b_tokenize: 8
        (0.1%), b_tok_get_all: 7 (0.0%), b_comp_prob: 1.96 (0.0%), b_tok_touch_all:
        3.0 (0.0%), b_finish: 0.62 (0.0%), tests_pri_0: 188 (1.3%),
        check_dkim_signature: 0.47 (0.0%), check_dkim_adsp: 3.0 (0.0%),
        tests_pri_500: 14790 (98.4%), poll_dns_idle: 14778 (98.3%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 02/17] sparc: fix compat siginfo ABI regression
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Dmitry V. Levin" <ldv@altlinux.org>

Starting with commit v4.14-rc1~60^2^2~1, a SIGFPE signal sent via kill
results to wrong values in si_pid and si_uid fields of compat siginfo_t.

This happens due to FPE_FIXME being defined to 0 for sparc, and at the
same time siginfo_layout() introduced by the same commit returns
SIL_FAULT for SIGFPE if si_code == SI_USER and FPE_FIXME is defined to 0.

Fix this regression by removing FPE_FIXME macro and changing all its users
to assign FPE_FLTUNK to si_code instead of FPE_FIXME.

Note that FPE_FLTUNK is a new macro introduced by commit
266da65e9156d93e1126e185259a4aae68188d0e.

Tested with commit v4.16-11958-g16e205cf42da.

This bug was found by strace test suite.

In the discussion about FPE_FLTUNK on sparc David Miller said:
> Eric, feel free to do something similar on Sparc.

Link: https://github.com/strace/strace/issues/21
Fixes: cc731525f26a ("signal: Remove kernel interal si_code magic")
Fixes: 2.3.41
Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Conceptually-Acked-By: David Miller <davem@davemloft.net>
Thanks-to: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/sparc/include/uapi/asm/siginfo.h | 7 -------
 arch/sparc/kernel/traps_32.c          | 2 +-
 arch/sparc/kernel/traps_64.c          | 2 +-
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/siginfo.h b/arch/sparc/include/uapi/asm/siginfo.h
index 896ce447d16a..e7049550ac82 100644
--- a/arch/sparc/include/uapi/asm/siginfo.h
+++ b/arch/sparc/include/uapi/asm/siginfo.h
@@ -17,13 +17,6 @@
 
 #define SI_NOINFO	32767		/* no information in siginfo_t */
 
-/*
- * SIGFPE si_codes
- */
-#ifdef __KERNEL__
-#define FPE_FIXME	0	/* Broken dup of SI_USER */
-#endif /* __KERNEL__ */
-
 /*
  * SIGEMT si_codes
  */
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index b1ed763e4787..33cd35bf3dc8 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -307,7 +307,7 @@ void do_fpe_trap(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 	info.si_errno = 0;
 	info.si_addr = (void __user *)pc;
 	info.si_trapno = 0;
-	info.si_code = FPE_FIXME;
+	info.si_code = FPE_FLTUNK;
 	if ((fsr & 0x1c000) == (1 << 14)) {
 		if (fsr & 0x10)
 			info.si_code = FPE_FLTINV;
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 462a21abd105..e81072ac52c3 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2372,7 +2372,7 @@ static void do_fpe_common(struct pt_regs *regs)
 		info.si_errno = 0;
 		info.si_addr = (void __user *)regs->tpc;
 		info.si_trapno = 0;
-		info.si_code = FPE_FIXME;
+		info.si_code = FPE_FLTUNK;
 		if ((fsr & 0x1c000) == (1 << 14)) {
 			if (fsr & 0x10)
 				info.si_code = FPE_FLTINV;
-- 
2.14.1

