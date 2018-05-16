Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-519016-1526487568-2-16919547144872936053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526487567; b=C8kAjB8v2Dj4X7bjA6YVCdjJYkJ6OC0EElk2OZV9bH5nD9BBwA
    mpixb2BNfm88IXHbRuIAZRxWcUq4WgWy1liiaRLd39O9lxV3pzBdH/YRWkix8sqK
    nhtJXpHOCidkX4feAUAkuYCXQz3TghWRUQ9oty0AeHq2aPiIxc7ilNDpBBOq6vdl
    Xc/HaLSX6MjVYq+DlsFilALMsGKnRiqNTRVU6i9qdf/XyP0g40TpYxXhAoqiBzPf
    Cc4dXebEJpN72JhtPTPIgkdtMeVKeXf7lLshR/97lcD/BBFTjlov8V8krjM5UOkY
    gfu7r3XDJO1M70UvmA53Dk3eUSvZ4YLqX8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526487567; bh=baVHRR4yak+nlOqMeE9hpmuourzovj
    A/G9yPbLc1C+k=; b=lq6nls2s6pNu/6a0W4X2LxofK5UcNFdwgdz/HlA4g/aCkT
    5ABwnTDqfmOuEIjkSf31VyllaNiEXB3wA3JHnt0kQwgLRJaucyVYQGoplAbYzS1m
    YArmt5FAVmLJIpiCxdKjzpZI2WFuXVUGVevh8yrpgGx6+ue2NsN7AFznj98pCDqS
    5HpO+DYHmYeLD9gJOpP6ZDuCpP8iaxcPUocOCYa1aehsVdeI4jSEvBTjhV11tjuk
    9Xr9UO1EWONYI5yBVQA4GOA4zhEIX7fhWxx09p7pzmPeu9tDREKEnXwqoCL69Szv
    Vyd20s+1lqWAZ1r13a7O++ulQtiScN40PB+cELhQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=D1y6hv5G
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=D1y6hv5G
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGtZoDaOB49v0s5HO5k7hbqKzEfslTKkinQprmQdZQtZwDed5g8X4OGf2qSTGDo486rZqVckfWebxWKrCWsrV98ahsgI7Paw4l2QRn8leysfeZ6MGleR
    YZW6gGwj3abOGu7MLyJ/3XrD8Q2rGZMOqAL5ck9t/s+8mAoWzw0lekkopJC2NyfuUHp2ul8O+bbx4EhBfbK/yiEhVt8q0YAGypLsV+VBQSoeAbw/iy/h43k+
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=958JWHIs8ISknejfI1QA:9 a=5sk7zAAB35yt_1Ag:21
    a=hRJ4WQwVKvHoyQEj:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeEPQTZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 12:19:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45362 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeEPQTY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 May 2018 12:19:24 -0400
Date: Wed, 16 May 2018 18:18:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
Message-ID: <20180516161837.GI12198@hirez.programming.kicks-ass.net>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <20180430224433.17407-8-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430224433.17407-8-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 06:44:26PM -0400, Mathieu Desnoyers wrote:
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c32a181a7cbb..ed21a777e8c6 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -223,6 +223,7 @@ config PPC
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_VIRT_CPU_ACCOUNTING
>  	select HAVE_IRQ_TIME_ACCOUNTING
> +	select HAVE_RSEQ
>  	select IRQ_DOMAIN
>  	select IRQ_FORCED_THREADING
>  	select MODULES_USE_ELF_RELA
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index 61db86ecd318..d3bb3aaaf5ac 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -133,6 +133,8 @@ static void do_signal(struct task_struct *tsk)
>  	/* Re-enable the breakpoints for the signal stack */
>  	thread_change_pc(tsk, tsk->thread.regs);
>  
> +	rseq_signal_deliver(tsk->thread.regs);
> +
>  	if (is32) {
>          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
>  			ret = handle_rt_signal32(&ksig, oldset, tsk);
> @@ -164,6 +166,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
>  	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
>  		clear_thread_flag(TIF_NOTIFY_RESUME);
>  		tracehook_notify_resume(regs);
> +		rseq_handle_notify_resume(regs);
>  	}
>  
>  	user_enter();

Again no rseq_syscall().
