Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753983AbeC0RtG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:49:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42703 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753850AbeC0RtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:49:03 -0400
X-Google-Smtp-Source: AIpwx48XeaDMKvhtVC43CjH/OcVwBB4rsJPC3MmcHnb6zZkD0HHQ3CEu9lyuaIIji2ZvKzBnr89AMQ==
Date: Tue, 27 Mar 2018 10:49:13 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com,
        richardcochran@gmail.com
Subject: Re: [PATCH v5 13/13] ARM: dts: ipq8074: Enable few peripherals for
 hk01 board
Message-ID: <20180327174913.GP1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-14-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521800336-19266-14-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:

> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/ipq8074-hk01.dts | 103 ++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
> index 6a838b5..dbca7ec 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
> @@ -21,6 +21,7 @@
>  
>  	aliases {
>  		serial0 = &blsp1_uart5;
> +		serial1 = &serial_blsp2;
>  	};
>  
>  	chosen {
> @@ -41,6 +42,47 @@
>  					bias-disable;
>  				};
>  			};
> +
> +			 i2c_0_pins: i2c_0_pinmux {
> +				  mux {
> +					   pins = "gpio42", "gpio43";
> +					   function = "blsp1_i2c";
> +					   drive-strength = <8>;
> +					   bias-disable;
> +				  };
> +			 };
> +
> +			 spi_0_pins: spi_0_pins {
> +				  mux {
> +					   pins = "gpio38", "gpio39", "gpio40", "gpio41";
> +					   function = "blsp0_spi";
> +					   drive-strength = <8>;
> +					   bias-disable;
> +				  };
> +			 };
> +
> +			 hsuart_pins: hsuart_pins {
> +				  mux {
> +					   pins = "gpio46", "gpio47", "gpio48", "gpio49";
> +					   function = "blsp2_uart";
> +					   drive-strength = <8>;
> +					   bias-disable;
> +				  };
> +			 };
> +
> +			 qpic_pins: qpic_pins {
> +				mux {
> +					   pins = "gpio1", "gpio3", "gpio4",
> +						  "gpio5", "gpio6", "gpio7",
> +						  "gpio8", "gpio10", "gpio11",
> +						  "gpio12", "gpio13", "gpio14",
> +						  "gpio15", "gpio16", "gpio17";
> +					   function = "qpic";

I would prefer that you move the pinmux part to the same dtsi that
defines the nand and add the board specific pinconf (electrical
properties) here. That way we limit the repetition between the board
files.

> +					   drive-strength = <8>;
> +					   bias-disable;
> +				  };
> +			};
> +
>  		};
>  

Other than that,

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
