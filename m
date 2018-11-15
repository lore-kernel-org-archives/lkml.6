Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BA8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688CD223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688CD223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbeKOW7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:59:47 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:47374 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeKOW7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:59:47 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42wh8J5Rwmz1r01q;
        Thu, 15 Nov 2018 13:52:00 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42wh8J4lC9z1qsK9;
        Thu, 15 Nov 2018 13:52:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id IyFlXmudXn9q; Thu, 15 Nov 2018 13:51:59 +0100 (CET)
X-Auth-Info: ez/UVKNWsSmb34E6DUMfvXmJjIqYIrtJonnlD0tzRo8=
Received: from antares.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 15 Nov 2018 13:51:59 +0100 (CET)
Cc:     pn@denx.de, afaerber@suse.de, robh+dt@kernel.org,
        mark.rutland@arm.com, wsa@the-dreams.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: actions: s700: Add I2C controller nodes
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20181113133235.37754-1-pn@denx.de>
 <20181115111217.GC15537@Mani-XPS-13-9360>
From:   Parthiban Nallathambi <pn@denx.de>
Message-ID: <f3364954-d1af-af41-2619-449b401140b8@denx.de>
Date:   Thu, 15 Nov 2018 13:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115111217.GC15537@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/18 12:12 PM, Manivannan Sadhasivam wrote:
> Hi Parthiban,
> 
> On Tue, Nov 13, 2018 at 02:32:35PM +0100, Parthiban Nallathambi wrote:
>> Add I2C controller nodes for Actions Semiconductor S700 SoC.
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> ---
>>   arch/arm64/boot/dts/actions/s700.dtsi | 40 +++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
>> index 192c7b39c8c1..573c844d7afe 100644
>> --- a/arch/arm64/boot/dts/actions/s700.dtsi
>> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
>> @@ -174,6 +174,46 @@
>>   			#clock-cells = <1>;
>>   		};
>>   
>> +		i2c0: i2c@e0170000 {
>> +			compatible = "actions,s900-i2c";
> 
> Why don't you add a compatible for S700? Also, please add the pinctrl
> nodes for these busses and enable the ones exposed on board. These could
> go in a separate patch.

Makes sense as pinctrl is already fine. Will do in v2 as series!

Thanks,
Parthi
> 
> Thanks,
> Mani
> 
>> +			reg = <0 0xe0170000 0 0x1000>;
>> +			clocks = <&cmu CLK_I2C0>;
>> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c1: i2c@e0174000 {
>> +			compatible = "actions,s900-i2c";
>> +			reg = <0 0xe0174000 0 0x1000>;
>> +			clocks = <&cmu CLK_I2C1>;
>> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c2: i2c@e0178000 {
>> +			compatible = "actions,s900-i2c";
>> +			reg = <0 0xe0178000 0 0x1000>;
>> +			clocks = <&cmu CLK_I2C2>;
>> +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c3: i2c@e017c000 {
>> +			compatible = "actions,s900-i2c";
>> +			reg = <0 0xe017c000 0 0x1000>;
>> +			clocks = <&cmu CLK_I2C3>;
>> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>>   		sps: power-controller@e01b0100 {
>>   			compatible = "actions,s700-sps";
>>   			reg = <0x0 0xe01b0100 0x0 0x100>;
>> -- 
>> 2.17.2
>>
> 

-- 
Thanks,
Parthiban N

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-22 Fax: (+49)-8142-66989-80 Email: pn@denx.de
