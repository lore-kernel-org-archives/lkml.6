Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AE2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FB320855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LXcJbimF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FB320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeK0Co0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:44:26 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:30562 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0Co0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:44:26 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAQFnfDQ009105;
        Tue, 27 Nov 2018 00:49:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAQFnfDQ009105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543247381;
        bh=8EUBaF/CO/3E+rlAYdfoIJSKGOBFTYWcflaN2XtYZFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LXcJbimFvaAl0LvUfBlds0xHccgP6ALyrMmaeuuaVtb3mGbZ8E6unQMhJjuhHnJFR
         +13jlMUkbzXiqQ+XcXShL2qDLFVgVBNSGpkobcYEMBKGKTvV8yGP2I0Gkw79cspLoP
         DNcwkolK2WRrvCO85nHipW6H3JhGzcFTu/W+Hkoj6S9N+q784+OlXv2xgjb42fx1oi
         KaYF526jH4pomLYFHzAEPBgj/Cs+eL6Xql8ofT3AtsCIeRzQsa5J/aFKm4aI+R0lIj
         W5UT/ZxZDx/Hp5yO8ssRa84d6o5nahtzhwlqQU6hiZoxSBb/tPdfs3M5UNCQ876S4O
         nDAbu4Xy9bq6g==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id h78so11614335vsi.6;
        Mon, 26 Nov 2018 07:49:41 -0800 (PST)
X-Gm-Message-State: AGRZ1gJ6Yvkv0nzgyz7+A9YXvaYPIcy/82eF4m8sD9m+PtY6cpWzv2US
        yXaQG2rJYRO54nWj37pg+MX4+GqWMVIHmJdAXko=
X-Google-Smtp-Source: AJdET5e949g3kg3MYp9aBKF8/nkaAYvUwl7quyX+PypQXAImnGZRRkGv0KLzZzmx8GgbEigdUt4hz+dVYoF6tg/9bBQ=
X-Received: by 2002:a67:385a:: with SMTP id f87mr11873768vsa.179.1543247380192;
 Mon, 26 Nov 2018 07:49:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542362530.git.viresh.kumar@linaro.org> <c759699a44189aed078186fd19089d2f44d988e3.1542362530.git.viresh.kumar@linaro.org>
In-Reply-To: <c759699a44189aed078186fd19089d2f44d988e3.1542362530.git.viresh.kumar@linaro.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 27 Nov 2018 00:49:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5OhS4tcZCP_Rykpxsgc5-rJTiZXS_yOravZv6iEeP3g@mail.gmail.com>
Message-ID: <CAK7LNAQ5OhS4tcZCP_Rykpxsgc5-rJTiZXS_yOravZv6iEeP3g@mail.gmail.com>
Subject: Re: [PATCH 10/10] ARM64: dts: uniphier: Add all CPUs in cooling maps
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm-soc <arm@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 7:06 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
>
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
>
> Update cooling maps to include all devices affected by individual trip
> points.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


Applied to linux-uniphier.
Thanks.




> ---
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index d7e2d8969601..4a0c46cb11cd 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -206,13 +206,10 @@
>                         cooling-maps {
>                                 map0 {
>                                         trip = <&cpu_alert>;
> -                                       cooling-device = <&cpu0
> -                                           THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -                               };
> -                               map1 {
> -                                       trip = <&cpu_alert>;
> -                                       cooling-device = <&cpu2
> -                                           THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>                                 };
>                         };
>                 };
> --
> 2.19.1.568.g152ad8e3369a
>


-- 
Best Regards
Masahiro Yamada
