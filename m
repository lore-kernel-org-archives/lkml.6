Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223491-1524186426-2-13726630849901608416
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
    1524186426; b=mZj5feHt4a/cB8GaRURYN71EGYaoqsUOp9K4a66E5GjCYWwBxP
    4raqLaB4AByQXx9y+O56/pTqjGT4Ct3Ed11YIMECJ6lqitkrqNvdGGXXe3BrHtL/
    2KafalRklyMnnjNCso09i068X7geDerv7WuWbGpwAO+8eyS+E1jCSaeaPK6ZCQur
    5gQ9/T45xtGWKjL2dIdyhlte/hEF+cu+UnKaNxgUKeEPYWYdYjx4VouTh48LJCod
    2tQXMGiHbnSWt3n0zENHQHpcbQNAk0JcPcynmGrP3ele7J2HqTLW0+cwFi6j+5BM
    g6hlkvAr1vmjeTOgc0c3Fy1ypbwBPE5CwQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186426; bh=OPe2
    QerxQnTu2e7zRJbH+icDEjtrR1gBE4xXMsn1sMQ=; b=uTeKKTNywUtvkq40Od2l
    U08IgOVZwECB8yGJpIszj40lOctJ+oKmsSmD1X8CMN0Qn0UIo+RPSYCUifTiFVMG
    lzJOMjVB0eBY3JdFbpXBfquYZdIExJRzQCHgO6mfTb2yWw3Gb5HjwU4soPXb7Ctk
    P2XFJQBW/b1USdwALYBZbL5klGCQbvOOfN2IjzA8s/KU7MsiVPWERHvzuOJ0e15O
    wGTZuxu2RjLk7l98/YgxG/UcU95iWVFmVDwGSFiZ1a3NDkVzV6V7xm/wPvDg3Zyw
    KEf9GoVT3pU6LjKEXjbpQsz6JsBz4nY3D/ypifFg5lI4Km0GeMvJXLe08DECrcc8
    Rw==
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
X-CM-Envelope: MS4wfE40dCO7e6SEqneULC03CUlFyrOlB3JZScvW6Ik2iQ481QngHaMm7K8N4XMQ5iU0wY+dK7kgyBOGRTb4ckqFs3XaFHOSD9YGqJN5hkcseEjThLwH2+dI
    CW7glfxLei5VdhRvgmBCaZ0tNFBP9LXTC2E8ewPfjrtORzKi6qf6bfI4k/SRE/O2P/XlUvW8G/WEKMkC92EV4Y6IuGHHbGLxLWw6PctQKqlL97gjhwtzdpSA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=hAG5_4vcAAAA:8
    a=1cMp6Op0AAAA:8 a=VwQbUJbxAAAA:8 a=PtDNVHqPAAAA:8 a=3wNksUP1Y_UooC3nF7cA:9
    a=Oj1lG1ZJNMcRoTxs:21 a=V_V7dp1rXx_MZzyW:21 a=x8gzFH9gYPwA:10
    a=8Bh8Pg2EFav9IBZ9i9Tn:22 a=cge21SmdFH0vqy2l-lvr:22 a=AjGcO6oz07-iQ99wixmX:22
    a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753761AbeDTBGs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:06:48 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:35746 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeDTBGp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:06:45 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Date: Thu, 19 Apr 2018 20:03:54 -0500
Message-Id: <20180420010408.24438-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KVf-00014u-HY;;;mid=<20180420010408.24438-3-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Pnk6f5A8wP3DPlfyerBDQ9jP7w1RmasY=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
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
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 215 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (1.2%), b_tie_ro: 1.71 (0.8%), parse: 0.66 (0.3%),
        extract_message_metadata: 17 (8.1%), get_uri_detail_list: 1.43 (0.7%),
        tests_pri_-1000: 9 (4.4%), tests_pri_-950: 1.17 (0.5%), tests_pri_-900: 0.97
        (0.5%), tests_pri_-400: 22 (10.3%), check_bayes: 21 (9.8%), b_tokenize: 6
        (2.7%), b_tok_get_all: 7 (3.4%), b_comp_prob: 1.70 (0.8%), b_tok_touch_all:
        2.9 (1.3%), b_finish: 0.57 (0.3%), tests_pri_0: 151 (70.2%),
        check_dkim_signature: 0.45 (0.2%), check_dkim_adsp: 2.8 (1.3%),
        tests_pri_500: 7 (3.3%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 03/17] signal/sh: Use force_sig_fault in hw_breakpoint_handler
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The call chain is:
breakpoint
  notify_die
    hw_breakpoint_exceptions_notify
      hw_breakpoint_handler

So the signal number can only be SIGTRAP.

In hw_breakpoint_handler rc is either NOTIFY_STOP or NOTIF_DONE
both of which notifier_to_errno converts to 0.  So si_errno is 0.

Historically si_addr was left unitialized in struct siginfo which is a
bug.  There appears to be no consensus among the various architectures
which value should be in si_addr.  So since no usable value has
been returned up to this point return NULL in si_addr.

Fixes: 4352fc1b12fa ("sh: Abstracted SH-4A UBC support on hw-breakpoint core.")
Fixes: 34d0b5af50a0 ("sh: Convert ptrace to hw_breakpoint API.")
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sh/kernel/hw_breakpoint.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index afe965712a69..8648ed05ccf0 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -347,13 +347,8 @@ static int __kprobes hw_breakpoint_handler(struct die_args *args)
 
 		/* Deliver the signal to userspace */
 		if (!arch_check_bp_in_kernelspace(bp)) {
-			siginfo_t info;
-
-			info.si_signo = args->signr;
-			info.si_errno = notifier_to_errno(rc);
-			info.si_code = TRAP_HWBKPT;
-
-			force_sig_info(args->signr, &info, current);
+			force_sig_fault(SIGTRAP, TRAP_HWBKPT,
+					(void __user *)NULL, current);
 		}
 
 		rcu_read_unlock();
-- 
2.14.1

