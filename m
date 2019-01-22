Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CED1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B18821019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="N8wAOKtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfAVOx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:53:57 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57582 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbfAVOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:53:56 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 94FC05C0072;
        Tue, 22 Jan 2019 15:53:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548168833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1z2bV6/Thu1aItV5gieud7p2JyjfefOn3QNcQrHKpXg=;
        b=N8wAOKtQapwQ13+w67WKMdap9XzOrlfNZLDp1KQwijxh3La2l7CUfVVxhPUadEtVnYN1pG
        ARPiVqIFKgLyw9OtW7VG32gkOSBEQsR7Cik+XkM75H+BpJh4GZ/Wqhth0KmqCyjh6FM+YT
        NhqyMJ54nr2Ta6lvfLkYvy/nCB3lpcQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Jan 2019 15:53:53 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, marcel.ziswiler@toradex.com,
        max.krummenacher@toradex.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] ARM: dts: Add stmpe-adc DT node to Toradex T30
 modules
In-Reply-To: <20190122132135.5012-3-dev@pschenker.ch>
References: <20190122132135.5012-1-dev@pschenker.ch>
 <20190122132135.5012-3-dev@pschenker.ch>
Message-ID: <34495b73d56dd3dcd7ef9df99d665fb4@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.2019 14:21, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Add the stmpe-adc DT node as found on Toradex T30 modules
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

> 
> ---
> 
>  arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi | 22 ++++++++++++++--------
>  arch/arm/boot/dts/tegra30-apalis.dtsi      | 22 ++++++++++++++--------
>  arch/arm/boot/dts/tegra30-colibri.dtsi     | 22 ++++++++++++++--------
>  3 files changed, 42 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
> b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
> index 02f8126481a2..8b7a827d604d 100644
> --- a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
> @@ -994,11 +994,17 @@
>  			id = <0>;
>  			blocks = <0x5>;
>  			irq-trigger = <0x1>;
> +			/* 3.25 MHz ADC clock speed */
> +			st,adc-freq = <1>;
> +			/* 12-bit ADC */
> +			st,mod-12b = <1>;
> +			/* internal ADC reference */
> +			st,ref-sel = <0>;
> +			/* ADC converstion time: 80 clocks */
> +			st,sample-time = <4>;
>  
>  			stmpe_touchscreen {
>  				compatible = "st,stmpe-ts";
> -				/* 3.25 MHz ADC clock speed */
> -				st,adc-freq = <1>;
>  				/* 8 sample average control */
>  				st,ave-ctrl = <3>;
>  				/* 7 length fractional part in z */
> @@ -1008,17 +1014,17 @@
>  				 * current limit value
>  				 */
>  				st,i-drive = <1>;
> -				/* 12-bit ADC */
> -				st,mod-12b = <1>;
> -				/* internal ADC reference */
> -				st,ref-sel = <0>;
> -				/* ADC converstion time: 80 clocks */
> -				st,sample-time = <4>;
>  				/* 1 ms panel driver settling time */
>  				st,settling = <3>;
>  				/* 5 ms touch detect interrupt delay */
>  				st,touch-det-delay = <5>;
>  			};
> +
> +			stmpe_adc {
> +				compatible = "st,stmpe-adc";
> +				/* forbid to use ADC channels 3-0 (touch) */
> +				st,norequest-mask = <0x0F>;
> +			};
>  		};
>  
>  		/*
> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi
> b/arch/arm/boot/dts/tegra30-apalis.dtsi
> index 7f112f192fe9..c18f6f61d764 100644
> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
> @@ -976,11 +976,17 @@
>  			id = <0>;
>  			blocks = <0x5>;
>  			irq-trigger = <0x1>;
> +			/* 3.25 MHz ADC clock speed */
> +			st,adc-freq = <1>;
> +			/* 12-bit ADC */
> +			st,mod-12b = <1>;
> +			/* internal ADC reference */
> +			st,ref-sel = <0>;
> +			/* ADC converstion time: 80 clocks */
> +			st,sample-time = <4>;
>  
>  			stmpe_touchscreen {
>  				compatible = "st,stmpe-ts";
> -				/* 3.25 MHz ADC clock speed */
> -				st,adc-freq = <1>;
>  				/* 8 sample average control */
>  				st,ave-ctrl = <3>;
>  				/* 7 length fractional part in z */
> @@ -990,17 +996,17 @@
>  				 * current limit value
>  				 */
>  				st,i-drive = <1>;
> -				/* 12-bit ADC */
> -				st,mod-12b = <1>;
> -				/* internal ADC reference */
> -				st,ref-sel = <0>;
> -				/* ADC converstion time: 80 clocks */
> -				st,sample-time = <4>;
>  				/* 1 ms panel driver settling time */
>  				st,settling = <3>;
>  				/* 5 ms touch detect interrupt delay */
>  				st,touch-det-delay = <5>;
>  			};
> +
> +			stmpe_adc {
> +				compatible = "st,stmpe-adc";
> +				/* forbid to use ADC channels 3-0 (touch) */
> +				st,norequest-mask = <0x0F>;
> +			};
>  		};
>  
>  		/*
> diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi
> b/arch/arm/boot/dts/tegra30-colibri.dtsi
> index 35af03ca9e90..3c421a5cfbc2 100644
> --- a/arch/arm/boot/dts/tegra30-colibri.dtsi
> +++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
> @@ -845,11 +845,17 @@
>  			id = <0>;
>  			blocks = <0x5>;
>  			irq-trigger = <0x1>;
> +			/* 3.25 MHz ADC clock speed */
> +			st,adc-freq = <1>;
> +			/* 12-bit ADC */
> +			st,mod-12b = <1>;
> +			/* internal ADC reference */
> +			st,ref-sel = <0>;
> +			/* ADC converstion time: 80 clocks */
> +			st,sample-time = <4>;
>  
>  			stmpe_touchscreen {
>  				compatible = "st,stmpe-ts";
> -				/* 3.25 MHz ADC clock speed */
> -				st,adc-freq = <1>;
>  				/* 8 sample average control */
>  				st,ave-ctrl = <3>;
>  				/* 7 length fractional part in z */
> @@ -859,17 +865,17 @@
>  				 * current limit value
>  				 */
>  				st,i-drive = <1>;
> -				/* 12-bit ADC */
> -				st,mod-12b = <1>;
> -				/* internal ADC reference */
> -				st,ref-sel = <0>;
> -				/* ADC converstion time: 80 clocks */
> -				st,sample-time = <4>;
>  				/* 1 ms panel driver settling time */
>  				st,settling = <3>;
>  				/* 5 ms touch detect interrupt delay */
>  				st,touch-det-delay = <5>;
>  			};
> +
> +			stmpe_adc {
> +				compatible = "st,stmpe-adc";
> +				/* forbid to use ADC channels 3-0 (touch) */
> +				st,norequest-mask = <0x0F>;
> +			};
>  		};
>  
>  		/*
