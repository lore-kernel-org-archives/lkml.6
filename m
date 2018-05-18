Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3904782-1526647136-2-3970912734093438101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526647135; b=m5Nv7NH9/rnU/pkc/pnqduq3meSJvUysFQww7k8FaO89aeelus
    FEBs9IN0KvogwTuSP5Wcp+zYQ+kGjzcVZdB14RwFow5H0m+tKV8hAPYIvWmzBSuy
    ZxJdiO7Iaoejywk9MwErWkBRp0GxST9AgDhpRO3RpJcFdVs6/6iVCJPCjNfjWR5t
    Dv+voWvi0cN8SLKGn/o0Vf8nz2GSE99zRrF+0wyuuaecnsTM8PF6vIT+3uxVBaIc
    ffmp5TLSsfdo857QYjkE+B4M76IRrGijkBD8s567DPl+Fap/7avw9qUM+x6PXjR1
    QWrf4EchbdVfwDLLld5qL/ZvyjM2z8BXE9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1526647135; bh=fdSm/ohAct085C7uHMESnnOUChN/r1UzYXMAWgmb7W
    c=; b=eLGUmHWD6+Z7G9JJ8L8UW90YDqrp9vjjXaRbfdrSJGY6k5OHigL07NVSpp
    xpnIQUEq8gHXcp3AYJOeyeo5xmO44ZmKijVGYNr49Wpv5UieKx5WyaMSTofT/ZJm
    aqovrBJO/W0XnbTpJRFxpyNw+8VEF+EpolTx59lqAwmx7tIZq5eGiZoLRwPvTMMs
    PhC71bwhEVrMbwACdbVjdJdWR4a9Jod+h5vgI1KQSnN83qT9+lMtUi8FKe3h29D5
    Vwzfh3RV43ZH7ay94IZCwaGhgnGNGRInlpN+mGpBaxr4qQL5qD4SvZLUka7vQw+C
    SBrFUkdLZVuoawDX4/9rOKSvCa5w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ellerman.id.au header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ellerman.id.au header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJsYzc32RqbdC7N8ar+/QKryz5+0onHOlndPcz31ama1+5Vntloj7/S3B8c1qZaS/sAI2K2Ytb8MCz+iwCWrHeD8ZCyKfxMIaN+Jsi2hkuEpWamC4Y/9
    VYOB0ieB307sqBfrt50eNkbDRpMv68fIU2wZ91K4Lp5+Xz0CKat1xIOu0DS4YR7/5pPhjltiiUMmbIyiRfcnO6QKYle8slzo0cucWA2NCjSQl8F2HHLz5XHc
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7d_E57ReAAAA:8
    a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=w3vVgvQxHcbt_4zMOR4A:9
    a=rLlfUyBxKXTqtY8U:21 a=7t7ie_civxxDy9oR:21 a=9uJS9M6w_WAA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=M4RU-Flaiq8Hmqv6YSws:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeERMix (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 08:38:53 -0400
Received: from ozlabs.org ([203.11.71.1]:41267 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeERMiw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 18 May 2018 08:38:52 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
In-Reply-To: <277374719.2144.1526570889798.JavaMail.zimbra@efficios.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <20180430224433.17407-8-mathieu.desnoyers@efficios.com> <20180516161837.GI12198@hirez.programming.kicks-ass.net> <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com> <20180517011949.GA1121@tardis> <277374719.2144.1526570889798.JavaMail.zimbra@efficios.com>
Date: Fri, 18 May 2018 22:38:44 +1000
Message-ID: <87sh6pxhnv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> ----- On May 16, 2018, at 9:19 PM, Boqun Feng boqun.feng@gmail.com wrote:
>> On Wed, May 16, 2018 at 04:13:16PM -0400, Mathieu Desnoyers wrote:
>>> ----- On May 16, 2018, at 12:18 PM, Peter Zijlstra peterz@infradead.org wrote:
>>> > On Mon, Apr 30, 2018 at 06:44:26PM -0400, Mathieu Desnoyers wrote:
>>> >> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> >> index c32a181a7cbb..ed21a777e8c6 100644
>>> >> --- a/arch/powerpc/Kconfig
>>> >> +++ b/arch/powerpc/Kconfig
>>> >> @@ -223,6 +223,7 @@ config PPC
>>> >>  	select HAVE_SYSCALL_TRACEPOINTS
>>> >>  	select HAVE_VIRT_CPU_ACCOUNTING
>>> >>  	select HAVE_IRQ_TIME_ACCOUNTING
>>> >> +	select HAVE_RSEQ
>>> >>  	select IRQ_DOMAIN
>>> >>  	select IRQ_FORCED_THREADING
>>> >>  	select MODULES_USE_ELF_RELA
>>> >> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
>>> >> index 61db86ecd318..d3bb3aaaf5ac 100644
>>> >> --- a/arch/powerpc/kernel/signal.c
>>> >> +++ b/arch/powerpc/kernel/signal.c
>>> >> @@ -133,6 +133,8 @@ static void do_signal(struct task_struct *tsk)
>>> >>  	/* Re-enable the breakpoints for the signal stack */
>>> >>  	thread_change_pc(tsk, tsk->thread.regs);
>>> >>  
>>> >> +	rseq_signal_deliver(tsk->thread.regs);
>>> >> +
>>> >>  	if (is32) {
>>> >>          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
>>> >>  			ret = handle_rt_signal32(&ksig, oldset, tsk);
>>> >> @@ -164,6 +166,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long
>>> >> thread_info_flags)
>>> >>  	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
>>> >>  		clear_thread_flag(TIF_NOTIFY_RESUME);
>>> >>  		tracehook_notify_resume(regs);
>>> >> +		rseq_handle_notify_resume(regs);
>>> >>  	}
>>> >>  
>>> >>  	user_enter();
>>> > 
>>> > Again no rseq_syscall().
>>> 
>>> Same question for PowerPC as for ARM:
>>> 
>>> Considering that rseq_syscall is implemented as follows:
>>> 
>>> +void rseq_syscall(struct pt_regs *regs)
>>> +{
>>> +       unsigned long ip = instruction_pointer(regs);
>>> +       struct task_struct *t = current;
>>> +       struct rseq_cs rseq_cs;
>>> +
>>> +       if (!t->rseq)
>>> +               return;
>>> +       if (!access_ok(VERIFY_READ, t->rseq, sizeof(*t->rseq)) ||
>>> +           rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
>>> +               force_sig(SIGSEGV, t);
>>> +}
>>> 
>>> and that x86 calls it from syscall_return_slowpath() (which AFAIU is
>>> now used in the fast-path since KPTI), I wonder where we should call
>> 
>> So we actually detect this after the syscall takes effect, right? I
>> wonder whether this could be problematic, because "disallowing syscall"
>> in rseq areas may means the syscall won't take effect to some people, I
>> guess?
>> 
>>> this on PowerPC ?  I was under the impression that PowerPC return to
>>> userspace fast-path was not calling C code unless work flags were set,
>>> but I might be wrong.
>>> 
>> 
>> I think you're right. So we have to introduce callsite to rseq_syscall()
>> in syscall path, something like:
>> 
>> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> index 51695608c68b..a25734a96640 100644
>> --- a/arch/powerpc/kernel/entry_64.S
>> +++ b/arch/powerpc/kernel/entry_64.S
>> @@ -222,6 +222,9 @@ system_call_exit:
>> 	mtmsrd	r11,1
>> #endif /* CONFIG_PPC_BOOK3E */
>> 
>> +	addi    r3,r1,STACK_FRAME_OVERHEAD
>> +	bl	rseq_syscall
>> +
>> 	ld	r9,TI_FLAGS(r12)
>> 	li	r11,-MAX_ERRNO
>> 	andi.
>> 		r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
>> 
>> But I think it's important for us to first decide where (before or after
>> the syscall) we do the detection.
>
> As Peter said, we don't really care whether it's on syscall entry or exit, as
> long as the process gets killed when the erroneous use is detected. I think doing
> it on syscall exit is a bit easier because we can clearly access the userspace
> TLS, which AFAIU may be less straightforward on syscall entry.

Coming in to the thread late, sorry if I'm missing the point.

> We may want to add #ifdef CONFIG_DEBUG_RSEQ / #endif around the code you
> proposed above, so it's only compiled in if CONFIG_DEBUG_RSEQ=y.

That sounds good. A function call is not free even if it returns immediately.

> On the ARM leg of the email thread, Will Deacon suggests to test whether current->rseq
> is non-NULL before calling rseq_syscall(). I wonder if this added check is justified
> as the assembly level, considering that this is just a debugging option. We already do
> that check at the very beginning of rseq_syscall().

I guess it depends if this is one of those "debugging options" that's
going to end up turned on in distro kernels?

I think in that code we'd need to check paca->current->rseq, so that
wouldn't be free either.

cheers
