Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BABC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B234421924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dx/QfRnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfBHKbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:31:52 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:47037 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfBHKbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:31:51 -0500
Received: by mail-vk1-f194.google.com with SMTP id j23so688044vke.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 02:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MerumxiTvhdlEtvDPR2yIGJ6zc7jexdulFt9GY7zil4=;
        b=Dx/QfRnHnPNzCNUHKO+nqiMZianm9l0TJYEw2UhpQLBCbzk6Fcpda0McUiSPvLZcJU
         AjqEQFPbwL6HtEMLtVjktzO3d5eatBMq9w/xWA1l+3Vhl7/NGdbaf42yH+Izr4lfFYxP
         izgCXZeglDapb8XeGZdrSygUgt4y8+vdN97tmdnz+pyzvwGkuEQyB3StsFeEwMjPs/+x
         LiI/iwo812aF0stZB2rpazXd5/Z7mZ5j/uWLBf1gPCY3UxuILzDEoFFAsBVxIplOFEHF
         OojoEa9WpaneYdrovdpwj6Y/9pzMhPnXaWtMc0HNgy76NS4+2WPNvlr0eWHDuy0Y3jrb
         UN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MerumxiTvhdlEtvDPR2yIGJ6zc7jexdulFt9GY7zil4=;
        b=lUwtEhjysbTz97T767QOt6mzDVv0u6Y6t+uPp4JHGlYEBWBByE4StH0g5aSjl7O7hB
         MIcgzymreOZXmKjYGWdedSo95un5cnB8lCMw/FTjWv6BqN4awp/IKp4Ydqt2pcT/miu2
         bpsd7nj5MX4YkC4FvtMT+k7kn7Vj7IzsalsRJdUL8dQh0Dknw66GWyTkwt4VcPqLUUFs
         1CjerJta4v0E8CWtPw2UlwBlW2TVYc7qAgHwLMEApfWyuZ3A/qoJ8mEjnHWt4cNQ7icu
         B8CYtfc1REJdYCFL9zUEr4tMLoLytQxma8fItGAViF4Iasgb672T5s6iOBFkUa84frCm
         oi1w==
X-Gm-Message-State: AHQUAub9tow83AzIHXnzIru4i3tOQaa1wYbkIwiHlScV90ZNAsRxAr6i
        FEZLMn8DDCl1jALOkELyG1xiEUNDdRw7VCAfhKonjw==
X-Google-Smtp-Source: AHgI3IZR+QeK03E3RGrIR+LU9LMsqPR1isp5ByW4vxzgwrklOBUP8T+PDDzROfUAl7Q23Jd6QY8xZWW2xYTO1PhRlZE=
X-Received: by 2002:a1f:1c81:: with SMTP id c123mr8685918vkc.52.1549621909965;
 Fri, 08 Feb 2019 02:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20190129015547.213276-1-swboyd@chromium.org> <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
 <CAPDyKFrrncpfEfbZJ1LHvqDbkc29CaJxZnXwh4Mz7PT6Efbctg@mail.gmail.com>
 <20190208071726.urevxs5a3vaf7gwh@vireshk-i7> <CAPDyKFrXWAzDChd3d2acQnF6GZw57+g6XeNtHo29q3i1qjidnQ@mail.gmail.com>
 <20190208100529.l2y75ua3bfa6nnyx@vireshk-i7>
In-Reply-To: <20190208100529.l2y75ua3bfa6nnyx@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 Feb 2019 11:31:13 +0100
Message-ID: <CAPDyKFpmZNW7KgsgagD_6tKTQ07AJS7Kc=AGCQmMpNASuOG-Dg@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
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

On Fri, 8 Feb 2019 at 11:05, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-02-19, 10:45, Ulf Hansson wrote:
> > On Fri, 8 Feb 2019 at 08:17, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 07-02-19, 14:37, Ulf Hansson wrote:
> > > > I think we also need to consider cross SoC drivers. One SoC may have
> > > > both clocks and OPPs to manage, while another may have only clocks.
> > >
> > > We already have that case with CPUs as well and dev_pm_opp_set_rate()
> > > takes care of it.
> >
> > I think you may have misunderstood my point. Or maybe I don't get yours. :-)
>
> It was me. I thought you are talking about regulators and that is what
> is already managed, i.e. to work with or without regulators.
>
> > What if there is no OPP at all to use, then dev_pm_opp_set_rate() is
> > just a noop, right? In this scenario the driver still need to call
> > clk_set_rate().
> >
> > How do we cope with these cases?
>
> Yeah, that would be a problem and hacking the OPP core may not be the
> right solution :(

I guess one simple way forward could just be to check if there is an
OPP handle/table available, then use dev_pm_opp_set_rate(). When no
OPP handle/table, use clk_set_rate() *instead*, not both.

That could work, don't you think?

Kind regards
Uffe
