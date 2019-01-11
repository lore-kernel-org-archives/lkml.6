Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB36C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A09F2177E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOsJ6JCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfAKKYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:24:37 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40404 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbfAKKYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:24:37 -0500
Received: by mail-vs1-f68.google.com with SMTP id z3so8886167vsf.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 02:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBQrJVCwQ0JVDhwx4xMgo3jE6/kf13B9wxHBBaJ7Qx4=;
        b=YOsJ6JCbZtnDm9mNFmWziR8/Y3/Y9J2Da6tneHn0GQMoYK56XP9wu9xWR2u2kDRHVs
         cGlw1dekdqmsUDXJLnsXGaZcEd/3ueBPf5Clmyg8N6I200+P/eLaHqqJpPgKRup4nJ90
         0YqeT74AKhgFrSaAYtCvjT90wfQoLdCMljo5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBQrJVCwQ0JVDhwx4xMgo3jE6/kf13B9wxHBBaJ7Qx4=;
        b=lz7DcxIdLfO4xnFOStLGRHAcJRcEW06RvNSei5D9Mr62w5d7pm/KYoweYz+oRXVMXk
         0kl53aXaREq30mtkZ67VmYQh7OjwtvYDKEF/Ae3Ea+zn5vuc7scs72hK9SRWH2IixXX+
         I9r7hYLBFqqNgKc9iqLNSqcYbvjXbxk0NIWVS1/n/nB087vlRW7SBAfLJ/Rj/GFQPi7r
         Z4QLpynx7REoRN6Vjf+/eKoyfWTtlgWkbyGd4YbPblVKRN+mohxUQQt/1CP19k52kN/5
         pr07sgFjCtz6YxTY+N/JGHV7K3S5clhMVavcPpHO2USnNSGBLhaMlEmnlurvqVVHQQGs
         M8jg==
X-Gm-Message-State: AJcUukeyKY1YuahdDnHBbVUvxz7AJBTJ1QFg/X+TMB+nDITj3XVtyCdn
        U474r3UcAaCUQ0Wf1m3LGQqnX9ciNaebnoDDqKKqOg==
X-Google-Smtp-Source: ALg8bN4Fd4aCLPUgWUKtf+5ePEYo4pNi36UsBHfOlVqWCE9CWD+Mb0uf/ZCf/LfWGsNZbpwXdvXNhs0LSVfiwL7eiuw=
X-Received: by 2002:a67:7ed8:: with SMTP id z207mr5331792vsc.159.1547202275581;
 Fri, 11 Jan 2019 02:24:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
 <20190110011533.GV261387@google.com>
In-Reply-To: <20190110011533.GV261387@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 11 Jan 2019 15:54:23 +0530
Message-ID: <CAHLCerPN3dxd=XBEkU2cMacFDkZjNhXEw7BDYNTEyfSUszSUzg@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] arm64: dts: sdm845: Increase alert trip point to
 95 degrees
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

On Thu, Jan 10, 2019 at 6:45 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Amit,
>
> On Thu, Jan 10, 2019 at 05:30:55AM +0530, Amit Kucheria wrote:
> > 75 degrees is too aggressive for throttling the CPU. After speaking to
> > Qualcomm engineers, increase it to 95 degrees.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index c27cbd3bcb0a..29e823b0caf4 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -1692,7 +1692,7 @@
> >
> >                       trips {
> >                               cpu_alert0: trip0 {
> > -                                     temperature = <75000>;
> > +                                     temperature = <95000>;
> >                                       hysteresis = <2000>;
> >                                       type = "passive";
> >                               };
> > @@ -1713,7 +1713,7 @@
> >
> >                       trips {
> >                               cpu_alert1: trip0 {
> > -                                     temperature = <75000>;
> > +                                     temperature = <95000>;
> >                                       hysteresis = <2000>;
> >                                       type = "passive";
> >                               };
> > @@ -1734,7 +1734,7 @@
> >
> >                       trips {
> >                               cpu_alert2: trip0 {
> > -                                     temperature = <75000>;
> > +                                     temperature = <95000>;
> >                                       hysteresis = <2000>;
> >                                       type = "passive";
> >                               };
> > @@ -1755,7 +1755,7 @@
> >
> >                       trips {
> >                               cpu_alert3: trip0 {
> > -                                     temperature = <75000>;
> > +                                     temperature = <95000>;
> >                                       hysteresis = <2000>;
> >                                       type = "passive";
> >                               };
> > @@ -1776,7 +1776,7 @@
> >
> >                       trips {
> >                               cpu_alert4: trip0 {
> > -                                     temperature = <75000>;
> > +                                     temperature = <95000>;
> >                                       hysteresis = <2000>;
> >                                       type = "passive";
> >                               };
> > @@ -1797,7 +1797,7 @@
> >
> >                       trips {
> >                               cpu_alert5: trip0 {
> > -                                     temperature = <75000>;
> > +                                     temperature = <95000>;
> >                                       hysteresis = <2000>;
> >                                       type = "passive";
> >                               };
> > @@ -1818,7 +1818,7 @@
> >
> >                       trips {
> >                               cpu_alert6: trip0 {
> > -                                     temperature = <75000>;
> > +                                     temperature = <95000>;
> >                                       hysteresis = <2000>;
> >                                       type = "passive";
> >                               };
> > @@ -1839,7 +1839,7 @@
> >
> >                       trips {
> >                               cpu_alert7: trip0 {
> > -                                     temperature = <75000>;
> > +                                     temperature = <95000>;
> >                                       hysteresis = <2000>;
> >                                       type = "passive";
> >                               };
>
> The change itself looks good to me, however I wonder if it would be
> worth to eliminate redundancy and merge the current 8 thermal zones
> into 2, one for the Silver and one for the Gold cluster (as done by
> http://crrev.com/c/1381752). There is a single cooling device for
> each cluster, so it's not clear to me if there is any gain from having
> a separate thermal zone for each CPU. If it is important to monitor
> the temperatures of the individual cores this can still be done by
> configuring the thermal zone of the cluster with multiple thermal
> sensors.

Reducing the number of thermal zones to 2 (by grouping 4 sensors per
zone) is not possible due a limitation of the thermal framework[1]. It
is something that we want to address. Previous attempts to fix this
were rejected for various reasons. Eduardo was going to share a way to
have more flexible mapping between sensors and zones after discussions
at LPC.

<nag> Eduardo, do you have anything we can review? </nag> :-)

Having said that, we'll need some aggregation functions when we add
multiple sensors to a zone (e.g. max, mean) to reflect the zone. This
will lose information about hotspots and prevent things like idle
injection on a particular CPU that is causing most of the heat in the
aggregated zone. So IMHO, it might be useful to have information about
the hotspots (i.e TZ per sensor) and aggregated values (ambient
temperature) that can be fed to the thermal policy.


[1] https://elixir.bootlin.com/linux/v5.0-rc1/source/drivers/thermal/of-thermal.c#L502
