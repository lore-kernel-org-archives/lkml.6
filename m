Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB018C4646D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714C1217AF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oah4qOMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714C1217AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbeHCXok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729828AbeHCXok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:44:40 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6148D217AA;
        Fri,  3 Aug 2018 21:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533332794;
        bh=w0Bi++YE8Yo383mVz0KRJ0fRrI0IPoHerDLYVt1j3/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oah4qOMSz/K/l3H74aoIbQh62cUcT62rK2tJFVrjvmD2mww6bT9arlHr1aRnQQelJ
         0HsqwkS8tZf0nUrSqElF84AWy/xyP0WobXY7A++dmmYp7OvhPihCr+f2lP/bWwl4JH
         +/ZJmGzw4rbyaPJ9NEaF7BDb0bfPq7uM+Qk0tcYs=
Date:   Fri, 3 Aug 2018 22:46:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 2/9] ARM: dts: qcom: msm8974-hammerhead: add device
 tree bindings for mpu6515
Message-ID: <20180803224627.3c5d8072@archlinux>
In-Reply-To: <20180803001900.25371-3-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
        <20180803001900.25371-3-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 20:18:53 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch adds device tree bindings for the mpu6515 to the LG Nexus 5
> (hammerhead) phone. Confirmed that the gyroscope / accelerometer
> (mpu6515), magnetometer (ak8963), and temperature / pressure (bmp280)
> sensors are available on the phone.
> 
> Interrupts are not working properly on the ak8963 magnetometer so they
> are currently not configured.
> 
> The bmp280 retuns temperature/pressure measurement skipped errors but
> will reliably work if I run:
> 
>     echo 1 > in_pressure_oversampling_ratio
>     echo 1 > in_temp_oversampling_ratio
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
I've queued up the regulator patch for IIO but it won't make the coming
merge window.  There is no dependence between this and that patch, but
I would assume the hardware won't work until both are present.

Jonathan

> ---
> I'll send follow up patch(es) once I investigate why the skipped errors
> are occurring with the bmp280 with the default oversampling ratios.
> 
>  .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 56 +++++++++++++++++++
>  arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> index c2dc9d09484a..928affae1885 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> @@ -241,6 +241,24 @@
>  				bias-pull-up;
>  			};
>  		};
> +
> +		i2c12_pins: i2c12 {
> +			mux {
> +				pins = "gpio87", "gpio88";
> +				function = "blsp_i2c12";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +		};
> +
> +		mpu6515_pin: mpu6515 {
> +			irq {
> +				pins = "gpio73";
> +				function = "gpio";
> +				bias-disable;
> +				input-enable;
> +			};
> +		};
>  	};
>  
>  	sdhci@f9824900 {
> @@ -277,6 +295,44 @@
>  			linux,code = <KEY_VOLUMEDOWN>;
>  		};
>  	};
> +
> +	i2c@f9968000 {
> +		status = "ok";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c12_pins>;
> +		clock-frequency = <100000>;
> +		qcom,src-freq = <50000000>;
> +
> +		mpu6515@68 {
> +			compatible = "invensense,mpu6515";
> +			reg = <0x68>;
> +			interrupts-extended = <&msmgpio 73 IRQ_TYPE_EDGE_FALLING>;
> +			vddio-supply = <&pm8941_lvs1>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mpu6515_pin>;
> +
> +			i2c-gate {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				ak8963@f {
> +					compatible = "asahi-kasei,ak8963";
> +					reg = <0x0f>;
> +					// Currently only works in polling mode.
> +					// gpios = <&msmgpio 61 0>;
> +					vid-supply = <&pm8941_lvs1>;
> +					vdd-supply = <&pm8941_l17>;
> +				};
> +
> +				bmp280@76 {
> +					compatible = "bosch,bmp280";
> +					reg = <0x76>;
> +					vdda-supply = <&pm8941_lvs1>;
> +					vddd-supply = <&pm8941_l17>;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &spmi_bus {
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index d9019a49b292..cebb6ae9143a 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -737,6 +737,17 @@
>  			dma-names = "tx", "rx";
>  		};
>  
> +		blsp_i2c12: i2c@f9968000 {
> +			status = "disabled";
> +			compatible = "qcom,i2c-qup-v2.1.1";
> +			reg = <0xf9968000 0x1000>;
> +			interrupts = <0 106 IRQ_TYPE_NONE>;
> +			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>  		spmi_bus: spmi@fc4cf000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg-names = "core", "intr", "cnfg";

