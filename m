Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2081085-1525128444-2-8131042280156176404
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
    1525128443; b=BpyG9NWI2yz9UQgxy7p4mbzn3kFb55bQ+a3eN2IcygrSbngdEp
    4+kgk73R+iBfHRUXvjNjIl2oleR9hjnY9ZYXrtg7Gos7ReNtin/W8cCj34CVT/QO
    jCuwQNKDEeGL5YV+7uwFUaDjzmkvl0UvloNP3sL1aibxUl/zxQCAPMbr4dKzRLti
    SCt14mdGL477nVGed/lLMYrS21a5XtVgjMHp0pvRwhqtDtELcCklQdn7kqQuZ7Vy
    RMAagWLVJUsIaeuEzXngs2PZ+3/yvW+40lVkR84wKg7hrZXP8fS6WsbAINshq3Tq
    /IAxGro7N3bQpSGLwVVKLvvYC4SGphA+nOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525128443; bh=
    lyX3Z528EZmMqEJ9GytqlMs+yf3f8r8Y/KPBQCZLgIU=; b=ddOrA4pJNdfYItN2
    PgzCW+e1aEn5tOUg0RqiNCYoo0+knyNNW3IMmk9v0oROaJRjylTfd5B5G2Hr7YT/
    fos4bRV3dnNwndOT2EJUIHZVJi6x54j1XHk6mzFiq/tEfos1BwpOypB8N5FCYwH0
    2Xc8h4CktZWFnPn2oaIiA+mQhEdr6CZs5UE+3fuhLDyd/GqKPCf42bTsgrb9U16m
    +p8GJXpcAOGc2eHY0umxhs6iwQGQYJ4LVjNnff3GAeAP2Y4rleSmntqk+pTAS6ge
    c7II4VTif0s001oHdmm4Lx9UcC5qXxgUkiWZjcQY8Iio5GKmOVo5HPYrjEpzCm/t
    VgpB4g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfCKyLVGy1et6mLA6yhfxx1pGBys66Pdb4iIxUUbsiv07hsLguDQc//msAUAMWWeqCEVMUGl39fb8bNbBzzZ+XdjboQsIimWAHbk1XrCpOdzlf5HeWXls
    TgxYcWpyatdGNrgvfTnBesI15DtCM3QtFJidaBLP2UWVUugo7tcXryVEotFmwpMpCG/mjuJvrx57d3TZISjUniB9a4WFvNzaTD3nOTjS7MLFjAgeCOIRa97b
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8
    a=7d_E57ReAAAA:8 a=wMNdZWldAAAA:8 a=hGzw-44bAAAA:8 a=JfrnYn6hAAAA:8
    a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8 a=G5HWyBugIy8sD1MnFzYA:9
    a=U-Kt6-Ji7Vr91if6:21 a=FLGmjylF8EaF4hMs:21 a=x8gzFH9gYPwA:10
    a=jhqOcbufqs7Y1TYCrUUU:22 a=FUarYpL4UH3yWsho8X8J:22 a=HvKuF1_PTVFglORKqfwH:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=IC2XNlieTeVoXbcui8wp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755498AbeD3Wqy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 18:46:54 -0400
Received: from mail.efficios.com ([167.114.142.138]:52980 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755442AbeD3Woq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Apr 2018 18:44:46 -0400
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/14] powerpc: Add support for restartable sequences
Date: Mon, 30 Apr 2018 18:44:26 -0400
Message-Id: <20180430224433.17407-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Boqun Feng <boqun.feng@gmail.com>

Call the rseq_handle_notify_resume() function on return to userspace if
TIF_NOTIFY_RESUME thread flag is set.

Perform fixup on the pre-signal when a signal is delivered on top of a
restartable sequence critical section.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/Kconfig         | 1 +
 arch/powerpc/kernel/signal.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c32a181a7cbb..ed21a777e8c6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -223,6 +223,7 @@ config PPC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_RSEQ
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 61db86ecd318..d3bb3aaaf5ac 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -133,6 +133,8 @@ static void do_signal(struct task_struct *tsk)
 	/* Re-enable the breakpoints for the signal stack */
 	thread_change_pc(tsk, tsk->thread.regs);
 
+	rseq_signal_deliver(tsk->thread.regs);
+
 	if (is32) {
         	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
 			ret = handle_rt_signal32(&ksig, oldset, tsk);
@@ -164,6 +166,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
+		rseq_handle_notify_resume(regs);
 	}
 
 	user_enter();
-- 
2.11.0

