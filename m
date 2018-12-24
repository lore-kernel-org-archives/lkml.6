Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993DEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD652173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545648852;
	bh=3qbLk7RPwBtFoZfU67uPEWWCetuTCgF0l/cjnQ+dvcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wt54sEAI7pq+cdUJGuGD39LKnowLipgml7FXRXMCz310QiXlBoDv7ly1zQ7T55xdG
	 zcxhCHN9pIqVDtQ/tVNIkwkFs1k9DsU5cf/A3Y47XQG1sSOvFd8Vi8dcKigko9j3LC
	 qpxQEMqIsfe/rUtSoWV7fX9LSHu5t/40gazSghZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbeLXKyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 05:54:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbeLXKyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 05:54:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE7572173C;
        Mon, 24 Dec 2018 10:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545648849;
        bh=3qbLk7RPwBtFoZfU67uPEWWCetuTCgF0l/cjnQ+dvcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzMuDn1b9iW2mqgmZpOKPTSIr2kIPJGbnS23plb/w8byi2NETBvMWmZyLkIWYvOh+
         6D/wvoJoOs2CmpA+zfD2C/B3S9P8zxF+WhOxippBPXfoveevfaCWkEtS7AlvVGvEyV
         4TWdqceAfCu0qo1mp21O46X7PwIqHY9MDtVBJWNE=
Date:   Mon, 24 Dec 2018 11:54:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Marcus Meissner <christian.brauner@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181224105407.GA29719@kroah.com>
References: <20181223164954.hib4lbchftspidsd@suse.de>
 <20181223171703.s7jm6fkyosnsf33z@brauner.io>
 <20181223180609.GA102606@dtor-ws>
 <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
 <20181224091703.GB26796@kroah.com>
 <CAEJqkgj2EjQq_aaspRs7uyTL4LxC9dRUTheN25H+QhjkLjjpjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJqkgj2EjQq_aaspRs7uyTL4LxC9dRUTheN25H+QhjkLjjpjQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 11:15:34AM +0100, Gabriel C wrote:
> Am Mo., 24. Dez. 2018 um 10:17 Uhr schrieb Greg KH <gregkh@linuxfoundation.org>:
> >
> > On Mon, Dec 24, 2018 at 08:31:27AM +0100, Gabriel C wrote:
> > > Am So., 23. Dez. 2018 um 19:09 Uhr schrieb Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com>:
> > >
> > > [ also added Linus to CC on that one too ]
> > > >
> > > > On Sun, Dec 23, 2018 at 06:17:04PM +0100, Christian Brauner wrote:
> > > > > On Sun, Dec 23, 2018 at 05:49:54PM +0100, Marcus Meissner wrote:
> > > > > > Hi,
> > > > > >
> > > > > > I am the maintainer of libmtp and libgphoto2
> > > > > >
> > > > > > Some months ago I was made aware of this bug:
> > > > > >     https://bugs.kde.org/show_bug.cgi?id=387454
> > > > > >
> > > > > > This was fallout identified to come from this kernel commit:
> > > > > >
> > > > > >     commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
> > > > > >     Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > >     Date:   Wed Jul 19 17:24:30 2017 -0700
> > > > >
> > > > > Fwiw, the addition of {un}bind events has caused issues for
> > > > > systemd-udevd as well and is tracked here:
> > > > > https://github.com/systemd/systemd/issues/7587
> > > > > I haven't been aware of this until yesterday and it seems that so far
> > > > > this hasn't been brought up on lkml until you did now.
> > > >
> > > > The fallout was caused by premature enabling of the new events in
> > > > systemd/udev by yours truly (even though the commit has Lennart's name
> > > > on it due to how it was merged):
> > > >
> > > > https://github.com/systemd/systemd/commit/9a39e1ce314d1a6f8a754f6dab040019239666a9
> > > >
> > > > "Add handling for bind/unbind actions (#6720)
> > > >
> > > > Newer kernels will emit uevents with "bind" and "unbind" actions. These
> > > > uevents will be issued when driver is bound to or unbound from a device.
> > > > "Bind" events are helpful when device requires a firmware to operate
> > > > properly, and driver is unable to create a child device before firmware
> > > > is properly loaded.
> > > >
> > > > For some reason systemd validates actions and drops the ones it does not
> > > > know, instead of passing them on through as old udev did, so we need to
> > > > explicitly teach it about them."
> > > >
> > > > Similarly it is now papered over in systemd/udev until we make it
> > > > properly handle new events:
> > > >
> > > > https://github.com/systemd/systemd/commit/56c886dc7ed5b2bb0882ba85136f4070545bfc1b
> > > >
> > > > "sd-device: ignore bind/unbind events for now
> > > >
> > > > Until systemd/udev are ready for the new events and do not flush entire
> > > > device state on each new event received, we should ignore them."
> > > >
> > >
> > > And how about peoples still uses systemd < 235 and newer kernels ?
> >
> > Is that an issue?  Who uses that, and does it cause problems on their
> > systems given that the events just do not do anything for those systems?
> >
> > We tested this out a lot back in the summer of 2017 and I thought all
> > was well.  What recently changed that caused breakages to suddenly show
> > up?  How have we not seen this until now?
> >
> 
> Well people observed that , please click the bug link for that KDE bug.
> Reported '2017-11-30'..
> 
> I can reproduce that on systemd 231 ( which we have here ) and
> kernels >= 4.14 just easy.
> 
> Can't use any mtp devices all dropping :
> 
> The file or folder udi=/org/kde/solid/udev/.......  does not exists'
> 
> Why it got not reported here is probably because people are shy to
> report such things to LKML.
> 
> > We can drop the "new" uevents now by reverting the patch, but what about
> > the userspace tools that now depend on them as we have had them in our
> > kernels for so long?  We can't now break them, right?  Should we add a
> > new kernel config option to not emit those for older userspaces that can
> > not handle this (of which I really still do not understand given that we
> > tested the heck out of this last year...)
> 
> Peoples started to add workarounds to make it work somewhat again.
> 
> Greg any such changes to udev are very fragile.

I am not changing udev.  Well, Dmitry changed udev, and then reverted
it, so all should be fine :)

> Also dropping some patch to systemd-udev won't solve anything on such moves.

If systemd-udev was broken, it should resolve the issue, right?

> Remember there exists other udev impelmentations too and not only that.

Ok, what other udev implementations are broken and why have we not heard
from them in the past 1 1/2 years?

> See example below :
> 
> app1- xxx - depending on some udev / kernel behaviour ( add rule in this case )
> kernel - xxx changes that ( adding bind which confuses add to usersapce )

No, another random uevent should never confuse userspace as userspace
always had to properly handle any uevent it got, no matter what it was
called.  Why would userspace get confused?

> - on update to that kernel app1 breaks..
> - udevd - drops an patch in to catch up
> - app1 trying to workaround now both ( which is that case here )
>    and now here the mess starts.

What application is working around what exactly?  Specific patches would
be good to point to.

> Having app1-fixed for kernel who changed behaviour and using now
> and kernel does not have this makes app1 breaks again
> 
> Using fixed udev and app1 without workarounds on kernel with bind breaks,
> using not fixed udev , app1 without workround breaks etc..
> 
> >
> > still confused,
> >
> 
> The problem I see here is 'bind' confuses 'add'.
> 
> So is there a way to make bind event _not_ confusing add event ?

A bind event should not confuse any other events at all, it is as if
adding any other type of uevent would also confuse an add event?

Something is really wrong if that were to happen why is udev thinking
'bind' is the same as 'add'?  Is it also thinking that 'unbind' is the
same as 'add'?

And see Dmitry's email, it seems that all of the combinations are now
handled properly.

If not, how to resolve this?

thanks,

greg k-h
