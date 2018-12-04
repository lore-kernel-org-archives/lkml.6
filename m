Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F0FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1557C206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYmdXCit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1557C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeLDQgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:36:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46982 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeLDQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:36:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so8463699pfe.13;
        Tue, 04 Dec 2018 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4JtLpX5MoLOBCXYSQ76Mgss2oVSTtL6KxQT04j18GUs=;
        b=mYmdXCitOyJUoERAkUmgBSFB5skglAfkrBLqnon0R66qPkh9P65wQIcH8tTS5hSWDz
         PU6bZEMwluKNP8RV4L3Sv2RvuOmtWFkuXgqohvZkMfi7/e1PxXR8vRZSIJgfuj/sJTIK
         KycUO8uDMDlHJfepsZmreC5aof9pIsfoqP2wTcXdsj0UaPQ357aBXuSSoxF6J/2SuTjb
         S6bRenIV+0gE7qO14X5UBuJ+5NZTYpalWd3e7lVTr2R4IL1xAKbVVtotiu2cpSlJv4UP
         vB9MjRIJKgnpXDCN+f2NO9pEHVecyS0IGo6GJfl+JgK9zaF6j0GqiWBZBV6kkNIfQaic
         0OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4JtLpX5MoLOBCXYSQ76Mgss2oVSTtL6KxQT04j18GUs=;
        b=IE+penfib8wYptpaQQd+cEYVSd7IP1Kpy5tkuekS4wMqWnqkJgTaqyxc0p2C+rAhoN
         epsfA6i605lVd0hLYF19pMMm396IJ/ltybCIX+tlRlWWPmfJUwAOWbFEbuwyoOpRJB9L
         JxrR229IBpLsLfpPaqV1R6/l6orxsNmTj8H7TSj7zw6/q8Di1U6it54fc8y0erKgRgYT
         Yv2+HwVDnNpXnjjVoRqCkQcawmXhekpgDMHIo9oqWclgI2rkGRpTg4DKWyPq20ne127h
         FdQc+Rd0e4AHrgB1XPSE413gtsxpPp9D6pwn+HHTvElm4DS00gQfJ7IZcl7dHsCJ8LYV
         eQRg==
X-Gm-Message-State: AA+aEWalYj43oheF6q3FB/0DZs8eZxbKnjpYR0pxht+RGOIvZmxfHC4e
        DMHW6HdgJ/ss27SchY9GUkw=
X-Google-Smtp-Source: AFSGD/V1FWpLcr8C299amvDE40wkaZFAVTU6VSavusrS6ikqg/kSBQrgEpwdYBYHlSHjNL2pk5JaBQ==
X-Received: by 2002:a63:6302:: with SMTP id x2mr17143897pgb.183.1543941396514;
        Tue, 04 Dec 2018 08:36:36 -0800 (PST)
Received: from localhost.localdomain ([4.16.3.165])
        by smtp.gmail.com with ESMTPSA id b5sm48583275pfc.150.2018.12.04.08.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 08:36:35 -0800 (PST)
Date:   Tue, 4 Dec 2018 08:36:33 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, vkoul@kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qcs404: Add thermal zones for
 each sensor
Message-ID: <20181204163631.GA1790@localhost.localdomain>
References: <cover.1543335819.git.amit.kucheria@linaro.org>
 <f89944deceba4c16c1863f1b303e2d970f3c8456.1543335819.git.amit.kucheria@linaro.org>
 <20181129165709.GF2688@localhost.localdomain>
 <CAP245DXz=6vCoB+ssV6kBEk-vqSmVTFnsRJxDoGUd_JmPZv0jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP245DXz=6vCoB+ssV6kBEk-vqSmVTFnsRJxDoGUd_JmPZv0jg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:56:15PM +0530, Amit Kucheria wrote:
> On Thu, Nov 29, 2018 at 10:27 PM Eduardo Valentin <edubezval@gmail.com> wrote:
> >
> > On Tue, Nov 27, 2018 at 09:59:07PM +0530, Amit Kucheria wrote:
> > > qcs404 has 10 sensors connected to the single TSENS IP. Define a thermal
> > > zone for each of those sensors to expose the temperature of each zone.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > > Tested-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/qcs404.dtsi | 206 +++++++++++++++++++++++++++
> > >  1 file changed, 206 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > > index 57d14d8f0c90..cbc3fd378893 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > > @@ -30,6 +30,7 @@
> > >                       reg = <0x100>;
> > >                       enable-method = "psci";
> > >                       next-level-cache = <&L2_0>;
> > > +                     #cooling-cells= <2>;
> > >               };
> > >
> > >               CPU1: cpu@101 {
> > > @@ -38,6 +39,7 @@
> > >                       reg = <0x101>;
> > >                       enable-method = "psci";
> > >                       next-level-cache = <&L2_0>;
> > > +                     #cooling-cells= <2>;
> > >               };
> > >
> > >               CPU2: cpu@102 {
> > > @@ -46,6 +48,7 @@
> > >                       reg = <0x102>;
> > >                       enable-method = "psci";
> > >                       next-level-cache = <&L2_0>;
> > > +                     #cooling-cells= <2>;
> > >               };
> > >
> > >               CPU3: cpu@103 {
> > > @@ -54,6 +57,7 @@
> > >                       reg = <0x103>;
> > >                       enable-method = "psci";
> > >                       next-level-cache = <&L2_0>;
> > > +                     #cooling-cells= <2>;
> > >               };
> > >
> > >               L2_0: l2-cache {
> > > @@ -507,4 +511,206 @@
> > >                       #interrupt-cells = <2>;
> > >               };
> > >       };
> > > +
> > > +     thermal-zones {
> > > +             aoss-thermal {
> > > +                     polling-delay-passive = <250>;
> > > +                     polling-delay = <1000>;
> > > +
> > > +                     thermal-sensors = <&tsens 0>;
> > > +
> > > +                     trips {
> > > +                             aoss_alert: trip0 {
> > > +                                     temperature = <75000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "passive";
> >
> >
> > A passive trip and yet no cooling map associate to it..
> 
> Oops, was waiting for cpufreq to be enabled on the platform. I'll get
> rid of the trips for now.

Well, the expectation is to have a fully defined thermal zone. Without
trips or cooling maps they are not complete.

> 
> >
> > > +                             };
> > > +                             aoss_crit: trip1 {
> > > +                                     temperature = <95000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "critical";
> > > +                             };
> > > +                     };
> > > +             };
> > > +
> > > +             dsp-thermal {
> > > +                     polling-delay-passive = <250>;
> > > +                     polling-delay = <1000>;
> > > +
> > > +                     thermal-sensors = <&tsens 1>;
> > > +
> > > +                     trips {
> > > +                             dsp_alert: trip0 {
> > > +                                     temperature = <75000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "passive";
> > > +                             };
> > > +                             dsp_crit: trip1 {
> > > +                                     temperature = <95000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "critical";
> > > +                             };
> > > +                     };
> > > +             };
> > > +
> > > +             lpass-thermal {
> > > +                     polling-delay-passive = <250>;
> > > +                     polling-delay = <1000>;
> > > +
> > > +                     thermal-sensors = <&tsens 2>;
> > > +
> > > +                     trips {
> > > +                             lpass_alert: trip0 {
> > > +                                     temperature = <75000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "passive";
> > > +                             };
> > > +                             lpass_crit: trip1 {
> > > +                                     temperature = <95000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "critical";
> > > +                             };
> > > +                     };
> > > +             };
> > > +
> > > +             wlan-thermal {
> > > +                     polling-delay-passive = <250>;
> > > +                     polling-delay = <1000>;
> > > +
> > > +                     thermal-sensors = <&tsens 3>;
> > > +
> > > +                     trips {
> > > +                             wlan_alert: trip0 {
> > > +                                     temperature = <75000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "passive";
> > > +                             };
> > > +                             wlan_crit: trip1 {
> > > +                                     temperature = <95000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "critical";
> > > +                             };
> > > +                     };
> > > +             };
> > > +
> > > +             cluster-thermal {
> > > +                     polling-delay-passive = <250>;
> > > +                     polling-delay = <1000>;
> > > +
> > > +                     thermal-sensors = <&tsens 4>;
> > > +
> > > +                     trips {
> > > +                             cluster_alert: cluster_alert {
> > > +                                     temperature = <75000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "passive";
> > > +                             };
> > > +                             cluster_crit: cluster_crit {
> > > +                                     temperature = <110000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "critical";
> > > +                             };
> > > +                     };
> > > +             };
> > > +
> > > +             cpu-thermal0 {
> > > +                     polling-delay-passive = <250>;
> > > +                     polling-delay = <1000>;
> > > +
> > > +                     thermal-sensors = <&tsens 5>;
> > > +
> > > +                     trips {
> > > +                             cpu_alert0: cpu_alert0 {
> > > +                                     temperature = <75000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "passive";
> > > +                             };
> > > +                             cpu_crit0: cpu_crit0 {
> > > +                                     temperature = <110000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "critical";
> > > +                             };
> > > +                     };
> > > +             };
> > > +
> > > +             cpu-thermal1 {
> > > +                     polling-delay-passive = <250>;
> > > +                     polling-delay = <1000>;
> > > +
> > > +                     thermal-sensors = <&tsens 6>;
> > > +
> > > +                     trips {
> > > +                             cpu_alert1: trip0 {
> > > +                                     temperature = <75000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "passive";
> > > +                             };
> > > +                             cpu_crit1: trip1 {
> > > +                                     temperature = <110000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "critical";
> > > +                             };
> > > +                     };
> > > +             };
> > > +
> > > +             cpu-thermal2 {
> > > +                     polling-delay-passive = <250>;
> > > +                     polling-delay = <1000>;
> > > +
> > > +                     thermal-sensors = <&tsens 7>;
> > > +
> > > +                     trips {
> > > +                             cpu_alert2: trip0 {
> > > +                                     temperature = <75000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "passive";
> > > +                             };
> > > +                             cpu_crit2: trip1 {
> > > +                                     temperature = <110000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "critical";
> > > +                             };
> > > +                     };
> > > +             };
> > > +
> > > +             cpu-thermal3 {
> > > +                     polling-delay-passive = <250>;
> > > +                     polling-delay = <1000>;
> > > +
> > > +                     thermal-sensors = <&tsens 8>;
> > > +
> > > +                     trips {
> > > +                             cpu_alert3: trip0 {
> > > +                                     temperature = <75000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "passive";
> > > +                             };
> > > +                             cpu_crit3: trip1 {
> > > +                                     temperature = <110000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "critical";
> > > +                             };
> > > +                     };
> > > +             };
> > > +
> > > +             gpu-thermal {
> > > +                     polling-delay-passive = <250>;
> > > +                     polling-delay = <1000>;
> > > +
> > > +                     thermal-sensors = <&tsens 9>;
> > > +
> > > +                     trips {
> > > +                             gpu_alert: trip0 {
> > > +                                     temperature = <75000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "passive";
> > > +                             };
> > > +                             gpu_crit: trip1 {
> > > +                                     temperature = <95000>;
> > > +                                     hysteresis = <2000>;
> > > +                                     type = "critical";
> > > +                             };
> > > +                     };
> > > +             };
> > > +     };
> > >  };
> > > --
> > > 2.17.1
> > >
