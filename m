Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeBIMvB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:51:01 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52481 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeBIMu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:50:59 -0500
X-Google-Smtp-Source: AH8x22453XTg+hQ02nrnRDPLT5ALcGZaKLPRwP130qKcQDKDme67GpLJ2elRLYgoU7z+F0NqVzr9Mg==
Date: Fri, 9 Feb 2018 13:50:51 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, stern@rowland.harvard.edu,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, corbet@lwn.net
Subject: Re: [PATCH 1/2] Documentation/memory-barriers.txt: cross-reference
 "tools/memory-model/"
Message-ID: <20180209125051.GA21678@andrea>
References: <20180203012103.GD3617@linux.vnet.ibm.com>
 <8b4db282-2705-ed96-cf23-b0cdf94bbac8@gmail.com>
 <20180204183708.GA10437@andrea>
 <20180209123100.GY3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209123100.GY3617@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 04:31:00AM -0800, Paul E. McKenney wrote:
> On Sun, Feb 04, 2018 at 07:37:08PM +0100, Andrea Parri wrote:
> > Hi Akira,
> > 
> > On Mon, Feb 05, 2018 at 01:14:10AM +0900, Akira Yokosawa wrote:
> > > Hi Paul,
> > > CC: Andrea
> > > 
> > > This is intentionally off the list, as I was not cc'd in the thread.
> > > If you think it is worthwhile, could you help me join the thread by
> > > forwarding the following part as a reply to your message, plus CC: to me.
> > 
> > [CCing lists and other people]
> > 
> > 
> > > 
> > > On Fri, Feb 02, 2018 at 17:21:03AM -0800, Paul E. McKenney wrote:
> > > > On Fri, Feb 02, 2018 at 10:12:48AM +0100, Andrea Parri wrote:
> > > >> Recent efforts led to the specification of a memory consistency model
> > > >> for the Linux kernel [1], which "can (roughly speaking) be thought of
> > > >> as an automated version of memory-barriers.txt" and which is (in turn)
> > > >> "accompanied by extensive documentation on its use and its design".
> > > >> 
> > > >> Make sure that the (occasional) reader of memory-barriers.txt will be
> > > >> aware of these developments.
> > > >> 
> > > >> [1] https://marc.info/?l=linux-kernel&m=151687290114799&w=2
> > > >> 
> > > >> Signed-off-by: Andrea Parri <parri.andrea@xxxxxxxxx>
> > > > 
> > > > I am inclined to pull in something along these lines, but would like
> > > > some feedback on the wording, especially how "official" we want to
> > > > make the memory model to be.
> > > > 
> > > > Thoughts?
> > > 
> > > The change log of commit e7720af5f9ac ("locking/Documentation: Add disclaimer") says:
> > >     
> > >     It appears people are reading this document as a requirements list for
> > >     building hardware. This is not the intent of this document. Nor is it
> > >     particularly suited for this purpose.
> > >     
> > >     The primary purpose of this document is our collective attempt to define
> > >     a set of primitives that (hopefully) allow us to write correct code on
> > >     the myriad of SMP platforms Linux supports.
> > >     
> > >     Its a definite work in progress as our understanding of these platforms,
> > >     and memory ordering in general, progresses.
> > >     
> > >     Nor does being mentioned in this document mean we think its a
> > >     particularly good idea; the data dependency barrier required by Alpha
> > >     being a prime example. Yes we have it, no you're insane to require it
> > >     when building new hardware.
> > > 
> > > My take on the Linux Kernel memory-consistency model is a supplement of
> > > memory-barriers.txt and the disclaimer also applies to the memory model.
> > > 
> > > > 
> > > > If I don't hear otherwise in a couple of days, I will pull this as is.
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > >> ---
> > > >>  Documentation/memory-barriers.txt | 4 +++-
> > > >>  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >> 
> > > >> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > > >> index a863009849a3b..8cc3f098f4a7d 100644
> > > >> --- a/Documentation/memory-barriers.txt
> > > >> +++ b/Documentation/memory-barriers.txt
> > > >> @@ -17,7 +17,9 @@ meant as a guide to using the various memory barriers provided by Linux, but
> > > >>  in case of any doubt (and there are many) please ask.
> > > >> 
> > > >>  To repeat, this document is not a specification of what Linux expects from
> > > >> -hardware.
> > > >> +hardware.  For such a specification, in the form of a memory consistency
> > > >> +model, and for documentation about its usage and its design, the reader is
> > > >> +referred to "tools/memory-model/".
> > > >> 
> > > 
> > > Adding cross-reference in this way can _weaken_ the message of the disclaimer.
> > 
> > Thank you for your remarks; I do share the same concern.
> > 
> > > What about adding it in the previous sentence as the patch appended bellow?
> > 
> > I do like this idea: I believe that my phrasing (and that "what Linux
> > expects from hardware") may be easily subject to misinterpretation...
> > which your solution can avoid.
> 
> Any objections to Akira's patch below?  (Give or take the usual
> wordsmithing.)
> 
> Andrea, should I interpret your paragraph above ask an Acked-by?

Well, I am among the Signed-off-by: of the patch; it didn't seem too fair
to me to Ack my own patch... ;-) Is the wording sound? other suggestions?

  Andrea


> 
> 							Thanx, Paul
> 
> >   Andrea
> > 
> > 
> > > 
> > > The tag use in the change log may need adjustments. I'm not familiar with the
> > > manner in modifying other persons' patches. Of course, the wording itself can
> > > be improved further.  Any feedback is welcome.
> > > 
> > >      Thanks, Akira
> > > 
> > > >>  The purpose of this document is twofold:
> > > >> 
> > > >> -- 
> > > >> 2.7.4
> > > >> 
> > > 
> > > ----8<-------
> > > From 714e8c4b09acd6e965de116532dce05070b9e636 Mon Sep 17 00:00:00 2001
> > > From: Akira Yokosawa <akiyks@gmail.com>
> > > Date: Mon, 5 Feb 2018 00:28:36 +0900
> > > Subject: [PATCH] Documentation/memory-barriers.txt: cross-reference "tools/memory-model/"
> > > 
> > > Recent efforts led to the specification of a memory consistency model
> > > for the Linux kernel [1], which "can (roughly speaking) be thought of
> > > as an automated version of memory-barriers.txt" and which is (in turn)
> > > "accompanied by extensive documentation on its use and its design".
> > > 
> > > Make sure that the (occasional) reader of memory-barriers.txt will be
> > > aware of these developments.
> > > 
> > > [1] https://marc.info/?l=linux-kernel&m=151687290114799&w=2
> > > 
> > > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > > Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> > > ---
> > >  Documentation/memory-barriers.txt | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > > index 479ecec..975488d 100644
> > > --- a/Documentation/memory-barriers.txt
> > > +++ b/Documentation/memory-barriers.txt
> > > @@ -14,7 +14,9 @@ DISCLAIMER
> > >  This document is not a specification; it is intentionally (for the sake of
> > >  brevity) and unintentionally (due to being human) incomplete. This document is
> > >  meant as a guide to using the various memory barriers provided by Linux, but
> > > -in case of any doubt (and there are many) please ask.
> > > +in case of any doubt (and there are many) please ask. For clarification of such
> > > +doubt, in the form of a memory consistency model, and for documentation about
> > > +its usage and its design, the reader is referred to "tools/memory-model/".
> > >  
> > >  To repeat, this document is not a specification of what Linux expects from
> > >  hardware.
> > > -- 
> > > 2.7.4
> > > 
> > > 
> > > 
> > 
> 
