Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39AFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FBF2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCQ1CFze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeLRJ6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:58:23 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52476 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLRJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:58:23 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so3226278itg.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 01:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LColufcCVRD2XshW6yz/FKw4A4MgsVLkqne5soI0nkQ=;
        b=SCQ1CFzeNT3TjarMrqIX9Q8g42cIhYkmCihKzbrOtIbsGJlRVeDAmZlTHAyeDLTV5i
         RTnjXzpsEkHCVcA1qfsFrF0laOfa+fWUWVb0wTK/6hUz1MbIYpRP5h1arcHGKE1rC0E3
         gP8+qmtHX6VpaEO3R/L8XMxPMs73nQXWQmOYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LColufcCVRD2XshW6yz/FKw4A4MgsVLkqne5soI0nkQ=;
        b=iCGKHFYMfc85KZUInyJjuYQ1XuYnqiXwAl2Fg15yeVeACRmP2T9SxTkuAuy/NARvW4
         zt4h86K8N/4FFrnXeL9ZkE1/AZfij5pBW9Oq4m0IzmIKbHynOaN3wix57LUOBRpV9UXq
         AXqzvh2csHvVZGOHpVZQV+goW89QwCgKMcj+vhLguEbfKhmvSc3lza+Tjlr+njVkdkDc
         SyqA0ngLn1s9ztPfw4n6t4ijXuKMFdeNbR05LV7zP1nOan5Xh1/fm8NocSeERI95d5u8
         Xf1oKg+qxb68rCLsGByCzoPStIIOkwooF4TCEOZ/qTsrgz5g4aKvmGLJsQQ2lyMA7MAX
         XeUA==
X-Gm-Message-State: AA+aEWYgWFs1TDbYAHm3oHiS6+gdZD+v9FfS7qwVWrhJESPnyy/BEcwb
        JA2Fx8k4IdqTddm/dEsO9AC/Pc8mWJOyECpiiLudAA==
X-Google-Smtp-Source: AFSGD/VpVibqseet1OEMWQO0XgbLjqVsNfniJWir0VNyo/+qVO5/NDO8rSWfRr3DRChHMlQVV4Xju+J9CVGqI+auDYY=
X-Received: by 2002:a02:7f08:: with SMTP id r8mr14498487jac.20.1545127101732;
 Tue, 18 Dec 2018 01:58:21 -0800 (PST)
MIME-Version: 1.0
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
 <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFrvrN6+sVGc1sM+hmQo=JR=8FyAz_YRK9DzEQN2jOVX6w@mail.gmail.com>
 <CAKfTPtBbZgZtU-qZhh-nKoC=cNj=ZT_LTn=cTX4V10MCZhDFEg@mail.gmail.com> <CAJZ5v0i0FMw90vBH9L9EirX-mfFzh4Fb0npE8Y7rHbFn0JpZyw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i0FMw90vBH9L9EirX-mfFzh4Fb0npE8Y7rHbFn0JpZyw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Dec 2018 10:58:10 +0100
Message-ID: <CAKfTPtCNYz6a5rqvpGGGNgsAw_=HdqtpEOfXjn309saNUBjbrw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/i915: Move to new PM core fields
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
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

On Tue, 18 Dec 2018 at 10:57, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 17, 2018 at 3:22 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Fri, 14 Dec 2018 at 15:36, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Fri, 14 Dec 2018 at 15:22, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > With jiffies been replaced by raw ns in PM core accounting, 915 driver is
> > > > updated to use this new time infrastructure.
> > > >
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >  drivers/gpu/drm/i915/i915_pmu.c | 12 ++++++------
> > > >  drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
> > > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> > > > index d6c8f8f..cf6437d 100644
> > > > --- a/drivers/gpu/drm/i915/i915_pmu.c
> > > > +++ b/drivers/gpu/drm/i915/i915_pmu.c
> > > > @@ -493,14 +493,14 @@ static u64 get_rc6(struct drm_i915_private *i915)
> > > >                  */
> > > >                 if (kdev->power.runtime_status == RPM_SUSPENDED) {
> > > >                         if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> > > > -                               i915->pmu.suspended_jiffies_last =
> > > > -                                                 kdev->power.suspended_jiffies;
> > > > +                               i915->pmu.suspended_time_last =
> > > > +                                       kdev->power.suspended_time;
> > > >
> > >
> > > Huh, so patch 2 introduces a complier error because of removing the
> > > old fields. We can't have that.
> >
> > I agree
> > The patch was mainly to raise discussion
>
> OK, so patch [1/3] from this series should be applicable regardless, right?

Yes
