Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BABC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A62218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548931025;
	bh=ralH68wct4CDBtN6a0gUpMysmIoKpdk39I4Gx9T6h3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mGQ+2M40LLwUQJQuVbXGmto1o2C8/LUUT9g+8WRfrutp687jFjLx92VdGIif6fQ3v
	 2zVBnUiPUJKUQt/e05L59QV4PcY/KXCa0vFkv5RERv2ENhIkwwz7/Au0YhduFyAxY/
	 hrYJiaJQNfE8HD1Y+ql4EzIgEFZV+GjzwsJdt94M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfAaKhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:37:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43124 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfAaKhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:37:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so2350221otr.10;
        Thu, 31 Jan 2019 02:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGLE4sJVDSsEGFYGRHVCsYaVhZ0sVzVpHkt63HlKvRw=;
        b=bVCXtEhbXvd6UDfIDzMuCBEXCHCMJsXU3oLY8u02mNuKoa0ZvQb+aegGRzOD/iAlmH
         6tWU4rQBhiP96Ff5bAvzjqgCPXAT8r7wPXijJuWz2N86MCWwuGGDKYJlezOIsDlFwQYh
         mjeyCRxEDNjq0OKMP2FH6dD5XQ6zvGcC7woCvvDsWx5VL5HbYZCG2hHAhYuHB9RwlK1d
         gOa6UUhHRwZ2YTF/wETUCChIR8SZSn7dLq7qo/3Ufh70YQzwzGN0OW0F0nVmI6ANbI2b
         VKJD/bnA4ZSI0XHRT5u4QEenkrtV8r915ZIbWoyj5XtzRphnKLxEep0KKZ4HNAWnO3N9
         BUuA==
X-Gm-Message-State: AJcUukfNmvCaOPvckv8CFJXBAm2Uc5dOgtYpSlyIO0JPpiPRUFWVc25V
        T9swewumLkOTK6HTfE8jcDohQ4/waYKCHyt79lE=
X-Google-Smtp-Source: ALg8bN6BbvRAl58Nq8npf/BRg/NwNLNriBbg6tH0l/+M41Z2SVYSjsgy7CTcvJvDs5jsSc8o2qtzbBlTjnuBMI7MVfs=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr26119894otg.139.1548931021983;
 Thu, 31 Jan 2019 02:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20190129015547.213276-1-swboyd@chromium.org> <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <CAJZ5v0jY5Zjg0R7uC6ewJT5Pi-15Mohotj=im9k8w4THJSM0Dw@mail.gmail.com> <20190131100628.6ex6ic3kspuxxxt7@vireshk-i7>
In-Reply-To: <20190131100628.6ex6ic3kspuxxxt7@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Jan 2019 11:36:50 +0100
Message-ID: <CAJZ5v0jA0U1Z=AeRrEGXH2j+AenzNaiD+tV-yKwKanKwiNVW7g@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 31-01-19, 10:58, Rafael J. Wysocki wrote:
> > On Thu, Jan 31, 2019 at 10:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Adding few folks to the thread who might be interested in this stuff.
> > >
> > > On 28-01-19, 17:55, Stephen Boyd wrote:
> > > > This patch series is an RFC around how we can implement DVFS for devices
> > > > that aren't your typical OPPish device (i.e. GPU/CPU). They don't have a
> > > > strict set of frequencies that they have been tested at to derive some
> > > > operating performance point. Instead they have a coarser set of
> > > > frequency max or 'fmax' OPPs that describe the maiximum frequency the
> > > > device can operate at with a given voltage.
> > > >
> > > > The approach we take is to let the devm_pm_opp_set_rate() API accept 0
> > > > as a valid frequency indicating the frequency isn't required anymore and
> > > > to make the same API use the clk framework to round the frequency passed
> > > > in instead of relying on the OPP table to specify each frequency that
> > > > can be used. Once we have these two patches in place, we can use the OPP
> > > > API to change clk rates instead of clk_set_rate() and use all the recent
> > > > OPP enhancements that have been made around required-opps and genpd
> > > > performance states to do DVFS for all devices.
> > >
> > > Generally speaking I am fine with such an approach but I am not sure
> > > about what others would say on this as they had objections to using
> > > OPP core for setting the rate itself.
> > >
> > > FWIW, I suggested exactly this solution sometime back [1]
> > >
> > > - Drivers need to use two API sets to change clock rate (OPP helpers)
> > >   and enable/disable them (CLK framework helpers) and this leads us to
> > >   exactly that combination. Is that acceptable ? It doesn't look great
> > >   to me as well..
> >
> > I agree here.
> >
> > > - Do we expect the callers will disable clk before calling
> > >   opp-set-rate with 0 ? We should remove the regulator requirements as
> > >   well along with perf-state.
> >
> > Well, disabling clk affects HW in general, doesn't it?
>
> Yeah, but the regulator may be shared and is running at higher
> voltages just because of the clock requirement of the device getting
> disabled here. Or did I misunderstood what you wanted to say ?

What I wanted to say is that if the caller is required to disable clk
beforehand, that may be as good as setting its rate to zero already.

> > > - What about enabling/disabling clock as well from OPP framework. We
> > >   can enable it on the very first call to opp-set-rate and disable
> > >   when freq is 0. That will simplify the drivers as well.
> >
> > That sounds compelling, but I guess there are cases in which you can
> > gate the clock regardless of the frequency setting.  How would that
> > work then?
>
> Can you give any example here ? I am not sure I understood the concern
> here.

It looks like I was confused somehow, never mind. :-)
