Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE59C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0682214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0682214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJIOeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:34:24 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44090 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbeJIOeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:34:24 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w997Dr22030245;
        Tue, 9 Oct 2018 09:18:28 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2n01hep4qu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Oct 2018 09:18:28 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6788431;
        Tue,  9 Oct 2018 07:18:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3339324E2;
        Tue,  9 Oct 2018 07:18:27 +0000 (GMT)
Received: from [10.201.23.236] (10.75.127.45) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 9 Oct
 2018 09:18:26 +0200
Subject: Re: [PATCH v3 1/7] dt-bindings: stm32-dma: Add DMA/MDMA chaining
 support bindings
To:     Vinod <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-2-git-send-email-pierre-yves.mordret@st.com>
 <20181007145722.GY2372@vkoul-mobl>
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <5d7a218c-9e96-3931-88ab-0b4dcb3ec4e5@st.com>
Date:   Tue, 9 Oct 2018 09:18:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181007145722.GY2372@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-09_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod

On 10/07/2018 04:57 PM, Vinod wrote:
> On 28-09-18, 15:01, Pierre-Yves MORDRET wrote:
>> From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>>
>> This patch adds dma bindings to support DMA/MDMA chaining transfer.
>> 1 bit is to manage both DMA FIFO Threshold
>> 1 bit is to manage DMA/MDMA Chaining features.
>> 2 bits are used to specify SDRAM size to use for DMA/MDMA chaining.
> 
> Please do mention which specific bits?

This is written below into DMA Client section. But I can put some words here.

> 
>> The size in bytes of a certain order is given by the formula:
>>     (2 ^ order) * PAGE_SIZE.
>> The order is given by those 2 bits.
>> For cyclic, whether chaining is chosen, any value above 1 can be set :
>> SRAM buffer size will rely on period size and not on this DT value.
>>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>   Version history:
>>     v3:
>>     v2:
>>        * rework content
>>     v1:
>>        * Initial
>> ---
>> ---
>>  .../devicetree/bindings/dma/stm32-dma.txt          | 27 +++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
>> index c5f5190..2bac8c7 100644
>> --- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
>> +++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
>> @@ -17,6 +17,12 @@ Optional properties:
>>  - resets: Reference to a reset controller asserting the DMA controller
>>  - st,mem2mem: boolean; if defined, it indicates that the controller supports
>>    memory-to-memory transfer
>> +- dmas: A list of eight dma specifiers, one for each entry in dma-names.
>> +  Refer to stm32-mdma.txt for more details.
>> +- dma-names: should contain "ch0", "ch1", "ch2", "ch3", "ch4", "ch5", "ch6" and
>> +  "ch7" and represents each STM32 DMA channel connected to a STM32 MDMA one.
>> +- memory-region : phandle to a node describing memory to be used for
>> +  M2M intermediate transfer between DMA and MDMA.
>>  
>>  Example:
>>  
>> @@ -36,6 +42,16 @@ Example:
>>  		st,mem2mem;
>>  		resets = <&rcc 150>;
>>  		dma-requests = <8>;
>> +		dmas = <&mdma1 8 0x10 0x1200000a 0x40026408 0x00000020 1>,
>> +		       <&mdma1 9 0x10 0x1200000a 0x40026408 0x00000800 1>,
>> +		       <&mdma1 10 0x10 0x1200000a 0x40026408 0x00200000 1>,
>> +		       <&mdma1 11 0x10 0x1200000a 0x40026408 0x08000000 1>,
>> +		       <&mdma1 12 0x10 0x1200000a 0x4002640C 0x00000020 1>,
>> +		       <&mdma1 13 0x10 0x1200000a 0x4002640C 0x00000800 1>,
>> +		       <&mdma1 14 0x10 0x1200000a 0x4002640C 0x00200000 1>,
>> +		       <&mdma1 15 0x10 0x1200000a 0x4002640C 0x08000000 1>;
>> +		dma-names = "ch0", "ch1", "ch2", "ch3", "ch4", "ch5", "ch6", "ch7";
>> +		memory-region = <&sram_dmapool>;
>>  	};
>>  
>>  * DMA client
>> @@ -68,7 +84,16 @@ channel: a phandle to the DMA controller plus the following four integer cells:
>>  	0x1: 1/2 full FIFO
>>  	0x2: 3/4 full FIFO
>>  	0x3: full FIFO
>> -
>> + -bit 2: Intermediate M2M transfer from/to DDR to/from SRAM throughout MDMA
>> +	0: MDMA not used to generate an intermediate M2M transfer
>> +	1: MDMA used to generate an intermediate M2M transfer.
>> + -bit 3-4: indicated SRAM Buffer size in (2^order)*PAGE_SIZE.
>> +	PAGE_SIZE is given by Linux at 4KiB: include/asm-generic/page.h.
>> +	Order is given by those 2 bits starting at 0.
>> +	Valid only whether Intermediate M2M transfer is set.
> 
> why do we need this as a property?

In some UC, we need more than 4KiB in case of chaining for better performances.
Chaining has to be enabled by client if performance is at sacks.

> 
>> +	For cyclic, whether Intermediate M2M transfer is chosen, any value can
>> +	be set: SRAM buffer size will rely on period size and not on this DT
>> +	value.
>>  
>>  Example:
>>  
>> -- 
>> 2.7.4
> 
