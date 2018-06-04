Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeFDNDz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:03:55 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36959 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeFDNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:03:53 -0400
X-Google-Smtp-Source: ADUXVKJM31wXD7NG8EC9l6pky8VyqJ+kI9ZdcOn63SmF2NmDSQGlBIzNriE/9nTKBE3jRMBwiX8J3oskjVrW/L2hwws=
MIME-Version: 1.0
In-Reply-To: <20180518162815.GA24966@rob-hp-laptop>
References: <cover.1526487615.git.vilhelm.gray@gmail.com> <ccdbbfb2833d274b6bfa234aada57e68d9793dd5.1526487615.git.vilhelm.gray@gmail.com>
 <CAL_Jsq+a4s=5N6wUWifoHWQoornbDBY-UY2xrwj1kggNH4Q5pQ@mail.gmail.com>
 <CA+M3ks4vjE5JMmLjjPnf6ffD9QYSUmSyrpO+yxADT_8WqAA3Tg@mail.gmail.com> <20180518162815.GA24966@rob-hp-laptop>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Mon, 4 Jun 2018 15:03:51 +0200
Message-ID: <CA+M3ks43RzdhYPwz7i0kB_CPYPLmRfwtALS-bPzuwEQEMcts0Q@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] dt-bindings: counter: Document stm32 quadrature encoder
To: Rob Herring <robh@kernel.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w54D41HP015628

2018-05-18 18:28 GMT+02:00 Rob Herring <robh@kernel.org>:
> On Thu, May 17, 2018 at 08:59:40PM +0200, Benjamin Gaignard wrote:
>> 2018-05-17 18:23 GMT+02:00 Rob Herring <robh+dt@kernel.org>:
>> > On Wed, May 16, 2018 at 12:51 PM, William Breathitt Gray
>> > <vilhelm.gray@gmail.com> wrote:
>> >> From: Benjamin Gaignard <benjamin.gaignard@st.com>
>> >
>> > v6? Where's v1-v5?
>> >
>> >> Add bindings for STM32 Timer quadrature encoder.
>> >> It is a sub-node of STM32 Timer which implement the
>> >> counter part of the hardware.
>> >>
>> >> Cc: Rob Herring <robh+dt@kernel.org>
>> >> Cc: Mark Rutland <mark.rutland@arm.com>
>> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> >> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>> >> ---
>> >>  .../bindings/counter/stm32-timer-cnt.txt      | 26 +++++++++++++++++++
>> >>  .../devicetree/bindings/mfd/stm32-timers.txt  |  7 +++++
>> >>  2 files changed, 33 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>> >> new file mode 100644
>> >> index 000000000000..377728128bef
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>> >> @@ -0,0 +1,26 @@
>> >> +STMicroelectronics STM32 Timer quadrature encoder
>> >> +
>> >> +STM32 Timer provides quadrature encoder counter mode to detect
>> >
>> > 'mode' does not sound like a sub-block of the timers block.
>>
>> quadrature encoding is one of the counting modes of this hardware
>> block which is enable to count on other signals/triggers
>
> You don't need a child node and compatible to set a mode.

"mode" isn't the good word here because quadratic encoder enable a
sub-block of this hardware.
Timer internal counter input could be internal or external clocks,
some IIO triggers
or the output of the quadratic encoder sub-block.
It is a child like pwm or IIO trigger.

>
>> >> +angular position and direction of rotary elements,
>> >> +from IN1 and IN2 input signals.
>> >> +
>> >> +Must be a sub-node of an STM32 Timer device tree node.
>> >> +See ../mfd/stm32-timers.txt for details about the parent node.
>> >> +
>> >> +Required properties:
>> >> +- compatible:          Must be "st,stm32-timer-counter".
>> >> +- pinctrl-names:       Set to "default".
>> >> +- pinctrl-0:           List of phandles pointing to pin configuration nodes,
>> >> +                       to set IN1/IN2 pins in mode of operation for Low-Power
>> >> +                       Timer input on external pin.
>> >> +
>> >> +Example:
>> >> +       timers@40010000  {
>> >> +               compatible = "st,stm32-timers";
>> >> +               ...
>> >> +               counter {
>> >> +                       compatible = "st,stm32-timer-counter";
>> >
>> > Is there only 1? How is the counter addressed?
>>
>> Yes there is only one counter per hardware block.
>> Counter is addressed like the two others sub-nodes and the details
>> about parent mode are describe in stm32-timers.txt
>> Should I add them here too ? so example will be like that:
>
> No, you should drop the child node and add pinctrl to the parent.
>
> Any other functions this block has that you plan on adding? Please make
> bindings as complete as possible, not what you currently have drivers
> for.

Counter framework didn't exist when I pushed timer node but thanks to
William's effort
it will allow us to use this kindf of hardware

Benjamin

>
>> timers@40010000  {
>>   #address-cells = <1>;
>>   #size-cells = <0>;
>>   compatible = "st,stm32-timers";
>>   reg = <0x40010000 0x400>;
>>   clocks = <&rcc 0 160>;
>>   clock-names = "int";
>>   counter {
>>     compatible = "st,stm32-timer-counter";
>>     pinctrl-names = "default";
>>     pinctrl-0 = <&tim1_in_pins>;
>>     };
>>  };
>>
>> Benjamin
>> >
>> > _______________________________________________
>> > linux-arm-kernel mailing list
>> > linux-arm-kernel@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org │ Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
