Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FFBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0043C214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545127046;
	bh=ZrWoCwIWQgmITNoNcfFgYw+90L9e0OEYK6x2Yhj6G1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KgNlGSqSkodxYaIgl/ctdM9uXOklDoQi6dLxTt0LZKrTqpcoqT/C5OO/LDpPj64Gn
	 fxDikcHlKLKGDtLTaWrp3htrfJ8NCBzPVSKerlZoyek85YeCnuNtioH4FTtA+ZUzhp
	 pwpMWdmY9ettOtKcKEmd2NHb1adMOfwf71paRHUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeLRJ5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:57:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39493 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeLRJ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:57:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so15086659otl.6;
        Tue, 18 Dec 2018 01:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00FxPsfrcp7joAZSXVq+WKZb/kQ2nBOl2ENc4HLkmqg=;
        b=neDUJc8MrbvwvaubBIpVNy/i2XhDb4s1EUN0ZUK+PornMxVHDLhITospPqkgAsliWB
         ZsWMhEyYCmDXHaAiBc3KHwVOiBbNpxiWv4T27W+chCS7q8zbY7AI1htP0W+oXIeu6jq6
         54lxIzvd2bttZsOfe2HlAAdG7no7Cmw0ivW5ssJoZgtoaUIFzzIA8uciV3PjMiJM9/6R
         f4LpbAeClSCH3abyMcH48//sWohj8UVfU7mr9SeHgXbASD+skfUFRmU3Q2OYyWLgtEvp
         Ja8y0jhb05OA4gjW1KW1AVXdeOXXYTTZhOF0+CbOhnQqxwMQt6EqzVHq/9BhYCzmeHJb
         1MZQ==
X-Gm-Message-State: AA+aEWaSf1wD3zgXJgUlRXDJNGswb8+MzSMDuC95aMrbDQ+1i36Ckbds
        tUUilgDugP1pnl9s79ZFObk3M2ErGX2Ur5Y5hwo=
X-Google-Smtp-Source: AFSGD/Wh3Mk/yhi/N3Ny/pCtKoXp0amQA2QAsmQgMjOXID0RdO99X58w5upt6AnZfMoWMVniOgBCXBOYnDeObZDyCrw=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr11116209otq.119.1545127043316;
 Tue, 18 Dec 2018 01:57:23 -0800 (PST)
MIME-Version: 1.0
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
 <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFrvrN6+sVGc1sM+hmQo=JR=8FyAz_YRK9DzEQN2jOVX6w@mail.gmail.com> <CAKfTPtBbZgZtU-qZhh-nKoC=cNj=ZT_LTn=cTX4V10MCZhDFEg@mail.gmail.com>
In-Reply-To: <CAKfTPtBbZgZtU-qZhh-nKoC=cNj=ZT_LTn=cTX4V10MCZhDFEg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Dec 2018 10:57:12 +0100
Message-ID: <CAJZ5v0i0FMw90vBH9L9EirX-mfFzh4Fb0npE8Y7rHbFn0JpZyw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/i915: Move to new PM core fields
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 3:22 PM Vincent Guittot
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

OK, so patch [1/3] from this series should be applicable regardless, right?
