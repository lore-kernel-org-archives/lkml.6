Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223491-1524186557-2-11234304212939271264
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
    1524186556; b=uTgbPjSDuYjFEoHBzLev7Z9lPTKhuX9woZ43LgvMzKb/hj7UPX
    2+iDY7QsIE02yQ8+0d4/BelqR7O2IJp3S+ES0KTZfCHIjBod4XfBIKVEExsXpRis
    oeKK3WdNvv5v9HwtsabqfGxLqgWhybUpg3B9aTrFO5o1VTyPAnOUVc+dfd6RosxF
    f/ddgPecM9nKG2UH3y54j3xMgU+O6kS1k0it1F6EAwK6tGPuG2fVVdNpxc46GYNI
    LywlSUYRr0db5xklBOHWZKHfIg2CpDDtzH7GkL5iWqM/mivaoywpmGzwVTCR9b8w
    PWG9wUU1Xo4jdc4riuKYdZEe3ruo4TXo6GhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186556; bh=hrjd
    SHbKxPumI+6q81JJCncDi/6vr5P3BXeTQ4XqXas=; b=cb8nsu/NXVufcbuQMVny
    +55ShInbxZhbDT4dGXgmyuG15uXglti+3DIGumLIsEfBnm3S5i5LA0Nd1OQO09Wc
    PIpZCfd21Ofn4T0M7VAIuZn4xRJ3Kl7/7GjjZJWa1r9I66uHvcRG8M91784Vmj2p
    r8qFLBQ+i8KIpotyQKYovXbg6E7ZOrq09iqVU/pFkephMAv4nhWKAK+ISyLfpE1r
    CFCaTiGQ5bt4iYzYZisR5lc3ywUJtC9L1zHkN9ryaBWYb4e79TGP3jcPxRtTGti2
    CphdeA3LrT0FftJuk4a8Uy9hZzaVtfAIjDMQpDb4FH1+seDrO8+GPe5S9VTcG4AD
    XA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEzug36DPiKu2e6f1yZcn4gn9sHBY/xShACvN9zvfK7EPqIsWsx2uTWxX2VSJXvs4VjGz0geELDwvP3vVaN5OlHxXVlefWZkNOtU1dX2nJocZj+RKugI
    uPcdpyFGJlOXIkXsPCWckuXAxrVXbE3AQ2PeCm9rzrySrFvYUbYfytcaDK3A+Zu32eXhuSgdNnmHcyUKk2OLvwFUyVTHQWE9WmTIC+nyYpGdILZPsFi7uok0
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=PtDNVHqPAAAA:8
    a=VwQbUJbxAAAA:8 a=BOQMbGMBe2QSaYG7RW0A:9 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbeDTBHM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:07:12 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50103 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754111AbeDTBHK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:07:10 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Thu, 19 Apr 2018 20:03:58 -0500
Message-Id: <20180420010408.24438-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KW4-00014u-8A;;;mid=<20180420010408.24438-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/WQLWGLuc0FfpoA5VsF5c2b2XKVp4Zb/8=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on sa03.xmission.com
X-Remote-Spam-Level: ******
X-Remote-Spam-Status: No, score=6.2 required=8.0 tests=ALL_TRUSTED,BAYES_40,DCC_CHECK,
        TR_Symld_Words,T_TooManySym_01,XMGappySubj_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.0
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2837]
        *  3.0 DCC_CHECK Listed in DCC (http://rhyolite.com/anti-spam/dcc/)
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=many]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=many 
X-Remote-Spam-Combo: ******;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 832 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 4.1 (0.5%), b_tie_ro: 3.0 (0.4%), parse: 1.41 (0.2%),
        extract_message_metadata: 28 (3.4%), get_uri_detail_list: 4.9 (0.6%),
        tests_pri_-1000: 11 (1.3%), tests_pri_-950: 2.5 (0.3%), tests_pri_-900: 1.85
        (0.2%), tests_pri_-400: 37 (4.4%), check_bayes: 34 (4.1%), b_tokenize: 15
        (1.8%), b_tok_get_all: 8 (1.0%), b_comp_prob: 4.4 (0.5%), b_tok_touch_all:
        2.8 (0.3%), b_finish: 0.86 (0.1%), tests_pri_0: 733 (88.1%),
        check_dkim_signature: 0.95 (0.1%), check_dkim_adsp: 5.0 (0.6%),
        tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 07/17] signal: Reduce copy_siginfo_to_user to just copy_to_user
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that every instance of struct siginfo is now initialized it is no
longer necessary to copy struct siginfo piece by piece to userspace
but instead the entire structure can be copied.

As well as making the code simpler and more efficient this means that
copy_sinfo_to_user no longer cares which union member of struct
siginfo is in use.

In practice this means that all 32bit architectures that define
FPE_FIXME will handle properly send SI_USER when kill(SIGFPE) is sent.
While still performing their historic architectural brokenness when 0
is used a floating pointer signal.  This matches the current behavior
of 64bit architectures that define FPE_FIXME who get lucky and an
overloaded SI_USER has continuted to work through copy_siginfo_to_user
because the 8 byte si_addr occupies the same bytes in struct siginfo
as the 4 byte si_pid and the 4 byte si_uid.

Problematic architectures still need to fix their ABI so that signalfd
and 32bit compat code will work properly.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 84 ++-------------------------------------------------------
 1 file changed, 2 insertions(+), 82 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d4ccea599692..d56f4d496c89 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2850,89 +2850,9 @@ enum siginfo_layout siginfo_layout(int sig, int si_code)
 
 int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
 {
-	int err;
-
-	if (!access_ok (VERIFY_WRITE, to, sizeof(siginfo_t)))
+	if (copy_to_user(to, from , sizeof(struct siginfo)))
 		return -EFAULT;
-	if (from->si_code < 0)
-		return __copy_to_user(to, from, sizeof(siginfo_t))
-			? -EFAULT : 0;
-	/*
-	 * If you change siginfo_t structure, please be sure
-	 * this code is fixed accordingly.
-	 * Please remember to update the signalfd_copyinfo() function
-	 * inside fs/signalfd.c too, in case siginfo_t changes.
-	 * It should never copy any pad contained in the structure
-	 * to avoid security leaks, but must copy the generic
-	 * 3 ints plus the relevant union member.
-	 */
-	err = __put_user(from->si_signo, &to->si_signo);
-	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user(from->si_code, &to->si_code);
-	switch (siginfo_layout(from->si_signo, from->si_code)) {
-	case SIL_KILL:
-		err |= __put_user(from->si_pid, &to->si_pid);
-		err |= __put_user(from->si_uid, &to->si_uid);
-		break;
-	case SIL_TIMER:
-		/* Unreached SI_TIMER is negative */
-		break;
-	case SIL_POLL:
-		err |= __put_user(from->si_band, &to->si_band);
-		err |= __put_user(from->si_fd, &to->si_fd);
-		break;
-	case SIL_FAULT:
-		err |= __put_user(from->si_addr, &to->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		err |= __put_user(from->si_trapno, &to->si_trapno);
-#endif
-#ifdef __ia64__
-		err |= __put_user(from->si_imm, &to->si_imm);
-		err |= __put_user(from->si_flags, &to->si_flags);
-		err |= __put_user(from->si_isr, &to->si_isr);
-#endif
-		/*
-		 * Other callers might not initialize the si_lsb field,
-		 * so check explicitly for the right codes here.
-		 */
-#ifdef BUS_MCEERR_AR
-		if (from->si_signo == SIGBUS && from->si_code == BUS_MCEERR_AR)
-			err |= __put_user(from->si_addr_lsb, &to->si_addr_lsb);
-#endif
-#ifdef BUS_MCEERR_AO
-		if (from->si_signo == SIGBUS && from->si_code == BUS_MCEERR_AO)
-			err |= __put_user(from->si_addr_lsb, &to->si_addr_lsb);
-#endif
-#ifdef SEGV_BNDERR
-		if (from->si_signo == SIGSEGV && from->si_code == SEGV_BNDERR) {
-			err |= __put_user(from->si_lower, &to->si_lower);
-			err |= __put_user(from->si_upper, &to->si_upper);
-		}
-#endif
-#ifdef SEGV_PKUERR
-		if (from->si_signo == SIGSEGV && from->si_code == SEGV_PKUERR)
-			err |= __put_user(from->si_pkey, &to->si_pkey);
-#endif
-		break;
-	case SIL_CHLD:
-		err |= __put_user(from->si_pid, &to->si_pid);
-		err |= __put_user(from->si_uid, &to->si_uid);
-		err |= __put_user(from->si_status, &to->si_status);
-		err |= __put_user(from->si_utime, &to->si_utime);
-		err |= __put_user(from->si_stime, &to->si_stime);
-		break;
-	case SIL_RT:
-		err |= __put_user(from->si_pid, &to->si_pid);
-		err |= __put_user(from->si_uid, &to->si_uid);
-		err |= __put_user(from->si_ptr, &to->si_ptr);
-		break;
-	case SIL_SYS:
-		err |= __put_user(from->si_call_addr, &to->si_call_addr);
-		err |= __put_user(from->si_syscall, &to->si_syscall);
-		err |= __put_user(from->si_arch, &to->si_arch);
-		break;
-	}
-	return err;
+	return 0;
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.14.1

