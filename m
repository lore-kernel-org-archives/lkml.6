Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451C6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079E820878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079E820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbeGIN3v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:29:51 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:26559 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932666AbeGIN3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:29:49 -0400
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="15785711"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Jul 2018 06:29:48 -0700
Received: from [192.168.100.252] (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Mon, 9 Jul 2018
 06:29:47 -0700
Subject: Re: [PATCH v5 4/5] ARM: dts: at91: sama5d2: add nodes for I2S
 controllers
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <nicolas.ferre@microchip.com>, <boris.brezillon@bootlin.com>,
        <robh+dt@kernel.org>, <broonie@kernel.org>, <sboyd@kernel.org>,
        <Cristian.Birsan@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
 <20180618141239.10892-5-codrin.ciubotariu@microchip.com>
 <20180706193923.GC16084@piout.net>
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Message-ID: <e056ed7d-521d-54ab-2e5d-0f5259a09ec6@microchip.com>
Date:   Mon, 9 Jul 2018 16:29:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706193923.GC16084@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.2018 22:39, Alexandre Belloni wrote:
> Hi Codrin,
> 
> On 18/06/2018 17:12:38+0300, Codrin Ciubotariu wrote:
>> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>
>> This patch adds DT nodes for I2S0 and I2S1. It also adds an alias for
>> each I2S node.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>> [codrin.ciubotariu@microchip.com: added phandle to new mux clock]
>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>> ---
>>
>> The bindings for the I2S node are applied to broonie/sound.git .
>>
>> Changes in v5:
>> 	- the previous name was:
>> 	  [PATCH v4 6/7] ARM: dts: at91: sama5d2: add nodes for I2S controllers
>>
>>   arch/arm/boot/dts/sama5d2.dtsi | 34 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
>> index eeb6afa1cda7..eca73ce40bc5 100644
>> --- a/arch/arm/boot/dts/sama5d2.dtsi
>> +++ b/arch/arm/boot/dts/sama5d2.dtsi
>> @@ -58,6 +58,8 @@
>>   		serial1 = &uart3;
>>   		tcb0 = &tcb0;
>>   		tcb1 = &tcb1;
>> +		i2s0 = &i2s0;
>> +		i2s1 = &i2s1;
>>   	};
>>   
>>   	cpus {
>> @@ -1313,6 +1315,22 @@
>>   				clocks = <&clk32k>;
>>   			};
>>   
>> +			i2s0: i2s@f8050000 {
>> +				compatible = "atmel,sama5d2-i2s";
>> +				reg = <0xf8050000 0x100>;
>> +				interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
>> +				dmas = <&dma0
>> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>> +					 AT91_XDMAC_DT_PERID(31))>,
>> +				       <&dma0
>> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>> +					 AT91_XDMAC_DT_PERID(32))>;
>> +				dma-names = "tx", "rx";
>> +				clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>, <&i2s0muxck>;
>> +				clock-names = "pclk", "gclk", "aclk", "muxclk";
>> +				status = "disabled";
>> +			};
>> +
> 
> Can you resend the DTS patches after removing the unnecessary clocks?

I will. Should I also make the "muxclk" clock an assigned clock to 
assign its parent ?

Thanks and best regards,
Codrin
