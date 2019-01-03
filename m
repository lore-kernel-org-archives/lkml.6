Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991BA208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KhgsL8G9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfACW2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:28:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33975 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfACW2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:28:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so24286302lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 14:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBX/RExnDCFm1z5Pxexihn//AmAS6OkGW3Qjjb4LKE4=;
        b=KhgsL8G9ARvwOsnLNXnfDSAoxnT8ZQeUl9aP9R3VX7vFOsvx+LNPt+rN4PbEoR7oFm
         vGminG/94NKYkSHZ89VvWMF4cLAjAM7ZDzmLmbZ8aShIheDWyKVbyWWYXnBM520GR3X+
         FOlgTIrd3bVbUk17XIhs75/O5ERhO6ASxhx5unWtE3phDRIutK2qd3AhkGo2U6J6J8Zu
         2Kzb4huLu4VtCciFiGNuNcmSYaMuWhpZC8qaur0tO7+Yr3i/UF0xQIz3Q3v2CMdh6TZU
         r8xWqCKMMzQXgR1MUiXb0WSQwtay5VWwsM4yVIaTp2cqXSK/LsUeE3rKCnfLf7umUHGA
         tDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBX/RExnDCFm1z5Pxexihn//AmAS6OkGW3Qjjb4LKE4=;
        b=k2cpGvHplnNj9wglllT4rdh8rpJ9Te7+2dYmEER7lNjb/cRi9khASdYPEMIE0DCv59
         XWxjUgBuQThtC1DLvApTrbEthzP+mKxJk4sqjwZLpk4iUErWI326vLNKihtR1oWeiC4l
         ds5T/TQ95dKiX4Z5JqrXF7uUcOox8/eKBnsQ63Y6wTN8xqBgqrkhCN6ZrUaK6FY2JTR1
         iHeFYRWyVZIKSQtW/nmjoAvpnnkzR9HjzKFBYmCqL4wz9l06rIZDySB/zQVNe4CRzz5z
         gxYoy2qaPm3jpBZPlTXj7UgICscQdCDDiDk1OEW0KBsuxq5AlFuIrIXCIeKNl/hZRytz
         2+ew==
X-Gm-Message-State: AA+aEWZ/hL6zIeaq+L5pAZE51gwUDbO97F3LzI4oCbmWMXKF5Iercdyf
        f7vmYk8m1SIA9G6d+7Yt2D7Zk2AWz87javJ6MQdalw==
X-Google-Smtp-Source: AFSGD/VdbEANahE7GmsnwOz21FYnTsB5Cq3dqk8OXDJYJRs9NGyXnBm6iabmtEalnl3vN7+6+DD2olrU3cg5j3cdU1U=
X-Received: by 2002:a19:1bd2:: with SMTP id b201mr23381848lfb.136.1546554487815;
 Thu, 03 Jan 2019 14:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20181223143550.10672-1-christian@brauner.io> <20181223143550.10672-2-christian@brauner.io>
 <CAHRSSEythiuV6HH9c-q5TwU=tDyZ-K5gjgF+uYZmd6pmAJTovw@mail.gmail.com>
 <20190103203418.rpx3wcs3ozncpnhu@brauner.io> <CAHRSSEz9pJY1gs5VuWs-R4dmWgME4ocQkVGcNvpX1TVUWpdE0w@mail.gmail.com>
 <20190103220841.ycoavsqcbauayypl@brauner.io>
In-Reply-To: <20190103220841.ycoavsqcbauayypl@brauner.io>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 3 Jan 2019 14:27:56 -0800
Message-ID: <CAHRSSEwQ67_fO0X+6Gq-MrnN3EWD8ZhOLH=nxwaEUcgQGKEqRA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] binderfs: reserve devices for initial mount
To:     Christian Brauner <christian@brauner.io>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 2:08 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Thu, Jan 03, 2019 at 01:47:13PM -0800, Todd Kjos wrote:
> > On Thu, Jan 3, 2019 at 12:34 PM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > On Thu, Jan 03, 2019 at 12:25:24PM -0800, Todd Kjos wrote:
> > > > On Sun, Dec 23, 2018 at 6:36 AM Christian Brauner <christian@brauner.io> wrote:
> > > > >
> > > > > The binderfs instance in the initial ipc namespace will always have a
> > > > > reserve of 4 binder devices unless explicitly capped by specifying a lower
> > > > > value via the "max" mount option.
> > > > > This ensures when binder devices are removed (on accident or on purpose)
> > > > > they can always be recreated without risking that all minor numbers have
> > > > > already been used up.
> > > > >
> > > > > Cc: Todd Kjos <tkjos@google.com>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > ---
> > > > > v1:
> > > > > - patch introduced
> > > > > v0:
> > > > > - patch not present
> > > > > ---
> > > > >  drivers/android/binderfs.c | 7 ++++++-
> > > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > > > index 873adda064ac..aa635c7ea727 100644
> > > > > --- a/drivers/android/binderfs.c
> > > > > +++ b/drivers/android/binderfs.c
> > > > > @@ -40,6 +40,8 @@
> > > > >  #define INODE_OFFSET 3
> > > > >  #define INTSTRLEN 21
> > > > >  #define BINDERFS_MAX_MINOR (1U << MINORBITS)
> > > > > +/* Ensure that the initial ipc namespace always has a devices available. */
> > > > > +#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 4)
> > > >
> > > > Why do you ever need more minors per instance than the number of
> > > > devices listed in CONFIG_ANDROID_BINDER_DEVICES?
> > >
> > > Are you asking asking why this is 4 and not 3? In that case we should
> > > probably parse CONFIG_ANDROID_BINDER_DEVICES once at init time and then
> > > reserve that many binder devices. Thoughts?
> >
> > I'm asking why CONFIG_ANDROID_BINDER_DEVICES isn't the source of truth
> > for the number of devices (it normally specifies 3 devices, but could
> > be different). I can't think of a reason why you'd want
> > CONFIG_MAX_MINOR_CAPPED to be different than the number of devices
> > indicated by CONFIG_ANDROID_BINDER_DEVICES and having it specified in
> > two places seems error prone.
>
> I'm not following. The CONFIG_MAX_MINOR_CAPPED and
> CONFIG_ANDROID_BINDER_DEVICES do not have a relation to each other just
> like binder devices requested in CONFIG_ANDROID_BINDER_DEVICES do not
> have a relation to binderfs binder devices as was requested for this
> patchset.
> I also don't know what you mean "appear in two places".
>
> The fact is, binderfs binder devices are independent of binderfs binder
> devices. So it is perfectly reasonable for someone to say
> CONFIG_ANDROID_BINDER_DEVICES="" and *only* rely on binderfs itself.
> Which absolutely need to be possible.
> What I want in such scenarios is that people always have a number of
> binderfs binder devices guaranteed to be available in the binderfs mount
> in the initial ipc namespace no matter how many devices are allocated in
> non-initial ipc namespace binderfs mounts. That's why allo non-initial
> ipc namespace binderfs mounts will use the CONFIG_MAX_MINOR_CAPPED macro
> which guarantees that there's number of devices reserved for the
> binderfs instance in the initial ipc namespace.

Yes, you are right. Cobwebs from vacation -- I confused this with the
previous non-binderfs implementation that was posted that did use
CONFIG_ANDROID_BINDER_DEVICES to instantiate the devices in all
containers. In binderfs, that is only used for the initial (default)
devices.
