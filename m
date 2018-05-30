Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4008273-1527692383-2-2491866063559222094
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527692383; b=BSq9htPH/q36uJ/GllymcSA9sh2xBNU5XHezp1OzfCXi6dI9T9
    yllKzemfN2liGYx1x2bZczki+FAZL+SFz7uPe5DfIv1OLHhbJjXeqLGdHh28ly8Q
    S/9taCQ/3bTw3KX3eZMLbMJETeiNY7tDhkDhVPStU2gOEXRMvJqCwA7ukWPCWBNQ
    p8YcK3oUnDP1TLiEIvat2GfohoXbyR73A1k1Y5zMSq6L1ZUAsJrIe3jhVYn6sXjv
    Ikt3/sJiWjb2m4LViz9uuTlK3bbndUBXA6UV6xLq2BFUNqZNnB0rC1KTmfN7TOjK
    i410refXEaBMg2Bz4tpkOoCtivZ2OWF849uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527692383; bh=HuEYhWl+tYU8Jwd1+csLCgf4Ab+db5emTdKy+IsBGl
    s=; b=AZCpNy9xrl0+UotFdd8we0hw2g3EQ3MdeaXDeo7PG1J6SxcRHzHR1fiP2W
    iQxSF/M8Ph3y/U3afE+VzEx9wGZ1QcPSp8+0/QLI706ay25KRTHNAeEeqKSUVAQB
    KP3yK9KfePd79mxJweh1RmuG88JakXHaK4M+Cy4cIqXr3Xbn1RagUmrQXUumCxjE
    KvMxxngLSBtodngtow3mb7OnXbf6DA5qkLGGhPmRZqSdigKCYS/oLJF1SAUaDFU4
    wTk0CIbV8NCtx1jY4UsALZV2bb+EGgQP2NV08ptYGZq1TBbl6gOXc8ON0tyWghVM
    CvNdgpgCSUFp813yldeXctc+YJyA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linux-foundation.org
    header.i=@linux-foundation.org header.b=asZ7UCeS header.a=rsa-sha256
    header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=WVio0VqK;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linux-foundation.org
      header.i=@linux-foundation.org header.b=asZ7UCeS header.a=rsa-sha256
      header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=WVio0VqK;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN1TvPz+P8r4tMEYsznQgXNdqLLQQUN2aByvyGSH2cvAxTEVPPTfdU/vJB1gdQoRj9uq6Gs+vgCGgcEZ9EF0Uz/z9KwxEZM1PBGpJZkgaBRMvSO2vuBl
    VairHFwROaejnFpKuG31KDCrBT87vL86yQnvCJNikrzeyQitadLojidGEcph7yxK09JcEKLqPuW4xRbYGfqHEOpunkq4BqYa3bbazFMeHOzqZxcZhvjzeKbQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=PQWRJEmWsxYTHi7mVx0A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeE3O7l (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 10:59:41 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39150 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeE3O7k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 May 2018 10:59:40 -0400
X-Google-Smtp-Source: ADUXVKKeoz907JuLpxYQ9VAndtnzKb46os/dvTM/lFzP0plxNyG0zVwaEF2VQyt5i85QfuWljxSxEoyVYvECc5c7W6A=
MIME-Version: 1.0
References: <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
 <Pine.LNX.4.44L0.1805301009340.1502-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1805301009340.1502-100000@iolanthe.rowland.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 May 2018 09:59:28 -0500
Message-ID: <CA+55aFy2SqVr3XggBS6_N+EUZMABa0xwpme5BW4qmLQ1h6J3pQ@mail.gmail.com>
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

On Wed, May 30, 2018 at 9:29 AM Alan Stern <stern@rowland.harvard.edu>
wrote:

> >
> > Can't we simplify the whole sequence as basically
> >
> >      A
> >      if (!B)
> >          D
> >
> > for that "not B" case, and just think about that. IOW, let's ignore the
> > whole "not executed" code.

> Your listing is slightly misleading.

No. You're confused.

You're confused because you're conflating two *entirely* different things.

You're conflating the static source code with the dynamic execution. They
are NOT THE SAME.

   It really should be:

>          A
>          if (!B)
>                  ; // NOP
>          D

No it really really shouldn't.

There are two completely different situations:

(1) there is the source code:

     A
     if (B)
          C
     D

where  C contains a barrier, and B depends on A and is not statically
determinable.

In the source code, 'D' looks unconditional BUT IT DAMN WELL IS NOT.

It's not unconditional - it's just done in both conditions! That's a big
big difference.

> In other words, D should be beyond the end of the "if" statement, not
> inside one of the branches.

You're just completely confused.

What you are stating makes no sense at all.

Seriously, your reading of the code is entirely monsenscal, and seems to be
about syntax, not about semantics. Which is crazy.

Lookie here, you can change the syntactic model of that code to just be

     A
     if (B)
         C
         D
     else
         D

and that code obviously has the EXACT SAME SEMANTICS.

So if you get hung up on trivial syntactic issues, you are by definition
confused, and your tool is garbage. You're doing memory ordering analysis,
not syntax parsing, for chrissake!

>   At run time, of course, it doesn't matter;
> CPUs don't try to detect where the two branches of an "if" recombine.
> (Leaving aside issues like implementing an "if" as a move-conditional.)

You cannot do it as a move-conditional, since that code generation would
have been buggy shit, exactly because of C. But that's a code generation
issue, not a run-time decision.

So at run-time, the code ends up being

     A
     if (!B)
         D

and D cannot be written before A has been read, because B depends on A, and
you cannot expose specutive writes before the preconditions have been
evaluated.

> Remember, the original code was:

>          A
>          if (!B)
>                  C
>          D

> So the execution of D is _not_ conditional, and it doesn't depend on A
> or B.  (Again, CPUs don't make this distinction, but compilers do.)

Again, the above is nothing but confused bullshit.

D depends on B, which depends on A.

Really. Really really.

Anybody - or any tool - that doesn't see that is fundamentally wrong, and
has been confused by syntax.

A *compiler* will very much also make that distinction. If it doesn't make
that distinction, it's not a compiler, it's a buggy piece of shit.

Because semantics matter.

Think about it.

                  Linus
