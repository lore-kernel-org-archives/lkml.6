Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF42C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D538206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRcCTYdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D538206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeHRUSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 16:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbeHRUSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 16:18:01 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 505862124D;
        Sat, 18 Aug 2018 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534612177;
        bh=Ps8SThuPCLt8zE96VmSoOjS9AV4dUHaq83OVI+RdGMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tRcCTYdE4jpjaR3RHEPIW56W/MW/OGgWl0/mGz8tj0Y6mEFNn4KXkmWv4P1fsJLhh
         RunpG+uyQP7AJyvaWfzmNN8E4JRZxQqI+FKlpvtWHSoJzmLYUJcApykKrQSdCNy/87
         6O4S4Pw31k/pTT49pvMdbL3vGH7I8zCvfo6Wrj3k=
Date:   Sat, 18 Aug 2018 18:09:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 9/9] ARM: dts: qcom: msm8974-hammerhead: add device
 tree bindings for ALS / proximity
Message-ID: <20180818180931.77165945@archlinux>
In-Reply-To: <20180803001900.25371-10-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
        <20180803001900.25371-10-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 20:19:00 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch adds device tree bindings for the tsl2772 ALS / proximity
> sensor for the LG Nexus 5 (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

The precursors are working their way through the iio tree, but
it will be the next merge window before they go upstream.

Thanks,

Jonathan

> ---
>  .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 27 +++++++++++++++++++
>  arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> index 928affae1885..ed8f064d0895 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> @@ -242,6 +242,15 @@
>  			};
>  		};
>  
> +		i2c3_pins: i2c3 {
> +			mux {
> +				pins = "gpio10", "gpio11";
> +				function = "blsp_i2c3";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +		};
> +
>  		i2c12_pins: i2c12 {
>  			mux {
>  				pins = "gpio87", "gpio88";
> @@ -333,6 +342,24 @@
>  			};
>  		};
>  	};
> +
> +	i2c@f9925000 {
> +		status = "ok";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c3_pins>;
> +		clock-frequency = <100000>;
> +		qcom,src-freq = <50000000>;
> +
> +		avago_apds993@39 {
> +			compatible = "avago,apds9930";
> +			reg = <0x39>;
> +			interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
> +			vdd-supply = <&pm8941_l17>;
> +			vddio-supply = <&pm8941_lvs1>;
> +			led-max-microamp = <100000>;
> +			amstaos,proximity-diodes = <0>;
> +		};
> +	};
>  };
>  
>  &spmi_bus {
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index cebb6ae9143a..6dcf2bee66fb 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -713,6 +713,17 @@
>  			#size-cells = <0>;
>  		};
>  
> +		blsp_i2c3: i2c@f9925000 {
> +			status = "disabled";
> +			compatible = "qcom,i2c-qup-v2.1.1";
> +			reg = <0xf9925000 0x1000>;
> +			interrupts = <0 97 IRQ_TYPE_NONE>;
> +			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>  		blsp_i2c8: i2c@f9964000 {
>  			status = "disabled";
>  			compatible = "qcom,i2c-qup-v2.1.1";

