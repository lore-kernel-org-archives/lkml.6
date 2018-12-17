Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F49C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F70D20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGc1KFKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbeLQPSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:18:36 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41588 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeLQPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:18:36 -0500
Received: by mail-vk1-f193.google.com with SMTP id t127so2913226vke.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7I4PQNBS1V6fWOmlJA0XqMK2GULEqyPSWTkO83gzGlg=;
        b=WGc1KFKQCtRPqAADDt0TyOXdxnTQv2MYMQXbAf4c4nGPbakMi/Jm/G2nJJ/m9LeEJu
         MfmiVOiY/1T9q4HQNeHiV2Ayx+9VCkN3pfk3vKIZjK+bbfYlkLjWiY3dC6bxod8IP6C0
         iNmgxLHVlZGpM6QbgPkCF4wkE1VgZ1f+Q0fm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7I4PQNBS1V6fWOmlJA0XqMK2GULEqyPSWTkO83gzGlg=;
        b=LAJfXB7N9W8+qVG/0FV5om9mnAl0RBC76L5Q1PCnhXPDfedMlLhZtQ6t7N0wxWOW+/
         lCfdK/d8zQwILPqbTdO26PbF98+qzTbXMF6+ol5yDX4dKWrs6uXeSjcc5TsiaqZ4o5RR
         lTaWJbEzPueaknnoMIkmJ4RXqQQ/YrCyLxRH7YOIl/a3wM6Ra+o4qLpgQqBVScTMr74Q
         jqzJ94TMEwQhEnkFRxcdpF7ULH8DK53wif7EwNt38aGUV96O9y+NWhXop9mJ/1uaAKqp
         3jeF0xYfIzKIG9dBQzcPB+WnlTKDg/8hHrAqtRfhESyqdXL9yIaSoLFOVbnURLuDWPre
         fhQA==
X-Gm-Message-State: AA+aEWZ0gXDykvbFWQELH2aJXzZdqAiqh0TCcCQ6PCRdV4Urq+2vpcER
        aTFZQvlKivEFWMfJrScQ9Vzdf0HPj0Utg6hJrelfoA==
X-Google-Smtp-Source: AFSGD/Wf6+4LOIrkqy9CvZPuzAg5Z/SJcaUPhl8YRgfshNFuEx9gWqb6lKQ1F1cik7rbglBS1jHFKhcGBamIDa/t5q4=
X-Received: by 2002:a1f:298e:: with SMTP id p136mr3775069vkp.40.1545059914482;
 Mon, 17 Dec 2018 07:18:34 -0800 (PST)
MIME-Version: 1.0
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
 <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFrvrN6+sVGc1sM+hmQo=JR=8FyAz_YRK9DzEQN2jOVX6w@mail.gmail.com> <CAKfTPtBbZgZtU-qZhh-nKoC=cNj=ZT_LTn=cTX4V10MCZhDFEg@mail.gmail.com>
In-Reply-To: <CAKfTPtBbZgZtU-qZhh-nKoC=cNj=ZT_LTn=cTX4V10MCZhDFEg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Dec 2018 16:17:58 +0100
Message-ID: <CAPDyKFpGO0q2Ydt6rprupKWaGwis=EY21xGTfDXC+XvF4X=9Hg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/i915: Move to new PM core fields
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

On Mon, 17 Dec 2018 at 15:22, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 14 Dec 2018 at 15:36, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 14 Dec 2018 at 15:22, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > With jiffies been replaced by raw ns in PM core accounting, 915 driver is
> > > updated to use this new time infrastructure.
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  drivers/gpu/drm/i915/i915_pmu.c | 12 ++++++------
> > >  drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
> > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> > > index d6c8f8f..cf6437d 100644
> > > --- a/drivers/gpu/drm/i915/i915_pmu.c
> > > +++ b/drivers/gpu/drm/i915/i915_pmu.c
> > > @@ -493,14 +493,14 @@ static u64 get_rc6(struct drm_i915_private *i915)
> > >                  */
> > >                 if (kdev->power.runtime_status == RPM_SUSPENDED) {
> > >                         if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> > > -                               i915->pmu.suspended_jiffies_last =
> > > -                                                 kdev->power.suspended_jiffies;
> > > +                               i915->pmu.suspended_time_last =
> > > +                                       kdev->power.suspended_time;
> > >
> >
> > Huh, so patch 2 introduces a complier error because of removing the
> > old fields. We can't have that.
>
> I agree
> The patch was mainly to raise discussion
> >
> > Ideally the driver shouldn't touch these fields in the first place,
> > but because the fields are defined in a public header, there is always
> > a risk that they becomes abused. I would appreciate if we can change
> > the driver move away from using these fields and make that a patch
> > preceding patch 2.
>
> In fact, the driver doesn't only use some internal fields but also
> takes the power.lock
> IIUC, the driver wants the current pm runtime suspended time to
> estimate a metric when perf events are not accessible

Huh, so it's even worse. :-(

I had a brief look at the runtime PM deployment for these drivers and
it's really messy. Unfortunate, I have limited knowledge about the
gpu/drm drivers, so I can't tell without a investing in a deeper
analyze, of how to convert to something more generic.

> I'm going to send a new version with a runtime pm interface proposal to fix this

Yeah, please go ahead and try something, I am willing to help review.

> >
> > > -                       val = kdev->power.suspended_jiffies -
> > > -                             i915->pmu.suspended_jiffies_last;
> > > -                       val += jiffies - kdev->power.accounting_timestamp;
> > > +                       val = kdev->power.suspended_time -
> > > +                               i915->pmu.suspended_time_last;
> > > +                       val += ktime_to_ns(ktime_get()) -
> > > +                               kdev->power.accounting_timestamp;
> > >
> > > -                       val = jiffies_to_nsecs(val);
> > >                         val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
> > >
> > >                         i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
> > > diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
> > > index 7f164ca..3dc2a30 100644
> > > --- a/drivers/gpu/drm/i915/i915_pmu.h
> > > +++ b/drivers/gpu/drm/i915/i915_pmu.h
> > > @@ -95,9 +95,9 @@ struct i915_pmu {
> > >          */
> > >         struct i915_pmu_sample sample[__I915_NUM_PMU_SAMPLERS];
> > >         /**
> > > -        * @suspended_jiffies_last: Cached suspend time from PM core.
> > > +        * @suspended_time_last: Cached suspend time from PM core.
> > >          */
> > > -       unsigned long suspended_jiffies_last;
> > > +       u64 suspended_time_last;
> > >         /**
> > >          * @i915_attr: Memory block holding device attributes.
> > >          */
> > > --
> > > 2.7.4
> > >

Kind regards
Uffe
