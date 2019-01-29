Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19647C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6364214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548774847;
	bh=qlHSCtwc7CZA3lrjJGWS5xngOSzHuOiH244mYsIbt80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qonomfYuyqqG8zR95QQHnvqRssJR5fhmvbthTYOiIbccSuCOEC8RA/PFuXTqn5OFX
	 bQTpnMS0syT75CLrStGU7+y/OcPKx1CYEHym558ofmhkdCzwgwBTZyw7uKwuE/2X/T
	 HdKnDeyxD9jqvFKZGBvZT4eSPiAazABiHbw4xN4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfA2POF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:14:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfA2POF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:14:05 -0500
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC58214DA;
        Tue, 29 Jan 2019 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548774843;
        bh=qlHSCtwc7CZA3lrjJGWS5xngOSzHuOiH244mYsIbt80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DFfvJuBA+/NxylKGdMVIShV15qaC6hXW6yZIN0fVoWYef4ZAUXbLLiNIwxREi6W1o
         6LfRJsZwJ6EUWmir1IjOM0WwC4UFmlYRVg4BBMkCZyfy6syHpsQ7jER8HnM+mNbRpM
         o873b6+xMj5PrmKxiGfGFMw1tyPS6IacEy1R7JPo=
Received: by mail-lj1-f174.google.com with SMTP id g11-v6so17813755ljk.3;
        Tue, 29 Jan 2019 07:14:03 -0800 (PST)
X-Gm-Message-State: AJcUukfx1fj1112MkPAhXrNzW58eYwBi+Qegfd1R4mZd2bGjXUZUViEa
        9e5BOmwt7X1lxCsmChrup64NyoVao/7apAlrmrU=
X-Google-Smtp-Source: ALg8bN5SddqFDnQ12cd2+9JeO+tBIl6WXCSpKA4VlBPmtTIjEQOWTwYRGmX4YrbExzUdKhfacYkTF5AbTCLQ0JVraqY=
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr18632864lja.19.1548774841270;
 Tue, 29 Jan 2019 07:14:01 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190128192154eucas1p2e696de47c5aab0cdb80cff32254daaf9@eucas1p2.samsung.com>
 <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com> <1548703299-15806-7-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1548703299-15806-7-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 29 Jan 2019 16:13:49 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfHzspKWxHcf=DGf73v0sdnG=oDAa-9QLv2eRCHoC9RwQ@mail.gmail.com>
Message-ID: <CAJKOXPfHzspKWxHcf=DGf73v0sdnG=oDAa-9QLv2eRCHoC9RwQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] DT: arm: exynos: add DMC device for exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, myungjoo.ham@samsung.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 at 20:21, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add description of Dynamic Memory Controller and PPMU counters.
> They are used by exynos5-dmc driver.
>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: devicetree@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-samsung-soc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 81 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 ++++++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff158..6880d13 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -1337,6 +1337,87 @@
>                                 opp-hz = /bits/ 64 <400000000>;
>                         };
>                 };
> +
> +               ppmu_dmc0_0: ppmu_dmc0_0@10d00000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d00000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +                                       event-name = "ppmu-event3-dmc0_0";
> +                               };
> +                       };
> +               };
> +
> +

No need for double line.

> +               ppmu_dmc0_1: ppmu_dmc0_1@10d10000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d10000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
> +                                       event-name = "ppmu-event3-dmc0_1";
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc1_0: ppmu_dmc1_0@10d10000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d60000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
> +                                       event-name = "ppmu-event3-dmc1_0";
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc1_1: ppmu_dmc1_1@10d70000 {

1. Generic node name, e.g. "ppmu".
2. Please put all ppmu nodes after nocp nodes to group everything logically.

> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d70000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
> +                                       event-name = "ppmu-event3-dmc1_1";
> +                               };
> +                       };
> +               };
> +
> +               dmc: dmc@10c20000 {

1. Node name: memory-controller.
2. Put it before nocp nodes.

> +                       compatible = "samsung,exynos5422-dmc";
> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +                               <0x10030000 0x1000>, <0x10000000 0x1000>;
> +                       clocks =        <&clock CLK_FOUT_SPLL>,

Weird indentation.

> +                                       <&clock CLK_MOUT_SCLK_SPLL>,
> +                                       <&clock CLK_FF_DOUT_SPLL2>,

Indent all continued lines with first entry (like in other places in this file).

> +                                       <&clock CLK_FOUT_BPLL>,
> +                                       <&clock CLK_MOUT_BPLL>,
> +                                       <&clock CLK_SCLK_BPLL>,
> +                                       <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                                       <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                                       <&clock CLK_MOUT_MCLK_CDREX>,
> +                                       <&clock CLK_DOUT_CLK2X_PHY0>,
> +                                       <&clock CLK_CLKM_PHY0>,
> +                                       <&clock CLK_CLKM_PHY1>
> +                                       ;

Join the trailing semicolon with previous lines.

> +                       clock-names =   "fout_spll",
> +                                       "mout_sclk_spll",

Indent all continued lines with first entry (like in other places in this file).

> +                                       "ff_dout_spll2",
> +                                       "fout_bpll",
> +                                       "mout_bpll",
> +                                       "sclk_bpll",
> +                                       "mout_mx_mspll_ccore",
> +                                       "mout_mx_mspll_ccore_phy",
> +                                       "mout_mclk_cdrex",
> +                                       "dout_clk2x_phy0",
> +                                       "clkm_phy0",
> +                                       "clkm_phy1"
> +                                       ;

Join the trailing semicolon with previous lines.
> +               };
>         };
>
>         thermal-zones {
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index bf09eab..54ee8b2 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -119,6 +119,28 @@
>         status = "okay";
>  };
>
> +&ppmu_dmc0_0 {
> +       status = "okay";
> +};
> +
> +&ppmu_dmc0_1 {
> +       status = "okay";
> +};
> +
> +&ppmu_dmc1_0 {
> +       status = "okay";
> +};
> +
> +&ppmu_dmc1_1 {
> +       status = "okay";
> +};

Put the new entries respecting alphabetical order (order of label name).

> +
> +&dmc {

The same.

Best regards,
Krzysztof

> +       devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
> +                       <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
> +       status = "okay";
> +};
> +
>  &cpu0 {
>         cpu-supply = <&buck6_reg>;
>  };
> --
> 2.7.4
>
