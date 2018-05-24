Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162833-2-14773609156136737496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162833; b=ju4IivdPdPP5V5FLW+MxX5XFYve4/blgZDU2dHS1SzTJ/Zve86
    5ZgflkpnBnDN3ei3d2Nhhe2K1zb5Y0XK3iThCG0hYL6WTLzWKPS+XkBYObQ2YQuE
    pMhCwuj380gNQZRY6jzcutlCegACKPqR8fA+9GynYb7NuhIM2Wt7QSAPO7zO53Ua
    UPqkM98zrDNaH78BBcxZ7fJmIfOoDmxkVg2uYb8628k3epuOttACs5PUPdMWdbdb
    RqjspddJuM5b3b+dqLPR+o3s/f2MwLwvd67B+t9O4dnUGsIVUQjfi7ur6dG8zpdu
    GUM+REphMEz9U0MN5czSK2QFWKkED8pXh8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162833; bh=LJvEztUub5WfoG15eQ3fdL+9Ny/kIx
    ItWy3FncFsPJU=; b=etuYv/5Wfx2fEJmK16uCPlhT49xcdwexn89oAJbCvffZfv
    SdaoWaG2I5rv6uuyxVMetJpbaJmuMeAB2JB0oh3Fe7vwueSVXTsPSgpd8dbpX3kj
    0KRo7blLoSBlorY01iWE6X4ME1UjMVpl5da9jJqIv+a/ic39SZWNNDXa0L/Avmr1
    PUUpPZEQU0DEftQWvNAIJrXjCwBK63O2RqsoZI2EQdsiMSMs6AnDKHATjA5IchgK
    RTNZHnDTJc/PQbWXdIXDQNlMa3DaL2xkynmA+2mXRTuIO2+FjbkIpE/RPDFZwqgv
    xEDo0DAyQqDRgetjxsylmt3rSyZ6U0GqD7ycdD4g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ZCoPQRXw x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ZCoPQRXw x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJSI/Exgm8n4DuWWtS3NHva34oLZQvgmVbHGcN7b0oXN85GkqhYiKamfnbYCitdJqfoZ7z5Mnit+8zz2djchrW5i5lHKzuTkvrnAoV+qFVGcqZUawsQG
    LajPSlb6VV1GJk72l8TTHgsq+BJ9mxKddfIipr+M1Aekdl8jU+W6muhDFhh1LgqSZbHa2Tas/eQX564qmL61VSJz5BpTqJDiWR14C6xoBy4wN/Cfjt2wPxNn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=MvuuwTCpAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=e-Ovw6bNAAAA:8
    a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8 a=WYz05adAXObAxls0UmMA:9 a=QEXdDO2ut3YA:10
    a=fwJGlFohZkAA:10 a=dVHiktpip_riXrfdqayU:22 a=AjGcO6oz07-iQ99wixmX:22
    a=nOxMtLUM5ck9Hn2diPJ4:22 a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966904AbeEXLxf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966903AbeEXJqV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <Waiman.Long@hpe.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stas Sergeev <stsp@list.ru>,
        Scott J Norton <scott.norton@hpe.com>,
        Douglas Hatch <doug.hatch@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH 4.4 51/92] signals: avoid unnecessary taking of sighand->siglock
Date: Thu, 24 May 2018 11:38:28 +0200
Message-Id: <20180524093204.323977661@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <Waiman.Long@hpe.com>

commit c7be96af89d4b53211862d8599b2430e8900ed92 upstream.

When running certain database workload on a high-end system with many
CPUs, it was found that spinlock contention in the sigprocmask syscalls
became a significant portion of the overall CPU cycles as shown below.

  9.30%  9.30%  905387  dataserver  /proc/kcore 0x7fff8163f4d2
  [k] _raw_spin_lock_irq
            |
            ---_raw_spin_lock_irq
               |
               |--99.34%-- __set_current_blocked
               |          sigprocmask
               |          sys_rt_sigprocmask
               |          system_call_fastpath
               |          |
               |          |--50.63%-- __swapcontext
               |          |          |
               |          |          |--99.91%-- upsleepgeneric
               |          |
               |          |--49.36%-- __setcontext
               |          |          ktskRun

Looking further into the swapcontext function in glibc, it was found that
the function always call sigprocmask() without checking if there are
changes in the signal mask.

A check was added to the __set_current_blocked() function to avoid taking
the sighand->siglock spinlock if there is no change in the signal mask.
This will prevent unneeded spinlock contention when many threads are
trying to call sigprocmask().

With this patch applied, the spinlock contention in sigprocmask() was
gone.

Link: http://lkml.kernel.org/r/1474979209-11867-1-git-send-email-Waiman.Long@hpe.com
Signed-off-by: Waiman Long <Waiman.Long@hpe.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stas Sergeev <stsp@list.ru>
Cc: Scott J Norton <scott.norton@hpe.com>
Cc: Douglas Hatch <doug.hatch@hpe.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/signal.h |   17 +++++++++++++++++
 kernel/signal.c        |    7 +++++++
 2 files changed, 24 insertions(+)

--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -97,6 +97,23 @@ static inline int sigisemptyset(sigset_t
 	}
 }
 
+static inline int sigequalsets(const sigset_t *set1, const sigset_t *set2)
+{
+	switch (_NSIG_WORDS) {
+	case 4:
+		return	(set1->sig[3] == set2->sig[3]) &&
+			(set1->sig[2] == set2->sig[2]) &&
+			(set1->sig[1] == set2->sig[1]) &&
+			(set1->sig[0] == set2->sig[0]);
+	case 2:
+		return	(set1->sig[1] == set2->sig[1]) &&
+			(set1->sig[0] == set2->sig[0]);
+	case 1:
+		return	set1->sig[0] == set2->sig[0];
+	}
+	return 0;
+}
+
 #define sigmask(sig)	(1UL << ((sig) - 1))
 
 #ifndef __HAVE_ARCH_SIG_SETOPS
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2495,6 +2495,13 @@ void __set_current_blocked(const sigset_
 {
 	struct task_struct *tsk = current;
 
+	/*
+	 * In case the signal mask hasn't changed, there is nothing we need
+	 * to do. The current->blocked shouldn't be modified by other task.
+	 */
+	if (sigequalsets(&tsk->blocked, newset))
+		return;
+
 	spin_lock_irq(&tsk->sighand->siglock);
 	__set_task_blocked(tsk, newset);
 	spin_unlock_irq(&tsk->sighand->siglock);
