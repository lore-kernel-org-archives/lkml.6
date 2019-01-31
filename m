Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02C5C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D1E20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPdxFMKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbfAaKGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:06:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43746 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731927AbfAaKGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:06:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so1250632plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=liJiLXD990nItDduxgphW2/p5eBWRLLq8tBuK2uvFh4=;
        b=DPdxFMKOyrIpEo9p8To/71lXGKNLd22hIHO5ahdQDvCbW4aRg7DPMO/gD2ppZhXoHv
         flGbHbh/Z7tSHdjJZRzb1WV/+uksvJK2NMUY8JAkrE83dXucrooIwGCsCY5mDARPY5lm
         gQBbPFmnizHOzNAszS68wLa+ib2qgfEPqLoa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=liJiLXD990nItDduxgphW2/p5eBWRLLq8tBuK2uvFh4=;
        b=uRLBxiDUJ1HFBSyiltlIQqEvHNo+t9nbglQaEtU/ewLMcBwOSzIJjZq9klhz/eQZMV
         JPKvMwRrrqgJ9rtgRlHM+N86KTmPsbGmpilug1DKEZUboaRYjaxb8MGU0AQyJA7AE9HW
         mRYcFz0DuKyIll40lY9x+c3u0vnVuVkn8Ne151Ff3+2a4Al1E0UGlRBmAKc7lbreNiTh
         PD4rr0i6XGgJfqu6ld+k6PkEpWs193ciGmYrcbd1bmZd9NhCzdJeDgATve33qfmMJwMP
         bS1odb3dVBvajlfWC9UYc807vn9dC/QDuwzNEryzly4/BSO2aNLvwBwePoqt919+DCKN
         EtrQ==
X-Gm-Message-State: AJcUukfzaR/eO61rShm59qfD7F4Jyx7gcbDf11AW5vg4JmZg6U5pDXnh
        3DCzSBC2WYqx3jtCovU8UoEJVw==
X-Google-Smtp-Source: ALg8bN7mkePrjw1qh55w0aIXAH/Dj8SA3ZHDOp7aHkkylR/KvA3d9kdmLHK4YOrjaBifH13qMghwoA==
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr32586245plp.172.1548929191204;
        Thu, 31 Jan 2019 02:06:31 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id n21sm5749063pfg.84.2019.01.31.02.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 02:06:30 -0800 (PST)
Date:   Thu, 31 Jan 2019 15:36:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        grahamr@codeaurora.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
Message-ID: <20190131100628.6ex6ic3kspuxxxt7@vireshk-i7>
References: <20190129015547.213276-1-swboyd@chromium.org>
 <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <CAJZ5v0jY5Zjg0R7uC6ewJT5Pi-15Mohotj=im9k8w4THJSM0Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jY5Zjg0R7uC6ewJT5Pi-15Mohotj=im9k8w4THJSM0Dw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-01-19, 10:58, Rafael J. Wysocki wrote:
> On Thu, Jan 31, 2019 at 10:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
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
> I agree here.
> 
> > - Do we expect the callers will disable clk before calling
> >   opp-set-rate with 0 ? We should remove the regulator requirements as
> >   well along with perf-state.
> 
> Well, disabling clk affects HW in general, doesn't it?

Yeah, but the regulator may be shared and is running at higher
voltages just because of the clock requirement of the device getting
disabled here. Or did I misunderstood what you wanted to say ?

> > - What about enabling/disabling clock as well from OPP framework. We
> >   can enable it on the very first call to opp-set-rate and disable
> >   when freq is 0. That will simplify the drivers as well.
> 
> That sounds compelling, but I guess there are cases in which you can
> gate the clock regardless of the frequency setting.  How would that
> work then?

Can you give any example here ? I am not sure I understood the concern
here.

-- 
viresh
