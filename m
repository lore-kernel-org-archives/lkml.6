Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1429EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D133220664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gp9r/IxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D133220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeK0Cot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:44:49 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:63658 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbeK0Cot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:44:49 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wAQFo03N009191;
        Tue, 27 Nov 2018 00:50:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wAQFo03N009191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543247401;
        bh=hL+L3u9Fm2Haz7qoi3wTzyMopfmO+fzPMqkMT2tsQ2U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gp9r/IxJzkf3HeT1FoVi+Bnk5iQEqhEW8d07ziuKfZhVcf+pTue8aLl5V25ABeDsp
         5Rm2FOYUCj+eGVl5DifhXuFB8NqAjhzfZj5KVVPvm9R7QtVHfvt9ItnW1UtXlVwRLb
         zXxu1ipXxkZOkeD++18AAJHt779Z9u/3kGxO9MYmCbQjODah0jIvUZ/GznUpmP46kw
         bphD1oVPhL12ewA7XtcwKS1uQsscPXJzwscBlsQKO/AXjlklci/kzDO8vq4YNSeOWS
         8yGVrSmkeU7FIdCqlFgQV9jgvhycMkfuny6qOZqUuOJy/b1OT6MP12zNfqAJjBFpQd
         V7bxEq1xQahuw==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id d19so6445943uaq.11;
        Mon, 26 Nov 2018 07:50:00 -0800 (PST)
X-Gm-Message-State: AA+aEWZjjd9NP9gjVqNB7HUn/H6fOBeKYStSOYiiZS5UCRWt4/Gfqr/V
        eYxWZii3V6WBUylV6vOjzA3GfCbwnfv3lLiCCSA=
X-Google-Smtp-Source: AFSGD/VukaDB3Vj3fzz7Nl3TN+LKs/MONeFxFkv30nfMH95NV5Kzc0SrLhFkNXFkEeA+07WVFxOPo55JfsJuzGB7QaE=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr10874260uaj.42.1543247399696;
 Mon, 26 Nov 2018 07:49:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542362000.git.viresh.kumar@linaro.org> <b522f13dfffcec1e2b78e126513114428ec9a4b4.1542362000.git.viresh.kumar@linaro.org>
In-Reply-To: <b522f13dfffcec1e2b78e126513114428ec9a4b4.1542362000.git.viresh.kumar@linaro.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 27 Nov 2018 00:49:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNATh3cGVC+KhBtATyzvCnzqv_QpFujjg_J7WikRHq0rjPA@mail.gmail.com>
Message-ID: <CAK7LNATh3cGVC+KhBtATyzvCnzqv_QpFujjg_J7WikRHq0rjPA@mail.gmail.com>
Subject: Re: [PATCH 6/6] ARM: dts: uniphier: Add all CPUs in cooling maps
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
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

On Fri, Nov 16, 2018 at 7:02 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
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
>  arch/arm/boot/dts/uniphier-pxs2.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> index 8d20e9548e39..06a049f6edf8 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> @@ -141,8 +141,10 @@
>                         cooling-maps {
>                                 map {
>                                         trip = <&cpu_alert>;
> -                                       cooling-device = <&cpu0
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
