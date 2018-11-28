Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5191C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1A1208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBUDTiVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1A1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeK1OAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeK1OAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:00:34 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7080920851;
        Wed, 28 Nov 2018 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543374033;
        bh=XCnTTLIGwnln8sQmY082ZvWo6a5oYxn6vUPhIaUeimM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBUDTiVo1dqMORd8Z69CWzPZsnFprEAb/cPBb+12UuFeutXTTIJZwMEebUTKRERRM
         JpXFXcMSATNCOZsGPPTFv1JlCwSIim+Rr8kpwVT4rllv15c1LUZYtMQjTgPRfdGFq0
         I2mNLi9s4bB7CneEjXzIFWnZ25fbnHoknW7I6pmA=
Date:   Wed, 28 Nov 2018 11:00:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: Add stmpe-adc driver to relevant
 devicetrees
Message-ID: <20181128030011.GG20643@dragon>
References: <20181119102528.2830-1-dev@pschenker.ch>
 <20181119102528.2830-4-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119102528.2830-4-dev@pschenker.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:25:28AM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Activate the stmpe-adc driver as found on Apalis/Colibri iMX6/T30 modules

iMX6 and T30 changes need to be separate patches.

Shawn

> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v2:
>  - Put common ADC settings in mfd
> 
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 23 +++++++++++++++--------
>  arch/arm/boot/dts/tegra30-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/tegra30-colibri.dtsi | 22 ++++++++++++++--------
>  4 files changed, 57 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 3dc99dd8dde1..8db476d8978d 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -331,11 +331,18 @@
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
> +		/* forbid to use ADC channels 3-0 (touch) */
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			/* 3.25 MHz ADC clock speed */
> -			st,adc-freq = <1>;
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
>  			/* 7 length fractional part in z */
> @@ -345,17 +352,16 @@
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
> +			st,norequest-mask = <0x0F>;
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index 87e15e7cb32b..2e303d79c7f8 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -262,11 +262,18 @@
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
> +		/* forbid to use ADC channels 3-0 (touch) */
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			/* 3.25 MHz ADC clock speed */
> -			st,adc-freq = <1>;
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
>  			/* 7 length fractional part in z */
> @@ -276,17 +283,17 @@
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
> +			/* 3.25 MHz ADC clock speed */
> +			st,norequest-mask = <0x0F>;
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
> index 7f112f192fe9..850b0d13549a 100644
> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
> @@ -976,11 +976,18 @@
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
> +			/* forbid to use ADC channels 3-0 (touch) */
>  
>  			stmpe_touchscreen {
>  				compatible = "st,stmpe-ts";
> -				/* 3.25 MHz ADC clock speed */
> -				st,adc-freq = <1>;
>  				/* 8 sample average control */
>  				st,ave-ctrl = <3>;
>  				/* 7 length fractional part in z */
> @@ -990,17 +997,16 @@
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
> +				st,norequest-mask = <0x0F>;
> +			};
>  		};
>  
>  		/*
> diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
> index 35af03ca9e90..1f9198bb24ff 100644
> --- a/arch/arm/boot/dts/tegra30-colibri.dtsi
> +++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
> @@ -845,11 +845,18 @@
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
> +			/* forbid to use ADC channels 3-0 (touch) */
>  
>  			stmpe_touchscreen {
>  				compatible = "st,stmpe-ts";
> -				/* 3.25 MHz ADC clock speed */
> -				st,adc-freq = <1>;
>  				/* 8 sample average control */
>  				st,ave-ctrl = <3>;
>  				/* 7 length fractional part in z */
> @@ -859,17 +866,16 @@
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
> +				st,norequest-mask = <0x0F>;
> +			};
>  		};
>  
>  		/*
> -- 
> 2.19.1
> 
