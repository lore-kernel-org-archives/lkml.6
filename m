Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53545C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1853720843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1853720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeICOXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:23:19 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:12134 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbeICOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:23:19 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w839xPSA007496;
        Mon, 3 Sep 2018 12:03:46 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2m7ghthr7k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Sep 2018 12:03:46 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95E0431;
        Mon,  3 Sep 2018 10:03:44 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7405B29D5;
        Mon,  3 Sep 2018 10:03:44 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Sep
 2018 12:03:43 +0200
Subject: Re: [PATCH] ARM: dts: stm32: enable display on stm32mp157c-ev1 board
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
References: <1534856316-30346-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <2369d88e-b5d4-dfb2-ef1a-7d8d194b8e45@st.com>
Date:   Mon, 3 Sep 2018 12:03:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1534856316-30346-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-03_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick,

On 08/21/2018 02:58 PM, Yannick Fertré wrote:
> Enable panel raydium RM68200, DSI bridge & display controller.
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-ev1.dts | 60 +++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> index 372bc2e..cd9062a 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> @@ -6,6 +6,7 @@
>   /dts-v1/;
>   
>   #include "stm32mp157c-ed1.dts"
> +#include <dt-bindings/gpio/gpio.h>
>   
>   / {
>   	model = "STMicroelectronics STM32MP157C eval daughter on eval mother";
> @@ -19,6 +20,12 @@
>   		serial0 = &uart4;
>   		ethernet0 = &ethernet0;
>   	};
> +	panel_backlight: panel-backlight {
> +		compatible = "gpio-backlight";
> +		gpios = <&gpiod 13 GPIO_ACTIVE_LOW>;
> +		default-on;
> +		status = "okay";
> +	};
>   };
>   
>   &ethernet0 {
> @@ -46,6 +53,45 @@
>   	status = "okay";
>   };
>   
> +&dsi {

Can you check ordering please ?

> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			dsi_in: endpoint {
> +				remote-endpoint = <&ltdc_ep0_out>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			dsi_out: endpoint {
> +				remote-endpoint = <&dsi_panel_in>;
> +			};
> +		};
> +	};
> +
> +	panel-dsi@0 {
> +		compatible = "raydium,rm68200";
> +		reg = <0>;
> +		reset-gpios = <&gpiof 15 GPIO_ACTIVE_LOW>;
> +		backlight = <&panel_backlight>;
> +		status = "okay";
> +
> +		port {
> +			dsi_panel_in: endpoint {
> +				remote-endpoint = <&dsi_out>;
> +			};
> +		};
> +	};
> +};
> +
>   &i2c2 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c2_pins_a>;
> @@ -62,6 +108,20 @@
>   	status = "okay";
>   };
>   
> +&ltdc {
> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ltdc_ep0_out: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&dsi_in>;
> +		};
> +	};
> +};
> +
>   &m_can1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&m_can1_pins_a>;
> 
