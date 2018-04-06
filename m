Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeDFMSo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:18:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43740 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbeDFMSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:18:43 -0400
Date: Fri, 6 Apr 2018 13:18:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound updates for 4.17-rc1
Message-ID: <20180406121832.GX29239@sirena.org.uk>
References: <s5hwoxmdpmu.wl-tiwai@suse.de>
 <CA+55aFxuowsvQyq0+xeq=ganTHqw2uZ6kkZ8DBk0k01cJHUzjA@mail.gmail.com>
 <20180405190441.GC12349@sirena.org.uk>
 <CA+55aFw3B=2NjM2dapxFRU=GYtMJ+Mm=MBVDEp8PNqp9LGz_7Q@mail.gmail.com>
 <20180406011147.GD12349@sirena.org.uk>
 <CA+55aFwZ=GeDXh2Q5LnFD6Kor=e2+ZNChKX=5Mf3Oebw06J9QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwZ=GeDXh2Q5LnFD6Kor=e2+ZNChKX=5Mf3Oebw06J9QA@mail.gmail.com>
X-Cookie: A fool and his money are soon popular.
X-TUID: iNzspeQw6O/g
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 06:31:37PM -0700, Linus Torvalds wrote:
> On Thu, Apr 5, 2018 at 6:11 PM, Mark Brown <broonie@kernel.org> wrote:

[No signature, managed to leave my smartcard at home, sorry :/]

> >>  (3) if you are done and ready with a branch, and it's time to just
> >> say "the development on this branch is all done, now I will ask
> >> upstream to pull it, and I'll merge this into my upstream branch"

> >>      THIS IS NEVER AUTOMATED!

> >>      Sure, you might script it ("I have 35+ branches that I will send
> >> out, I use a script to merge them all together"), but the act of
> >> running that script is not something daily, it's something like "I am
> >> now ready to ask Takashi to take this", so you do it before you do the
> >> pull request to upstream.

> > Hrm, OK.  This I find unclear in that if you're saying it's OK to script
> > the merge of lots of branches I'm having trouble seeing the distinction
> > between that and the test merges you're talking about.

> The distinction is in intent and timing - and resulting history.

> The "merge for release" happens once - when you are ready to send it
> out. The end result is a single merge that brings in the changes to
> the code, and a history that is legible and understandable.

> So if you have 50 branches with new code, and they all have the
> changes you were working on, maybe there's a lot of merges (not
> necessarily 50 of them, since you use octopus merges, but easily ten).

Indeed, that's what my script is doing. 

> But the merges they are are the *only* thing that brings in the new
> code, and when you look at history, the code development within one
> topic branch is nice and linear and there aren't odd other merges in
> the middle.

> That makes it a *lot* easier to follow a certain strand of development
> (namely the strand of your topic branch). There aren't five other
> random merges that pull in the changes part-way through.

Indeed - that's what most of the branches do.  The main cases where
there are merges are "merge up the fixes because it's broken without or
conflicts a lot" and "merge this new API we're about to start using".
Like I said in my last e-mail I can easily write a bit of blurb for
those ones, there's definitely room for improvement there.

> So the "merge for release" is something that has been THOUGHT about.
> Maybe there was scripting simply because there were lots of branches,
> but it was all ready and intentional, and none of it should have been
> merged in some half-way ready state. By definition, the branches you
> merged were *ready*.

> Otherwise you shouldn't have been merging them for an upstream pull
> request at all!

> See?

Honestly not really; to me the end result of doing that without manually
writing some blurb on each branch (and adding some delays and so on) is
going to be identical to that a for test merge as far as someone reading
the history is concerned so I'm no further forwards unless I just have
much fewer branches like I say.  It really feels like the big gap here
is that you see creating branches and merging them as much more
substantial operations than I do, like I said in the prior e-mail I
think a lot of that is coming from other things I've worked with where
merges were more common.

I do already go through a process of thinking about what's in there much
like you describe both before deciding to tag things, and then carry on
doing so as I write the signed tag.  It doesn't usually involve me
rebuilding the merge simply because normally the outcome is that
everything is already fine (that is the goal), and even on the occasions
where I do rebuild I can't see a way to usefully convey that with
automation.  When I look at other people's merge for pull type stuff I'm
not seeing any obvious ideas beyond going down to single branch merges
and it seems like without reducing the number that'd also set off your
alarm bells.

I think I get and agree with what you're saying about the thought
process behind what to send upstream, what I'm not getting is how to
convey it.
