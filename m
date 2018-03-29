Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1497517-1522348677-2-7884544397243218277
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522348676; b=HxTjqsQf79JWnM+Mt60MRXTMNTAYyv9X3++5RQfmA0mGu/eYD0
    o+CpkctjZ0lAZV/Re8fnvbwP4A8HuzB3xw5M0OevN37PKQjg6rgtqMaJAJoDVXIT
    Jh6njQfeFmxikX4W/jCHJIXx68+yhHQVsEVjgbTjXFhQs9ZjCvOg8bXhSeV6xCre
    wx7Odm5B3oLS3PGEGXy/uOBy7mKY1n2uSvWK0Yg2x/QAciVZ9f+E0W9XV4qgH7zN
    mrscThIxi2I6WltN/THEt0QxXlJ6wd49aCyr27julwoeUqUQLr2NO5CEANkDcZII
    4iKWaU6q/isJ7nSWcLurYN/C2ACyzPFg/Q1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522348676;
    bh=XvqTW794S/TfPNKZY+PLxT8SJhifZs1KkMKr/q9Jt6A=; b=CKJXmVN5lbCt
    UvUHGOO88k07IaWenKIQBvp38vMIFWsUMalfaTso+4vL1/qKnE9wtUJKO6E9Rqud
    8ocKySNfYueIYbfAAZwphE1Wr6+l4UVp6DnPb+PfyQOhPggpxBmlG2q95+Fdf1Rw
    rzmqClJ6N8QLUg/qDB7y/tPEOPK5gm6YxoIUmb7nMCF564mVA+5P2FaoAE0W2GxU
    4FQ8koxt79Kpxuc998LsWcEr+hcQFrkanjhQPZC2j1djZGpO11O/Lh3qlF5PaOm9
    JOpJOBXfwE5wcZr5lHqvJ9gyH+/TyCl+808o3JtphSSvNbL4ciwx61HQwA6QhWJ/
    IF6QgK4uEQ==
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
X-CM-Envelope: MS4wfDeSbtQ+6G3UsCZ2KABviitXTVV5bE/v7Q9118Kjxwsrc2OIiDRsTcv/z7Y8AxaFb5XOUtwYd9UZdiGem1g3IsOrqaMukN7+C171Qx8JfDi4ze69CdUd
    nvTItXslgcy5QwgmTwWEgFDO3co58iwebG9Qyt0h1BBl/EAhINqexVzT6tyTQx5rqqOtWnnbEV6m9B8ia0Sh8cOZHz6cu39myM3uJXEpFdiKvROqpTOOENbx
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=meVymXHHAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=6v0ROPv4NEZ4CVOXagQA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeC2Shy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:37:54 -0400
Received: from mail.efficios.com ([167.114.142.138]:50078 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeC2SCf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 14:02:35 -0400
Date: Thu, 29 Mar 2018 14:02:33 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <21903915.856.1522346553810.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180329122439.4a909c72@gandalf.local.home>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180328174935.GK4082@hirez.programming.kicks-ass.net> <181076499.279.1522268382303.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1803282305030.1496@nanos.tec.linutronix.de> <87410797.545.1522331641598.JavaMail.zimbra@efficios.com> <20180329142338.GD4043@hirez.programming.kicks-ass.net> <544124089.623.1522337940950.JavaMail.zimbra@efficios.com> <20180329122439.4a909c72@gandalf.local.home>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: qvRuBK4nMzc3YgRr7lnp2KqNAoq3Dw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 29, 2018, at 12:24 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 29 Mar 2018 11:39:00 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Enforcing SIGSEGV on syscall entry when nested in a rseq critical section
>> will not be free both in terms of syscall overhead, and in terms of code
>> maintenance: we'd need to add those checks into entry.S for each architecture
>> supported, which pretty much doubles the amount of architecture-specific
>> code we need to implement for rseq. Currently, all we need is to hook in
>> signal delivery and wire up the system call numbers.
> 
> Why not have the check on syscall exit? Then we could use the ptrace
> type mechanism to only go that path when a rseq exists for the program.

Currently, anyone using ptrace on a process has pretty much given up all
hopes of performance. Processes will use rseq to gain performance, not the
opposite, so this deterioration will be unwelcome.

One thing I would find more acceptable is to only compile in this check under
a CONFIG_DEBUG_RSEQ option or something similar. This means we can then put
the check at the most convenient location without caring too much about its
performance impact.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
