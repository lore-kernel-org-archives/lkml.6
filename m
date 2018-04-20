Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223491-1524186390-2-9842783775059342699
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
    1524186389; b=Ggpkt/LSAiHIY2ij21mwJKpd2+uEmRTaoypvu9G6l7238OPETL
    Lyo21uxCzLINMRs3VO5mEO+Q3v3qrEU90Gytil+OqcdO0t36b/5kb6I/bvhWmOoy
    BsNdTcWIdZFhmtjBqbrsGgdZ0FtMXasIeoUFwJG3oAEALsTNirWAlk0FojMpwNbE
    Ef036Xi4Va7Er2+itum6VUathQI5+99TutpBAOMZdk4S+QBi6bmpmi0mZDec+F1m
    93jeJmETp2lU2XAjqHa860u3aY83GlFyeB+vsBtcy6oM3tYZN+doQlX5mHggqAIi
    VWn6l5LTD3IHW01QYwzlim/zjIjR/LxmCHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186389; bh=FLCn
    G8N6V/vV6A0t+oUEeE0C6ElLjwD5IQ+ry9v9uc4=; b=IpTGNTpT/FWzCVV9RsMY
    JKD3+9R8XNZIWzKCY+r4PpM5nXMuB6FaJI0lzEW2wCC8n8eoThN0S5JtqXlrGYpn
    Nzm8B1UimB9qLZpCKL2W0SEha1UvHxm4TeYZCaJ1ehF1RGEa6OusqtbGebJCV37Q
    LMFReSvPN7MqZ8gs0HOk10UMvisPv03WDspMOOPUcdKvJc0UahHy8dpQTV3LDcm0
    0HoyyGIHCRSin/tpRQM5IZWrlWr58D1hrjvcB5u/6FD99fKOZ9KCNEMi/tPjLiuD
    6FywqtgSLawcRSaDnitf3zWLjdR7HT3okKlXLVbq6uCt7XjzKd+b5AgCGdDhn0HF
    fw==
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
X-CM-Envelope: MS4wfPgrYcRuvKpkfuUo1guNtzroM/K0l+P0BM5wtsAePp1narproh+vzdtUypNDnV5Wmq6B9ybM2847gZUKZ/dreoWYVA08ZPVRTwVjrNCXWLBWj2Qc65vj
    ppz6HPpByytC42LEiZalVIeiTsml6W1GH5GW39oM39RdKDv1LzDs5BIW6Tm3KIWm9gYQ8FWwA+XndmLEksndMkdwC9tX/5iwJNJmkTdcoj0oAZ9HmjWpvL63
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=rWkr9Ua9AAAA:8
    a=tOO0nKmCAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=PtDNVHqPAAAA:8
    a=8cYQcSIDvJfdrCM2kNsA:9 a=x8gzFH9gYPwA:10 a=Qv-QrLrHZjTXZfLJ-zom:22
    a=Gz67Kf0DkuxJ4rqyVRET:22 a=AjGcO6oz07-iQ99wixmX:22 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbeDTBG1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:06:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50066 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeDTBGZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:06:25 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Helge Deller <deller@gmx.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Date: Thu, 19 Apr 2018 20:03:52 -0500
Message-Id: <20180420010408.24438-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KV7-00014u-MZ;;;mid=<20180420010408.24438-1-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+YEgApePL4+/oeBn5U62uh+ghuglh3t5I=
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
X-Remote-Spam-Timing: total 15029 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.9 (0.0%), b_tie_ro: 2.1 (0.0%), parse: 0.69 (0.0%),
        extract_message_metadata: 18 (0.1%), get_uri_detail_list: 1.57 (0.0%),
        tests_pri_-1000: 3.0 (0.0%), tests_pri_-950: 1.18 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 22 (0.1%), check_bayes: 21 (0.1%), b_tokenize: 8
        (0.1%), b_tok_get_all: 6 (0.0%), b_comp_prob: 2.1 (0.0%), b_tok_touch_all:
        2.9 (0.0%), b_finish: 0.62 (0.0%), tests_pri_0: 138 (0.9%),
        check_dkim_signature: 0.41 (0.0%), check_dkim_adsp: 8 (0.1%), tests_pri_500:
        14841 (98.7%), poll_dns_idle: 14830 (98.7%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 01/17] signal/alpha: Document a conflict with SI_USER for SIGFPE
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Setting si_code to 0 is the same as setting si_code to SI_USER.  This
is the same si_code as SI_USER.  Posix and common sense requires that
SI_USER not be a signal specific si_code.  As such this use of 0 for
the si_code is a pretty horribly broken ABI.

Cc: Helge Deller <deller@gmx.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Ref: 0a635c7a84cf ("Fill in siginfo_t.")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/osf_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 89faa6f4de47..2e02aef5a334 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -872,7 +872,7 @@ SYSCALL_DEFINE5(osf_setsysinfo, unsigned long, op, void __user *, buffer,
 		fex = (exc >> IEEE_STATUS_TO_EXCSUM_SHIFT) & swcr;
  		if (fex) {
 			siginfo_t info;
-			int si_code = 0;
+			int si_code = FPE_FIXME;
 
 			if (fex & IEEE_TRAP_ENABLE_DNO) si_code = FPE_FLTUND;
 			if (fex & IEEE_TRAP_ENABLE_INE) si_code = FPE_FLTRES;
-- 
2.14.1

