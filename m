Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeEDAa1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:30:27 -0400
Received: from foss.arm.com ([217.140.101.70]:47882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbeEDAaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:30:25 -0400
Date: Thu, 3 May 2018 19:30:23 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jnair@caviumnetworks.com>,
        <Robert.Richter@cavium.com>, <Vadim.Lomovtsev@cavium.com>,
        <Jan.Glauber@cavium.com>, <gklkml16@gmail.com>
Subject: Re: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
Message-Id: <20180503193023.9c27512d6a0e9af85f8c0407@arm.com>
In-Reply-To: <20180501115405.GE25237@arm.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
        <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
        <20180426170624.bfcba885431d57d0de2a3ddd@arm.com>
        <20180427093027.ngtuoezyh6mtz26p@lakrids.cambridge.arm.com>
        <20180427081525.f9dcc756678baf3bb6e6e473@arm.com>
        <20180427143719.GA5093@arm.com>
        <20180427104629.2bff4b4b683a93ddf39f8df5@arm.com>
        <20180427160914.GA5286@arm.com>
        <20180427115625.b5191d381cd41e7ee092fea1@arm.com>
        <20180501115405.GE25237@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2018 12:54:05 +0100
Will Deacon <will.deacon@arm.com> wrote:

> Hi Kim,

Hi Will, thanks for responding.

> On Fri, Apr 27, 2018 at 11:56:25AM -0500, Kim Phillips wrote:
> > On Fri, 27 Apr 2018 17:09:14 +0100
> > Will Deacon <will.deacon@arm.com> wrote:
> > > On Fri, Apr 27, 2018 at 10:46:29AM -0500, Kim Phillips wrote:
> > > > On Fri, 27 Apr 2018 15:37:20 +0100
> > > > Will Deacon <will.deacon@arm.com> wrote:
> > > > > For anything under drivers/perf/, I'd prefer not to have these prints
> > > > > and instead see efforts to improve error reporting via the perf system
> > > > > call interface.
> > > > 
> > > > We'd all prefer that, and for all PMU drivers, why should ones under
> > > > drivers/perf be treated differently?
> > > 
> > > Because they're the ones I maintain...
> > 
> > You represent a minority on your opinion on this matter though.
> 
> I'm not sure that's true

I haven't seen another arch/PMU driver maintainer actively oppose it
other than you (and Mark).

> -- you tend to be the only one raising this issue;

If you're basing that on list activity, I wouldn't, since most Arm perf
users don't subscribe to LKML.  I'm trying to represent current and
future Arm perf users that shouldn't be expected to hang out here on
LKML and review PMU drivers.  Couldn't tell you why PMU driver authors
themselves don't chime in, but will note that some drivers in
drivers/perf do print things from their event_init functions.

Also, you have been cc'd on off-list email threads where SPE users had
to debug the SPE driver's event_init() manually.  There are other SPE
users I know that have had to go through the same painstaking process of
debugging the SPE driver.  Last but not least, there's me, and I'd sure
appreciate more verbose PMU drivers, based on my real-life performance
monitoring experience(s).

> I think most people don't actually care one way or the other. If you know of

Like I said, I think you're limiting your audience to LKML subscribers,
who are more amenable to being convinced they need to debug their
kernel.

> others who care about it too then I suggest you work together as a group to
> solve the problem in a way which is amenable to the upstream maintainers.

I know a few off-list people that would like a more user-friendly Arm
perf experience, but we're not qualified to solve the larger problem
that perf has had since its inception, and I think it's a little unfair
for you to suggest that, esp. given you're one of the maintainers, and
there's Linus on top of you.

> Then you won't have to worry about fixing it personally. You could even
> propose a topic for plumbers if there is enough interest in a general
> framework for propagating error messages to userspace.

I'm not worried about fixing it personally or not.  I'm worried about
our perf users' experience given your objection to using the vehicle
already in use on other architectures and PMU drivers.

If you - or anyone else for that matter - know of a way that'll get us
past this, by all means, say something.

If it helps, I recently asked acme if we could borrow bits from struct
perf_event and got no response.

> > > > As you are already aware, I've personally tried to fix this problem -
> > > > that has existed since before the introduction of the perf tool (I
> > > > consider it a syscall-independent enhanced error interface), multiple
> > > > times, and failed.
> > > 
> > > Why is that my problem? Try harder?
> > 
> > It's your problem because we're here reviewing a patch that happens to
> > fall under your maintainership.  I'll be the first person to tell you
> > I'm obviously incompetent and haven't been able to come up with a
> > solution that is acceptable for everyone up to and including Linus
> > Torvalds.  I'm just noticing a chronic usability problem that can be
> > easily alleviated in the context of this patch review.
> 
> I don't see how incompetence has anything to do with it and, like most

Well you told me to try harder, and I'm trying to let you know that I
can try harder - ad infinitum - and still not get it, so telling me to
try harder isn't going to necessarily resolve the issue.

> people (lucky gits...), I doubt Torvalds cares too deeply about PMU driver
> internals. No arguments on the usability problem, but this ain't the fix

Like acme, I doubt Linus runs perf on real Arm h/w, so yes, I don't
think they care that much, but if they did try to do it one day, I'd
like to that they'd be able to have dmesg contain that extra error
information for them.

As you know, David Howells wrote a supplemental error syscall facility
[1], that Linus nacked (off list no less).  Does Linus care about what
David Howells was developing it for?  I don't know, but he does have
enough experience to know whether a certain approach to a problem is
sustainable in his kernel or not.

> you're looking for: it's a bodge. We've been over this many times before.

I think it's OK - necessary even - until this error infrastructure
problem perf has is fixed, and I think you're being unrealistic if you
think it will be fixed anytime soon.

> > > > So until someone comes up with a solution that works for everyone
> > > > up to and including Linus Torvalds (who hasn't put up a problem
> > > > pulling PMU drivers emitting things to dmesg so far, by the way), this
> > > > keep PMU drivers' errors silent preference of yours is unnecessarily
> > > > impeding people trying to measure system performance on Arm based
> > > > machines - all other archs' maintainers are fine with PMU drivers using
> > > > dmesg.
> > > 
> > > Good for them, although I'm pretty sure that at least the x86 folks are
> > > against this crap too.
> > 
> > Unfortunately, it doesn't affect them nearly as much as it does our
> > more diverse platforms, which is why I don't think they care to do
> > much about it.
> 
> x86 has its fair share of PMUs too, so I don't think we're special in this
> regard. The main difference seems to be that they have better support in
> the perf tool for diagnosing problems.

Indeed, their software is as vertically integrated as their hardware,
and, well, they have more people with more experience working and caring
about perf running and being more usable.

> > > > > Anyway, I think this driver has bigger problems that need addressing.
> > > > 
> > > > To me it represents yet another PMU driver submission - as the years go
> > > > by - that is lacking in the user messaging area.  Which reminds me, can
> > > > you take another look at applying this?:
> > > 
> > > As I said before, I'm not going to take anything that logs above pr_debug
> > > for things that are directly triggerable from userspace. Spin a version
> > 
> > Why?  There are plenty of things that emit stuff into dmesg that are
> > directly triggerable from userspace.  Is it because it upsets fuzzing
> > tests?  How about those be run with a patched kernel that somehow
> > mitigates the printing?
> 
> [we've been over this before]
> There are two camps that might find this information useful:
> 
>   1. People writing userspace support for a new PMU using the
>      perf_event_open syscall
> 
>   2. People trying to use a tool which abstracts the PMU details to some
>      degree (e.g. perf tool)
> 
> Those in (1) can get by with pr_debug. Sure, they have to recompile, but
> it's not like there are many people in this camp and they'll probably be
> working with the PMU driver writer to some degree anyway and taking new
> kernel drops.

No, please, that's a worse user experience than necessary.

FWIW, I see this type of person as e.g., a JIT developer - a
compiler/toolchain person - who has decided to use h/w monitoring to
help the JIT engine find hotspots.  The first place they should start
is to start using the perf tool itself, experimenting with events and
PMUs of interest.  When satisfied, they should clone the parameters
the tool makes to the perf_event_open syscall in their JIT engine.  We
should not be wasting their time forcing them to hack around in the
kernel trying to debug perf driver semantics.

> Those in (2) may not have access to dmesg, absolutely should not be able

I don't think you're being realistic here: we're talking about people
trying to improve performance: They would likely have kptr_restrict ==
0 (unrestricted), so why would they have dmesg_restrict set?  Btw, the
rationale for dmesg_restrict was kernel pointer visibility [2], but now
%Kp hashes addresses before printing them, so it's even less likely to
be used.  Curious, where have you seen dmesg_restrict being set?

> to spam it (since this could hide other important messages), will probably

How will it hide other important messages?  Run a logging daemon?
We're not talking about a lot of messages here: one line per perf
invocation: see e.g. runs in [2].

> struggle to match an internal message from the PMU driver to their
> invocation of the high-level tool and may well be in a multi-user
> environment so will struggle to identify the messages that they are
> responsible for.

Again, I think you're being unrealistic.  My experience - in
multiple performance analysis roles - was that I was always the only
person using the machine at the time, and can easily correlate perf
invocations with dmesg output, particularly if I run 'dmesg -w &' prior
to invoking perf.  In one of those roles, having to mess with the
kernel was almost inconceivable - it literally 'just worked' for
everything else.  I was lucky that I had prior kernel experience in
order to debug the driver and be able find out how to invoke perf.

> What they actually want is for the perf tool to give
> them more information, and dmesg is not the right channel for that, for
> similar reasons.

We'd all like the perf tool to do things better, and dmesg is all we
have for now, and now I'm sounding like I did 1 1/2 years ago.

> > > using pr_debug and I'll queue it.
> > 
> > How about using a ratelimited dev_err variant?
> 
> Nah, I don't want dmesg being parsed by users of perf tool. pr_debug should
> be sufficient for perf tool developers working with a new PMU type.

OK the question was to the ratelimited part, but I think that even
might be the default these days [4].

For reasons (different perceptions?) already mentioned above, I also
don't agree that this has to do with just perf tool developers, and
only when working with a new PMU type.  My main concern is new/future
users to perf on Arm, working with any PMU type - new or old.  If there
is a perf tool-side component to this driver, I don't see it.  Having
said that, I think the owners of this and other PMU drivers should have
a say in what type of experience they want for their users in this
regard...is that fair?

Thanks,

Kim

[1] https://patchwork.kernel.org/patch/9907463/
[2] https://lwn.net/Articles/414813/
[3] https://lkml.org/lkml/2017/11/21/385
[4] https://lwn.net/Articles/693010/
