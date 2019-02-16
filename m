Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D052C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 23:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E1121A4C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 23:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1u2uNgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfBPXha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 18:37:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32825 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbfBPXha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 18:37:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id h22so9341209wmb.0;
        Sat, 16 Feb 2019 15:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3vihQgKqfgjXdWkIV1rQ1oSJIgvuAd1lUf0NOIzM6U=;
        b=l1u2uNgutoFuX/iuAtplf9sjKqfc1oxyWb6GdKO2CpLqqjwY7U3x3xht8U+AHokdur
         5sfNWzncQQmGiTpv60NllLzbtHQ3PiaTnAqqaLEqKajgamuRE3MugkLSgF+GNBmZQ3Ux
         XOmqeLsZT+bjaE2aaCQqzTzZFKfdoCdAd8hs4o+J6Ut1g/gMgyn0rIiqjn/OJov9Fcz4
         v8qICK6Aw3Ktv1XYX4bYbomVd70+7l2stRE0r45DVzVr1O8NUNPUK37WRNfc/PMvcyun
         Lgo0ImmLjB5rHOW4bo92k++g3pQySOmMF+RCW9KMUlJV3cQfMV4PBliq6j0s9v+ip0pa
         eGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3vihQgKqfgjXdWkIV1rQ1oSJIgvuAd1lUf0NOIzM6U=;
        b=fjPvEk73hXFcHQrlB7uAPxgt1cvZvBrynlQXTHK8LfP7N3PwsAvG++MOaICqhPEJ4t
         +2Im7B43w4GWXMTS1X1eKG2yT1WBkZL9B4R2gSHmksjYSZj+MCRP4csjZUFMLxiw+qXw
         FqUO77ZPBOk0sM5Ug7Av44jalU4EGn6yVpv2h1p9uz4goGLNlGXURno/gOhIsI3b3itf
         zLG2M8KPUzxzraNYxsG+1kfjrIRbStb3oI7x/4QK/QePdHbCExOHSnJzDfjJyINaciBi
         XVY0nN6aXEnarN4FEa5uDjWDGIHYx8sZacBKy1Fl2RuMEVjRtWO8W42DcIbgTTgEUqZi
         xSIg==
X-Gm-Message-State: AHQUAua1VzhyuL/UJvK1I8jWH9iAwQepZhlXj0qixGQat6mNwJCfD2nh
        7NrIi65ZnPiPDmFUxLx5MP9fz1Yhwd2fvNMLVBA=
X-Google-Smtp-Source: AHgI3IYaaK0lWVcIEvEVrqLebt3e/5CxN8nSWmNEva7umfr62cINr+uHO1eKc6EpKs0MLn6Mo2jTlj8k/4NabpFsEZA=
X-Received: by 2002:a1c:f701:: with SMTP id v1mr10629504wmh.153.1550360247027;
 Sat, 16 Feb 2019 15:37:27 -0800 (PST)
MIME-Version: 1.0
References: <2281684.8tZHfIXjiu@aspire.rjw.lan> <CADnq5_NmDYzZZPUh5Wp+a8bycRWFDt3Lhzf0AKx9BECJ_U-Kyg@mail.gmail.com>
 <20190216060058.gsiddsmj3f27e6v7@wunner.de>
In-Reply-To: <20190216060058.gsiddsmj3f27e6v7@wunner.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Sat, 16 Feb 2019 18:37:13 -0500
Message-ID: <CADnq5_OqaQA2HNcy+ZZvsN5MTEWLXoFEuirX4f4nzEOJ6NrdVA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "?????????????? ????????????????" <ukrkyi@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 1:01 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Fri, Feb 15, 2019 at 11:01:04AM -0500, Alex Deucher wrote:
> > On Fri, Feb 15, 2019 at 10:39 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On HP ProBook 4540s, if PM-runtime is enabled in the radeon driver
> > > and the direct-complete optimization is used for the radeon device
> > > during system-wide suspend, the system doesn't resume.
> > >
> > > Preventing direct-complete from being used with the radeon device by
> > > setting the DPM_FLAG_NEVER_SKIP driver flag for it makes the problem
> > > go away, which indicates that direct-complete is not safe for the
> > > radeon driver in general and should not be used with it (at least
> > > for now).
> > >
> > > This fixes a regression introduced by commit c62ec4610c40
> > > ("PM / core: Fix direct_complete handling for devices with no
> > > callbacks") which allowed direct-complete to be applied to
> > > devices without PM callbacks (again) which in turn unlocked
> > > direct-complete for radeon on HP ProBook 4540s.
> >
> > Do other similar drivers like amdgpu and nouveau need the same fix?
> > I'm not too familiar with the direct_complete feature in general.
>
> direct_complete means that a discrete GPU which is in D3cold upon
> entering system sleep is left as is, i.e. it is not woken.  It is
> also expected to still be in D3cold when resuming from system sleep
> from the PM core's point of view.  (If it is in D0uninitialized, the
> GPU's driver needs to ensure it is transitioned to D3cold again.)
>
> I know for a fact that resuming the discrete GPU is not necessary
> on my MacBook Pro with Nvidia GPU.  I'd expect those with AMD GPUs
> to behave the same.  The apple-gmux driver takes care of putting
> the GPU into D3cold on resume from system sleep if it was in D3cold
> when entering system sleep (see drivers/platform/x86/apple-gmux.c,
> gmux_resume()).
>
> I think it is desirable to use direct_complete because it saves power
> (no need to gratuitously wake the GPU upon entering system sleep,
> only to immediately cut its power) and it also speeds up the suspend
> process by about half a second.

Thanks for the info.  It sounds like we need a similar patch for
amdgpu.  With dGPUs controlled by the ACPI ATPX method, I believe the
dGPU is powered by automatically on resume from S3/S4.  I think there
may be a way to change that behavior in some revisions of ATPX (i.e.,
to keep the state across suspend cycles), but it's not the default.
I'm not sure about the newer _PR3 stuff in Hybrid Graphics laptops.  I
think it retains state.  In both radeon and amdgpu we probably need to
check if the system is using ATPX or _PR3 and disable direct complete
for ATPX at least.

Alex

>
> The root cause on the HP ProBook 4540s needs to be debugged, I'd
> suspect a BIOS issue which could be adressed by a quirk, either for
> this particular machine or for a certain class of devices (e.g. all
> machines which use PR3 to transition to D3cold) if that is necessary
> to behave identically to Windows.  Or maybe the atpx vga_switcheroo
> handler needs to be amended to put the GPU into D3cold on resume from
> system sleep if it was runtime suspended before.
>
> Is this machine using s2idle or does it suspend to S3?
>
> Thanks,
>
> Lukas
>
> > > Fixes: c62ec4610c40 ("PM / core: Fix direct_complete handling for devices with no callbacks")
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=201519
> > > Reported-by: ?????????????? ???????????????? <ukrkyi@gmail.com>
> > > Tested-by: ?????????????? ???????????????? <ukrkyi@gmail.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/gpu/drm/radeon/radeon_kms.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > Index: linux-pm/drivers/gpu/drm/radeon/radeon_kms.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/gpu/drm/radeon/radeon_kms.c
> > > +++ linux-pm/drivers/gpu/drm/radeon/radeon_kms.c
> > > @@ -172,6 +172,7 @@ int radeon_driver_load_kms(struct drm_de
> > >         }
> > >
> > >         if (radeon_is_px(dev)) {
> > > +               dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
> > >                 pm_runtime_use_autosuspend(dev->dev);
> > >                 pm_runtime_set_autosuspend_delay(dev->dev, 5000);
> > >                 pm_runtime_set_active(dev->dev);
