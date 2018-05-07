Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeEGRXZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbeEGRXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:23:23 -0400
Date: Mon, 7 May 2018 18:23:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: stm32: Add ADC support to stm32mp157c
Message-ID: <20180507182317.7406c682@archlinux>
In-Reply-To: <1525247091-18143-4-git-send-email-fabrice.gasnier@st.com>
References: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
        <1525247091-18143-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018 09:44:51 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> stm32mp157c has an ADC block with two physical ADCs.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
The driver support is now queued up in the IIO tree and should
be in Linux next later this week.

Thanks,

Jonathan

> ---
>  arch/arm/boot/dts/stm32mp157c.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index bc3eddc..7758a90 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -160,6 +160,38 @@
>  			status = "disabled";
>  		};
>  
> +		adc: adc@48003000 {
> +			compatible = "st,stm32mp1-adc-core";
> +			reg = <0x48003000 0x400>;
> +			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&rcc ADC12>, <&rcc ADC12_K>;
> +			clock-names = "bus", "adc";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			adc1: adc@0 {
> +				compatible = "st,stm32mp1-adc";
> +				#io-channel-cells = <1>;
> +				reg = <0x0>;
> +				interrupt-parent = <&adc>;
> +				interrupts = <0>;
> +				status = "disabled";
> +			};
> +
> +			adc2: adc@100 {
> +				compatible = "st,stm32mp1-adc";
> +				#io-channel-cells = <1>;
> +				reg = <0x100>;
> +				interrupt-parent = <&adc>;
> +				interrupts = <1>;
> +				status = "disabled";
> +			};
> +		};
> +
>  		rcc: rcc@50000000 {
>  			compatible = "st,stm32mp1-rcc", "syscon";
>  			reg = <0x50000000 0x1000>;
