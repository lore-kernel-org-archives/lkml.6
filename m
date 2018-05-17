Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2893474-1526601051-2-1387660616496503889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526601050; b=nYnsTitqe6tgXHk2QfqvKKYHPq/zfFt2rjat2OnlUE6TAAOZSJ
    F7W3oExT9BjDCkotQtBmF8/NYW1imMvNTHpdDQPaCZu0yYmzKUS8XyZj6EQ8pOf1
    ovOfVBXQYTWzOolso7A/jZo04AVepcwqmtHpwfT38528srPSz+3g3pBDhHS3cw3Z
    IEUJugUsTey+npl4j5oqS3ejtSFVo8iG5E41x8orNKSJSKHAYkpi7ioEV/4IZd2p
    0/x0HLSho7lOm3RqoU8TUh5tYU5D9MqRq1Cayz4tdlUvzip/pIambiFqumUHvhdY
    +T17c1hTEDImRwoHFUgHUyD2nf/uGuSmPrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:to:cc:mime-version
    :content-transfer-encoding:content-type:subject:date:in-reply-to
    :references:sender:list-id; s=fm2; t=1526601050; bh=K+OwHLGE5cVG
    XBgh6O2iutrro7FvjGMBQvqj47FPy2M=; b=EnQQYd2IzGD182ke2pbROVsnfsnA
    2bRErH4kDNgvcX+KjFAWmtelzHem31ANsd2dwarDuDgKUIjvcX567GYgPbw0uaSm
    HhfsuCcwgJU1End/ARTrJjzQmq1Etsmcmub7SL3ZGb/qd63+O+I7f3H2zbWMqxFm
    TGPQ3aKAYK1VLQtm8nZ75Ty/5lIrOOGglOgOev64r3QVUVKH8U/9TByGME7mibhK
    74OSERQndO3AdlZIEfTiKlXIvqoGOAeYj9gNBPkjodj1E6VA28tj+twwEQR2BYSY
    bNBrHlfxYe5A8K5KTRalBQXOpdOvUnaNp2YFG7wk02V1NtMCdCoOD2jTVQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=T17rRO33 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=SDcWJ/WU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=T17rRO33 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=SDcWJ/WU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNzjUlho+97N8P4KESM2wZtEaPHZLS7eRPO8G3blwaPFdCASqYeyC9MYnniz/PlVoL0Imqo8ksOaj21bNCJrK6fcLRMQFrVrNTn9kTcwJr4DgZpFnXZQ
    xi/5zrgteIZAjAUddpFJzLItESC1/dBUR++a8D+NfGZJ8bop1kv1Dg2xfND6OhoXLnyVePl6vVwyiL3gaWUzr110HI5oIP2tIOrTEM+S87QhacUJM0okOauF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=RT4zlxQfEhcA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=55RZ_tf2JzlzXXbrvVUA:9
    a=2ee_S2H0cYKtZkaS:21 a=RAzqY76wsDgwnFcQ:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEQXus (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 19:50:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42316 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbeEQXuq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 19:50:46 -0400
X-Google-Smtp-Source: AB8JxZqDMoRA2U+eMeK1QkEKUcg4RK4fdQOvL2HUbulGv1dIa5TliWwMQGYJduNK4XJzMRUDLzBSYQ==
X-ME-Sender: <xms:UxX-WvgvsmvuYb2uyhNcrmJWlQL7Obg1dlpcI2fGESFrH0uGNfE-dw>
Message-Id: <1526601043.1338308.1376191416.0444B8C5@webmail.messagingengine.com>
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-api" <linux-api@vger.kernel.org>,
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
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-29fe4c42
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
Date: Fri, 18 May 2018 07:50:43 +0800
In-Reply-To: <277374719.2144.1526570889798.JavaMail.zimbra@efficios.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <20180430224433.17407-8-mathieu.desnoyers@efficios.com>
 <20180516161837.GI12198@hirez.programming.kicks-ass.net>
 <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com>
 <20180517011949.GA1121@tardis>
 <277374719.2144.1526570889798.JavaMail.zimbra@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Thu, May 17, 2018, at 11:28 PM, Mathieu Desnoyers wrote:
> ----- On May 16, 2018, at 9:19 PM, Boqun Feng boqun.feng@gmail.com wrote:
> 
> > On Wed, May 16, 2018 at 04:13:16PM -0400, Mathieu Desnoyers wrote:
> >> ----- On May 16, 2018, at 12:18 PM, Peter Zijlstra peterz@infradead.org wrote:
> >> 
> >> > On Mon, Apr 30, 2018 at 06:44:26PM -0400, Mathieu Desnoyers wrote:
> >> >> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> >> >> index c32a181a7cbb..ed21a777e8c6 100644
> >> >> --- a/arch/powerpc/Kconfig
> >> >> +++ b/arch/powerpc/Kconfig
> >> >> @@ -223,6 +223,7 @@ config PPC
> >> >>  	select HAVE_SYSCALL_TRACEPOINTS
> >> >>  	select HAVE_VIRT_CPU_ACCOUNTING
> >> >>  	select HAVE_IRQ_TIME_ACCOUNTING
> >> >> +	select HAVE_RSEQ
> >> >>  	select IRQ_DOMAIN
> >> >>  	select IRQ_FORCED_THREADING
> >> >>  	select MODULES_USE_ELF_RELA
> >> >> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> >> >> index 61db86ecd318..d3bb3aaaf5ac 100644
> >> >> --- a/arch/powerpc/kernel/signal.c
> >> >> +++ b/arch/powerpc/kernel/signal.c
> >> >> @@ -133,6 +133,8 @@ static void do_signal(struct task_struct *tsk)
> >> >>  	/* Re-enable the breakpoints for the signal stack */
> >> >>  	thread_change_pc(tsk, tsk->thread.regs);
> >> >>  
> >> >> +	rseq_signal_deliver(tsk->thread.regs);
> >> >> +
> >> >>  	if (is32) {
> >> >>          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
> >> >>  			ret = handle_rt_signal32(&ksig, oldset, tsk);
> >> >> @@ -164,6 +166,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long
> >> >> thread_info_flags)
> >> >>  	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
> >> >>  		clear_thread_flag(TIF_NOTIFY_RESUME);
> >> >>  		tracehook_notify_resume(regs);
> >> >> +		rseq_handle_notify_resume(regs);
> >> >>  	}
> >> >>  
> >> >>  	user_enter();
> >> > 
> >> > Again no rseq_syscall().
> >> 
> >> Same question for PowerPC as for ARM:
> >> 
> >> Considering that rseq_syscall is implemented as follows:
> >> 
> >> +void rseq_syscall(struct pt_regs *regs)
> >> +{
> >> +       unsigned long ip = instruction_pointer(regs);
> >> +       struct task_struct *t = current;
> >> +       struct rseq_cs rseq_cs;
> >> +
> >> +       if (!t->rseq)
> >> +               return;
> >> +       if (!access_ok(VERIFY_READ, t->rseq, sizeof(*t->rseq)) ||
> >> +           rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
> >> +               force_sig(SIGSEGV, t);
> >> +}
> >> 
> >> and that x86 calls it from syscall_return_slowpath() (which AFAIU is
> >> now used in the fast-path since KPTI), I wonder where we should call
> > 
> > So we actually detect this after the syscall takes effect, right? I
> > wonder whether this could be problematic, because "disallowing syscall"
> > in rseq areas may means the syscall won't take effect to some people, I
> > guess?
> > 
> >> this on PowerPC ?  I was under the impression that PowerPC return to
> >> userspace fast-path was not calling C code unless work flags were set,
> >> but I might be wrong.
> >> 
> > 
> > I think you're right. So we have to introduce callsite to rseq_syscall()
> > in syscall path, something like:
> > 
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 51695608c68b..a25734a96640 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -222,6 +222,9 @@ system_call_exit:
> > 	mtmsrd	r11,1
> > #endif /* CONFIG_PPC_BOOK3E */
> > 
> > +	addi    r3,r1,STACK_FRAME_OVERHEAD
> > +	bl	rseq_syscall
> > +
> > 	ld	r9,TI_FLAGS(r12)
> > 	li	r11,-MAX_ERRNO
> > 	andi.
> > 		r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> > 
> > But I think it's important for us to first decide where (before or after
> > the syscall) we do the detection.
> 
> As Peter said, we don't really care whether it's on syscall entry or 
> exit, as
> long as the process gets killed when the erroneous use is detected. I 
> think doing
> it on syscall exit is a bit easier because we can clearly access the 
> userspace
> TLS, which AFAIU may be less straightforward on syscall entry.
>

Fair enough.
 
> We may want to add #ifdef CONFIG_DEBUG_RSEQ / #endif around the code you
> proposed above, so it's only compiled in if CONFIG_DEBUG_RSEQ=y.
> 

OK.

> On the ARM leg of the email thread, Will Deacon suggests to test whether 
> current->rseq
> is non-NULL before calling rseq_syscall(). I wonder if this added check 
> is justified
> as the assembly level, considering that this is just a debugging option. 
> We already do
> that check at the very beginning of rseq_syscall().
> 

Yes, I think it's better to do the check in rseq_syscall(), leaving the asm
code a bit cleaner.

Regards,
Boqun

> Thoughts ?
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Regards,
> > Boqun
> > 
> >> Thoughts ?
> >> 
> >> Thanks!
> >> 
> >> Mathieu
> >> 
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> > > http://www.efficios.com
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
