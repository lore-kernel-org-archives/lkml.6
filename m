Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E74C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D6120B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548928721;
	bh=WyuRz3FAuL0GeNECNl3ySe5BrZg8WRASwrzJTqXiegg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rSKzH8Bj3O3Wx/iMAMbOWWhOuvIGgXONJWA6cgBf8Mp7BAD/xFhyqJhy5wvyJ38gf
	 +4gMTcZ8n6EfbQJFNYWQZW8pWDCY2Wl6H/5v8ZY6uy6jEpb+2DS3eLUCOEVvtoma4V
	 fyqjd/KF3dNN3Dije6IAZ7cpSYBBN/0JEOhgX51Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfAaJ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:58:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45252 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfAaJ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:58:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so2182280oie.12;
        Thu, 31 Jan 2019 01:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HaQjbfS7FrYlrpLEePwCO05qGMrqLC1DJNvUWq7MyM=;
        b=NGvYnB6wF3nLVo9nGBVBdz7VMnjx5CPStuajpShwIUDi2CP2thRUOQE4efQVCjh7gR
         OHFYIoHiu9QcNsZ+ShPdfWTwrvxoPp5dmQNEtI50fSiJDilmVLLsCsVObH25U3XN/vG4
         JD3176LnC1UVmLgOoQeMKAzLRA/bGmtDI7R43zZAD/fQ9JreYhMYUQDZmDHR2Jasxlmt
         WGkPOtC8z1VQhDZ5ra0ZhklmjsmLVsw3deiggVu40+EuHgOyBwiEAKP9Y2Di4XAxWbAI
         59sFlb7s8T/EfBunvCL6SMFf/K2PLFtMvuKRVNpMG2Ubt2iEi/kKAlbtQ+FOjo4IdjeR
         oXEA==
X-Gm-Message-State: AJcUuke4TxPuX1SYrIIi0I/2tlD9cXZuwssxagW5Y1zx4afwNIoo7ln9
        bh2bdwxbFnc+08gELRcRvpjttB3M76m8Xo3li8WSXQ==
X-Google-Smtp-Source: ALg8bN7nXANm5mx4Lc+ZLo2FNaxDhtrriMP3WIJD7UFoFkm8ZhQPopr/tHCRnYI8TncmIVynkT0/92NiXJbNeFxvrwc=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr14248256oix.246.1548928718301;
 Thu, 31 Jan 2019 01:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20190129015547.213276-1-swboyd@chromium.org> <20190131092349.fksfqemm23qddkhw@vireshk-i7>
In-Reply-To: <20190131092349.fksfqemm23qddkhw@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Jan 2019 10:58:26 +0100
Message-ID: <CAJZ5v0jY5Zjg0R7uC6ewJT5Pi-15Mohotj=im9k8w4THJSM0Dw@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 10:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Adding few folks to the thread who might be interested in this stuff.
>
> On 28-01-19, 17:55, Stephen Boyd wrote:
> > This patch series is an RFC around how we can implement DVFS for devices
> > that aren't your typical OPPish device (i.e. GPU/CPU). They don't have a
> > strict set of frequencies that they have been tested at to derive some
> > operating performance point. Instead they have a coarser set of
> > frequency max or 'fmax' OPPs that describe the maiximum frequency the
> > device can operate at with a given voltage.
> >
> > The approach we take is to let the devm_pm_opp_set_rate() API accept 0
> > as a valid frequency indicating the frequency isn't required anymore and
> > to make the same API use the clk framework to round the frequency passed
> > in instead of relying on the OPP table to specify each frequency that
> > can be used. Once we have these two patches in place, we can use the OPP
> > API to change clk rates instead of clk_set_rate() and use all the recent
> > OPP enhancements that have been made around required-opps and genpd
> > performance states to do DVFS for all devices.
>
> Generally speaking I am fine with such an approach but I am not sure
> about what others would say on this as they had objections to using
> OPP core for setting the rate itself.
>
> FWIW, I suggested exactly this solution sometime back [1]
>
> - Drivers need to use two API sets to change clock rate (OPP helpers)
>   and enable/disable them (CLK framework helpers) and this leads us to
>   exactly that combination. Is that acceptable ? It doesn't look great
>   to me as well..

I agree here.

> - Do we expect the callers will disable clk before calling
>   opp-set-rate with 0 ? We should remove the regulator requirements as
>   well along with perf-state.

Well, disabling clk affects HW in general, doesn't it?

> - What about enabling/disabling clock as well from OPP framework. We
>   can enable it on the very first call to opp-set-rate and disable
>   when freq is 0. That will simplify the drivers as well.

That sounds compelling, but I guess there are cases in which you can
gate the clock regardless of the frequency setting.  How would that
work then?
