Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968171AbeEYTbK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:31:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37543 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967926AbeEYTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:31:08 -0400
X-Google-Smtp-Source: AB8JxZrgVPPMkEbDYdgUpy/N8w/y6bR8LNaHbWwTPu7zxgXglyScLSWruSr1W38o2cBlorAm9xWv3Q==
Date: Fri, 25 May 2018 12:32:47 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: apq8096-db820c: Removed bt-en-1-8v
 regulator
Message-ID: <20180525193247.GZ2259@tuxbook-pro>
References: <20180524180155.24839-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524180155.24839-1-thierry.escande@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 May 11:01 PDT 2018, Thierry Escande wrote:

> This patch removes the unused bt-en-1-8v regulator and moves the
> bt_en_gios claim to the pm8994_gpios node.
> 
> This bt_en_gpio could have been moved to the bluetooth serial node but
> instead this node declares an 'enable' gpio addressing the bt_en_gpio.
> This is needed by the Qualcomm QCA6174 WLAN/BT combo chip that needs to
> have the bt_en_gpio claimed even if only WLAN is used.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Change in v2:
> - Rebased on top of [1] posted a few days ago:
> 
> [1] https://lkml.org/lkml/2018/5/22/949
>     "arm64: dts: fix regulator property name for wlan pcie endpoint"
>     
> 
>  arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi |  2 +-
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi           | 14 --------------
>  2 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
> index 6167af955659..a6ad3d7fe655 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
> @@ -4,7 +4,7 @@
>  &pm8994_gpios {
>  
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&ls_exp_gpio_f>;
> +	pinctrl-0 = <&ls_exp_gpio_f &bt_en_gpios>;
>  
>  	ls_exp_gpio_f: pm8994_gpio5 {
>  		pinconf {
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> index 7ca6e78def55..2c026b8af792 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> @@ -171,19 +171,6 @@
>  			pinctrl-0 = <&usb2_vbus_det_gpio>;
>  		};
>  
> -		bt_en: bt-en-1-8v {
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&bt_en_gpios>;
> -			compatible = "regulator-fixed";
> -			regulator-name = "bt-en-regulator";
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> -
> -			/* WLAN card specific delay */
> -			startup-delay-us = <70000>;
> -			enable-active-high;
> -		};
> -
>  		wlan_en: wlan-en-1-8v {
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&wlan_en_gpios>;
> @@ -204,7 +191,6 @@
>  				status = "okay";
>  				perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
>  				vddpe-3v3-supply = <&wlan_en>;
> -				vddpe1-supply = <&bt_en>;
>  			};
>  
>  			pcie@608000 {
> -- 
> 2.14.1
> 
