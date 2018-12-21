Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A827EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFFB218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqZ3PSmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390666AbeLUN1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:27:08 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50828 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387909AbeLUN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:27:07 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so6772906iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 05:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBbTccJTV0xChIPgS/OocPcWO32N86xyBKdcKeA6L+g=;
        b=cqZ3PSmzLj7/QVuHY7BzUYQLmE+afaH1jS+MiOotH+euIUZ9xKul9xA1+r13cTWG0E
         UOecr74rbS4Mlh/7s4F8ejrGSakl4eL42xo6Z2vEPG0gtqr45ExKCjXnUzipi5YJQemK
         W0VpXmrH7rbfKZPxgJveS3FMtcD4QSXovRP98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBbTccJTV0xChIPgS/OocPcWO32N86xyBKdcKeA6L+g=;
        b=g1Upgu1vs3Hzjokmoy4sD/d7AJjEsL6ut7S1KeA1As1riF+vedXV1a16MrJNmbPPGC
         A5qvlDiqSsmcMl+xPf6F+Ey1FZBe2QZn2sSs42lQEndNe7237wt0nFAx9gHR3uakXrz1
         7vryoTqbjyYo3+o8jvzjlyblSxMQX6Z9FMx3MfKBvB3e1C1l64rBfedYo90SSriOSUFv
         8fp8+SKcCESzP6Q2hklqV1knemdApDCZFqMcc/IEdT7ioGFXi3pZHzt7aJUIaOxr7EQV
         Mcwu0X3HJjOZGXqpq1WuSJPkX9wneaiZyLh4qlN9qS3R2XMCmuIfkT64DpJAewGIOJgJ
         jWFA==
X-Gm-Message-State: AA+aEWaoqdBGsWStl2VuMMSX3javw7IYuVqlUqIyHX1LNeomUi7YTw1e
        NpUwKe+7KRFVk7eAVLUgWVH2OyTL33p37MjmmDJzBw==
X-Google-Smtp-Source: AFSGD/XOVN4drVc6uUOHbtsIlbmKZd7OYaowscLguONkk4HwavKaMYr7FBLEJ9PkLFzMTpSGt2jl9pCANqyufj8z3Sg=
X-Received: by 2002:a02:7f08:: with SMTP id r8mr1555336jac.20.1545398825443;
 Fri, 21 Dec 2018 05:27:05 -0800 (PST)
MIME-Version: 1.0
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-3-git-send-email-vincent.guittot@linaro.org> <ae85c6d4-5482-1376-7573-8ece9f78bc61@linux.intel.com>
In-Reply-To: <ae85c6d4-5482-1376-7573-8ece9f78bc61@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Dec 2018 14:26:54 +0100
Message-ID: <CAKfTPtDx8u_TnZQnQNmn+=A5A78CPVSWKvMdOVD0UEw4m4s1iQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v5 2/3] drm/i915: Move on the new pm runtime interface
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        "Intel graphics driver community testing & development" 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 at 12:33, Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> Hi,
>
> On 21/12/2018 10:33, Vincent Guittot wrote:
> > Use the new pm runtime interface to get the accounted suspended time:
> > pm_runtime_suspended_time().
> > This new interface helps to simplify and cleanup the code that computes
> > __I915_SAMPLE_RC6_ESTIMATED and to remove direct access to internals of
> > PM runtime.
> >
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   drivers/gpu/drm/i915/i915_pmu.c | 16 ++++++----------
> >   drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
> >   2 files changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> > index d6c8f8f..3f76f60 100644
> > --- a/drivers/gpu/drm/i915/i915_pmu.c
> > +++ b/drivers/gpu/drm/i915/i915_pmu.c
> > @@ -5,6 +5,7 @@
> >    */
> >
> >   #include <linux/irq.h>
> > +#include <linux/pm_runtime.h>
> >   #include "i915_pmu.h"
> >   #include "intel_ringbuffer.h"
> >   #include "i915_drv.h"
> > @@ -478,7 +479,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
> >                * counter value.
> >                */
> >               spin_lock_irqsave(&i915->pmu.lock, flags);
> > -             spin_lock(&kdev->power.lock);
> >
> >               /*
> >                * After the above branch intel_runtime_pm_get_if_in_use failed
> > @@ -491,16 +491,13 @@ static u64 get_rc6(struct drm_i915_private *i915)
> >                * suspended and if not we cannot do better than report the last
> >                * known RC6 value.
> >                */
> > -             if (kdev->power.runtime_status == RPM_SUSPENDED) {
> > -                     if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> > -                             i915->pmu.suspended_jiffies_last =
> > -                                               kdev->power.suspended_jiffies;
> > +             if (pm_runtime_status_suspended(kdev)) {
> > +                     val = pm_runtime_suspended_time(kdev);
>
> There is a race condition between the status check and timestamp access
> which the existing code solves by holding the power.lock over it. But I
> don't exactly remember how this issue was manifesting. Is
> kdev->power.suspended_jiffies perhaps reset on exit from runtime
> suspend, which was then underflowing the val, not sure.
>
> Anyways, is the new way of doing this safe with regards to this race? In

AFAICT it is safe.
The current version does:
1-take lock,
2-test if dev is suspended
3-read some internals field to computed an up-to-date suspended time
4-update __I915_SAMPLE_RC6_ESTIMATED
5-release lock

The new version does:
1-test if dev is suspended
2-get an up-to-date  suspended time with pm_runtime_suspended_time.
This is atomic and monotonic
3-update __I915_SAMPLE_RC6_ESTIMATED

A change from suspended to another states that happens just before
step 1 is ok for both as we will run the else if
No change of the state can happen after step 1 in current code and the
estimated suspended time will be the time up to step2. In parallel,
Any state change will have to wait step5 to continue
If a change from suspended to another state happens after step 1 in
new code, the suspended time return by PM core will be the time up to
this change. So I would say you don't delay state transition and you
get a more accurate estimated suspended time (even if the difference
should be small).
If a change from suspended to another state happens after step 2 in
new code, the suspended time return by PM core will be the time up to
step 2 so there is no changes


> other words is the value pm_runtime_suspended_time always monotonic,
> even when not suspended? If not we have to handle the race somehow.

Yes pm_runtime_suspended_time is monotonic and stays unchanged when
not suspended

>
> If it is always monotonic, then worst case we report one wrong sample,
> which I guess is still not ideal since someone could be querying the PMU
> with quite low frequency.
>
> There are tests which probably can hit this, but to run them
> automatically your patches would need to be rebased on drm-tip and maybe
> sent to our trybot. I can do that after the holiday break if you are
> okay with having the series waiting until then.

yes looks good to me

Thanks,
Vincent

>
> Regards,
>
> Tvrtko
>
> >
> > -                     val = kdev->power.suspended_jiffies -
> > -                           i915->pmu.suspended_jiffies_last;
> > -                     val += jiffies - kdev->power.accounting_timestamp;
> > +                     if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> > +                             i915->pmu.suspended_time_last = val;
> >
> > -                     val = jiffies_to_nsecs(val);
> > +                     val -= i915->pmu.suspended_time_last;
> >                       val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
> >
> >                       i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
> > @@ -510,7 +507,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
> >                       val = i915->pmu.sample[__I915_SAMPLE_RC6].cur;
> >               }
> >
> > -             spin_unlock(&kdev->power.lock);
> >               spin_unlock_irqrestore(&i915->pmu.lock, flags);
> >       }
> >
> > diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
> > index 7f164ca..3dc2a30 100644
> > --- a/drivers/gpu/drm/i915/i915_pmu.h
> > +++ b/drivers/gpu/drm/i915/i915_pmu.h
> > @@ -95,9 +95,9 @@ struct i915_pmu {
> >        */
> >       struct i915_pmu_sample sample[__I915_NUM_PMU_SAMPLERS];
> >       /**
> > -      * @suspended_jiffies_last: Cached suspend time from PM core.
> > +      * @suspended_time_last: Cached suspend time from PM core.
> >        */
> > -     unsigned long suspended_jiffies_last;
> > +     u64 suspended_time_last;
> >       /**
> >        * @i915_attr: Memory block holding device attributes.
> >        */
> >
