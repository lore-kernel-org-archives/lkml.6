Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2288337-1526570924-2-823519937396976079
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
    1526570923; b=T4vTaGWpyth5kX+5t+xNAYm5cZ2RNPAznVUfxEWbqlcxiMw4NB
    iFMzcuAItWG8AKOaiS0VsKhqyi2JA7quFMO7NsModa1SKJBl+1Da8zMOobzlEXK8
    +0QA3j7ED7F9y1yRkUq6xY//HBeQA/r2U1Ti+t24jWt35RGZfjJMfKhrKBQNtkTq
    yzbAosX+O+aNDREN/psffwmulyBUfanzhzdwxQ3uFEjbl7wCYbybG63vnz0K4iut
    hMjoicYpaPllAw1eK/J6coxd7zVFlTI5iwhXoLB7RwJrsyP85V9n1d737H2KZs7X
    L6osJXGfAYibt/xZENLm/XA8DWTukGdeun4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526570923;
    bh=9F1fBwc07AVFqbr69/jXwCznjPoS3d6aziAK4jzjiqQ=; b=lim4ynwza6Ka
    n9JsEbVzNr0AUkv/I4Di/6OU+2cdfFLQkEG0i4p2d/zPjQWiCssaV2ckiCTgWabT
    5QLXqWHf/+h+tOZy9q0A6yi2MYFseEgRd/96XmBgoC2ABzNEIqFzmHOxKLJ4OzCN
    JoyAWngqZuwPE6Jj+FnWCE3nI7Q+fNGlVrNKSj1kr8sDUAiwYqkCgRJIPMKzIs1Q
    Zd4FMMA2hrsNAWGTdz3g99FMwMHNfxExy+NUmfN2G6OU7I78501i6FeqRC2wc6iN
    3aH0JsyTZRbXhUfE1deXeEHnHwYKB0E4oPm/ZZJI8CFe8ynGoU8CORRZgl63tRhx
    YvssBL9rog==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=efficios.com header.i=@efficios.com header.b=p53qf0Z9
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=efficios.com header.i=@efficios.com header.b=p53qf0Z9
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
X-CM-Envelope: MS4wfOtvke3pszlpV9WbAx3YyrrkQaBFp9WuZM6FhPxVxzC5Ypfd2HXYQx/bxlOZVj02dhuq4hvy6q24LZE2JhxbeoJjCafirC5ob1y1V0uPYNhnAWspk8P6
    U2BW/FkFIP6smFWZHSxdXGx9/u7ArlJ7tvYx6aIi9TlqlWMbJKsnVFmsl6YojHLh1V1adWzWWY51sGpBKDYOH0Qg+sWmH5Xe/+yF9ajh9odbOk9eeJhaYTrd
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10 a=FqpbrowB-PMA:10 a=pGLkceISAAAA:8
    a=JfrnYn6hAAAA:8 a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=UBAswzqG-q0dGkjG6JYA:9
    a=Zly5CFrAdkx83X80:21 a=_joe3xwz4do74tTQ:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeEQP2N (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 11:28:13 -0400
Received: from mail.efficios.com ([167.114.142.138]:40412 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEQP2L (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 11:28:11 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 208431C013B
Date: Thu, 17 May 2018 11:28:09 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <277374719.2144.1526570889798.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180517011949.GA1121@tardis>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <20180430224433.17407-8-mathieu.desnoyers@efficios.com> <20180516161837.GI12198@hirez.programming.kicks-ass.net> <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com> <20180517011949.GA1121@tardis>
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2026 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2031)
Thread-Topic: powerpc: Add support for restartable sequences
Thread-Index: t85YqVTIgXObWq1917sxjLzY1A4eQw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On May 16, 2018, at 9:19 PM, Boqun Feng boqun.feng@gmail.com wrote:

> On Wed, May 16, 2018 at 04:13:16PM -0400, Mathieu Desnoyers wrote:
>> ----- On May 16, 2018, at 12:18 PM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Mon, Apr 30, 2018 at 06:44:26PM -0400, Mathieu Desnoyers wrote:
>> >> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> >> index c32a181a7cbb..ed21a777e8c6 100644
>> >> --- a/arch/powerpc/Kconfig
>> >> +++ b/arch/powerpc/Kconfig
>> >> @@ -223,6 +223,7 @@ config PPC
>> >>  	select HAVE_SYSCALL_TRACEPOINTS
>> >>  	select HAVE_VIRT_CPU_ACCOUNTING
>> >>  	select HAVE_IRQ_TIME_ACCOUNTING
>> >> +	select HAVE_RSEQ
>> >>  	select IRQ_DOMAIN
>> >>  	select IRQ_FORCED_THREADING
>> >>  	select MODULES_USE_ELF_RELA
>> >> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
>> >> index 61db86ecd318..d3bb3aaaf5ac 100644
>> >> --- a/arch/powerpc/kernel/signal.c
>> >> +++ b/arch/powerpc/kernel/signal.c
>> >> @@ -133,6 +133,8 @@ static void do_signal(struct task_struct *tsk)
>> >>  	/* Re-enable the breakpoints for the signal stack */
>> >>  	thread_change_pc(tsk, tsk->thread.regs);
>> >>  
>> >> +	rseq_signal_deliver(tsk->thread.regs);
>> >> +
>> >>  	if (is32) {
>> >>          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
>> >>  			ret = handle_rt_signal32(&ksig, oldset, tsk);
>> >> @@ -164,6 +166,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long
>> >> thread_info_flags)
>> >>  	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
>> >>  		clear_thread_flag(TIF_NOTIFY_RESUME);
>> >>  		tracehook_notify_resume(regs);
>> >> +		rseq_handle_notify_resume(regs);
>> >>  	}
>> >>  
>> >>  	user_enter();
>> > 
>> > Again no rseq_syscall().
>> 
>> Same question for PowerPC as for ARM:
>> 
>> Considering that rseq_syscall is implemented as follows:
>> 
>> +void rseq_syscall(struct pt_regs *regs)
>> +{
>> +       unsigned long ip = instruction_pointer(regs);
>> +       struct task_struct *t = current;
>> +       struct rseq_cs rseq_cs;
>> +
>> +       if (!t->rseq)
>> +               return;
>> +       if (!access_ok(VERIFY_READ, t->rseq, sizeof(*t->rseq)) ||
>> +           rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
>> +               force_sig(SIGSEGV, t);
>> +}
>> 
>> and that x86 calls it from syscall_return_slowpath() (which AFAIU is
>> now used in the fast-path since KPTI), I wonder where we should call
> 
> So we actually detect this after the syscall takes effect, right? I
> wonder whether this could be problematic, because "disallowing syscall"
> in rseq areas may means the syscall won't take effect to some people, I
> guess?
> 
>> this on PowerPC ?  I was under the impression that PowerPC return to
>> userspace fast-path was not calling C code unless work flags were set,
>> but I might be wrong.
>> 
> 
> I think you're right. So we have to introduce callsite to rseq_syscall()
> in syscall path, something like:
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 51695608c68b..a25734a96640 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -222,6 +222,9 @@ system_call_exit:
> 	mtmsrd	r11,1
> #endif /* CONFIG_PPC_BOOK3E */
> 
> +	addi    r3,r1,STACK_FRAME_OVERHEAD
> +	bl	rseq_syscall
> +
> 	ld	r9,TI_FLAGS(r12)
> 	li	r11,-MAX_ERRNO
> 	andi.
> 		r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> 
> But I think it's important for us to first decide where (before or after
> the syscall) we do the detection.

As Peter said, we don't really care whether it's on syscall entry or exit, as
long as the process gets killed when the erroneous use is detected. I think doing
it on syscall exit is a bit easier because we can clearly access the userspace
TLS, which AFAIU may be less straightforward on syscall entry.

We may want to add #ifdef CONFIG_DEBUG_RSEQ / #endif around the code you
proposed above, so it's only compiled in if CONFIG_DEBUG_RSEQ=y.

On the ARM leg of the email thread, Will Deacon suggests to test whether current->rseq
is non-NULL before calling rseq_syscall(). I wonder if this added check is justified
as the assembly level, considering that this is just a debugging option. We already do
that check at the very beginning of rseq_syscall().

Thoughts ?

Thanks,

Mathieu

> 
> Regards,
> Boqun
> 
>> Thoughts ?
>> 
>> Thanks!
>> 
>> Mathieu
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
