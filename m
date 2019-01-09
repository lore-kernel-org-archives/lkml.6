Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8834EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E710217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYVIK8PW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfAIOMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:12:38 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34216 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbfAIOMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:12:38 -0500
Received: by mail-io1-f67.google.com with SMTP id b16so6132799ior.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 06:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0nl716eAE7GZXTIOr6MtAR6wxSXrMDpGuwhYZIWFNu8=;
        b=kYVIK8PWEFIVLns5XbgfzNM29cEgjEiyFDGvuS68M0A1aoZ0c6QVSmCD797y4IJwE8
         1+0Z/wVipeWfWPyqZ8Vap/wXRBYqcZSnoG/7SgnmbOD0/aY4qVc0iP0IyE4P6/5cvTe8
         W5uTeRLjjCPlAcmD0bPhUwGgamwAfLggmo4wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0nl716eAE7GZXTIOr6MtAR6wxSXrMDpGuwhYZIWFNu8=;
        b=TE904xgLcqZY76AEUcEB81DZrfjFN64rNZ1n9hdzooUSax4xpD2A0z+nSLz09gAysM
         Sz6PDIFFa9fqWzRdz+iT+XPya9CwekYZgdpiKtlFpOCbKPTG3RiUsI5vo/jYQro6VkJo
         EwhH8XHVk1WKr6Svw8wuwlykVgtck3bVKfengLaAnbqe9j8IO2adTL5eULYV0y+A6oyO
         oYnf2yj0tCkB4rvKVCUqNroSF1Y4V4O0DFm3MxzG2TpV4QLgNruBxDb0R23M2xUqAUaP
         sYT6xi0LYD4ol03AG8XBYppiZhPWDOzSqNx4wYt8Dw9vN2OiVRNTI6bePMi5TVBa/hfz
         t5VQ==
X-Gm-Message-State: AJcUukcNmU6KRtns+pYxU24D3NWBJsdg04sdNUWWyHS4RNeN0zVZlJCJ
        JWty5osOKJ//GINEMGw/DFFb8SeIWWFZd48psfj7qQ==
X-Google-Smtp-Source: ALg8bN4i6g+do94SE0K3kd9bP561s1z028QzgfvZ5BycqrZqGshkwktWXF7m5xpWmX+sdBf6SaVqeRyJ/rZvL0HYWrQ=
X-Received: by 2002:a6b:6b02:: with SMTP id g2mr3774737ioc.18.1547043156498;
 Wed, 09 Jan 2019 06:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com> <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com> <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109111703.GA28605@lenoch> <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
 <20190109115824.GA1353@lenoch> <CAKfTPtAAgYYW8A1LDg18bM=5vCAMDbQ05APp9QWSaifW=F0SgQ@mail.gmail.com>
 <20190109133337.GA13579@lenoch>
In-Reply-To: <20190109133337.GA13579@lenoch>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 9 Jan 2019 15:12:25 +0100
Message-ID: <CAKfTPtAsENRKh_wTFXCLW2_MdMBug+tV2KtjC7x6RigN7hgPmw@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please keep all thread list when replying :-)

On Wed, 9 Jan 2019 at 14:33, Ladislav Michl <ladis@linux-mips.org> wrote:
>
> On Wed, Jan 09, 2019 at 02:24:37PM +0100, Vincent Guittot wrote:
> > On Wed, 9 Jan 2019 at 12:58, Ladislav Michl <ladis@linux-mips.org> wrot=
e:
> > >
> > > On Wed, Jan 09, 2019 at 12:27:57PM +0100, Vincent Guittot wrote:
> > > > On Wed, 9 Jan 2019 at 12:17, Ladislav Michl <ladis@linux-mips.org> =
wrote:
> > > > >
> > > > > On Wed, Jan 09, 2019 at 02:42:18AM +0100, Vincent Guittot wrote:
> > > > > > Le Tuesday 08 Jan 2019 =C3=A0 13:37:43 (-0800), Tony Lindgren a=
 =C3=A9crit :
> > > > > > > * Vincent Guittot <vincent.guittot@linaro.org> [190108 16:42]=
:
> > > > > > > > On Tue, 8 Jan 2019 at 16:53, Tony Lindgren <tony@atomide.co=
m> wrote:
> > > > > > > > > Hmm so could it be that we now rely on timers that that m=
ay
> > > > > > > > > not be capable of waking up the system from idle states w=
ith
> > > > > > > > > hrtimer?
> > > > > > > >
> > > > > > > > With nohz and hrtimer enabled,  timer relies on hrtimer to =
generate
> > > > > > > > the tick so you should use the same interrupt.
> > > > > > >
> > > > > > > OK yeah looks like that part is working just fine.
> > > > > > >
> > > > > > > Adding some printks and debugging over ssh, looks like
> > > > > > > omap8250_runtime_resume() gets called just fine based on a wa=
keirq,
> > > > > > > but then omap8250_runtime_suspend() runs immediately instead =
of
> > > > > > > waiting for the three second timeout.
> > > > > > >
> > > > > > > Lowering the autosuspend_delay_ms to 2100 ms makes things wor=
k again.
> > > > > > > Anything higher than 2200 ms seems to somehow time out immedi=
ately
> > > > > > > now :)
> > > > > >
> > > > > > This is quite close to the max ns of an int on arm 32bits
> > > > > >
> > > > > > Could you try the patch below ?
> > > > > >
> > > > > > ---
> > > > > >  drivers/base/power/runtime.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/=
runtime.c
> > > > > > index 7062469..44c5c76 100644
> > > > > > --- a/drivers/base/power/runtime.c
> > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > @@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struc=
t device *dev)
> > > > > >
> > > > > >       last_busy =3D READ_ONCE(dev->power.last_busy);
> > > > > >
> > > > > > -     expires =3D last_busy + autosuspend_delay * NSEC_PER_MSEC=
;
> > > > > > +     expires =3D last_busy + (u64)(autosuspend_delay) * NSEC_P=
ER_MSEC;
> > > > > >       if (expires <=3D now)
> > > > > >               expires =3D 0;    /* Already expired. */
> > > > >
> > > > > Hmm, comment above function states it returns "the expiration tim=
e in jiffies
> > > > > (adjusted to be nonzero)", so there's probably more to fix...
> > > >
> > > > The comment is wrong and should be updated as commit 8234f6734c5d h=
as
> > > > moved on hrtimer and expires is now in raw ns unit
> > >
> > > Yup. Who'll send a patch? Is it worth optimizing as bellow? I'm fine =
with doing
> >
> > You can send a patch for updating the comment.
> >
> > > both.
> >
> > Regarding proposal below:
> > - pm_runtime_autosuspend_expiration() returns u64 and not ktime_t
>
> Well, that's matter of adding ktime_to_ns (which is noop).
>
> > - use helper ktime_before/after to compare ktime_t value
> >
> > Using ktime helper function makes the code less readable and the
>
> That why I avoided it.

But you must use helper function if you use ktime_t
That's one main reason for using u64 instead of ktime_t

>
> > proposal make the function more difficult to read IMHO when you
> > compare
> >   expires =3D last_busy + autosuspend_delay * NSEC_PER_MSEC;
> > with
> >   expires =3D ktime_add_ns(ms_to_ktime(autosuspend_delay),
> >                               READ_ONCE(dev->power.last_busy));
>
> I agree, but it doea all the magic correctly, so you won't need
> to touch that code is ktime_t changes (I know, unlikely..)

But the current implementation doesn't care of any changes in ktime_t
as it uses raw ns

>
> > or when you compare
> >  if (expires <=3D now)
> > with
> >  if (ktime_after(now, expires))
> >
> > And  I'm not sure that this will optimize the code at the end
>
> Checked generated code on ARM and x86 and gcc does pretty good job here.
>
> > Only the replacement of the "goto out" by return 0 would make sense IMO
>
> Well, main concern was not to call ktime_get at the beginning of function
> as it is not too cheap.

Doesn't the compiler optimize that to just before the test ?

>
> > Regards,
> > Vincent
> >
> > >
> > > > > You can also consider change like this (still does not return jif=
fies):
> > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/ru=
ntime.c
> > > > > index 70624695b6d5..c72eaf21a61c 100644
> > > > > --- a/drivers/base/power/runtime.c
> > > > > +++ b/drivers/base/power/runtime.c
> > > > > @@ -129,23 +129,20 @@ static void pm_runtime_cancel_pending(struc=
t device *dev)
> > > > >  u64 pm_runtime_autosuspend_expiration(struct device *dev)
> > > > >  {
> > > > >         int autosuspend_delay;
> > > > > -       u64 last_busy, expires =3D 0;
> > > > > -       u64 now =3D ktime_to_ns(ktime_get());
> > > > > +       ktime_t expires;
> > > > >
> > > > >         if (!dev->power.use_autosuspend)
> > > > > -               goto out;
> > > > > +               return 0;
> > > > >
> > > > >         autosuspend_delay =3D READ_ONCE(dev->power.autosuspend_de=
lay);
> > > > >         if (autosuspend_delay < 0)
> > > > > -               goto out;
> > > > > -
> > > > > -       last_busy =3D READ_ONCE(dev->power.last_busy);
> > > > > +               return 0;
> > > > >
> > > > > -       expires =3D last_busy + autosuspend_delay * NSEC_PER_MSEC=
;
> > > > > -       if (expires <=3D now)
> > > > > -               expires =3D 0;    /* Already expired. */
> > > > > +       expires =3D ktime_add_ns(ms_to_ktime(autosuspend_delay),
> > > > > +                              READ_ONCE(dev->power.last_busy));
> > > > > +       if (expires <=3D ktime_get())
> > > > > +               return 0;       /* Already expired. */
> > > > >
> > > > > - out:
> > > > >         return expires;
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
> > > > >
> > > > > Regards,
> > > > >         ladis
