Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2904459-1527013178-2-17079904623968010076
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527013177; b=ep20+DWdo5dW4yfU584XKv/e9FyfBstU7zETxCASI5xw613/ke
    Uz6C4hXPhnAzd9OqxnhVKJKpfKZI1Sj2/VauPP+JmMmtuLcLtSif3M2Vc8HnoSDQ
    nddplSBpcBQ+hFhqm1L+5/EGLbU3hn4ulQ1PltdZeVK8PMQ5iDZPLC5D77TXgqS9
    RrcQULpOoDsNvwyxRLHEfNLedZyEvdG6qCC/KUqL6fkvRrSe1egbJFXFnh63UvVl
    PccBW0M8MMK2tcWhwHCnbMAtlwsMfTwaEe6lKKlTJ8kmiMS4OiXbYRnsmS/DleXw
    CtGBL69qGEclXHrs4kAZeqoZHG8A96I5o9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527013177;
    bh=AWKUfKvCQNzIpPkkFNN9y920PTxBmSt4BoMXOk8KeBk=; b=BEeciJ++5PiN
    W1BhZrKp3o7HTrVMQBeqtXzPVpqLDEE7wQKTWESLZuVepmQXI+usTO+ke0p2/Uqm
    BzzkXFl5rXS/vveI1xvWin+vJphGtbh9WaNifhMJ4V7mSYTnVDPtBC3PeaqXHX8r
    2qr9jecnUK/7XjVh3PBcEZuFNkmzoeZhy/R6NKVduZlRFwL1fU0ANgzLFFIWOnXy
    jNFj17f8Ii0MjxaeRf0DlzETFazERSxxFqdaqxHHF/28X5MAAgyDunjmkXz8fe9K
    2BXNUEvgzq3PyjH2Bso5WnHKp5Xkex5MhjwlH0JehPhQG4FDx053dVX4YFwgxFFB
    Q5aphzPohg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=efficios.com header.i=@efficios.com header.b=DWlUZpN+
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=efficios.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=efficios.com header.i=@efficios.com header.b=DWlUZpN+
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=efficios.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfARf0N78k8FFBR2PyddKtjssOfj80V+p4zW5hEgZxzniqVoIVugAztRZvrjyIlyT4kvTohamcxdZMGK+50HaRrCg8VSrqAhP2zBicQdpQzi6pZRzkLSN
    N1Tdjg0AQIXB1hwgY7o9nWGlQWWvhMnUr4lN65i+E/UQZfJ5rMXwtY6YPWli3/oaV5tISezidRkG8z55LhJG3G9HIAmU3sjtVHbY+1tSzoIaMT183M82xqgT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=FqpbrowB-PMA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=2kT2n_QYi9vJlmkipbkA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeEVSTg (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 14:19:36 -0400
Received: from mail.efficios.com ([167.114.142.138]:38086 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEVSTf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 14:19:35 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 54D6D1B0766
Date: Tue, 22 May 2018 14:19:33 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Will Deacon <will.deacon@arm.com>,
        Russell King <linux@arm.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <1564615700.2786.1527013173112.JavaMail.zimbra@efficios.com>
In-Reply-To: <2135166002.2147.1526571001678.JavaMail.zimbra@efficios.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <20180430224433.17407-4-mathieu.desnoyers@efficios.com> <20180516161809.GH12198@hirez.programming.kicks-ass.net> <670368504.1912.1526501593893.JavaMail.zimbra@efficios.com> <20180517133230.GA2688@arm.com> <2135166002.2147.1526571001678.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH 03/14] arm: Add restartable sequences support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2026 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2031)
Thread-Topic: Add restartable sequences support
Thread-Index: hkDF4Yy2rYjeT3UBbYbe4+QoPict4o8/7+pV
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On May 17, 2018, at 11:30 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

[...]
> 
> Or as proposed by Boqun, we can simply call rseq_syscall in a CONFIG_DEBUG_RSEQ
> ifdef. Given that this is a debug option, is it worth it to add the
> current->rseq
> test for NULL in assembly before the call, or do we want to favor simplicity ?
> 

Based on advice from Will Deacon, I alternatively tried to add a new TIF_RSEQ thread
flags, but unfortunately bits 1 through 8 are already used, and this is all that fits
in an immediate operand on arm32 for the fast-path thread flag syscall work mask check
in assembly.

So considering that this is a kernel debug option, I took the approach of adding a
call at the very beginning of return from syscall fast and slow paths, which is only
compiled in if CONFIG_DEBUG_RSEQ=y.

Does the following approach make sense ?


arm: Add syscall detection for restartable sequences

Syscalls are not allowed inside restartable sequences, so add a call to
rseq_syscall() at the very beginning of system call exiting path for
CONFIG_DEBUG_RSEQ=y kernel. This could help us to detect whether there
is a syscall issued inside restartable sequences.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 3c4f887..b427ef8 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -39,12 +39,13 @@ saved_pc    .req    lr
 
        .section .entry.text,"ax",%progbits
        .align  5
-#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING))
+#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING) || \
+       IS_ENABLED(CONFIG_DEBUG_RSEQ))
 /*
  * This is the fast syscall return path.  We do as little as possible here,
  * such as avoiding writing r0 to the stack.  We only use this path if we
- * have tracing and context tracking disabled - the overheads from those
- * features make this path too inefficient.
+ * have tracing, context tracking and rseq debug disabled - the overheads
+ * from those features make this path too inefficient.
  */
 ret_fast_syscall:
  UNWIND(.fnstart       )
@@ -71,14 +72,20 @@ fast_work_pending:
        /* fall through to work_pending */
 #else
 /*
- * The "replacement" ret_fast_syscall for when tracing or context tracking
- * is enabled.  As we will need to call out to some C functions, we save
- * r0 first to avoid needing to save registers around each C function call.
+ * The "replacement" ret_fast_syscall for when tracing, context tracking,
+ * or rseq debug is enabled.  As we will need to call out to some C functions,
+ * we save r0 first to avoid needing to save registers around each C function
+ * call.
  */
 ret_fast_syscall:
  UNWIND(.fnstart       )
  UNWIND(.cantunwind    )
        str     r0, [sp, #S_R0 + S_OFF]!        @ save returned r0
+#if IS_ENABLED(CONFIG_DEBUG_RSEQ)
+       /* do_rseq_syscall needs interrupts enabled. */
+       mov     r0, sp                          @ 'regs'
+       bl      do_rseq_syscall
+#endif
        disable_irq_notrace                     @ disable interrupts
        ldr     r2, [tsk, #TI_ADDR_LIMIT]
        cmp     r2, #TASK_SIZE
@@ -113,6 +120,12 @@ ENDPROC(ret_fast_syscall)
  */
 ENTRY(ret_to_user)
 ret_slow_syscall:
+#if IS_ENABLED(CONFIG_DEBUG_RSEQ)
+       /* do_rseq_syscall needs interrupts enabled. */
+       enable_irq_notrace                      @ enable interrupts
+       mov     r0, sp                          @ 'regs'
+       bl      do_rseq_syscall
+#endif
        disable_irq_notrace                     @ disable interrupts
 ENTRY(ret_to_user_from_irq)
        ldr     r2, [tsk, #TI_ADDR_LIMIT]
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 5879ab3..f09e9d66 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -710,3 +710,10 @@ asmlinkage void addr_limit_check_failed(void)
 {
        addr_limit_user_check();
 }
+
+#ifdef CONFIG_DEBUG_RSEQ
+asmlinkage void do_rseq_syscall(struct pt_regs *regs)
+{
+       rseq_syscall(regs);
+}
+#endif



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
