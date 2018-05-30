Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-313932-1527717677-2-3253541353234428036
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527717676; b=F+FILwJt96FNubM4GsQTgPsq0Q2SMBqbH8ToS3xlZHLEDF/TGM
    t7YubtCfVBvppAUwgvEwQiMtG2kbMg9XmaUxtJlAvw2CoURUmM5a+v2qfFkjoZkL
    eplZEr4U4lJ6Swes7pHjYryRyp2/aPvN4IyNcA5mrU2CbRJzgM68ojEBElOx14bb
    MKG+63bMRV1A7R+gttETx/PBN2ddWvm/9bUtxc/pY35zruGblrjxqiH74yJB5Tp+
    u/Oo0gGfCcpwU+Q1nzPIFgb+CdOYM28Y8xzZulRtR5VxJMSuk4ThrPLyCoEQ9B4W
    VXJz2oxGTVwokeGAqNcEqv5k3w/dTNW6YZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527717676; bh=OUQMo3YGUP+hqbNvCkI6XaUveQyXEM+63f5eG0MAcK
    Q=; b=Dn7/DPy8FoFJ9F503HvpNtlIaaVqWvY73zgeYG+PRZxqhTVQKz+NHQ99MF
    RNFCEROg3OwLpOYfgDBzktgrB1JfQdTVp/9SQ+9OtbzyyMHspD9PYnFQq+i9ou0F
    BmEQFhlfnc6Tjqb7eT3LL6AUPhDCKnJsKYqnqQk9GLqFdMHgF2JpqgMkkubyp/qt
    /HU+kf5MTN4cLw7IJgFOgg7v0fgR37NodjC0Gbwx3D/0R/pyyFDp2/elLw/3NtqP
    1RR2tT6KV6XjzshYEod9oB5GkEpCJGgaXbaIBy+odF0EzZc3e3zucjoUgVLxdfBN
    5cE0gz2JAZ3Hr6wKPGLN3FIVTNiw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linux-foundation.org
    header.i=@linux-foundation.org header.b=WVUSCmPN header.a=rsa-sha256
    header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=ZnHgVoE9;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linux-foundation.org
      header.i=@linux-foundation.org header.b=WVUSCmPN header.a=rsa-sha256
      header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=ZnHgVoE9;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIBhh/7peQzYkh5mD0r1Vl9hpM1KSWcRUA3CwSKAJMjUxg6s/KKLbgMhdYokb89xNDeQIm65drT03sGBzutERm6vW/CdbYawGL6O0PyF9HXWGlrSvWXZ
    iov9z7glMTepQDEQQYQkHqozTu+QCQGigtTcFHrWYdd889KYiNxXQ6ViraYkcDWe1YNtlFhSS94xM/fy5Q2zl3j7tyUJ0dGJFT2AXyjibyEeyIaOohXzZCC4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=57jNveXy4t212eyojx4A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932488AbeE3WBP (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 18:01:15 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34490 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeE3WBO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 May 2018 18:01:14 -0400
X-Google-Smtp-Source: ADUXVKLluppE5etvOWbBkXnfHo4Tzejp6fyQAYza27FbSZUCCyVvCBG2FH1WF3HjZTxSzenoAqlN1mumZc0JHI+xHn8=
MIME-Version: 1.0
References: <20180530183826.GI7063@linux.vnet.ibm.com> <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 May 2018 17:01:01 -0500
Message-ID: <CA+55aFxXgECHW+Pekiuvt1htsDfML2ximrLrmr99xewGYpmEng@mail.gmail.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 30, 2018 at 2:08 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Indeed.  The very first line Linus quoted in his first reply to me
> (elided above) was:
>
>         Putting this into herd would be extremely difficult, if not impossible,
>         because it involves analyzing code that was not executed.
>
> It should be clear from this that I was talking about herd.  Not gcc or
> real hardware.

So what does herd actually work on? The source code or the executable,
or a trace?

I found the herd paper, but I'm on the road helping my daughter in
college move, and I don't have the background to skim the paper
quickly and come up with the obvious answer, so I'l just ask.

Because I really think that from our memory model standpoint, we
really do have the rule that

   load -> cond -> store

is ordered - even if the store address and store data is in no way
dependent on the load. The only thing that matters is that there's a
conditional that is dependent on the load in between the load and the
store.

Note that this is *independent* of how you get to the store. It
doesn't matter  if it's a fallthrough conditional jump or  a taken
conditional jump, or whether  there is a joining.

The only thing that *does* matter is whether the conditional can be
turned into a "select" statement. If the conditional can be turned
into a data dependency, then the ordering goes away. That is why it
was relevant whether "C" contained a barrier or not (it doesn't even
have to be a *memory* barrier, it just has to be a barrier for code
generation).

Note that the "C doesn't even have to have a memory barrier" is
important, because the orderin from load->cond->store doesn't actually
have anything to do with any memory ordering imposed by C, it's much
more fundamental than that.

> Preserving the order of volatile accesses isn't sufficient.  The
> compiler is still allowed to translate
>
>         r1 = READ_ONCE(x);
>         if (r1) {
>                 ...
>         }
>         WRITE_ONCE(y, r2);
>
> into something resembling
>
>         r1 = READ_ONCE(x);
>         WRITE_ONCE(y, r2);
>         if (r1) {
>                 ...
>         }

Correct.

What matter is that the code in C (now called "..." above ;^) has a
build-time barrier that means that the compiler cannot do that.

That barrier can be pretty much anything. The important part is
literally that there's a guarantee that the write cannot  be migrated
below the conditional.

But I don't know what level 'herd' works on. If it doesn't see
compiler barriers (eg our own "barrier()" macro that literally is just
that), only sees the generated code, then it really has no other
information than what he compiler _happened_ to do - it doesn't know
if the compiler did the store after the conditional because it *had*
to do so, or whether it was just a random instruction scheduling
decision.

            Linus
