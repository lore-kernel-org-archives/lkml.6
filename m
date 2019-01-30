Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D9EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6432218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548841616;
	bh=eq6mkz7tmSz4JqlH9cPSbzOyve7f/T0O6pQ9peiyEIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=je+QojDludGaYEsEH4F4qSk1PbxDKZq/xLbKzYRWiDAQKjjXY9DuJTEnQMAp1tYiu
	 XZwzbZlgRKoOJOg7BZnuQe1VVpCcppvxYUTGACYOItJoct4OJUeftJ5RapWbxPJQA2
	 hSqQR5YQpROOuecXobcMKINkmY13avN/86ELjoqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfA3Jqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfA3Jqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:46:54 -0500
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E30218A4;
        Wed, 30 Jan 2019 09:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548841613;
        bh=eq6mkz7tmSz4JqlH9cPSbzOyve7f/T0O6pQ9peiyEIc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fFW5AIwnxWlGldCMqXGdPLLAv9I3WhvONdvIhPa4LwMAvPA0lPHsI73mk8ZmqzY2O
         4m0tvkA3ZEAT+10Qklvs1OP5S/J8/TUZn5mNyV2+kbKT0zhwhEVLO3pFVIWN+Bkp2s
         f4s23q5sllAwtCMF64Ao+SYkWN0UgRqlCzHo1l2A=
Received: by mail-lf1-f54.google.com with SMTP id f5so16852946lfc.13;
        Wed, 30 Jan 2019 01:46:53 -0800 (PST)
X-Gm-Message-State: AJcUukfrHBuynJz0UHwrt82HCIBKVtMC7M9fX9459fN02QcuFEwxnkud
        EX99ivwqQqY0meW2aw9G6aadP8SurtSQqiGlcaQ=
X-Google-Smtp-Source: ALg8bN61aj/FiXXDgFycATgLJ2gdYQ6qz8VxuYXguWjaGkfgynYNnDZoXdCzq6sv17QfVxUYvVWlpioJGlSzoUuYSew=
X-Received: by 2002:ac2:4194:: with SMTP id z20mr22462742lfh.74.1548841611662;
 Wed, 30 Jan 2019 01:46:51 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190129175526eucas1p253dc2e8a0d64b34d95c84d585fb0fac0@eucas1p2.samsung.com>
 <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com> <1548784514-26649-7-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1548784514-26649-7-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 30 Jan 2019 10:46:40 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcfZsZPYStrV-QOd2YJsoaJdbtdz2RX-AJrC6A6B8vJqA@mail.gmail.com>
Message-ID: <CAJKOXPcfZsZPYStrV-QOd2YJsoaJdbtdz2RX-AJrC6A6B8vJqA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] DT: arm: exynos: add DMC device for exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 at 18:55, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add description of Dynamic Memory Controller and PPMU counters.
> They are used by exynos5422-dmc driver.
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
>  arch/arm/boot/dts/exynos5420.dtsi             | 69 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 +++++++++
>  2 files changed, 91 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff158..4d76335 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -235,6 +235,27 @@
>                         status = "disabled";
>                 };
>
> +               dmc: memory-controller@10c20000 {
> +                       compatible = "samsung,exynos5422-dmc";
> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +                               <0x10030000 0x1000>, <0x10000000 0x1000>;
> +                       clocks = <&clock CLK_FOUT_SPLL>,
> +                               <&clock CLK_MOUT_SCLK_SPLL>,
> +                               <&clock CLK_FF_DOUT_SPLL2>,
> +                               <&clock CLK_FOUT_BPLL>, <&clock CLK_MOUT_BPLL>,
> +                               <&clock CLK_SCLK_BPLL>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                               <&clock CLK_MOUT_MCLK_CDREX>,
> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
> +                               <&clock CLK_CLKM_PHY0>, <&clock CLK_CLKM_PHY1>;
> +                       clock-names = "fout_spll", "mout_sclk_spll",
> +                               "ff_dout_spll2", "fout_bpll", "mout_bpll",
> +                               "sclk_bpll", "mout_mx_mspll_ccore",
> +                               "mout_mx_mspll_ccore_phy", "mout_mclk_cdrex",
> +                               "dout_clk2x_phy0", "clkm_phy0", "clkm_phy1";

We misunderstood each other. I did not ask for compaction into one
continued line but for proper indentation. Having one entry per one
line was fine because you have really a lot of entries and it was
making things easier to check.
It should look like:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos54xx.dtsi?h=v4.20#n78

Best regards,
Krzysztof
