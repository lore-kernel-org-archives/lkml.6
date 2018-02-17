Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeBQVIl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 16:08:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:54665 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751253AbeBQVIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 16:08:39 -0500
Subject: Re: [PATCH 06/10] arm64: dts: actions: Add S900 gpio nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-7-manivannan.sadhasivam@linaro.org>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <fb5f904e-a262-df5b-a947-957e579ec4c9@suse.de>
Date: Sat, 17 Feb 2018 22:08:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180217204433.3095-7-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.02.2018 um 21:44 schrieb Manivannan Sadhasivam:
> Add gpio nodes for Actions Semi S900 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/actions/s900.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
> index 0156483f0f4d..e359509ad9d3 100644
> --- a/arch/arm64/boot/dts/actions/s900.dtsi
> +++ b/arch/arm64/boot/dts/actions/s900.dtsi
> @@ -180,6 +180,13 @@
>  			clocks = <&cmu CLK_GPIO>;
>  		};
>  
> +		gpio: gpio@e01b0000 {
> +			compatible = "actions,s900-gpio";
> +			reg = <0x0 0xe01b0000 0x0 0x1000>;
> +			gpio-controller;

Same as the bindings example, this is lacking gpio-ranges.

https://github.com/afaerber/linux/commit/f4526bbacd75d014a69e6e3ff051638589ee71a3

Also why have only one node? That forces the information about GPIO
banks into the driver rather than into the DT.

> +			#gpio-cells = <2>;
> +		};
> +
>  		timer: timer@e0228000 {
>  			compatible = "actions,s900-timer";
>  			reg = <0x0 0xe0228000 0x0 0x8000>;

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
