Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6045ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867C120850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="d67btKh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867C120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verdurent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbeGRK7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:59:41 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45970 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeGRK7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:59:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so7746239oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OVrZPeEzp5eQvIbzymwPvkdoteqL0N7smTTqOwTceKs=;
        b=d67btKh67Owuaiv3f9pkLt1CDIdKqtlxbuqfh0Vi3vnUk9Zyc8S9O/vLR4dOXWe8Rj
         d75fAAuqbYziTnaml8MSQVGWa8sTWgBUsuU6infW1Liu7A8kSkw10JDNmjA3DO6aV+FE
         PKN8Wr65GHRM3kxtx+S8BJVTXXX8zh+VjWfFL4KAv1jzr3m2qWttGhzw927lEubHPpIp
         OLgAs6WZ1kua8lXdI9dm9Ue1GGET/ulVkOuPYmK/a5HS0OUc2aVAHOpieqYA/zO+oxn3
         7RQSkgiLErm2wz192JMwXxwKHPjDctaJ7UH2AkZIK9AUzb6KDdmjYprRgAGs2GjRngWL
         rnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OVrZPeEzp5eQvIbzymwPvkdoteqL0N7smTTqOwTceKs=;
        b=s8GayQNj/DVPvlJW/wyyGU7jaqQsf4MaQCZv3g18qQzVdffSjYORTaqHSdumKtHOsO
         2ioAtQoIGSiiU5caF3YsLgzdigkT95bfsdfIIl7g0NrHtIfbN1N85gwSFXeAz2VUYasq
         IYzWKwGeqqvsOCCjdKbu2SlnF6PrTs3axItNPXvczwhQLzFLI9KKR3ZGsZ8OMH8qzis+
         89bIN4bQ/NBzDfrs3RAxMo9BqH1Yum4Ss4f5auciHDXvKnoCcyNZ07T+K42iKXsGp/Ac
         OpmJU9CLUVlWv1g9Bh5u4AZxdDdQzmZ0XF8Iy3YCLbdBAKy2jIZ3VBebBWpp0p5FHLGJ
         m05Q==
X-Gm-Message-State: AOUpUlGpxWjcZ9mzp2z82FOvWJvvlinicAwaGaHRlNw82VcTzq2vGkzb
        hYv9IFTn+WmCl/K78eVGJHlhIW5rdFRv2Nb4950NpA==
X-Google-Smtp-Source: AAOMgpeCn2SeGaaxviYNAq+2ptXetB8mQkTYe1J9B0Pmf3nxNWMDeo07YTIlytI6ZxfMazUF6hkL34Z1RrtH3FPkpPw=
X-Received: by 2002:aca:d605:: with SMTP id n5-v6mr5238207oig.287.1531909347528;
 Wed, 18 Jul 2018 03:22:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:22:26
 -0700 (PDT)
In-Reply-To: <9f9cc23d1fd17503c9056d62f7757fb9c412d1f9.1527244201.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org> <9f9cc23d1fd17503c9056d62f7757fb9c412d1f9.1527244201.git.viresh.kumar@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 18 Jul 2018 15:52:26 +0530
Message-ID: <CAHLCerN1Oxz3t53gxvK83A8jQswsPitgm_NjQ4CWB8V02R_LnQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] arm: dts: qcom: Add missing OPP properties for CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arm@kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 4:02 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The OPP properties, like "operating-points", should either be present
> for all the CPUs of a cluster or none. If these are present only for a
> subset of CPUs of a cluster then things will start falling apart as soon
> as the CPUs are brought online in a different order. For example, this
> will happen because the operating system looks for such properties in
> the CPU node it is trying to bring up, so that it can create an OPP
> table.
>
> Add such missing properties.
>
> Fix other missing property (clock latency) as well to make it all
> work.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

FWIW,
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index b25daf368012..8c202b359270 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -75,6 +75,14 @@
>                         reg = <0x1>;
>                         clocks = <&gcc GCC_APPS_CLK_SRC>;
>                         clock-frequency = <0>;
> +                       operating-points = <
> +                               /* kHz  uV (fixed) */
> +                               48000   1100000
> +                               200000  1100000
> +                               500000  1100000
> +                               666000  1100000
> +                       >;
> +                       clock-latency = <256000>;
>                 };
>
>                 cpu@2 {
> @@ -86,6 +94,14 @@
>                         reg = <0x2>;
>                         clocks = <&gcc GCC_APPS_CLK_SRC>;
>                         clock-frequency = <0>;
> +                       operating-points = <
> +                               /* kHz  uV (fixed) */
> +                               48000   1100000
> +                               200000  1100000
> +                               500000  1100000
> +                               666000  1100000
> +                       >;
> +                       clock-latency = <256000>;
>                 };
>
>                 cpu@3 {
> @@ -97,6 +113,14 @@
>                         reg = <0x3>;
>                         clocks = <&gcc GCC_APPS_CLK_SRC>;
>                         clock-frequency = <0>;
> +                       operating-points = <
> +                               /* kHz  uV (fixed) */
> +                               48000   1100000
> +                               200000  1100000
> +                               500000  1100000
> +                               666000  1100000
> +                       >;
> +                       clock-latency = <256000>;
>                 };
>         };
>
> --
> 2.15.0.194.g9af6a3dea062
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
