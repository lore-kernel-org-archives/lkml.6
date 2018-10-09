Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10252C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C057E2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C057E2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeJIOiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:38:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39247 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725892AbeJIOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:38:51 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w997JPqE023754;
        Tue, 9 Oct 2018 09:22:58 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n0muxrtsp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Oct 2018 09:22:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EF88F3A;
        Tue,  9 Oct 2018 07:22:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A77A524FA;
        Tue,  9 Oct 2018 07:22:57 +0000 (GMT)
Received: from [10.201.23.236] (10.75.127.45) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 9 Oct
 2018 09:22:56 +0200
Subject: Re: [PATCH v3 2/7] dt-bindings: stm32-dmamux: Add one cell to support
 DMA/MDMA chain
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
 <1538139715-24406-3-git-send-email-pierre-yves.mordret@st.com>
 <20181007145805.GZ2372@vkoul-mobl>
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <20eafd84-7bb8-0019-94e2-3f46a894edf1@st.com>
Date:   Tue, 9 Oct 2018 09:22:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181007145805.GZ2372@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-09_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/2018 04:58 PM, Vinod wrote:
> On 28-09-18, 15:01, Pierre-Yves MORDRET wrote:
>> From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>>
>> Add one cell to support DMA/MDMA chaining.
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
>>  Documentation/devicetree/bindings/dma/stm32-dmamux.txt | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
>> index 1b893b2..5e92b59 100644
>> --- a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
>> +++ b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
>> @@ -4,9 +4,9 @@ Required properties:
>>  - compatible:	"st,stm32h7-dmamux"
>>  - reg:		Memory map for accessing module
>>  - #dma-cells:	Should be set to <3>.
>> -		First parameter is request line number.
>> -		Second is DMA channel configuration
>> -		Third is Fifo threshold
>> +-		First parameter is request line number.
>> +-		Second is DMA channel configuration
>> +-		Third is a 32bit bitfield
> 
> please separate out formatting changes and actual change proposed..

Yes. sorry. my bad.

> 
>>  		For more details about the three cells, please see
>>  		stm32-dma.txt documentation binding file
>>  - dma-masters:	Phandle pointing to the DMA controllers.
>> -- 
>> 2.7.4
> 
