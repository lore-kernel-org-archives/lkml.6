Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96011C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C14020874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUrHCtir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbfAKLR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:17:28 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34205 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfAKLR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:17:28 -0500
Received: by mail-vk1-f193.google.com with SMTP id y14so3203371vkd.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 03:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quQ2a5r0AVi1NGzHp6qX04vip5C75+yRZ4FIq6abYxU=;
        b=PUrHCtirh/11Xl3jifleikYf/qaulj9x8roOveqoGrryf/a/gEP+yi7dW5GVHqqdvP
         naHuqTWVf6lq/q4TTuWUjb2bmz9+9JTRQTFf7k7ZygkEzj8j5/Fz7SA69evQTTmoyhTr
         SIWK7djs3dQaZNShNBSVcUiQPHXHnlF/dxVvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quQ2a5r0AVi1NGzHp6qX04vip5C75+yRZ4FIq6abYxU=;
        b=PRXNOc8nDxHEQBZ8gyJKrn1A9kyCCkN03WcMoXsnkGBaeXbRoaT/I1suSTTIEIjk0s
         Kv4jYJCxsSVQ5Ah6wPJA/T5NtD56yDqyF0BqNEPKIFQVBlhE+21betEGRRq1XW44p5s4
         X7mrSxJCp2yFmJcJo2xK9a6o5Y7Wp9284e3rOYuH1a9iY7RFD7HuFvfsZw+F+JCXOo5k
         mydZvMGMVglOhq+gZg6RSWfLS8LCdzv+0S+a+M+lQnL1fjhIrpNaG398mdaxpowRwKcM
         DRnPF5XmmI6t2W13GgB10WG8LZ9kJA4IGdRnRd6P0bClVaPyXpv/AHWzDSkO6nZaPpNO
         4t2g==
X-Gm-Message-State: AJcUuke9il95NwxMIcIKOsj8qU63i9n3NJj9L/o128nQKIN8d06Hw48I
        wGuEgu7oaZOtXpofJ2MXwLtHRRBrc0Rqhjl7X2L7Iw==
X-Google-Smtp-Source: ALg8bN65A89hpC0CNlzDLjsb/Tpgb7RZ5BKCJUG6H8jamm+Z9lohXfDdgfnSMS2n808zzrzCpOm2CAqjrEto6ZzpU9M=
X-Received: by 2002:a1f:b58d:: with SMTP id e135mr5462558vkf.86.1547205446291;
 Fri, 11 Jan 2019 03:17:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
 <20190111003014.GB261387@google.com>
In-Reply-To: <20190111003014.GB261387@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 11 Jan 2019 16:47:15 +0530
Message-ID: <CAHLCerP5ZyORkJm9E8kk-+4X6u6f2=vn_0hq7jSewr9O4=RKDw@mail.gmail.com>
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

On Fri, Jan 11, 2019 at 6:00 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Thu, Jan 10, 2019 at 05:30:56AM +0530, Amit Kucheria wrote:
> > Since the big and little cpus are in the same frequency domain, use all
> > of them for mitigation in the cooling-map. At the lower trip points we
> > restrict ourselves to throttling only a few OPPs. At higher trip
> > temperatures, allow ourselves to be throttled to any extent.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 145 +++++++++++++++++++++++++++
> >  1 file changed, 145 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 29e823b0caf4..cd6402a9aa64 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -13,6 +13,7 @@
> >  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> >  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >       interrupt-parent = <&intc>;
> > @@ -99,6 +100,7 @@
> >                       compatible = "qcom,kryo385";
> >                       reg = <0x0 0x0>;
> >                       enable-method = "psci";
> > +                     #cooling-cells = <2>;
> >                       next-level-cache = <&L2_0>;
> >                       L2_0: l2-cache {
> >                               compatible = "cache";
> > @@ -114,6 +116,7 @@
> >                       compatible = "qcom,kryo385";
> >                       reg = <0x0 0x100>;
> >                       enable-method = "psci";
> > +                     #cooling-cells = <2>;
> >                       next-level-cache = <&L2_100>;
> >                       L2_100: l2-cache {
> >                               compatible = "cache";
> > @@ -126,6 +129,7 @@
> >                       compatible = "qcom,kryo385";
> >                       reg = <0x0 0x200>;
> >                       enable-method = "psci";
> > +                     #cooling-cells = <2>;
> >                       next-level-cache = <&L2_200>;
> >                       L2_200: l2-cache {
> >                               compatible = "cache";
> > @@ -138,6 +142,7 @@
> >                       compatible = "qcom,kryo385";
> >                       reg = <0x0 0x300>;
> >                       enable-method = "psci";
> > +                     #cooling-cells = <2>;
> >                       next-level-cache = <&L2_300>;
> >                       L2_300: l2-cache {
> >                               compatible = "cache";
> > @@ -150,6 +155,7 @@
> >                       compatible = "qcom,kryo385";
> >                       reg = <0x0 0x400>;
> >                       enable-method = "psci";
> > +                     #cooling-cells = <2>;
> >                       next-level-cache = <&L2_400>;
> >                       L2_400: l2-cache {
> >                               compatible = "cache";
> > @@ -162,6 +168,7 @@
> >                       compatible = "qcom,kryo385";
> >                       reg = <0x0 0x500>;
> >                       enable-method = "psci";
> > +                     #cooling-cells = <2>;
> >                       next-level-cache = <&L2_500>;
> >                       L2_500: l2-cache {
> >                               compatible = "cache";
> > @@ -174,6 +181,7 @@
> >                       compatible = "qcom,kryo385";
> >                       reg = <0x0 0x600>;
> >                       enable-method = "psci";
> > +                     #cooling-cells = <2>;
> >                       next-level-cache = <&L2_600>;
> >                       L2_600: l2-cache {
> >                               compatible = "cache";
> > @@ -186,6 +194,7 @@
> >                       compatible = "qcom,kryo385";
> >                       reg = <0x0 0x700>;
> >                       enable-method = "psci";
> > +                     #cooling-cells = <2>;
> >                       next-level-cache = <&L2_700>;
> >                       L2_700: l2-cache {
> >                               compatible = "cache";
> > @@ -1703,6 +1712,23 @@
> >                                       type = "critical";
> >                               };
> >                       };
> > +
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip = <&cpu_alert0>;
> > +                                     cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
> > +                                                      <&CPU1 THERMAL_NO_LIMIT 4>,
> > +                                                      <&CPU2 THERMAL_NO_LIMIT 4>,
> > +                                                      <&CPU3 THERMAL_NO_LIMIT 4>;
> > +                             };
> > +                             map1 {
> > +                                     trip = <&cpu_crit0>;
> > +                                     cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
>
> Slightly off-topic, buy maybe not so much since we are just starting
> to use the trip points:
>
> Currently we use the naming scheme 'cpu_<type>N' for trip points. I
> anticipate that we're going to add more passive trip points soon, to
> keep the 'power_allocator' thermal governor happy, which expects a
> 'switch_on' and a 'desired_temperature' trip point. With the current
> naming scheme this could become a bit messy. I suggest to change it to
> 'cpuN_<type>[X]', which would allow for something like 'cpuN_alert0'
> and 'cpuN_alert1'.
>
> If you think the change makes sense you can consider to do it within
> this series, I can also send a separate patch once it has landed.

Sure, I can change them to cpuN_alertX format.

> You could also consider to add the additional trip point in this
> series if you agree that it will be needed.

I expect that we'll end up with at least 2 passive trip points but I
don't know what temperature to set the next one at. So let's just go
with 1 passive and 1 critical trip point in this series and you can
send a patch adding more once we've characterised IPA.

> This is not necessarily a call for action, just thinking loudly about
> a closely related topic ;-)

Thanks for the reviews.

Regards,
Amit
