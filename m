Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F36EC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE2B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVrr2m3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfAUJoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:44:08 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41533 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfAUJoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:44:05 -0500
Received: by mail-vk1-f195.google.com with SMTP id t127so4442654vke.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Civ2EZOz8Odxk1Vw4YH1JP5x5ipWUzMNpI7y9HaNTHI=;
        b=VVrr2m3ZMWlt7xRjXdd7JtQjlKY/beb0E/kGCn3tPo30JaH5ghAkVoOEf69qjNO73k
         LLUmO43cundSJdX9rz5kXX8/DR3Yy7EEWf/Jp3nwj+az4x1S+U02tVoQiF37YPGBAQOU
         HmDW00SLewGg/FtUnKpad1X5CrqYPtCMVYcng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Civ2EZOz8Odxk1Vw4YH1JP5x5ipWUzMNpI7y9HaNTHI=;
        b=mRRmdqHIot76wpiZ+fgz9YV4+K2merpuovmi3soCjnwCMNQPpJcAQmaTyrjBitOnur
         uo/1SMi0myx2/BMHKSf1yOruPDd4OV3yjuKtpPYjGsLd/Rc0pl/N7H0zVHD4qs2RFrCx
         dzjbmkfXCdoX50SXsyAhdXPLfycch+lQufsQPljUdMK9SXnnI09eRWOqFEZlCstuVRLj
         VTiap2HwuLyCGTwRb1t9zPli0xCNqF2usVKMQ4HWTrotWy1JKWSd/dKsdP9ITUQg82sK
         I0p7yIih6wZ5ZvQFK37GyQXDzPuh/AmXnV1J89sHeVz4zdMi7e5Z+zkNMtYsh1330Z6p
         QCkw==
X-Gm-Message-State: AJcUukeMjbqXdAbbi+JzCJ9U0k+dmAmFP5+YckEdO0CBw4HIjdIJbizs
        8OXnjrz1Hq1b6Z7bVNuI5IqjWWXFIgh3EzZfV44N3A==
X-Google-Smtp-Source: ALg8bN5vFPXLM0E3s0vy/t2gcmICskZlA0/g7rivqw2RxKMzxiqIW5kyWrFX5o8xgbU8xVwN2XKVDjlxnSISEgyq9Eo=
X-Received: by 2002:a1f:a8c5:: with SMTP id r188mr11826355vke.44.1548063843992;
 Mon, 21 Jan 2019 01:44:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <2de2d178380525191d99d6c3619ad8c45efdbab4.1547458732.git.amit.kucheria@linaro.org>
 <20190117055730.7hxe37ngcubo6htw@vireshk-i7> <CAJZ5v0j2-RPckRigk+gjo4ffiB+04VE_v6Dnw90E-Q7X2knpvA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j2-RPckRigk+gjo4ffiB+04VE_v6Dnw90E-Q7X2knpvA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 21 Jan 2019 15:13:52 +0530
Message-ID: <CAHLCerNZuJ3+s+gNMURVJAk+fgfhfmTKH58kyCDPwpcm+Q7W3A@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] thermal: cpu_cooling: Clarify error message
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 4:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 17, 2019 at 6:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 14-01-19, 15:51, Amit Kucheria wrote:
> > > Make it clear that it is a failure if the cpufreq driver was unable to
> > > register as a cooling device. Makes it easier to find in logs and
> > > grepping for words like fail, err, warn.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  drivers/thermal/cpu_cooling.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > > index dfd23245f778..6fff16113628 100644
> > > --- a/drivers/thermal/cpu_cooling.c
> > > +++ b/drivers/thermal/cpu_cooling.c
> > > @@ -774,7 +774,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
> > >
> > >               cdev = __cpufreq_cooling_register(np, policy, capacitance);
> > >               if (IS_ERR(cdev)) {
> > > -                     pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
> > > +                     pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
> > >                              policy->cpu, PTR_ERR(cdev));
> > >                       cdev = NULL;
> > >               }
> >
> > Always keep such cleanup patches at the top, so the maintainers can
> > pick them up easily even if the entire series doesn't get in.
>
> Actually, if nothing in the series depends on this change and this
> change doesn't depend on anything in the series, why is it part of the
> series at all?

Indeed, I should've separated this from the series. Done now.
