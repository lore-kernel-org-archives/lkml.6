Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1DCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F45B2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWhuKufD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbeLXLci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:32:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37458 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbeLXLci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 06:32:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so8063591lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 03:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jEDKMQUrxfJs9SwFRGDI/WgJiT8YtQ7BZ7ezY4zo28=;
        b=nWhuKufDHWBNLzo+/NBk8/nZX4dLgSweJMB5rMOy6einZO/UZPm+/sGXutsYyU5P3V
         qaxJaoghLXxApZJLUlmaQAfxWL6/D3mEmuJCpESCEOW6wYKttIZPb7lEWzqFjKolooeG
         2X5rl22yDb8BEdIjBtP4ecGhv+9uLKof0xMraAlu9FzrptmhhYVvBpWFZtqW6uwdT8uW
         g/UyHg2eDsTxSoK0mmpQRBEvCa20Q7tJ89O6AMOym16kfLqqaGP0de41AKtIhzdlCc4o
         8nYhZCD2HqqqF6W4/UTcJKUANbih2/dipQN/9qPZIe+MkRctpyx73AleXIeQu+05f95B
         5V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jEDKMQUrxfJs9SwFRGDI/WgJiT8YtQ7BZ7ezY4zo28=;
        b=EapNTi1y+iZemBZpumob8Q0JSbV+hd98rVXnysfzL/X6wkjnhOYYbK201ClGA0PD6l
         JkYgvcEH3zZVnHG5BGIdIc865+WImyXLuMeRhvVHo/ALaz+4ULFYgncN4UVuritk5hlQ
         3bD1FeP7S46fPuIRw1kKhqxRGVaMQCF/awSGMlpZhmPkyZL1n+a3F4la1orwlAIGO4DC
         YirHgD7AkjlJ/WZxkduck1Vm3USGXzoZ9t9yKV0K/RjQ7ncfqWRNL40v8dSvDF1LRpzB
         M7DfCZ4sFeRdUeiQC+oATJqjzmEndWmuhxhnWjn9oeRMzwUGsSQgIFP3V4hWkNZr67yo
         IB5g==
X-Gm-Message-State: AA+aEWYfRnSvipiNBBlUGlzIM1xZ/RpXExvUoZErjEZcFaE3oa2z8Qow
        D9nr0uHIbWlOClBzGD9SNw54XhkuWGVOQkdiGhMYjNY=
X-Google-Smtp-Source: AFSGD/WTamQcNRfo9jfFbA5F2dhMmLqSuuddndRWh9/X6ZRyC3+xItcsTIO4ZIZCIffGFLnbXVkQOAEvHKSPSX8o5r8=
X-Received: by 2002:a19:2906:: with SMTP id p6mr6093071lfp.17.1545651155077;
 Mon, 24 Dec 2018 03:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20181223164954.hib4lbchftspidsd@suse.de> <20181223171703.s7jm6fkyosnsf33z@brauner.io>
 <20181223180609.GA102606@dtor-ws> <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
 <20181224091703.GB26796@kroah.com> <CAEJqkgj2EjQq_aaspRs7uyTL4LxC9dRUTheN25H+QhjkLjjpjQ@mail.gmail.com>
 <20181224105407.GA29719@kroah.com>
In-Reply-To: <20181224105407.GA29719@kroah.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Mon, 24 Dec 2018 12:32:08 +0100
Message-ID: <CAEJqkgjvOBagdSNhg04466vUXq7v55fE4vHvF66JjezDLu+wFg@mail.gmail.com>
Subject: Re: FYI: Userland breakage caused by udev bind commit
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Marcus Meissner <christian.brauner@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo., 24. Dez. 2018 um 11:54 Uhr schrieb Greg KH <gregkh@linuxfoundation.org>:
>
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

That because software maintainers started to change / workaround with
some different set of
udev rules :)

Original report was on Gentoo and eudev also ..

An now with systemd 240 it will break again probably =)

>
> > See example below :
> >
> > app1- xxx - depending on some udev / kernel behaviour ( add rule in this case )
> > kernel - xxx changes that ( adding bind which confuses add to usersapce )
>
> No, another random uevent should never confuse userspace as userspace
> always had to properly handle any uevent it got, no matter what it was
> called.  Why would userspace get confused?

See : https://bugs.kde.org/show_bug.cgi?id=387454#c29

>
> > - on update to that kernel app1 breaks..
> > - udevd - drops an patch in to catch up
> > - app1 trying to workaround now both ( which is that case here )
> >    and now here the mess starts.
>
> What application is working around what exactly?  Specific patches would
> be good to point to.
>

In case of libmtp / gphoto2 , so far I can tell they changed the udev rules.
However Marcus Meissner should know better than me :)

In case of solid .. is still broken ..

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
>

I don't know why that is and cannot answer you that yet.
I'm near 900KM away from my place and don't have the right hardware
near me to debug/look
why some software gets confused.

> And see Dmitry's email, it seems that all of the combinations are now
> handled properly.
>
> If not, how to resolve this?

I don't know how Dimitry's testing looks like on this however
since I can reproduce that bug with systemd 231 and kernel >= 4.14
I don't think that is resolved.

Also he talks just about systemd's udev .. What about others ?

I don't know for sure on how that can be solved , reverting this patch
seems to be
not a good idea.

Maybe your idea adding a CONFIG about , enable it by default so software
at least can have a sort check on the kernel configuration and based on that
taking action on what rules to install and so on ?

>
> thanks,
>
> greg k-h

BR,

Gabriel
