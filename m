Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E682C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E15218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8gKwmV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeLSQgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:36:55 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36343 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbeLSQgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:36:54 -0500
Received: by mail-vk1-f196.google.com with SMTP id 185so2963120vkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 08:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAVDRAKXjEgetESDPnTGxslg2DWhI716VxNC7/phOGQ=;
        b=M8gKwmV1Y5UnJuwfaM3qJY+orBKQ5AJs9+1IPKmBSU/61LCYr/nqdNHGKE6ueM0saG
         vFusn1pukwuOsv7Re/IFoW5gWhR9HgVKUMorINMDvAleRTbjPWPsW2Bn2I+aC3lKgW1t
         QWAt739R+t+/6BqnhZ/+8FLmgAl+f3dC5yK54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAVDRAKXjEgetESDPnTGxslg2DWhI716VxNC7/phOGQ=;
        b=Ic1qKInVmKBvlyYXMIGuXFhbFGOK0oFT0FSN2cMfV4spLtQA1jeVgMT3htktRcJRAz
         Gz6eeDADs8tjUFgYpkFpUav0UMecoTprKKyggCf7UetdnEPn9NLG7nGFIThz3Dt7ZA2K
         mFQhlI/IOC8tEi+8qqPFZRKoiiXTkFu6ZuR2ekukLWrSfFuY5EOtxTMGPLYa/HbmCGPr
         CfkCkukUU5YJcoSoW5qsb1hR4IEOZjLMxMqoZG4JqPczWQUfxqEazC8ucrgC2/8GcYg7
         adZcojXexhZGUohdalWZNupWzkbDtSf2xBdSCH4bhLKTe3tgA0RosZwmk9fNpDlVgSjs
         sbhA==
X-Gm-Message-State: AA+aEWZ/tUgYCNttRkBo4MSUUhEUnftgtDsMQ38m74K2lsrgnavPRpQ9
        vR1QYD1DgXvc4PPyGuXW2JLmrSOrRmafaQ8/DzcRQQ==
X-Google-Smtp-Source: AFSGD/W2rLbeB+9WXcJ6SdfU1gArXuGU92P2MN2WURqHrafvRQRg26mDkb5wrsbZyzeQmUKSaaWGY+Mpf1vsA4hyGHo=
X-Received: by 2002:a1f:60c9:: with SMTP id u192mr9274717vkb.36.1545237412978;
 Wed, 19 Dec 2018 08:36:52 -0800 (PST)
MIME-Version: 1.0
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
 <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFq6X8vJU=pK1fgirGkD2-GS=LryRP1No8bSgPNLbyvAEg@mail.gmail.com>
 <CAKfTPtCpv0MqF64JGTyR63bqKdAhXzL1fEsNbS6DHsD-jXYpKw@mail.gmail.com>
 <CAPDyKFrSxX-eBsTiEvbrbjVpqkSuBnhxruCgtihH6hSvWSFD1g@mail.gmail.com>
 <CAKfTPtB=TUAz=KpZzJsRUvK8ymiXnTgQ3BxcY0yu9YbJ1BW7QA@mail.gmail.com>
 <CAPDyKFoR7t=K65n0_+4yRqdpRMZ0BbA16cDhmxEvNhm0qEOXNQ@mail.gmail.com> <CAKfTPtA4Fr6Xk7+dUpzZqGvK6dJGtWAiz70Ho4noQk3gBdGFdg@mail.gmail.com>
In-Reply-To: <CAKfTPtA4Fr6Xk7+dUpzZqGvK6dJGtWAiz70Ho4noQk3gBdGFdg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 17:36:16 +0100
Message-ID: <CAPDyKFqpieqgh-0U_N1wwWdciotMAAJ2SRNXpGAb8D2voiaOJA@mail.gmail.com>
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

On Wed, 19 Dec 2018 at 14:26, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 19 Dec 2018 at 11:43, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 19 Dec 2018 at 11:34, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Wed, 19 Dec 2018 at 11:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
>
> > > > > > >
> > > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > > > index 7062469..6461469 100644
> > > > > > > --- a/drivers/base/power/runtime.c
> > > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > > @@ -88,6 +88,32 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
> > > > > > >         dev->power.runtime_status = status;
> > > > > > >  }
> > > > > > >
> > > > > > > +u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update)
> > > > > > > +{
> > > > > > > +       u64 now = ktime_to_ns(ktime_get());
> > > > > >
> > > > > > I think you should stay on jiffies here - and then switch to ktime in patch 3.
> > > > > >
> > > > > > > +       u64 delta = 0, time = 0;
> > > > > > > +       unsigned long flags;
> > > > > > > +
> > > > > > > +       spin_lock_irqsave(&dev->power.lock, flags);
> > > > > > > +
> > > > > > > +       if (dev->power.disable_depth > 0)
> > > > > > > +               goto unlock;
> > > > > > > +
> > > > > > > +       /* Add ongoing state  if requested */
> > > > > > > +       if (update && dev->power.runtime_status == status)
> > > > > > > +               delta = now - dev->power.accounting_timestamp;
> > > > > > > +
> > > > > >
> > > > > > Hmm. Do we really need to update the accounting timestamp? I would
> > > > > > rather avoid it if possible.
> > > > >
> > > > > i915/drm uses this to track ongoing suspended state. In fact they are
> > > > > mainly interested by this part
> > > >
> > > > Again, sorry I don't follow.
> > >
> > > In fact we don't update dev->power.accounting_timestamp but only use
> > > it to get how much time has elapsed in the current state.
> > >
> > > >
> > > > My suggested changes below, would do exactly that; track the ongoing
> > > > suspended state.
> > > >
> > > > The user can call the function several times while the device remains
> > > > RPM_SUSPENDED, and if needed the user could then compute the delta
> > > > in-between the calls, for whatever reason that may be needed.
> > >
> > > So I'm not sure to catch your question:
> > > Is your problem linked to status != RPM_SUSPENDED or the update
> > > parameter that compute delta ?
> >
> > My intent was to keep things simple.
> >
> > 1. Only expose last suspended time, which means tracking the ongoing
> > suspended state. In other words, you can also remove "enum rpm_status
> > status" as the in-parameter to pm_runtime_accounted_time_get().
>
> Ok for this point if Rafael doesn't see any benefit of keeping the
> generic interface
>
> > 2. Don't allow the user of pm_runtime_accounted_time_get() to update
> > the current timestamp, in "dev->power.accounting_timestamp".
>
> But pm_runtime_accounted_time_get doesn't update
> dev->power.accounting_timestamp, it only reads it to know when when
> the last state transition happened

I understand, sorry for not being clear enough.

My point is, you must not update dev->power.suspended_time, without
also setting a new value for dev->power.accounting_timestamp.
Otherwise, the next time the core calls
update_pm_runtime_accounting(), it will end up adding a wrong delta to
dev->power.suspended_time.

BTW, it seems like you have based this on top of some patch converting
from jiffies to ktime, as I can't fine dev->power.suspended_time, but
instead I have dev->power.suspended_jiffies.

On Wed, 19 Dec 2018 at 14:26, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 19 Dec 2018 at 11:43, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 19 Dec 2018 at 11:34, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Wed, 19 Dec 2018 at 11:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
>
> > > > > > >
> > > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > > > index 7062469..6461469 100644
> > > > > > > --- a/drivers/base/power/runtime.c
> > > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > > @@ -88,6 +88,32 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
> > > > > > >         dev->power.runtime_status = status;
> > > > > > >  }
> > > > > > >
> > > > > > > +u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update)
> > > > > > > +{
> > > > > > > +       u64 now = ktime_to_ns(ktime_get());
> > > > > >
> > > > > > I think you should stay on jiffies here - and then switch to ktime in patch 3.
> > > > > >
> > > > > > > +       u64 delta = 0, time = 0;
> > > > > > > +       unsigned long flags;
> > > > > > > +
> > > > > > > +       spin_lock_irqsave(&dev->power.lock, flags);
> > > > > > > +
> > > > > > > +       if (dev->power.disable_depth > 0)
> > > > > > > +               goto unlock;
> > > > > > > +
> > > > > > > +       /* Add ongoing state  if requested */
> > > > > > > +       if (update && dev->power.runtime_status == status)
> > > > > > > +               delta = now - dev->power.accounting_timestamp;
> > > > > > > +
> > > > > >
> > > > > > Hmm. Do we really need to update the accounting timestamp? I would
> > > > > > rather avoid it if possible.
> > > > >
> > > > > i915/drm uses this to track ongoing suspended state. In fact they are
> > > > > mainly interested by this part
> > > >
> > > > Again, sorry I don't follow.
> > >
> > > In fact we don't update dev->power.accounting_timestamp but only use
> > > it to get how much time has elapsed in the current state.
> > >
> > > >
> > > > My suggested changes below, would do exactly that; track the ongoing
> > > > suspended state.
> > > >
> > > > The user can call the function several times while the device remains
> > > > RPM_SUSPENDED, and if needed the user could then compute the delta
> > > > in-between the calls, for whatever reason that may be needed.
> > >
> > > So I'm not sure to catch your question:
> > > Is your problem linked to status != RPM_SUSPENDED or the update
> > > parameter that compute delta ?
> >
> > My intent was to keep things simple.
> >
> > 1. Only expose last suspended time, which means tracking the ongoing
> > suspended state. In other words, you can also remove "enum rpm_status
> > status" as the in-parameter to pm_runtime_accounted_time_get().
>
> Ok for this point if Rafael doesn't see any benefit of keeping the
> generic interface
>
> > 2. Don't allow the user of pm_runtime_accounted_time_get() to update
> > the current timestamp, in "dev->power.accounting_timestamp".
>
> But pm_runtime_accounted_time_get doesn't update
> dev->power.accounting_timestamp, it only reads it to know when when
> the last state transition happened
>
> >
> > Is that okay for the drm driver, to do what it does today?
>
> drm driver needs 2 things: the  accounted suspended time since the
> last transition

The core keeps tracks of the "total suspended time". Each time
update_pm_runtime_accounting() is called, and the state is
RPM_SUSPENDED it adds a delta to the total suspended time. Just to be
clear, this may even happen when userspace reads the
"runtime_suspended_time" sysfs node.

My point is, the core doesn't track the "total suspended time since
the last transition", which seems to be what the drm driver tries to
figure out.

Just to be clear, I don't think we should update the core to provide
the data reflecting that time, as it would add overhead from
additional time computations. I think it's better to push this down to
those drivers that needs it, as it seems like a highly unusual thing.

Instead, perhaps we should provide an API
(pm_runtime_suspended_time()) that simply returns the value of
dev->power.suspended_jiffies. The driver/subsystem could then call
this API from its ->runtime_suspend|resume() callbacks, for example,
to store values from it locally and later compute the deltas from it
that it needs.

Do note that, the core updates the status of the device to
RPM_SUSPENDED, after the ->runtime_suspend() callback has returned a
successful error code. Hence, calling the API from a
->runtime_suspend() callback would fetch the total suspended time, up
until the last time the device became runtime resumed. That should be
helpful, right?

> and the time elapse in the current state when suspened

Re-thinking this a bit from my earlier comments - and by following the
above reasoning, it sounds like this better belongs in the
driver/subsystem, without requiring any data from the core.

The driver/subsystem could just store a timestamp in it's
->runtime_suspend() callback and whenever needed, it could compute a
delta towards it. That should work, right?

[...]

Kind regards
Uffe
