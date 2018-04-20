Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1818344-1524235811-2-17976333883661194271
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524235810; b=To+l5EMueLnwLCyf1+t/O2w6w2GX3sqhPm38/I/UzClQtvnxB/
    0mouubfGmGGRv6xSsWxQpDrMvad/oAtQiH6a6jhiUz0sqfm3VM6lPZaSJk299UVy
    QjYRkBn129dDR61/hG0QVn5TkwZY9qweoH+3swlByxFMdbsssf2v2KGMs97P+I/l
    QAMc329SrdAPYdPE49c441Q12T8QNnofXmBZxe1qjNZTddznhB0+W8mhjI9VHJ+D
    MgE0aa7aRVo64SPpm+4WbWDZvnYwQnVav/l1D79n8QCNVSlDBZF4jJym0ctTeOrh
    pL4BOT26xLAUFSfsEEbMUd/cKJqNoBCk9agw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524235810; bh=eGW4
    kbTZ2xZ0p9ArOU6JJQfvPyrFDVN1KVxaBkq1BgU=; b=kY6h86wvDAsFT/kSpdxW
    yT9kP/yRyOuQ068WBAXi9AaVLHhicx+L9djF6TE7JNLOltgCPQSQsLSXq9XHDlA5
    JJX77e++6MoO3XgybL7p80jABuTm6AjGBGw4NRIHXhoqJowy76bERO4NC+iJlUOw
    HyFUtTsIGHZCw/6a6iQUM3Cg4TvaejX28oqsvfJAc9QdydZKQQNKCsaHA4VznBUA
    x30Wc7GCuGLLilD87jhMfOepFNi1UHiWjcAWYIFcU5feh3YOO0HxHriNeSEQjVZR
    cBElRL7zq0IxQamLfuiLJ8soZRdARWPjsui71yVrwxPdC3njuAWDaO7KEi2R/Ssg
    Iw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPBgnI1gGPsFu2KCQLOy75Pcod9R4VNb+ucxOlwBAL/QLdSqdvC6b1Y+DA8u21FqFXAQ9qQJqDeFhh1tiDUU0MGAmvpHkaUaS4hG0BzY7g6J+C8a3MDq
    gn0TzXAaZwmveMw4C+z2eOMid3AXXzAbfbSA8rx91TFkcPdfPLN/1QqbPG3mdXKN5cu7wIunrlv8DLwAHTXOcULEZHXPw9G1H9uAYD7ABUaykYCT6LPqkyvL
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=F-1i3n2SAAAA:8
    a=pGLkceISAAAA:8 a=u3DotqyyAAAA:8 a=VwQbUJbxAAAA:8 a=PtDNVHqPAAAA:8
    a=SaM_RO4T0lwjWyvdT18A:9 a=DkFbxxcXd2AJf-O9kuUr:22 a=g3YQyp1ytkc1jtnOLIrM:22
    a=AjGcO6oz07-iQ99wixmX:22 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755264AbeDTOtV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 10:49:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44843 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755199AbeDTOqD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Apr 2018 10:46:03 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, stable@vger.kernel.org
Date: Fri, 20 Apr 2018 09:38:10 -0500
Message-Id: <20180420143811.9994-21-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XFL-0006Ha-Ej;;;mid=<20180420143811.9994-21-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18i8hJSYIdg6fuMl9u1yXGnn+6OXyrVp48=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 193 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (1.3%), b_tie_ro: 1.80 (0.9%), parse: 0.64 (0.3%),
        extract_message_metadata: 14 (7.5%), get_uri_detail_list: 1.26 (0.7%),
        tests_pri_-1000: 8 (3.9%), tests_pri_-950: 1.19 (0.6%), tests_pri_-900: 0.97
        (0.5%), tests_pri_-400: 16 (8.4%), check_bayes: 15 (7.9%), b_tokenize: 5
        (2.7%), b_tok_get_all: 5 (2.7%), b_comp_prob: 1.45 (0.8%), b_tok_touch_all:
        1.68 (0.9%), b_finish: 0.53 (0.3%), tests_pri_0: 115 (59.6%),
        check_dkim_signature: 0.43 (0.2%), check_dkim_adsp: 2.2 (1.1%),
        tests_pri_500: 32 (16.7%), poll_dns_idle: 25 (13.1%), rewrite_mail: 0.00
        (0.0%)
Subject: [REVIEW][PATCH 21/22] signal/xtensa: Consistenly use SIGBUS in do_unaligned_user
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While working on changing this code to use force_sig_fault I
discovered that do_unaliged_user is sets si_signo to SIGBUS and passes
SIGSEGV to force_sig_info.  Which is just b0rked.

The code is reporting a SIGBUS error so replace the SIGSEGV with SIGBUS.

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: stable@vger.kernel.org
Fixes: 5a0015d62668 ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 3")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/xtensa/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 51771929f341..90b509f65b6f 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -339,7 +339,7 @@ do_unaligned_user (struct pt_regs *regs)
 	info.si_errno = 0;
 	info.si_code = BUS_ADRALN;
 	info.si_addr = (void *) regs->excvaddr;
-	force_sig_info(SIGSEGV, &info, current);
+	force_sig_info(SIGBUS, &info, current);
 
 }
 #endif
-- 
2.14.1
