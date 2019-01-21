Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2268C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C41120861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfAUInt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:43:49 -0500
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:10718 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728933AbfAUIns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:43:48 -0500
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1glVBG-0005L3-Hg; Mon, 21 Jan 2019 09:43:42 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1glVBG-0006Iv-Cx; Mon, 21 Jan 2019 09:43:42 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
Message-ID: <cf6bf50028fd17a623f93d8d6114af3e9b54c610.camel@pschenker.ch>
Subject: Re: [PATCH] ARM: dts: imx6*-apalis/-colibri: mark I2C recovery
 GPIOs as open drain
From:   Philippe Schenker <dev@pschenker.ch>
Reply-To: dev@pschenker.ch
To:     Stefan Agner <stefan@agner.ch>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
        kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Jan 2019 09:43:41 +0100
In-Reply-To: <20190118133113.19484-1-stefan@agner.ch>
References: <20190118133113.19484-1-stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 14:31 +0100, Stefan Agner wrote:
> Since commit d2d0ad2aec4a ("i2c: imx: use open drain for recovery
> GPIO") GPIO lib expects this GPIO to be configured as open drain.
> Make sure we define this GPIO as open drain in the device tree.
> This gets rid of the following warning:
>   gpio-81 (scl): enforced open drain please flag it properly in DT/ACPI
> DSDT/board file
> 
> Note that currently the i.MX pinctrl driver does not support
> enabling open drain directly, so this patch has no effect in
> practice. Open drain is enabled by the fixed pinmux entry.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>

> ---
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 4 ++--
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 4 ++--
>  arch/arm/boot/dts/imx6ull-colibri.dtsi | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index cf66f9ececbd..2d0ed199ed20 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -429,8 +429,8 @@
>  	pinctrl-names = "default", "recovery";
>  	pinctrl-0 = <&pinctrl_i2c3>;
>  	pinctrl-1 = <&pinctrl_i2c3_recovery>;
> -	scl-gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio3 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio3 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "disabled";
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index 87e15e7cb32b..8a27c2a05678 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -298,8 +298,8 @@
>  	pinctrl-names = "default", "recovery";
>  	pinctrl-0 = <&pinctrl_i2c3>;
>  	pinctrl-1 = <&pinctrl_i2c3_recovery>;
> -	scl-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "disabled";
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> index 6c63a7384611..9ad1da159768 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> @@ -94,16 +94,16 @@
>  	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c1>;
>  	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	sda-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
> -	scl-gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
> +	sda-gpios = <&gpio1 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	scl-gpios = <&gpio1 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  };
>  
>  &i2c2 {
>  	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c2>;
>  	pinctrl-1 = <&pinctrl_i2c2_gpio>;
> -	sda-gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
> -	scl-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
> +	sda-gpios = <&gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	scl-gpios = <&gpio1 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "okay";
>  
>  	ad7879@2c {

