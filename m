Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4008273-1527691604-2-13422781345296839746
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527691604; b=N96lLb0IdZZd/B2KoSiOZ3BpUVPUlTGZZocnlVVkUyZKSEGo7V
    WeNKijbRBKnC20y5X/iY2uKmzlqzbvWntsh7+jqIlqn2/t1fVO+R65yeOae07ffr
    hexqysRrjlp3bwLRZLqxHIiR7iYHp0ooJLpqR91uhbaEEdlP5b9oxGgXvBmzPWx1
    4K2TSD+ysf8JAwm9VRKMPN1E+L7iCt0FV6pxyL834IsKU5U7Mv6Vu3qZeHjzd02r
    TvaZ8+umkaV6YGBsaPP7OaSUu7DEAn3hJ+wS7JXCwi5XwgGLHUAWoB1bNCsQP5Aa
    OTmO0mJebh6bkTD97Ki6Z0fcoLDvufDJqiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1527691604; bh=1DjDRd6WCIJ95OXlGizo/jDFEP4FIkq1iBuLv81aaps=; b=X
    pMf6zWYILC/QX5yXLfhg42wHIwHlFFeZOvEUs1ajNKZKqiaaaP1m2fblEF+IjP2B
    FaBK7HIPLC8ee3kYznZJaeG0rnQg6yMELceJqz3lsT0PnGrlQcSOaa2LLKxIEi1Z
    oSWkhJBN01OX7d81n0X3+a/yoVAhn0n6VN+0ghbzEsUUpzOxZQX/5yr/8NsJ90yd
    kkGeles79m9ll/CCSjJeq9ywReaXav4XBmpSzrW3HUjfqvJBymeD6CET90vTfZxK
    GWe3quigXZcW9L8GuDpqySqR6fzI54NZu88Lmo4OUflFzklS30rhv2+X2IvaALKd
    KkWp1Hn4sK7uEl/0HlCXw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfNTv9aqJSeyNMM51MhNbCeLOk+5tLBfN2XqQe6uJvV0YO2XkgAKJLlRz54dNW49urhiZetI8YZ+zmMUW39TQ03rWhk8vf7GqqkaeG2W7C/rB/PuTjojj
    V9OiIIi9X3h8y7FWYYpzGgDdKJcrE61x7lS2W0ctYMoRg+RoUkrrZqozas27cf8beUMW8ImdtAxkAtMSQHNaM6qz/Q/QheJmioITj/gtBs4JwpSP+tMS8/Uq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=keG4ADoblHjc36YmDLoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeE3Oqn (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 10:46:43 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36506 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751191AbeE3Oqm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 May 2018 10:46:42 -0400
Date: Wed, 30 May 2018 10:46:41 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
In-Reply-To: <20180529225321.GQ3803@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1805301035140.1502-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 29 May 2018, Paul E. McKenney wrote:

> On Tue, May 29, 2018 at 04:10:02PM -0500, Linus Torvalds wrote:
> > On Tue, May 29, 2018 at 3:49 PM Alan Stern <stern@rowland.harvard.edu>
> > wrote:
> > 
> > > Putting this into herd would be extremely difficult, if not impossible,
> > > because it involves analyzing code that was not executed.
> 
> One (ugly) way to handle it, assuming we are correct about what it
> happening, would be to place ordering on the other side of the "if"
> that is at least as strong as on the first side.  Probably some example
> that completely breaks this approach, though...
> 
> > Does it?
> > 
> > Can't we simplify the whole sequence as basically
> > 
> >      A
> >      if (!B)
> >          D
> > 
> > for that "not B" case, and just think about that. IOW, let's ignore the
> > whole "not executed" code.
> > 
> > If B depends on A like you state, then that already implies that the write
> > in D cannot come before the read of A.
> > 
> > You fundamentally cannot do a conditional write before the read that the
> > write condition depends on. So *any* write after a conditional is dependent
> > on the read.
> > 
> > So the existence of C - whether it has a barrier or not - is entirely
> > immaterial at run-time.
> > 
> > Now, the *compiler* can use the whole existence of that memory barrier in C
> > to determine whether it can re-order the write to D or not, of course, but
> > that's a separate issue, and then the whole "code that isn't executed" is
> > not the issue any more. The compiler obviously sees all code, whether
> > executing or not.
> > 
> > Or am I being stupid and missing something entirely? That's possible.
> 
> This will take some analysis, both to make sure that I got Roman's
> example correct and to get to the bottom of exactly what LKMM thinks
> can be reordered.  I am shifting timezones eastward, so I am not going
> to dig into it today.
> 
> But here are a couple of things that take some getting used to:
> 
> 1.	The "if (r1 == x)" would likely be "if (r1 == &x)" in the Linux
> 	kernel.
> 
> 2.	Unless there is something explicit stopping the reordering, the
> 	herd tool assumes that the compiler can reorder unrelated code
> 	completely across the entirety of an "if" statement.  It might
> 	well have decided that it could do so in this case, due to the
> 	fact that the "if" statement isn't doing anything with x (just
> 	with its address).
> 
> 	But yes, given that r1 comes from the load from *c, it would
> 	be difficult (at best) to actually apply that optimization in
> 	this case.
> 
> But let's find out what is really happening.  Easy to speculate, but
> much harder to speculate correctly.  ;-)

What's really happening is that herd doesn't realize the load from *c
must execute before the store to x (as in your 2 above).  You can see
this if you add the following to linux-kernel.cat:

let prop2 = ((prop \ id) & int)

and then run the modified litmus test through herd with "-show prop
-doshow prop2 -gv".  The output graph has a prop2 link from the store
to x leading back to the load from c, indicating that in this
execution, the store must execute before the load.

Alan
