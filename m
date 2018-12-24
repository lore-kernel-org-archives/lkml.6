Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A667C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C122821736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaW8vM6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLXHb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 02:31:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37581 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeLXHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 02:31:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so9711228ljd.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 23:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcDgWrVperDuh/6LtlD9XASVIbwq6WBNGAnnxvH7T8Y=;
        b=SaW8vM6dQQAL90tpa804qY8di+vxLfqW3gxnRU2T45Xv3j1upZZHf7ljUOfAtuvXHt
         uOJOI2ODa6remaKYWKqFY96JbCPNuE7l53whb1QQ1AP+tOzYHtm+1kGYGpDpX8AFYmpz
         BbzqB1GjUaHCGYwm5psmf+muKXu4w5csKyzZytjHU1OlzPoDUfKkoYfl09mimU0bAuz5
         VuUtE66rMVOziJ+pmrRDWSJy0YGXzItH/QkMco0djIhdFvhSliGlbSGkWJSGfZEKZhRk
         E8YsN3VASiuTLXpFGl+6NxMO1o/XMWwxJBVqNJlCWdxw4nYl7ukWjDbaMLpUIwIWHTUs
         IHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcDgWrVperDuh/6LtlD9XASVIbwq6WBNGAnnxvH7T8Y=;
        b=q8bwuIWtFlxXXjnxNEgmSfw5R+9QrCYBxBr38Yo6Hv0XkovJTkxrJ5h37imG1/24pG
         OgqWNwc+bnbcPUFrZYiJ/fv0Z58xRaSJfkNbAVioNVO8bMi7riHW5NkrStBY4Ql+CXJl
         cRTANV3uNXHVtNgJY0P9m9RHsC7n7Hu0d7Q8xCp2gkSy8aCEEO0uzY8x3dJ8S6n5ACHU
         WW1pLHuEpN/A61CUxcoPxh1JWRoJgjCwDHMeqE2b2jBvovJ9H0fmhZ5pSPaRvJe2A+Ib
         FUz96edhkLMreqzT8n5YI7YXydSSdK9xRWKH0T0uFZ5FjStHkDnNxM62jx5lC38Td3eh
         Wy3g==
X-Gm-Message-State: AJcUuker1aoL9tdPxodbtGBv9VuC9TSQaETfkf2lRq4WszxuS8gQnhIy
        iN9Osn093MjRwOc8H9+g1fw9agIBgdU3/xjQ/Q==
X-Google-Smtp-Source: ALg8bN4TxL2+2c275VOh+RzqjWbJ1hTKgXOhUz1NFuVpZBbiJQaqDRVimD38mBF0CTNrq+1Uhs63S+JpAhQzDFE8Ftk=
X-Received: by 2002:a2e:88cf:: with SMTP id a15-v6mr6634679ljk.76.1545636713708;
 Sun, 23 Dec 2018 23:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20181223164954.hib4lbchftspidsd@suse.de> <20181223171703.s7jm6fkyosnsf33z@brauner.io>
 <20181223180609.GA102606@dtor-ws>
In-Reply-To: <20181223180609.GA102606@dtor-ws>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Mon, 24 Dec 2018 08:31:27 +0100
Message-ID: <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
Subject: Re: FYI: Userland breakage caused by udev bind commit
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Marcus Meissner <christian.brauner@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am So., 23. Dez. 2018 um 19:09 Uhr schrieb Dmitry Torokhov
<dmitry.torokhov@gmail.com>:

[ also added Linus to CC on that one too ]
>
> On Sun, Dec 23, 2018 at 06:17:04PM +0100, Christian Brauner wrote:
> > On Sun, Dec 23, 2018 at 05:49:54PM +0100, Marcus Meissner wrote:
> > > Hi,
> > >
> > > I am the maintainer of libmtp and libgphoto2
> > >
> > > Some months ago I was made aware of this bug:
> > >     https://bugs.kde.org/show_bug.cgi?id=387454
> > >
> > > This was fallout identified to come from this kernel commit:
> > >
> > >     commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
> > >     Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > >     Date:   Wed Jul 19 17:24:30 2017 -0700
> >
> > Fwiw, the addition of {un}bind events has caused issues for
> > systemd-udevd as well and is tracked here:
> > https://github.com/systemd/systemd/issues/7587
> > I haven't been aware of this until yesterday and it seems that so far
> > this hasn't been brought up on lkml until you did now.
>
> The fallout was caused by premature enabling of the new events in
> systemd/udev by yours truly (even though the commit has Lennart's name
> on it due to how it was merged):
>
> https://github.com/systemd/systemd/commit/9a39e1ce314d1a6f8a754f6dab040019239666a9
>
> "Add handling for bind/unbind actions (#6720)
>
> Newer kernels will emit uevents with "bind" and "unbind" actions. These
> uevents will be issued when driver is bound to or unbound from a device.
> "Bind" events are helpful when device requires a firmware to operate
> properly, and driver is unable to create a child device before firmware
> is properly loaded.
>
> For some reason systemd validates actions and drops the ones it does not
> know, instead of passing them on through as old udev did, so we need to
> explicitly teach it about them."
>
> Similarly it is now papered over in systemd/udev until we make it
> properly handle new events:
>
> https://github.com/systemd/systemd/commit/56c886dc7ed5b2bb0882ba85136f4070545bfc1b
>
> "sd-device: ignore bind/unbind events for now
>
> Until systemd/udev are ready for the new events and do not flush entire
> device state on each new event received, we should ignore them."
>

And how about peoples still uses systemd < 235 and newer kernels ?

> > >
> > > If distributions would be using libmtp and libgphoto2 udev rules
> > > that just triggered on "add" events, and not the new "bind" events,
> > > the missing "attribute tagging" of the "bind" events would confused the
> > > KDE Solid device detection and make the devices no longer detected.
> > >
> > > This did not affect distributions that rely on the newer "hwdb"
> > > device detection method.
> > >
> > > I have released fixed libmtp and libgphoto2 versions in November, so
> > > this is under control, but wanted to bring this up as a "kernel caused
> > > userland breakage".
>
> Given that we explicitly enabled these new events in systemd/udev code
> this is actually "userspace caused userspace breakage" case.

I really do not agree with you here .. Is kernel -> userspace breakage
and while userspace is trying to workaround even much more breaks.

>
> Still it is unfortunate that we did nit notice that my patch enabling
> this functionality in systemd was premature.
>
> Thanks.
>
> --
> Dmitry

BR,

Gabriel
