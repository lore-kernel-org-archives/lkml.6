Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3069C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B54C2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwRc5RHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfBTJkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:40:21 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43494 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfBTJkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:40:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id y4so26405204qtc.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oiALbVHO0qnijQyT/jVIby775WJPlwFVtSmkZ7NGoOQ=;
        b=NwRc5RHIXtilJyd10T0vR5zGbhHDll97/l8GiptoZlHdrY4nLJJhN3s3uWCkrZc9ye
         o2wmkqM+yXrFwR+wkCjFge+39JTgXPDknrvH5N8IiijsxfReynIe30XqkkyAxIqsSkXK
         CQw45R/28bb/G55mosUdBu0EKgqH5FU/cGwnufZbh57SNQo/UgYLV0ma0UrcFAvDfvWM
         HIjzoQ9qnYamXhh7EGDjC1eWe/2O/XVoQKjMP+4LrRU9+GCnfKVboApPoRrC5BT+Uqz5
         8LHlYMQRNXLSlJboWXzFrlZkJUIonXnt9oP9CkVfy8ptPk+WhKKfS7WsCodONweFwbtp
         k/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiALbVHO0qnijQyT/jVIby775WJPlwFVtSmkZ7NGoOQ=;
        b=Da4Vwx64AUdrZ2vJ2KB5PPr3Vy4FjChIXpljGzjJRFZDeYtbVnwJiHpecCr3CvMzPp
         6y19poSIzFhpryoajUiDUF6qlXMkeeCszHdFjZQsDPl/1f+xlb25UMTCEr0XhwRiybVF
         UJHjdCdlM9QL9w4UcXh7oVI96iLpy07e9x/VdVUmCrVmZmn+PJlnvqffsghl7mz9PQcL
         zbDkwtOppWjNYU6nkvIQR/QxBd6+2UQSO8zsDe0aKSllhDn7wqniprMs1T9kJ7mJxgWH
         9c3b/LpBtV7Gl/pf5UYrEAMRsjgOIWl9s+CgXwMUhG/9+NC3+/s7TLp7tFoY3VgTSBts
         AeSg==
X-Gm-Message-State: AHQUAuZNgxp0Q66V77BJqTC/pq8gs/BRuQ2/r3vxn8SYb228cOxCabtN
        dOdljnmzucNW3Nh44uRzYC6MhN7Je4F/d+SE+rxnAg==
X-Google-Smtp-Source: AHgI3Ia/Tg/P8q1oAfq7l7QFPekVjgEnBb99Xa7VrCIWP+BMBAKgQJ2Z8DJGqujP9CdYZd1ELcrG1JQgfrrKArDAlBQ=
X-Received: by 2002:aed:3ef7:: with SMTP id o52mr26716934qtf.276.1550655618673;
 Wed, 20 Feb 2019 01:40:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549525708.git.amit.kucheria@linaro.org>
 <42fd6c63c58db82088924c70d016e03a2b6fa9fe.1549525708.git.amit.kucheria@linaro.org>
 <20190220010913.GB2811@localhost.localdomain>
In-Reply-To: <20190220010913.GB2811@localhost.localdomain>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 20 Feb 2019 15:10:07 +0530
Message-ID: <CAP245DW1W4oxxtEK_C4X0xvOUqZm4W_+-0XxZFy4AtZcHscCNQ@mail.gmail.com>
Subject: Re: [PATCH v1 23/24] arm64: dts: qcom: qcs404: Add thermal zones for
 each sensor
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 6:39 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Thu, Feb 07, 2019 at 04:19:41PM +0530, Amit Kucheria wrote:
> > qcs404 has 10 sensors connected to the single TSENS IP. Define a thermal
> > zone for each of those sensors to expose the temperature of each zone.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs404.dtsi | 243 +++++++++++++++++++++++++++
> >  1 file changed, 243 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > index 57d14d8f0c90..ca99c45864df 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > @@ -3,6 +3,7 @@
> >
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/clock/qcom,gcc-qcs404.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >       interrupt-parent = <&intc>;
> > @@ -30,6 +31,7 @@
> >                       reg = <0x100>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> > +                     #cooling-cells= <2>;
> >               };
> >
> >               CPU1: cpu@101 {
> > @@ -38,6 +40,7 @@
> >                       reg = <0x101>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> > +                     #cooling-cells= <2>;
> >               };
> >
> >               CPU2: cpu@102 {
> > @@ -46,6 +49,7 @@
> >                       reg = <0x102>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> > +                     #cooling-cells= <2>;
> >               };
> >
> >               CPU3: cpu@103 {
> > @@ -54,6 +58,7 @@
> >                       reg = <0x103>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> > +                     #cooling-cells= <2>;
> >               };
> >
> >               L2_0: l2-cache {
> > @@ -507,4 +512,242 @@
> >                       #interrupt-cells = <2>;
> >               };
> >       };
> > +
> > +     thermal-zones {
>
> There are several zones with passive trips and no cooling maps.

Indeed. The policy bits are still a WIP and in some cases the
throttling is handled by someone in userspace. But I'd like to expose
at least the temperatures at each of the sensors to make it easier for
others to use this information. See my reply to the cover letter.

Regards,
Amit




> > +             aoss-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 0>;
> > +
> > +                     trips {
> > +                             aoss_alert0: trip-point@0 {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             aoss_crit: aoss_crit {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             dsp-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 1>;
> > +
> > +                     trips {
> > +                             dsp_alert0: trip-point@0 {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             dsp_crit: dsp_crit {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             lpass-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 2>;
> > +
> > +                     trips {
> > +                             lpass_alert0: trip-point@0 {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             lpass_crit: lpass_crit {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             wlan-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 3>;
> > +
> > +                     trips {
> > +                             wlan_alert0: trip-point@0 {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             wlan_crit: wlan_crit {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             cluster-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 4>;
> > +
> > +                     trips {
> > +                             cluster_alert0: trip-point@0 {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             cluster_crit: cluster_crit {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             cpu0-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 5>;
> > +
> > +                     trips {
> > +                             cpu0_alert0: trip-point@0 {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             cpu0_crit: cpu_crit {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip = <&cpu0_alert0>;
> > +                                     cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             cpu1-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 6>;
> > +
> > +                     trips {
> > +                             cpu1_alert0: trip-point@0 {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             cpu1_crit: cpu_crit {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip = <&cpu1_alert0>;
> > +                                     cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             cpu2-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 7>;
> > +
> > +                     trips {
> > +                             cpu2_alert0: trip-point@0 {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             cpu2_crit: cpu_crit {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip = <&cpu2_alert0>;
> > +                                     cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             cpu3-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 8>;
> > +
> > +                     trips {
> > +                             cpu3_alert0: trip-point@0 {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             cpu3_crit: cpu_crit {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip = <&cpu3_alert0>;
> > +                                     cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                    <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             gpu-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 9>;
> > +
> > +                     trips {
> > +                             gpu_alert0: trip-point@0 {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             gpu_crit: gpu_crit {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +     };
> >  };
> > --
> > 2.17.1
> >
