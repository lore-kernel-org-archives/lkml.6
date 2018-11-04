Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD75C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 08:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0F420854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 08:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYBGZYhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0F420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbeKDRj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 12:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbeKDRj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 12:39:59 -0500
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22BA12081C;
        Sun,  4 Nov 2018 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541319951;
        bh=o5lmYLHza7zgY8OuolXXIYHYppJRT8gDEh9i6p/w2DI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYBGZYhVFbEjEUH93ltsDqLtU8YbvydvWQwv6VdnEr4rh3IG7XASok7JfVnA6s2oI
         UEhrytY0/uVIyscAoyvFwpoVgKjymLtXHeUuZ1i4F8JFB1McXfhockCjslTyQYeyDg
         p3al/BVvdtqaZjNxoj23P59T7eqknlEAXQtY7umI=
Date:   Sun, 4 Nov 2018 16:25:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V1] ARM: dts: sabreauto: Remove reg property from fixed
 regulator
Message-ID: <20181104082533.GD26016@tiger>
References: <20181024102255.25640-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024102255.25640-1-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 10:25:12AM +0000, Joakim Zhang wrote:
> Remove reg property from fixed regulator as upstream has no longer
> needed this property.

Prefix 'ARM: dts: imx6qdl-sabreauto: ...' should be more accurate.  And
the 'reg' property was there only because we have a fake bus container
node 'regulators'.

I applied the patch after updating the prefix and rewording the commit
log a little bit.

Shawn

> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 53 ++++++++++--------------
>  1 file changed, 22 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index a6dc5c42c632..a10f0ad0bfb1 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -75,39 +75,30 @@
>  		};
>  	};
>  
> -	regulators {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> +	reg_audio: regulator-audio {
> +		compatible = "regulator-fixed";
> +		regulator-name = "cs42888_supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
>  
> -		reg_audio: regulator@0 {
> -			compatible = "regulator-fixed";
> -			reg = <0>;
> -			regulator-name = "cs42888_supply";
> -			regulator-min-microvolt = <3300000>;
> -			regulator-max-microvolt = <3300000>;
> -			regulator-always-on;
> -		};
> +	reg_usb_h1_vbus: regulator-usb-h1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_h1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&max7310_b 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
>  
> -		reg_usb_h1_vbus: regulator@1 {
> -			compatible = "regulator-fixed";
> -			reg = <1>;
> -			regulator-name = "usb_h1_vbus";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			gpio = <&max7310_b 7 GPIO_ACTIVE_HIGH>;
> -			enable-active-high;
> -		};
> -
> -		reg_usb_otg_vbus: regulator@2 {
> -			compatible = "regulator-fixed";
> -			reg = <2>;
> -			regulator-name = "usb_otg_vbus";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			gpio = <&max7310_c 1 GPIO_ACTIVE_HIGH>;
> -			enable-active-high;
> -		};
> +	reg_usb_otg_vbus: regulator-usb-otg-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&max7310_c 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
>  	};
>  
>  	sound-cs42888 {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
