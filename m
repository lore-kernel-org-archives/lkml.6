Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B79C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED88218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MvidC4xx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfAYQAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:00:16 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:42208 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAYQAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:00:16 -0500
Received: by mail-io1-f52.google.com with SMTP id x6so8095423ioa.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 08:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKEIV/JkkIR3TnGFFktIu2EklMJrZJo3GLe9IIoBhbo=;
        b=MvidC4xxW/nHfMaadhj3gyVdsgCpGU6seR1rl3j/QrfNQueaoVyAS2QRtqJwGZsx8V
         PjzjmtR00IEhJQHAbpuHCIDBWnlPlAO5endR5crAvmNymyWM64mRFiJqjECLhywdR8ib
         SfgWdceMS/PHyEM6Ifl6Rh414viM2Z/fg4Zwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKEIV/JkkIR3TnGFFktIu2EklMJrZJo3GLe9IIoBhbo=;
        b=jp/tio6mplaKyQuOytcsABcVJEjPbyETf2Sz1YhYqsSaBEhO9b7nXKGbhkcy90q9fG
         DTO9jpa3xd6Ffm8ur0YSsTwnLXI17R8uS7eUp6/+Vo42olIAUFvoazPjzsb31ELl46qq
         2b8OEs6KGNCUNAO850/UjF9ErgopcLUaQ9SsYL3JGlVv6CLQ00YB1Z2hV6gBAmOxJ/er
         LnHGFTP/p3i9mbPgbxUIVSGPOAudImibaQ2Arv4E/e+MJN5Ji2oDRCc7/7MwNj+cxOqN
         5Vf6C3s8/vxP8EjI4XO3dScgu3XzFsJHZJYTLagtE/G/gEjrDKQGISYCgX6qg87Ucimz
         Rtqw==
X-Gm-Message-State: AJcUukdKhPwBFJLLndr6OP7/B41sbekB30P0CrGoer2kwMuUctklywnu
        HZTgbAOw/RgX26hWzxArlNTLa5nxw6THrhyx4V11zg==
X-Google-Smtp-Source: ALg8bN5eKuLyGex8hilNXgRCAgH4CBbSykYWBk/8Dmdp9+b+/k73past4C2WunX603ztyoIx1HiFzILibggv55HDkYk=
X-Received: by 2002:a5e:d503:: with SMTP id e3mr7903513iom.291.1548432014361;
 Fri, 25 Jan 2019 08:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
 <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
 <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com>
 <CAOesGMg-_K_KJFtxyZJFbM+p1N5UfeUwvXmxkj+DRtNSj7Bosw@mail.gmail.com>
 <20190123232052.GD1257@redhat.com> <CAOesGMhU6wzX=sBC0iqDrzBYinP8POp=9-d4oEQoaNee-dU1zQ@mail.gmail.com>
 <20190123234817.GE1257@redhat.com> <CAKMK7uHPNPJGxyHt46wwNGwdoZkLez9Cf7hAZ1sXh8=w56OUOQ@mail.gmail.com>
 <CAFCwf10fvFAXQCGXpJHdf2bBOEJ9ZXZvoUgH9JWbNOtnmELBmg@mail.gmail.com>
 <CAPM=9twdfFSevH-qq7Vf1F7-nAgYvAw9XYmEKT-8LYBc403Thw@mail.gmail.com>
 <CAOesGMh2CPrBn57b2H51+wVRtW0Y3SFpTOMGSSc4ombMkVLGNQ@mail.gmail.com>
 <CAKMK7uHb2SRBnsNniV4SPHhe-XB+CsWkt0DjE9-vu1t_eJAWxg@mail.gmail.com> <CAOesGMhZ9w9AAPXAir=JC5VpAFXcHUrRWi10tXG07ZyFPiE8JQ@mail.gmail.com>
In-Reply-To: <CAOesGMhZ9w9AAPXAir=JC5VpAFXcHUrRWi10tXG07ZyFPiE8JQ@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 25 Jan 2019 17:00:02 +0100
Message-ID: <CAKMK7uGURTpFPdt1YkaOTJ31K3RbCurA-J9RbUh8XBgFRzMc7g@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Olof Johansson <olof@lixom.net>
Cc:     Dave Airlie <airlied@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, fbarrat@linux.ibm.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 4:02 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Thu, Jan 24, 2019 at 11:43 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > On Fri, Jan 25, 2019 at 1:14 AM Olof Johansson <olof@lixom.net> wrote:
> > >
> > > On Thu, Jan 24, 2019 at 2:23 AM Dave Airlie <airlied@gmail.com> wrote:
> > > >
> > > > > I know I won't be able to convince you but I want to say that I think
> > > > > your arguments for full userspace open source are not really
> > > > > technical.
> > > >
> > > > There is more to keeping a kernel going than technical argument unfortunately.
> > > >
> > > > I guess the question for Greg, Olof etc, is do we care about Linux the
> > > > kernel, or Linux the open source ecosystem, if the former, these sort
> > > > of accelerator shim drivers are fine, useless to anyone who doesn't
> > > > have all the magic hidden userspace, and impossible to support for
> > > > anyone else, if the latter, we should leave the cost of maintenance to
> > > > the company benefiting from it and leave maintaining it out of tree.
> > >
> > > As mentioned in my reply to Daniel, I think we've got a history of
> > > being pragmatic and finding reasonable trade-offs of what can be open
> > > and what can be closed. For example, if truly care about open source
> > > ecosystem, drivers that require closed firmware should also be
> > > refused.
> >
> > Firmware has traditionally been different since usually it's looked
> > down, doesn't do much wrt functionality (dumb fifo scheduling at best,
> > not really power management) and so could be reasonably shrugged off
> > as "it's part of hw". If you care about the open graphics ecosystem,
> > i.e. your ability to port the stack to new cpu architectures, new
> > window systems (e.g. android -> xorg, or xorg -> android, or something
> > entirely new like wayland), new, more efficient client interface
> > (vulkan is a very new fad), then having a closed firmware is not going
> > to be a problem. Closed compiler, closed runtime, closed anything else
> > otoh is a serious practical pain.
> >
> > Unfortunately hw vendors seem to have realized that we (overall
> > community of customers, distro, upstream) are not insisting on open
> > firmware, so they're moving a lot of "valuable sauce" (no really, it's
> > not) into the firmware. PM governors, cpu scheduling algorithms, that
> > kind of stuff. We're not pleased, and there's lots of people doing the
> > behind the scenes work to fix it. One practical problem is that even
> > if we've demonstrated that r/e'ing a uc is no bigger challenge than
> > anything, there's usually this pesky issue with signatures. So we
> > can't force the vendors like we can with the userspace side. Otherwise
> > nouveau would have completely open firmware even for latest chips
> > (like it has for olders).
> >
> > > > Simple question like If I plug your accelerator into Power or ARM64,
> > > > where do I get the port of your userspace to use it?
> > >
> > > Does demanding complete open userspace get us closer to that goal in
> > > reality? By refusing to work with people to enable their hardware,
> > > they will still ship their platforms out of tree, using DKMS and all
> > > the other ways of getting kernel modules installed to talk to the
> > > hardware. And we'd be no closer.
> > >
> > > In the end, they'd open up their userspace when there's business
> > > reasons to do so. It's well-known how to work around refusal from us
> > > to merge drivers by now, so it's not much leverage in that area.
> >
> > Correct. None of the hw vendors had a business reason to open source
> > anything unforunately. Yes, eventually customers started demanding
> > open source and treatening to buy the competition, but this only works
> > if you have multiple reasonably performant & conformant stacks for
> > different vendors. The only way to get these is to reverse engineer
> > them.
>
> That's the grass-roots version of it, and it is indeed a lot of work.
> What _has_ proven to have success is when companies that would drive
> real revenue for the vendors have requirements for them to open up,
> contribute, and participate. In the graphics world it hasn't gotten
> things all the way to the right spot, but I know first hand that for
> example Chrome OS's insistence on upstream participation has made
> significant differences in how several companies interact with our
> communities.
>
> It's not something that's easy to do when the target is
> consumer-oriented hardware (which graphics mostly is), but at least
> for now, these accelerators aren't targeting end users as much as
> corporate environments, where we do have allies.

Cros is the only reason we do have the stack we do in graphics.
They've been investing ridiculous amounts of money into this, and they
actually invest even more now than 1-2 years ago. I know for a fact
that without cros a few of the open stacks would have substantially,
if not completely, closed down again. If you don't believe that, look
at how debian treats the latest intel libva driver as partially
non-free (because it's become that).

> > Now reverse-engineering is a major pain in itself (despite all the
> > great tooling gpu folks developed over the past 10 years to convert it
> > from a black art to a repeatable engineering excercise), but if you
> > additionally prefer the vendors closed stack (which you do by allowing
> > to get them to get merged) the r/e'd stack has no chance. And there is
> > not other way to get your open source stack. I can't really go into
> > all the details of the past 15+ of open source gpus, but without the
> > pressure of other r/e'ed stacks and the pressure of having stacks for
> > competitiors (all made possible through aggressive code sharing) we
> > would have 0 open source gfx stacks. All the ones we have either got
> > started with r/e first (and eventually the vendor jumped on board) or
> > survived through r/e and customer efforts (because the vendor planned
> > to abandon it). Another part of this is that we accept userspace only
> > when it's the common upstream (if there is one), to prevent vendors
> > closing down their stacks gradually.
> >
> > So yeah I think by not clearly preferring open source over
> > stacks-with-blobs (how radically you do that is a bit a balance act in
> > the end, I think we've maxed out in drivers/gpu on what's practically
> > possible) you'll just make sure that there's never going to be a
> > serious open source stack.
>
> I can confidently say that I would myself clearly give preferential
> treatment to open stacks when they show up. The trick is how we get
> there -- do we get there quicker by refusing to work with the
> partially closed stacks? My viewpoint is that we don't, and that the
> best way to get there is to bring them in and start working with what
> we have instead of building separate camps that we later need to
> figure out how to move.
>
> > > > I'm not the final arbiter on this sort of thing, but I'm definitely
> > > > going to make sure that anyone who lands this code is explicit in
> > > > ignoring any experience we've had in this area and in the future will
> > > > gladly accept "I told you so" :-)
> > >
> > > There's only one final arbiter on any inclusion to code to the kernel,
> > > but we tend to sort out most disagreements without going all the way
> > > there.
> > >
> > > I still think engaging has a better chance of success than rejecting
> > > the contributions, especially with clear expectations w.r.t. continued
> > > engagement and no second implementations over time. In all honestly,
> > > either approach might fail miserably.
> >
> > This is maybe not clear, but we still work together with the blob
> > folks as much as possible, for demonstration: nvidia sponsored XDC
> > this year, and nvidia engineers have been regularly presenting there.
> > Collaboration happens around the driver interfaces, like loaders (in
> > userspace), buffer sharing, synchronization, negotiation of buffer
> > formats and all that stuff. Do as much enganging as possible, but if
> > you give preferrential treatment to the closed stacks over the open
> > ones (and by default the vendor _always_ gives you a closed stack, or
> > as closed as possible, there's just no business case for them to open
> > up without a customer demanding it and competition providing it too),
> > you will end up with a closed stack for a very long time, maybe
> > forever.
> >
> > Even if you insist on an open stack it's going to take years, since
> > the only way to get there is lots of r/e, and you need to have at
> > least 2 stacks or otherwise the customers can't walk away from the
> > negotiation table. So again from gfx experience: The only way to get
> > open stacks is solid competition by open stacks, and customers/distros
> > investing ridiculous amounts of money to r/e the chips and write these
> > open&cross vendor stacks. The business case for vendors to open source
> > their stacks is just not there. Not until they can't sell their chips
> > any other way anymore (nvidia will embrace open stacks as soon as
> > their margins evaporate, not a second earlier, like all the others
> > before them). Maybe at the next hallway track we need to go through a
> > few examples of what all happened and is still happening in the
> > background (here's maybe not a good idea).
>
> Again, the graphics world is different since the volume market has
> traditionally been consumers, and the split got very deep. What we
> want to avoid here is to get into the same situation by avoiding the
> large split.
>
> Look at it another way, these are roughly the options and possible outcomes:
>
> 1a. We don't merge these drivers, vendors say "okay then" and open up
> their whole stacks. We merge the drivers. Then we start working
> together on moving to a common base.
> 1b. We don't merge these drivers, the vendors all do their own thing
> and over the next 5 years, we reverse engineer and start to bring in
> second implementations of all their code.
> 2a. We merge these drivers, start close engagement with the vendors,
> collaborate and converge with their next-gen products (possibly move
> first-gen over).
> 2b. We merge these drivers, and vendors still go off on their own and
> do their own thing. We spend the next 5 years reverse engineering and
> move over to open, new drivers even though the first ones are in-tree.
>
> 1a/2a are successful outcomes. I put 1a at very very low probability.
> 2b at medium probability with the right allies in the corporate world.
>
> 1b/2b are partial failure modes with huge effort needed and a
> passionate volunteer base.
>
> Both 1a/2a and 1b/2b have similar amounts of work involved. In other
> words, I don't see how anyone benefits from eliminating (2) as an
> approach, especially since 1a is an unlikely development of events.
>
> And, guess what -- if we do get open stacks early on, and give heavy
> preferential treatment to these, we can push others in that direction
> sooner rather than later, before stacks diverge too far. I just don't
> see how _not_ engaging is going to help here. Even if we do engage,
> the worst possible outcome is still the same as not engaging but a
> good chance for something better.

If you do have allies with big purses (both product buying power and
the willingness & ability to just hire a driver team and create facts
if the vendor doesnt cooperate), then you can directly make option 1a
happen: vendors open their stacks, you merge them (and of course you
start engaging right away). If you don't have that, then you'll have
1b or 2b and will entirely depend upon students and other fools with
too much time to r/e and write your open stack. And for those 1b is
the substantially better option. Only cases where 2a works is if some
team internally in the vendor makes it happen and somehow convinces
management that there's a real market for this (or going to be). But
if that real market (said customer with a big purse and an insistence
on open source) does not materialize, the effort will crumble again
after a few years.

Anyway I don't think we'll convince each other of anything here, so
we'll just see what happens and we have a nice chat in a few years
about this all :-) Maybe if you want someone else still from the
graphics hippies club, perhaps chat with Keith Packard. He's got quite
a bit of experience and has seen even more dumpster fires than Dave,
Jerome or me.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
