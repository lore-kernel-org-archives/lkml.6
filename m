Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0E8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF9820874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="khFrJtRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbeLQOWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:22:11 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35555 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeLQOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:22:10 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so20180529itp.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 06:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nAK355NzTmjDd4KxDsy7RYHYak6vWNy8FtWguRoD19E=;
        b=khFrJtRdVjwap/UnZocSBunpi88JzWevU+qCzVcBqCMJ3c4P/GjTZjYNJqwEoujlaq
         TgBmny2zdyBy0wPnNa7/YenHtonwHJOiyQarX0RkqodXGHKxQ3Y+BfZ5oDLZdW+LIJNe
         sQHphPGm0zsHVszNq/d/mosWpmBlxyBUe5nEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAK355NzTmjDd4KxDsy7RYHYak6vWNy8FtWguRoD19E=;
        b=MB50FquDEhmm3ArIDz7iE2AeiwVSEUZ3+7Yic2JChFEvjCE0E29FUTHr9wagJlThdn
         btkRNg0iOaJkLDskiShJiDPuFrgAXapzUP185x8vGvAFiGwp36WR6lLZ2vDhu7vuycRZ
         f5OboIWHnvcZzlaCoX4kz05CrqNdPQoSyi6shbvYzfJkhYkES6DFujUbJpg6senOrYCb
         kiL61stONhU0F8BhqHL32LgClMf40EUaM0235qan3cexmbGvu5AbU3uzUHWhcUxFJG8m
         hs3tyju4As6yzsd6z+WVKKGfuN53eEbpy7DFKp84SxKY/YqP/G+aMmVJlGx0BvomyLI5
         DDuw==
X-Gm-Message-State: AA+aEWY3cgQdh5xOiAraUJwYEWThSbEht6du8oDa2eXf/OoYqsFbHdw3
        ZnL9skuYcE4JIQ03laSwXzkmIap9NJwpRhQIDIbCZA==
X-Google-Smtp-Source: AFSGD/UA7/miKoEotf+7YZI7cEPGfsRpoeC20pFvZLwq5rhGLweorlQ4fAqEirCCFWwfFo4hUZjKnjocrKpG5x1C5gM=
X-Received: by 2002:a24:6f42:: with SMTP id x63mr12163338itb.152.1545056528193;
 Mon, 17 Dec 2018 06:22:08 -0800 (PST)
MIME-Version: 1.0
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
 <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org> <CAPDyKFrvrN6+sVGc1sM+hmQo=JR=8FyAz_YRK9DzEQN2jOVX6w@mail.gmail.com>
In-Reply-To: <CAPDyKFrvrN6+sVGc1sM+hmQo=JR=8FyAz_YRK9DzEQN2jOVX6w@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 17 Dec 2018 15:21:56 +0100
Message-ID: <CAKfTPtBbZgZtU-qZhh-nKoC=cNj=ZT_LTn=cTX4V10MCZhDFEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/i915: Move to new PM core fields
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 at 15:36, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 14 Dec 2018 at 15:22, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > With jiffies been replaced by raw ns in PM core accounting, 915 driver is
> > updated to use this new time infrastructure.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/gpu/drm/i915/i915_pmu.c | 12 ++++++------
> >  drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> > index d6c8f8f..cf6437d 100644
> > --- a/drivers/gpu/drm/i915/i915_pmu.c
> > +++ b/drivers/gpu/drm/i915/i915_pmu.c
> > @@ -493,14 +493,14 @@ static u64 get_rc6(struct drm_i915_private *i915)
> >                  */
> >                 if (kdev->power.runtime_status == RPM_SUSPENDED) {
> >                         if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> > -                               i915->pmu.suspended_jiffies_last =
> > -                                                 kdev->power.suspended_jiffies;
> > +                               i915->pmu.suspended_time_last =
> > +                                       kdev->power.suspended_time;
> >
>
> Huh, so patch 2 introduces a complier error because of removing the
> old fields. We can't have that.

I agree
The patch was mainly to raise discussion
>
> Ideally the driver shouldn't touch these fields in the first place,
> but because the fields are defined in a public header, there is always
> a risk that they becomes abused. I would appreciate if we can change
> the driver move away from using these fields and make that a patch
> preceding patch 2.

In fact, the driver doesn't only use some internal fields but also
takes the power.lock
IIUC, the driver wants the current pm runtime suspended time to
estimate a metric when perf events are not accessible
I'm going to send a new version with a runtime pm interface proposal to fix this

Vincent

>
> > -                       val = kdev->power.suspended_jiffies -
> > -                             i915->pmu.suspended_jiffies_last;
> > -                       val += jiffies - kdev->power.accounting_timestamp;
> > +                       val = kdev->power.suspended_time -
> > +                               i915->pmu.suspended_time_last;
> > +                       val += ktime_to_ns(ktime_get()) -
> > +                               kdev->power.accounting_timestamp;
> >
> > -                       val = jiffies_to_nsecs(val);
> >                         val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
> >
> >                         i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
> > diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
> > index 7f164ca..3dc2a30 100644
> > --- a/drivers/gpu/drm/i915/i915_pmu.h
> > +++ b/drivers/gpu/drm/i915/i915_pmu.h
> > @@ -95,9 +95,9 @@ struct i915_pmu {
> >          */
> >         struct i915_pmu_sample sample[__I915_NUM_PMU_SAMPLERS];
> >         /**
> > -        * @suspended_jiffies_last: Cached suspend time from PM core.
> > +        * @suspended_time_last: Cached suspend time from PM core.
> >          */
> > -       unsigned long suspended_jiffies_last;
> > +       u64 suspended_time_last;
> >         /**
> >          * @i915_attr: Memory block holding device attributes.
> >          */
> > --
> > 2.7.4
> >
>
> Kind regards
> Uffe
