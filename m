Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2081085-1525128418-2-11675110765166529118
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
    1525128417; b=M0sJdMEmtVs/gYHKuj9oh+4ARAcOoiKfeoI3qrGQRw8G+BwxeB
    csXk4rHhXu49Bkcn5d9SMsoagvzbk/ITJfN/HAx4mXpptZWhb/yS4RjqlCLoVVlW
    orn3eqi9+87FwcErPutj++LWa2DXj8sYwjYGfYF5SDAG2nqkqQbF9kiSl6mNaGOF
    mSYsuhTwMKDIZufYEo71AlO918G+UN1QC/cz1E0dFrP9wB1ZaKh/AIsC3Iyts9Ku
    Hct8VMtkOt/Euh9Mir2TaeE30zlNJY0bRoYhM0zfRMi25VRvZYlVOeOUIwVIkqPp
    BaxKJzJGX8LWOXpu6FU73+QMGN8LAxtBmcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525128417; bh=
    6w1CQ/Bel6eXeSSXXKeEaiQbTjkdX5e9JQqS9SfvrN8=; b=iuJU21k8xSmTd/u1
    TqMIs6v1DCSjn3B8R8GZEsD8WLwj1YNcknXZscBK/X/df1LN/GLcLZG3CvRo4gTe
    yZ7jbVrJy948fEzyxwoT8FV4kITycNRCTkrHnQHwesOjcXJMm5LWgXk0ZTEq6jtt
    a9D/Bt1DkHHvRHE4PbAjSSThRhjHIcoHwjmdNN/8O6vgqgKg3ompq5Qn+Zuvt+Lw
    oiMxldo216STMY3PbcLLIGMlK13ZF8/ug5WdUJo2v2K4GAL8G1PqI4pqO2qsNjlp
    l6nPK+fWjZma1pMSrx7jqxpX1cfrHut5vGwMdZegluccH9JLSRZm13pf332syXV1
    GmaZWg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfCEtyz4eeeXsO2q13gIpNsBb0jsSoFJ2Wl+jbanRnKPl04hGaXMytV4s8F3XrJYV2N0tZpKcDrB7RDlgiJHdy4idv5OjYV/KANzK5a8QDW/pqB6tNPdt
    4gnDaTsgFPDxkMxq5zirUZudK/Y1xpHbVjzFEpR+H3ShhsVz0UdQddHMUNZJXDR6UeWBOsOl3whsH8CM++eA75dQDMrEgPTeBi+uL33xfJAQdA/A/AByKLPJ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=7d_E57ReAAAA:8
    a=drOt6m5kAAAA:8 a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8 a=JfrnYn6hAAAA:8
    a=SOq6UgPBAAAA:8 a=WfulkdPnAAAA:8 a=FOH2dFAWAAAA:8 a=NufY4J3AAAAA:8
    a=20KFwNOVAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8 a=UPm3pfgAAAAA:8
    a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=g7pywOGN1Paq1EdbV4IA:9
    a=LOU8yYvvEhgmHtpI:21 a=9BkHEsnc4kFJ77tt:21 a=x8gzFH9gYPwA:10
    a=jhqOcbufqs7Y1TYCrUUU:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=3hv5r9HjGAh9o5iR9qwG:22 a=56QPVbyS4OZCpcuOg7Z9:22
    a=i3VuKzQdj-NEYjvDI-p3:22 a=TPcZfFuj8SYsoCJAFAiX:22 a=2JgSa4NbpEOStq-L5dxp:22
    a=uD9XBtlS4o1URY3aiGdj:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755450AbeD3Woq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 18:44:46 -0400
Received: from mail.efficios.com ([167.114.142.138]:52892 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755290AbeD3Woo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Apr 2018 18:44:44 -0400
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
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 03/14] arm: Add restartable sequences support
Date: Mon, 30 Apr 2018 18:44:22 -0400
Message-Id: <20180430224433.17407-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Call the rseq_handle_notify_resume() function on return to
userspace if TIF_NOTIFY_RESUME thread flag is set.

Perform fixup on the pre-signal frame when a signal is delivered on top
of a restartable sequence critical section.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Paul Turner <pjt@google.com>
CC: Andrew Hunter <ahh@google.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org
---
 arch/arm/Kconfig         | 1 +
 arch/arm/kernel/signal.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f4b88f..4f5c386631d4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -91,6 +91,7 @@ config ARM
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE if (SMP && ARM_LPAE)
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index bd8810d4acb3..5879ab3f53c1 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -541,6 +541,12 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	int ret;
 
 	/*
+	 * Increment event counter and perform fixup for the pre-signal
+	 * frame.
+	 */
+	rseq_signal_deliver(regs);
+
+	/*
 	 * Set up the stack frame
 	 */
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
@@ -660,6 +666,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 			} else {
 				clear_thread_flag(TIF_NOTIFY_RESUME);
 				tracehook_notify_resume(regs);
+				rseq_handle_notify_resume(regs);
 			}
 		}
 		local_irq_disable();
-- 
2.11.0

