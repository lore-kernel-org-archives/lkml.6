Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A465FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747A3218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJuJCZMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfBHJqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:46:04 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44043 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfBHJqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:46:02 -0500
Received: by mail-vs1-f65.google.com with SMTP id u11so1709704vsp.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 01:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfKs0cXhIUgqW2i/K32NFOhzEM/EXJ6bJiU4eWT25uU=;
        b=nJuJCZMJrh7vKg9Zv4iLXsQ28BYMgQu4bHB7UGiiBCanVI+x9NvvK5glbimj8pY/Ft
         6jKV4Grhq2wLv+PcO8Azwjypgs5zWQkZkANlw3algP0sE1CUvkXuzu4nTyzZQGPRVIh2
         AiOQxvjRfKNI8lerE4U0EhEKtqisNrs712EokywBJroFQqLZb5IAOJMGsl5C3G3MbOST
         91OIzPuZJi6aPOjnpO9EK84JqVnjF6OS6uTFe+QM1VfrjhqGLN6ITJo7LTjk0qtwpGlS
         NLlJJIeC0vhd9MHv+Ccmbm4nnnpu+vhm7viTHI9NS/Vr/09kHo5zhzQ9filcQheaI+/T
         gHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfKs0cXhIUgqW2i/K32NFOhzEM/EXJ6bJiU4eWT25uU=;
        b=JtZMYlkPAnTO4NsmjEV/rwyYBfzm8ntDSXxCwbYWVLVa4tugy9Ifs/Y0HRjsIl0R7G
         9b2NKgUL/Q5N9s/Sv14jkU2xZWKiofcbMkIjyyOPSCT/csbzJw4h7Ayni2NT5BS/w28I
         icbW8s8jOqqARpQhXdv2BEbvP4qbI1nd8YgVQmhw91OpfhldvKa7lSbnXin/Y3dhOjzw
         qcgUsgI6O8EE45wRcDgdc7b127702RUOjwsm4bSJgzNo62cG+aBhX426Z3+85yftsavA
         BqSHnzydEJZQEurgu9S7LaKg9hvx8bs07e+9zUb6KL/BKR3KI0KlzkgDvpvP2rtDwjDi
         d+kw==
X-Gm-Message-State: AHQUAuYqeWXFYrY8WMSjrZPVnvAPAxYqY9mOS7U1N7gVVz0TZUnmAnmZ
        6YcdJFeAMi35piNGDiQ5Sg8eADIHRq+cUA2dQf5oVQ==
X-Google-Smtp-Source: AHgI3IZf3vloPldI00gTcokLoccPjaRyuEgbhzG08EySxv2JyyhapMQMdUIwI9hmycIocKAjCOuAILiU7myhaRu+m5g=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr9063224vsc.34.1549619161058;
 Fri, 08 Feb 2019 01:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20190129015547.213276-1-swboyd@chromium.org> <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
 <CAPDyKFrrncpfEfbZJ1LHvqDbkc29CaJxZnXwh4Mz7PT6Efbctg@mail.gmail.com> <20190208071726.urevxs5a3vaf7gwh@vireshk-i7>
In-Reply-To: <20190208071726.urevxs5a3vaf7gwh@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 Feb 2019 10:45:24 +0100
Message-ID: <CAPDyKFrXWAzDChd3d2acQnF6GZw57+g6XeNtHo29q3i1qjidnQ@mail.gmail.com>
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

On Fri, 8 Feb 2019 at 08:17, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 07-02-19, 14:37, Ulf Hansson wrote:
> > I think we also need to consider cross SoC drivers. One SoC may have
> > both clocks and OPPs to manage, while another may have only clocks.
>
> We already have that case with CPUs as well and dev_pm_opp_set_rate()
> takes care of it.

I think you may have misunderstood my point. Or maybe I don't get yours. :-)

What if there is no OPP at all to use, then dev_pm_opp_set_rate() is
just a noop, right? In this scenario the driver still need to call
clk_set_rate().

How do we cope with these cases?

>
> > Even it this may be fairly uncommon, we should consider it, before we
> > decide to fold in additional clock management, like
> > clk_prepare|unprepare() for example, behind the dev_pm_opp_set_rate()
> > API.
> >
> > The point is, the driver may need to call clk_prepare|enable()
> > anyways, unless we make that conditional depending on a DT compatible
> > string, for example. Of course, because the clock prepare/enable is
> > reference counted, there may not be a problem in practice to have both
> > the OPP and driver to deal with it.
>

Kind regards
Uffe
