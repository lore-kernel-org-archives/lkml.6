Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4156032-1522167372-2-12993368548664857401
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522167369; b=hWVWJgWH+wBgb+axk0sN6KZwQAwdbkeMUvj749x1sRvmVkl
    h5bh4qe9NHFZZLCs7Q0RbimgHvpTZv/lHcg99DRpNBI+Rj2U5D7Fc3QKV6aCz4Jp
    oT4kn6RNLh6xaXpKf29/c+ykjbCxDTIqMBynG3ZzgNiJl4744k2b1uMl1XI2b3kr
    Kl64sBsW+CuTHTLP9LIl41FOdcI4TICwkjFZ6oEKOqEfCoOtw9qcvKw+1kJYjO4R
    Mj/wUA8500mQc2S8VWOuxMwgrY8smzENn+vswP4K7OhWTrfPRmuXIfH533XC7+1x
    PlQmqmTSN/6TP7fnklGGrtmo1Z2E4SDvWYkj7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522167369;
    bh=CpPowo29il9Q49l2hCR80rSX2fZt0XH081z6Z3OfcbI=; b=wO7JwMqM1Ryt
    AyEz0lGsMdP7HYIHWUHbhz26niBvCY7eXZPcQeoR1yRKUP80750VIWKrPUPCoEwS
    CBX/Q/qoNe+wKpZLmUtNL3F3YQ0K1vQBpkI70F3fEzDvVEE2LisZ7+EuHv/EBysf
    Q+moBAESuScfuzAntjis4+zP2wlOwG8GIla27Oyg/PlOS3eH38wQ8TIiKPhruOBt
    MsY6FfiT4lLiTk90RVskrW5Q9Wp1/kdzxtu4CMQsmePfSHNBN+IfTmpuDXECPKS8
    eMP04vkl+n3TB9c2mska1L0U4ECwQU2GhWTr3qBHF7+tw8LqaEYbAJ94PFD3tMIl
    lPmYxsmq7Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBGwSMmClwJrTEjUFCaK7tX+0AUZqNblx4C3CcVKbQdWhAoZWer7nJJIqFIh4ibVgAxiFBNhYLaLBTMrsud/SbVDi6tW76zK8bhSUV8oVGBXHGxCIiDD
    npIP3fxAEEljrmhRO1PtwFe4pF9KPKs0uvriawGnsSmHFumm5nJW6m13L8RZ4Tb4i1MveKr5UOVKe0vnloIOSUBtQMcHIBaPWoCTnzWq/GpXNkAll/mD6K5z
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=7d_E57ReAAAA:8
    a=drOt6m5kAAAA:8 a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8 a=JfrnYn6hAAAA:8
    a=SOq6UgPBAAAA:8 a=WfulkdPnAAAA:8 a=FOH2dFAWAAAA:8 a=NufY4J3AAAAA:8
    a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8
    a=UPm3pfgAAAAA:8 a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=UyVg9twnpGBeDI6iwygA:9 a=bkWpEpxVr9s0JNFF:21 a=iF-wcr2FuRMqRSyZ:21
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=3hv5r9HjGAh9o5iR9qwG:22
    a=56QPVbyS4OZCpcuOg7Z9:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=TPcZfFuj8SYsoCJAFAiX:22
    a=NdAtdrkLVvyUPsUoGJp4:22 a=2JgSa4NbpEOStq-L5dxp:22 a=uD9XBtlS4o1URY3aiGdj:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeC0QQI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:16:08 -0400
Received: from mail.efficios.com ([167.114.142.138]:53332 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeC0QQB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Mar 2018 12:16:01 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.17 05/21] x86: Add support for restartable sequences
Date: Tue, 27 Mar 2018 12:05:26 -0400
Message-Id: <20180327160542.28457-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Call the rseq_handle_notify_resume() function on return to userspace if
TIF_NOTIFY_RESUME thread flag is set.

Increment the event counter and perform fixup on the pre-signal frame
when a signal is delivered on top of a restartable sequence critical
section.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Paul Turner <pjt@google.com>
CC: Andrew Hunter <ahh@google.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org
---
 arch/x86/Kconfig         | 1 +
 arch/x86/entry/common.c  | 1 +
 arch/x86/kernel/signal.c | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0fa71a78ec99..47a2b14fcc7d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -178,6 +178,7 @@ config X86
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && UNWINDER_FRAME_POINTER && STACK_VALIDATION
 	select HAVE_STACK_VALIDATION		if X86_64
+	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 74f6eee15179..ad348b28bcec 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -164,6 +164,7 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 		if (cached_flags & _TIF_NOTIFY_RESUME) {
 			clear_thread_flag(TIF_NOTIFY_RESUME);
 			tracehook_notify_resume(regs);
+			rseq_handle_notify_resume(regs);
 		}
 
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 4cdc0b27ec82..0f549cbd8b46 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -687,6 +687,12 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	sigset_t *set = sigmask_to_save();
 	compat_sigset_t *cset = (compat_sigset_t *) set;
 
+	/*
+	 * Increment event counter and perform fixup for the pre-signal
+	 * frame.
+	 */
+	rseq_signal_deliver(regs);
+
 	/* Set up the stack frame */
 	if (is_ia32_frame(ksig)) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
-- 
2.11.0

