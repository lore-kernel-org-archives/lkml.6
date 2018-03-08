Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbeCHWhu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:37:50 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36522 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeCHWhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:37:48 -0500
X-Google-Smtp-Source: AG47ELudhbcrhrUq56sn1A9iKnU8GVTwtgeLxdpLE0miFvtlFa6nX+lZMXQFotpSCTnipqKY7O+yggLd1u5cP5ioIr4=
MIME-Version: 1.0
In-Reply-To: <2a83eb83-10a9-54f3-e0da-bd6cf32b5ac1@linaro.org>
References: <1520522698-16153-1-git-send-email-tmaimon77@gmail.com>
 <1520522698-16153-3-git-send-email-tmaimon77@gmail.com> <2a83eb83-10a9-54f3-e0da-bd6cf32b5ac1@linaro.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Fri, 9 Mar 2018 00:37:47 +0200
Message-ID: <CAP6Zq1gKE0xUGHuwXa7eLEsUisnaaz=QLgs=6uYnUYDGdX5ryw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] clocksource/drivers/npcm: Add NPCM7xx timer driver
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>, venture@google.com,
        Joel Stanley <joel@jms.id.au>, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w28MbtK8015716

On 8 March 2018 at 17:33, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 08/03/2018 16:24, Tomer Maimon wrote:
>> Add Nuvoton BMC NPCM7xx timer driver.
>>
>> The clocksource Enable 24-bit TIMER0 and TIMER1 counters,
>> while TIMER0 serve as clockevent and TIMER1 serve as clocksource.
>>
>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>> Reviewed-by: Brendan Higgins <brendanhiggins@xxxxxxxxxx>
>> ---
>
> [ ... ]
>
>> +
>> +     pr_info("Enabling NPCM7xx clocksource timer base: 0x%x, IRQ: %d ",
>> +             (int)timer_of_base(&npcm7xx_to), timer_of_irq(&npcm7xx_to));
>
> You can use '%p' instead of '0x%x' and remove the (int) cast.
I think we need to use in the pr_info %px, if I use %p I get in the
kernel boot print "(ptrval)" instead of the address.
please refer: https://lwn.net/Articles/740249/
>
> I'm fine with the driver. If there is no comment, I will take it and do
> the change (if you are ok), no need on this case to resend a v6.
Yes great, Thank a lot!
>
>
>
> --
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
