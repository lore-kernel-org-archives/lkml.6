Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C257C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466342152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466342152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeI0BVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:21:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34422 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeI0BVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:21:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so2890644edr.1;
        Wed, 26 Sep 2018 12:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eyAUno7dCoPQO4E2Fq/fpMiyoPi9ZXVl138MM23sWII=;
        b=B1nAOVuLeheqCaIhLtBct5q34pB0NjVpIVWRoq64TBArgd94URwwljIyW2BOxEwU8Z
         vHWqrqF3J0XoTWNqe6QWH/sqmp6lb66HjioHyHKtpKUH5m8pcSifrtkmVSF//ziuKKMY
         Qi7Lz7BnmfVf/eHLtFkINbZAIKL8ZtVYMvKwsh59ZqXZ8kDauWBxh9t2eT9Xc+21emhM
         4e6A9s8rBiYYA14moion5gx2GM5tk9XDSHjRNFBgTof6LMGhRstnq/C60WNDtfdFII3/
         u87h1IN2ZGCdPrL4zWQBjdV9up7X5wswj8QODkuVWjsqQw8BwyCz/k1YbhrWIOz+cip3
         nhbQ==
X-Gm-Message-State: ABuFfojKgav0QtfMIEhukp6vJP3bBJ8Iv9GzDukDV8PdiirV5BulZAuS
        DoNxLfj9PkSVJSfR4h8AcB/qTasz
X-Google-Smtp-Source: ACcGV60u2nukFHccRxvcU/qIMeOKFSma0pJtsm3per+nL0XddR+yKclC8aJ78yP0xmE+gkTI/PbFig==
X-Received: by 2002:a50:f1c2:: with SMTP id y2-v6mr10540952edl.21.1537988802128;
        Wed, 26 Sep 2018 12:06:42 -0700 (PDT)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id b58-v6sm369315ede.37.2018.09.26.12.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 12:06:41 -0700 (PDT)
Date:   Wed, 26 Sep 2018 21:06:39 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCHv4 4/6] ARM: dts: exynos: Add CD and WP pins to Odroid
 XU3/XU4 SD card
Message-ID: <20180926190639.GA6461@kozik-lap>
References: <20180922075238.884-1-linux.amoon@gmail.com>
 <20180922075238.884-6-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180922075238.884-6-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 07:52:36AM +0000, Anand Moon wrote:
> Add the card-detect and write-protect GPIO pins for OdroidXU3/XU4
> SD card by adding pinctrl setting for wp-gpio pin and set it to
> active low.
> 
> This also removes debug messages:
>     dwmmc_exynos 12220000.mmc: No GPIO consumer cd found
>     dwmmc_exynos 12220000.mmc: No GPIO consumer wp found
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Fix the commit message and squash it with cd-gpios and wp-gpio
> patches into single patch as suggested by Krzysztof.

As Marek pointed to my Odroid XU patch, there is no point of adding
cd-gpios and wp-gpios properties.

Adding pin configuration for wp pin is also not needed. Reset values are
working properly. However there might be meaning of adding it just in
case - if bootloader decided to touch it...

Best regards,
Krzysztof


> ---
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi     | 8 ++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 4 +++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> index dda8ca2d2324..9a39a0d8ec86 100644
> --- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> @@ -289,6 +289,14 @@
>  		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>  		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
>  	};
> +
> +	sd2_wp: sd2-wp {
> +		samsung,pins = "gpc4-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		/* Pin is floating so pull it up to disable write-protect */
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> +	};
>  };
>  
>  &pinctrl_2 {
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index a80b6c045154..2aacfb669140 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -498,10 +498,12 @@
>  	samsung,dw-mshc-sdr-timing = <0 4>;
>  	samsung,dw-mshc-ddr-timing = <0 2>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
> +	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_wp &sd2_bus1 &sd2_bus4>;
>  	bus-width = <4>;
>  	cap-sd-highspeed;
>  	max-frequency = <200000000>;
> +	cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&gpc4 0 GPIO_ACTIVE_LOW>;
>  	vmmc-supply = <&ldo19_reg>;
>  	vqmmc-supply = <&ldo13_reg>;
>  	sd-uhs-sdr50;
> -- 
> 2.17.1
> 
