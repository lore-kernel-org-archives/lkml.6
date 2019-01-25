Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2037CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BEB218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="DFN6RsSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfAYPdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:33:36 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51385 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAYPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:33:36 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so11092629ite.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 07:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnxuO0zInriS8uytZ7mXwH/xwkftDEWcb8plf38/ch4=;
        b=DFN6RsSFdzmY0p8mcPBtIBSBEenEbBgV3a1c4lpyy16qx4dtd+plvsJeVYu3gJCbjj
         zeLrguWqEZlSQQrYGFaszAuWAxwY83UbN6T1HcY7Aq+J6eM6FHNJDKIxMdymTy0H7oqu
         4eqPOENDHQ9N5jXtx4GFF9G1QgGEYTvf1iHb2YMQ0If+8yin5nWmF0Eb2i9fdRjDMCd5
         C+qbbnTgIa4ykU0BVzfRJPGlkB957ILuBvf/hfPdgxKhzU0a05rkhdTqMi0pxfHjgAk6
         mT3TkzeajB8HH7wSa8YGxsjK8zyfdimWG+uiHjmVO3T/lB1hZsHoQtPykNelxB2lOWJh
         8fTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnxuO0zInriS8uytZ7mXwH/xwkftDEWcb8plf38/ch4=;
        b=TXfn7JOT5n6Ye8xyVa7eLXJ72raNvCjgI/xBytg2QVuKKSTHANSddHySWCk9a17U83
         qyMBbIzP8AD94Qdkn9wNhQn1w7DNosVG6u1pnJFfUbhP33eIS1P0KLfilceIwN0MyDNK
         aN56mEihpVkthGRRB5Sm3MY9+iYjXtXpOsjFQnDJPIgsoi3ZaKM4hi8JDDuR/zDv97VV
         8ECN1LH+e6LhWCguDrNc2PitUzkk2SeT4Lo69PCPPw3iY4J89BYc3BHUxdBpJIfK9Mxv
         O/nTf9AVCgCS5QosEdLmIJvRNGyDUqoLqAW++5+842v9aoyMTCzGgqlRDcvPQu5UN7kR
         rQtA==
X-Gm-Message-State: AJcUukdjIcapfrmJuquTUnQAxcuqOgxl725hkf64e8Y2ismDTbbBS7PP
        NC+FR9qaoBCgCD4BrVZFcVq2UNC3CMJszFh1T6+iyQ==
X-Google-Smtp-Source: ALg8bN5a8v09r0nJgCDim5fnuhErJaS2P4mj/Kj77NZNLRZkK03VdiH138TnTg69dL99F53+SM3bUdS7HerP9QtDy9Y=
X-Received: by 2002:a24:2104:: with SMTP id e4mr4164119ita.59.1548430414712;
 Fri, 25 Jan 2019 07:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <20190125073745.GD11891@kroah.com>
In-Reply-To: <20190125073745.GD11891@kroah.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 25 Jan 2019 07:33:23 -0800
Message-ID: <CAOesGMgJUeUMoRXZ98=J8bpfCuZOOMo5pwpVXZX-o-y1dAQsHA@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 24, 2019 at 11:37 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 24, 2019 at 07:57:11AM +1000, Dave Airlie wrote:
> > On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> > > for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> > > Habana Labs since its inception two and a half years ago.
> >
> > Hey Oded,
> >
> > So this creates a driver with a userspace facing API via ioctls.
> > Although this isn't a "GPU" driver we have a rule in the graphics
> > drivers are for accelerators that we don't merge userspace API with an
> > appropriate userspace user.
> >
> > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> >
> > I see nothing in these accelerator drivers that make me think we
> > should be treating them different.
>
> I understand that this is your position on when you accept drivers into
> the DRM layer, as you need to interact with common interfaces and a
> massive userspace stack at the same time.  And that's wonderful, it
> allows you to be able to move both sides of that stack forward without
> removing support for devices that worked on older kernels.
>
> But, that's not really the case with this new driver at all.  We add new
> driver subsystems, and individual drivers, with loads of new ioctls, in
> every new kernel release.  We don't impose on all of them the "your
> userspace code must be open" rule, so why is this new driver somehow
> different from them?
>
> Yes, there is the fun legal issue of "derivative works" when talking
> about a userspace program that is written to only interact with a
> specific kernel driver using a custom api like this one has, and how the
> license of the kernel side (GPLv2) affects the userspace side
> (whatever), but that is something that I leave up to the lawyers who
> like discussing and enforcing such things.
>
> When evaluating this driver (note, I saw it for a few revisions before
> Oded posted it here), all I did was try to make sure that it fit in
> properly with the kernel apis and methods of operations.  Given that
> there are no in-kernel drivers for this type of device, and that it
> really is a pretty small shim layer around the hardware, which means
> that userspace does a lot of the heavy lifting, it is going to be a
> very hardware-specific user/kernel api, and that shows.

I brought this up because there are sort of, if you squint, three-ish
of these already (the OpenCAPI/CAPI ones and now this). Also,
Jonathan's comment about CCIX pieces coming as well.

I've talked to a handful of vendors in this space and more or less all
of them hope that drivers/misc is still a suitable home for their
driver by the time it's ready to post, and I know that if we keep them
there, it'll only be one or two more drivers until we have this
discussion anyway.

That's really why I brought it up now, to get a clear stance on "Yeah,
we know these are all slightly different today, and we're willing to
give them a predictable home for the first while as we figure out
together how things should look". Keep in mind, this space is also
currently a bit of a gold rush, with many people working hard to get
to market with near-zero talk between them.

> Sidenote, this could have almost just been a UIO driver, which would
> have put _ALL_ of the logic in userspace.  At least this way we have a
> chance for the kernel code to be sane and not try to inflict problems on
> the rest of the system.

Yeah, and sharing hardware when you have userspace drivers tends to
need a bunch of synchronization and coordination which leads to taller
(closed?) stacks there. Having resource arbitration and sharing
assisted by the kernel is usually the right thing, and we should
encourage that.

> Going forward, it would be wonderful if we could come up with a unified
> api for how to interact with these types of hardware accelerators, but
> given the newness of this industry, and the vastly different ways people
> are trying to solve the problem, that is going to take a few attempts,
> and many years before we can get there.  Until then, taking drivers like
> this into the kernel tree makes sense as that way all of our users will
> be able to use that hardware, and better yet, the rest of us can learn
> more about how this stuff works so that we can help out with that api
> generation when it happens.

Exactly my viewpoint as well, combined with not pushing vendors
towards nvidia models by default even if they start out separate, and
having a chance to find inroads with them on engineering levels when
they come to us with the drivers.

Absolutely best chance for success is _always_ when we can engage with
the vendor engineers as peers, instead of going up and down the
corporate charts first (you often need to do a bit of both, but having
allies in engineering makes it much easier).

> So for now, I have no objection to taking this type of driver into the
> tree.  Yes, it would be wonderful if we had an open userspace program to
> drive it so that we could actually test and make changes to the api over
> time, but I think that is something that the submitting company needs to
> realize will be better for them to do, as for right now, all of that
> testing and changes are their responsibility.

I do think having requirements of being able to exercise the hardware
is really valuable, and we should consider what a requirement for that
would look like. For the Habana case that could be a separate
low-level library and a test workload on top. For FPGA cases it could
be a well-known reference bitstream with the vendor reference
control/communication path + similar low-level pieces.

> As for what directory the code should live in, I suggested "misc" as
> there was no other universal location, and I hate to see new subsystems
> be created with only one driver, as that's pretty sad.  But it's just a
> name/location, I have no dog in the fight, so I really don't care where
> it ends up in the tree, just as long as it gets merged somewhere :)

I'm usually one to push back against new subsystems too, especially
when I see a framework proposal with just one driver. In this case,
given that we all know more vendors will come along, I think it makes
sense to take the discussion and establish structure now. This should
give some clarity to those who are out there that we haven't seen yet,
and give them a chance to prepare for things such as the low-level
userspace pieces mentioned above.

So I think setting this up now is the right thing to do, we know there
will be more material here and having a common aggregation of it makes
sense.


-Olof
