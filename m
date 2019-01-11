Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EE1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E9420878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfAKV5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:57:19 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44874 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726471AbfAKV5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:57:19 -0500
Received: (qmail 7675 invoked by uid 2102); 11 Jan 2019 16:57:17 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2019 16:57:17 -0500
Date:   Fri, 11 Jan 2019 16:57:17 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <mingo@kernel.org>, <parri.andrea@gmail.com>,
        <will.deacon@arm.com>, <peterz@infradead.org>,
        <boqun.feng@gmail.com>, <npiggin@gmail.com>, <dhowells@redhat.com>,
        <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>,
        <willy@infradead.org>
Subject: Re: [PATCH RFC LKMM 7/7] tools/memory-model: Dynamically check SRCU
 lock-to-unlock matching
In-Reply-To: <20190111214446.GL1215@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1901111654200.1501-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019, Paul E. McKenney wrote:

> On Fri, Jan 11, 2019 at 12:20:45AM +0100, Andrea Parri wrote:
> > > > I'm not all that exited about spreading version requirements in the
> > > > source: we report this requirement in our README, and apparently we
> > > > already struggle to keep this information up-to-date.  So what about
> > > > squashing something like the below (assume that 7.52 will be released
> > > > by the time this patch hit mainline; if this won't be the case, we
> > > > may consider using the development version 7.51+6)? notice that this
> > > > also removes an (obsolete, at this point) comment from lock.cat.
> > > 
> > > Sounds like a very good point to me!
> > > 
> > > Should have pointers in the various files to the README file?  Or maybe
> > > get people used to using scripting that checks versions?  Or maybe
> > > after answering questions for some time, people will get used to
> > > checking versions?
> > 
> > As discussed off-list: I have no strong opinion on this regard, well,
> > except that I think we ought to fix the README, somehow (consider my
> > diff below as a first proposal).  Akira actually preceded me on this
> > and suggested another solution [1].
> > 
> >   Andrea
> > 
> > [1] http://lkml.kernel.org/r/04d15c18-d210-e3da-01e2-483eff135cb7@gmail.com
> 
> My concern with this approach is that it seems to me to implicitly promise
> that herd will provide backwards compatibility, which is a real pain to
> test, let alone to provide.  Yes, the latest version of herd probably
> supports latest mainline, but will five-years-from-now herd work correctly
> on the .bell, .cat, and .def files from current mainline?

The README file can say something along the lines of:

	Herd version 7.52 (later versions may or may not be 
	compatible).  Herd can be downloaded from...

Alan


