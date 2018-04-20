Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276252-1524186600-2-17781049437604178620
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
    1524186599; b=EKVZBhKJ2rHexUlFJg6pghz2AuAC6Fs1soD+XWtWrgGbNoS39Q
    yG0Yc5vxB/VO1yoWwcPK+i0rnvqpq/cZXTfCs9r6oHMscPRezTFel2ph1LIpXKUM
    CMjjcml02FKSrf0H+AhG8QLK7HN3GOeFSTz790ErTCOnuYEnTe/jSBy0N6SoE/ct
    z8FFiDt8QOsX0xQ4b20qriAWjYKdvffLlLjrm4znLS5NSlAd52hhECeHFbR2oeT4
    LsBFzyCWrz/9t3sYgI1ZYgOP4l7726mX/UBwieaZKXcu4JRjMSmzsVQJ/Q9AaOmu
    SE22JpQ15Bsbr3pyivZSCHIzS3ixgqAEvOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186599; bh=FBor
    vy89eptTM2dfecME3FPKZO3yhvTyPAXJ+iPNspU=; b=fBRh7F8f5KXe0Ti6FIqd
    MmmQbcoZs2NC81dWbpj1Z9DztDrqKYgUMVibVGTKg5nRFE+NS0GIiXB4j1VB9c0v
    BGW4m67f+AQKquAgslnoHGhOdbyhRTx7i0D4Q4ZAdDiYFUV0NmZevwiab0LdXRhG
    uObjxrAsoPIYeQwn8NKL7ujyBi0yeAct58fJF6wYzQ5YV1/1Ea4jGaJ8reCk0f6+
    WxqnzczXD5yLE2dLatZ1UKCmsU0jLaw+qqBzINrOeGhsgI2vogfC7x+6IAxWMdGU
    ucrgnOPXEXxBIVsuwDY5+ujXKO8SfSqW9BVWrjUzALaNBzUjHXLHgx4QatTfd5ez
    Uw==
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
X-CM-Envelope: MS4wfH3eK8tbFbaa4UF7JUd4J2APsgCRuyWg5ayBHEGWSh11/eSOvhfiFRBYDLsLeo4VYQ5O+8+ZQO7901MAzWqT3l45Gwcy2DPWKRLBBE6h/vxSJ9FS/CUm
    km/seUx/QbZkIBPQ5sf+bfdSBqA2K+G60JlOxVIsYY65vptiZ3wNBob2VDXoZletocmaywYcVrHwd5uuCcmoc0K3taAG9igWLPfRWn0h6OL6V90Sm+T1B1PW
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=ZT-azI6cAAAA:8
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=Kt70PQ2AgPF-GNvOW84A:9 a=x8gzFH9gYPwA:10
    a=MMnepr4wVL9Sz6vaZzge:22 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753991AbeDTBHD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:07:03 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:35773 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeDTBHB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:07:01 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 20:03:55 -0500
Message-Id: <20180420010408.24438-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KVh-00014u-Hw;;;mid=<20180420010408.24438-4-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18piH1jbkLUpRAAqTI7RjjE1SfF85JnhGw=
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
        *      [score: 0.4990]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15028 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.6 (0.0%), b_tie_ro: 2.8 (0.0%), parse: 0.68 (0.0%),
        extract_message_metadata: 15 (0.1%), get_uri_detail_list: 1.39 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.16 (0.0%), tests_pri_-900:
        0.95 (0.0%), tests_pri_-400: 19 (0.1%), check_bayes: 18 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 4.9 (0.0%), b_comp_prob: 1.52 (0.0%), b_tok_touch_all:
        3.7 (0.0%), b_finish: 0.59 (0.0%), tests_pri_0: 143 (1.0%),
        check_dkim_signature: 0.44 (0.0%), check_dkim_adsp: 3.9 (0.0%),
        tests_pri_500: 14840 (98.7%), poll_dns_idle: 14828 (98.7%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 04/17] signal/nds32: Use force_sig in unhandled_interruption and unhandled_exceptions
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Neither unhandled_interrupt nor unhandled_exceptions fills in any of the
siginfo fields whend sending SIGKILL.  Further because it is SIGKILL
even if all of the fields were filled out appropriately it would be impossible
for the process to read any of the siginfo fields.  So simplfy things and
just use force_sig instead of force_sig_info.

Fixes: 2923f5ea7738 ("nds32: Exception handling")
Cc: Vincent Chen <vincentc@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/nds32/kernel/traps.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 6e34eb9824a4..65961bf91d64 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -318,29 +318,22 @@ void do_debug_trap(unsigned long entry, unsigned long addr,
 
 void unhandled_interruption(struct pt_regs *regs)
 {
-	siginfo_t si;
 	pr_emerg("unhandled_interruption\n");
 	show_regs(regs);
 	if (!user_mode(regs))
 		do_exit(SIGKILL);
-	si.si_signo = SIGKILL;
-	si.si_errno = 0;
-	force_sig_info(SIGKILL, &si, current);
+	force_sig(SIGKILL, current);
 }
 
 void unhandled_exceptions(unsigned long entry, unsigned long addr,
 			  unsigned long type, struct pt_regs *regs)
 {
-	siginfo_t si;
 	pr_emerg("Unhandled Exception: entry: %lx addr:%lx itype:%lx\n", entry,
 		 addr, type);
 	show_regs(regs);
 	if (!user_mode(regs))
 		do_exit(SIGKILL);
-	si.si_signo = SIGKILL;
-	si.si_errno = 0;
-	si.si_addr = (void *)addr;
-	force_sig_info(SIGKILL, &si, current);
+	force_sig(SIGKILL, current);
 }
 
 extern int do_page_fault(unsigned long entry, unsigned long addr,
-- 
2.14.1

