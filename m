Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2133250-1526563949-2-14892948809918339375
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526563948; b=kjEeBPh7Xu6HPtLqHEa0aL1c0/l+JpyvktqXI0a1FIDARwTIw8
    x9760BKZrehTPtuul8jKX04JVIwylhZLDV0dKXE5LTHSqGbPEDusYtGKrbXKInnq
    D4JaDcOXGB6prHRdjA/1/ryEYInttMPQVRkfJ9koo/7xZJAQM1k4HUKSW0bUYrtq
    oiP0rl7JUJG9GV0QxRnsmizP3q3e+q3qR0Y6Z50R+txCztx97DTMEIJ6QYBLjNQI
    DlzdTiMFy+7G+Hped9/UdeogOIGZt/nMRDANAnAQ+kIxe2+dZ97KF0fuQV+pmQjG
    f+1DQymwvCTh0tpxBNDWO5PxWl7KW/rFmUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526563948; bh=NYtSSCZWLB8gCWdoD5ijq4nVIxP9h8
    IqaBKYtTQW5yI=; b=MKIwLaaweIprofZU5+j8AklfDJULNFCUV9LeSQb3vqX07j
    8SadsBDqM5FufH9Olj6xk7lmh0OVQrX2ZxIYrv4sDmGN9wra343k6gYEcl3fpQcw
    j777YXeUF1K73othDiyxrFDL5f/KKMVCA5Lp+6HtZprrB5Vz9jaz0oGvInWcohqf
    K1JwIcR7+6/H9vu1aNeQS1Bto4/AFTFYTPZxoS+frkmh9+e+a8n1BDvxkeLwsucQ
    erSwQHWcRBPsle4fcweLaJ7dk9dc/5o1MZ3mIt19vENJYuB/4ffdJxEfOz2LCrWo
    dxa0citQF3Sbg88UBBEArVF0aCkTy7hdQee/H0FQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM1bARbUBMaTD+Qky0fGCQJsOdp1pafF5ZQfBnQHV0vkO9Y7sSf0Li9gZ2nHG1R2HuwhhYsT8bNPKCg8lHl0rW9UYKnKkK3K7EvS3ZYGlLe0bLf7ZyhI
    w+mFgcT8PTcmdYuYRjjk7M+vs1m5rsJwMO3LgZfKmyEKbP0JkqoIhPvuT+LvjS4Fhm5a5u8O5QAVXQWduj1gq2Ioiy0hHc4TEgYy3R59KirmCw34Y7jL9/Od
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=c0JOFI1fKpCsw2nqqyoA:9
    a=zyUIX6J7nA3Zrzfv:21 a=H7SVKM9mUpo12JlE:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeEQNcN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 09:32:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35848 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752073AbeEQNcF (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 17 May 2018 09:32:05 -0400
Date: Thu, 17 May 2018 14:32:31 +0100
From: Will Deacon <will.deacon@arm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 03/14] arm: Add restartable sequences support
Message-ID: <20180517133230.GA2688@arm.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <20180430224433.17407-4-mathieu.desnoyers@efficios.com>
 <20180516161809.GH12198@hirez.programming.kicks-ass.net>
 <670368504.1912.1526501593893.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670368504.1912.1526501593893.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 04:13:13PM -0400, Mathieu Desnoyers wrote:
> ----- On May 16, 2018, at 12:18 PM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Mon, Apr 30, 2018 at 06:44:22PM -0400, Mathieu Desnoyers wrote:
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index a7f8e7f4b88f..4f5c386631d4 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -91,6 +91,7 @@ config ARM
> >>  	select HAVE_PERF_USER_STACK_DUMP
> >>  	select HAVE_RCU_TABLE_FREE if (SMP && ARM_LPAE)
> >>  	select HAVE_REGS_AND_STACK_ACCESS_API
> >> +	select HAVE_RSEQ
> >>  	select HAVE_SYSCALL_TRACEPOINTS
> >>  	select HAVE_UID16
> >>  	select HAVE_VIRT_CPU_ACCOUNTING_GEN
> >> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> >> index bd8810d4acb3..5879ab3f53c1 100644
> >> --- a/arch/arm/kernel/signal.c
> >> +++ b/arch/arm/kernel/signal.c
> >> @@ -541,6 +541,12 @@ static void handle_signal(struct ksignal *ksig, struct
> >> pt_regs *regs)
> >>  	int ret;
> >>  
> >>  	/*
> >> +	 * Increment event counter and perform fixup for the pre-signal
> >> +	 * frame.
> >> +	 */
> >> +	rseq_signal_deliver(regs);
> >> +
> >> +	/*
> >>  	 * Set up the stack frame
> >>  	 */
> >>  	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
> >> @@ -660,6 +666,7 @@ do_work_pending(struct pt_regs *regs, unsigned int
> >> thread_flags, int syscall)
> >>  			} else {
> >>  				clear_thread_flag(TIF_NOTIFY_RESUME);
> >>  				tracehook_notify_resume(regs);
> >> +				rseq_handle_notify_resume(regs);
> >>  			}
> >>  		}
> >>  		local_irq_disable();
> > 
> > I think you forgot to hook up rseq_syscall() checking.
> 
> Considering that rseq_syscall is implemented as follows:
> 
> +void rseq_syscall(struct pt_regs *regs)
> +{
> +       unsigned long ip = instruction_pointer(regs);
> +       struct task_struct *t = current;
> +       struct rseq_cs rseq_cs;
> +
> +       if (!t->rseq)
> +               return;
> +       if (!access_ok(VERIFY_READ, t->rseq, sizeof(*t->rseq)) ||
> +           rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
> +               force_sig(SIGSEGV, t);
> +}
> 
> and that x86 calls it from syscall_return_slowpath() (which AFAIU is
> now used in the fast-path since KPTI), I wonder where we should call
> this on ARM ? I was under the impression that ARM return to userspace
> fast-path was not calling C code unless work flags were set, but I might
> be wrong.
> 
> Thoughts ?

Since this only matters for CONFIG_DEBUG_RSEQ, can we just force the
slowpath for rseq tasks when that option is set?

Will
