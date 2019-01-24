Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309F9C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D044E20854
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="tPWr1a0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfAXXve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:51:34 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38663 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfAXXvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:51:33 -0500
Received: by mail-it1-f195.google.com with SMTP id z20so7243274itc.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 15:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKTE/rf8k0y0wtzVsQoa3HzrYXz9co0/s1NjZkFG5nQ=;
        b=tPWr1a0GbY2DWsb9zmQl6FA1WTa5rzDU3xB4W7L61e2mVeaSs5mlXsknSz34GQBd4c
         8naIApeEQ1nGgyOsPO/g5dkjpHL5xXZV1+V+LRzNgT8pwCbb2mflormr4o+VTFTx1SPt
         kg69NwALUg3lqNbqV3MY3Y77poFjAf0O/Q1v4yzwG5tLumkgtD19szbKHJHPAuSC1oLE
         eQnHspD1c2B57ffMJ/zgXRfoHszaBntSgcNGdVrgJvcsGu9kXuXDPmmJ5N0XA0Xyjz1M
         OUib6pF8p4tUvUZr9V53AG1w1ogZVSWU5fyyJbZ0iRRUqn7PHhUsy4+B1CNq3bi/IQes
         9FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKTE/rf8k0y0wtzVsQoa3HzrYXz9co0/s1NjZkFG5nQ=;
        b=Lb2tmWOeht8oWyFaYvfMIsxpdj7tbPJIUYH8vs3YmKFj6XnSRTEOmbqySPvAD1vPuH
         F1KqX8jeLjc5UBuQrwa0+dQXZGNYuc9C+hnPPotRnoD3rUK6Jq61fjXFJsp+c76kIjm9
         uZGrkdsQ46eFgaLMiTkTYyqyk+wNIxQqW+7vWAsYUohPc+Q4pS+IvImfSVIBdpaMlOrn
         u3gMphnPgpqvJ0a5qYrYhB+C3BwFSnLdXpOrQ+NpuV4c0NA7sPnKvRQWaGabENcbp2K+
         zK0dieGgMaYj3nCcEf/SLUI1Qm/V35xUlp1ERy98XuT4OYundFNIkfOKGHIcDRzaGOd1
         Z+Nw==
X-Gm-Message-State: AJcUukd4O18y/alMqcGXODfFPNgNHryv8Og7qSsmsPVQEUAU9vmjormE
        gmctlF2yMhH86fDhOHa6wSOXnKAszG3iwBMmBFyAHg==
X-Google-Smtp-Source: ALg8bN4KqpWYJ2kg6FtdTVFxPRUDQVLHs7MEwpIRADiAbbd2Pu0Vh8ihLoWL4y2chJTvH0rZTeAwOK8wvCd86yyO45c=
X-Received: by 2002:a02:98d2:: with SMTP id c18mr5309266jak.11.1548373892517;
 Thu, 24 Jan 2019 15:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
 <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
 <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com>
 <CAOesGMg-_K_KJFtxyZJFbM+p1N5UfeUwvXmxkj+DRtNSj7Bosw@mail.gmail.com>
 <20190123232052.GD1257@redhat.com> <CAOesGMhU6wzX=sBC0iqDrzBYinP8POp=9-d4oEQoaNee-dU1zQ@mail.gmail.com>
 <20190123234817.GE1257@redhat.com> <CAKMK7uHPNPJGxyHt46wwNGwdoZkLez9Cf7hAZ1sXh8=w56OUOQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHPNPJGxyHt46wwNGwdoZkLez9Cf7hAZ1sXh8=w56OUOQ@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 24 Jan 2019 15:51:21 -0800
Message-ID: <CAOesGMg7NOW5Zp1Ru6U=eXv3p8d4O+m6RSA-0S656Aw+2hiqpg@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, fbarrat@linux.ibm.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 23, 2019 at 11:36 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> Hi all,
>
> Top post, because new argument.

I'm diving in and replying to this instead of other replies upthread,
since I think it brings up the core of the disagreement.

> There's lots of really good technical arguments for having the
> userspace component of a driver stack that spans both kernel and
> userspace open too. For me, that's not really the important argument.
>
> I care about open source, I'm not interested in blobs (beyond that
> they're useful for reverse engineering). I think the upstream
> community should care about open source, and by and large it very much
> does: We haven't merged ndiswrapper, or the nvidia shim, or anything
> like that to make running blobs in the kernel easier. And at least in
> the case of the one traditional driver subsystem where 90% of the
> driver lives in userspace, we also care about that part being open.

Nobody is talking about merging kernel blobs. I think we're all in
agreement that it's absolutely out of question.

Traditionally, nearly all hardware has had closed firmware as well,
and if anything affects how we are tied down on making kernel-level
changes, this is a big one. What makes userspace different from that
perspective? Why do we have that double standard?

The question is if we're looking to alienate vendors and create a
whole new set of Nvidia-style driver stacks that will grow and grow,
or if we're willing to discuss with them and get them involved now, to
a point where we can come up with a reasonable,
standardized/extensible interface between upper levels of device FW,
through kernel and into low-level userspace. Getting them to separate
out the low-level portions of their software stacks to something that
is open is a medium-term good compromise in this direction (ideally
they might end up sharing this layer too, but that's not on me to
decide). Most of these pieces of hardware work in similar manners; a
stream of commands with data, and a stream of
completions/results/output data.

I'm incredibly impressed by how much of the graphics stack is open,
and how much of it has been reverse engineered for the closed
platforms. But if we have a chance to do it differently here, and in
particular avoid the long cycle of alienating the vendors and
encouraging them to build out-of-tree elaborate stacks for later
reverse engineering and catch-up, I would really like to.

There's currently one large benefit between these drivers and the
graphics space as far as I know; nobody's trying to do unified drivers
between Linux and other OS:es, so the whole "we need a messy shim
layer and a universal driver" situation should be avoidable (and to be
clear, we would not accept such drivers no matter what).

> Anything else is imo just a long-term dis-service to the community of
> customers, other vendors, ... Adapting a famous quote: If you're ok
> with throwing away some long term software freedom for a bit of short
> term hardware support you'll get neither.

The argument here is not "short term hardware support", since that's
not what we're adding (since you need more than the kernel pieces for
that). What we're able to do is collaborate instead of having all
these vendors work out-of-tree on their own with absolutely no
discussions with us at all, and nowhere to share their work without
setting up some new organization (with all the overhead from that). I
think getting people to collaborate in-tree is the best shot we have
at success.

> So if someone propose to merge some open source kernel driver that
> requires piles of closed source userspace to be any use at all, I'm
> just not interested. And if the fpga folks have merged fpga drivers
> without at least a basic (non-optimizing) RTL compiler, then that was
> a grave mistake. That doing this is also technically a bad idea (for
> all the reasons already discussed) is just the icing on the top for
> me.
>
> And to tie this back to the technical discussion, here's a scenario
> that's bound to happen:
> 1. vendor crams their open source driver into upstream, with full blob userspace
> 2. vendor gets bored (runs low on money, accidentally fired the entire
> old team, needs to do more value add, whatever, ...) rewrites the
> entire stack
> 3. vendor crams their new&completely incompatible open source stack
> into upstream
> 4. upstream is now unvoluntarily stuck maintaining 2 drivers for the
> exact same thing, and we can't fix anything of that because if you
> touch one side of the stack without undertstanding the other part
> you're guaranteed to create regressions (yes this is how this works
> with gpu drivers, we've learned this the hard way)
> 5. repeat

This can be avoided, in that we would not allow second completely
separate stacks. We should have a transition point where we don't
allow one-off weird custom drivers in the future, but we don't know
what the shared implementation will look like yet.

We have precedence from the wifi space, where we pushed back and got
vendors to move towards shared interfaces.

> Hence for these technical reasons you'll then end up with a subsystem
> that only the vendor can touch, and hence also the vendor can abandon
> at will. Not like drivers/gpu, where customers, consulting shops,
> students, ... routinely can&do add new features to existing drivers.
>
> This is not a winning move.

It depends on what the goal is. Complete software freedom? I agree,
this might not get us much closer to that (but also not further). And
if that's the goal, we should refuse to merge any driver that doesn't
have open device firmware as well. Why would we have double standards
in this area? Why are we allowing libusb to implement proprietary
userspace drivers?



So, let's loop back to the technical arguments instead.

What we want from a technical goal is to avoid broad proliferation of
completely separate out-of-tree software stacks, and get people to
collaborate and benefit from each others work in ways that we can
still change things over time where we need to from the kernel side.
Is anyone disagreeing with that (technical) goal?

Unless there's disagreement on the goal, where the views differ is on
how to get there -- whether we are better of pretending that this
hardware doesn't exist, and try to come up with some elaborate shared
framework that nobody is using yet, with the hopes that vendors will
move over from their proprietary stack once they've already been
successful in shipping that. Or whether we're better off getting them
engaged with us, picking up their drivers for the early hardware and
we all get exposure to the stacks and keep communication channels open
with clear understanding that we expect this engagement to shift over
time.

Since we're starting fresh here, we can set our own expectations
upfront: No second implementations unless they're onto a shared
framework, and we can even preserve the right to remove hardware
support (treat it as staging drivers) if a vendor disengages and goes
away, or if promises in other areas are broken (such as open low-level
userspace).


-Olof
