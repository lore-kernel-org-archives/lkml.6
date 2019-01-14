Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C083C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C4E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547461652;
	bh=SaG0E0sq+CSmRU30q1klmKYEuzC3qRvOoJjKA/EvSIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e/AkxsfRRnH185ayh3lFeT9p3qJW3u/ODtAOEFrdo44qElv+5zpa1L7W/DRqD0tCA
	 FHQ9hZEPDX/YteaMFGmEYh7t0xTqhe6LtnPS5VdZNnUvH3Zg3oCg6xuuWne8icNTNh
	 wqfKaa8IwXWrG4JZjfujxwo3x4EQ4oMXYhEFzxeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfANK1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:27:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42754 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANK1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:27:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so18816876otk.9;
        Mon, 14 Jan 2019 02:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66pnsJcjjtoff7kyX1q2rOaQSsSN+m5fm4jlCvbC+o8=;
        b=d1biCIt5JY7mp99KHCwjg4ldyS2aDs4MLTkJye7x0SuikyBuU1gXWhHmpgmpiX2aXS
         XAtg2fqGMLQm0URT0aX2REJ/Mcjk2U6GJ7RZ4GlV6GL0y/oJ9DKhx5AemGBxKcvu3SPd
         a+YNTG0gscULWdiB7fWEndcBi1VAxeTak9kDuTFzLGEwKT1ORynKmg/T9APSRkwk777X
         x3B9jCJSfdIaQzLT4MHR2CdRbpjBNTgOcUiPYKpv0AdEbtU4gLrM2QGOKUnQEFMF+IBW
         Sm3mkaR1sh0xGCbB//sRj6zHusup3A/pR9mswlYjVrcu4De+Rnz2kELxGJrk2YG6QkPK
         cL2g==
X-Gm-Message-State: AJcUukfqWT+UjIm7/QbSAZcs79hVKWi37V/22kIYyH1WD+bsKcnrzUAV
        LpScqHhsMtia3+UgVXmymUuGpnHiFC1IMNGeyV8=
X-Google-Smtp-Source: ALg8bN51Uyye2bXDKzJeH7Hc/JZ2S+KFMbLlBzI1u7JM1Lz7AUd8vtJDWrgEMcYdRLOoKLF/DocNZ5yvg/ULcLbHeqk=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr17157550oti.258.1547461649194;
 Mon, 14 Jan 2019 02:27:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Jan 2019 11:27:17 +0100
Message-ID: <CAJZ5v0h+m6sR=nFFXSMv_FKy=y0W4mSd3W34qW48-BpnGBPcZQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Thermal throttling for SDM845
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        bjorn.andersson@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>,
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

On Mon, Jan 14, 2019 at 11:22 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Add support for thermal throttling on SDM845.
>
> We introduce a generic flag to be used by cpufreq drivers to tell the
> cpufreq core to auto-register a thermal cooling device.
>
> There are a few miscellaneous fixes to keep checkpatch happy.
>
> If this approach is acceptable I can send a series converting other cpufreq
> drivers to use this flag and get rid of driver code.
>
> Amit Kucheria (9):
>   [ALREADY QUEUED] cpufreq: qcom-hw: Move to device_initcall
>   drivers: thermal: of-thermal: Print name of device node with error
>   drivers: cpufreq: Add thermal_cooling_device pointer to struct
>     cpufreq_policy
>   cpufreq: Add a flag to auto-register a cooling device
>   cpufreq: Replace open-coded << with BIT()
>   cpufreq: qcom-hw: Register as a cpufreq cooling device
>   arm64: dts: sdm845: Increase alert trip point to 95 degrees
>   arm64: dts: sdm845: wireup the thermal trip points to cpufreq
>   thermal: cpu_cooling: Clarify error message
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 193 +++++++++++++++++++++++----
>  drivers/cpufreq/cpufreq.c            |  13 ++
>  drivers/cpufreq/qcom-cpufreq-hw.c    |   5 +-
>  drivers/thermal/cpu_cooling.c        |   2 +-
>  drivers/thermal/of-thermal.c         |   4 +-
>  include/linux/cpufreq.h              |  34 +++--
>  6 files changed, 210 insertions(+), 41 deletions(-)

Would it be possible to split this series so as to put the cpufreq
patches separately?
