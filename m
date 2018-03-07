Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeCGKap (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:30:45 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:56100 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeCGKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:30:38 -0500
X-Google-Smtp-Source: AG47ELtevs7CFk89noceRDW1sYZWAuzfeiDJUO6AxYkTs9QGRp+Qrd6O6zimgHQHX3DzWRnHvErQnO4mwG11g6ddJyE=
MIME-Version: 1.0
In-Reply-To: <CACPK8Xeb3ryfi+FXr+mdpk2fPtSTwJXkuBjRhW76vx1SxGQfYQ@mail.gmail.com>
References: <1519655769-25836-1-git-send-email-tmaimon77@gmail.com>
 <1519655769-25836-2-git-send-email-tmaimon77@gmail.com> <CACPK8Xeb3ryfi+FXr+mdpk2fPtSTwJXkuBjRhW76vx1SxGQfYQ@mail.gmail.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 7 Mar 2018 12:30:37 +0200
Message-ID: <CAP6Zq1io9rLytqkyo5BBFw1Hf24c-r9PuH5ORsKu-j2brzbZHQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-binding: timer: document NPCM7xx timer DT bindings
To: Joel Stanley <joel@jms.id.au>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late response

On 2 March 2018 at 03:51, Joel Stanley <joel@jms.id.au> wrote:
> Hi Tomer,
>
> On Tue, Feb 27, 2018 at 1:06 AM, Tomer Maimon <tmaimon77@gmail.com> wrote:
>> Added device tree binding documentation for Nuvoton NPCM7xx timer.
>>
>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>> ---
>>  .../bindings/timer/nuvoton,npcm7xx-timer.txt       | 25 ++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
>> new file mode 100644
>> index 000000000000..c5150522e618
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
>> @@ -0,0 +1,25 @@
>> +Nuvoton NPCM7xx timer
>
> Would it make more sense to all this Nuvoton NPCM Timer? This way the
> name stays generic for when you add other systems.
>
we cant promise the timer will stay the same in the next generation, I
will leave this for NPCM7xx
>> +
>> +Nuvoton NPCM7xx have three timer modules, each timer module provides five 24-bit
>> +timer counters.
>
>
> I notice the timer has a register in the middle of it that is used for
> the watchdog. Should we describe this in the same binding? Even if we
> just add some text that adds
>
>  ... and one watchdog register.
>
I'm not sure, because the binding is only for the timer I dont think I
need to describe what is the
register contains
>> +
>> +Required properties:
>> +- compatible      : "nuvoton,npcm750-timer" for Poleg NPCM750.
>> +- reg             : Offset and length of the register set for the device.
>> +- interrupts      : Contain the timer interrupt with flags for
>> +                    falling edge.
>> +
>> +Required clocking property, have to be one of:
>> +- clocks          : phandle of timer reference clock.
>> +- clock-frequency : The frequency in Hz of the clock that drives the NPCM7xx
>> +                    timer (usually 25000000).
>> +
>> +Example:
>> +
>> +timer@f0008000 {
>> +    compatible = "nuvoton,npcm750-timer";
>> +    interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> +    reg = <0xf0008000 0x1000>;
>
> This can probably be <0xf0008000 0x50>, as tthe timer hardware only
> has registers up to base + 0x50.
Thanks,
I will modify it in the next version, waiting fro more comments.
>
>> +    clocks = <&clk NPCM7XX_CLK_TIMER>;
>> +};
>> +
>> --
>> 2.14.1
>>

Cheers,

Tomer
