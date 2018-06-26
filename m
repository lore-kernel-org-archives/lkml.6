Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4F0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D75421C18
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D75421C18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935457AbeFZMO0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:14:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43850 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933509AbeFZMOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:14:23 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5QCDSOe008197;
        Tue, 26 Jun 2018 14:13:49 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2juk81gm7u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Jun 2018 14:13:49 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B358D3F;
        Tue, 26 Jun 2018 12:13:39 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8931D2956;
        Tue, 26 Jun 2018 12:13:39 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Jun
 2018 14:13:38 +0200
Subject: Re: [PATCH 3/3] ARM: multi_v7_defconfig: enable STM32 SPI
To:     Amelie DELAUNAY <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1526566904-24514-1-git-send-email-amelie.delaunay@st.com>
 <1526566904-24514-4-git-send-email-amelie.delaunay@st.com>
 <e3bd3097-fbde-b790-e2b3-d78fb34b849d@st.com>
 <120d8997-3184-bfed-26b7-e0ac7d995b74@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f61c7908-8046-1709-94cf-a4066a330299@st.com>
Date:   Tue, 26 Jun 2018 14:13:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <120d8997-3184-bfed-26b7-e0ac7d995b74@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/26/2018 01:47 PM, Amelie DELAUNAY wrote:
> Hi Alex
> 
> On 06/26/2018 10:44 AM, Alexandre Torgue wrote:
>> Hi Amélie
>> 
>> On 05/17/2018 04:21 PM, Amelie Delaunay wrote:
>>> Enable the STM32 SPI driver, implemented on STM32MP1 SoC.
>>>
>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>>> ---
>>>   arch/arm/configs/multi_v7_defconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/configs/multi_v7_defconfig 
>>> b/arch/arm/configs/multi_v7_defconfig
>>> index 89167cd..f990335 100644
>>> --- a/arch/arm/configs/multi_v7_defconfig
>>> +++ b/arch/arm/configs/multi_v7_defconfig
>>> @@ -411,6 +411,7 @@ CONFIG_SPI_S3C64XX=m
>>>   CONFIG_SPI_SH_MSIOF=m
>>>   CONFIG_SPI_SH_HSPI=y
>>>   CONFIG_SPI_SIRF=y
>>> +CONFIG_SPI_STM32=y
>>>   CONFIG_SPI_SUN4I=y
>>>   CONFIG_SPI_SUN6I=y
>>>   CONFIG_SPI_TEGRA114=y
>>>
>> 
>> Driver which are are not "vital" to boot STM32 platform should be 
>> defined as module. It's the case for this one. Isn't ?
>> 
> 
> You're right. I'll send v2 with CONFIG_SPI_STM32=m ASAP. Should I resend
> the whole patchset (with DT), or just this patch and you take the DT
> patches as they are ?
> 

No, you can just resend this one. I will take DT part from this version.

Regards
Alex

> Regards,
> Amelie
