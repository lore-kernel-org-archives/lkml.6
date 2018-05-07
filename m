Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1403089-1525717285-2-1036483317044643158
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525717285; b=JF9Ln8N2+gVBA7c7dGWQW61Ieqbr32LC68vPdO0C1YnndS/YW3
    13222GP0HfbSIe6DIOGuVrXNOdDMdDcIV1rj1g8qaC6jyDUNUWW88E54JawwGn7g
    QLpucGpFim+RdK30HgBOtXEnbDOMnZr9WJer8B6Vtd3fIrtNcFCY04zWcQC9p8kG
    JbReAZRJS5Z6CE7fKtg4mlRm2zJmDcCXew3zrrUEDxLcA3eNBe/yKyRkiRbTnl41
    NN7Rucjc6ye9Jl7nO9PDre32Q822+6ZYmJYknuOYz2C3iPl2onhA/cTgIwxSp5J+
    rTz86OKmg6fBsl9VfV1z3uGaMV61/cfGE49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525717285;
    bh=do8KFtu84t1QYhnw/5lvTUgxrUsbE3fvB7Pk+k+hkHk=; b=Bi7ztxRz/8FR
    x7ho86vufUtr7Sj1jW7GQh3xHqKlFIuHCOWOIKtuos1I14UTWL62M+qc6sNyxx5T
    JZaMkH5MBJL/9/l8NRdtNO3oPrf/1bjzW4SWV65kecQ60uElsvR33EEmw52c/vbc
    IlIqdrdgRXO+K2PsRUM5NzgUQZ5pphY4yihP+ZGY4nbfpTGg6M+TO9sJTwIG7kXP
    pZLAJ9szeO3Lq9VFO0KicbToNrFthziFJHI70AIzFSXqerriWiSogmuq3pCoRIz/
    hNPQ8kaEDZ/DCHxS9EiI4lVaShPOVvD0bYzeU3ZLbb+QjowUTGA433vUaCJ5Qnpr
    YXssMIzJgQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDVVC3/V0aSUrtIofF7+tD+k2gmDgECnczXaWEuLwy6z8qfGxXhqwUIT3hObGYcx1O2O64IqlSWmg1HIpbuNpacCSVxknG5EmwALJsufh3vQxiJGN2JR
    2EDdHj/cwTg/uOezECBDfYAZGq4nJZ0S19b/R/FH6BaGcO8v2ct2/cb3vIJNPcvLszKT0SNw7BcKvPCg0IT2CajkuU0L3Ew0dk6hbsXvI2beHVjxTYAbVoHy
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=meVymXHHAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8
    a=7d_E57ReAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=VnNF1IyMAAAA:8 a=n8i27M1mAAAA:8 a=ZxOT1uL7pEJHGetpaTQA:9 a=CjuIK1q_8ugA:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeEGSVW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 14:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752352AbeEGSVV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 7 May 2018 14:21:21 -0400
Date: Mon, 7 May 2018 14:21:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zilstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] softirq: reorder trace_softirqs_on to prevent lockdep
 splat
Message-ID: <20180507142117.35310ff2@gandalf.local.home>
In-Reply-To: <20180502014439.87828-1-joelaf@google.com>
References: <20180502014439.87828-1-joelaf@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Peter, Ingo or Thomas,

Can you queue this up? Or would you prefer that I take it?

-- Steve


On Tue,  1 May 2018 18:44:39 -0700
Joel Fernandes <joelaf@google.com> wrote:

> I'm able to reproduce a lockdep splat with config options:
> CONFIG_PROVE_LOCKING=y,
> CONFIG_DEBUG_LOCK_ALLOC=y and
> CONFIG_PREEMPTIRQ_EVENTS=y
> 
> $ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable
> ---
> [   26.112609] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
> [   26.112636] WARNING: CPU: 0 PID: 118 at kernel/locking/lockdep.c:3854
> [...]
> [   26.144229] Call Trace:
> [   26.144926]  <IRQ>
> [   26.145506]  lock_acquire+0x55/0x1b0
> [   26.146499]  ? __do_softirq+0x46f/0x4d9
> [   26.147571]  ? __do_softirq+0x46f/0x4d9
> [   26.148646]  trace_preempt_on+0x8f/0x240
> [   26.149744]  ? trace_preempt_on+0x4d/0x240
> [   26.150862]  ? __do_softirq+0x46f/0x4d9
> [   26.151930]  preempt_count_sub+0x18a/0x1a0
> [   26.152985]  __do_softirq+0x46f/0x4d9
> [   26.153937]  irq_exit+0x68/0xe0
> [   26.154755]  smp_apic_timer_interrupt+0x271/0x280
> [   26.156056]  apic_timer_interrupt+0xf/0x20
> [   26.157105]  </IRQ>
> 
> The issue was this:
> 
> preempt_count = 1 << SOFTIRQ_SHIFT
> 
> 	__local_bh_enable(cnt = 1 << SOFTIRQ_SHIFT) {
> 		if (softirq_count() == (cnt && SOFTIRQ_MASK)) {
> 			trace_softirqs_on() {
> 				current->softirqs_enabled = 1;
> 			}
> 		}
> 		preempt_count_sub(cnt) {
> 			trace_preempt_on() {
> 				tracepoint() {
> 					rcu_read_lock_sched() {
> 						// jumps into lockdep
> 
> Where preempt_count still has softirqs disabled, but
> current->softirqs_enabled is true, and we get a splat.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zilstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Glexiner <tglx@linutronix.de>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Fenguang Wu <fengguang.wu@intel.com>
> Cc: Baohong Liu <baohong.liu@intel.com>
> Cc: Vedang Patel <vedang.patel@intel.com>
> Cc: kernel-team@android.com
> Cc: stable@vger.kernel.org
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Fixes: d59158162e032 ("tracing: Add support for preempt and irq enable/disable events")
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
>  kernel/softirq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 24d243ef8e71..47e2f61938c0 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -139,9 +139,13 @@ static void __local_bh_enable(unsigned int cnt)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> +	if (preempt_count() == cnt)
> +		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> +
>  	if (softirq_count() == (cnt & SOFTIRQ_MASK))
>  		trace_softirqs_on(_RET_IP_);
> -	preempt_count_sub(cnt);
> +
> +	__preempt_count_sub(cnt);
>  }
>  
>  /*
