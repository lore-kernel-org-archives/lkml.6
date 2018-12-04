Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B57CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19A720851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CG8k2TsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19A720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeLDL0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:26:34 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33286 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeLDL03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:26:29 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so17575606qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 03:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dywNk1vDCmBOKed8JsSQPLHdWV2cUelzlxpl7MW0Nak=;
        b=CG8k2TsKJsqHMedzobNW/WfVlCE+rjQx+8Oyp142ZhF160lDI0J6qTHHAI1QUQlfNH
         1k9us2FUeK9U/+ssVE7PzU5K2u2QJbTcQJRggUf43sx3W0f7UP0kL02bSleIz8pKq0tC
         8dCJdooCJuta9SbDjwHI5TSScdGmBnO4DtLi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dywNk1vDCmBOKed8JsSQPLHdWV2cUelzlxpl7MW0Nak=;
        b=Wqzi4tLs6lZp5sJm4rxJ5laWhijYilpvCj7mdS6HYqd5Krwcri5qoY6zhPQ+EXkCKj
         +Dh4j8iuMXbx33Gv2aHQvn8kdQnGw20+8RCLOqwYZVGW0/l1wrj8Dvl5ep4AYfNuEeIn
         v+DAnxV0f8KKILDj80m2bbDYd9Gcyp9VdaUxho5LOkyyPGGpWEE/Xs4boVXOfPSDmaYt
         mcaNXvQaLniKY80tXHbQSxvOt5IvNnE+zrF6OF0tvTe4eRs8s/vXwAa7hyZtrkBvGz76
         wkiGYDUIvzYf/fOt8qhtQVwktMTCn54ElNx2AVns49Y4811kQuTPGmc7d9rwscHdOQ7i
         aB9Q==
X-Gm-Message-State: AA+aEWbE9rg5oIv7+gfa31gIQnpNnoTvx+jhgPbbOmUVOeHwdlkT85go
        YaAhGPT/X0/jpmPnM0tZWJ2psycgrGRhet9KjT5oow==
X-Google-Smtp-Source: AFSGD/VeSpv+sMD210daXI39/bW03TK4oF39crVvFdPAcnFH25yeVrIWQQG9NNLa9hN710bSzXvuBXzA5SM9bTQaNKk=
X-Received: by 2002:ac8:203:: with SMTP id k3mr19585235qtg.64.1543922787220;
 Tue, 04 Dec 2018 03:26:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543335819.git.amit.kucheria@linaro.org>
 <f89944deceba4c16c1863f1b303e2d970f3c8456.1543335819.git.amit.kucheria@linaro.org>
 <20181129165709.GF2688@localhost.localdomain>
In-Reply-To: <20181129165709.GF2688@localhost.localdomain>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 4 Dec 2018 16:56:15 +0530
Message-ID: <CAP245DXz=6vCoB+ssV6kBEk-vqSmVTFnsRJxDoGUd_JmPZv0jg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qcs404: Add thermal zones for
 each sensor
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, vkoul@kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:27 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Tue, Nov 27, 2018 at 09:59:07PM +0530, Amit Kucheria wrote:
> > qcs404 has 10 sensors connected to the single TSENS IP. Define a thermal
> > zone for each of those sensors to expose the temperature of each zone.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > Tested-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs404.dtsi | 206 +++++++++++++++++++++++++++
> >  1 file changed, 206 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > index 57d14d8f0c90..cbc3fd378893 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > @@ -30,6 +30,7 @@
> >                       reg = <0x100>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> > +                     #cooling-cells= <2>;
> >               };
> >
> >               CPU1: cpu@101 {
> > @@ -38,6 +39,7 @@
> >                       reg = <0x101>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> > +                     #cooling-cells= <2>;
> >               };
> >
> >               CPU2: cpu@102 {
> > @@ -46,6 +48,7 @@
> >                       reg = <0x102>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> > +                     #cooling-cells= <2>;
> >               };
> >
> >               CPU3: cpu@103 {
> > @@ -54,6 +57,7 @@
> >                       reg = <0x103>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> > +                     #cooling-cells= <2>;
> >               };
> >
> >               L2_0: l2-cache {
> > @@ -507,4 +511,206 @@
> >                       #interrupt-cells = <2>;
> >               };
> >       };
> > +
> > +     thermal-zones {
> > +             aoss-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 0>;
> > +
> > +                     trips {
> > +                             aoss_alert: trip0 {
> > +                                     temperature = <75000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
>
>
> A passive trip and yet no cooling map associate to it..

Oops, was waiting for cpufreq to be enabled on the platform. I'll get
rid of the trips for now.

>
> > +                             };
> > +                             aoss_crit: trip1 {
> > +                                     temperature = <95000>;
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
> > +                             dsp_alert: trip0 {
> > +                                     temperature = <75000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             dsp_crit: trip1 {
> > +                                     temperature = <95000>;
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
> > +                             lpass_alert: trip0 {
> > +                                     temperature = <75000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             lpass_crit: trip1 {
> > +                                     temperature = <95000>;
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
> > +                             wlan_alert: trip0 {
> > +                                     temperature = <75000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             wlan_crit: trip1 {
> > +                                     temperature = <95000>;
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
> > +                             cluster_alert: cluster_alert {
> > +                                     temperature = <75000>;
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
> > +             cpu-thermal0 {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 5>;
> > +
> > +                     trips {
> > +                             cpu_alert0: cpu_alert0 {
> > +                                     temperature = <75000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             cpu_crit0: cpu_crit0 {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             cpu-thermal1 {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 6>;
> > +
> > +                     trips {
> > +                             cpu_alert1: trip0 {
> > +                                     temperature = <75000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             cpu_crit1: trip1 {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             cpu-thermal2 {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 7>;
> > +
> > +                     trips {
> > +                             cpu_alert2: trip0 {
> > +                                     temperature = <75000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             cpu_crit2: trip1 {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             cpu-thermal3 {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens 8>;
> > +
> > +                     trips {
> > +                             cpu_alert3: trip0 {
> > +                                     temperature = <75000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             cpu_crit3: trip1 {
> > +                                     temperature = <110000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
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
> > +                             gpu_alert: trip0 {
> > +                                     temperature = <75000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +                             gpu_crit: trip1 {
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
