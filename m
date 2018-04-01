Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-388702-1522599316-2-680815821873742860
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522599316; b=i/q94G4W3yzRw5ZmdRqARA80fW84twZucbUxR0+rT0Vw+D5TVX
    skynWiNC2/5KBvlKW0/T64w6q08x7jztRzX3h4D18keOMer9zf0DbUteIbruvMmo
    ePIWYLqyExc06FDT2BB55Ti8f3vGSqjUuLcX3MKMhxbVr/NIm74EQKDOzI9hZOYX
    XeLlcv0Dxlkt/X8434qBje96UmDWaLZwKzgwSH4WkD0CpE9frzN22g/vgiIrO7I7
    7Q1KdqHR9jsAob26DjRtiPcKxMbR6lA5tHprqga6m838DDdamts8Su1Kq9udMWZ/
    3HDqKSPiK01JaMLsa89guY4NKq6nEcm0hT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522599316;
    bh=RBbc9esVVEGFlgQrQVePLcsG5zjYpZodQfjlgVpQiuM=; b=Es5GMBGflUlQ
    j1TBzoBSTG7iYBJJTvIUalwcXgFWlxqictT6t4YIiAl4yBsU868zj3bUUB95Z3iB
    xyt1fDH8kdYpz42xKy7vHGW/7rORKVHdfAtxMMjRiM7yp2rK14LUklrkTz+2GSX4
    iB8A6g2TuV6rXKEFY+oeUi4496+FSBfNXfR+pnYHD47Qq/OeFVd36GwxdbphYnvy
    Ze1l6rxlNrdK6yuAdwYQ8jBsuAyfKYeFAdrccmsXcg78nTqVRKFsyui6bMoZPhfr
    Rj9BKEiNVdj8k8BTclbcWsGcFEkrXaRN0nrjb0PWSjcq/7P5eKxgPZRinFu2vc3s
    RjCaTujbYw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIKBzVpZiXQe1XPeYIxi8oYP71VVMPSwxcLD68T9ce7JfqNhnZazqOOJyGZS6okoIei+9kpaIhlKQ9yUrSRbNGSUh4dnFXwtA+2WbNoflpk1aYF0+v/V
    5r1WbCp1hlaXy/vTOcLGxHuPr0QWrsgsi0h+LSjSzasr9aaeZ6Sm7BXHjNB3ABy69dRAtO9ZCTH2vGKFrQaGJ7MqdcVB/2oHeeZJsewyzBr9hmc/7EAHwEsi
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=ZJj9Sj1TOB-oLq_LhIMA:9
    a=a5WCQ_epvVuEe-cq:21 a=9F6LvdJqjKG-yZQV:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbeDAQPM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 1 Apr 2018 12:15:12 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:34418 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753602AbeDAQPM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 1 Apr 2018 12:15:12 -0400
Date: Sun, 1 Apr 2018 17:13:56 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
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
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
Message-ID: <20180401171356.085a2a33@alans-desktop>
In-Reply-To: <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
        <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 27 Mar 2018 12:05:23 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Expose a new system call allowing each thread to register one userspace
> memory area to be used as an ABI between kernel and user-space for two
> purposes: user-space restartable sequences and quick access to read the
> current CPU number value from user-space.

What is the *worst* case timing achievable by using the atomics ? What
does it do to real time performance requirements ? For cpu_opv you now
give an answer but your answer is assuming there isn't another thread
actively thrashing the cache or store buffers, and that the user didn't
sneakily pass in a page of uncacheable memory (eg framebuffer, or GPU
space).

I don't see anything that restricts it to cached pages. With that check
in place for x86 at least it would probably be ok and I think the sneaky
attacks to make it uncacheable would fail becuase you've got the pages
locked so trying to give them to an accelerator will block until you are
done.

I still like the idea it's just the latencies concern me.

>        Restartable sequences are atomic  with  respect  to  preemption
>        (making  it atomic with respect to other threads running on the
>        same CPU), as well as  signal  delivery  (user-space  execution
>        contexts nested over the same thread).

CPU generally means 'big lump with legs on it'. You are not atomic to the
same CPU, because that CPU may have 30+ cores with 8 threads per core.

It could do with some better terminology (hardware thread, CPU context ?)

>        In  a  typical  usage scenario, the thread registering the rseq
>        structure will be performing  loads  and  stores  from/to  that
>        structure.  It  is  however also allowed to read that structure
>        from other threads.  The rseq field updates  performed  by  the
>        kernel  provide  relaxed  atomicity  semantics, which guarantee
>        that other threads performing relaxed atomic reads of  the  cpu
>        number cache will always observe a consistent value.

So what happens to your API if the kernel atomics get improved ? You are
effectively exporting rseq behaviour from private to public.

Alan
