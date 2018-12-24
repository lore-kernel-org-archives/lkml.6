Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160CCC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C394F2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajQg5cvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbeLXRec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 12:34:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45203 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXRec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 12:34:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so5770371plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vmN8r2oKm4cfg3j/vdStM2K6QpLlxU5sxNRtxZarUGs=;
        b=ajQg5cvyME1nRiJnp05pvoyyXY2g65hyJSRkxLbUeSOZhBxVdTNYIVKBrkQPobyUeg
         1KEUa5ytjkCBTrv54HU63DbC2H0TQheH4H3Q0jWxHylQDp66zRTaNPY+P6vUVCizflTL
         1XiXvIBp36B7O2Xvy5V5xoh1NHczWQbQbk4GwoMM0hbaDKovAFK+ZXv9idkm5Cx+fl7B
         spQxUEdBB3QLjW2eOa9tp3h8Saod/s4WWz9rL1+gAcu8d1RnaaU45zqifpUdgc5d+vfF
         nO/Kn2AepSS4VkZlg4LOnRlXxvKItg+pEq0m22q+xyTA91x/+5NPpgQafIz94Bk1q6X6
         nz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vmN8r2oKm4cfg3j/vdStM2K6QpLlxU5sxNRtxZarUGs=;
        b=KS8Da+Uowywh7jd5F33hgQzIVlzgzxxFS3ofZK+wITieXacDvwMe5LRuOnOQ8XN/rd
         5L9oqSxLSn34zH5dM9WT2kVY31stdGtsh02XsDjwehP3HiXy+lNZ5KH/xM5ObC80oBCO
         1D42S4Um8m9lUANbEFMfg/+7fMmw24+GxhegILEvAHzjDTwzCL3TRASnAKrwVwZR0gJ9
         SE7gtTAGA8bLwrxIftooGKbrvk5y+5uzXuvzhjpFxtXLBrIDx1Huu+q20xTmr9Ns4EGO
         V4bfEp9xNb0esT2ixgBkKAcjdWjBqGG/HtKiDXEwyEtR16UnKfgLXF3nnJcrk3mLDvxT
         TBUA==
X-Gm-Message-State: AJcUukeC4BoOPFXMSZC4a5dUR5ksznb7BCtLTAtJoATuU2ykQ7R5jaSl
        8lSPP+FjZ1DHrzPJWgxzN3jH8vhP
X-Google-Smtp-Source: ALg8bN7qEUUXj4FPgLRm2QVgR3D/+1YfQTzYRba6sfy0/G28g2ea+mkLjmdfC+D4G8ZRaRXF+kFltg==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr13354006plh.99.1545672870070;
        Mon, 24 Dec 2018 09:34:30 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm54727543pfv.30.2018.12.24.09.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 09:34:29 -0800 (PST)
Date:   Mon, 24 Dec 2018 09:34:27 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Gabriel C <nix.or.die@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Marcus Meissner <christian.brauner@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181224173427.GA254245@dtor-ws>
References: <20181223164954.hib4lbchftspidsd@suse.de>
 <20181223171703.s7jm6fkyosnsf33z@brauner.io>
 <20181223180609.GA102606@dtor-ws>
 <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
 <20181224091703.GB26796@kroah.com>
 <CAEJqkgj2EjQq_aaspRs7uyTL4LxC9dRUTheN25H+QhjkLjjpjQ@mail.gmail.com>
 <20181224105407.GA29719@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224105407.GA29719@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 11:54:07AM +0100, Greg KH wrote:
> On Mon, Dec 24, 2018 at 11:15:34AM +0100, Gabriel C wrote:
> > Am Mo., 24. Dez. 2018 um 10:17 Uhr schrieb Greg KH <gregkh@linuxfoundation.org>:
> > >
> > > On Mon, Dec 24, 2018 at 08:31:27AM +0100, Gabriel C wrote:
> > > > Am So., 23. Dez. 2018 um 19:09 Uhr schrieb Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com>:
> > > >
> > > > [ also added Linus to CC on that one too ]
> > > > >
> > > > > On Sun, Dec 23, 2018 at 06:17:04PM +0100, Christian Brauner wrote:
> > > > > > On Sun, Dec 23, 2018 at 05:49:54PM +0100, Marcus Meissner wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > I am the maintainer of libmtp and libgphoto2
> > > > > > >
> > > > > > > Some months ago I was made aware of this bug:
> > > > > > >     https://bugs.kde.org/show_bug.cgi?id=387454
> > > > > > >
> > > > > > > This was fallout identified to come from this kernel commit:
> > > > > > >
> > > > > > >     commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
> > > > > > >     Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > > >     Date:   Wed Jul 19 17:24:30 2017 -0700
> > > > > >
> > > > > > Fwiw, the addition of {un}bind events has caused issues for
> > > > > > systemd-udevd as well and is tracked here:
> > > > > > https://github.com/systemd/systemd/issues/7587
> > > > > > I haven't been aware of this until yesterday and it seems that so far
> > > > > > this hasn't been brought up on lkml until you did now.
> > > > >
> > > > > The fallout was caused by premature enabling of the new events in
> > > > > systemd/udev by yours truly (even though the commit has Lennart's name
> > > > > on it due to how it was merged):
> > > > >
> > > > > https://github.com/systemd/systemd/commit/9a39e1ce314d1a6f8a754f6dab040019239666a9
> > > > >
> > > > > "Add handling for bind/unbind actions (#6720)
> > > > >
> > > > > Newer kernels will emit uevents with "bind" and "unbind" actions. These
> > > > > uevents will be issued when driver is bound to or unbound from a device.
> > > > > "Bind" events are helpful when device requires a firmware to operate
> > > > > properly, and driver is unable to create a child device before firmware
> > > > > is properly loaded.
> > > > >
> > > > > For some reason systemd validates actions and drops the ones it does not
> > > > > know, instead of passing them on through as old udev did, so we need to
> > > > > explicitly teach it about them."
> > > > >
> > > > > Similarly it is now papered over in systemd/udev until we make it
> > > > > properly handle new events:
> > > > >
> > > > > https://github.com/systemd/systemd/commit/56c886dc7ed5b2bb0882ba85136f4070545bfc1b
> > > > >
> > > > > "sd-device: ignore bind/unbind events for now
> > > > >
> > > > > Until systemd/udev are ready for the new events and do not flush entire
> > > > > device state on each new event received, we should ignore them."
> > > > >
> > > >
> > > > And how about peoples still uses systemd < 235 and newer kernels ?
> > >
> > > Is that an issue?  Who uses that, and does it cause problems on their
> > > systems given that the events just do not do anything for those systems?
> > >
> > > We tested this out a lot back in the summer of 2017 and I thought all
> > > was well.  What recently changed that caused breakages to suddenly show
> > > up?  How have we not seen this until now?
> > >
> > 
> > Well people observed that , please click the bug link for that KDE bug.
> > Reported '2017-11-30'..
> > 
> > I can reproduce that on systemd 231 ( which we have here ) and
> > kernels >= 4.14 just easy.
> > 
> > Can't use any mtp devices all dropping :
> > 
> > The file or folder udi=/org/kde/solid/udev/.......  does not exists'
> > 
> > Why it got not reported here is probably because people are shy to
> > report such things to LKML.
> > 
> > > We can drop the "new" uevents now by reverting the patch, but what about
> > > the userspace tools that now depend on them as we have had them in our
> > > kernels for so long?  We can't now break them, right?  Should we add a
> > > new kernel config option to not emit those for older userspaces that can
> > > not handle this (of which I really still do not understand given that we
> > > tested the heck out of this last year...)
> > 
> > Peoples started to add workarounds to make it work somewhat again.
> > 
> > Greg any such changes to udev are very fragile.
> 
> I am not changing udev.  Well, Dmitry changed udev, and then reverted
> it, so all should be fine :)
> 
> > Also dropping some patch to systemd-udev won't solve anything on such moves.
> 
> If systemd-udev was broken, it should resolve the issue, right?
> 
> > Remember there exists other udev impelmentations too and not only that.
> 
> Ok, what other udev implementations are broken and why have we not heard
> from them in the past 1 1/2 years?
> 
> > See example below :
> > 
> > app1- xxx - depending on some udev / kernel behaviour ( add rule in this case )
> > kernel - xxx changes that ( adding bind which confuses add to usersapce )
> 
> No, another random uevent should never confuse userspace as userspace
> always had to properly handle any uevent it got, no matter what it was
> called.  Why would userspace get confused?
> 
> > - on update to that kernel app1 breaks..
> > - udevd - drops an patch in to catch up
> > - app1 trying to workaround now both ( which is that case here )
> >    and now here the mess starts.
> 
> What application is working around what exactly?  Specific patches would
> be good to point to.
> 
> > Having app1-fixed for kernel who changed behaviour and using now
> > and kernel does not have this makes app1 breaks again
> > 
> > Using fixed udev and app1 without workarounds on kernel with bind breaks,
> > using not fixed udev , app1 without workround breaks etc..
> > 
> > >
> > > still confused,
> > >
> > 
> > The problem I see here is 'bind' confuses 'add'.
> > 
> > So is there a way to make bind event _not_ confusing add event ?
> 
> A bind event should not confuse any other events at all, it is as if
> adding any other type of uevent would also confuse an add event?
> 
> Something is really wrong if that were to happen why is udev thinking
> 'bind' is the same as 'add'?  Is it also thinking that 'unbind' is the
> same as 'add'?

The issue is a combination of factors:

1. systemd/udev/eudev flushing state for a device for each new uevent,
   so receiving "bind" or any new uevent that we might create in the
   future drops everything that was added by rules for "add"

2. Most rules having stanza ACTION!="add|change" GOTO="end" which
   is actually proper expression, but has unfortunate effect of not
   re-adding properties that were dropped.

Some package maintainers started changing this to ACTION=="remove",
ACTION!="bind", etc, but I think this actually is nit good long-term
strategy.

> 
> And see Dmitry's email, it seems that all of the combinations are now
> handled properly.

I was talking about systemd only, but I guess we do have eudev...

> 
> If not, how to resolve this?

Well, it appears that we can no longer extend uevent interface with new
types of uevents, at least not until we go and fix up all
udev-derivatives and give some time for things to settle. I am not sure
if abusing change to signal bind/unbind, as was suggested by Lennart on
one of the threads is such a great idea and it is not really extensible.

I guess reverting is the right solution here. I wish folks would yell
earlier though...

Thanks.

-- 
Dmitry
