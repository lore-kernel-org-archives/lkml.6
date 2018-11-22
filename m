Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DD0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4106320672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKJ1qkK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4106320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390866AbeKVWPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:15:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38599 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388099AbeKVWPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:15:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so7091040qtl.5;
        Thu, 22 Nov 2018 03:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQ10AyWF9HXxhEkpoNVZ9YkeZJW+jbPPHiLHpcqfSNU=;
        b=VKJ1qkK8DbRk5ShD/u6Y15AH81/mHrfthpq6d8lx/iQyVL9PVi8LDKj1wZqRgarWh6
         SUl25tD8l5GL9rOWVreFav3wYix4YG7oAkpI6uM3a7CRvCDNx/iMibcayJ0yENuTse9H
         9SR/6z6gKxVAmqn2LGVjPy+lWHWIJHpVamwZC+4vTo9gGLjOUkCGc9X9N8mii3OCdcRS
         drsdTcROyzjwT0hEPMb3psHXCA88ZTnFYEOk1+DCc1xIpLVaGGQipuNTEinBSBnYHnKX
         LaRJulVZy7agTSD52Gj1Lr5bg7kWO0/nunlmjxMxUcjU5iJZ/S5IMgB24JafzxGVqYDN
         89wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQ10AyWF9HXxhEkpoNVZ9YkeZJW+jbPPHiLHpcqfSNU=;
        b=l8YiDdjSTyxbRriNBmxIRbo9kdKfN3/ZHk0XUTnXZjTTKbYSvAVlhps3jcF7n2IDXq
         hoxrWbycUTePLQWRv2Di8ojSOWH8ZyajCaw+VJjUZXvF6UYd81VZq26WfUrXVPjtVS7h
         j7vcztXfgVl/XYUHo1S3n5usocLgb8tKgznoM7w0h8iRNSytpaskxR6w7snZXACyOwr8
         QLUinEe6PDOfzuwt5/RcgzxRPxUQfb+DabV2KF068mM7pyPdPhYXKomIFrqSWdehECfr
         A23UIriaZXmmNpQmmJYKccuFEHIOHFySNsSXUDqVZqvniiaG+wBb4zfz2pw1LtgWStXo
         oLQw==
X-Gm-Message-State: AGRZ1gIjvNPxE6ClscEm1tyxzY4G7DuPkfyRt5NDuVPUEP1VAfJdt66H
        YGYLs7Qv/CZLxKzCeLjqsMjwLTVpCVv/eAUh7nmEzOrf
X-Google-Smtp-Source: AJdET5chPQjLtRp3Ia1WkNC/Ua1HVbelagNeRUiZjbPbuqBaOrLCfmvF2HSs7mYYouZ9zD3fXtYWKzTfFVSoWOzwXEg=
X-Received: by 2002:aed:2d26:: with SMTP id h35mr9759147qtd.373.1542886614484;
 Thu, 22 Nov 2018 03:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
 <20181108171701.4444-4-ayman.bagabas@gmail.com> <20181119235713.GB7367@amd>
 <s5hr2fgfcrm.wl-tiwai@suse.de> <20181120091039.GA16916@amd>
 <s5hbm6kf6gi.wl-tiwai@suse.de> <20181120093610.GF16916@amd>
 <s5h4lccf58f.wl-tiwai@suse.de> <20181120115159.GG16916@amd> <s5hzhu4c569.wl-tiwai@suse.de>
In-Reply-To: <s5hzhu4c569.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Nov 2018 13:36:43 +0200
Message-ID: <CAHp75VddanEB-7qQutSWkbSZW4srRzGXkigCMxEP7zJ=KC6iKw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei WMI micmute LED
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 2:19 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 20 Nov 2018 12:51:59 +0100,
> Pavel Machek wrote:
> >
> > Hi!
> >
> > > > You have general-purpose LED, yet you are treating it as "something
> > > > special". That means ugly code (quoted above) and lack of flexibility.
> > > >
> > > > For example, if my notebook lacks HDD LED, I can use scrollock LED for
> > > > that instead. Or, in reverse way, maybe "mic mute" LED is not useful
> > > > for me, and I'd like to use it for notifications instead.
> > >
> > > I'm not against adding the LEDs device implementation for any exotic
> > > usage.
> > >
> > > But for the audio mute LED features, you'll need really lots of other
> > > works if it were implemented via leds device.  That's the hardest
> > > part, and a few lines of hooks solves it easily in the kernel side.
> > > That's all about it.
> > >
> > > If you are ready for submitting the real solutions in user-space side
> > > (patching PulseAudio and whatever all existing sound daemons, and
> > > creating yet another daemon for non-PA systems (another footprint,
> > > lovely), and so on), we can happily delete such in-kernel hooks :)
> >
> > I'm not saying we should move it to the userspace.
> >
> > I'm saying this should be "normal" led. drivers/leds/led-huawei-acpi.c,
> > or something. Perhaps this acpi stuff is so similar you don't really
> > need .c code.
> >
> > And then there should be a "mic muted" trigger. Similar to
> > drivers/leds/trigger/ledtrig-disk.c.
>
> And who will trigger this, e.g. when the mixer is muted?

Is this settled? I'm encouraged to promote this series to our for-next branch.

-- 
With Best Regards,
Andy Shevchenko
