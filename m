Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70A7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12F520656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfAOPD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:03:28 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:43730 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726077AbfAOPD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:03:27 -0500
Received: (qmail 2365 invoked by uid 2102); 15 Jan 2019 10:03:26 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jan 2019 10:03:26 -0500
Date:   Tue, 15 Jan 2019 10:03:26 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Dmitry Vyukov <dvyukov@google.com>
cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
In-Reply-To: <CACT4Y+bYKPeyURX9K8i_ySEhqJ5OnFP1_=+u9=Y_Y+fYOo_jGQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1901151002040.1408-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019, Dmitry Vyukov wrote:

> On Tue, Jan 15, 2019 at 12:54 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> >
> > On Mon, Jan 14, 2019 at 02:41:49PM -0500, Alan Stern wrote:
> > > The patch below is my first attempt at adapting the Linux Kernel
> > > Memory Model to handle plain accesses (i.e., those which aren't
> > > specially marked as READ_ONCE, WRITE_ONCE, acquire, release,
> > > read-modify-write, or lock accesses).  This work is based on an
> > > initial proposal created by Andrea Parri back in December 2017,
> > > although it has grown a lot since then.
> >
> > Hello, Alan,
> >
> > Good stuff!!!
> >
> > I tried applying this in order to test it against the various litmus
> > tests, but no joy.  Could you please tell me what commit is this patch
> > based on?
> >
> >                                                         Thanx, Paul
> >
> > > The adaptation involves two main aspects: recognizing the ordering
> > > induced by plain accesses and detecting data races.  They are handled
> > > separately.  In fact, the code for figuring out the ordering assumes
> > > there are no data races (the idea being that if a data race is
> > > present then pretty much anything could happen, so there's no point
> > > worrying about it -- obviously this will have to be changed if we want
> > > to cover seqlocks).
> 
> Hi Alan,
> 
> Is there a mailing list dedicated to this effort? Private messages
> tend to lost over time, no archive, not possible to send a link or
> show full history to anybody, etc.

No specific mailing list.  We've been relying on LKML.

> Re seqlocks, strictly saying defining races for seqlocks is not
> necessary. Seqlocks can be expressed without races in C by using
> relaxed atomic loads within the read critical section. We may consider
> this option as well.

That seems like a reasonable approach.

Alan

