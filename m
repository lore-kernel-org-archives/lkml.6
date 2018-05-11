Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeEKHrw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 03:47:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36860 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752277AbeEKHru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 03:47:50 -0400
Subject: Re: [PATCH 01/11] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
To: Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        radek <radoslaw.pietrzyk@gmail.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
 <1524759514-12392-2-git-send-email-ludovic.Barre@st.com>
 <20a1b5f0-7494-01a9-635f-c46c337a23b3@arm.com>
From: Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <364a4b45-0276-8e99-4902-f6dfc2aaff2d@st.com>
Date: Fri, 11 May 2018 09:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20a1b5f0-7494-01a9-635f-c46c337a23b3@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/08/2018 04:47 PM, Marc Zyngier wrote:
> On 26/04/18 17:18, Ludovic Barre wrote:
>> From: radek <radoslaw.pietrzyk@gmail.com>
>>
>> - In stm32_exti_alloc function, discards irq_domain_set_info
>>    with handle_simple_irq. This overwrite the setting defined while init
>>    of generic chips. Exti controller manages edge irq type.
>> - Removes acking in chained irq handler as this is done by
>>    irq_chip itself inside handle_edge_irq
>> - removes unneeded irq_domain_ops.xlate callback
>>
>> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
>> Acked-by: Ludovic Barre <ludovic.barre@st.com>
>> Tested-by: Ludovic Barre <ludovic.barre@st.com>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> 
> Nit: the "From:" should match the SoB line (the address does, but not
> the name). I can fix that up when I apply the series.
> 

Thanks

> Thanks,
> 
> 	M.
> 
