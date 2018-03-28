Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeC1SgP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:36:15 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33233 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeC1SgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:36:11 -0400
X-Google-Smtp-Source: AIpwx4/1QRmmoOAKxeGXs5kC762r+b6dzPlxYRDqkHiRMPq/eyXkDS1hCOh7GyLaJBOR+VNgjta56equTl3nCjNmuuU=
MIME-Version: 1.0
In-Reply-To: <c02d2ae665890e7214bcfa6c42a49c69@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net> <20180317232901.14129-1-paul@crapouillou.net>
 <20180317232901.14129-3-paul@crapouillou.net> <CA+7wUsyAkW+Bgmp6MuWTce1jMG-ug1b-UqFVen_vVeKFiW5Fww@mail.gmail.com>
 <c02d2ae665890e7214bcfa6c42a49c69@crapouillou.net>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 28 Mar 2018 20:35:50 +0200
X-Google-Sender-Auth: poi3CHIuufSvBUbH1UVKJwpWaUk
Message-ID: <CA+7wUswkTy=1BJwk0Ys=HFZ4Sk9pFr4jsE0LvDM1x41YRBCg4g@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: ingenic: Add DT bindings for TCU clocks
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>, linux-clk@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SIaK7H026154

On Wed, Mar 28, 2018 at 5:04 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> Le 2018-03-20 08:15, Mathieu Malaterre a écrit :
>>
>> Hi Paul,
>>
>> Two things:
>>
>> On Sun, Mar 18, 2018 at 12:28 AM, Paul Cercueil <paul@crapouillou.net>
>> wrote:
>>>
>>> This header provides clock numbers for the ingenic,tcu
>>> DT binding.
>>
>>
>> I have tested the whole series on my Creator CI20 with success, using:
>>
>> + tcu@10002000 {
>> + compatible = "ingenic,jz4780-tcu";
>> + reg = <0x10002000 0x140>;
>> +
>> + interrupt-parent = <&intc>;
>> + interrupts = <27 26 25>;
>> + };
>>
>>
>> So:
>>
>> Tested-by: Mathieu Malaterre <malat@debian.org>
>
>
> Great! Is that for the whole patchset or just this one patch?

The sentence just above was "whole series"  :) so yes that was for the
whole series. Technically I only tested it on JZ4780, I hope this is
acceptable for the tag.



>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  include/dt-bindings/clock/ingenic,tcu.h | 23 +++++++++++++++++++++++
>>>  1 file changed, 23 insertions(+)
>>>  create mode 100644 include/dt-bindings/clock/ingenic,tcu.h
>>>
>>>  v2: Use SPDX identifier for the license
>>>  v3: No change
>>>  v4: No change
>>>
>>> diff --git a/include/dt-bindings/clock/ingenic,tcu.h
>>> b/include/dt-bindings/clock/ingenic,tcu.h
>>> new file mode 100644
>>> index 000000000000..179815d7b3bb
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/ingenic,tcu.h
>>> @@ -0,0 +1,23 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * This header provides clock numbers for the ingenic,tcu DT binding.
>>> + */
>>> +
>>> +#ifndef __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
>>> +#define __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
>>> +
>>> +#define JZ4740_CLK_TIMER0      0
>>> +#define JZ4740_CLK_TIMER1      1
>>> +#define JZ4740_CLK_TIMER2      2
>>> +#define JZ4740_CLK_TIMER3      3
>>> +#define JZ4740_CLK_TIMER4      4
>>> +#define JZ4740_CLK_TIMER5      5
>>> +#define JZ4740_CLK_TIMER6      6
>>> +#define JZ4740_CLK_TIMER7      7
>>> +#define JZ4740_CLK_WDT         8
>>> +#define JZ4740_CLK_LAST                JZ4740_CLK_WDT
>>> +
>>> +#define JZ4770_CLK_OST         9
>>> +#define JZ4770_CLK_LAST                JZ4770_CLK_OST
>>> +
>>
>>
>> When working on JZ4780 support, I always struggle to read those kind
>> of #define. Since this is a new patch would you mind changing
>> s/JZ4740/JZ47XX/ in your header ?
>
>
> Well the idea was that these defines are for JZ4740 and newer.
> But that means all Ingenic SoCs, so I guess I can change it.
>
>> Thanks for your work on JZ !
>
>
> Sure, thank you for testing!
>
>
>>> +#endif /* __DT_BINDINGS_CLOCK_INGENIC_TCU_H__ */
>>> --
>>> 2.11.0
>>>
>>>
>
