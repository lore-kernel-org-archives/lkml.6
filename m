Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CF3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8195D20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IlDGbAzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8195D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeK3V1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:27:40 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44614 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeK3V1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:27:39 -0500
Received: by mail-vs1-f68.google.com with SMTP id g68so2996164vsd.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 02:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tK1jaZ6vKaWYxzt1HtCazqRt64MsjqvVDHoaX2x3+7Q=;
        b=IlDGbAzFts+u2bC53bK+sNhmcxUddRYO8bJMquUjDYtTghGDzfCn43SsrV5WI0ogbn
         /jm4RoHeK6GxPcQNqsBcGGNgwCo3f9UlauzABfjX6LW1KZnSPQvLt69E6AwZH7cpM4Ev
         SHBOBeuOQmqSI01b4iyW1fODogpI2p/rIKue0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tK1jaZ6vKaWYxzt1HtCazqRt64MsjqvVDHoaX2x3+7Q=;
        b=iJ0p5svr3fNarz1dvLh5Ri0ps6LIVU2bxsRrGMq3H6B9cKKV9J2KGs0jKm/xHTY6SC
         GJ6Mu5eATRcNddzb1Hsc6Q1dYGAC7Y6mS6gKkPMjlKUYxFk8c6cuj7JzIlavj7zUaI1g
         +Sanq0c+LYI8yICgf1llTnx1F7mpTVX95VL/ahGsD1Q2X9YtIjVljQssh93vKMra+4Qd
         cTzOMZm6g5644iEMx/7vKTOZQcx3cZ02VoJC3YMcAvG7cVt/A4Q7VIHjLzQ8FFFSwv5G
         bUbx4xrBonGn4ZZN4ad0WE2iNMq+bIIsot+IhTtDaAExfv4vPaVQX/N98E41MCqSl/VD
         mDBQ==
X-Gm-Message-State: AA+aEWYMdL/xDikYHqxsxEJKb2bb/DEZTjA38G0A1+8gRVFRcPJG3kxO
        LEyTT+v93oKJ1FWfbr5HPpevV/GH9M5tvI1G8YloUg==
X-Google-Smtp-Source: AFSGD/UGi7sLInvlsh26oAkMeLqKC9x9iURTXYUKQqNrvuc/kkMmkWnGyShW7R2J3ATurpC+ksJq/W97wTUNvSYL4Ko=
X-Received: by 2002:a67:e002:: with SMTP id c2mr2325909vsl.34.1543573130495;
 Fri, 30 Nov 2018 02:18:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543219386.git.viresh.kumar@linaro.org> <5a29ceb2704239a8efb4db2e47ca155a422a6e57.1543219386.git.viresh.kumar@linaro.org>
 <CAPDyKFpp1iPQ08QQjoi9b4RGUo2Zw_L_vjy8xtnSpg34gn--eA@mail.gmail.com> <20181130095912.7hutbsrihpg4gez4@vireshk-i7>
In-Reply-To: <20181130095912.7hutbsrihpg4gez4@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Nov 2018 11:18:14 +0100
Message-ID: <CAPDyKFocp63hUOYOJ3HUXBj2CcHZGXMQ6n873SmMSfpDhRjB7g@mail.gmail.com>
Subject: Re: [PATCH V2 5/5] PM / Domains: Propagate performance state updates
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 10:59, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-11-18, 10:44, Ulf Hansson wrote:
> > On Mon, 26 Nov 2018 at 09:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > This commit updates genpd core to start propagating performance state
> > > updates to master domains that have their set_performance_state()
> > > callback set.
> > >
> > > A genpd handles two type of performance states now. The first one is the
> > > performance state requirement put on the genpd by the devices and
> > > sub-domains under it, which is already represented by
> > > genpd->performance_state.
> >
> > This isn't correct.
> >
> > Currently genpd->performance_state reflects the aggregation of the
> > state requirements from each device that is attached to it. Not from
> > subdomains.
>
> Okay, will improve the changelog.
>
> > > The second type, introduced in this commit, is
> > > the performance state requirement(s) put by the genpd on its master
> > > domain(s). There is a separate value required for each master that the
> > > genpd has and so a new field is added to the struct gpd_link
> > > (link->performance_state), which represents the link between a genpd and
> > > its master. The struct gpd_link also got another field
> > > prev_performance_state, which is used by genpd core as a temporary
> > > variable during transitions.
> > >
> > > We need to propagate setting performance state while powering-on a genpd
> > > as well, as we ignore performance state requirements from sub-domains
> > > which are powered-off. For this reason _genpd_power_on() also received
> > > the additional parameter, depth, which is used for hierarchical locking
> > > within genpd.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/base/power/domain.c | 113 ++++++++++++++++++++++++++++++------
> > >  include/linux/pm_domain.h   |   4 ++
> > >  2 files changed, 98 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index d6b389a9f678..206e263abe90 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -239,24 +239,88 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
> > >  static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
> > >  #endif
> > >
> > > +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> > > +                                          unsigned int state, int depth);
> > > +
> >
> > I don't like forward declarations like these, as in most cases it
> > means that the code can be re-worked and improved.
> >
> > However, because of the recursiveness code in genpd, I understand that
> > it may be needed for some cases. Anyway, please have look and see if
> > you can rid of it.
>
> Will see if I can do it any better, though I really doubt it :)
>
> > >  static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> > > -                                       unsigned int state)
> > > +                                       unsigned int state, int depth)
>
>
> > > -static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
> > > +static int
> > > +_genpd_power_on(struct generic_pm_domain *genpd, bool timed, int depth)
> >
> > Cosmetics, but please move the new parameter below instead of moving
> > "static int" above.
> >
> > >  {
> > >         unsigned int state_idx = genpd->state_idx;
> > >         ktime_t time_start;
> > > @@ -368,7 +442,8 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
> > >         elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
> > >
> > >         if (unlikely(genpd->set_performance_state)) {
> > > -               ret = genpd->set_performance_state(genpd, genpd->performance_state);
> > > +               ret = _genpd_set_performance_state(genpd,
> > > +                                       genpd->performance_state, depth);
> >
> > This is going to be a problem for genpd_sync_power_on() as in some
> > cases we can't allow to use locks.
>
> So we pass the use_lock parameter to this routine as well ?

Maybe.

>
> > Moreover I am wondering how this plays with genpd_power_on(), as when
> > it calls _genpd_power_on() the first time, that is done by holding the
> > top-level master's lock - and all locks in that hierarchy. In other
> > words we are always powering on the top most master first, then step
> > by step we move down in the hierarchy to power on the genpds.
>
> Sure, but the ordering of locks is always subdomain first and then master.
> Considering the case of Qcom, we have two domains Cx (sub-domain) and Mx (master).
>
> On first genpd_power_on(Cx) call, we will first call genpd_power_on(Mx) which
> will just power it on as none of its master will have perf-state support. We
> then call _genpd_power_on(Cx) which will also not do anything with Mx as its own
> (Cx's) pstate would be 0 at that time. But even if it had a valid value, it will
> propagate just fine with all proper locking in place.

Can you explain that, it's not super easy to follow the flow.

So what will happen if Cx has a value that needs to be propagated?
What locks will be taken, and in what order?

Following, what if we had a Bx domain, being the subdomain of Cx, and
it too had a value that needs to be propagated. It sounds like we will
do the propagation one time per level. Is that really necessary,
couldn't we just do it once, after the power on sequence have been
completed?

Kind regards
Uffe
