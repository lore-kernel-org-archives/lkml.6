Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276252-1524186513-2-4721670611211105081
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
    1524186512; b=PZsR2FssFlHGONsMs2tt2fRriv3sDNM7vvdro++VaKLCT4943L
    ALdGOdxabZKnhVRj5eHPqPuFITwR86OL3+AbMUNgEsJuG/NMJgnib1ojqQz1e9a7
    fiRBbvxjazm02qaaCklkyUEH2TnYmgyu4WbMIuq1pHh7eg9vf50ObeVtaHf/iNPV
    MSFfyfPVisZGE33dRJq7Pe6YH0rfqfEY2Lgfmt4CqRN0y0r6TZR8rmH21kSvLEpn
    8gVjOmhWJ+el+0NdrDzcS7WrN0y/gcvbkAb5mHdFqRzccdrgkRCJ+rkZ4kukvcSB
    DlFOnvGicniYc7X0A0qRlcPC+5r5o4P0QHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186512; bh=S1r2
    jnjDHXBACCtvTVYHReQHtUr38JdxrA4ovSDu6yY=; b=jzdNnTnpz7jZQuCbiAgv
    IbynmN3dzgPVwI7RreRuk8m9L/wp89Y3z6umLWv2RyDQS4ZL9C5kvWtAUlCaUS2T
    Q+owHn+NmKnYA3j6oXZW0zuxBIXyk3VYh5bvYVdmSGBdrul2hgEIWOX8rM3zF8Hb
    dW1/fUT1Vfsu4jZN4L1Vsnq3ulhPJ7a6SNdPMdVpXB/FnoYuS+keOMmWzIjgQnla
    wTfu0GAEo4Jkyo7d/HiDfdfz16MXNbPdNGEIvJdN8PB4Kv3j8X7l+z9ETBDzWJMo
    BxHuSHF5O+WNaspq3/DH+8HGQZZnV8sfqarXsMx/oFPEgW6BV/BTcXkAnZ4QyiTw
    Xg==
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
X-CM-Envelope: MS4wfGzD6iLnzsPawMGc/tE/day8Uk4NZ3PTOivMi95r6ZVGGN1ATu31S1NgkME+C3FyI2VnyKnFRHEr861qq9VVmYQ7jBHhZob/QVJOmrRPEH+4+UBYEHA7
    WrYjVTWyuIVIAbsUPGNivDIiNqcrN8eew+3QTfYfdesehfhlP0Dd3ZIgl7zZ/DEf198DWaQM4RZEMRkAGCIzUss25oYEId6hiZKcPmkTieglPUuQAOOV0r+l
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=PtDNVHqPAAAA:8
    a=VwQbUJbxAAAA:8 a=eXZUO_418sDOxnjbNSEA:9 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbeDTBH2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:07:28 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50135 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753992AbeDTBH1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:07:27 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Thu, 19 Apr 2018 20:03:59 -0500
Message-Id: <20180420010408.24438-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KW6-00014u-SB;;;mid=<20180420010408.24438-8-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18uSgI+mxwhJAKd5brXS8cDvuLbLZjNbf0=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: *******
X-Remote-Spam-Status: No, score=7.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,DCC_CHECK,
        TR_Symld_Words,T_TooManySym_01,T_XMDrugObfuBody_04,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4990]
        *  3.0 DCC_CHECK Listed in DCC (http://rhyolite.com/anti-spam/dcc/)
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=many]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_04 obfuscated drug references
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=many 
X-Remote-Spam-Combo: *******;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15023 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (0.0%), b_tie_ro: 1.99 (0.0%), parse: 0.95 (0.0%),
        extract_message_metadata: 11 (0.1%), get_uri_detail_list: 1.57 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.22 (0.0%), tests_pri_-900:
        1.00 (0.0%), tests_pri_-400: 16 (0.1%), check_bayes: 15 (0.1%), b_tokenize:
        4.8 (0.0%), b_tok_get_all: 4.9 (0.0%), b_comp_prob: 1.67 (0.0%),
        b_tok_touch_all: 2.3 (0.0%), b_finish: 0.63 (0.0%), tests_pri_0: 127 (0.8%),
        check_dkim_signature: 0.42 (0.0%), check_dkim_adsp: 2.5 (0.0%),
        tests_pri_500: 14858 (98.9%), poll_dns_idle: 14849 (98.8%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 08/17] signal: Stop special casing TRAP_FIXME and FPE_FIXME in siginfo_layout
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After more experience with the cases where no one the si_code of 0
is used both as a signal specific si_code, and as SI_USER it appears
that no one cares about the signal specific si_code case and the
good solution is to just fix the architectures by using
a different si_code.

In none of the conversations has anyone even suggested that
anything depends on the signal specific redefinition of SI_USER.

There are at least test cases that care when si_code as 0 does
not work as si_user.

So make things simple and keep the generic code from introducing
problems by removing the special casing of TRAP_FIXME and FPE_FIXME.
This will ensure the generic case of sending a signal with
kill will always set SI_USER and work.

The architecture specific, and signal specific overloads that
set si_code to 0 will now have problems with signalfd and
the 32bit compat versions of siginfo copying.   At least
until they are fixed.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d56f4d496c89..fc82d2c0918f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2835,15 +2835,6 @@ enum siginfo_layout siginfo_layout(int sig, int si_code)
 			layout = SIL_POLL;
 		else if (si_code < 0)
 			layout = SIL_RT;
-		/* Tests to support buggy kernel ABIs */
-#ifdef TRAP_FIXME
-		if ((sig == SIGTRAP) && (si_code == TRAP_FIXME))
-			layout = SIL_FAULT;
-#endif
-#ifdef FPE_FIXME
-		if ((sig == SIGFPE) && (si_code == FPE_FIXME))
-			layout = SIL_FAULT;
-#endif
 	}
 	return layout;
 }
-- 
2.14.1

