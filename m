Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F930C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE0220879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qInd4RAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfAJItd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:49:33 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35297 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfAJItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:49:33 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so15148303itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 00:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXxMNgnNjv1FNbbfO1QjzeRs3wBxDBS9EbQ9kYXKStw=;
        b=qInd4RAq72NcVcx3YwHVvGixfiZgOmngzI69SwijvLIjpVZZqOVtNOjcgFCfl0YP1w
         YDm11Ie7slCqJ0tITog3++EkHtkciZgqFsOVFFhz5tQsqfS04dvswj0ZsJ3LSXurfGMZ
         tdk3mOEtrbAMYOmGY/Ozx1DLgAmpG0+6N8cf0z3DB6JVPzxKnhjt/mI1Xmm69AD8o6mI
         d7yrk1W7s5jvi8hiGwYO2NsAe9aalpsmiyNVd/RofPUTnBbnWSJJDW/ycimoQY8IyquC
         fNqKra9HRkuim8efan8f+AnqLhlQPnbeqCN3EDIVln3+aAjYbHSJK2V4gUJyLUqo6St7
         gJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXxMNgnNjv1FNbbfO1QjzeRs3wBxDBS9EbQ9kYXKStw=;
        b=eNFS26oJ1xjex9VB5S/xilSbXWADGpAPs5xAb4vlLaK6bUwudekq22ya0+/+zovHuX
         ze76Ej4ylhKFBXz+nnSVOzFptSIn6xZPChszs68mcG7i2gKCJP+cSSJCrVUpSeuMzFPG
         MACwJTqHcwJiKOydZRMfQhLir1NtPWNIt7fY3ck9fmoX+3u9NjQGgnov1tjL9bedUYcZ
         1izQTMgo8BTE3FzSe7Wor9QXS5MZkKEeajgdzrBKQTUXr26RjBv9DVceWS7lKyee58+y
         7PnBM1lYHdMOa778K7w1j4IGKzCgpNuR8n6Nsoy8YsOoP2vbVRIE1YO5El0x+jeRB8mS
         OuIA==
X-Gm-Message-State: AJcUukfd8P+0A3JAIb3se4w+9y28Cbsbu0Nrf0n0ANgZdRUpwEtY93DT
        K49SLppoITZ1Ea++X4WencC76FPIyND38FB6eqtrKw==
X-Google-Smtp-Source: ALg8bN5+eU4UQ9WwGX5OTvXZ2x0ZVtwsXxnuoFUvNMUA/olvvYEcKed3EC/WQh/sVMGBUQ70yvyxujKqJX/EHCQlJJE=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr5686968itl.144.1547110171410;
 Thu, 10 Jan 2019 00:49:31 -0800 (PST)
MIME-Version: 1.0
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190109000214.GA5907@andrea> <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
 <20190109112432.GA6351@andrea> <CACT4Y+YAr1XuwAy1qRL678VHZjzsbAQ05o1zoN9ZfC0muYzK8g@mail.gmail.com>
 <20190109121126.GA7141@andrea> <CACT4Y+azpzvjmUTdWj6H4qe4mELx924pGrY_VFZD9Hi+4VMj5g@mail.gmail.com>
 <20190109171053.GY1215@linux.ibm.com>
In-Reply-To: <20190109171053.GY1215@linux.ibm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Jan 2019 09:49:20 +0100
Message-ID: <CACT4Y+ZZYxE5z4_wZ_Na3z6Y-RmhfrHt3y3sQzUcdUuR35Xc_g@mail.gmail.com>
Subject: Re: seqcount usage in xt_replace_table()
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Luc Maranget <luc.maranget@inria.fr>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 6:11 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Wed, Jan 09, 2019 at 01:29:02PM +0100, Dmitry Vyukov wrote:
> > On Wed, Jan 9, 2019 at 1:11 PM Andrea Parri
> > <andrea.parri@amarulasolutions.com> wrote:
> > >
> > > On Wed, Jan 09, 2019 at 12:55:27PM +0100, Dmitry Vyukov wrote:
> > > > On Wed, Jan 9, 2019 at 12:24 PM Andrea Parri
> > > > <andrea.parri@amarulasolutions.com> wrote:
> > > > >
> > > > > On Tue, Jan 08, 2019 at 04:36:46PM -0800, Anatol Pomozov wrote:
> > > > > > Hello
> > > > > >
> > > > > > On Tue, Jan 8, 2019 at 4:02 PM Andrea Parri
> > > > > > <andrea.parri@amarulasolutions.com> wrote:
> > > > > > >
> > > > > > > Hi Anatol,
> > > > > > >
> > > > > > > On Tue, Jan 08, 2019 at 11:33:39AM -0800, Anatol Pomozov wrote:
> > > > > > > > Hello folks,
> > > > > > > >
> > > > > > > > A bit of context what I am doing. I am trying to port KTSAN (Kernel
> > > > > > > > Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
> > > > > > > > and makes sure it is accessed in a thread-safe manner.
> > > > > > >
> > > > > > > Interesting!  FYI, some LKMM's maintainers (Paul included) had and
> > > > > > > continued to have some "fun" discussing topics related to "thread-
> > > > > > > safe memory accesses": I'm sure that they'll be very interested in
> > > > > > > such work of yours and eager to discuss your results.
> > > > > >
> > > > > > Thread Sanitizer is a great tool to find thread-safety issues with
> > > > > > user-space code. The tool been developed by a team of smart people
> > > > > > from Google [1].
> > > > > >
> > > > > > KTSAN is an attempt to bring the same ideas to Linux kernel [2]. A
> > > > > > bunch of work been done there but the project is still at
> > > > > > proof-of-concept point.
> > > > >
> > > > > Yes, I have been aware of these tools since at least  ;-)
> > > > >
> > > > >   https://groups.google.com/forum/#!msg/ktsan/bVZ1c6H2NE0/Dxrw55bfBAAJ
> > > > >
> > > > >
> > > > > >
> > > > > > I am not a part of Google's dynamic tools team. But I've decided to
> > > > > > pick something to do during the New Year holidays so started porting
> > > > > > KTSAN from v4.2 to v4.20. The work is "almost completed" but I need to
> > > > > > fix a few crashes [3].
> > > > >
> > > > > I guess my first reaction would remain
> > > > >
> > > > >   "it's kind of hard (to use an euphemism) to review 7,582 additions
> > > > >   or so for a data race detector without a clear/an accepted (by the
> > > > >   community) notion of data race..."
> > > >
> > > > Tsan's notion of a data race is basically the C/C++'s notion:
> > > > concurrent/unsynchronized non-atomic access in different threads at
> > > > least one of which is a write.
> > >
> > > Yeah, I think that this notion needs to be detailed, discussed,
> > > documented, and discussed again. ;-)
> > >
> > >
> > > > Tremendous (for such a project) benefits of automatic data race
> > > > detection is a good motivation to finally agree on and accept a
> > > > practically useful notion of a data race.
> > >
> > > Agreed.
> >
> > While having a 100% formal definition of a data race upfront would be
> > useful, I don't think this is a hard requirement for deployment of
> > KTSAN. What I think is required is:
> > 1. Agree that the overall direction is right.
> > 2. Agree that we want to enable data race detection and resolve
> > problems as they appear in a practical manner (rather than block whole
> > effort on every small thing).
> > We deployed TSAN in user-space in much larger code bases than kernel,
> > and while we had the C/C++ formal definition of a data race, practical
> > and legacy matters were similar to that of the kernel (lots of legacy
> > code, different opinions, etc). Doing both things in tandem (defining
> > a memory model and deploying a data race detector) can actually have
> > benefits as a race detector may point to under-defined or
> > impractically defined areas, and will otherwise help to validate that
> > the model works and is useful.
> > KTSAN is not fixed as well. We adopted it as we gathered more
> > knowledge and understanding of the kernel. So it's not that we have to
> > commit to something upfront.
>
> In any case, there might well be some differences in approach between
> KTSAN and LKMM due to input size differences:  One would expect LKMM
> to be able to tolerate a more computationally intensive definition as
> a consequence of KTSAN's ability to process much larger code bases.
>
> But I nevertheless believe that it would be good to have these differences
> be a matter of conscious choice rather than a matter of chance.  ;-)
>
> My guess is that LKMM picks its starting point (which might take some
> additional time), then KTSAN critiques it, and then we work out what
> differences should result in a change to one or the other (or both)
> and which differences are inherent in the different workloads that LKMM
> and KTSAN are presented with.
>
> Seem reasonable?

Sounds reasonable.

For seqcounts we currently simply ignore all accesses within the read
section (thus the requirement to dynamically track read sections).
What does LKMM say about seqlocks?
