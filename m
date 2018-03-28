Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2270871-1522240227-2-6713572764377231486
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522240226; b=mWZ1vY+YUMk62Zq8OO49kr2pwf0u2OVms4O2dMEg2CHuyuP
    MXOyXuIg/Sgx6g8Ni5RccEBTk8ToJvn0Vjr0uGumGNegto0nCOMJBsXSE4nL+141
    lqzsAbcF63ZbOEakN+ACdA5nhXQ77/z0grNciHEmzM3zYd/HXM+KkQkoCpp7XV7z
    LWlkx2lzuXFryVWtzVbYEq5IPkufyZQ6Uycwyn9viyQx7+qvSL933bNRYL1TPJxk
    F4PnmUgqle/EWTo0wQ6H2lhVPr0BWR548u0vgGUUSmcGcbfN5Jk1pUqmc3MVM43p
    wuQ7mzeNCm7Wn8yVnEdC9aACIj8ySy6Xbp02HcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522240226; bh=18o879ASw+cG8yJ3XrEuGEUNOu
    YNc58/Q3TqnrVn8f0=; b=lvO8LCi1MOf3OODqN0NxyGoYp8lyR+4ellI/zE3RST
    kR4EiKPQ0IEOejep8khgJTnFgjyIMf0XdxT7RZFuuyuZyo3vL26Yfwu4yiPeti4g
    CAquT+KSoZJ4UFI62AZc8L1qw8j5SHDbh35ot6pqwoqwuOb3pcCrkfHmRpalfPZl
    HnTFTT9ZYxuqroFf+tMSVhHvMyMSQCysp6spwWtQmRD5oS+NFepW3p7Cm2OVxAAR
    xpFXk+ynoaMC2smfFLZ/iAtX1jgyoHMh9GmyO+o8xOILX2gUZViwhtAPe+2ja4GY
    HcxAsGaBmbttL4A+oZmRFdmCREBkaHimkO9ZlYPTKl+A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=sVszCnEz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=sVszCnEz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCASWyny4TH2xaP57ELAu99Sn3H0Fzwp+rCej99d3vTfJkhfac9ugwGdhrZXb9o6OzMJUQc6BKqRqQ5RuXij2Yd95N6+aEEvPKokP0CLpZxsnDV2vv8A
    k4rG0LMumyto3jH8D1fA+UNS2+qfM6K60j8uUsOX16tqPdsvNwOqzReckdIK/cS/hS2kpozoeBca+4qQAxcx1oZhF6DHfdIqBKpr6vrENN/6nSbaMhvbMLrk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=WigLEbnOAlGHTBVXOKMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeC1MaN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 08:30:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeC1MaK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 08:30:10 -0400
Date: Wed, 28 Mar 2018 14:29:46 +0200
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
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable sequences
 system call (v12)
Message-ID: <20180328122946.GU4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
 <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:
> +static int rseq_update_cpu_id(struct task_struct *t)
> +{
> +	uint32_t cpu_id = raw_smp_processor_id();

u32

> +
> +	if (__put_user(cpu_id, &t->rseq->cpu_id_start))
> +		return -EFAULT;
> +	if (__put_user(cpu_id, &t->rseq->cpu_id))
> +		return -EFAULT;
> +	trace_rseq_update(t);
> +	return 0;
> +}
> +
> +static int rseq_reset_rseq_cpu_id(struct task_struct *t)
> +{
> +	uint32_t cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;

u32

> +
> +	/*
> +	 * Reset cpu_id_start to its initial state (0).
> +	 */
> +	if (__put_user(cpu_id_start, &t->rseq->cpu_id_start))
> +		return -EFAULT;
> +	/*
> +	 * Reset cpu_id to RSEQ_CPU_ID_UNINITIALIZED, so any user coming
> +	 * in after unregistration can figure out that rseq needs to be
> +	 * registered again.
> +	 */
> +	if (__put_user(cpu_id, &t->rseq->cpu_id))
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int rseq_get_rseq_cs(struct task_struct *t,
> +			    unsigned long *start_ip,
> +			    unsigned long *post_commit_offset,
> +			    unsigned long *abort_ip,
> +			    uint32_t *cs_flags)
> +{
> +	struct rseq_cs __user *urseq_cs;
> +	struct rseq_cs rseq_cs;
> +	unsigned long ptr;
> +	u32 __user *usig;
> +	u32 sig;
> +	int ret;
> +
> +	ret = __get_user(ptr, &t->rseq->rseq_cs);
> +	if (ret)
> +		return ret;
> +	if (!ptr)
> +		return 0;
> +	urseq_cs = (struct rseq_cs __user *)ptr;
> +	if (copy_from_user(&rseq_cs, urseq_cs, sizeof(rseq_cs)))
> +		return -EFAULT;
> +	if (rseq_cs.version > 0)
> +		return -EINVAL;
> +
> +	/* Ensure that abort_ip is not in the critical section. */
> +	if (rseq_cs.abort_ip - rseq_cs.start_ip < rseq_cs.post_commit_offset)
> +		return -EINVAL;

The kernel will not crash if userspace messes that up right? So why do
we care to check?

> +
> +	*cs_flags = rseq_cs.flags;
> +	*start_ip = rseq_cs.start_ip;
> +	*post_commit_offset = rseq_cs.post_commit_offset;
> +	*abort_ip = rseq_cs.abort_ip;

Then this becomes a straight struct assignment.

> +
> +	usig = (u32 __user *)(rseq_cs.abort_ip - sizeof(u32));
> +	ret = get_user(sig, usig);
> +	if (ret)
> +		return ret;
> +

> +	if (current->rseq_sig != sig) {
> +		printk_ratelimited(KERN_WARNING
> +			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
> +			sig, current->rseq_sig, current->pid, usig);
> +		return -EPERM;
> +	}

Is there any text that explains the thread model and possible attack
that this signature prevents? I failed to find any, which raises the
question, why is it there..

> +	return 0;
> +}
> +
> +static int rseq_need_restart(struct task_struct *t, uint32_t cs_flags)

u32

> +{
> +	uint32_t flags, event_mask;

u32

> +	int ret;
> +
> +	/* Get thread flags. */
> +	ret = __get_user(flags, &t->rseq->flags);
> +	if (ret)
> +		return ret;
> +
> +	/* Take critical section flags into account. */
> +	flags |= cs_flags;
> +
> +	/*
> +	 * Restart on signal can only be inhibited when restart on
> +	 * preempt and restart on migrate are inhibited too. Otherwise,
> +	 * a preempted signal handler could fail to restart the prior
> +	 * execution context on sigreturn.
> +	 */
> +	if (unlikely(flags & RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL)) {
> +		if ((flags & (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
> +		    | RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)) !=
> +		    (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
> +		     | RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT))
> +			return -EINVAL;

Please put operators at the end of the previous line, not at the start
of the new line when you have to break statements.

Also, that's unreadable.

#define RSEQ_CS_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT |	\
		       RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL  |	\
		       RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)

	if (unlikely((flags & RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL) &&
	             (flags & RSEQ_CS_FLAGS) != RSEQ_CS_FLAGS))
		return -EINVAL;


> +	}
> +
> +	/*
> +	 * Load and clear event mask atomically with respect to
> +	 * scheduler preemption.
> +	 */
> +	preempt_disable();
> +	event_mask = t->rseq_event_mask;
> +	t->rseq_event_mask = 0;
> +	preempt_enable();
> +
> +	event_mask &= ~flags;
> +	if (event_mask)
> +		return 1;
> +	return 0;

	return !!(event_mask & ~flags);

> +}
> +
> +static int clear_rseq_cs(struct task_struct *t)
> +{
> +	unsigned long ptr = 0;
> +
> +	/*
> +	 * The rseq_cs field is set to NULL on preemption or signal
> +	 * delivery on top of rseq assembly block, as well as on top
> +	 * of code outside of the rseq assembly block. This performs
> +	 * a lazy clear of the rseq_cs field.
> +	 *
> +	 * Set rseq_cs to NULL with single-copy atomicity.
> +	 */
> +	return __put_user(ptr, &t->rseq->rseq_cs);

	__put_user(0UL, &t->rseq->rseq_cs); ?

> +}
> +
> +static int rseq_ip_fixup(struct pt_regs *regs)
> +{
> +	unsigned long ip = instruction_pointer(regs), start_ip = 0,
> +		post_commit_offset = 0, abort_ip = 0;

valid C, but yuck. Just have two 'unsigned long' lines.

Also, why the =0, the below call to rseq_get_rseq_cs() will either
initialize of fail.

> +	struct task_struct *t = current;
> +	uint32_t cs_flags = 0;

u32

> +	bool in_rseq_cs = false;
> +	int ret;
> +
> +	ret = rseq_get_rseq_cs(t, &start_ip, &post_commit_offset, &abort_ip,
> +			&cs_flags);

	ret = rseq_get_rseq_cs(t, &start_ip, &post_commit_offset,
			       &abort_ip, &cs_flags);


> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Handle potentially not being within a critical section.
> +	 * Unsigned comparison will be true when
> +	 * ip >= start_ip, and when ip < start_ip + post_commit_offset.
> +	 */
> +	if (ip - start_ip < post_commit_offset)
> +		in_rseq_cs = true;
> +
> +	/*
> +	 * If not nested over a rseq critical section, restart is
> +	 * useless. Clear the rseq_cs pointer and return.
> +	 */
> +	if (!in_rseq_cs)
> +		return clear_rseq_cs(t);


That all seems needlessly complicated; isn't:

	if (ip - start_ip >= post_commit_offset)
		return clear_rseq_cs();

equivalent? Nothing seems to use that variable after this.

> +	ret = rseq_need_restart(t, cs_flags);
> +	if (ret <= 0)
> +		return ret;
> +	ret = clear_rseq_cs(t);
> +	if (ret)
> +		return ret;
> +	trace_rseq_ip_fixup(ip, start_ip, post_commit_offset, abort_ip);
> +	instruction_pointer_set(regs, (unsigned long)abort_ip);
> +	return 0;
> +}
