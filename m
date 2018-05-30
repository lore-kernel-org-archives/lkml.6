Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4008273-1527690572-2-4655354652318654525
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527690571; b=jtjF4iiSjSlvkkdwOKenu7pulFhuBjfKfnZ/5ENELrogWv3bnY
    LRRT/YbqD+ThsdPvVdspQhrsMTTKmQm7uJxqgtiYwfHbyi/rI1V/XayfxreVNS8e
    pw+h6KOtvDk95au7ORXRdsJD1xypo0izjG4a5aMHBocLHGRLcuNvrcZxTZugINkT
    3AKK9/0nTkYBRpJDfXNG/NECSRQuBZ7k5+H9hOnWqyim8meAnNxR4pRJsPYRSyiJ
    sGD0476lTNCz4YxSZ33fga/9o0o6SYzOqFXWJaXOh/k18MD1L15wJh+WE7m/sZW3
    nXY4VyQJF0Na5YbzJQQ3sq66krUouiCOGpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1527690571; bh=9nDdLMlOwI1N+hCLgqGXlH0O2Rivr3LcB8r6o5Trj+Q=; b=H
    ydrL4USSINF1UUJvy5gD0TXFLU79rKweFRrrScsRmJay1pCuIYuwah9FLHpXoewN
    GeuEvL5tSbMwrYrQHKVmTki9DQXq1d/yHQ40dxN0ll3ZgbCsdB5UfO8kNAclnuv5
    janyKKTwDrH0FKa8PoxAUXMsrqSs9UzTBuDnbFX2hnhORKm8rUI7DbsRbtyLC0LI
    x7jznva4GMRNteZE1yYtKXPAyEb7dxQB0Z4IplzWacXIgO3US6vgWZ9vPhOplHpr
    1K9hbRFNzhaV92HQl14/Wogk19FXj/qZB1KY3UN6s0rMZ/jvI0MsZg/obJQ28PEy
    RYlHf+AfTtJkD+4jxQmyg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCfo5PPid87WJX790jIyr1Xb9R1xwi3+0/EYHsEgjLeqe0tvMigWv9gAdxlI1CQ1eSe061EGbB69TwRp55J1EQ+npQHgLzaDR+dqGrWWO5/ioxfrC1rm
    nj7kV2MeV3SZugIqvFn0M4KDjpfWEHIrJ6BUgLxoIN8EavnMPY+sIWRSgYzIOV/yzR88iCRi1FLk+xFBBs8sB695CY4qln49kFSuNjaH9TXNMNxxir8CCCMh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-KG_OBUHnIVKuRwLwd8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeE3O32 (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 10:29:28 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36208 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751561AbeE3O3R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 May 2018 10:29:17 -0400
Date: Wed, 30 May 2018 10:29:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        <andrea.parri@amarulasolutions.com>,
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
In-Reply-To: <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1805301009340.1502-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 29 May 2018, Linus Torvalds wrote:

> On Tue, May 29, 2018 at 3:49 PM Alan Stern <stern@rowland.harvard.edu>
> wrote:
> 
> > Putting this into herd would be extremely difficult, if not impossible,
> > because it involves analyzing code that was not executed.
> 
> Does it?
> 
> Can't we simplify the whole sequence as basically
> 
>      A
>      if (!B)
>          D
> 
> for that "not B" case, and just think about that. IOW, let's ignore the
> whole "not executed" code.

Your listing is slightly misleading.  It really should be:

	A
	if (!B)
		; // NOP
	D

In other words, D should be beyond the end of the "if" statement, not 
inside one of the branches.  At run time, of course, it doesn't matter; 
CPUs don't try to detect where the two branches of an "if" recombine.
(Leaving aside issues like implementing an "if" as a move-conditional.)

> If B depends on A like you state, then that already implies that the write
> in D cannot come before the read of A.
> 
> You fundamentally cannot do a conditional write before the read that the
> write condition depends on. So *any* write after a conditional is dependent
> on the read.

Remember, the original code was:

	A
	if (!B)
		C
	D

So the execution of D is _not_ conditional, and it doesn't depend on A 
or B.  (Again, CPUs don't make this distinction, but compilers do.)

> So the existence of C - whether it has a barrier or not - is entirely
> immaterial at run-time.
> 
> Now, the *compiler* can use the whole existence of that memory barrier in C
> to determine whether it can re-order the write to D or not, of course, but
> that's a separate issue, and then the whole "code that isn't executed" is
> not the issue any more. The compiler obviously sees all code, whether
> executing or not.
> 
> Or am I being stupid and missing something entirely? That's possible.

Not at all -- that point about the compiler is exactly what I was
trying to get at.  The object code the compiler generates depends on
the contents of _both_ branches of the "if" statement, even though only
one branch is executed at run time.  Hence an analysis based entirely
on what instructions are executed in a particular run (which is what
herd does) will necessarily be incomplete.

That's what happened here.  The LKMM herd model treats statements
beyond the end of an "if" statement as though the compiler can reorder
them before the start of the "if", unless something in the branch which
was taken prevents this reordering.  But herd ignores the contents of
the untaken branch, even when they would block the reordering.

Alan
