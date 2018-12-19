Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00623C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD5020866
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pzz3nFKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbeLSKxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:53:17 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39452 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbeLSKxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:53:17 -0500
Received: by mail-vs1-f67.google.com with SMTP id h78so11959765vsi.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 02:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLK40EgKIKp3NB5AeBPyNZyo1IwhNKosbRaznCx78iw=;
        b=Pzz3nFKG5BvU9Df11j5njkFoEPOnsCXigkHUolPAzxHTCaEOFHxUko4m5O90F9GDcF
         uBeNJK77xp63iUn6MlSxeZHNmflSFj06ZdyhyinDlnowRWxuhqBnWAd62ieIthZK3KDj
         ytCEJ/bNNmIu8jd5BpyPYpKRhrFMcz6KKi8F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLK40EgKIKp3NB5AeBPyNZyo1IwhNKosbRaznCx78iw=;
        b=buOaUBK39JDAscyCOERdGR66mForp5mFyweJqryfhnJsoDn7+yRxnbFDxKI2Aukrbm
         zv1FSvBZHhJfiVPkSRUCt9QpLGs5q5ocuduV6EC7lrP1c33sx6vD7W7g8pcSfdWKrC6+
         obLBKBwARdmcIhYRgv6DLbx/vTslyAgXyBv5/ThA3VUN8ACxYSW+CVzdxRqKO450SZ+A
         BLbiT1QWUkZJ8Ym3R77ZvyWhqnb6QdkD0261xP70RlWEzLnFG0fjr78rNt16Dj7Ch2XV
         tq0IzE3EUfn2lei1xeATrAoOlZikM7p2A7v5qyr2tlFn1qEOoYg4b46PCQVuNjfEmxH6
         QlGA==
X-Gm-Message-State: AA+aEWY8dq5fr9MLsjgIugvGMwurzP42QWhJBPPjkbQMMLky6RJ/PTJN
        opaCzkEqhDlfiNaeCDVyrOanm6/jomG1BdlBcIIm+Q==
X-Google-Smtp-Source: AFSGD/WBlMU97G0W0ScT/9BhAkyd7RB5sswk+1zyF9iLL6dPlqyMzhF7qDz8bytabbbs+JtX+CDml0X8oFvYyTMXj7w=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr9821114vsi.191.1545216795647;
 Wed, 19 Dec 2018 02:53:15 -0800 (PST)
MIME-Version: 1.0
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
 <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFq6X8vJU=pK1fgirGkD2-GS=LryRP1No8bSgPNLbyvAEg@mail.gmail.com>
 <CAKfTPtCpv0MqF64JGTyR63bqKdAhXzL1fEsNbS6DHsD-jXYpKw@mail.gmail.com>
 <CAPDyKFrSxX-eBsTiEvbrbjVpqkSuBnhxruCgtihH6hSvWSFD1g@mail.gmail.com>
 <CAKfTPtB=TUAz=KpZzJsRUvK8ymiXnTgQ3BxcY0yu9YbJ1BW7QA@mail.gmail.com> <CAPDyKFoR7t=K65n0_+4yRqdpRMZ0BbA16cDhmxEvNhm0qEOXNQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoR7t=K65n0_+4yRqdpRMZ0BbA16cDhmxEvNhm0qEOXNQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 11:52:39 +0100
Message-ID: <CAPDyKFpfDF_7ZyhRY-jfapjuQQ=5KpQt7QV2-d_a-qki=omAYA@mail.gmail.com>
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

On Wed, 19 Dec 2018 at 11:43, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 19 Dec 2018 at 11:34, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Wed, 19 Dec 2018 at 11:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 19 Dec 2018 at 11:11, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Wed, 19 Dec 2018 at 10:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > On Tue, 18 Dec 2018 at 15:55, Vincent Guittot
> > > > > <vincent.guittot@linaro.org> wrote:
> > > > > >
> > > > > > Some drivers (like i915/drm) need to get the accounted suspended time.
> > > > > > pm_runtime_accounted_time_get() will return the suspended or active
> > > > > > accounted time until now.
> > > > >
> > > > > I suggest to leave the active accounted time out for now. At least
> > > > > until we have some users.
> > > >
> > > > This is needed to keep same feature level for i915/drm
> > >
> > > I don't follow. According to the changes in the drm driver in patch2,
> > > we are only calling the new pm_runtime interface with RPM_SUSPENDED?
> >
> > sorry I mix your question above and the one about  accounting_timestamp.
> >
> > So I agree that only RPM_SUSPENDED is used for now
> >
> > >
> > > >
> > > > >
> > > > > That said, perhaps rename the function to something along the lines
> > > > > of, pm_runtime_last_suspended_time(), to make it more clear.
> > > > >
> > > > > >
> > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > ---
> > > > > >  drivers/base/power/runtime.c | 26 ++++++++++++++++++++++++++
> > > > > >  include/linux/pm_runtime.h   |  2 ++
> > > > > >  2 files changed, 28 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > > index 7062469..6461469 100644
> > > > > > --- a/drivers/base/power/runtime.c
> > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > @@ -88,6 +88,32 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
> > > > > >         dev->power.runtime_status = status;
> > > > > >  }
> > > > > >
> > > > > > +u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update)
> > > > > > +{
> > > > > > +       u64 now = ktime_to_ns(ktime_get());
> > > > >
> > > > > I think you should stay on jiffies here - and then switch to ktime in patch 3.
> > > > >
> > > > > > +       u64 delta = 0, time = 0;
> > > > > > +       unsigned long flags;
> > > > > > +
> > > > > > +       spin_lock_irqsave(&dev->power.lock, flags);
> > > > > > +
> > > > > > +       if (dev->power.disable_depth > 0)
> > > > > > +               goto unlock;
> > > > > > +
> > > > > > +       /* Add ongoing state  if requested */
> > > > > > +       if (update && dev->power.runtime_status == status)
> > > > > > +               delta = now - dev->power.accounting_timestamp;
> > > > > > +
> > > > >
> > > > > Hmm. Do we really need to update the accounting timestamp? I would
> > > > > rather avoid it if possible.
> > > >
> > > > i915/drm uses this to track ongoing suspended state. In fact they are
> > > > mainly interested by this part
> > >
> > > Again, sorry I don't follow.
> >
> > In fact we don't update dev->power.accounting_timestamp but only use
> > it to get how much time has elapsed in the current state.
> >
> > >
> > > My suggested changes below, would do exactly that; track the ongoing
> > > suspended state.
> > >
> > > The user can call the function several times while the device remains
> > > RPM_SUSPENDED, and if needed the user could then compute the delta
> > > in-between the calls, for whatever reason that may be needed.
> >
> > So I'm not sure to catch your question:
> > Is your problem linked to status != RPM_SUSPENDED or the update
> > parameter that compute delta ?
>
> My intent was to keep things simple.
>
> 1. Only expose last suspended time, which means tracking the ongoing
> suspended state. In other words, you can also remove "enum rpm_status
> status" as the in-parameter to pm_runtime_accounted_time_get().
> 2. Don't allow the user of pm_runtime_accounted_time_get() to update
> the current timestamp, in "dev->power.accounting_timestamp".
>
> Is that okay for the drm driver, to do what it does today?

Hold on. I am wondering if the drm driver could use the existing
pm_runtime_autosuspend_expiration() function instead. Isn't that
really that what is needed?

[...]

Kind regards
Uffe
