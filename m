Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E41C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7E8217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jF6JLv9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeLRKIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:08:46 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:32836 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeLRKIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:08:45 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so7861432itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 02:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O9iF7M+1yOkyOXucvDk5+WwCU64Agt0HB5MDM5Sn3BQ=;
        b=jF6JLv9Tuw4Zlp77HFzrOVqfWyy+lPGRyvyLCEidbbGvOW717jU82TKOO3AOxkIXiW
         PbMcGMnLNJ6gy9YU6YJAW4zHM0c/JDey8k32NZeV9mJxKDb6OUBxyfhcnds5Y1SXBwze
         nzo+0EKlMn1eQBGcfEbLezY4XkvRp6o1XrPfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9iF7M+1yOkyOXucvDk5+WwCU64Agt0HB5MDM5Sn3BQ=;
        b=lgV7JfdigokH3Zy65B1LnBw+GTofd4hW0uSM/xVZL6ey16JqtSUKsAhA/0E40zTtNA
         R0yNY4cgoLfo266Lgnf9E6ZAEAbo7I/Q6rpmKYGpk1qB9tx0CO+dC78lq/0q67PIWkJD
         7EUe59wjOKJQxiUpcD4I2s6lMZDrrASyVwaf9+OK7ER5LxkOM3g5vtK5cUvDfgu1+1gK
         m3NoJyXBiXFYxmB6ofjwZOkjdGL+czVV/mY7+jH/o/137OQ/VkRJIS5lgHizuEZnFV7z
         qvUuUfhgz+yJSrMR1iL994hwMhYv1j5OxDIRmvZrjdZnwYlWybtGzo1NdKk7UV6dG6/7
         EoQQ==
X-Gm-Message-State: AA+aEWbRCEagP5gbxbWbhnhotYVjvzuwdfxfA4EgBGtgS1i2kojFdjyp
        fu9nZ7PDiLV3/gvmrjZJwtiyeCU2NYi6eAs9mVNCIA==
X-Google-Smtp-Source: AFSGD/UYEDJNipjJIph+pzNktuqRDtMV3FSHJ2VxTdeHJxiYefNnkguw0MRlnZg1ES9mAYgoudiUCcwhaXz/rAj71Jw=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr2262853itk.114.1545127723963;
 Tue, 18 Dec 2018 02:08:43 -0800 (PST)
MIME-Version: 1.0
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
 <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFrvrN6+sVGc1sM+hmQo=JR=8FyAz_YRK9DzEQN2jOVX6w@mail.gmail.com>
 <CAKfTPtBbZgZtU-qZhh-nKoC=cNj=ZT_LTn=cTX4V10MCZhDFEg@mail.gmail.com>
 <CAJZ5v0i0FMw90vBH9L9EirX-mfFzh4Fb0npE8Y7rHbFn0JpZyw@mail.gmail.com>
 <CAKfTPtCNYz6a5rqvpGGGNgsAw_=HdqtpEOfXjn309saNUBjbrw@mail.gmail.com> <CAJZ5v0g9ceG=dVTTfwkqdZQ0-YMswvfHNfmryZfXAfH=yJV__g@mail.gmail.com>
In-Reply-To: <CAJZ5v0g9ceG=dVTTfwkqdZQ0-YMswvfHNfmryZfXAfH=yJV__g@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Dec 2018 11:08:33 +0100
Message-ID: <CAKfTPtDAnCR16dr1wkT3U1+ZfwjP=JqeBhuRKoUcN5ocB7_fpg@mail.gmail.com>
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

On Tue, 18 Dec 2018 at 11:03, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Dec 18, 2018 at 10:58 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Tue, 18 Dec 2018 at 10:57, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Dec 17, 2018 at 3:22 PM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Fri, 14 Dec 2018 at 15:36, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > On Fri, 14 Dec 2018 at 15:22, Vincent Guittot
> > > > > <vincent.guittot@linaro.org> wrote:
> > > > > >
> > > > > > With jiffies been replaced by raw ns in PM core accounting, 915 driver is
> > > > > > updated to use this new time infrastructure.
> > > > > >
> > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > ---
> > > > > >  drivers/gpu/drm/i915/i915_pmu.c | 12 ++++++------
> > > > > >  drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
> > > > > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> > > > > > index d6c8f8f..cf6437d 100644
> > > > > > --- a/drivers/gpu/drm/i915/i915_pmu.c
> > > > > > +++ b/drivers/gpu/drm/i915/i915_pmu.c
> > > > > > @@ -493,14 +493,14 @@ static u64 get_rc6(struct drm_i915_private *i915)
> > > > > >                  */
> > > > > >                 if (kdev->power.runtime_status == RPM_SUSPENDED) {
> > > > > >                         if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> > > > > > -                               i915->pmu.suspended_jiffies_last =
> > > > > > -                                                 kdev->power.suspended_jiffies;
> > > > > > +                               i915->pmu.suspended_time_last =
> > > > > > +                                       kdev->power.suspended_time;
> > > > > >
> > > > >
> > > > > Huh, so patch 2 introduces a complier error because of removing the
> > > > > old fields. We can't have that.
> > > >
> > > > I agree
> > > > The patch was mainly to raise discussion
> > >
> > > OK, so patch [1/3] from this series should be applicable regardless, right?
> >
> > Yes
>
> OK, I'll queue it up, then.

Thanks

>
> Next time you do something like that  please mark patches for
> discussion in a series as [RFC] so it is all clear.

ok. will do for the next version of the last 2 patches
