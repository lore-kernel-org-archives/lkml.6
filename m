Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeCNMEz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:04:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51452 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751289AbeCNMEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:04:53 -0400
Subject: Re: [PATCH v2 1/2] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
To: =?UTF-8?Q?Rados=c5=82aw_Pietrzyk?= <radoslaw.pietrzyk@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Ludovic BARRE <ludovic.barre@st.com>
References: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
 <a709e416-4024-f804-b2ff-ae6c2171a7c8@arm.com>
 <CAFvLkMSZjgFMAe0VRc0AEpG89BgXkfMb9+ivJ8V+PFighOoDRA@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <118e66b4-3137-7af5-b93d-b1949fad575c@arm.com>
Date: Wed, 14 Mar 2018 12:04:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAFvLkMSZjgFMAe0VRc0AEpG89BgXkfMb9+ivJ8V+PFighOoDRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/18 11:46, Radosław Pietrzyk wrote:
> Hi Marc,
> We had a quite fruitful discussion in this mail thread regarding this
> topic and Ludovic acked it so recently I have asked Thomas if he still
> needs this v3 patch with detailed explanation especially as v2 version
> of stm32-gpio patch has been already taken by Linus. However if you
> require I can resend v3 of this patch only with this detailed explanation.

That'd be useful. The changelog is the only thing that will be left from
this discussion, so it'd better be complete and accurate. If you quickly
send a v3 for this single patch, I'll queue it right away.

Thanks,

	M.

> 
> 2018-03-14 12:09 GMT+01:00 Marc Zyngier <marc.zyngier@arm.com
> <mailto:marc.zyngier@arm.com>>:
> 
>     Radoslaw,
> 
>     On 23/02/18 08:42, Thomas Gleixner wrote:
>     > Radoslaw,
>     >
>     > On Fri, 23 Feb 2018, Radoslaw Pietrzyk wrote:
>     >
>     >> - discards setting handle_simple_irq handler for hierarchy interrupts
>     >> - removes acking in chained irq handler as this is done by
>     >> irq_chip itself inside handle_edge_irq
>     >> - removes unneeded irq_domain_ops.xlate callback
>     >
>     > if that's all functionally correct, then this is a nice cleanup. Though
>     > from the above changelog its hard to tell because it merily tells WHAT the
>     > patch does, but not WHY. The WHY is the important information for a
>     > reviewer who is not familiar with the particular piece of code/hardware.
>     >
>     > Can you please amend the changelog with proper explanations why a
>     > particular piece of code is not needed or has to be changed to something
>     > else?
> 
>     Any update on this? I'd like to queue this for 4.17, but Thomas'
>     comments should be addressed before that happens. Ca you please respin a
>     version with a better change log and the various review tags?
> 
>     Thanks,
> 
>             M.
>     --
>     Jazz is not dead. It just smells funny...
> 
> 


-- 
Jazz is not dead. It just smells funny...
