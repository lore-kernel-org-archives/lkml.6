Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655FFC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9332229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406649AbfBNKgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:36:24 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41210 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727539AbfBNKgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:36:24 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EAa0rA026763;
        Thu, 14 Feb 2019 11:36:13 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qmwsujqr4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 11:36:13 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 364CC31;
        Thu, 14 Feb 2019 10:36:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11EB74EA2;
        Thu, 14 Feb 2019 10:36:13 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.46) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 11:36:11 +0100
Subject: Re: [PATCH 0/4] Add nvmem support on STM32
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lionel.debieve@st.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
 <4aaa83b2-35a6-e2c2-a3f4-6579b5d67038@st.com>
 <46a59513-a322-1e14-41b5-ecbd4c478286@linaro.org>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <46ae9e00-1cf6-0ac9-eb9d-540eae7c621b@st.com>
Date:   Thu, 14 Feb 2019 11:36:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <46a59513-a322-1e14-41b5-ecbd4c478286@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 11:34 AM, Srinivas Kandagatla wrote:
> 
> 
> On 13/02/2019 10:15, Fabrice Gasnier wrote:
>> On 1/30/19 5:38 PM, Fabrice Gasnier wrote:
>>> Non volatile memory area is available on STM32. It contains various
>>> factory programmed information such as unique device ID, analog
>>> calibration...
>>> This patchset adds NVMEM support to access these data.
>>
>> Hello,
>>
>> Gentle reminder for this new driver review
> Nvmem provider driver itself looks fine for me, but I am unable to take
> this as 5.1 material, as I normally take nvmem patches which are
> reviewed and ready before rc5.
> 

Hi Srini,
Thanks for the feedback.

> dt bindings patch needs an ack from DT maintainers.

I hope Rob cant take a look at it.

Best Regards,
Fabrice

> 
> Thanks,
> srini
>>
>> Best Regards,
>> Fabrice
>>
>>>
>>> Fabrice Gasnier (4):
>>>    dt-bindings: nvmem: Add STM32 factory-programmed romem
>>>    nvmem: Add driver for STM32 factory-programmed read only mem
>>>    nvmem: stm32: add support for STM32MP15 BSEC to control OTP data
>>>    ARM: dts: stm32: Add romem and temperature calibration on stm32mp157c
>>>
>>>   .../devicetree/bindings/nvmem/st,stm32-romem.txt   |  31 ++++
>>>   arch/arm/boot/dts/stm32mp157c.dtsi                 |  13 ++
>>>   drivers/nvmem/Kconfig                              |  10 +
>>>   drivers/nvmem/Makefile                             |   2 +
>>>   drivers/nvmem/stm32-romem.c                        | 202
>>> +++++++++++++++++++++
>>>   5 files changed, 258 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
>>>   create mode 100644 drivers/nvmem/stm32-romem.c
>>>
