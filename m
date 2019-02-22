Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B795C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2362081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D973TjTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfBVKdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:33:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34648 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfBVKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:33:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id 98so1490306oty.1;
        Fri, 22 Feb 2019 02:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPoR1P+Jx7C7d9k/Q/XUwBrh6UJnb7qtMiFYdsFu3s4=;
        b=D973TjTCF970LNesGwfFth4msYJckQM+sHxHgHJ4SDdL5iiqks5a/orvXY4WPZYwYy
         UNi8PiT4JTX7vEhWK/SzQXaGoVhGEDeO2ylHCFz6834G+aeezHzumz7/8RpioAI/+v4r
         oG9U0fMvftjwW1PulSJK6Z+X51ozVQsvow5hrUq2/pLqZV2khUdaUFcA4XTSRVwwJ2EY
         LpX3h2T+VnhIFGfo1gnmD3vCMtYaqgPdSCoa70koMzmw3o5HDFLMbt9K/C1goNN0drrF
         DNyhzs9b0GQs+190G4DjxfvVolg9RoEkKl/ePe5yvDSQSCTKgr5HBCnCFYg5gB+YuJkf
         sPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPoR1P+Jx7C7d9k/Q/XUwBrh6UJnb7qtMiFYdsFu3s4=;
        b=GW307fbu8aCaAp3StbqH8ZOO0qr91tnAbXRvuneUpEy/29qe35eixUeCVGbWFbCXm/
         ntmfc6g3ba/M5fs4nza7ZnTxqGxP8eir1OI99bZHMiZ/CVrDGoyphh9NGfqT4+dDUEEv
         7ybK0sx24o7O7G4WLqmztm8nT71mT5QrRPHUM49gpQ8lku/qW4N/l1ue0nnAFHUtbuWh
         rl+cU0MCPPA5WNA9VQey0eFnZuzEqGev3+3FYfskTOlJHmiZSPC5/QoXSdEIEUcYl7+E
         HipFwitaMFZyt1ypwCsGDagfzy1h4/mF0w4sTNKEQsoe2EzF/OEVWv4l8G4+QGamWnc1
         BXPg==
X-Gm-Message-State: AHQUAuZxG0W8vFEcmJv4cJ/GVcDqEO69SfLc51tnzbYPGSiz2Ur27ip6
        rh9bIU9JpQXq5ZhCxrDJo6U9GH6/+UjaID0yVHo=
X-Google-Smtp-Source: AHgI3IahvAgFj6HX0sGtDIKUruSFZn0xCxQL8wQ1GZSiE85RxiZij1ehpjQ86ayaacrUV77MAUvau4Ai6qlYrAdGp8k=
X-Received: by 2002:a9d:69d4:: with SMTP id v20mr2314540oto.41.1550831615833;
 Fri, 22 Feb 2019 02:33:35 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190222102034epcas3p373245ed6e3e83e297bcaff48aec37992@epcas3p3.samsung.com>
 <20190222101948.848-1-linux.amoon@gmail.com> <d4f36ce1-ddef-5756-05dc-74e8dd08417c@samsung.com>
In-Reply-To: <d4f36ce1-ddef-5756-05dc-74e8dd08417c@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 22 Feb 2019 16:03:26 +0530
Message-ID: <CANAwSgSnunUbZJeT72B7HjAuBgsLQFA6_y_ijadHUKEAOoM-gA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add pin configuration for read strobe
 for Odroid XU3/XU4 eMMC
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Fri, 22 Feb 2019 at 15:59, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Anand,
>
> On 2019-02-22 11:19, Anand Moon wrote:
> > Add Read Strobe RDQS pin configuration for eMMC to support higher data rate read/write.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 6 ++++++
> >  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> > index b82af7c89654..4fb3865e082a 100644
> > --- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> > +++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> > @@ -206,6 +206,12 @@
> >               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> >       };
> >
> > +     sd0_rdqs: sd0-rdqs {
> > +             samsung,pins = "gpc0-7";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +     };
> > +
>
> The above lines are not needed. There is already a sd0_rclk node with
> exactly the same configuration just above your change.
>

Sorry once again, I failed to look closely., sorry for the noise.

Best Regards
-Anand

> >       sd1_clk: sd1-clk {
> >               samsung,pins = "gpc1-0";
> >               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > index b299e541cac0..d41397748ed2 100644
> > --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > @@ -411,7 +411,7 @@
> >       samsung,dw-mshc-hs400-timing = <0 2>;
> >       samsung,read-strobe-delay = <90>;
> >       pinctrl-names = "default";
> > -     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
> > +     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_rdqs &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
> >       bus-width = <8>;
> >       cap-mmc-highspeed;
> >       mmc-hs200-1_8v;
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
