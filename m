Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3264303-1522272347-2-9191450761276206699
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522272347; b=NnT1FUUwm7yIQRSCGLA/lsdPPi4BEvfFy7KYXCG+JWj24yg
    mew+LfzXSt0GXzQDqFJ853+pvTswxcxO/eX7Ik6Jz0ZXLe2GQDsygLQMZrhmzd6Y
    FqOWIGF9PyUoE9fnj208T7sUJFmC0TnPGmXiXO9T/0XXhn4xsCY5+3QUe6yEJ8cD
    zI9mp/JG2jbHk2TiVzFwXE/6tqZC/VhxLjfXwF3fhkxUDB5ThqZgluB2VYlfuesz
    QYrOfgCDee5an+rOqAfDaHhKAqOZJgskWG+mH+3mIZeb4acwzeOZzvoT6tlmIskV
    vhOCMWRIOFqDV2odqikoIvP2RSScRRe8+XPoXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=arctest; t=1522272347; bh=7ORp19PrhPSi45EXtcrawOeIpw1rTz6Nfn5
    KZR/+t64=; b=Zrm67gpMTS6D446cihbscb5StI/kyogcbycw9k8M5HLA4TUmt+a
    L7tcVRIsoqEPDci5toaLHcVjjqX631lVHX/a9EdJC50NQLulZQkVk9Yv/eEry5Vm
    YzrwIIbEMj3V/Td4a9izzvpHhm4Gbxn8Vk6XXP5QwptLci/s2HsdETiMIV4Ut5sw
    x5Ts2Dp/YYlFw2r79zcXdD4Vx2fcR2T5Ra3yMvTIsWXXSOPfE1Mn3tfpLyaULzdk
    fYeWGZctxoFS5NqFPwd+CRcpU4czg8WxnYE4V3/bwsZwI+SalS0QMRmCvFXyXB8y
    WsgeJy6HBBRXP+tVWDR2TXbaqBQdyyqxKSw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNzCsMRZzBB30jV4gKE8rOsDRjhm1+rkpCTwT+7qzDkxc8XELFFEPQABp+wl+rPvm+i8xcWYmDKmTUori8cGSE1F8pQmdQde9BxFbWJKCCFOZTIpIC4h
    1FXwqv/3WLqqcRppeUNFElHhkcjP88TWAGmPKzsQv+4gvSl9iEubcneGiyZBrlerrT9GEE5orgt3JmjXM5AGMqqHrX5dIqDb2oDkJFkHLqy+U43Q0SAFjiij
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=yFrSdVHJC8_IG7VLq48A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeC1VZo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 17:25:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51978 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeC1VZn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 17:25:43 -0400
Date: Wed, 28 Mar 2018 23:25:22 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
cc: Peter Zijlstra <peterz@infradead.org>,
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
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable sequences
 system call (v12)
In-Reply-To: <181076499.279.1522268382303.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.1803282305030.1496@nanos.tec.linutronix.de>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180328125004.GV4043@hirez.programming.kicks-ass.net> <1523662633.2105.1522248474778.JavaMail.zimbra@efficios.com> <20180328145946.GH4082@hirez.programming.kicks-ass.net>
 <265889560.1.1522250045589.JavaMail.zimbra@efficios.com> <20180328152814.GI4082@hirez.programming.kicks-ass.net> <533214853.56.1522251426819.JavaMail.zimbra@efficios.com> <20180328174935.GK4082@hirez.programming.kicks-ass.net>
 <181076499.279.1522268382303.JavaMail.zimbra@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 28 Mar 2018, Mathieu Desnoyers wrote:
> ----- On Mar 28, 2018, at 1:49 PM, Peter Zijlstra peterz@infradead.org wrote:
> > I don't think disallowing system calls is arbitrary. And I think that is
> > something we really want to enforce, because it's batshit insane to
> > allow.
> > 
> > And if we allow now, people _will_ use it and we can't ever take it
> > away again.
> 
> Here are some examples of how I would like to use system calls within
> rseq critical sections, for testing purposes:
> 
> - Issue poll(NULL, 0, ms_timeout) from a rseq critical section, to introduce
>   a delay in the critical section and test the effect,

It's simple enough to use a delay loop for that. It's testing after all.

> - Issue sched_yield() from a rseq critical section, to introduce preemption at
>   that point,

Make it loop on a varible and use secondary threads to force preemption.

> - Issue kill() on self, thus testing interruption by signals over rseq c.s.,

Second thread can do that

> - Invoke sched_setaffinity to tweak the cpu affinity mask to force thread
>   migration within a rseq c.s.

Second thread can do that

> I currently have only implemented the poll(), sched_yield() and kill()
> test-cases outside of the rseq critical sections, instead relying on
> assembly loops to introduce delays in rseq c.s.. However, if we disallow
> system calls in rseq critical sections, I'll never be able to use those
> systems calls to extend the test matrix.

All of these tests can be implemented without system calls and there is no
justification to allow system calls just because it makes writing test
cases simpler. Nice try.

> I see other use-cases where having a system call in a rseq critical section
> could make sense: if vDSO data shared between kernel and user-space rely
> on rseq for synchronization, but a fallback sometimes needs to issue a system
> call for part of the operation.

What in the VDSO relies on rseqs? Nothing AFAICT. If the VDSO ever goes to
use that then it's going to be a kernel/vdso specific variant and we'll
figure out how that needs to be handled if at all.

But we are not misdesigning now to accomodate artificial scenarios dreamed
up for argumentation sake,

> Therefore I'd really want to keep allowing system calls within rseq critical
> sections, even though we don't expect this to be the typical use-case.

Syscalls inside rseq sections make no sense whatsoever, unless you can
rollback the message you just sent through the intertubes when the rseq
loop failed the taste test. If that works we might reconsider.

Thanks,

	tglx

