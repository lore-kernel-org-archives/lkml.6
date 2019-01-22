Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57EDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFDB2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfAVRPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:15:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:51750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728719AbfAVRPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:15:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4942BB08E;
        Tue, 22 Jan 2019 17:15:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ADD861E158D; Tue, 22 Jan 2019 18:15:50 +0100 (CET)
Date:   Tue, 22 Jan 2019 18:15:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Kernel development process (was: [PATCH] fs: ratelimit
 __find_get_block_slow() failure message.)
Message-ID: <20190122171550.GH13149@quack2.suse.cz>
References: <CACT4Y+atyYbmrkyX0n+kvBWOt0OaauQbvrRhpUezaHXce5ZDrA@mail.gmail.com>
 <54b68f21-c8b5-7074-74e0-06e3d7ee4003@i-love.sakura.ne.jp>
 <CACT4Y+ZyP2QGL3ENJZRe8qbiL8SB8yDPHRY-npTzb14+LB05RQ@mail.gmail.com>
 <20190116104308.GC26069@quack2.suse.cz>
 <CACT4Y+akwPNEAiBtd5j6r0M6M7DmXV3kig+bnDL39H7uu44O3Q@mail.gmail.com>
 <CACT4Y+Zn0CyCmKRg3v76gesnAj1i7qaBdzGEzk1ecnwnKSkLaQ@mail.gmail.com>
 <20190116162813.GA5446@kroah.com>
 <CACT4Y+a0=45WTbtyuMOq1y5aHw1W-o7c5t3YFnOPeAfgswTA1g@mail.gmail.com>
 <20190121083737.GA6566@quack2.suse.cz>
 <CACT4Y+a4wq8LRTSq-C-Qw0e5G_zyMTXFiRrtTW1rbK1=W4ajog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a4wq8LRTSq-C-Qw0e5G_zyMTXFiRrtTW1rbK1=W4ajog@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-01-19 16:27:53, Dmitry Vyukov wrote:
> On Mon, Jan 21, 2019 at 9:37 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 17-01-19 14:18:56, Dmitry Vyukov wrote:
> > > On Wed, Jan 16, 2019 at 5:28 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jan 16, 2019 at 12:48:41PM +0100, Dmitry Vyukov wrote:
> > > > > On Wed, Jan 16, 2019 at 12:03 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > I wanted to provide a hash/link to this commit but, wait, you want to
> > > > > say that this patch for a security bugs was mailed, recorded by
> > > > > patchwork, acked by subsystem developer and then dropped on the floor
> > > > > for 3+ years? Doh!
> > > > >
> > > > > https://lore.kernel.org/patchwork/patch/599779/
> > > > >
> > > > > There are known ways how to make this not a thing at all. Like open
> > > > > pull requests on github:
> > > > > https://github.com/google/syzkaller/pulls
> > > > > or, some projects even do own dashboard for this:
> > > > > https://dev.golang.org/reviews
> > > > > because this is important. Especially for new contributors, drive-by
> > > > > improvements, good samaritan fixes, etc.
> > > > >
> > > > > Another example: a bug-fixing patch was lost for 2 years:
> > > > > "Two years ago ;) I don't understand why there were ignored"
> > > > > https://www.spinics.net/lists/linux-mm/msg161351.html
> > > > >
> > > > > Another example: a patch is applied to a subsystem tree and then lost
> > > > > for 6 months:
> > > > > https://patchwork.kernel.org/patch/10339089/
> > > >
> > > > I don't understand the issue here.  Are you saying that sometimes
> > > > patches that have been submitted get dropped?  Yes, that's known, it is
> > > > up to the submitter to verify and ensure that the patch is applied.
> > > > Given our rate of change and the large workload that some maintainers
> > > > have, this is the best that we can do at the moment.
> > > >
> > > > Putting it all in a github dashboard would not scale in the least (other
> > > > projects smaller than us have tried and ended up stopping from doing
> > > > that as it fails horribly).
> > > >
> > > > Yes, we can always do better, but remember that the submitter needs to
> > > > take the time to ensure that their patches are applied.  Heck, I have
> > > > patches submitted months ago that I know the maintainers ignored, and I
> > > > need to remember to send them again.  We put the burden of development
> > > > on the thing that scales, the developer themselves, not the maintainer
> > > > here.
> > > >
> > > > It's the best that we know of how to do at the moment, and we are always
> > > > trying to do better.  Examples of this are where some subsystems are now
> > > > getting multiple maintainers to handle the workload, and that's helping
> > > > a lot.  That doesn't work for all subsystems as not all subsystems can
> > > > even find more than one maintainer who is willing to look at the
> > > > patches.
> > >
> > > The issue here is that patches are lost and "up to the submitter" is
> > > not fully working.
> > > It may be working reasonably well when a developer has an official
> > > assignment at work to do thing X, and then they can't miss/forget
> > > about "is thing X merged yet". But it fails for new contributors,
> > > drive-by improvements, good samaritan fixes, etc. Things that we need
> > > no less than the first category (maybe more).
> > > Machines are always better than humans at such scrupulous tracking
> > > work. So if humans can do it, machines will do even better.
> > > The dashboard definitely needs to be sharded in multiple dimensions.
> > > E.g. "per subsystem", "per assigned reviewer", and even "per author".
> > > Because e.g. how may mine are lost? Only this one or more? How many
> > > yours are lost? Do you know?
> > > I am sure this is doable and beneficial. I don't know why other
> > > projects failed with this, maybe that's something with github. But
> > > there are also codebases that are 100x larger than kernel and do
> > > amount of changes kernel receives in a year in less than a week and
> > > nothing gets lots thanks to scalable processes and automation.
> >
> > Out of curiosity which ones?
> 
> I mean in particular Google codebase [1] but I think Facebook [2],
> Chromium [3], Rust [4], Go processes share lots of the same
> principles. Overall idea is process unification and automation and
> building more complex functions on top of lower-level functions. This
> allows to move very fast at very large scale and at the same time
> preserving very high code quality (as required by and proven by
> continuous delivery).
> 
> I feel that perhaps I failed to explain the larger picture assuming
> that it's common knowledge, but perhaps it's not, so I draw this
> 1-pager diagram how functions build on top of functions and all fit
> together:
> 
> https://docs.google.com/presentation/d/e/2PACX-1vRq2SdmiP-wqUb3Xo2drgn48bw2HbyGqFPP-ebfTfn6eNZkHSRwKZKRBAT6K3E3Ra9IJ218ZqRxvmfG/pub
> (also attached if you prefer a download)

Thanks for drawing this and for the references! I know these things in
principle but the image certainly helps in knowing what your are talking
about exactly.

> The goal is not to say that this is the only true way of doing things
> or that we need all of this, but to show that higher-level nice things
> can't be built without proper lower-level foundation. We all agree on
> few lowest level things (like git and C), which is good and already
> brings tremendous benefits. But it really feels to me that at the
> current kernel scale and fundamentality we need the next layer of
> common building blocks in the process: things like change tracking (in
> particular, patches that can be reliably applied) and tests (that are
> easy to add, discoverer, run locally and on CI). And to really work as
> foundation these things need to be agreed on as being "the solution"
> (e.g. "all kernel changes go through patchwork") rather then "being
> allowed to be used by fragmented groups if they want".

Understood. I guess eventually we may get to something like that but at
least as far as I can observe current efforts, trying to change something
in the kernel development process is like herding cats. You need to offer
big enough bowl of cream ;).

> [1] https://cacm.acm.org/magazines/2016/7/204032-why-google-stores-billions-of-lines-of-code-in-a-single-repository/fulltext
> [2] https://framethink.wordpress.com/2011/01/17/how-facebook-ships-code/
> [3] https://www.youtube.com/watch?v=dIageYT0Vgg
> [4] https://www.chromium.org/developers

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
