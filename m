Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B12C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E5720883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E5720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbeFUH0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:26:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38326 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754166AbeFUH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:26:00 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5L7O2lL027081;
        Thu, 21 Jun 2018 09:25:23 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jqqgqbpv5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Jun 2018 09:25:23 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BCC8C34;
        Thu, 21 Jun 2018 07:25:19 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9737E1647;
        Thu, 21 Jun 2018 07:25:19 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 21 Jun
 2018 09:25:18 +0200
Subject: Re: [PATCH V3 1/3] watchdog: stm32: add pclk feature for stm32mp1
To:     Rob Herring <robh@kernel.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1529502698-13263-1-git-send-email-ludovic.Barre@st.com>
 <1529502698-13263-2-git-send-email-ludovic.Barre@st.com>
 <20180620191409.GA29934@rob-hp-laptop>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <618bcde6-0a41-9341-c55c-6e1d0ee8e51d@st.com>
Date:   Thu, 21 Jun 2018 09:25:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620191409.GA29934@rob-hp-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/20/2018 09:14 PM, Rob Herring wrote:
> On Wed, Jun 20, 2018 at 03:51:36PM +0200, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch adds config data to manage specific properties by
>> compatible. Adds stm32mp1 config which requires pclk clock.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  21 +++-
> 
> Please split bindings to separate patch.

OK

> 
>>   drivers/watchdog/stm32_iwdg.c                      | 116 +++++++++++++--------
>>   2 files changed, 91 insertions(+), 46 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>> index cc13b10a..f07f6d89 100644
>> --- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>> @@ -2,18 +2,31 @@ STM32 Independent WatchDoG (IWDG)
>>   ---------------------------------
>>   
>>   Required properties:
>> -- compatible: "st,stm32-iwdg"
>> -- reg: physical base address and length of the registers set for the device
>> -- clocks: must contain a single entry describing the clock input
>> +- compatible: Should be either "st,stm32-iwdg" or "st,stm32mp1-iwdg"
> 
> Please format one per line.

OK

> 
>> +- reg: Physical base address and length of the registers set for the device
>> +- clocks: Reference to the clock entry lsi. Additional pclk clock entry
>> +  is required only for st,stm32mp1-iwdg.
>> +- clock-names: Name of the clocks used.
>> +  "lsi" for st,stm32-iwdg
>> +  "pclk", "lsi" for st,stm32mp1-iwdg
> 
> Put lsi 1st so it is always index 0.

OK

> 
>>   
>>   Optional Properties:
>>   - timeout-sec: Watchdog timeout value in seconds.
>>   
>> -Example:
>> +Examples:
>>   
>>   iwdg: watchdog@40003000 {
>>   	compatible = "st,stm32-iwdg";
>>   	reg = <0x40003000 0x400>;
>>   	clocks = <&clk_lsi>;
>> +	clock-names = "lsi";
>> +	timeout-sec = <32>;
>> +};
>> +
>> +iwdg: iwdg@5a002000 {
> 
> watchdog@...

sorry, I forget this occurrence.

> 
> Do we really need 2 example just to show 2 clocks?

No, I could keep only one

> 
>> +	compatible = "st,stm32mp1-iwdg";
>> +	reg = <0x5a002000 0x400>;
>> +	clocks = <&rcc IWDG2>, <&clk_lsi>;
>> +	clock-names = "pclk", "lsi";
>>   	timeout-sec = <32>;
>>   };
