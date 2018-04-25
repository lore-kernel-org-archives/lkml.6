Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-976924-1524672943-5-17625204160601030552
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
    1524672942; b=M4W/8+LCsqqfD/Iep5DpuE7g5rsPIkXK1MB91OUfJ6AkkDYMuJ
    g5oPF+g1wlSKHhJQE0cfP5+WR62ZimOXKqW01I6uKqQGNKKskl+Lwu0q7YJlyYtn
    qCXWffk0+HogdLt4TA9w4GdSkxPk1TldDp3YeGXT4VzPI7jZJJXbnzU9BTvwCL4p
    L6JCan+m79GoCKqAv8gfyPBNDe+QZCGFf1MkzIvMYzYn0z+CmsvKnzPwy6Zfx8m+
    zUj1y/tnmOwPi/t1DE2pz7ONZeJHJC3fPD2KA8Eas9GFPC43syCflzDlcsnzUoIc
    PywF+QLyIwnTqdHG4M0fQp1w7d03a7/P/5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1524672942; bh=M28O1UMtlI01TC07KuFvD6jYCyjfA9zHjwpSl3qxEN
    A=; b=OQ27xHPm/mKhaMx55Yyy0G3BJ+MYMc2hVt+dyqNMiOWw3BE5Wnh9PGekN/
    zFn9+1Vo53prYAfR7Pjzz85EiwGxIBxdPfmIsTA7nuYukVAAIkIbZ2kxARaCGx0w
    624tNqhx+A05feX2t5onKtDiQFLvH/1d4aqN3zPWJ6YgnGcDK7BZV5vNz0CWBZZY
    1Tp00nvXAsfQ3KLKSlino83fatfOiciismAaPxTKXnQF1fWDtQltcs9Ij7oYgWiV
    5L41Ul/SVfEWSGxjW0p2yH3xkvvm16Gfv0bk5fm6+8ZSB1HC1zoOVC0ecunCNS8a
    sr42VimpPl2UevUAeFAeCQDnifXw==
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
X-CM-Envelope: MS4wfK4bCogLy1qLR0jGxUcv/HMvxwKDnzRT7EP+imAiHkFRbiLOBRXiy421ceCsnyGnVeRRfS7tLeC/FRSWCByzldABUPpduU5gDd6rThWi6R9yY3PIjtvR
    EMfdvR1sewJb2MWJwOa0Q5OyjnHquBdmht68No07amtRGuYrrNDuuoaiVsm8UivJDMBTtd2pq2U/IuEKMoi1XmuzvHjBvdhmICwBVWBzejMbLVBZj7dcNEDA
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=RnlboG6XQGUm5l5X9f0A:9 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755410AbeDYQPV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:15:21 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52605 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755066AbeDYQPR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:15:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Vincent Chen <deanbo422@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <878t9ilmhv.fsf@xmission.com>
        <20180420010408.24438-5-ebiederm@xmission.com>
        <CAJsyPhyDeafwUQxXgnZ9Rfj6nwYrU_Kgyfv8DQ2q0BkwW25BBw@mail.gmail.com>
Date: Wed, 25 Apr 2018 11:13:45 -0500
In-Reply-To: <CAJsyPhyDeafwUQxXgnZ9Rfj6nwYrU_Kgyfv8DQ2q0BkwW25BBw@mail.gmail.com>
        (Vincent Chen's message of "Wed, 25 Apr 2018 20:10:22 +0800")
Message-ID: <87in8fuuva.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fBN4d-0005vW-Li;;;mid=<87in8fuuva.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19bzHQGudzCNwPp/JLxSNhX1GL1Bc66W44=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa08.xmission.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01 autolearn=disabled
        version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4903]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ;Vincent Chen <deanbo422@gmail.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 452 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 5 (1.1%), b_tie_ro: 4.4 (1.0%), parse: 0.58 (0.1%),
        extract_message_metadata: 16 (3.6%), get_uri_detail_list: 0.93 (0.2%),
        tests_pri_-1000: 17 (3.8%), tests_pri_-950: 13 (2.9%), tests_pri_-900: 0.93
        (0.2%), tests_pri_-400: 49 (10.8%), check_bayes: 48 (10.5%), b_tokenize: 9
        (1.9%), b_tok_get_all: 9 (1.9%), b_comp_prob: 1.45 (0.3%), b_tok_touch_all:
        13 (2.9%), b_finish: 0.65 (0.1%), tests_pri_0: 331 (73.3%),
        check_dkim_signature: 8 (1.9%), check_dkim_adsp: 9 (2.1%), tests_pri_500: 12
        (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] signal/nds32: More information in do_revinsn
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


While reviewing f6ed1ecad56f ("signal/nds32: Use force_sig(SIGILL) in do_revisn")
Vincent Chen asked if it was possible to provide more information in do_revinsn
with force_sig_fault.

That seems reasonable and the appropirate si_code appears to be
ILL_ILLOPC (illegal opcode) as the printk indicates this code path
is triggered when a reserved instruction is exectured.

So update do_revinsn to use force_sig_fault(SIGILL, ILL_ILLOPC, ...).
Giving userspace a much better experience when soemone attempts
to execute a reserved instruction.

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Suggested-by: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Vincent I have updated this from your suggestion to use
ILL_ILLOPC as that appears the more appropriate si_code.
Normally I expect you could just update your nds32 tree and
make this kind of change but since I am touching this code anyway I will
be happy to take this change along with the others.

Does this look good to you?

 arch/nds32/kernel/traps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index a6205fd4db52..5c2f61835ab9 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -349,7 +349,8 @@ void do_revinsn(struct pt_regs *regs)
 	show_regs(regs);
 	if (!user_mode(regs))
 		do_exit(SIGILL);
-	force_sig(SIGILL, current);
+	force_sig_fault(SIGILL, ILL_ILLOPC,
+			(void __user *)instruction_pointer(regs), current);
 }
 
 #ifdef CONFIG_ALIGNMENT_TRAP
-- 
2.14.1

