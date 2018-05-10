Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966026AbeEJBJo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:09:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51134 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965688AbeEJBJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:09:41 -0400
Date: Wed, 9 May 2018 20:09:37 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        <Vadim.Lomovtsev@cavium.com>, <linux-doc@vger.kernel.org>,
        <gklkml16@gmail.com>, <Jan.Glauber@cavium.com>,
        <linux-kernel@vger.kernel.org>, <Robert.Richter@cavium.com>,
        <jnair@caviumnetworks.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
Message-Id: <20180509200937.c236794eefc6bd7266c0fb86@arm.com>
In-Reply-To: <bb3e3c6f-f4df-a182-c947-10c77c998cd1@arm.com>
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
        <20180503193023.9c27512d6a0e9af85f8c0407@arm.com>
        <bb3e3c6f-f4df-a182-c947-10c77c998cd1@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2018 18:10:44 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> Hi Kim,

Hi Robin,

> On 04/05/18 01:30, Kim Phillips wrote:
> > On Tue, 1 May 2018 12:54:05 +0100
> > Will Deacon <will.deacon@arm.com> wrote:
> >> On Fri, Apr 27, 2018 at 11:56:25AM -0500, Kim Phillips wrote:
> >>> On Fri, 27 Apr 2018 17:09:14 +0100
> >>> Will Deacon <will.deacon@arm.com> wrote:
> >>>> On Fri, Apr 27, 2018 at 10:46:29AM -0500, Kim Phillips wrote:
> >>>>> On Fri, 27 Apr 2018 15:37:20 +0100
> >>>>> Will Deacon <will.deacon@arm.com> wrote:
> >>>>>> For anything under drivers/perf/, I'd prefer not to have these prints
> >>>>>> and instead see efforts to improve error reporting via the perf system
> >>>>>> call interface.
> >>>>>
> >>>>> We'd all prefer that, and for all PMU drivers, why should ones under
> >>>>> drivers/perf be treated differently?
> >>>>
> >>>> Because they're the ones I maintain...
> >>>
> >>> You represent a minority on your opinion on this matter though.
> >>
> >> I'm not sure that's true
> > 
> > I haven't seen another arch/PMU driver maintainer actively oppose it
> > other than you (and Mark).
> > 
> >> -- you tend to be the only one raising this issue;
> > 
> > If you're basing that on list activity, I wouldn't, since most Arm perf
> > users don't subscribe to LKML.  I'm trying to represent current and
> > future Arm perf users that shouldn't be expected to hang out here on
> > LKML and review PMU drivers.  Couldn't tell you why PMU driver authors
> > themselves don't chime in, but will note that some drivers in
> > drivers/perf do print things from their event_init functions.
> 
> As a PMU driver author who *has* already invested not-inconsiderable 
> time and effort in trying to explain to you the technical issues from a 
> non-maintainer perspective (and is about to do so again), I can't help 
> but feel rather slighted by that comment.

Very sorry!  You're quite right.  I believe I had considered you as a
kernel developer first, and was trying to keep LKML activity affined to
LKML, vs. other activity on other mailing lists.

> > Also, you have been cc'd on off-list email threads where SPE users had
> > to debug the SPE driver's event_init() manually.  There are other SPE
> > users I know that have had to go through the same painstaking process of
> > debugging the SPE driver.  Last but not least, there's me, and I'd sure
> > appreciate more verbose PMU drivers, based on my real-life performance
> > monitoring experience(s).
> > 
> >> I think most people don't actually care one way or the other. If you know of
> > 
> > Like I said, I think you're limiting your audience to LKML subscribers,
> > who are more amenable to being convinced they need to debug their
> > kernel.
> > 
> >> others who care about it too then I suggest you work together as a group to
> >> solve the problem in a way which is amenable to the upstream maintainers.
> > 
> > I know a few off-list people that would like a more user-friendly Arm
> > perf experience, but we're not qualified to solve the larger problem
> > that perf has had since its inception, and I think it's a little unfair
> > for you to suggest that, esp. given you're one of the maintainers, and
> > there's Linus on top of you.
> > 
> >> Then you won't have to worry about fixing it personally. You could even
> >> propose a topic for plumbers if there is enough interest in a general
> >> framework for propagating error messages to userspace.
> > 
> > I'm not worried about fixing it personally or not.  I'm worried about
> > our perf users' experience given your objection to using the vehicle
> > already in use on other architectures and PMU drivers.
> > 
> > If you - or anyone else for that matter - know of a way that'll get us
> > past this, by all means, say something.
> > 
> > If it helps, I recently asked acme if we could borrow bits from struct
> > perf_event and got no response.
> > 
> >>>>> As you are already aware, I've personally tried to fix this problem -
> >>>>> that has existed since before the introduction of the perf tool (I
> >>>>> consider it a syscall-independent enhanced error interface), multiple
> >>>>> times, and failed.
> >>>>
> >>>> Why is that my problem? Try harder?
> >>>
> >>> It's your problem because we're here reviewing a patch that happens to
> >>> fall under your maintainership.  I'll be the first person to tell you
> >>> I'm obviously incompetent and haven't been able to come up with a
> >>> solution that is acceptable for everyone up to and including Linus
> >>> Torvalds.  I'm just noticing a chronic usability problem that can be
> >>> easily alleviated in the context of this patch review.
> >>
> >> I don't see how incompetence has anything to do with it and, like most
> > 
> > Well you told me to try harder, and I'm trying to let you know that I
> > can try harder - ad infinitum - and still not get it, so telling me to
> > try harder isn't going to necessarily resolve the issue.
> > 
> >> people (lucky gits...), I doubt Torvalds cares too deeply about PMU driver
> >> internals. No arguments on the usability problem, but this ain't the fix
> > 
> > Like acme, I doubt Linus runs perf on real Arm h/w, so yes, I don't
> > think they care that much, but if they did try to do it one day, I'd
> > like to that they'd be able to have dmesg contain that extra error
> > information for them.
> > 
> > As you know, David Howells wrote a supplemental error syscall facility
> > [1], that Linus nacked (off list no less).  Does Linus care about what
> > David Howells was developing it for?  I don't know, but he does have
> > enough experience to know whether a certain approach to a problem is
> > sustainable in his kernel or not.
> > 
> >> you're looking for: it's a bodge. We've been over this many times before.
> > 
> > I think it's OK - necessary even - until this error infrastructure
> > problem perf has is fixed, and I think you're being unrealistic if you
> > think it will be fixed anytime soon.
> > 
> >>>>> So until someone comes up with a solution that works for everyone
> >>>>> up to and including Linus Torvalds (who hasn't put up a problem
> >>>>> pulling PMU drivers emitting things to dmesg so far, by the way), this
> >>>>> keep PMU drivers' errors silent preference of yours is unnecessarily
> >>>>> impeding people trying to measure system performance on Arm based
> >>>>> machines - all other archs' maintainers are fine with PMU drivers using
> >>>>> dmesg.
> >>>>
> >>>> Good for them, although I'm pretty sure that at least the x86 folks are
> >>>> against this crap too.
> >>>
> >>> Unfortunately, it doesn't affect them nearly as much as it does our
> >>> more diverse platforms, which is why I don't think they care to do
> >>> much about it.
> >>
> >> x86 has its fair share of PMUs too, so I don't think we're special in this
> >> regard. The main difference seems to be that they have better support in
> >> the perf tool for diagnosing problems.
> > 
> > Indeed, their software is as vertically integrated as their hardware,
> > and, well, they have more people with more experience working and caring
> > about perf running and being more usable.
> 
> I note that uncore_pmu_event_init() and snb_uncore_imc_event_init(), to 
> pick a couple of Intel examples, contain a lot of the same logic to the 
> ARM system PMU drivers you repeatedly request should be more verbose. 
> Now, surely either perf tool already has some magic which somehow makes 
> those routines "user-friendly", in which case there seems no reason that 
> at least any generic event attribute stuff couldn't be applied to ARM 
> PMUs as well; or if not then you could easily send a patch adding 
> "helpful" printk()s to those drivers too and actively solicit the 
> maintainer feedback you lament not having.

Those Intel drivers?  IIRC, those drivers have been developed
historically more in sync with the tool.  I believe early drivers
started out with four simple error cases- each with its own -Evalue -
and as the infrastructure grew, they still enjoyed more-or-less a
one-to-one correspondence between the -Evalue they returned and what
the tool did in response. Periodically the fall-back (retry) code and
message texts get amended as drivers get added.

In the Arm infrastructure, things are generally more 'disabling' to
the user - they'd rather error out instead of be more accommodating
(bit.LITTLE is a good example of this), so we have people copying
others' very strict event_inits that return the most generic -EINVAL
for most things, without trying to see what can be done to (a) either
continue, going "we knew they meant this," or (b) looking at returning
a different -Evalue, and/or eventually printing something to dmesg (in
the case it's pretty clear that the user will have no idea what
esoteric thing happened).

So whilst what you're saying may be true, I care about Arm more, as I
don't see that big an error messaging problem on Intel right now.

> >>>>>> Anyway, I think this driver has bigger problems that need addressing.
> >>>>>
> >>>>> To me it represents yet another PMU driver submission - as the years go
> >>>>> by - that is lacking in the user messaging area.  Which reminds me, can
> >>>>> you take another look at applying this?:
> >>>>
> >>>> As I said before, I'm not going to take anything that logs above pr_debug
> >>>> for things that are directly triggerable from userspace. Spin a version
> >>>
> >>> Why?  There are plenty of things that emit stuff into dmesg that are
> >>> directly triggerable from userspace.  Is it because it upsets fuzzing
> >>> tests?  How about those be run with a patched kernel that somehow
> >>> mitigates the printing?
> >>
> >> [we've been over this before]
> >> There are two camps that might find this information useful:
> >>
> >>    1. People writing userspace support for a new PMU using the
> >>       perf_event_open syscall
> >>
> >>    2. People trying to use a tool which abstracts the PMU details to some
> >>       degree (e.g. perf tool)
> >>
> >> Those in (1) can get by with pr_debug. Sure, they have to recompile, but
> >> it's not like there are many people in this camp and they'll probably be
> >> working with the PMU driver writer to some degree anyway and taking new
> >> kernel drops.
> > 
> > No, please, that's a worse user experience than necessary.
> > 
> > FWIW, I see this type of person as e.g., a JIT developer - a
> > compiler/toolchain person - who has decided to use h/w monitoring to
> > help the JIT engine find hotspots.  The first place they should start
> > is to start using the perf tool itself, experimenting with events and
> > PMUs of interest.  When satisfied, they should clone the parameters
> > the tool makes to the perf_event_open syscall in their JIT engine.  We
> > should not be wasting their time forcing them to hack around in the
> > kernel trying to debug perf driver semantics.
> > 
> >> Those in (2) may not have access to dmesg, absolutely should not be able
> > 
> > I don't think you're being realistic here: we're talking about people
> > trying to improve performance: They would likely have kptr_restrict ==
> > 0 (unrestricted), so why would they have dmesg_restrict set?  Btw, the
> > rationale for dmesg_restrict was kernel pointer visibility [2], but now
> > %Kp hashes addresses before printing them, so it's even less likely to
> > be used.  Curious, where have you seen dmesg_restrict being set?
> > 
> >> to spam it (since this could hide other important messages), will probably
> > 
> > How will it hide other important messages?  Run a logging daemon?
> > We're not talking about a lot of messages here: one line per perf
> > invocation: see e.g. runs in [2].
> 
> Assuming you meant [3], that's a pretty trivial case which doesn't 
> really illustrate the whole scope of the problem.

You're right, they're trivial cases that have trivial messages that
enable the trivial user.  It's not the whole scope of the problem, but
it's a very good start.

> Just for you, I added prints in 4 places where event_init validation 
> returns -EINVAL in my not-yet-upstream SMMUv2 PMU driver. Let's capture 
> a few events on my Juno board to get some arbitrary cross-sections of 
> system-wide I/O activity:
> 
> [root@space-channel-5 ~]# perf stat -e arm_smmu/cycles/ -e 
> arm_smmu/access,tcefcfg=1/ -e arm_smmu/access,tcefcfg=1,smr_id=1/ -e 
> arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/ -e 
> arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/ find /usr > /dev/null
> 
>   Performance counter stats for 'system wide':
> 
>           729128494      arm_smmu/cycles/ 
>                (12.08%)
>           841301489      arm_smmu/cycles/ 
>                (28.10%)
>           834458758      arm_smmu/cycles/ 
>                (23.40%)
>           774373529      arm_smmu/cycles/ 
>                (15.69%)
>          1028501665      arm_smmu/cycles/ 
>                (13.84%)
>                5401      arm_smmu/access,tcefcfg=1/ 
>                 (27.11%)
>                   0      arm_smmu/access,tcefcfg=1/ 
>                 (14.73%)
>                   0      arm_smmu/access,tcefcfg=1/ 
>                 (23.27%)
>                   0      arm_smmu/access,tcefcfg=1/ 
>                 (20.54%)
>              220788      arm_smmu/access,tcefcfg=1/ 
>                 (17.37%)
>                   0      arm_smmu/access,tcefcfg=1,smr_id=1/ 
>                          (28.18%)
>                   0      arm_smmu/access,tcefcfg=1,smr_id=1/ 
>                          (24.10%)
>                   0      arm_smmu/access,tcefcfg=1,smr_id=1/ 
>                          (12.52%)
>                   0      arm_smmu/access,tcefcfg=1,smr_id=1/ 
>                          (16.17%)
>                   0      arm_smmu/access,tcefcfg=1,smr_id=1/ 
>                          (19.71%)
>                   0      arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/ 
>                          (19.68%)
>                   0      arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/ 
>                          (23.69%)
>                   0      arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/ 
>                          (29.15%)
>                   0      arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/ 
>                          (29.19%)
>               12092      arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/ 
>                          (27.70%)
>                   0      arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/ 
>                          (16.97%)
>                   0      arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/ 
>                          (13.36%)
>                   0      arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/ 
>                          (16.01%)
>                   0      arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/ 
>                          (24.70%)
>                   0      arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/ 
>                          (28.39%)
> 
>         2.315150449 seconds time elapsed
> 
> 
> Wonderful, it worked OK. And yet in that brief time it spammed 
> *sixty-one* lines to the kernel log:
> 
> [ 2096.220934] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.226893] event_source arm_smmu_1: Incompatible filtering mode
> [ 2096.232852] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.238798] event_source arm_smmu_1: Incompatible filtering mode
> [ 2096.244744] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.250690] event_source arm_smmu_4: Incompatible filtering mode
> [ 2096.256641] event_source arm_smmu_2: Incompatible filtering mode
> [ 2096.262594] event_source arm_smmu_0: Incompatible filtering mode
> [ 2096.268546] event_source arm_smmu_1: Incompatible filtering mode
> [ 2096.274492] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.280437] event_source arm_smmu_4: Incompatible filtering mode
> [ 2096.286381] event_source arm_smmu_2: Incompatible filtering mode
> [ 2096.292326] event_source arm_smmu_0: Incompatible filtering mode
> [ 2096.298271] event_source arm_smmu_1: Incompatible filtering mode
> [ 2096.304215] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.310164] event_source arm_smmu_4: Incompatible filtering mode
> [ 2096.316109] event_source arm_smmu_2: Incompatible filtering mode
> [ 2096.322053] event_source arm_smmu_0: Incompatible filtering mode
> [ 2096.327997] event_source arm_smmu_1: Incompatible filtering mode
> [ 2096.333941] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.339887] event_source arm_smmu_3: Incompatible SMR value
> [ 2096.345408] event_source arm_smmu_1: Incompatible filtering mode
> [ 2096.351361] event_source arm_smmu_4: Incompatible filtering mode
> [ 2096.357313] event_source arm_smmu_2: Incompatible filtering mode
> [ 2096.363263] event_source arm_smmu_0: Incompatible filtering mode
> [ 2096.369214] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.375171] event_source arm_smmu_1: Incompatible filtering mode
> [ 2096.381124] event_source arm_smmu_4: Incompatible filtering mode
> [ 2096.387078] event_source arm_smmu_2: Incompatible filtering mode
> [ 2096.393029] event_source arm_smmu_0: Incompatible filtering mode
> [ 2096.398984] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.404936] event_source arm_smmu_1: Incompatible filtering mode
> [ 2096.410890] event_source arm_smmu_4: Incompatible filtering mode
> [ 2096.416840] event_source arm_smmu_4: Incompatible context bank index
> [ 2096.423130] event_source arm_smmu_2: Incompatible filtering mode
> [ 2096.429075] event_source arm_smmu_0: Incompatible filtering mode
> [ 2096.435019] event_source arm_smmu_1: Incompatible context bank index
> [ 2096.441308] event_source arm_smmu_3: Incompatible context bank index
> [ 2096.447611] event_source arm_smmu_4: Incompatible filtering mode
> [ 2096.453557] event_source arm_smmu_2: Incompatible filtering mode
> [ 2096.459501] event_source arm_smmu_0: Incompatible filtering mode
> [ 2096.465445] event_source arm_smmu_1: Incompatible filtering mode
> [ 2096.471390] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.477342] event_source arm_smmu_4: Incompatible filtering mode
> [ 2096.483286] event_source arm_smmu_2: Incompatible SMR value
> [ 2096.488800] event_source arm_smmu_0: Incompatible SMR value
> [ 2096.494316] event_source arm_smmu_2: Incompatible filtering mode
> [ 2096.500319] event_source arm_smmu_0: Incompatible filtering mode
> [ 2096.571799] event_source arm_smmu_1: Incompatible filtering mode
> [ 2096.577749] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.583705] event_source arm_smmu_4: Incompatible SMR value
> [ 2096.589221] event_source arm_smmu_2: Incompatible SMR value
> [ 2096.594736] event_source arm_smmu_0: Incompatible SMR value
> [ 2096.600256] event_source arm_smmu_1: Incompatible SMR value
> [ 2096.605770] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.611718] event_source arm_smmu_4: Incompatible filtering mode
> [ 2096.617663] event_source arm_smmu_2: Incompatible filtering mode
> [ 2096.623607] event_source arm_smmu_0: Incompatible filtering mode
> [ 2096.629550] event_source arm_smmu_1: Incompatible filtering mode
> [ 2096.635494] event_source arm_smmu_3: Incompatible filtering mode
> [ 2096.641443] event_source arm_smmu_4: Incompatible context bank index
> 
> (and in case it's not clear, that output is *continual* during the perf 
> run; empirically, the runtime only needs to reach about 6 seconds or so 
> for the dmesg ringbuffer to wrap so I have to fall back to journalctl to 
> see what I missed)
> 
> Now how about we try counting those exact same events a slightly 
> different way:
> 
> [root@space-channel-5 ~]# perf stat -e 
> \{arm_smmu/cycles/,arm_smmu/access,tcefcfg=1/,arm_smmu/access,tcefcfg=1,smr_id=1/,arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/,arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/\} 
> find /usr > /dev/null
> 
>   Performance counter stats for 'system wide':
> 
>       <not counted>      arm_smmu/cycles/ 
> 
>     <not supported>      arm_smmu/cycles/ 
> 
>     <not supported>      arm_smmu/cycles/ 
> 
>     <not supported>      arm_smmu/cycles/ 
> 
>     <not supported>      arm_smmu/cycles/ 
> 
>     <not supported>      arm_smmu/access,tcefcfg=1/ 
> 
>     <not supported>      arm_smmu/access,tcefcfg=1/ 
> 
>     <not supported>      arm_smmu/access,tcefcfg=1/ 
> 
>     <not supported>      arm_smmu/access,tcefcfg=1/ 
> 
>     <not supported>      arm_smmu/access,tcefcfg=1/ 
> 
>     <not supported>      arm_smmu/access,tcefcfg=1,smr_id=1/ 
> 
>     <not supported>      arm_smmu/access,tcefcfg=1,smr_id=1/ 
> 
>     <not supported>      arm_smmu/access,tcefcfg=1,smr_id=1/ 
> 
>     <not supported>      arm_smmu/access,tcefcfg=1,smr_id=1/ 
> 
>     <not supported>      arm_smmu/access,tcefcfg=1,smr_id=1/ 
> 
>     <not supported>      arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/ 
> 
>     <not supported>      arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/ 
> 
>     <not supported>      arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/ 
> 
>     <not supported>      arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/ 
> 
>     <not supported>      arm_smmu/tlb_alloc,tcefcfg=2,ndx=0/ 
> 
>     <not supported>      arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/ 
> 
>     <not supported>      arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/ 
> 
>     <not supported>      arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/ 
> 
>     <not supported>      arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/ 
> 
>     <not supported>      arm_smmu/tlb_alloc,tcefcfg=2,ndx=1/ 
> 
> 
>         0.721310193 seconds time elapsed
> 
> 
> Oh, that didn't work. Let's check dmesg to see why:
> 
> [ 2416.494951] event_source arm_smmu_3: Incompatible filtering mode
> [ 2416.500933] event_source arm_smmu_3: Incompatible filtering mode
> [ 2416.506958] event_source arm_smmu_3: Incompatible filtering mode
> [ 2416.513276] event_source arm_smmu_3: Incompatible filtering mode
> 
> 
> Well, it said the same thing continually when it worked correctly, so I 
> guess it must have failed for some other reason. As the user I'm now not 
> only confused but unknowingly heading towards the *wrong* conclusion 
> thanks to those "helpful" messages. And that's not even contemplating 
> the "what if multiple programs did this at the same time" case.

Like I said in other threads, multiple invocations aren't a concern vs.
experimenting with multiple atomic invocations to get the pattern of
events and their parameters down to a valid, successfully executing
(hopefully without dmesg output?) state.

WRT the rest of what you say above, I'd have to check the individual
error condition details, but yes, you're right to think the user's
confused, but - and forgive the pun here - armed with the information
coming from the driver, they are able to adapt and learn to know what's
possible and what's not when combining different event groups.

The volume of messaging doesn't concern me much either:

- it doesn't change with dev_dbg vs. dev_warn
- using a logger to scroll far back isn't generally a problem
- users tend to focus on one event at a time when experimenting before
composing and invoking the final event list.

> >> struggle to match an internal message from the PMU driver to their
> >> invocation of the high-level tool and may well be in a multi-user
> >> environment so will struggle to identify the messages that they are
> >> responsible for.
> > 
> > Again, I think you're being unrealistic.  My experience - in
> > multiple performance analysis roles - was that I was always the only
> > person using the machine at the time, and can easily correlate perf
> > invocations with dmesg output, particularly if I run 'dmesg -w &' prior
> > to invoking perf.  In one of those roles, having to mess with the
> > kernel was almost inconceivable - it literally 'just worked' for
> > everything else.  I was lucky that I had prior kernel experience in
> > order to debug the driver and be able find out how to invoke perf.
> > 
> >> What they actually want is for the perf tool to give
> >> them more information, and dmesg is not the right channel for that, for
> >> similar reasons.
> > 
> > We'd all like the perf tool to do things better, and dmesg is all we
> > have for now, and now I'm sounding like I did 1 1/2 years ago.
> > 
> >>>> using pr_debug and I'll queue it.
> >>>
> >>> How about using a ratelimited dev_err variant?
> >>
> >> Nah, I don't want dmesg being parsed by users of perf tool. pr_debug should
> >> be sufficient for perf tool developers working with a new PMU type.
> > 
> > OK the question was to the ratelimited part, but I think that even
> > might be the default these days [4].
> > 
> > For reasons (different perceptions?) already mentioned above, I also
> > don't agree that this has to do with just perf tool developers, and
> > only when working with a new PMU type.  My main concern is new/future
> > users to perf on Arm, working with any PMU type - new or old.  If there
> > is a perf tool-side component to this driver, I don't see it.  Having
> > said that, I think the owners of this and other PMU drivers should have
> > a say in what type of experience they want for their users in this
> > regard...is that fair?
> 
> As I've said before, a significant portion of what you want to improve 
> involves generic perf_event properties which would already be much 
> better validated in the core than by every driver individually, so the 
> first straightforward step would be to improve the interface between 
> drivers and perf core, such that the "hard" problem reduces to 
> communicating from a single part of perf core to userspace. As it is, 
> PMU drivers alone simply don't have enough context to know when an 
> event_init "failure" is actually significant to the user or not, thus if 
> they display user-visible messages directly then half the time the user 
> will be thoroughly misled unless they are intimately familiar with how 
> perf core grouping and event rotation work (see above), yet required 
> knowledge of perf internals is exactly what you're arguing against!

You're right, perf is inherently confusing to use, but more information
is better than none, esp. for the trivial cases.

Thanks,

Kim
