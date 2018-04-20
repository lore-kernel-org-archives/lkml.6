Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753743AbeDTHTD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:19:03 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47287 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751254AbeDTHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:19:01 -0400
Subject: Re: [PATCH v2 1/2] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
To: =?UTF-8?Q?Rados=c5=82aw_Pietrzyk?= <radoslaw.pietrzyk@gmail.com>
CC: Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
 <a709e416-4024-f804-b2ff-ae6c2171a7c8@arm.com>
 <CAFvLkMSZjgFMAe0VRc0AEpG89BgXkfMb9+ivJ8V+PFighOoDRA@mail.gmail.com>
 <118e66b4-3137-7af5-b93d-b1949fad575c@arm.com>
 <ef86e131-ffb4-b883-b9ca-1e670d960d3e@st.com>
 <CAFvLkMQv3AajhFaRxsBt+UzdGFeix_FA-0mhtYqwMo2x0zgrnA@mail.gmail.com>
From: Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <4c8eda6d-a4b0-8c9c-19c2-c5ee334ff3ba@st.com>
Date: Fri, 20 Apr 2018 09:18:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAFvLkMQv3AajhFaRxsBt+UzdGFeix_FA-0mhtYqwMo2x0zgrnA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.121]
X-ClientProxiedBy: GPXDAG7NODE5.st.com (10.75.127.84) To GPXDAG6NODE4.st.com
 (10.75.127.80)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ok, So I include your patch in my serie
- irqchip: stm32: Optimizes and cleans up stm32-exti irq_domain

BR
Ludo

On 04/19/2018 10:03 PM, Radosław Pietrzyk wrote:
> Sure, I don't mind. I didn't have time to resend v3 with more verbose 
> description.
> 
> 2018-04-19 15:24 GMT+02:00 Ludovic BARRE <ludovic.barre@st.com 
> <mailto:ludovic.barre@st.com>>:
> 
>     Hi Radoslaw
> 
>     I preparing a patch serie which add support of stm32mp1.
>     Would you like, I add your patch (with commit message updated)
>     in my serie?
>     patch:
>     -irqchip: stm32: Optimizes and cleans up stm32-exti irq_domain
> 
>     BR
>     Ludo
> 
> 
>     On 03/14/2018 01:04 PM, Marc Zyngier wrote:
> 
>         On 14/03/18 11:46, Radosław Pietrzyk wrote:
> 
>             Hi Marc,
>             We had a quite fruitful discussion in this mail thread
>             regarding this
>             topic and Ludovic acked it so recently I have asked Thomas
>             if he still
>             needs this v3 patch with detailed explanation especially as
>             v2 version
>             of stm32-gpio patch has been already taken by Linus. However
>             if you
>             require I can resend v3 of this patch only with this
>             detailed explanation.
> 
> 
>         That'd be useful. The changelog is the only thing that will be
>         left from
>         this discussion, so it'd better be complete and accurate. If you
>         quickly
>         send a v3 for this single patch, I'll queue it right away.
> 
>         Thanks,
> 
>                  M.
> 
> 
>             2018-03-14 12:09 GMT+01:00 Marc Zyngier
>             <marc.zyngier@arm.com <mailto:marc.zyngier@arm.com>
>             <mailto:marc.zyngier@arm.com <mailto:marc.zyngier@arm.com>>>:
> 
>                   Radoslaw,
> 
>                   On 23/02/18 08:42, Thomas Gleixner wrote:
>                   > Radoslaw,
>                   >
>                   > On Fri, 23 Feb 2018, Radoslaw Pietrzyk wrote:
>                   >
>                   >> - discards setting handle_simple_irq handler for
>             hierarchy interrupts
>                   >> - removes acking in chained irq handler as this is
>             done by
>                   >> irq_chip itself inside handle_edge_irq
>                   >> - removes unneeded irq_domain_ops.xlate callback
>                   >
>                   > if that's all functionally correct, then this is a
>             nice cleanup. Though
>                   > from the above changelog its hard to tell because it
>             merily tells WHAT the
>                   > patch does, but not WHY. The WHY is the important
>             information for a
>                   > reviewer who is not familiar with the particular
>             piece of code/hardware.
>                   >
>                   > Can you please amend the changelog with proper
>             explanations why a
>                   > particular piece of code is not needed or has to be
>             changed to something
>                   > else?
> 
>                   Any update on this? I'd like to queue this for 4.17,
>             but Thomas'
>                   comments should be addressed before that happens. Ca
>             you please respin a
>                   version with a better change log and the various
>             review tags?
> 
>                   Thanks,
> 
>                           M.
>                   --
>                   Jazz is not dead. It just smells funny...
> 
> 
> 
> 
> 
