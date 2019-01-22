Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5383DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAD621721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="LPER5UJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfAVOxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:53:34 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57552 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbfAVOxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:53:33 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id AA5385C0072;
        Tue, 22 Jan 2019 15:53:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548168810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nytjyd97V7nibdyJjfrhGG/2AIH00/JlriYdguPAV0k=;
        b=LPER5UJ9+o9iBGvtBzI8MZs4uRP7lWt46+LJkd0UMOBYlqeecg7Ema68jaVflyy7CyV+Et
        293idn9DGDUbL8BFK9fv1nxtrgfsnB4pG0E6EG7fNkhyD3tNZ7gfwxtwfwItcNJKVEGL8H
        6QasopEa2gUzHCwx/ZVJmRnO+6MK+sY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Jan 2019 15:53:30 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, marcel.ziswiler@toradex.com,
        max.krummenacher@toradex.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] ARM: dts: Add stmpe-adc DT node to Toradex iMX6
 modules
In-Reply-To: <20190122132135.5012-2-dev@pschenker.ch>
References: <20190122132135.5012-1-dev@pschenker.ch>
 <20190122132135.5012-2-dev@pschenker.ch>
Message-ID: <959c74d19959e0cf2261df7f3deaf536@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.2019 14:21, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Add the stmpe-adc DT node as found on Toradex iMX6 modules
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

> ---
> 
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 22 ++++++++++++++--------
>  2 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 8380f1b26826..e8c7ef7e078a 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -332,11 +332,17 @@
>  		id = <0>;
>  		blocks = <0x5>;
>  		irq-trigger = <0x1>;
> +		/* 3.25 MHz ADC clock speed */
> +		st,adc-freq = <1>;
> +		/* 12-bit ADC */
> +		st,mod-12b = <1>;
> +		/* internal ADC reference */
> +		st,ref-sel = <0>;
> +		/* ADC converstion time: 80 clocks */
> +		st,sample-time = <4>;
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			/* 3.25 MHz ADC clock speed */
> -			st,adc-freq = <1>;
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
>  			/* 7 length fractional part in z */
> @@ -346,17 +352,17 @@
>  			 * current limit value
>  			 */
>  			st,i-drive = <1>;
> -			/* 12-bit ADC */
> -			st,mod-12b = <1>;
> -			/* internal ADC reference */
> -			st,ref-sel = <0>;
> -			/* ADC converstion time: 80 clocks */
> -			st,sample-time = <4>;
>  			/* 1 ms panel driver settling time */
>  			st,settling = <3>;
>  			/* 5 ms touch detect interrupt delay */
>  			st,touch-det-delay = <5>;
>  		};
> +
> +		stmpe_adc {
> +			compatible = "st,stmpe-adc";
> +			/* forbid to use ADC channels 3-0 (touch) */
> +			st,norequest-mask = <0x0F>;
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index 87e15e7cb32b..eb8603a2444e 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -262,11 +262,17 @@
>  		id = <0>;
>  		blocks = <0x5>;
>  		irq-trigger = <0x1>;
> +		/* 3.25 MHz ADC clock speed */
> +		st,adc-freq = <1>;
> +		/* 12-bit ADC */
> +		st,mod-12b = <1>;
> +		/* internal ADC reference */
> +		st,ref-sel = <0>;
> +		/* ADC converstion time: 80 clocks */
> +		st,sample-time = <4>;
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			/* 3.25 MHz ADC clock speed */
> -			st,adc-freq = <1>;
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
>  			/* 7 length fractional part in z */
> @@ -276,17 +282,17 @@
>  			 * current limit value
>  			 */
>  			st,i-drive = <1>;
> -			/* 12-bit ADC */
> -			st,mod-12b = <1>;
> -			/* internal ADC reference */
> -			st,ref-sel = <0>;
> -			/* ADC converstion time: 80 clocks */
> -			st,sample-time = <4>;
>  			/* 1 ms panel driver settling time */
>  			st,settling = <3>;
>  			/* 5 ms touch detect interrupt delay */
>  			st,touch-det-delay = <5>;
>  		};
> +
> +		stmpe_adc {
> +			compatible = "st,stmpe-adc";
> +			/* forbid to use ADC channels 3-0 (touch) */
> +			st,norequest-mask = <0x0F>;
> +		};
>  	};
>  };
