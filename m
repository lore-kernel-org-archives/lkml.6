Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF885C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9F721919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nx2emEwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfBHHO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:14:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46788 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfBHHO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:14:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so1243229pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 23:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Zbv02WhigbgOtQTatMdliJnNcsU0eIBIQVfEsFeaVY=;
        b=Nx2emEwr8zbQ6N1taXTn5x0cAEE1+2KqPAaVFNEgsfq0UVILZARhXf2RUenl3F6n8P
         DtugoqIEre3jr3Xp49PAC1CoiE5RgDEI4Bb1UgwaCB8PsX5W5nt4+CjYHZHoZlz2VUm6
         vG0uPFvtm/OoRkv1Lp1jlYivo4YybpJDAwDSOkf+KYU7uSUfb/UkEYG/sZkak/kaaBkO
         ygHAysEj3aPkXTg8X+WhvJCIjZuiCV43BxHbxLbmal2P2v/IJlJjCXoW/4RD8dkXBgYE
         hXu1YHmX8ujz4c+SB+r2YssDlUBq2Dma0mDf4opUsfxQDMgINMbRXMaEBoBjMYBVPH3B
         SCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Zbv02WhigbgOtQTatMdliJnNcsU0eIBIQVfEsFeaVY=;
        b=Lnt1ZqtX9W2HB5J0qRfGAGpupWUxhzBdN02EOYhjiwqs+1ah72CQtCdomDeWw+s019
         dWVg9XtiICssgvTQH4Tj0YF1jjfICipdqL/5mCn1P/432sal4VNy6dEDqbdMOUHdoWqo
         vfnbCPvQWVCMyKrZcaYs2FXjxSYO9cH6vMG/4RteMmQ60ZnLKIcxmBFDuW97thc4FTsQ
         IVf0vBScEyrR7M/8sCZ4+Bvil9phhKhgZmTLg/zzhRT48Moma3nXX+d5Ssn7px5tUDW+
         uP/X48WOZ01NWTnjo003OKvoktKo4IbRfaGr4Wtxg3fwG8LlAmQIvUmI0Gk8t9y9z37Z
         Zmmw==
X-Gm-Message-State: AHQUAuaaQkM11yr3t0ns4hPrxGQTj6fazO7l/Ia/iQvqugj1FhjdbPMd
        NMN7lO4kteeKttPJaV+bLTG/ng==
X-Google-Smtp-Source: AHgI3Ib2TDV8KN89Ees+T4SditdYEJBvM/wh3npSuWOJwYPsspQSXfNfx+k0MS3DgkKNiPETAp/f1g==
X-Received: by 2002:a63:4f5e:: with SMTP id p30mr8643255pgl.71.1549610096892;
        Thu, 07 Feb 2019 23:14:56 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id i28sm2246910pfi.171.2019.02.07.23.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 23:14:55 -0800 (PST)
Date:   Fri, 8 Feb 2019 12:44:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     grahamr@codeaurora.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        vincent.guittot@linaro.org
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
Message-ID: <20190208071453.3ktqwu773z3jnaww@vireshk-i7>
References: <20190129015547.213276-1-swboyd@chromium.org>
 <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-02-19, 23:58, Stephen Boyd wrote:
> Quoting Viresh Kumar (2019-01-31 01:23:49)
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

I agree, that's why I wrote the dev_pm_opp_set_rate() API initially.

> > 
> > - Do we expect the callers will disable clk before calling
> >   opp-set-rate with 0 ? We should remove the regulator requirements as
> >   well along with perf-state.
> 
> Yes, that's the plan. Problems come along with this though, like shared
> resource constraints and actually knowing the clk on/off state,
> frequency, voltage, etc. at boot time and making sure to keep those
> constraints satisfied during normal operation.

But that isn't any different from drivers doing clk_disable directly,
right ? So that shouldn't worry us.

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

I am not sure I understood this well. The reference counting within
clk/regulator should let both the layers (driver and opp core) work
just fine. Why would a driver don't want OPP core to call
clk_prepare_enable() all the time ?

> Otherwise I don't really see a problem with the OPP call handling the
> enable state of the clk as well.

Right, so I would like that to be part of this series when this gets
implemented.

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

I don't remember any such cases, I may have forgotten about those
though.

> > > 2) dev_pm_opp_set_rate(0) is an interesting solution to the problem of
> > > dropping the rate requirement. Is there anything better than this?

I am okay with it. I don't want to invent another set of APIs to
enable / disable the resources.

> > > 3) How do we handle devices that already have power-domains specified in
> > > DT? The opp binding for required-opps doesn't let us specify the power
> > > domain to target, instead it assumes that whatever power domain is
> > > attached to a device is the one that OPP needs to use to change the
> > > genpd performance state. Do we need a
> > > dev_pm_opp_set_required_opps_name() or something to be explicit about

Yeah, we may need to come up with something like this eventually. I
had written something like that earlier, but then it wasn't required.

> > > this? Can we have some way for the power domain that required-opps
> > > correspond to be expressed in the OPP tables themselves?

Not sure I understood it. Can you explain with some example please ?

> > > 4) How do we achieve the "full constraint" state? i.e. what do we do
> > > about some devices being active and others being inactive during boot
> > > and making sure that the voltage for the shared power domains doesn't
> > > drop until all devices requiring it have informed OPP about their
> > > power requirements?

We need the boot-constraint framework for that. I think this is a
problem which we have currently as well. I am waiting for the
bus-scaling framework to get in, after that we will have lot of cases
where boot-constraints would be required and it won't be limited to
just clcd then.

-- 
viresh
