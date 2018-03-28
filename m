Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2462495-1522246785-2-3102296219332770862
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
    t=1522246784; b=w6kruMT/q1jX8Y2w7yvEIjc4r08lWVw7SwE1dHD8DZqCdOm
    Q2IKpbHLjmD94wJaZthcHamhUIvfTFLS7WCcO+RzzPwW2r7etU2/4HBV+SwSVmar
    gFY25VxCYkI+GB+rzVtbekvLw1ahtgcaEaLSL58CDHslS5APL5rUi0GIrHWY2l77
    +BnUKgf65eis03I2Q7A8P/VHsmNlQbwTe3IZ2k3jm4bAxYGXoiVAW/lrfYNm/Sd+
    tsgGSIxOedAUPyT8okW+PtLvGyZo+nrx6Ps4KZ2E6cgqS+DqgyiohWpklMfQQAGD
    Q6/nHGqZBQ+CnpDP2wxqd+WZkQPADMiGLOMk+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522246784; bh=H9IMOrED52Xo7pb4agt7HNXrv+qSgE7OSlebrjASfo0=; b=C
    GHV0Le/YOY22DnW+sFlw5Qzr0RkAWsOqvh+z/uW0EiYLy20v0hPe7Onv+PB5Zf8f
    MCpPKPhDgxid01XuE0BnZHU7XIsn06b+wJF14ZWUzOzfPaymSwoPCfIzNJccr4kd
    2g5tcKlr3qvpaLVyCrhrxILr8C+0gNbNm2aClgA3bp2pq/jZgexqI9mRXgnpzX03
    CAvbw/6QbmdJdPwF/Q0waD00RRvubrDpHteToAqbvoMLwdBiyXN8cr2X4hEuDT52
    Ho6wxsZ8Y76oqJrGi46HWOBVUXBA8DWVYysuBih3eG2n+Fx6eER9jVrpb+QsvOZu
    6mFVfXPnI8ALeZJgTw64g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfK2s5yhs7VyvaJPOv2nJkL9g1AzZBH7MaLI61V9VvaCY1mG1KcEpLN7EGTQnZmAjGZEJj+cREq6JFtj910v5tG7g5/Gkt2kNHs/hOJEumVbKpY5WHEHD
    pEOrnRDifi9l1MxETRfRAy9h+cZR69tOKw6612t6H9t39IzcZmfvRJ89/RD6aovhNP1kad+OYa0Z3tMHegM09Uhwj3ZPuV/5GhNUsUEPMhT9rcVhQucu/Tbg
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=zxtECigeEC--2eQrUCwA:9
    a=DreEa7tXX5EmkfLF:21 a=uClrUiA8hBkzckzU:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbeC1OTi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 10:19:38 -0400
Received: from mail.efficios.com ([167.114.142.138]:36796 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeC1OTg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 10:19:36 -0400
Date: Wed, 28 Mar 2018 10:19:33 -0400 (EDT)
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
Message-ID: <1602066458.2029.1522246773927.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180328111952.GS4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180328111952.GS4043@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: oZa9XxD5Ql08V10mQq0a0I1RlslAQw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 7:19 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:
>> +#ifdef CONFIG_RSEQ
>> +	struct rseq __user *rseq;
>> +	u32 rseq_len;
>> +	u32 rseq_sig;
>> +	/*
>> +	 * RmW on rseq_event_mask must be performed atomically
>> +	 * with respect to preemption.
>> +	 */
>> +	unsigned long rseq_event_mask;
>> +#endif
> 
>> +static inline void rseq_signal_deliver(struct pt_regs *regs)
>> +{
>> +	set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
>> +	rseq_handle_notify_resume(regs);
>> +}
>> +
>> +static inline void rseq_preempt(struct task_struct *t)
>> +{
>> +	set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
>> +	rseq_set_notify_resume(t);
>> +}
>> +
>> +static inline void rseq_migrate(struct task_struct *t)
>> +{
>> +	set_bit(RSEQ_EVENT_MIGRATE_BIT, &t->rseq_event_mask);
>> +	rseq_set_notify_resume(t);
>> +}
> 
> Given that comment above, do you really need the full atomic set bit?
> Isn't __set_bit() sufficient?

For each of rseq_signal_deliver, rseq_preempt, and rseq_migrate, we should
confirm that their callers guarantee preemption is disabled before
we can use __set_bit() in each of those functions.

Is that the case ? If so, we should also document the requirement
about preemption for each function.

AFAIU, rseq_migrate is only invoked from __set_task_cpu, which I *think*
always has preemption disabled. rseq_preempt() is called by the scheduler,
so this one is fine. On x86, rseq_signal_deliver is called from setup_rt_frame,
with preemption enabled.

So one approach would be to use __set_bit in both rseq_preempt and rseq_migrate,
but keep the atomic set_bit() in rseq_signal_deliver.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
