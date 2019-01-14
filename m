Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B77C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9D320663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWXlINNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfANIWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:22:47 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:37868 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfANIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:22:47 -0500
Received: by mail-qt1-f169.google.com with SMTP id t33so25593249qtt.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzCMRkPjwb4Dx6wTDpuHrvvkH9s2qA4zbjpLMDOf6WY=;
        b=WWXlINNMXoo8lh1hxH1/uQjyo2DTp5Kw676A1zhH0DUrdB0kd4Ib2IEBWr5mVMEjg/
         6ND7NjNz/8XUM6288E1QSnebUnAiFdGBrYyioQVDtbBBE5P1OVsbCAI2qLytBCPYIm59
         kLAUHFcb6+ej4iOQxQ8F0CInsu+Dsehrk8nvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzCMRkPjwb4Dx6wTDpuHrvvkH9s2qA4zbjpLMDOf6WY=;
        b=sZewNNoRyxbOy30J21VZz1VkCqWrnuTpuG/f26i7xYAkJQ4kIAh4H9oJikmit8VAZ6
         fiK3hrsBjFzX0wIYZRLaLbwHCeKhKQS/JdtbldI4m7RHEecGHjNApPdS/svBeaHkYy5T
         PpwTkXaiXwpz8A4o8K6Cx28hKVYsXnYtoRkC/TUVZwM6MbNsiXxPfLxNR255n3O44cR3
         HKm4mT4rzTwO1kV3+cpI5JKyXjCVbD9xz9Oaf23Yf8aNkKeAqYHgwG+2cJxW+7KIkfhV
         TGEbLGaAfh8sJ6Osh33jk8iQGvcUmML2KESkFuU3WuMJuSH5v1nmUP55JPEM5+SrpRHt
         esaA==
X-Gm-Message-State: AJcUukfLcG1niFQm/qnYbbx20BpL1V8SIHK60Ja+Ybp+Jh0YGJOhgrMG
        2x5+BD+R+ct/Bifw/2p1pzMx3OckB2GC0BpDlJF52A==
X-Google-Smtp-Source: ALg8bN5Rj2QOQ70z4bItG48no8rh7StK+FjP34wDeEqkWDkvCr1tfNDdvifM+sl2Mb2C3lyyMxr4j+XZyTmx6YGkGQM=
X-Received: by 2002:ac8:203:: with SMTP id k3mr23612850qtg.64.1547454165954;
 Mon, 14 Jan 2019 00:22:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
 <20190111003014.GB261387@google.com> <CAHLCerP5ZyORkJm9E8kk-+4X6u6f2=vn_0hq7jSewr9O4=RKDw@mail.gmail.com>
 <20190111203605.GG261387@google.com>
In-Reply-To: <20190111203605.GG261387@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 14 Jan 2019 13:52:34 +0530
Message-ID: <CAP245DWMz0UfRdD9HHaRF0fvTgYroxLrj5LcTgQMA9DuBm4T8A@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] arm64: dts: sdm845: wireup the thermal trip points
 to cpufreq
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 2:06 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Another concern about adding trip points later could be the node
> name. We currently have:
>
>
> trips {
>   cpu0_alert0: trip0 {
>     ...
>   };
>
>   cpu0_crit: trip1 {
>     ...
>   };
> };
>
> If we keep increasing enumeration with the node name this would become:
>
> trips {
>   cpu0_alert0: trip0 {
>     ...
>   };
>
>   cpu0_alert1: trip1 {
>     ...
>   };
>
>   cpu0_crit: trip2 {
>     ...
>   };
> };
>
> i.e. the node name of the critical trip-point changes, which might be
> a concern for dtsi's that override a value, though they should
> probably use the phandle &cpu0_crit anyway. If this is a concern we
> could change the node names to 'alert0' and 'crit'.
>
> I looked around a bit and actually I kinda like the naming scheme used
> by hisilicon/hi6220.dtsi, mediatek/mt8173.dtsi and rockchip/rk3328.dtsi
> (with minor variations):
>
> trips {
>         threshold: trip-point@0 {
>                 temperature = <68000>;
>                 hysteresis = <2000>;
>                 type = "passive";
>         };
>
>         target: trip-point@1 {
>                 temperature = <85000>;
>                 hysteresis = <2000>;
>                 type = "passive";
>         };
>
>         cpu_crit: cpu_crit@0 {
>                 temperature = <115000>;
>                 hysteresis = <2000>;
>                 type = "critical";
>         };
> };
>
> If we were to use this we'd have to adapt it slightly since we have
> multiple thermal zones. In line with the other scheme this could be
> cpuN_threshold, cpuN_target and cpuN_crit.
>

I like this scheme enough that I adopted it for v2.
