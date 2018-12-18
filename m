Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D24217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545127399;
	bh=CHgq6uLIfMo67O2f4q+Ur0qL10nTFRCRxpKDhr2KlPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bsm2QXdSkJmmhKmlySwGpAFJmcBm75fJ1Ua4VKqCOWQ0F4tA7EyKGGkVaEtUUd+JJ
	 k9YVEYR/WVrPowvxzAdmrnwprpwGspeLPIUO7qL8X1stCAD5F10HeLTqpVGOrjDhvo
	 tKiADVwChFfuLjfWE3ozChF3twV9CQU+fPMw9ii0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeLRKDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:03:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41979 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeLRKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:03:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so15087024otk.8;
        Tue, 18 Dec 2018 02:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEf6s4X8eLoUp2qjtxzm+IOFRJHkPGDbSx9jc/pT93E=;
        b=ZlgfYXKfDc5zVEZdi/R+uW+aVKUmSIPyMd85leH69X34fgZzIAWM0GYust2yVDSE+z
         WDnYYCm0IqJG4acZmotRuCPjkTy3bMzbH4RaNFVFv/baEtVNbEvqEsCycUnjWc5z6+1/
         3MDQmYma+7UG2JNyshxNdEiDz/fbj9E9I8iFPoTNdcmVKqMuTFFAbSKuFm10NmZ0s0Nb
         le13nXdhiqQYh2R9zK4FusMV07yIcH+EA68vDmzl6o9CSWKGBiuk1mynD9SMO3LniNPs
         O5H9AnHcsFQlQcJnx2XuEU5eSwxlPp8KzCeBK0zmtXztwGTQ2AVJqkjCpjWiI8Upmkkg
         +YeQ==
X-Gm-Message-State: AA+aEWbpT+iARMP6ic3vV3mia5Vl76gOeo43urZ4c9V+v6lCTApdIUVm
        a5zsTckG9GiM7RJahRLIA41IwYeS7w+mTT0RtU0=
X-Google-Smtp-Source: AFSGD/VeVSoXBT2ZQLENEBXN8a/VMDaHluF+p99TFaWIo065ShVNBHy41qtILkk/1fuPL83W6+yYLQ+FkiLPegfEAcE=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr11351954otn.200.1545127396604;
 Tue, 18 Dec 2018 02:03:16 -0800 (PST)
MIME-Version: 1.0
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
 <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFrvrN6+sVGc1sM+hmQo=JR=8FyAz_YRK9DzEQN2jOVX6w@mail.gmail.com>
 <CAKfTPtBbZgZtU-qZhh-nKoC=cNj=ZT_LTn=cTX4V10MCZhDFEg@mail.gmail.com>
 <CAJZ5v0i0FMw90vBH9L9EirX-mfFzh4Fb0npE8Y7rHbFn0JpZyw@mail.gmail.com> <CAKfTPtCNYz6a5rqvpGGGNgsAw_=HdqtpEOfXjn309saNUBjbrw@mail.gmail.com>
In-Reply-To: <CAKfTPtCNYz6a5rqvpGGGNgsAw_=HdqtpEOfXjn309saNUBjbrw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Dec 2018 11:03:05 +0100
Message-ID: <CAJZ5v0g9ceG=dVTTfwkqdZQ0-YMswvfHNfmryZfXAfH=yJV__g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/i915: Move to new PM core fields
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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

On Tue, Dec 18, 2018 at 10:58 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 18 Dec 2018 at 10:57, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Dec 17, 2018 at 3:22 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Fri, 14 Dec 2018 at 15:36, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Fri, 14 Dec 2018 at 15:22, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > With jiffies been replaced by raw ns in PM core accounting, 915 driver is
> > > > > updated to use this new time infrastructure.
> > > > >
> > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > ---
> > > > >  drivers/gpu/drm/i915/i915_pmu.c | 12 ++++++------
> > > > >  drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
> > > > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> > > > > index d6c8f8f..cf6437d 100644
> > > > > --- a/drivers/gpu/drm/i915/i915_pmu.c
> > > > > +++ b/drivers/gpu/drm/i915/i915_pmu.c
> > > > > @@ -493,14 +493,14 @@ static u64 get_rc6(struct drm_i915_private *i915)
> > > > >                  */
> > > > >                 if (kdev->power.runtime_status == RPM_SUSPENDED) {
> > > > >                         if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> > > > > -                               i915->pmu.suspended_jiffies_last =
> > > > > -                                                 kdev->power.suspended_jiffies;
> > > > > +                               i915->pmu.suspended_time_last =
> > > > > +                                       kdev->power.suspended_time;
> > > > >
> > > >
> > > > Huh, so patch 2 introduces a complier error because of removing the
> > > > old fields. We can't have that.
> > >
> > > I agree
> > > The patch was mainly to raise discussion
> >
> > OK, so patch [1/3] from this series should be applicable regardless, right?
>
> Yes

OK, I'll queue it up, then.

Next time you do something like that  please mark patches for
discussion in a series as [RFC] so it is all clear.
