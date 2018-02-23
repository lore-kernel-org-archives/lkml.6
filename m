Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBWJFk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:05:40 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:47056 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeBWJFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:05:37 -0500
X-Google-Smtp-Source: AG47ELtw2B0wwxIjGV7bjQvVtA6mwGuNMMCKS089oclKsB7aU3ZcDzXW2wZfDfzOWXiPBGCj/RipwUhFvH6+caWsHyg=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
References: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
From: =?UTF-8?Q?Rados=C5=82aw_Pietrzyk?= <radoslaw.pietrzyk@gmail.com>
Date: Fri, 23 Feb 2018 10:05:35 +0100
Message-ID: <CAFvLkMQzj51vgQrFvqDkTtGgT2mrXf4xekLewZ71owWai-_nMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] irqchip: stm32: Optimizes and cleans up stm32-exti irq_domain
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org, Ludovic BARRE <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the HW is fairly simple and straightforward comparing to other
irq chips so it's rather a logic that concerned me the most i.e. why
gpio irqs were handled in a "simple" manner whereas the rest of
interrupts in "edge" manner. According to specification all interrupts
are edge driven and that's how are they treated in set_type callback.
First I thought that all can be handled as simple but then I realized
it makes more sense in handling all of them as edge as they should
according to specification. I will prepare a v3 series with more
detailed explanation in it.

2018-02-23 9:42 GMT+01:00 Thomas Gleixner <tglx@linutronix.de>:
> Radoslaw,
>
> On Fri, 23 Feb 2018, Radoslaw Pietrzyk wrote:
>
>> - discards setting handle_simple_irq handler for hierarchy interrupts
>> - removes acking in chained irq handler as this is done by
>> irq_chip itself inside handle_edge_irq
>> - removes unneeded irq_domain_ops.xlate callback
>
> if that's all functionally correct, then this is a nice cleanup. Though
> from the above changelog its hard to tell because it merily tells WHAT the
> patch does, but not WHY. The WHY is the important information for a
> reviewer who is not familiar with the particular piece of code/hardware.
>
> Can you please amend the changelog with proper explanations why a
> particular piece of code is not needed or has to be changed to something
> else?
>
> Thanks,
>
>         tglx
