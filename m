Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEQSH2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:07:28 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46305 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeEQSH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:07:26 -0400
X-Google-Smtp-Source: AB8JxZqT6CwvNz9cCQiRPyl5+4bTOwg2Z/j2irGdKTVMu7UoJ4igZ8ol4LObitSGdF5mnpjOHJGrKw==
Date: Thu, 17 May 2018 14:07:07 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 6/9] dt-bindings: counter: Document stm32 quadrature
 encoder
Message-ID: <20180517180707.GA30194@sophia>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
 <ccdbbfb2833d274b6bfa234aada57e68d9793dd5.1526487615.git.vilhelm.gray@gmail.com>
 <CAL_Jsq+a4s=5N6wUWifoHWQoornbDBY-UY2xrwj1kggNH4Q5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+a4s=5N6wUWifoHWQoornbDBY-UY2xrwj1kggNH4Q5pQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 11:23:22AM -0500, Rob Herring wrote:
>On Wed, May 16, 2018 at 12:51 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>> From: Benjamin Gaignard <benjamin.gaignard@st.com>
>
>v6? Where's v1-v5?

Hi Rob,

I apologize, I should have CC you on the rest of the patchset to give
you a better idea of the context of this particular patch. Benjamin
Gaignard authored this particular patch, so I'll leave it up to him to
respond to your inline comments, but I can at least provide a brief
history of the revisions of this patchset as a whole.

This patchset introduces a "Generic Counter" interface for drivers to
support various counter devices (tally counters, rotary encoders, etc.).
The v1 revision was submitted on 31 July 2017
(https://lkml.org/lkml/2017/7/31/514) as a wrapper over existing
IIO functionality. This implementation design was unsuitable for the
needs of Generic Counter API, so the v4 revision submitted on 14
December 2017 reimplemented the Generic Counter API as its own Counter
subsystem (https://lkml.org/lkml/2017/12/14/778).

The v5 revision was submitted on 9 March 2018
(https://lkml.org/lkml/2018/3/9/728) and introduced the STM32 Timer
quadrature encoder driver with Generic Counter interface support. I
should have CC you in that revision to comment on the dt-bindings patch,
but I overlooked it, so I made sure to CC you on this v6 revision.

William Breathitt Gray

>
>> Add bindings for STM32 Timer quadrature encoder.
>> It is a sub-node of STM32 Timer which implement the
>> counter part of the hardware.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>> ---
>>  .../bindings/counter/stm32-timer-cnt.txt      | 26 +++++++++++++++++++
>>  .../devicetree/bindings/mfd/stm32-timers.txt  |  7 +++++
>>  2 files changed, 33 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>> new file mode 100644
>> index 000000000000..377728128bef
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>> @@ -0,0 +1,26 @@
>> +STMicroelectronics STM32 Timer quadrature encoder
>> +
>> +STM32 Timer provides quadrature encoder counter mode to detect
>
>'mode' does not sound like a sub-block of the timers block.
>
>> +angular position and direction of rotary elements,
>> +from IN1 and IN2 input signals.
>> +
>> +Must be a sub-node of an STM32 Timer device tree node.
>> +See ../mfd/stm32-timers.txt for details about the parent node.
>> +
>> +Required properties:
>> +- compatible:          Must be "st,stm32-timer-counter".
>> +- pinctrl-names:       Set to "default".
>> +- pinctrl-0:           List of phandles pointing to pin configuration nodes,
>> +                       to set IN1/IN2 pins in mode of operation for Low-Power
>> +                       Timer input on external pin.
>> +
>> +Example:
>> +       timers@40010000  {
>> +               compatible = "st,stm32-timers";
>> +               ...
>> +               counter {
>> +                       compatible = "st,stm32-timer-counter";
>
>Is there only 1? How is the counter addressed?
>
>> +                       pinctrl-names = "default";
>> +                       pinctrl-0 = <&tim1_in_pins>;
>> +               };
>> +       };
