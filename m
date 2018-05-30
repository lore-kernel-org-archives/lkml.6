Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-68338-1527703826-2-14899480377912126901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527703826; b=faNFkZ19ULdADAJxeWSMylCrKxq8D6f8qsP8z2p26Vl234kxap
    ygkeKqMZeWhhewYyHjWraOytJYpxRd3FYdkpfnIsdCgsOOUM0ASl+ZRat5GiMGI0
    3noL+22rAJ7fCBmV7A9fCVtDFtqnaKm3QVb15NCLifA3WENbFg1ogHCaApq6K2gx
    noUQLYVCizkVadFyOIgaatJ+NypKguPwPOQXI9w+TSNNqp502thw13JxY7H5nvy1
    6UcogwYB88kHe6nhGY9o57vXb9Fj+9q7Gkkd/L2Q8DSqDtiqGfexHBcH4wqUoPIx
    eKTcFgnTqYglSFOjV8xH3Chbuz/TVBxFWgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1527703826; bh=M8Y3PK/7sR/+WH6jCS9oysmo7YvYh8iCfVmKQtkE6cI=; b=J
    781JIDH1XNczPLj+lMvVcZrAlvzAE7TAFqOuVeuJWIN9gB/fXaExZQ157SkcguQl
    69/bOlQAihX2fo5TD0mBdRfsBkQLcs1aPXOJzBYGPUOpG+ll6HesFKz+WA6Oi6cX
    73db2iGKXNrrHG0dI9uo1fDHUDM3YMNhB3x6hNwudQF/Mf4E63jO5rTmSvah6zdu
    UyVabu4HcYzuXQiCuTqZK0pWSAh9CD80qc3b/ldQRg/grC3Rf6LBNi2wXER3bRNL
    S6k2ISYe61lGFfFyl5o3pfYOMoqWtHNA7/UtC+G0Zt4ViS1kApo/RFVPjjuvnk/m
    w+TI8vgT+nEdBo38lYE0w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rowland.harvard.edu header.result=pass
    header_org.domain=harvard.edu header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rowland.harvard.edu header.result=pass
      header_org.domain=harvard.edu header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ20YL79S1hZi5Jrdd8jDmH6TuUDnuHo9QvJkr36EISwhaGrSjTK4pUfGz4OnFC3ZdPdiHop05DpCzjUhPAdti9nczQqiHhx5iymLx9V9nbZmWD8RUt6
    go9G/F2X4SdiPGpB7XX8ThfdW0Gp57uq6hP9vMOI+07BvhQ77+e/TBIOVTIbMcG8J8TUcq4nxhj9Z4xXIl8bu3e88BjQAZGKubVGyukIwKWUUzW+l4LNvHHk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=uvHe_gaIcESmQfz8orsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeE3SKZ (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 14:10:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37146 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1750752AbeE3SKY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 May 2018 14:10:24 -0400
Date: Wed, 30 May 2018 14:10:23 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
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
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
In-Reply-To: <CA+55aFy2SqVr3XggBS6_N+EUZMABa0xwpme5BW4qmLQ1h6J3pQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1805301204590.1502-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 30 May 2018, Linus Torvalds wrote:

> On Wed, May 30, 2018 at 9:29 AM Alan Stern <stern@rowland.harvard.edu>
> wrote:
> 
> > >
> > > Can't we simplify the whole sequence as basically
> > >
> > >      A
> > >      if (!B)
> > >          D
> > >
> > > for that "not B" case, and just think about that. IOW, let's ignore the
> > > whole "not executed" code.
> 
> > Your listing is slightly misleading.
> 
> No. You're confused.
> 
> You're confused because you're conflating two *entirely* different things.
> 
> You're conflating the static source code with the dynamic execution. They
> are NOT THE SAME.

I'll do my best not to conflate them.

Your phrasing was not the greatest in this regard; it looked like you
were trying to talk about a different static source program.

>    It really should be:
> 
> >          A
> >          if (!B)
> >                  ; // NOP
> >          D
> 
> No it really really shouldn't.
> 
> There are two completely different situations:
> 
> (1) there is the source code:
> 
>      A
>      if (B)
>           C
>      D
> 
> where  C contains a barrier, and B depends on A and is not statically
> determinable.
> 
> In the source code, 'D' looks unconditional BUT IT DAMN WELL IS NOT.
> 
> It's not unconditional - it's just done in both conditions! That's a big
> big difference.

Can you explain in greater detail?  A lot of people would say that
something which occurs under either condition _is_ unconditional, by
definition.

> > In other words, D should be beyond the end of the "if" statement, not
> > inside one of the branches.
> 
> You're just completely confused.
> 
> What you are stating makes no sense at all.
> 
> Seriously, your reading of the code is entirely monsenscal, and seems to be
> about syntax, not about semantics. Which is crazy.
> 
> Lookie here, you can change the syntactic model of that code to just be
> 
>      A
>      if (B)
>          C
>          D
>      else
>          D
> 
> and that code obviously has the EXACT SAME SEMANTICS.

That is not entirely clear.  The semantics of a source program are
partly determined by the memory model, and the quality of the memory
model is exactly what this email thread is about.  Under a defective
memory model, this code might indeed have different semantics from the
original.

Granted, it _shouldn't_ -- but our LKMM is not ideal.  As an example,
one of the known defects of the memory model (we have pointed it out
repeatedly from the very beginning) is that when identical writes occur
in the two branches of an "if" statement, just as in your code above,
the model does not allow for the possibility that the compiler may
combine the two writes into one and move it up before the "if".

That's not the issue in this case, but it does show that the memory
model we are working with isn't perfect.  The subject of this
discussion is another example in which the memory model fails to give
the desired result.

[It's also worth pointing out that semantics vary with context.  Is
"x = 1; y = 2;" semantically equivalent to "y = 2; x = 1;"?  It is in
a single-threaded setting.  But in a multi-threaded setting it need not
be.]

> So if you get hung up on trivial syntactic issues, you are by definition
> confused, and your tool is garbage. You're doing memory ordering analysis,
> not syntax parsing, for chrissake!

To be fair, we are (or rather, herd is) doing both.

> >   At run time, of course, it doesn't matter;
> > CPUs don't try to detect where the two branches of an "if" recombine.
> > (Leaving aside issues like implementing an "if" as a move-conditional.)
> 
> You cannot do it as a move-conditional, since that code generation would
> have been buggy shit, exactly because of C. But that's a code generation
> issue, not a run-time decision.
> 
> So at run-time, the code ends up being
> 
>      A
>      if (!B)
>          D

Sorry, not clear enough.  Do you mean that the CPU ends up executing
essentially the same sequence of assembly instructions as you would get
from a naive compilation of this source code?  If so, then I agree.

By the same reasoning, at run-time the code also ends up being

	A
	if (B)
		;
	D

(that is, the sequence of executed assembly instructions would be
essentially the same).

> and D cannot be written before A has been read, because B depends on A, and
> you cannot expose specutive writes before the preconditions have been
> evaluated.
> 
> > Remember, the original code was:
> 
> >          A
> >          if (!B)
> >                  C
> >          D
> 
> > So the execution of D is _not_ conditional, and it doesn't depend on A
> > or B.  (Again, CPUs don't make this distinction, but compilers do.)
> 
> Again, the above is nothing but confused bullshit.
> 
> D depends on B, which depends on A.
> 
> Really. Really really.

Sure, in the code you wrote there is a control dependency from A to D.  
I would never say otherwise.

But my earlier email concerned the original source code outline.  
Whether the two are semantically equivalent or not, they are certainly
different syntactically.  herd's analysis has a large syntactic
component; given the original source code, LKMM does not generate a
control dependency from A to D.

You may think this is a weakness in LKMM: It treats two semantically
equivalent programs differently just because of syntactic variations.  
I wouldn't disagree.  (Much the same could be said of real C
compilers.)

In fact, the whole point of my original email was that this code 
pattern illustrates a weakness in LKMM.

> Anybody - or any tool - that doesn't see that is fundamentally wrong, and
> has been confused by syntax.
> 
> A *compiler* will very much also make that distinction. If it doesn't make
> that distinction, it's not a compiler, it's a buggy piece of shit.
> 
> Because semantics matter.
> 
> Think about it.

In the end, it seems that we are in violent agreement.  :-)

Alan
