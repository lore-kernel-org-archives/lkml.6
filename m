Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5194BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B299206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUUPOkfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfBGNhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:37:54 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41694 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfBGNhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:37:53 -0500
Received: by mail-vs1-f67.google.com with SMTP id t17so6663581vsc.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 05:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzHR8ZftV1OhX4YQPLU5KFmI9ec2dKucVidroRsVvjM=;
        b=ZUUPOkfeXR2H7VaecXNgL+jgfsCNCPlZgEcG/CwP6YLQpW3T2h1FYPzE3gZRbOW4jv
         3T432K7wZ0y0SaBaD9QIZ1df1afTduM90TXO8Bip1X5Txv8LPO7yo0+7clebs3P7LqOP
         LU5pTLZoyKahgmpfk6XdB1cyqk+nEJRwRiVSDln2pSvzw818PmEamgvMb5/xensMpyri
         clZwGh4QPoeUv3aYFqwpiAO0ZzTqbBPDDKogaqz8RLycYpydT27alEYvvLcg7MMh350u
         lq1jnEGnU9PLETtaHqhJaJt0sE9ZVyO0OtU7WdzT10OD0IvH7N4zrqVHziowy9H2i8DG
         N/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzHR8ZftV1OhX4YQPLU5KFmI9ec2dKucVidroRsVvjM=;
        b=AN2MPn0RpJh/pFYJGCu+jhmjJqagDMH3+ORz7PkGbRKx8WXKHJ2jz6OFVUAjrUKkYf
         m2ATg9OUepxjk1kgmJoue/vFSa0zv+BPKaCbiVZ3jm5+Ogy45V/zcAtxONme5AZjKE2X
         DI2CJqCdaCvJNkWPQlkpBWZEXw5v43BWwtLENbMxQHxU+EpciQp9VqNXzx9Rc8rX1XnS
         VcfOycgEsUuG9fsGCetQO4bdIYDsafBcLwM50KqO7wjIKi+7Fz9tzIjw8FKpTQMz2Of4
         JAmTjrJdDjMR4jFhbltxA8BWbkY0sLLT/OXEJ3xYAjYpaSFT5T4x1db+u97MCYIdcb0u
         +l9w==
X-Gm-Message-State: AHQUAuYfLKkKJQ4J+sjJF4hfczj7H8nij5tFVkCMDShSQryJuq8tvNbt
        avXN+E1oGb4KHG6ky1Y1EJwMIoS5qmGZPrjrDfvJQA==
X-Google-Smtp-Source: AHgI3Ib8DnIcJvM8Lwt20nRH7V48iSRl1jVqSqPVTyrMtQxwV/BA735ABtQUTixj4Uv2UHZSXPeiuS7Rdb6/XxvDl7I=
X-Received: by 2002:a67:b245:: with SMTP id s5mr6419954vsh.200.1549546671319;
 Thu, 07 Feb 2019 05:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20190129015547.213276-1-swboyd@chromium.org> <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
In-Reply-To: <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Feb 2019 14:37:14 +0100
Message-ID: <CAPDyKFrrncpfEfbZJ1LHvqDbkc29CaJxZnXwh4Mz7PT6Efbctg@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Graham Roff <grahamr@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 08:58, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Viresh Kumar (2019-01-31 01:23:49)
> > Adding few folks to the thread who might be interested in this stuff.
> >
> > On 28-01-19, 17:55, Stephen Boyd wrote:
> > > This patch series is an RFC around how we can implement DVFS for devices
> > > that aren't your typical OPPish device (i.e. GPU/CPU). They don't have a
> > > strict set of frequencies that they have been tested at to derive some
> > > operating performance point. Instead they have a coarser set of
> > > frequency max or 'fmax' OPPs that describe the maiximum frequency the
> > > device can operate at with a given voltage.
> > >
> > > The approach we take is to let the devm_pm_opp_set_rate() API accept 0
> > > as a valid frequency indicating the frequency isn't required anymore and
> > > to make the same API use the clk framework to round the frequency passed
> > > in instead of relying on the OPP table to specify each frequency that
> > > can be used. Once we have these two patches in place, we can use the OPP
> > > API to change clk rates instead of clk_set_rate() and use all the recent
> > > OPP enhancements that have been made around required-opps and genpd
> > > performance states to do DVFS for all devices.
> >
> > Generally speaking I am fine with such an approach but I am not sure
> > about what others would say on this as they had objections to using
> > OPP core for setting the rate itself.
> >
> > FWIW, I suggested exactly this solution sometime back [1]
> >
> > - Drivers need to use two API sets to change clock rate (OPP helpers)
> >   and enable/disable them (CLK framework helpers) and this leads us to
> >   exactly that combination. Is that acceptable ? It doesn't look great
> >   to me as well..
>
> Agreed. I don't think anyone thinks this looks great, but I'll argue
> that it's improving OPP for devices that already use it so that we can
> remove voltage requirements when their clk is off. Think about CPUs that
> are in their own clk domain where we want to remove the voltage
> requirement when those CPUs are offline, or a GPU that wants to remove
> its voltage requirement when it turns off clks. The combination is
> already out there, just OPP hasn't solved this problem.
>
> The only other plan I had was to implement another API like
> dev_pm_set_state() or something like that and have that do something
> like what the OPP rate API does right now. The main difference being
> that the argument to the function would be some opaque u64 that's
> converted by the bus/class/genpd attached to the device into whatever
> frequency/voltage/performance state is desired (and sequenced in the
> right order too). And then I was thinking that runtime PM or explicit
> dev_pm_set_state() calls would be used to tell this new layer that the
> device was going to a lower power mode with some other number (sub-kHz
> integer?) and have that be translated again into some
> frequency/voltage/performance state.
>
> Either way, each driver will have to change from using the clk APIs to
> changes rates to something else like one of these APIs, so I don't see a
> huge difference. Drivers will have to change.
>
> >
> > - Do we expect the callers will disable clk before calling
> >   opp-set-rate with 0 ? We should remove the regulator requirements as
> >   well along with perf-state.
>
> Yes, that's the plan. Problems come along with this though, like shared
> resource constraints and actually knowing the clk on/off state,
> frequency, voltage, etc. at boot time and making sure to keep those
> constraints satisfied during normal operation.
>
> >
> > - What about enabling/disabling clock as well from OPP framework. We
> >   can enable it on the very first call to opp-set-rate and disable
> >   when freq is 0. That will simplify the drivers as well.
>
> It works when those drivers aren't calling clk_disable() directly from
> some irq handler. I don't think that's very common, but in those cases
> we would probably want to allow drivers to quickly gate and ungate their
> clks but then defer the sleeping stuff (voltages and off chip clks) to
> the schedulable contexts. We'll still be left with a small number of
> drivers that want to only call clk_prepare() and clk_unprepare() from
> within OPP and keep calling clk_enable() and clk_disable() from their
> driver. So introduce different APIs for those drivers to indicate this
> to OPP? And only do that when it becomes a requirement?
>
> Otherwise I don't really see a problem with the OPP call handling the
> enable state of the clk as well.

I think we also need to consider cross SoC drivers. One SoC may have
both clocks and OPPs to manage, while another may have only clocks.

Even it this may be fairly uncommon, we should consider it, before we
decide to fold in additional clock management, like
clk_prepare|unprepare() for example, behind the dev_pm_opp_set_rate()
API.

The point is, the driver may need to call clk_prepare|enable()
anyways, unless we make that conditional depending on a DT compatible
string, for example. Of course, because the clock prepare/enable is
reference counted, there may not be a problem in practice to have both
the OPP and driver to deal with it.

>
> >
> > > One nice feature of this approach is that we don't need to change the
> > > OPP binding to support this. We can specify only the max frequencies and
> > > the voltage requirements in DT with the existing binding and slightly
> > > tweak the OPP code to achieve these results.
> > >
> > > This series includes a conversion of the uart and spi drivers on
> > > qcom sdm845 where these patches are being developed. It shows how a
> > > driver is converted from the clk APIs to the OPP APIs and how
> > > enable/disable state of the clk is communicated to the OPP layer.
> > >
> > > Some open topics and initial points for discussion are:
> > >
> > > 1) The dev_pm_opp_set_rate() API changes may break something that's
> > > relying on the rate rounding that OPP provides. If those exist,
> > > we may need to implement another API that is more explicit about using
> > > the clk API instead of the OPP tables.
> > >
> > > 2) dev_pm_opp_set_rate(0) is an interesting solution to the problem of
> > > dropping the rate requirement. Is there anything better than this?

This seems like a reasonable approach to me.

At least it seams silly to invent a separate API and I can't think of
anything else that makes sense.

> > >
> > > 3) How do we handle devices that already have power-domains specified in
> > > DT? The opp binding for required-opps doesn't let us specify the power
> > > domain to target, instead it assumes that whatever power domain is
> > > attached to a device is the one that OPP needs to use to change the
> > > genpd performance state. Do we need a
> > > dev_pm_opp_set_required_opps_name() or something to be explicit about
> > > this? Can we have some way for the power domain that required-opps
> > > correspond to be expressed in the OPP tables themselves?

Is the about the multiple PM domains per device? I thought we have
already covered this case, or at least part of it [1].

Doesn't dev_pm_opp_set_genpd_virt_dev() and friends, help you with this, no?

> > >
> > > 4) How do we achieve the "full constraint" state? i.e. what do we do
> > > about some devices being active and others being inactive during boot
> > > and making sure that the voltage for the shared power domains doesn't
> > > drop until all devices requiring it have informed OPP about their
> > > power requirements?

Good question. What kind of problems do you see.

Will drivers fail to probe? Will the HW operate outside valid conditions?

> > >
>
> Any comments on these topics?
>

Kind regards
Uffe

[1]
https://lkml.org/lkml/2018/10/25/204
