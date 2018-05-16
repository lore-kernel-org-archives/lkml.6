Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-526264-1526487951-2-7892103941292015269
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
    1526487951; b=CIL/zcrdOygHzEJmXd+Nyxzjan5oXHOL9H6qnRFeIy9t7IMqoK
    zeHTuDNZuL35dGofRZUP16xXZUp+MSahDE2NnHkrgMcbp1T5+pKkkS9dIZMJMrtP
    swpWUgcX6rWckgzkw9k48/WOoQZmO0wV2iQIvr8ZIxfDeMHdHTrkqXBI2XMKqC2U
    HBq7HyA7ghNrw8IIVi+ymmIWZFifB9RCQHb2wx6svvVYImFGYQDA1mPUMsjzF3IN
    juQXW7KT9HQv5rDzQnm5a9foOEuoXzTllFIznYn82RUffcQguSJc+pImkRLnXQc0
    RmUysl4UoKchFGRl9avRfhBn98sQZgxgBBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526487951; bh=j6ZczL3mseFsF5FhawxuOKfuvIodqU
    47rcCNYs80lnE=; b=h3gzsADPgJbJ/3B0djPt4+wqz97r3F7eolU3Vk9m56hB0F
    UuKUjwiweCm7N5mFXq4v3+ZLJKPWCg+eilFdbnq3azp3BJqH2eogEKQTwe/eZbxS
    2gLxrqHOYKIkbSHCU7SrqRZ0irgVaNPiddii4XJx+TbkoFzNAJJtrufizac7WiS1
    kpbWkRY+k5w9mlKiK0Jth4s8QXFkVTfJdS9CXFfcOgd3lVdTS3pVnKdd9Prqg3xO
    JBgDP8m6JIfoAAn3Uojdf2FuA3itVAyOxmDPhhRBQBENWmoZHCbivNCeQDBvHT+k
    3bBkZa6PMMUv7oAMIiyNnxqQdtYNwHbTntU9cLtg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=KdwTq7re
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=KdwTq7re
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
X-CM-Envelope: MS4wfLxHVDv5myBMye+o1r2V37rqXcu9wXuQ+7703DCv/Lf0H+E5aHwbn3rIIr0sNIqrkMcNTNsFSE2t+Vm7YRrYVRp7CtJ16IehrjVsM95PdE3PVaXetO2Z
    eZulirrJzYTlkYm8qqkaG+IfQxJXwKTXJE4if6BX4yw4E/SAFofuZtnh0sriWGtk4hQVGiZZ1L+YfOmZZDnoKqSN4SzqoMe/CJ2FPz4r0n394ujwfDsPPvMb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=CT5fc5g75rtFhA2J4ewA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeEPQZt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 12:25:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45448 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeEPQZt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 May 2018 12:25:49 -0400
Date: Wed, 16 May 2018 18:24:54 +0200
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
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 02/14] rseq: Introduce restartable sequences system call
 (v13)
Message-ID: <20180516162454.GJ12198@hirez.programming.kicks-ass.net>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <20180430224433.17407-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430224433.17407-3-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 06:44:21PM -0400, Mathieu Desnoyers wrote:
> Expose a new system call allowing each thread to register one userspace
> memory area to be used as an ABI between kernel and user-space for two
> purposes: user-space restartable sequences and quick access to read the
> current CPU number value from user-space.

> ---
>  MAINTAINERS                 |  11 ++
>  arch/Kconfig                |   7 +
>  fs/exec.c                   |   1 +
>  include/linux/sched.h       | 134 +++++++++++++++++
>  include/linux/syscalls.h    |   4 +-
>  include/trace/events/rseq.h |  57 +++++++
>  include/uapi/linux/rseq.h   | 133 +++++++++++++++++
>  init/Kconfig                |  23 +++
>  kernel/Makefile             |   1 +
>  kernel/fork.c               |   2 +
>  kernel/rseq.c               | 357 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/core.c         |   2 +
>  kernel/sys_ni.c             |   3 +
>  13 files changed, 734 insertions(+), 1 deletion(-)
>  create mode 100644 include/trace/events/rseq.h
>  create mode 100644 include/uapi/linux/rseq.h
>  create mode 100644 kernel/rseq.c
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
