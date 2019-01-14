Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8583FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DCB206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ib3tAHyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfANQxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:53:08 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:32792 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfANQxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:53:07 -0500
Received: by mail-vk1-f193.google.com with SMTP id d201so5027566vka.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tUttfEcOxtLxbzMjVC+wuWOy2MPi+P43KgBXi8LdE4=;
        b=Ib3tAHyViiKppL7q5i1Whj2NqOK04EE8ggruqMru05Ly7C21BjrJIdyvJ61mRvebSs
         KwLETgmPLqFKX5qVa8cCHuVPcx4d/qN3qPumWVTkByoFjwbhHDS8BzZhaGWjGueD9aNe
         Evg0bR9kD1qdkEPJH4o5Of3pXL4xcmOD0FTzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tUttfEcOxtLxbzMjVC+wuWOy2MPi+P43KgBXi8LdE4=;
        b=eNPn6JUU9v0CSatcwzTr/RRsL174rdbnML0YohNwqac5kHq8BRf/d3T2uMQwGrcQUk
         P4pAV+j774T3b6iwyQgoznF0Tvr7scneXYH2yVLb2s5Ry1z9a/ZTpmE74j83YMUV2uZi
         UiRmq5bDwgBjOycot1NomRYepyLV7ke16QLR4px8GYqaRLbgZjYLU5oMmyo+nMaMtz/F
         bauyo+R1wSZOmrPrP4covQSMUuofci9GXfN6XarEYs78iky0Rf8k+tZquCye77tHRxXJ
         4xGWmsjEqMIVn3hEoCrgFiDhCXceS9tMNKLGSUKW3PFzl3sN07ZB4MZ6Ydly6E2Hv/iX
         g5Cg==
X-Gm-Message-State: AJcUukciVquOECDGpveTEl8AouqcvKy+uhXPqKqrj5EmPrXhKfiw3fcd
        U0G5cjix7NWFpoy/A3t6bnFNkavMciEu245UzXUp7g==
X-Google-Smtp-Source: ALg8bN5yXM8eVgw7htg/wjuQ3aORGcT5UV8su+yHheVt9koAvHkwAONG4zUPegC1S4ggARJrKIbJH8x4eeg4JFlc5hg=
X-Received: by 2002:a1f:9ec9:: with SMTP id h192mr10097312vke.68.1547484785252;
 Mon, 14 Jan 2019 08:53:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <CAJZ5v0h+m6sR=nFFXSMv_FKy=y0W4mSd3W34qW48-BpnGBPcZQ@mail.gmail.com> <CAHLCerM+bbXbUzoqm_5oPw_o-zEFCN4FjXRGVVqYkGYzC5upDA@mail.gmail.com>
In-Reply-To: <CAHLCerM+bbXbUzoqm_5oPw_o-zEFCN4FjXRGVVqYkGYzC5upDA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 14 Jan 2019 22:22:54 +0530
Message-ID: <CAHLCerOH05ouDKuhe9Cz-qh-tJcqumHbrv7NqSc3STcH_UN-HA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Thermal throttling for SDM845
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 4:04 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Mon, Jan 14, 2019 at 3:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Jan 14, 2019 at 11:22 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > >
> > > Add support for thermal throttling on SDM845.
> > >
> > > We introduce a generic flag to be used by cpufreq drivers to tell the
> > > cpufreq core to auto-register a thermal cooling device.
> > >
> > > There are a few miscellaneous fixes to keep checkpatch happy.
> > >
> > > If this approach is acceptable I can send a series converting other cpufreq
> > > drivers to use this flag and get rid of driver code.
> > >
> > > Amit Kucheria (9):
> > >   [ALREADY QUEUED] cpufreq: qcom-hw: Move to device_initcall
> > >   drivers: thermal: of-thermal: Print name of device node with error
> > >   drivers: cpufreq: Add thermal_cooling_device pointer to struct
> > >     cpufreq_policy
> > >   cpufreq: Add a flag to auto-register a cooling device
> > >   cpufreq: Replace open-coded << with BIT()
> > >   cpufreq: qcom-hw: Register as a cpufreq cooling device
> > >   arm64: dts: sdm845: Increase alert trip point to 95 degrees
> > >   arm64: dts: sdm845: wireup the thermal trip points to cpufreq
> > >   thermal: cpu_cooling: Clarify error message
> > >
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 193 +++++++++++++++++++++++----
> > >  drivers/cpufreq/cpufreq.c            |  13 ++
> > >  drivers/cpufreq/qcom-cpufreq-hw.c    |   5 +-
> > >  drivers/thermal/cpu_cooling.c        |   2 +-
> > >  drivers/thermal/of-thermal.c         |   4 +-
> > >  include/linux/cpufreq.h              |  34 +++--
> > >  6 files changed, 210 insertions(+), 41 deletions(-)
> >
> > Would it be possible to split this series so as to put the cpufreq
> > patches separately?
>
> Sure, will send out another version.

I've now sent out a separate series just tackling the
auto-registration feature of a cooling device[1]. So the only bits in
this series needing separate review are patches 2, 7,8 and 9.

I'll wait couple of days to get some review on the other series before
sending out another version of the remaining patches listed above.
Feel free to comment on them in this thread, in the meanwhile.

Thanks.

[1] https://lore.kernel.org/patchwork/cover/1031909/
