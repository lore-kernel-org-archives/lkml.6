Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07F2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629892086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBh2ccvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfBTJSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:18:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45761 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:18:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id v139so1528365qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDbcccDbYW214rw2VMd5CZdvwhmnQLjONdFvmfgd2jI=;
        b=iBh2ccvgkNjyQlnxDZhhSDRiscPVSf14I/rVs/29ajGqQLhklh+OFud7jaDVYGDQlx
         W/Qo5unTPuwsBG9G/PjMPEW9Z+Jf16UoJbBcGE10ZVLKT6sPh4NMQl3HOKvTu1qXNjDi
         +lHP73EV1n8CWDIkKpz9FuOkyGHwAQoswQW5/oaMlf5kRLbaaefDDE+uLaEdyuQDg7MG
         //6XHgKIUd7cwgu8++ZKwaxlD5bCYbRxDghgu1zJpg+41T98mdk7XVBTdLXqNRdpOVtm
         gqLTNrpSKlL03YB9EOy/2uwIXDAj23y1VYYrlwXOfUkwSu7CmWN5Lz7evUJnobzSNNup
         LLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDbcccDbYW214rw2VMd5CZdvwhmnQLjONdFvmfgd2jI=;
        b=Zfcukw12+0edYoUze8RAEyKLq0aRhrjVOnIKkDgp8WULv4sDC6rufyuO1e1/CEvwQD
         zxXzZ8skDfRnpjwJAKeHUdhTofQpKe3m3vGpzVp0HvURY7X7VGbTNpWruhsLC7BPrSFf
         8XVzz6w3hIJDRoj9K3PM2k8dn7jAu3s8/1SMveKJw4v9+Y33Y4IcZUF8XCN1ccVtCarK
         hUwcHjcy0NAN/YGyDmw4Cg96aNFSOZkIoLhLdk7IWUsRfsKareeeJ61fJlts0nte0Zs5
         iRRwOVA1IxwgvCT3FheDUNO/J96B3Hb0ueXZdx9xVTnpyEtTSmv/TMJp5l/lNYSsv4hX
         Xycg==
X-Gm-Message-State: AHQUAuZ6NZDINk5t4zw/OS+c1RHv2SVkYBtX4D/fnp++URMw4nzDIjor
        HGpnNKLOIY6vYUdBX+5VV97hNEFGvSBERBrcW/Fwdg==
X-Google-Smtp-Source: AHgI3Iak2z+oB8GkCggvHLnHAf+XeYuffvzUt5v4cyCv8ACW+bezNoRwCZuR8xZ+Z/dVUShphnq2qwigmmUsQYZv8B4=
X-Received: by 2002:a37:b12:: with SMTP id 18mr4032686qkl.125.1550654322971;
 Wed, 20 Feb 2019 01:18:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550493113.git.amit.kucheria@linaro.org>
 <51feb49578f6e412eb5e80012dc63eab5532342b.1550493113.git.amit.kucheria@linaro.org>
 <20190220012456.GG2811@localhost.localdomain>
In-Reply-To: <20190220012456.GG2811@localhost.localdomain>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 20 Feb 2019 14:48:31 +0530
Message-ID: <CAP245DUv+3rMiFFQWGnAv6xgqDt7jJ2m5ioo3ETyQ8iKRef++g@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] arm64: dts: msm8996: thermal: Add temperature
 sensors near major peripherals
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 6:55 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Mon, Feb 18, 2019 at 06:05:18PM +0530, Amit Kucheria wrote:
> > msm8996 has a total of 21 temperature sensors. Populate DT with
> > information about them.
> >
> > There are 2 sensors on each of the cpus - one on the top, the other
> > below (we only expose one on the top in DT for now). For the GPU, we
> > expose both, the one on the top and the one below.
> >
> > Depending on the version of the silicon, sensor 2 is either placed near
> > the L3 cache or the venus video decoder. It would've been nice to be
> > able to be version-specific but we don't have DTs that differentiate the
> > two versions of silicon yet.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 98 +++++++++++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > index ae6e9f0778f0..8e36a39e1386 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > @@ -237,6 +237,104 @@
> >                               };
> >                       };
> >               };
> > +
> > +             gpu-thermal-top {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens1 6>;
> > +
> > +                     trips {
> > +                             gpu1_alert0: trip-point@0 {
> > +                                     temperature = <75000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
>
> What is the cooling map for this?

I'm working on it. Will send out an update.

> > +                             };
> > +
> > +                             gpu1_crit: gpu_crit {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             gpu-thermal-bottom {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens1 7>;
> > +
> > +                     trips {
> > +                             gpu2_alert0: trip-point@0 {
> > +                                     temperature = <75000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
> > +
> > +                             gpu2_crit: gpu_crit {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             m4m-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens0 1>;
> > +             };
> > +
> > +             l3_or_venus-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens0 2>;
> > +             };
> > +
> > +             cluster0-l2-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens0 7>;
> > +             };
> > +
> > +             cluster1-l2-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens0 12>;
> > +             };
> > +
> > +             camera-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens1 1>;
> > +             };
> > +
> > +             q6-dsp-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens1 2>;
> > +             };
> > +
> > +             mem-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens1 3>;
> > +             };
> > +
> > +             modemtx-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens1 4>;
> > +             };
> >       };
> >
> >       timer {
> > --
> > 2.17.1
> >
