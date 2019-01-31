Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E5CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BDA218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gw4l41l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfAaKl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:41:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47068 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfAaKl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:41:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so1278387ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+Od3GYG9A96O/IYdtRezuDGD30W8PJWMn/sozdI8xg=;
        b=gw4l41l7Q6ZQwGbagAjjtwZH4kEvG8etqpSz7PQapVJhOZy9Rv2O9aJWR6419uGSIA
         PzJwrzK52kafj/1+VRz2Dr+TSpGORL8I5SEL3F3UBbeCVkLXLpWpbaLFLcmfdlAcC2OC
         o5mQA0C9hiZ4t6ivlpJ5LI7qKeKYBcVXnKbZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+Od3GYG9A96O/IYdtRezuDGD30W8PJWMn/sozdI8xg=;
        b=SnRlrDNytFar8kBc9+O6QEviwq0Cg83fuhtQ8VGhg4haDwfEZ6XZNs9J0rR0apLo3T
         galvJQ9qSa1wDihcIRpTKgz7c6fv/otpgT7F27neiVQBwxkxBlfvo6PYH0nrPfuQy05+
         QOwQE7AIYvwKoaBwaR9215gbTdhZz8k3sVeEOi2JSRz2yWSEFLDQKhpuAZw7OJRzbp/w
         xe9RgTdovGYpgBr53lEmy+LXeFpz/Nn1QcuzMGB89YQxON1XUt4MqMkGOfQlSPUQGN2/
         FtAn/aUDeteQzeQ+EmP9vSo6nWizbJJ8bPBPuStbn6tREuJeg0rQlvromlgczDfGSLiW
         Xiug==
X-Gm-Message-State: AJcUukcXiY2VJN3U8IOiCb2eZJWS0Eby3PWTZoHHSXZX5U716n9jnZPg
        s/JD3HCVUomOKDF/32+3Xq+mkYn5Z2k=
X-Google-Smtp-Source: ALg8bN72hbNCvkZmnlCFFZQZGZf4PYorbYRLZlID3sPDSqoTwlX+tVBDn5s7KYaoiV3hf0+dHfLGzA==
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr34694140pls.12.1548931316096;
        Thu, 31 Jan 2019 02:41:56 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id p67sm6340873pfg.44.2019.01.31.02.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 02:41:55 -0800 (PST)
Date:   Thu, 31 Jan 2019 16:11:53 +0530
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
Message-ID: <20190131104153.ojyp3razjbzm6pnc@vireshk-i7>
References: <20190129015547.213276-1-swboyd@chromium.org>
 <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <CAJZ5v0jY5Zjg0R7uC6ewJT5Pi-15Mohotj=im9k8w4THJSM0Dw@mail.gmail.com>
 <20190131100628.6ex6ic3kspuxxxt7@vireshk-i7>
 <CAJZ5v0jA0U1Z=AeRrEGXH2j+AenzNaiD+tV-yKwKanKwiNVW7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jA0U1Z=AeRrEGXH2j+AenzNaiD+tV-yKwKanKwiNVW7g@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-01-19, 11:36, Rafael J. Wysocki wrote:
> On Thu, Jan 31, 2019 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 31-01-19, 10:58, Rafael J. Wysocki wrote:
> > > On Thu, Jan 31, 2019 at 10:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > Adding few folks to the thread who might be interested in this stuff.
> > > >
> > > > On 28-01-19, 17:55, Stephen Boyd wrote:
> > > > > This patch series is an RFC around how we can implement DVFS for devices
> > > > > that aren't your typical OPPish device (i.e. GPU/CPU). They don't have a
> > > > > strict set of frequencies that they have been tested at to derive some
> > > > > operating performance point. Instead they have a coarser set of
> > > > > frequency max or 'fmax' OPPs that describe the maiximum frequency the
> > > > > device can operate at with a given voltage.
> > > > >
> > > > > The approach we take is to let the devm_pm_opp_set_rate() API accept 0
> > > > > as a valid frequency indicating the frequency isn't required anymore and
> > > > > to make the same API use the clk framework to round the frequency passed
> > > > > in instead of relying on the OPP table to specify each frequency that
> > > > > can be used. Once we have these two patches in place, we can use the OPP
> > > > > API to change clk rates instead of clk_set_rate() and use all the recent
> > > > > OPP enhancements that have been made around required-opps and genpd
> > > > > performance states to do DVFS for all devices.
> > > >
> > > > Generally speaking I am fine with such an approach but I am not sure
> > > > about what others would say on this as they had objections to using
> > > > OPP core for setting the rate itself.
> > > >
> > > > FWIW, I suggested exactly this solution sometime back [1]
> > > >
> > > > - Drivers need to use two API sets to change clock rate (OPP helpers)
> > > >   and enable/disable them (CLK framework helpers) and this leads us to
> > > >   exactly that combination. Is that acceptable ? It doesn't look great
> > > >   to me as well..
> > >
> > > I agree here.
> > >
> > > > - Do we expect the callers will disable clk before calling
> > > >   opp-set-rate with 0 ? We should remove the regulator requirements as
> > > >   well along with perf-state.
> > >
> > > Well, disabling clk affects HW in general, doesn't it?
> >
> > Yeah, but the regulator may be shared and is running at higher
> > voltages just because of the clock requirement of the device getting
> > disabled here. Or did I misunderstood what you wanted to say ?
> 
> What I wanted to say is that if the caller is required to disable clk
> beforehand, that may be as good as setting its rate to zero already.

Right, but that doesn't mean that the requirements put on the
regulator and genpd are gone as well and that is why I favor the OPP
core to handle all the parts otherwise write the rules explicitly. If
the OPP core doesn't disable the clock and the caller also hasn't done
the same, then disabling the genpd/regulator may break things up.

-- 
viresh
