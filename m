Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-519016-1526487546-2-17489955931311307135
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
    1526487545; b=HEUSyqqjhNeC8ISjGcQ6BtToUSARlmACyL1wRujkPMrgQFdH9M
    J8YKljjGf2WU05NRntHqfFez6hait3K9xcgP+5a70TmoWTur7j21+V/+SxTzvciL
    yD592m2CebS81PXjnKSzJ9UWUr3LWkGAPe3bfAAJHfs60DMkAwEFmIZslxgWkSaK
    h3dSpjvMAhSIhTU7+S3gLFwxy5ERygNB/34rvpDwsgLU0hSXxywDE4i+iRnq76vA
    9ngywwfqfnIaKomvd/5ahKrgNlNY3GtKvaPwap9ZwrtzoVUYSTnE7OihspCXuvuB
    +HTpYy8JoBfAPHF9kjbSACuoKzNBcwsbS7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526487545; bh=lXYxdjffBEJIu1yCVzEcL39KKmMtJ8
    ztUhT+jY1HtRE=; b=RI2M9hqZsbjE73ugzndFS0J4S3LqR2g/Rw1G0md4NYo3H8
    fqq6QkRUFxsa4Yd4MD6JEuJGOk+epnnWYmW3WHfdcz5avF0G6QLJ3AIl/Lnwenkq
    Rb87YqNskipiUGvxxzXXpa2YRsBPYv9bdCnJJzw6x/cB/y/Bmd5zcs4RAxzpGOON
    8oMkYB9c4mIp9vgB+68gbAhzly9QSm6JPIZ5nOe/0PhDa1XKVx9swkM8xKTEQty2
    mGux/04SqtY+ilhglU9w14UH5oZzEniaS6ROKt01K/ED1At1UaHgftUNFEIwZLo3
    z+P8QxQqj1d3rjAo1i0yeQrunmYWmBAYZ01C1ceA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=WAdU0AIl
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=WAdU0AIl
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
X-CM-Envelope: MS4wfDpsaq1x9d6zlkpQSXV3+I3QzTDskJosftWheD+yXLHzCZM9HGt/spKpXTC70hnwxb5M5esnC6jDXujyC+moxpufXWvvC+3wmT5Bj+EeUMwFHvBlq6Ap
    DP9Ev/K2zd8nuiUHkOpX8ziqOqmZ3JI4ScY1lwc5wcRMaGWfeQQuLYUaImKy6rV+Y92F03q/zuYLPhVpSIjvkaxwTi90PV3lGV8JmGFsYDbm5YioXZIT0O9T
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=cxjoupLj5ldNc4JC9GwA:9 a=wMREKr5Ag4NTZ9fr:21
    a=M7J2kNc2XXMDveB-:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeEPQTD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 12:19:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbeEPQTC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 May 2018 12:19:02 -0400
Date: Wed, 16 May 2018 18:18:09 +0200
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
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 03/14] arm: Add restartable sequences support
Message-ID: <20180516161809.GH12198@hirez.programming.kicks-ass.net>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <20180430224433.17407-4-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430224433.17407-4-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 06:44:22PM -0400, Mathieu Desnoyers wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a7f8e7f4b88f..4f5c386631d4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -91,6 +91,7 @@ config ARM
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_RCU_TABLE_FREE if (SMP && ARM_LPAE)
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> +	select HAVE_RSEQ
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_UID16
>  	select HAVE_VIRT_CPU_ACCOUNTING_GEN
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index bd8810d4acb3..5879ab3f53c1 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -541,6 +541,12 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>  	int ret;
>  
>  	/*
> +	 * Increment event counter and perform fixup for the pre-signal
> +	 * frame.
> +	 */
> +	rseq_signal_deliver(regs);
> +
> +	/*
>  	 * Set up the stack frame
>  	 */
>  	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
> @@ -660,6 +666,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
>  			} else {
>  				clear_thread_flag(TIF_NOTIFY_RESUME);
>  				tracehook_notify_resume(regs);
> +				rseq_handle_notify_resume(regs);
>  			}
>  		}
>  		local_irq_disable();

I think you forgot to hook up rseq_syscall() checking.
