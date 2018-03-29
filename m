Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1445413-1522347112-2-11781785070704019586
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522347111; b=vDymQcPT2hSVLALmr2SWK+GhrQa9tXliJ+7epseInjyq8BOjH5
    HpjbEquDHqCmJOAgm/orSu32L+hoBM8jruVyuyqHftScYs6zyrkmq0k5rDUOyOwc
    GVM81G6M1JbxB4d7j4FWvR9vDjys0qkNGVOUKQwqb5EBWdO7HZaz8W/irBsGIKVc
    ZG/FnwgoaRhPiVmdung7WGPkztmrtKi/uKLBQFPpFAnqbQiC9MFebvU+AmPh9DA7
    3NJK5FnxmU7iUTNrNMhZCvK76ZTshIsYuTq7jUyKAFRvSuH9fGYOEGObXKiOcc8D
    XlK1JtzxbxoO0STSalJnZLMUmr06EW7Z6aKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522347111;
    bh=yGa5TwbPusMju0ym5Cis8toPqGJSSDMhLacqWJtdQjo=; b=vix7M4xielZo
    0eyUAXy1cN37JMZSb7TvB9YhT7HbrtjLxCg/8WO042PkgU/LAwUzo7TI3byG2826
    JdQ2sHvgYHBPqW5xukk9JdiELi2I4usP6fvZZUuvf/maj1amJ60AQWtuGLoa8t0w
    pPqfgjRw6Fxz6TjHrX3RWPMuOQuo4SYAYWstyMbO1zgEKxSkW5nltdAA0BXOSXZO
    coSajTIcXEN70NOR+/VDJvgeMBOkNaFhcq4rBKlfYmy1T1tV1oiPdbB1LKcvDyqr
    XHRd7jxsfeWwXkuFZwuNSqm1yKxmuu8oSTi7NlTTguZ45OdL4S0KHBW55KecsIQp
    nHIb8Tkz2w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH9SpQKmV3WskjrfNabfRd4srZm4RKMpEkcu+dnxmHX4qF6+jwfQTe/acGEqdqMI0gF5lmdhswqQUepUZg0DnnMC0TNC/JXZ2LCiLCzZ1GJn8Hxs+J5N
    X/7A34rTKAzAkYxmC8h6WetU5yzA+88DZsujnYs79qhADAzXYzrJW0cD8oV8LMrDR/7pZnugjQFzuxhhx6N9oDVIqjrH+hTi2tIBWuPTfs55TH7j1yJVHYHs
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=svTxBbp9I1HFmBz0-fIA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeC2SH7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754158AbeC2SH4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Mar 2018 14:07:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAFE21777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 29 Mar 2018 14:07:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
Message-ID: <20180329140752.12661138@gandalf.local.home>
In-Reply-To: <21903915.856.1522346553810.JavaMail.zimbra@efficios.com>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
        <20180328174935.GK4082@hirez.programming.kicks-ass.net>
        <181076499.279.1522268382303.JavaMail.zimbra@efficios.com>
        <alpine.DEB.2.21.1803282305030.1496@nanos.tec.linutronix.de>
        <87410797.545.1522331641598.JavaMail.zimbra@efficios.com>
        <20180329142338.GD4043@hirez.programming.kicks-ass.net>
        <544124089.623.1522337940950.JavaMail.zimbra@efficios.com>
        <20180329122439.4a909c72@gandalf.local.home>
        <21903915.856.1522346553810.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 14:02:33 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Currently, anyone using ptrace on a process has pretty much given up all
> hopes of performance. Processes will use rseq to gain performance, not the
> opposite, so this deterioration will be unwelcome.

The ptrace path has nothing to do with ptrace anymore, and probably be
hard to notice the performance hit. You simply set a TIF flag, and on
exit of the syscall it jumps to a path that checks special cases
(tracing system calls being one of them). It's called the ptrace path
because ptrace was the first one to use it (I'm guessing, I haven't
actually looked at the history).

This is used to add any system call checks that are not done during
normal operation. And this certainly falls under that category.

-- Steve
