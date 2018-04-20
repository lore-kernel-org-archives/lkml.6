Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276252-1524186818-2-1436273548526708393
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
    1524186817; b=IpyoBt/9OvMTbTp63jF9L4UQDrdwBkao8cO9lNOA3uPJ1kd+e0
    KcZbjOq2d1+oHINYgDfXGKzjRfRGbj06TRHBUaAcbR/VSAnq+BL0Wg21noaVAOgE
    6KWvnKSS48+G5tGczOevvA4EZN5OKuORmOZ3Zx9tqbqpe1bQZUZCv7ROmRSy0mKT
    70NhBl1iwvR3n4FUq52/WWxnNCgnrNzwfU44pKwr4TWpHvQdONGpG92u5ozusGcA
    3HSki1ErqwfKwc8m6+1Hs1UR+eZh8TppC9J8KjhQmBjGRf49vJpyP6edsq0PkU5N
    eLlngPk6x6LmrY9JWZjXtwZFKhyuNfgNAr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186817; bh=Cmh7
    MIH0GrNbzW80ViV/qfWFsOBZdFcKOnnMjEnRKdo=; b=VuOl/NC/nLW1U8xn8zRX
    wKh5AizpwtGrtUAjUJ60hxntDlvbmTvyIu1jHlQn/gZdomJ2jXUKV/gtg4DP3/Mt
    9KhQ8rEMDn7w3WQfVUhlT0CpfULhSM9jxSQ98dnA0iM0pmsgsd8yTZ3YicmAuMHc
    D4SXNVvW24hZ7vvXnt8k8P+giZUp6Wklwabk8OO0GbCqa2qtQRgGGjPZOP/zreUd
    AVBBtGK0hnOhDgx9c3pWqztYNrdizIQa8b7qEN1ku6USBU7S7dHbPJzqd8PjOLVe
    yiy/VLPHUh2y4MDAuaP6DEVxy70GvyntYpynclJrMNy+eWlGxZclKua4GPr7qNdJ
    Kw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfJLwonfT8j//J6EQF7bVHXVrkff+BKX8V7abkiCaIiEV4F3+np243fs7YNnPBtTYkgvZ8HgUQ1L5XIlnXGc4fer5O2D5m3YBBs3fpdiEG5u5AC5rGQFE
    r5yEAT5RLZZ7l8x+mBgmz6mv5zd2qO5m87vjINkhoXLWXKIiwZSh/bGVhSvjOt2lpOltIaM3Y+tFYC4SOrPzikYtT6hrpbKL71o8SdmeRpPnPtqLP3BpSZuL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=PtDNVHqPAAAA:8
    a=VwQbUJbxAAAA:8 a=oZn3U20kbFeh0i86PjUA:9 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeDTBMO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:12:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50408 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753782AbeDTBMI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:12:08 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 20:04:05 -0500
Message-Id: <20180420010408.24438-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KXH-00014u-Dr;;;mid=<20180420010408.24438-14-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/n1FeKmvx/QM+bYrcCjfCAHE1PECEB+cE=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa05.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4880]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 244 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.8 (1.5%), b_tie_ro: 2.5 (1.0%), parse: 1.28 (0.5%),
        extract_message_metadata: 26 (10.4%), get_uri_detail_list: 2.9 (1.2%),
        tests_pri_-1000: 14 (5.8%), tests_pri_-950: 1.62 (0.7%), tests_pri_-900: 1.26
        (0.5%), tests_pri_-400: 24 (9.7%), check_bayes: 22 (9.2%), b_tokenize: 9
        (3.6%), b_tok_get_all: 7 (2.8%), b_comp_prob: 2.4 (1.0%), b_tok_touch_all:
        2.3 (0.9%), b_finish: 0.73 (0.3%), tests_pri_0: 161 (65.9%),
        check_dkim_signature: 0.55 (0.2%), check_dkim_adsp: 3.0 (1.2%),
        tests_pri_500: 8 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 14/17] signal/unicore32: Use FPE_FLTUNK instead of 0 in ucf64_raise_sigfpe
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The si_code of 0 (aka SI_USER) has fields si_pid and si_uid not
si_addr so it so only by luck would the appropriate fields by copied
to userspace by copy_siginfo_to_user.

This is just broken and wrong.

Make it obvious what is happening by moving the si_code from a
parameter of the one call to ucf64_raise_sigfpe to a constant value
that info.si_code gets set to.

Explicitly set the si_code to FPE_FLTUNK the newly reserved floating
point si_code for an unknown floating point exception.

It looks like there is a fair chance that this is a code path that has
never been used in real life on unicore32.  The bad si_code and the
print statement that calls it an unhandled exception.  So I really
don't expect anyone will mind if this just gets fixed.

In similar situations on more popular architectures the conclusion was
just fix it.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Arnd Bergmann <arnd@arndb.de>
Fixes: d9bc15794d12 ("unicore32 additional architecture files: float point handling")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/unicore32/kernel/fpu-ucf64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/unicore32/kernel/fpu-ucf64.c b/arch/unicore32/kernel/fpu-ucf64.c
index d785955e1c29..8594b168f25e 100644
--- a/arch/unicore32/kernel/fpu-ucf64.c
+++ b/arch/unicore32/kernel/fpu-ucf64.c
@@ -52,14 +52,14 @@
  * Raise a SIGFPE for the current process.
  * sicode describes the signal being raised.
  */
-void ucf64_raise_sigfpe(unsigned int sicode, struct pt_regs *regs)
+void ucf64_raise_sigfpe(struct pt_regs *regs)
 {
 	siginfo_t info;
 
 	clear_siginfo(&info);
 
 	info.si_signo = SIGFPE;
-	info.si_code = sicode;
+	info.si_code = FPE_FLTUNK;
 	info.si_addr = (void __user *)(instruction_pointer(regs) - 4);
 
 	/*
@@ -94,7 +94,7 @@ void ucf64_exchandler(u32 inst, u32 fpexc, struct pt_regs *regs)
 		pr_debug("UniCore-F64 FPSCR 0x%08x INST 0x%08x\n",
 				cff(FPSCR), inst);
 
-		ucf64_raise_sigfpe(0, regs);
+		ucf64_raise_sigfpe(regs);
 		return;
 	}
 
-- 
2.14.1

