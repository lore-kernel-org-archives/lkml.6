Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BFFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBB420874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeLSPBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:01:05 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38808 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727502AbeLSPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:01:05 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBJEuFhq026070;
        Wed, 19 Dec 2018 16:00:26 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pcr8xxg5n-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Dec 2018 16:00:26 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EFF0D3A;
        Wed, 19 Dec 2018 15:00:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BA4552A59;
        Wed, 19 Dec 2018 15:00:24 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 19 Dec
 2018 16:00:23 +0100
Subject: Re: [PATCH v3 0/3] Make STM32 interrupt controller use hwspinlock
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20181217142215.17493-1-benjamin.gaignard@st.com>
 <297d3207-7302-674e-5acd-30dc7b2df408@arm.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <fc6eb663-8694-662d-c4c2-705c7bc57700@st.com>
Date:   Wed, 19 Dec 2018 16:00:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <297d3207-7302-674e-5acd-30dc7b2df408@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 12/18/18 4:39 PM, Marc Zyngier wrote:
> On 17/12/2018 14:22, Benjamin Gaignard wrote:
>> This series allow to protect STM32 interrupt controller configuration registers
>> with a hwspinlock to avoid conflicting accesses between processors.
>>
>> version 3:
>> - with bindings patch
>>
>> version 2:
>> - rework hwspinlock locking sequence in stm32 irqchip to take care of the
>>    cases where hwspinlock node is disabled or not yet probed
>>
>> Benjamin Gaignard (3):
>>    dt-bindings: interrupt-controller: stm32: Document hwlock properties
>>    irqchip: stm32: protect configuration registers with hwspinlock
>>    ARM: dts: stm32: Add hwlock for irqchip on stm32mp157
>>
>>   .../interrupt-controller/st,stm32-exti.txt         |   4 +
>>   arch/arm/boot/dts/stm32mp157c.dtsi                 |   1 +
>>   drivers/irqchip/irq-stm32-exti.c                   | 116 ++++++++++++++++++---
>>   3 files changed, 105 insertions(+), 16 deletions(-)
>>
> 
> I've taken the first two patches. Please route the DTS patch to the
> appropriate tree.
> 

I'll take DTS patch in stm32-next branch.

Regards
Alex

> Thanks,
> 
> 	M.
> 
