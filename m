Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbeDAVbt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 17:31:49 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35513 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbeDAVbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 17:31:47 -0400
X-Google-Smtp-Source: AIpwx488Ags+rpUB6kh3tp1GQZVXy6264D5bEvxCCRgcO2QIR/UaVamTskZ3ly6ZsROIU5NAomzh1g==
Date: Sun, 1 Apr 2018 14:32:10 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: qcom-apq8064: disable i2c by default at soc
 dtsi
Message-ID: <20180401213210.GE510@tuxbook-pro>
References: <20180315144434.14095-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315144434.14095-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15 Mar 07:44 PDT 2018, Srinivas Kandagatla wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch marks all the gsbi i2c node at soc level dtsi, so that kernel
> would not assume that its enabled and result in pin conflicts when gsbi
> is used for UART or SPI.
> 
> Without this patch we see below pin conflict.
> 
> apq8064-pinctrl 800000.pinctrl: pin GPIO_20 already requested by
>  12450000.serial; cannot claim for 12460000.i2c
> apq8064-pinctrl 800000.pinctrl: pin-20 (12460000.i2c) status -22
> apq8064-pinctrl 800000.pinctrl: could not request pin 20 (GPIO_20)
>  from group gpio20  on device 800000.pinctrl
> i2c_qup 12460000.i2c: Error applying setting, reverse things back
> i2c_qup: probe of 12460000.i2c failed with error -22
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 3ca96e361878..54cff79f5725 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -444,6 +444,7 @@
>  				clock-names = "core", "iface";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				status = "disabled";
>  			};
>  
>  		};
> @@ -472,6 +473,7 @@
>  				clock-names = "core", "iface";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				status = "disabled";
>  			};
>  		};
>  
> @@ -497,6 +499,7 @@
>  				clock-names = "core", "iface";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				status = "disabled";
>  			};
>  		};
>  
> @@ -521,6 +524,7 @@
>  				clocks = <&gcc GSBI4_QUP_CLK>,
>  					 <&gcc GSBI4_H_CLK>;
>  				clock-names = "core", "iface";
> +				status = "disabled";
>  			};
>  		};
>  
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
