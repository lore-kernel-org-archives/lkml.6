Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2F0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3124A2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAck+mNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439441AbfBNOwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:52:21 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38906 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfBNOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:52:20 -0500
Received: by mail-it1-f195.google.com with SMTP id l66so4840765itg.3;
        Thu, 14 Feb 2019 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+EGt+v5ZyVvPKwVW3emNjKEWeGsO2xJtAz1zaHUXrBU=;
        b=YAck+mNs/CPhSATtPY3A+HQ1SQVRWX6LVgVNMp3RMAlrd36W4KQ0FybFxm5aco7jPl
         7ohcscM3KZrSCLBBeZJxxigV7BmH6OlqlOsiOuxDHTp3sd7utq+Abvf6zKtFd0pix/SN
         /xecmi5kYK67GEgq7DW9WdNHMc40SkJqtexz6KjtAJ+MMS/CbaDqerur98Y65j68cTD9
         j6YHk/mU0lHLAhVKpmAlvDf/SUmJhBx5xeYeIJwCs1oE5GKeIKEmJySWd5+8TOfL/GMk
         obARw/CmdSQa3ESsdgu1w7JaWNzVv+MtoQ7iApfRutp0sKlhexqjp0ORfontJEam8vI1
         IdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EGt+v5ZyVvPKwVW3emNjKEWeGsO2xJtAz1zaHUXrBU=;
        b=dSlwOyPmOA9Wpnw89jCiYDxFJmlbDSiXFxO7So+c2YYMPXIjRy0y7pmLNpNw+9BgCJ
         WPr6v7tKviFFOY0KhEEjt0GpNVHiyO/soW4SKsM7sW2CUPcpLQWRKNGW8gRDtdjiv+5V
         QIIjs2m6BbK+TjMbVo1+Z9JVIiQl5SusXgUOyrA0Aa5a41XaGCfopqEIdCQWz2j67Dg8
         n1zw5rVtSY3gU5UIEtCx0+v7xrF/LPxe+gRCMJs5lInUJV9+WwlH2wmZjnbQynlOn0ux
         sx+/68fteti+pSU7joU1gm3v4oAKSVx3v4vim4Ju6tz2TIz0uv3SBMSYYmCwnIbB45Zq
         FryA==
X-Gm-Message-State: AHQUAuaFNevZbe3L/0xTns5ET1twdREeEQnI/FDUZJArySYDKYHQ/X6o
        VVuqAEBJdFRa2oHOglX+g/+4XUhGTtaHusIDJ94=
X-Google-Smtp-Source: AHgI3IY0C6Q/oztInKZQxwyd8k+COA306ww4jbwsIY03ZnBRkG6j/9fn3yyHQktGFWb1K6Y0nT0EJ+UQIh8nft81mcY=
X-Received: by 2002:a6b:c545:: with SMTP id v66mr1752509iof.40.1550155938783;
 Thu, 14 Feb 2019 06:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20190214130910.9201-1-tiny.windzz@gmail.com> <20190214130910.9201-5-tiny.windzz@gmail.com>
 <20190214143842.nqsh6trwdjxq2ecd@flea>
In-Reply-To: <20190214143842.nqsh6trwdjxq2ecd@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 14 Feb 2019 22:52:16 +0800
Message-ID: <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:38 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Thu, Feb 14, 2019 at 08:09:10AM -0500, Yangtao Li wrote:
> > Add an OPP (Operating Performance Points) table for the CPU cores to
> > enable DVFS (Dynamic Voltage & Frequency Scaling) on the H6. This
> > information comes from github.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 61 ++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > index 57a1390ecdc2..46a4a69eb38f 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -28,6 +28,8 @@
> >                       enable-method = "psci";
> >                       clocks = <&ccu CLK_CPUX>;
> >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> >               };
> >
> >               cpu1: cpu@1 {
> > @@ -37,6 +39,8 @@
> >                       enable-method = "psci";
> >                       clocks = <&ccu CLK_CPUX>;
> >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> >               };
> >
> >               cpu2: cpu@2 {
> > @@ -46,6 +50,8 @@
> >                       enable-method = "psci";
> >                       clocks = <&ccu CLK_CPUX>;
> >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> >               };
> >
> >               cpu3: cpu@3 {
> > @@ -55,6 +61,61 @@
> >                       enable-method = "psci";
> >                       clocks = <&ccu CLK_CPUX>;
> >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +     };
> > +
> > +     cpu_opp_table: opp_table {
> > +             compatible = "operating-points-v2";
> > +             opp-shared;
> > +
> > +             opp@480000000 {
> > +                     opp-hz = /bits/ 64 <480000000>;
> > +                     opp-microvolt = <800000 800000 880000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@720000000 {
> > +                     opp-hz = /bits/ 64 <720000000>;
> > +                     opp-microvolt = <800000 800000 880000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@816000000 {
> > +                     opp-hz = /bits/ 64 <816000000>;
> > +                     opp-microvolt = <800000 800000 880000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@888000000 {
> > +                     opp-hz = /bits/ 64 <888000000>;
> > +                     opp-microvolt = <800000 800000 940000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1080000000 {
> > +                     opp-hz = /bits/ 64 <1080000000>;
> > +                     opp-microvolt = <840000 840000 1060000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1320000000 {
> > +                     opp-hz = /bits/ 64 <1320000000>;
> > +                     opp-microvolt = <900000 900000 1160000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1488000000 {
> > +                     opp-hz = /bits/ 64 <1488000000>;
> > +                     opp-microvolt = <960000 960000 1160000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp@1800000000 {
> > +                     opp-hz = /bits/ 64 <1800000000>;
> > +                     opp-microvolt = <1060000 1060000 1160000>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
>
> So we definitely want to have that tested, especially since cpufreq
> can lead to all kind of hard to debug errors (brown-outs, CPU lockups,
> cache corruption, etc.). I good way to test that would be to use
> cpufreq-ljt-stress-test here:
> https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test
>
> I'm especially worried about the higher frequencies that will probably
> make the SoC heat too much
Indeed, in order to avoid this situation, it is best to have cpu cooling
support(But now it does not support thermal driver? ).


In this case, perhaps we should remove the frequency beyond a certain
range to avoid the CPU being too hot?

Yangtao
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
