Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeBALfj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:35:39 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45428 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752413AbeBALfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:35:34 -0500
X-Google-Smtp-Source: AH8x227Tt+xrRZ6BBYq4PYLOnoI+fpn5oiLB0zIIbjwy5nVb6sK7jpX8WqeliJS45h0ifVp18WSWOR7CJ/iP0bKvBGs=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUfGUXmjFdyjLdBiyOayy22p-91Oonp-hK4x0hqcOnPUA@mail.gmail.com>
References: <alpine.DEB.2.20.1801301935410.1797@nanos> <tip-55595980acc3232b018ba30df8ee6e0ac40ad184@git.kernel.org>
 <CAMuHMdUfGUXmjFdyjLdBiyOayy22p-91Oonp-hK4x0hqcOnPUA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 1 Feb 2018 12:35:33 +0100
X-Google-Sender-Auth: zeHVM7HyNn4OJe6C8ZhRpXuDZQA
Message-ID: <CAK8P3a0udHSrqBZ3BtJAqa4oUJ2wGuWZGZ6e=62OxLXbL_9X3A@mail.gmail.com>
Subject: Re: [tip:irq/urgent] genirq: Make legacy autoprobing work again
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Meelis Roos <mroos@linux.ee>, Ingo Molnar <mingo@kernel.org>,
        linux-tip-commits@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 9:15 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>> +++ b/kernel/irq/chip.c
>> @@ -294,11 +294,11 @@ int irq_activate(struct irq_desc *desc)
>>         return 0;
>>  }
>>
>> -void irq_activate_and_startup(struct irq_desc *desc, bool resend)
>> +int irq_activate_and_startup(struct irq_desc *desc, bool resend)
>>  {
>>         if (WARN_ON(irq_activate(desc)))
>>                 return;
>
> As reported by 0day, this should return something.
>
> if CONFIG_IRQ_DOMAIN=n or CONFIG_IRQ_DOMAIN_HIERARCHY=n,
> irq_activate() will never return 1, and the code path can be eliminated.
>
> BTW, is gcc becoming too smart, and already eliminating code before it
> generates warnings for it? Recently I've seen some other cases where buggy
> code was not warned about, as it was considered not having any impact.
>

I've tried my collection of compiler versions, and they produce a warning here
on my box.

       Arnd
