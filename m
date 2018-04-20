Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223491-1524186599-2-9932072653721173889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524186598; b=DOUPhfu4rN67LFBLWZyK5woS/dxr3PQtd1EKk5MOVtuFaDoW+6
    cDWcGcwEzLi5gSXSbUXt8DgI0cTr6Y+7u0Kjk0+LWA0WL9+HMpgtpFTqRjK3Zejp
    YJG/EL5tEWNy2XZD/5gZL9BeX4Ba2akqXRMK8bBvrFqq6G2K1dnwYdo7idTDzw5A
    8qJtXIbTQ5k2OvCJ5G48O0vY2Yq+wbhLgNVYlnRQoJYTodi3I3qj6Jvzvqr52w2U
    DY+aGru/T5TkYc0xw/cD34bpEeSbJ4Vo/PSmG+wdQj4GYMwRxcEanU/9qWDnZQdG
    VE2L7gDQCf/wgd0xakO4A6myTbz6EBUNfD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186598; bh=JRU2
    zp5rm3aWFG/ZClTD6kqOEnGO3Vw5yvYWMlM4Ie4=; b=pPQJPv/CIU4EAvT6k/7+
    nWVjMws7owutcM9kwn1qU7mjQ0ZlDP8wqBUqljX4EUfkL+kkQIz45O5TXXwNw1BD
    YlrXnyqXPinB43HX+96u8t2lgLGFEbHVdBenFQt5UVrSronc5CXSvR4Wsl2AhAsf
    ziMWdf5fCvVX3r/5tNQhxeTQoIIaT4Yuq2XoNxtTyI/dKdKuZBtdmCz1BwgtEaT+
    9H66Zl0N0dKzbBdwzUHbeo7xzRINztKIbSu3A8J58IksF1BNvLvZLTUYYnyHf8tM
    QlaiTfJxlNQKk9yhYzfnhaT3lcXEeTWEUfNdaZI4zIk2S5JVzHnw+mHQ4q0n1SxA
    9Q==
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
X-CM-Envelope: MS4wfFgI/Glxh5WrCRDL9a1yAxcNQbpYioWbKOv8kHXG6+Tn+cOseL24G1OFR8FMBDoEVyL/wAH8NaBK4uU+hCdc6lv/xivlDJWJphLk+RFmOyAr/uFceJDe
    8oxpim0K45VKzZ5+x3B7bSeYhqyuZYByGrvowmijM+cgEuhnaxxp/1xYzp8oWIE+KnrXuz5Mk/hZ5Oc0jMdFUUrRq7yAVvsbkXgpyKb458zdmhYNEiMvK0EN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=ZT-azI6cAAAA:8
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=7rkq99Zf_ZsM-TSiW2EA:9 a=x8gzFH9gYPwA:10
    a=MMnepr4wVL9Sz6vaZzge:22 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeDTBJT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:09:19 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44622 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754095AbeDTBHD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:07:03 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 20:03:56 -0500
Message-Id: <20180420010408.24438-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KVy-00014u-Dk;;;mid=<20180420010408.24438-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Hs5y7g5BPwUrwaAUXgttN6FSv8zCZ5II=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa04.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4768]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 204 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.6 (1.7%), b_tie_ro: 2.4 (1.2%), parse: 1.17 (0.6%),
        extract_message_metadata: 23 (11.5%), get_uri_detail_list: 1.92 (0.9%),
        tests_pri_-1000: 11 (5.2%), tests_pri_-950: 1.64 (0.8%), tests_pri_-900: 1.29
        (0.6%), tests_pri_-400: 20 (9.6%), check_bayes: 18 (8.9%), b_tokenize: 7
        (3.3%), b_tok_get_all: 5 (2.6%), b_comp_prob: 1.92 (0.9%), b_tok_touch_all:
        2.3 (1.1%), b_finish: 0.70 (0.3%), tests_pri_0: 131 (63.9%),
        check_dkim_signature: 0.55 (0.3%), check_dkim_adsp: 3.3 (1.6%),
        tests_pri_500: 8 (4.1%), poll_dns_idle: 1.61 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 05/17] signal/nds32: Use force_sig(SIGILL) in do_revisn
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As originally committed do_revisn would deliver a siginfo for SIGILL
with an si_code composed of random stack contents.  That makes no
sense and is not something userspace can depend on.  So simplify
the code and just use "force_sig(SIG_ILL, current)" instead.

Fixes: 2923f5ea7738 ("nds32: Exception handling")
Cc: Vincent Chen <vincentc@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/nds32/kernel/traps.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 65961bf91d64..8e9a5b1f6234 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -356,14 +356,11 @@ void do_dispatch_tlb_misc(unsigned long entry, unsigned long addr,
 
 void do_revinsn(struct pt_regs *regs)
 {
-	siginfo_t si;
 	pr_emerg("Reserved Instruction\n");
 	show_regs(regs);
 	if (!user_mode(regs))
 		do_exit(SIGILL);
-	si.si_signo = SIGILL;
-	si.si_errno = 0;
-	force_sig_info(SIGILL, &si, current);
+	force_sig(SIGILL, current);
 }
 
 #ifdef CONFIG_ALIGNMENT_TRAP
-- 
2.14.1

