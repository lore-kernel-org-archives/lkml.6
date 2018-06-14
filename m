Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 53B5EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1406E208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1406E208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755135AbeFNLsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:48:02 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61922 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755084AbeFNLsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:48:00 -0400
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="13058429"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jun 2018 04:47:55 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Thu, 14 Jun 2018
 04:47:53 -0700
Subject: Re: [PATCH 2/4] arm: dts: add support for Laird WB50N cpu module and
 DVK
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ben Whitten <ben.whitten@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
 <1528966340-23216-2-git-send-email-ben.whitten@lairdtech.com>
 <20180614095041.GW10521@piout.net>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <6f434031-19b9-bd3f-1e9f-e1b862a50d40@microchip.com>
Date:   Thu, 14 Jun 2018 13:47:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180614095041.GW10521@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2018 at 11:50, Alexandre Belloni wrote:
> On 14/06/2018 09:51:55+0100, Ben Whitten wrote:
>> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
>> ---
>>   arch/arm/boot/dts/Makefile        |   3 +-
>>   arch/arm/boot/dts/at91-wb50n.dts  | 116 ++++++++++++++++++++++
>>   arch/arm/boot/dts/at91-wb50n.dtsi | 202 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 320 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/boot/dts/at91-wb50n.dts
>>   create mode 100644 arch/arm/boot/dts/at91-wb50n.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 1ee94ee..fd5f8a6 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -61,7 +61,8 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>>   	at91-sama5d4_ma5d4evk.dtb \
>>   	at91-sama5d4_xplained.dtb \
>>   	at91-sama5d4ek.dtb \
>> -	at91-vinco.dtb
>> +	at91-vinco.dtb \
>> +	at91-wb50n.dtb
> 
> I know we have been bad at this but this should be
> at91-<soc>-<board>.dtb so at91-sama5d31-wb50n.dtb

See new message by Alexandre.

Actually, the current convention is explained here:
https://elixir.bootlin.com/linux/latest/source/Documentation/arm/Microchip/README#L159

>>   dtb-$(CONFIG_ARCH_ATLAS6) += \
>>   	atlas6-evb.dtb
>>   dtb-$(CONFIG_ARCH_ATLAS7) += \
>> diff --git a/arch/arm/boot/dts/at91-wb50n.dts b/arch/arm/boot/dts/at91-wb50n.dts
>> new file mode 100644
>> index 0000000..ee4f823
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/at91-wb50n.dts
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * at91-wb50n.dts - Device Tree file for wb50n evaluation board
>> + *
>> + *  Copyright (C) 2018 Laird
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +#include "at91-wb50n.dtsi"
>> +
>> +/ {
>> +	model = "Laird Workgroup Bridge 50N - Atmel SAMA5D";
>> +	compatible = "laird,wb50n", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
>> +
>> +	ahb {
>> +		apb {
>> +			watchdog@fffffe40 {
> 
> I don't mind if you want to have a preparation patch adding the
> necessary labels in the soc dtsi so you don't have to reproduce the
> ahb/apb hierarchy here.

I agree: +1

>> +	ahb {
>> +		apb {
>> +			pinctrl@fffff200 {
> 
> Ditto
> 
>> +				board {
>> +					pinctrl_mmc0_cd: mmc0_cd {
>> +						atmel,pins = <AT91_PIOC 26 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PC26 GPIO with pullup deglitch */
>> +					};
>> +
>> +					pinctrl_usba_vbus: usba_vbus {
>> +						atmel,pins = <AT91_PIOB 13 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>; /* PB13 GPIO with deglitch */
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&slow_osc {
>> +	atmel,osc-bypass;
>> +};
> 
> After the clock binding rework, this will have to be moved to the pmc
> node (the rework is not posted, this is just to remind me that this will
> have to be done).
> 
>> +
>> +&usart1_clk {
>> +	atmel,clk-output-range = <0 132000000>;
>> +};
> 
> The datasheet explicitly states that 66 MHz is the maximum allowed
> frequency for the USART. Note that the new binding will not allow you to
> do that.
> 
> However, I see the table disappeared from the latest datasheet. Maybe
> Nicolas can comment on that?

You're right, 66 MHz is the maximum frequency for all USART and UART on 
this sama5d3 SoC.

The disappearing of this table is a bug in the latest datasheet. I can 
see that the one "11121B–ATARM–08-Mar-13" still have it. I report this 
issue to the team in charge of datasheets (it will be certainly fixed 
for next release of this document).

Best regards,
-- 
Nicolas Ferre
