Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A12FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DDA2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfBYPsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:48:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43839 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727712AbfBYPsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:48:52 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PFg3FD011731;
        Mon, 25 Feb 2019 16:48:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtwxntjsw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Feb 2019 16:48:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 432E531;
        Mon, 25 Feb 2019 15:48:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16F7F51FA;
        Mon, 25 Feb 2019 15:48:36 +0000 (GMT)
Received: from [10.48.0.160] (10.75.127.44) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Feb
 2019 16:48:35 +0100
Subject: Re: [PATCH v1 1/3] ARM: dts: stm32: Add Vivante GPU support on
 STM32MP157c
To:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <devicetree@vger.kernel.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
 <1550246316-9747-2-git-send-email-pierre-yves.mordret@st.com>
 <1550247118.2546.56.camel@pengutronix.de>
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <44bb72aa-8e49-4ec5-dd9a-5fce6f0bce29@st.com>
Date:   Mon, 25 Feb 2019 16:48:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550247118.2546.56.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas

sorry for the delay : winter season :)

On 2/15/19 5:11 PM, Lucas Stach wrote:
> Hi Pierre-Yves,
> 
> Am Freitag, den 15.02.2019, 16:58 +0100 schrieb Pierre-Yves MORDRET:
>> Append Vivante GPU DT configuration.
>>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>  arch/arm/boot/dts/stm32mp157c.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
>> index f8bbfff..29540bc 100644
>> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
>> @@ -1106,6 +1106,16 @@
>>>  			status = "disabled";
>>>  		};
>>  
>> +		gpu: gpu@59000000 {
>> +			compatible = "vivante,gc";
>> +			reg = <0x59000000 0x800>;
>> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&rcc GPU>, <&rcc GPU_K>;
>> +			clock-names = "bus" ,"core";
> 
> Is this a 2D only core? If it is also 3D capable the binding says you
> need to specify the shader clock (may be the same clock feeding the
> core).

Yes, this is a 3D core.
As for "shader" clock both "core" and "shader" are connected internally. This is
why no "shader" input clock is seen.
Nonetheless we may add it for bindings compliance but from STM32MP1 pov this
won't make any changes.

Hope it clarifies.

Regards
> 
> Regards,
> Lucas
> 
>> +			resets = <&rcc GPU_R>;
>> +			status = "disabled";
>> +		};
>> +
>>  		dsi: dsi@5a000000 {
>>  			compatible = "st,stm32-dsi";
>>  			reg = <0x5a000000 0x800>;
