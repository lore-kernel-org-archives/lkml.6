Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89272C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EE42176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdTmmtZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbeLTIQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:16:06 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46739 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbeLTIQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:16:05 -0500
Received: by mail-ua1-f65.google.com with SMTP id v24so254231uap.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 00:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EW+yc9xYzhBFphE/g4XPkLziPa6TBoo65gyiSK1bjkw=;
        b=HdTmmtZ0zpzUOdvArmzpKoL7PnVLZ81MTKC82dvFslDuMLYXNB7e9lAhbCAG7JllGI
         sYAGDD/Zh7RNTBzy9OkGPBu1bjgLFOfO2HCZNHVrNP/TiJPyVmEwYCCNosD5HTyx1tRD
         1PE4AZcj+iEbc8rRoFXKm54sMZQl1M+YeYtBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EW+yc9xYzhBFphE/g4XPkLziPa6TBoo65gyiSK1bjkw=;
        b=HY63nyyIY3wx4ErvfjQ4XTR17euhu9eRJADN4jTIiHMP37wcVNs4QxtmkeRRXKs4SO
         IzfsTBQPz9zM8+p21CDORgfagznXEu/IM+iRvx4HHfnTxECYnZ+ZZyA0fMKUZ6u93aY0
         GWx2eqtEGT/AenrlqHo1EDF89z7RtiwZROj+reMakyxWUepBEqCWSWtrEMOFs4dm3U6X
         yk8VjGSXyhHvRiboxemschihTgrLie6SOPF/4rhRctixDPJmgF0mzAPKbZYeK/P6sVEI
         S5Hvm50a7n+pV8yPtogxHMM0Ns6KKUSx3QNyVwUCMFOzohS1B/MZ19rYXZvc0/89S3Ku
         DcrA==
X-Gm-Message-State: AA+aEWbJN7sb0hdgvmR5eoyvyrlogiNBAhCDHyOn/7cwmsRoOL5jubVy
        5c3qjjrFOZxxnvQDfNfJIJU5W1ELyic/I3/rIkEv/g==
X-Google-Smtp-Source: AFSGD/VpblgVUBHfxYPDH0CnSlTDBfG/CyjXMRTuHzWJ87LErIZy8Tsvu3Cmq3KIB2wUrgvkgeeYkNDuyhHGdl/yEAM=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr11854411uan.107.1545293763545;
 Thu, 20 Dec 2018 00:16:03 -0800 (PST)
MIME-Version: 1.0
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
 <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFq6X8vJU=pK1fgirGkD2-GS=LryRP1No8bSgPNLbyvAEg@mail.gmail.com>
 <CAKfTPtCpv0MqF64JGTyR63bqKdAhXzL1fEsNbS6DHsD-jXYpKw@mail.gmail.com>
 <CAPDyKFrSxX-eBsTiEvbrbjVpqkSuBnhxruCgtihH6hSvWSFD1g@mail.gmail.com>
 <CAKfTPtB=TUAz=KpZzJsRUvK8ymiXnTgQ3BxcY0yu9YbJ1BW7QA@mail.gmail.com>
 <CAPDyKFoR7t=K65n0_+4yRqdpRMZ0BbA16cDhmxEvNhm0qEOXNQ@mail.gmail.com>
 <CAKfTPtA4Fr6Xk7+dUpzZqGvK6dJGtWAiz70Ho4noQk3gBdGFdg@mail.gmail.com>
 <CAPDyKFqpieqgh-0U_N1wwWdciotMAAJ2SRNXpGAb8D2voiaOJA@mail.gmail.com> <CAKfTPtBp+eCqyCWh27FWe8pkrFJiLQitPL_+kfL42r_BTq6DcQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBp+eCqyCWh27FWe8pkrFJiLQitPL_+kfL42r_BTq6DcQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Dec 2018 09:15:27 +0100
Message-ID: <CAPDyKFocLDoJG5P3ywAV7+p6PL3fnno1cZ87=-Mzn49ag-y6tw@mail.gmail.com>
Subject: Re: [RFC v3 1/3] PM/runtime: Add a new interface to get accounted time
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        jani.nikula@linux.intel.com,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        "Intel graphics driver community testing & development" 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 17:52, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 19 Dec 2018 at 17:36, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 19 Dec 2018 at 14:26, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Wed, 19 Dec 2018 at 11:43, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Wed, 19 Dec 2018 at 11:34, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > On Wed, 19 Dec 2018 at 11:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > >
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > > > > > index 7062469..6461469 100644
> > > > > > > > > --- a/drivers/base/power/runtime.c
> > > > > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > > > > @@ -88,6 +88,32 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
> > > > > > > > >         dev->power.runtime_status = status;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update)
> > > > > > > > > +{
> > > > > > > > > +       u64 now = ktime_to_ns(ktime_get());
> > > > > > > >
> > > > > > > > I think you should stay on jiffies here - and then switch to ktime in patch 3.
> > > > > > > >
> > > > > > > > > +       u64 delta = 0, time = 0;
> > > > > > > > > +       unsigned long flags;
> > > > > > > > > +
> > > > > > > > > +       spin_lock_irqsave(&dev->power.lock, flags);
> > > > > > > > > +
> > > > > > > > > +       if (dev->power.disable_depth > 0)
> > > > > > > > > +               goto unlock;
> > > > > > > > > +
> > > > > > > > > +       /* Add ongoing state  if requested */
> > > > > > > > > +       if (update && dev->power.runtime_status == status)
> > > > > > > > > +               delta = now - dev->power.accounting_timestamp;
> > > > > > > > > +
> > > > > > > >
> > > > > > > > Hmm. Do we really need to update the accounting timestamp? I would
> > > > > > > > rather avoid it if possible.
> > > > > > >
> > > > > > > i915/drm uses this to track ongoing suspended state. In fact they are
> > > > > > > mainly interested by this part
> > > > > >
> > > > > > Again, sorry I don't follow.
> > > > >
> > > > > In fact we don't update dev->power.accounting_timestamp but only use
> > > > > it to get how much time has elapsed in the current state.
> > > > >
> > > > > >
> > > > > > My suggested changes below, would do exactly that; track the ongoing
> > > > > > suspended state.
> > > > > >
> > > > > > The user can call the function several times while the device remains
> > > > > > RPM_SUSPENDED, and if needed the user could then compute the delta
> > > > > > in-between the calls, for whatever reason that may be needed.
> > > > >
> > > > > So I'm not sure to catch your question:
> > > > > Is your problem linked to status != RPM_SUSPENDED or the update
> > > > > parameter that compute delta ?
> > > >
> > > > My intent was to keep things simple.
> > > >
> > > > 1. Only expose last suspended time, which means tracking the ongoing
> > > > suspended state. In other words, you can also remove "enum rpm_status
> > > > status" as the in-parameter to pm_runtime_accounted_time_get().
> > >
> > > Ok for this point if Rafael doesn't see any benefit of keeping the
> > > generic interface
> > >
> > > > 2. Don't allow the user of pm_runtime_accounted_time_get() to update
> > > > the current timestamp, in "dev->power.accounting_timestamp".
> > >
> > > But pm_runtime_accounted_time_get doesn't update
> > > dev->power.accounting_timestamp, it only reads it to know when when
> > > the last state transition happened
> >
> > I understand, sorry for not being clear enough.
> >
> > My point is, you must not update dev->power.suspended_time, without
> > also setting a new value for dev->power.accounting_timestamp.
> > Otherwise, the next time the core calls
> > update_pm_runtime_accounting(), it will end up adding a wrong delta to
> > dev->power.suspended_time.
>
> I fully agree on that and that's why dev->power.accounting_timestamp
> is not and has never been modified

Huh, I have miss-read your patch. What a mess, my apologies.

>
> >
> > BTW, it seems like you have based this on top of some patch converting
> > from jiffies to ktime, as I can't fine dev->power.suspended_time, but
> > instead I have dev->power.suspended_jiffies.
> >
> > On Wed, 19 Dec 2018 at 14:26, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Wed, 19 Dec 2018 at 11:43, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Wed, 19 Dec 2018 at 11:34, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > On Wed, 19 Dec 2018 at 11:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > >
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > > > > > index 7062469..6461469 100644
> > > > > > > > > --- a/drivers/base/power/runtime.c
> > > > > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > > > > @@ -88,6 +88,32 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
> > > > > > > > >         dev->power.runtime_status = status;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update)
> > > > > > > > > +{
> > > > > > > > > +       u64 now = ktime_to_ns(ktime_get());
> > > > > > > >
> > > > > > > > I think you should stay on jiffies here - and then switch to ktime in patch 3.
> > > > > > > >
> > > > > > > > > +       u64 delta = 0, time = 0;
> > > > > > > > > +       unsigned long flags;
> > > > > > > > > +
> > > > > > > > > +       spin_lock_irqsave(&dev->power.lock, flags);
> > > > > > > > > +
> > > > > > > > > +       if (dev->power.disable_depth > 0)
> > > > > > > > > +               goto unlock;
> > > > > > > > > +
> > > > > > > > > +       /* Add ongoing state  if requested */
> > > > > > > > > +       if (update && dev->power.runtime_status == status)
> > > > > > > > > +               delta = now - dev->power.accounting_timestamp;
> > > > > > > > > +
> > > > > > > >
> > > > > > > > Hmm. Do we really need to update the accounting timestamp? I would
> > > > > > > > rather avoid it if possible.
> > > > > > >
> > > > > > > i915/drm uses this to track ongoing suspended state. In fact they are
> > > > > > > mainly interested by this part
> > > > > >
> > > > > > Again, sorry I don't follow.
> > > > >
> > > > > In fact we don't update dev->power.accounting_timestamp but only use
> > > > > it to get how much time has elapsed in the current state.
> > > > >
> > > > > >
> > > > > > My suggested changes below, would do exactly that; track the ongoing
> > > > > > suspended state.
> > > > > >
> > > > > > The user can call the function several times while the device remains
> > > > > > RPM_SUSPENDED, and if needed the user could then compute the delta
> > > > > > in-between the calls, for whatever reason that may be needed.
> > > > >
> > > > > So I'm not sure to catch your question:
> > > > > Is your problem linked to status != RPM_SUSPENDED or the update
> > > > > parameter that compute delta ?
> > > >
> > > > My intent was to keep things simple.
> > > >
> > > > 1. Only expose last suspended time, which means tracking the ongoing
> > > > suspended state. In other words, you can also remove "enum rpm_status
> > > > status" as the in-parameter to pm_runtime_accounted_time_get().
> > >
> > > Ok for this point if Rafael doesn't see any benefit of keeping the
> > > generic interface
> > >
> > > > 2. Don't allow the user of pm_runtime_accounted_time_get() to update
> > > > the current timestamp, in "dev->power.accounting_timestamp".
> > >
> > > But pm_runtime_accounted_time_get doesn't update
> > > dev->power.accounting_timestamp, it only reads it to know when when
> > > the last state transition happened
> > >
> > > >
> > > > Is that okay for the drm driver, to do what it does today?
> > >
> > > drm driver needs 2 things: the  accounted suspended time since the
> > > last transition
> >
> > The core keeps tracks of the "total suspended time". Each time
> > update_pm_runtime_accounting() is called, and the state is
> > RPM_SUSPENDED it adds a delta to the total suspended time. Just to be
> > clear, this may even happen when userspace reads the
> > "runtime_suspended_time" sysfs node.
> >
> > My point is, the core doesn't track the "total suspended time since
> > the last transition", which seems to be what the drm driver tries to
> > figure out.
> >
> > Just to be clear, I don't think we should update the core to provide
> > the data reflecting that time, as it would add overhead from
> > additional time computations. I think it's better to push this down to
>
> Which kind of overhead are you referring ? This is done only when
> pm_runtime_accounted_time_get') is called and doesn't modify
> pm core metrics

I was talking hypothetically.

Having a function that performs some computation when actually called
by the user, along the lines of what you propose in $subject patch, is
in principle fine by me.

The important part, is that we don't make core to perform *additional*
unnecessary time computations, each time it calls
update_pm_runtime_accounting().

>
> > those drivers that needs it, as it seems like a highly unusual thing.
> >
> > Instead, perhaps we should provide an API
> > (pm_runtime_suspended_time()) that simply returns the value of
> > dev->power.suspended_jiffies. The driver/subsystem could then call
> > this API from its ->runtime_suspend|resume() callbacks, for example,
> > to store values from it locally and later compute the deltas from it
> > that it needs.
>
> not sure that i915/drm has such call back
>
> >
> > Do note that, the core updates the status of the device to
> > RPM_SUSPENDED, after the ->runtime_suspend() callback has returned a
> > successful error code. Hence, calling the API from a
> > ->runtime_suspend() callback would fetch the total suspended time, up
> > until the last time the device became runtime resumed. That should be
> > helpful, right?
>
> TBH, I don't know if this would help or not. i915/drm driver developer
> should have the answer
>
> AFAICT, all this code is not driver in itself but some perf monitoring
> stuff that estimate a events when it is not accessible anymore because
> devices is suspended
> >
> > > and the time elapse in the current state when suspened
> >
> > Re-thinking this a bit from my earlier comments - and by following the
> > above reasoning, it sounds like this better belongs in the
> > driver/subsystem, without requiring any data from the core.
> >
> > The driver/subsystem could just store a timestamp in it's
> > ->runtime_suspend() callback and whenever needed, it could compute a
> > delta towards it. That should work, right?
>
> I don't know i915/drm enough to know all that details

Okay, so let me re-summarize the main issue I see with your approach
in $subject patch.

dev->power.accounting_timestamp can't be used to know when last
transition was made. If I understand correctly, that is how you use
it. No?

Anyway, as stated, that's because the timestamp becomes updated, if
update_pm_runtime_accounting() is called via the sysfs nobs, which
means there is no state transition happening, but only accounting data
is updated.

So, what I think we can do from the core perspective, if it helps
(which I am not sure of):
1. Export a function, which returns the value of dev->power.suspended_jiffies.
2. Export a wrapper function (to deal with locking) which calls
update_pm_runtime_accounting(). This wrapper function allows the user
the update the total suspended time, also taking into account the time
spent in the current state.

Other than that, I think the rest should be managed in the drm driver itself.

Kind regards
Uffe
