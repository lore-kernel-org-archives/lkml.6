Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B653C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197A22683C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197A22683C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934363AbeFZJwJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:52:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54619 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933250AbeFZJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:52:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5Q9nVbV018950;
        Tue, 26 Jun 2018 11:51:36 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2juhf48kvg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Jun 2018 11:51:36 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C418B3D;
        Tue, 26 Jun 2018 09:51:34 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9592824FD;
        Tue, 26 Jun 2018 09:51:34 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Jun
 2018 11:51:33 +0200
Subject: Re: [PATCH v3] ARM: dts: stm32: Add ADC support to stm32mp157c
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1527003937-15999-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <3b44dd54-087c-e10f-4bf5-3728e735ee0c@st.com>
Date:   Tue, 26 Jun 2018 11:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527003937-15999-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 05/22/2018 05:45 PM, Fabrice Gasnier wrote:
> stm32mp157c has an ADC block with two physical ADCs.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v3:
> - Add dmas since dmamux1 has been added on top of stm32-next
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index b66f673..66d7496 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi


Applied on stm32-next.

Thanks.
Alex


> @@ -600,6 +600,42 @@
>   			clocks = <&rcc DMAMUX>;
>   		};
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
> +				dmas = <&dmamux1 9 0x400 0x01>;
> +				dma-names = "rx";
> +				status = "disabled";
> +			};
> +
> +			adc2: adc@100 {
> +				compatible = "st,stm32mp1-adc";
> +				#io-channel-cells = <1>;
> +				reg = <0x100>;
> +				interrupt-parent = <&adc>;
> +				interrupts = <1>;
> +				dmas = <&dmamux1 10 0x400 0x01>;
> +				dma-names = "rx";
> +				status = "disabled";
> +			};
> +		};
> +
>   		rcc: rcc@50000000 {
>   			compatible = "st,stm32mp1-rcc", "syscon";
>   			reg = <0x50000000 0x1000>;
> 
