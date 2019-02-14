Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3782C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E26721B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnHKDAoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbfBNSfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:35:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40041 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfBNSfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:35:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so12204842oth.7;
        Thu, 14 Feb 2019 10:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUnkOqkP+lBT8YabWNtqwczvSIOggUSareKuDeSX5K4=;
        b=NnHKDAoPXq2QSP0cf5oPksTx0TTuMaoP5XYkS573P3BMwiEqHQ5/y6pj6hLK8/4w4u
         8LWW5wJgysrtqWAYX9WvDhtkAE9glFVfu2XD2s6wcbxdKv3c5HG6B7HlEPofkiiYnZYi
         t8f+ignWuPKpeRFCjX8pAmn0j5iiQVIhhPpqIW5WzxM7DT3508r5JpMvpiYSjLZk+wNo
         B5ibyod+gvMwe82LAUR/mYBt0T3eZydP6dcSKQ65U7JXaITNIifp2PRdFWBeUpQbGDsy
         UyZCdUVVGp0LSRQjov6hpUtuHYLAbOt8U4/pBIsqEr+mSWMgUJ8hs6pzSfYvIJpno4ae
         oWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUnkOqkP+lBT8YabWNtqwczvSIOggUSareKuDeSX5K4=;
        b=lsnFWSnGPV3t3J8HjkJhL9RHxL8kKze/5N5Kt/0PYjhuFUT+Thsi9Vh8ApWbTdPYvn
         hk4WKkrGndLvYfV2nOBzzzKSvomZo881ekyDTUnZjmwZAt7cHcxRCOeKnKA8cj/L0fpU
         rnF+bE7UEJTvQCAyJyzZ5hpPYYXorpUXaPgtpLfivD8aj07YXARyOZO3B7EmGWplJsmo
         qjHcc+7O4sMi5Ua51ztUhlnLUFP/4NaC6AdpLhkvc2ICR+QpTzVmyYvRT1VWSe+3StQ8
         0dn4jevh3ZMp8LXZXcCfqvO69/VF4pBRVvQ907ZV1qsrtTOG3TXV1ynE82GmPo4QODAH
         fNvQ==
X-Gm-Message-State: AHQUAubboYlvXq0ObKVXpmw8G2wZl2jtfQBako/NpMXr1mzXx1EXTGxT
        7zXfsYczGHHPKhRz95Y0hrD6nly+fTTmhcWZy0Q=
X-Google-Smtp-Source: AHgI3IYXQd3PGXNPZvIN87V3A9BR1tXWrPdV6xnCmMCkSjzrNSsblc2fK6l0BKQtSNUjE/XTTlIn8a9WrLfFi7zcFm4=
X-Received: by 2002:a9d:c61:: with SMTP id 88mr3302161otr.335.1550169304636;
 Thu, 14 Feb 2019 10:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20190213214052.2427-1-linux.amoon@gmail.com> <20190213214052.2427-2-linux.amoon@gmail.com>
 <CAJKOXPeyFmKUGwqS1sgf_k2WSx9i0AETjpOLXtsmLFupTpgqnw@mail.gmail.com>
In-Reply-To: <CAJKOXPeyFmKUGwqS1sgf_k2WSx9i0AETjpOLXtsmLFupTpgqnw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 15 Feb 2019 00:04:54 +0530
Message-ID: <CANAwSgQB-=iwX1L0m6N=dbe6jbfUMYyjgna_QMmJyggj6rxzwQ@mail.gmail.com>
Subject: Re: [RFC 1/2] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Krzysztof,

Thanks fro your review comments.

On Thu, 14 Feb 2019 at 18:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi Anand,
>
> Thanks for the patch. See comments below.
>
> On Wed, 13 Feb 2019 at 22:41, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add suspend-to-mem node to regulator core to be enabled or disabled
> > during system suspend and also support changing the regulator operating
> > mode during runtime and when the system enter sleep mode.
> >
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >
> > Changes from previos patch
> > [0] https://patchwork.kernel.org/patch/10712549/
> >
> > Set all the WAKEUP source regulator in suspend-on state.
> > LD04, LD012, LD015, LD020, LD022
> > Set all the non used regulator in suspend-odd state
> > LD02, LD03, LD05, LD06, LD07, LD011, LD013, LDO14, LD016
> >
> > BUCK5, BUCK6, BUCK7 and not confirable as per driver max77686-regulator
> >
> > Tested on microSD card and it resumes correcly after suspend.
> > eMMC is not able to resume after entering into suspend state,
> > which need to be investigated and how to debug more.
> > ---
> >  .../boot/dts/exynos4412-odroid-common.dtsi    | 63 +++++++++++++++++++
> >  arch/arm/boot/dts/exynos4412-odroidu3.dts     |  3 +
> >  2 files changed, 66 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > index 08d3a0a7b4eb..e984461c37d9 100644
> > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > @@ -288,6 +288,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
>
> I see my comment from previous patch was not addressed.

I left this unchanged since this regulator is not active linked and used.
Ok I will change this to regulator-on-in-suspend,

From documentation device tree binding regulator.txt
"- regulator-always-on: boolean, regulator should never be disabled"

But some regulator switches to a low power mode under light current loads
and the device automatically switches back to a fast response mode as the
output load increases.

>
> >                         };
> >
> >                         ldo3_reg: LDO3 {
> > @@ -295,6 +298,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
>
> The same...

Ok I will change this to regulator-on-in-suspend,

>
> >                         };
> >
> >                         ldo4_reg: LDO4 {
> > @@ -302,6 +308,9 @@
> >                                 regulator-min-microvolt = <2800000>;
> >                                 regulator-max-microvolt = <2800000>;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo5_reg: LDO5 {
> > @@ -310,6 +319,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo6_reg: LDO6 {
> > @@ -317,6 +329,9 @@
> >                                 regulator-min-microvolt = <1000000>;
> >                                 regulator-max-microvolt = <1000000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo7_reg: LDO7 {
> > @@ -324,18 +339,27 @@
> >                                 regulator-min-microvolt = <1000000>;
> >                                 regulator-max-microvolt = <1000000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo8_reg: LDO8 {
> >                                 regulator-name = "VDD10_HDMI_1.0V";
> >                                 regulator-min-microvolt = <1000000>;
> >                                 regulator-max-microvolt = <1000000>;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo10_reg: LDO10 {
> >                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo11_reg: LDO11 {
> > @@ -343,6 +367,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo12_reg: LDO12 {
> > @@ -351,6 +378,9 @@
> >                                 regulator-max-microvolt = <3300000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo13_reg: LDO13 {
> > @@ -359,6 +389,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo14_reg: LDO14 {
> > @@ -367,6 +400,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo15_reg: LDO15 {
> > @@ -375,6 +411,9 @@
> >                                 regulator-max-microvolt = <1000000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo16_reg: LDO16 {
> > @@ -383,6 +422,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo20_reg: LDO20 {
> > @@ -396,6 +438,9 @@
> >                                 regulator-min-microvolt = <2800000>;
> >                                 regulator-max-microvolt = <2800000>;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
>
>
> The same... any comments?

I left this on for mshc_0 (emmc) regulator,
since I could not get suspend resume working on eMMc

>
> >                         };
> >
> >                         ldo22_reg: LDO22 {
> > @@ -405,6 +450,9 @@
> >                                  */
> >                                 regulator-name = "LDO22";
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo25_reg: LDO25 {
> > @@ -413,6 +461,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         buck1_reg: BUCK1 {
> > @@ -421,6 +472,9 @@
> >                                 regulator-max-microvolt = <1100000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
>
> Again, you did not address my comments.
>

Buck1 support entering into LPM setting,
But I will set this to regulator-on-in-suspend; in next patch.

> > +                               };
> >                         };
> >
> >                         buck2_reg: BUCK2 {
> > @@ -429,6 +483,9 @@
> >                                 regulator-max-microvolt = <1350000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         buck3_reg: BUCK3 {
> > @@ -437,6 +494,9 @@
> >                                 regulator-max-microvolt = <1050000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
>
> The same...

Buck3 support entering into LPM setting,
But I will set this to regulator-on-in-suspend; in next patch.

>
> >                         };
> >
> >                         buck4_reg: BUCK4 {
> > @@ -444,6 +504,9 @@
> >                                 regulator-min-microvolt = <900000>;
> >                                 regulator-max-microvolt = <1100000>;
> >                                 regulator-microvolt-offset = <50000>;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         buck5_reg: BUCK5 {
> > diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > index 2bdf899df436..4ebde09fc51d 100644
> > --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > @@ -82,6 +82,9 @@
> >         regulator-name = "LDO22_VDDQ_MMC4_2.8V";
> >         regulator-min-microvolt = <2800000>;
> >         regulator-max-microvolt = <2800000>;
> > +       regulator-state-mem {
> > +               regulator-on-in-suspend;
>
> Why?
>

I chose not to disable mshc_0 (emmc) regulator,
since I could not get suspend resume working on eMMC.

> Best regards,
> Krzysztof

Best Regards

-Anand
