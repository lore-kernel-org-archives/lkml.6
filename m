Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeBSIfK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:35:10 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58242 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751760AbeBSIfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:35:08 -0500
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ARM: dts: stm32: add USB OTG HS support for STM32H743
 SoC
Thread-Topic: [PATCH 1/3] ARM: dts: stm32: add USB OTG HS support for
 STM32H743 SoC
Thread-Index: AQHTpnaHXkI5tv+3xkuqd9/t+jJfJKOrWzgA
Date: Mon, 19 Feb 2018 08:34:28 +0000
Message-ID: <30e056af-7de7-64b4-0383-8639f5f1b962@st.com>
References: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
 <1518710604-21632-2-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1518710604-21632-2-git-send-email-amelie.delaunay@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A87B5D59591A14DBB92ADCA239F01A3@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1J8ZFTT006187



On 02/15/2018 05:03 PM, Amelie Delaunay wrote:
> This patch adds support for USB OTG HS on STM32H743 SoC.
> USB OTG HS controller is the same than the one used on STM32F7 SoCs.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>   arch/arm/boot/dts/stm32h743.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 38d7cb8..65d4509 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -217,6 +217,18 @@
>   			};
>   		};
>   
> +		usbotg_hs: usb@40040000 {
> +			compatible = "st,stm32f7xx-hsotg";
Need to change the compatible and use the updated one [1]. I send a v2.

[1] https://patchwork.kernel.org/patch/10222153/
> +			reg = <0x40040000 0x40000>;
> +			interrupts = <77>;
> +			clocks = <&rcc USB1OTG_CK>;
> +			clock-names = "otg";
> +			g-rx-fifo-size = <256>;
> +			g-np-tx-fifo-size = <32>;
> +			g-tx-fifo-size = <128 128 64 64 64 64 32 32>;
> +			status = "disabled";
> +		};
> +
>   		mdma1: dma@52000000 {
>   			compatible = "st,stm32h7-mdma";
>   			reg = <0x52000000 0x1000>;
> 
