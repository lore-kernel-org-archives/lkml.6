Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2729766-1522253981-2-5238815028070121378
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522253980; b=WVtPUkh7zkk6RRCO82EbfaDKQLX0VdieQSn3BnADHxO5cmV
    USKHOe7j/DKQX3rbX75kzoLfYlojcWkdwAOpxkvcfau22OCW9A56Fo5uznledTyh
    74lUJ6Yf9ytqA2+tiMHz98TkYgLCaqC6HsuABDKtGWx5ElAyNLTGW1zYEsjYZtKq
    I4meYdHOieWfWjmQY5EgvViZAGj+he/DG//GMbKc3qgW3nzcvNm1E90DOb7YIFVn
    mE7dYC+7wQLHqb/43mq75IXeMz4FLzEGflkeSZZfyWNycYi4XOb1exDY80qbtlnU
    C1VrH14oajbuXt2Cl6ZoQQi4icCdQ1NS4uxgfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522253980; bh=TyNnPEqFW8kaEQLkjsEobVtZugqSOlWiWliqCDPp5gg=; b=F
    mu5qGS3yT3zGgG6yIcQg/r1q4k43Vq/UgMAdImf2HWiBSIpWus/IQCGcIgVAWMaq
    UJ9cLnJcURYFT7xQKNXOyPqd2V6IjJ18Gqi5JE99khno1857znjv6HnvppDB+34c
    nN7+4MPF+3OnrZ51Wuipqst9ohxgdjazwid6vHT1LcjjDCTA8sxm0BWp4rIB/sPx
    Q3lw8c8QiiRHaKVuHcFvRliEvBpaCUgKVwZlHZqZyaV0fhRlOm4q+m7E4Bp+nW3A
    QrjkwJf1d+sA/+JkOMoi8FXwDLpQ4QdLmXBKu8OcGu5D2ORLzvb9ssFG5AgycbSK
    L9aujZtQjAg9rPvCS3/kw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfDdFWqJy4JJ+7tXFAkw9XnpqIYMRgtLY9Y6hWTiNiFDylv7cb7rchswKa5ZMp7Z8h/UqGCFE2VjEADyb/QPg+hhly5frb4Pb39xyyHUvA+AaaQ191typ
    yPnV6C0qo1XpDPYP3nFJ7bXf9P7nAui9BZrBCwOE2lK4HW/Tob2dcqYu3wl6g7/XsIoIPMqkcguL1iFpiY8mPjLz4awoMmkEKeCsvNQvYIfQRwrzvJNMobSJ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=1fq_PQY2wJywEZ5liHoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeC1QTK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 12:19:10 -0400
Received: from mail.efficios.com ([167.114.142.138]:58842 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752342AbeC1QTH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 12:19:07 -0400
Date: Wed, 28 Mar 2018 12:19:05 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
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
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <1976612894.96.1522253945890.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180328122946.GU4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180328122946.GU4043@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: 9zlLrM4xfM3Pu3382iXfa8D2nFImKQ==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 8:29 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:

[...]

>> +	/* Ensure that abort_ip is not in the critical section. */
>> +	if (rseq_cs.abort_ip - rseq_cs.start_ip < rseq_cs.post_commit_offset)
>> +		return -EINVAL;
> 
> The kernel will not crash if userspace messes that up right? So why do
> we care to check?

That's because the kernel clears the TLS @rseq_cs pointer whenever it restarts
a rseq critical section. Therefore, if the abort_ip points somewhere within
the rseq critical section, the kernel will clear the @rseq_cs pointer, move the
instruction pointer to the abort_ip, and return to user-space. At that stage,
user-space will still be running within a rseq critical section, but the
@rseq_cs pointer is NULL. So if the kernel preempts again before that critical
section completes, it will completely miss it.

So having the kernel segfault userspace when this pattern is encountered
is an extra safety net ensuring that if user-space ever implement such
construct, at least it will segfault quickly, and will therefore be easier
to debug, because easier to reproduce.

>> +
>> +	usig = (u32 __user *)(rseq_cs.abort_ip - sizeof(u32));
>> +	ret = get_user(sig, usig);
>> +	if (ret)
>> +		return ret;
>> +
> 
>> +	if (current->rseq_sig != sig) {
>> +		printk_ratelimited(KERN_WARNING
>> +			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x
>> (pid=%d, addr=%p).\n",
>> +			sig, current->rseq_sig, current->pid, usig);
>> +		return -EPERM;
>> +	}
> 
> Is there any text that explains the thread model and possible attack
> that this signature prevents? I failed to find any, which raises the
> question, why is it there..

The threat model is an attacker partly controlling a user-space process, trying
to execute his own code by abusing the rseq restart mechanism to make the kernel
jump to a user-space address of his choice, which contains either an injected shell
code or specific library functions, thus escalating to full control of the process
execution.

Where should I document this ?

> 
>> +	int ret;
>> +
>> +	/* Get thread flags. */
>> +	ret = __get_user(flags, &t->rseq->flags);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Take critical section flags into account. */
>> +	flags |= cs_flags;
>> +
>> +	/*
>> +	 * Restart on signal can only be inhibited when restart on
>> +	 * preempt and restart on migrate are inhibited too. Otherwise,
>> +	 * a preempted signal handler could fail to restart the prior
>> +	 * execution context on sigreturn.
>> +	 */
>> +	if (unlikely(flags & RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL)) {
>> +		if ((flags & (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
>> +		    | RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)) !=
>> +		    (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
>> +		     | RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT))
>> +			return -EINVAL;
> 
> Please put operators at the end of the previous line, not at the start
> of the new line when you have to break statements.
> 
> Also, that's unreadable.
> 
> #define RSEQ_CS_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT |	\
>		       RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL  |	\
>		       RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
> 
>	if (unlikely((flags & RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL) &&
>	             (flags & RSEQ_CS_FLAGS) != RSEQ_CS_FLAGS))
>		return -EINVAL;
> 

Based on your suggestion:

#define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE |     \
                                       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)

        if (unlikely((flags & RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL) &&
                     (flags & RSEQ_CS_PREEMPT_MIGRATE_FLAGS) !=
                     RSEQ_CS_PREEMPT_MIGRATE_FLAGS))
                return -EINVAL;


>> +}
>> +
>> +static int clear_rseq_cs(struct task_struct *t)
>> +{
>> +	unsigned long ptr = 0;
>> +
>> +	/*
>> +	 * The rseq_cs field is set to NULL on preemption or signal
>> +	 * delivery on top of rseq assembly block, as well as on top
>> +	 * of code outside of the rseq assembly block. This performs
>> +	 * a lazy clear of the rseq_cs field.
>> +	 *
>> +	 * Set rseq_cs to NULL with single-copy atomicity.
>> +	 */
>> +	return __put_user(ptr, &t->rseq->rseq_cs);
> 
>	__put_user(0UL, &t->rseq->rseq_cs); ?

Yes.

> 
>> +}
>> +
>> +static int rseq_ip_fixup(struct pt_regs *regs)
>> +{
>> +	unsigned long ip = instruction_pointer(regs), start_ip = 0,
>> +		post_commit_offset = 0, abort_ip = 0;
> 
> valid C, but yuck. Just have two 'unsigned long' lines.
> 
> Also, why the =0, the below call to rseq_get_rseq_cs() will either
> initialize of fail.

rseq_get_rseq_cs() can return 0 (success) if __get_user finds a
NULL pointer in the @rseq_cs TLS field. I'll use a
struct rseq_cs * parameter instead, and memset to 0 only in that
specific success case within rseq_get_rseq_cs() rather than always
initialize to 0 in its caller.

> 
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Handle potentially not being within a critical section.
>> +	 * Unsigned comparison will be true when
>> +	 * ip >= start_ip, and when ip < start_ip + post_commit_offset.
>> +	 */
>> +	if (ip - start_ip < post_commit_offset)
>> +		in_rseq_cs = true;
>> +
>> +	/*
>> +	 * If not nested over a rseq critical section, restart is
>> +	 * useless. Clear the rseq_cs pointer and return.
>> +	 */
>> +	if (!in_rseq_cs)
>> +		return clear_rseq_cs(t);
> 
> 
> That all seems needlessly complicated; isn't:
> 
>	if (ip - start_ip >= post_commit_offset)
>		return clear_rseq_cs();
> 
> equivalent? Nothing seems to use that variable after this.

Yep, Boqun already pointed it out. Fixed.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
