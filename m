Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42D2C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9354D2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvwNm/qC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9354D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeICNls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:41:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34675 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeICNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:41:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so17105625wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SbOJ0iDC7mjyjxIUXAPB+3RlnZNYqi363AzaXXN9ecM=;
        b=NvwNm/qCH14yhMar3URBZ+pY4hnm75xZJM3uSp7vNj5SiSJIXGxwVcDhQcHD52Tj2a
         Dpm7cp/HRYm6MWqXxt9q/KugMh7gPk02HIMfysogmPrDXA3YvmSoIQXXXN4MLziHabck
         CPjh+MW+y5tMtMftqjtL2vjxr2AM14P44ze+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SbOJ0iDC7mjyjxIUXAPB+3RlnZNYqi363AzaXXN9ecM=;
        b=Q5nQAIYgbflU+8ivWDmlhd+YeZu7k7o1Dbhf70DaA/SM4fmT8qbxBT+JrBC2QYmkX7
         T86cDcmr+PgqXBmD7BwoYLfaD1xYo70kOEj/XrDNgi2VHUQSvEhKg9V1WViL87xDykYD
         HKSwB0e360oscO5Xnw0JzX1Q+fBRmwhaySevP8pX797lOzqBz006NAQ37Wxn8t2wgxHz
         UaJSTOXZrZ+jypqRPZDraeCiiDEZUMiqp0nFx+PKY5Xk5hFmRCl6ClnKRf/H1SWaYwW5
         ou8R1KnIQ2KPSXMthBjVl27p9ZZidQe7IlXuA4aT+OE52VbgFKRap7+H/RsWae7r7++o
         eh8Q==
X-Gm-Message-State: APzg51A9P7J4fN10JWDqbQGs0Mu9GsceYk/0yz3KzBO/r9ObD0AKxLhK
        3AVVRML757THbdPrEzas7lS+rg==
X-Google-Smtp-Source: ANB0VdZdwCzLOrVAJ09ARXljcwFLK8SC/wJPlaFRrwlvFL3osvvv2HQY/DslA/tim7uBKzSSueX6Ng==
X-Received: by 2002:a5d:6a0e:: with SMTP id m14-v6mr18576683wru.192.1535966551009;
        Mon, 03 Sep 2018 02:22:31 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o15-v6sm15005474wru.23.2018.09.03.02.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 02:22:30 -0700 (PDT)
Date:   Mon, 3 Sep 2018 10:22:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 15/34] ARM: tegra: apalis_t30: reorder backlight
 properties
Message-ID: <20180903092228.7k46uf6qehgou5wx@holly.lan>
References: <20180831163817.23970-1-marcel@ziswiler.com>
 <20180831163817.23970-16-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831163817.23970-16-marcel@ziswiler.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 06:37:57PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Reorder backlight properties.

This is a bit terse. Should the header explain why too?


> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2: None
> 
>  arch/arm/boot/dts/tegra30-apalis-eval.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
> index 9f2392a05532..300ce726ff4d 100644
> --- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
> +++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
> @@ -185,13 +185,12 @@
>  
>  	backlight: backlight {
>  		compatible = "pwm-backlight";
> -		/* PWM_BKL1 */
> -		pwms = <&pwm 0 5000000>;
>  		brightness-levels = <255 231 223 207 191 159 127 0>;
>  		default-brightness-level = <6>;
>  		/* BKL1_ON */
>  		enable-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
>  		power-supply = <&reg_3v3>;
> +		pwms = <&pwm 0 5000000>; /* BKL1_PWM */
>  	};
>  
>  	gpio-keys {
> -- 
> 2.14.4
> 
