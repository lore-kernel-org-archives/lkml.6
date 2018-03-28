Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2070791-1522236024-2-14784497129366998577
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522236023; b=QCvnaz7IJ3FMbyQL0kTsGCc8PAzZHBqYU31vq7iOqStmI27
    qRfwQUmSVmyNNC8rBxZ0m095BpM1pQ7IYqfAFakg09VMgR3602bcIE7uoxLfJr4N
    SE07VQwye0gMuK90IGXLxqZr8kkOYaKQ3LnFg0XBUD+eNJOqfpe2ZF2cZQgimDD0
    GW/BhDbVLT/bd9dU9rRktq/kSLR5zUq8+hkqWH+ar8vzYvtGLcHJo3uOnZBygmQP
    ADLMSE+RU/7x0HpzV/d6AzOYbczOxf4mxsW3Gj7EyXoSNeYCgnZcfmCkvnqFg3FW
    7HeMITogHFu9oTxpdizxFEIsulJMuoc662nCk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522236023; bh=VIbkQy0yxc8UvGyLPHIBnujGCw
    Cxc+GCYQIaIB0UqmI=; b=LcJyx7rXGczO01O81G1cLhJHjm1EX0gbzy+WTWqqF0
    C80uTOmBlLXNtIEtd3TNXV1h+wm485QUbDYPi7oYEVmCM/OFao0vkv5wyEhtSudu
    8QHlSPy/c0EcKQUvu5f3Y5JaCf5Byv3scd9t+c2U8LtoZ3Cqo5Zq0bJfPYNJTFBi
    Ax+lLOvRFqVyY5cMW0rKdm6ujagL2hriBlv1IMZ4pRb6y+N22JrgaFumu2dzTEoK
    iuHqdd6DH+ubdJzGTAyCxz7qSXoch9ZhGThjAC8+HnwtizO2rgzXqCZgpHelZj7x
    42/NuIqFBf1Orh37tWQa+7VXgSweBpbbKDZ/d3uyMgdQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=MHNIl8W7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=MHNIl8W7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAMVEMXUM0ON3AgbbGa0WNjR3l+hUrWEbmN+C46YbmyTM6n0DgYlKsM1jwUHKPXdLUNyrXLI4kNuj6xBw7/oCxBrO+dBIU57sCdKHf/b0CspUzRdCX/j
    WwyV6SsxDnH0YmwvQGzvfDyrGGUjbXspYZrz9nITozuRGmxQm6FTKYuUxuhfOPKCsNnBUjUe7LAnBh6QdnXfRbkW11DGSqIklpZII17enmOwwkXz7p/fkXX8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=Afmgl6uhLy3NLcEKHZIA:9 a=8s__8gw4HGWGlDFP:21
    a=u7tR07MVs6p5mrFU:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeC1LUV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 07:20:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeC1LUV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 07:20:21 -0400
Date: Wed, 28 Mar 2018 13:19:52 +0200
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
Message-ID: <20180328111952.GS4043@hirez.programming.kicks-ass.net>
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
> +#ifdef CONFIG_RSEQ
> +	struct rseq __user *rseq;
> +	u32 rseq_len;
> +	u32 rseq_sig;
> +	/*
> +	 * RmW on rseq_event_mask must be performed atomically
> +	 * with respect to preemption.
> +	 */
> +	unsigned long rseq_event_mask;
> +#endif

> +static inline void rseq_signal_deliver(struct pt_regs *regs)
> +{
> +	set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
> +	rseq_handle_notify_resume(regs);
> +}
> +
> +static inline void rseq_preempt(struct task_struct *t)
> +{
> +	set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
> +	rseq_set_notify_resume(t);
> +}
> +
> +static inline void rseq_migrate(struct task_struct *t)
> +{
> +	set_bit(RSEQ_EVENT_MIGRATE_BIT, &t->rseq_event_mask);
> +	rseq_set_notify_resume(t);
> +}

Given that comment above, do you really need the full atomic set bit?
Isn't __set_bit() sufficient?
