Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753557AbeCPK53 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:57:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeCPK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:57:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Mar 2018 16:27:25 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v2 13/13] ARM: dts: ipq8074: Enable few peripherals for
 hk01 board
In-Reply-To: <1521193101-4586-14-git-send-email-sricharan@codeaurora.org>
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-14-git-send-email-sricharan@codeaurora.org>
Message-ID: <7284d03a864202fd0baaeeea093068ee@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-16 15:08, Sricharan R wrote:
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/ipq8074-hk01.dts | 103 
> ++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
> b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
> index 6a838b5..81dff867 100644
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
> +					   drive-strength = <8>;
> +					   bias-disable;
> +				  };
> +			};
> +
>  		};
> 
>  		serial@78b3000 {
> @@ -48,5 +90,66 @@
>  			pinctrl-names = "default";
>  			status = "ok";
>  		};
> +
> +		spi@78b5000 {
> +			 pinctrl-0 = <&spi_0_pins>;
> +			 pinctrl-names = "default";
> +			 status = "ok";
> +
> +			 m25p80@0 {
> +				  #address-cells = <1>;
> +				  #size-cells = <1>;
> +				  compatible = "n25q128a11", "jedec,spi-nor";
> +				  reg = <0>;
> +				  spi-max-frequency = <50000000>;
> +			 };
> +		};
> +
> +		serial@78B1000 {

  s/78B1000/78b1000

  With that,
  Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>

> +			 pinctrl-0 = <&hsuart_pins>;
> +			 pinctrl-names = "default";
> +			 status = "ok";
> +		};
> +
> +		i2c_0@78b6000 {
> +			 pinctrl-0 = <&i2c_0_pins>;
> +			 pinctrl-names = "default";
> +			 status = "ok";
> +		};
> +
> +		dma@7984000 {
> +			 status = "ok";
> +		};
> +
> +		nand@79b0000 {
> +			pinctrl-0 = <&qpic_pins>;
> +			pinctrl-names = "default";
> +			status = "ok";
> +
> +			nand@0 {
> +				reg = <0>;
> +				nand-ecc-strength = <4>;
> +				nand-ecc-step-size = <512>;
> +				nand-bus-width = <8>;
> +			};
> +		};
> +
> +		phy@86000 {
> +			status = "ok";
> +		};
> +
> +		phy@8e000 {
> +			status = "ok";
> +		};
> +
> +		pci@20000000 {
> +			status = "ok";
> +			perst-gpio = <&tlmm 58 0x1>;
> +		};
> +
> +		pci@10000000 {
> +			status = "ok";
> +			perst-gpio = <&tlmm 61 0x1>;
> +		};
>  	};
>  };
