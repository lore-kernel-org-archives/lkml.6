Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55223ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13B120858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1p3eejy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13B120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389856AbeIURAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeIURAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:00:43 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A6B2154C;
        Fri, 21 Sep 2018 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537528339;
        bh=7DFymsx6Z0oSh3UnOxkVXNdlpSHuk/ei//nRiC8MB2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d1p3eejynUCvRl/f7Zp4EXl7xwHiEIdykXeBe+cGznX4bAHwVcXZqs/rgsAOYxA2O
         KgqQZe6sV4vLML2WhrBUnOPywu43NjyQQtrKrkup/pO3p4InULmY38714mRFldCMgu
         8aEwdUPdI4w1lNg9ziZWMfNqIvBQ3rse+7ZkH3wE=
Received: by mail-wm1-f47.google.com with SMTP id q8-v6so2796358wmq.4;
        Fri, 21 Sep 2018 04:12:19 -0700 (PDT)
X-Gm-Message-State: APzg51BFEqI1MomRxEjwjW/dyXyyTSUvkgLiYLvSbfCV7euVAs90j+m9
        HAP+EWZNarcTDVJH/qDbbjSv6Aj7IEpN1RnuSnA=
X-Google-Smtp-Source: ACcGV60hNVt1lusof4o8aLoEQwbDemRkDnVw3ukOmVM1ODX7ZpNeGoSWtzxSAXFOjwUKoSGwXBVSaSU7YO4y63VHSLY=
X-Received: by 2002:a1c:a60e:: with SMTP id p14-v6mr6768397wme.64.1537528337529;
 Fri, 21 Sep 2018 04:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180920175826.1284-1-linux.amoon@gmail.com> <20180920175826.1284-6-linux.amoon@gmail.com>
In-Reply-To: <20180920175826.1284-6-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 21 Sep 2018 13:12:06 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdUVjG1xR-q-K98RQpqsWzw-emEv2_3x3CoS+XK8cye2Q@mail.gmail.com>
Message-ID: <CAJKOXPdUVjG1xR-q-K98RQpqsWzw-emEv2_3x3CoS+XK8cye2Q@mail.gmail.com>
Subject: Re: [PATCHv3 5/7] ARM: dts: exynos5422: use wp-gpio method to detect sd-card
To:     linux.amoon@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 at 19:59, Anand Moon <linux.amoon@gmail.com> wrote:
>
> add the Write Protect GPIO property for sdcard, to fix
> the warning message during boot time.
> of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/soc/mmc@12220000[0]'
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> New patch to this series.
> If we keep the wp-gpio GPIO_ACTIVE_LOW sdcard boot into RO mode.
> ---
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 03fe02ceae66..475c38bbc99e 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -370,6 +370,7 @@
>         cap-sd-highspeed;
>         max-frequency = <200000000>;
>         cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
> +       wp-gpios = <&gpc4 0 GPIO_ACTIVE_HIGH>;

Two issues here:
1. You need also proper pinctrl setting.
2. On schematics the WP is not connected... so how do you know that it
is active high? How did you test it? How do you want to test it on
microSD?

Best regards,
Krzysztof

>         vmmc-supply = <&ldo19_reg>;
>         vqmmc-supply = <&ldo13_reg>;
>         sd-uhs-sdr50;
> --
> 2.17.1
>
