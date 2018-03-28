Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2466908-1522247179-2-13326524311717716681
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
    t=1522247178; b=cME8IeiHEfbIx5Ag2w7h+qUjqHDQWSG5wi/XIseJp2FKIqi
    9NhFTZqoRQioeea4mf+WTnDHKJ32J5+nJGAJRBCKuiTmmhs1otKj2KYifxzExO4y
    P1WOeu6EMW37Mx/Y92lgpfdF/8Apwl7IgEwKJF2wWcUu8UNW5o5svjCudAUC3LY2
    8Mtb+KQ6AxGcRhuFZdzk0Tf1iuGs09YQwD5PZaMg1v/H4xWupG+zdtvnxmlJlx8J
    UJCLTQ+hBID1/6NMH4lPOjv6W3vM8pUz5kfi0dfLV+qE3sQDCcsF8h/OTB3dpHfD
    xiJ8xDEm0WErS8PWvqkN6t4Rrb0iS1uAUL3/O2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522247178; bh=RmtnjGdS4JZ7FhXDRcprLYMYm8s6JQWzFZJkZ6Z0Rk0=; b=e
    lRJPcTJ3z7GUM7ij6ppc3ap3CT9yjMClDjUQOHMqy6lxttA82yBm9OaXzFLfuDi1
    mLJlP1hOFd20px8CHUsJLtcoflrOgplabV3gDA2gdOkdJoIsNWl87ZBIgVUp6aNt
    WtVLbMBfYfJQmHje5NkYIUt4emouzIO/mqmtUNnLy7NYdYM+XFrO3LFNPAdsoOH/
    jzdmlaYlTaRwp+EwtlAfj9b9NBiUjhtmgAsuY9AT/1ho8/zZ2eaSzVTQ9RactrYi
    eVT2mjBeRMWydfK7TuxmegGWmWs2z+WMyYBn0f4sx/Xyuuqt1Lp1VnHm/UZy0alD
    vEWcTf0+AV+hAI+gGcIgA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfMzD9lqv5sg1vqnLN1M/n+dvFvTmoopiUBz+5mXkAQqDvCbKG/oLYaMO10a4hiuYRNA3f5K8VekMlbLK7QUtJMeYCpwK7zcLB2x/ebh0gQLKupPsWK2b
    jnwW3NA9HKQsLVyTg+cnbqXYyL9bvj5vi8/iPhMeXT6HEIja0imSqIv5MJAf/nintQ/2imbZQMomvrKYWxVNkpFRt6JH8FJQYU4EhqeZqqIhUYCs+oIu7Ek8
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=JZAWwylchsNqVXaV1voA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeC1O0Q (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 10:26:16 -0400
Received: from mail.efficios.com ([167.114.142.138]:37074 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeC1O0P (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 10:26:15 -0400
Date: Wed, 28 Mar 2018 10:26:14 -0400 (EDT)
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
Message-ID: <220077125.2034.1522247174476.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180328112225.GT4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180328112225.GT4043@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: z6biGYBCh868zWhFRlI8XBOdAjHfoA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 7:22 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:
>> +/*
>> + * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
>> + * contained within a single cache-line. It is usually declared as
>> + * link-time constant data.
>> + */
>> +struct rseq_cs {
>> +	/* Version of this structure. */
>> +	uint32_t version;
>> +	/* enum rseq_cs_flags */
>> +	uint32_t flags;
>> +	LINUX_FIELD_u32_u64(start_ip);
>> +	/* Offset from start_ip. */
>> +	LINUX_FIELD_u32_u64(post_commit_offset);
>> +	LINUX_FIELD_u32_u64(abort_ip);
>> +} __attribute__((aligned(4 * sizeof(uint64_t))));
> 
> What's with the uint32_t ? The normal Linux API type is __u32 afaik.

Will fix. Working on both kernel and user-space code in parallel kind
of does that to the brain. ;-)

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
