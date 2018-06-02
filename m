Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeFBIkv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 04:40:51 -0400
Received: from regular1.263xmail.com ([211.150.99.138]:45033 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeFBIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 04:40:45 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 59.33.104.134
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <66e0ebf9ac15318dfb91fe6dff89df78>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
References: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn> <1527737273-8387-3-git-send-email-djw@t-chip.com.cn> <CAL_JsqJK4vrmLBeN_ZeGCXAyqshshL16B0KN_+8uvt+=-O9TEw@mail.gmail.com> <0d08ba26-77f2-6c42-8fb1-214aaf6085e9@t-chip.com.cn> <CAL_JsqKSy4q5dfVfXbRMLa7koTWufpAt3yNdE-9mwyJ-VzVQRQ@mail.gmail.com>
User-agent: mu4e 1.0; emacs 25.3.1
From: Levin Du <djw@t-chip.com.cn>
To: Rob Herring <robh+dt@kernel.org>
Cc: "open list\:ARM\/Rockchip SoC..."
        <linux-rockchip@lists.infradead.org>,
        Wayne Chou <zxf@t-chip.com.cn>, Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list\:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/5] gpio: syscon: rockchip: add GPIO_MUTE support for rk3328
In-reply-to: <CAL_JsqKSy4q5dfVfXbRMLa7koTWufpAt3yNdE-9mwyJ-VzVQRQ@mail.gmail.com>
Date: Sat, 02 Jun 2018 16:40:09 +0800
Message-ID: <87zi0d8tue.fsf@t-chip.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob Herring <robh+dt@kernel.org> writes:

> On Thu, May 31, 2018 at 9:05 PM, Levin <djw@t-chip.com.cn> 
> wrote:
>> Hi Rob,
>>
>>
>> On 2018-05-31 10:45 PM, Rob Herring wrote:
>>>
>>> On Wed, May 30, 2018 at 10:27 PM,  <djw@t-chip.com.cn> wrote:
>>>>
>>>> From: Levin Du <djw@t-chip.com.cn>
>>>>
>>>> In Rockchip RK3328, the output only GPIO_MUTE pin, originally 
>>>> for codec
>>>> mute control, can also be used for general purpose. It is 
>>>> manipulated by
>>>> the GRF_SOC_CON10 register.
>>>>
>>>> Signed-off-by: Levin Du <djw@t-chip.com.cn>
>>>>
>>>> ---
>>>>
>>>> Changes in v3:
>>>> - Change from general gpio-syscon to specific 
>>>> rk3328-gpio-mute
>>>>
>>>> Changes in v2:
>>>> - Rename gpio_syscon10 to gpio_mute in doc
>>>>
>>>> Changes in v1:
>>>> - Refactured for general gpio-syscon usage for Rockchip SoCs.
>>>> - Add doc rockchip,gpio-syscon.txt
>>>>
>>>>   .../bindings/gpio/rockchip,rk3328-gpio-mute.txt    | 28
>>>> +++++++++++++++++++
>>>>   drivers/gpio/gpio-syscon.c                         | 31
>>>> ++++++++++++++++++++++
>>>>   2 files changed, 59 insertions(+)
>>>>   create mode 100644
>>>> Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
>>>> b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
>>>> new file mode 100644
>>>> index 0000000..10bc632
>>>> --- /dev/null
>>>> +++
>>>> b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
>>>> @@ -0,0 +1,28 @@
>>>> +Rockchip RK3328 GPIO controller dedicated for the GPIO_MUTE 
>>>> pin.
>>>> +
>>>> +In Rockchip RK3328, the output only GPIO_MUTE pin, 
>>>> originally for codec
>>>> mute
>>>> +control, can also be used for general purpose. It is 
>>>> manipulated by the
>>>> +GRF_SOC_CON10 register.
>>>> +
>>>> +Required properties:
>>>> +- compatible: Should contain "rockchip,rk3328-gpio-mute".
>>>> +- gpio-controller: Marks the device node as a gpio 
>>>> controller.
>>>> +- #gpio-cells: Should be 2. The first cell is the pin number 
>>>> and
>>>> +  the second cell is used to specify the gpio polarity:
>>>> +    0 = Active high,
>>>> +    1 = Active low.
>>>> +
>>>> +Example:
>>>> +
>>>> +       grf: syscon@ff100000 {
>>>> +               compatible = "rockchip,rk3328-grf", "syscon",
>>>> "simple-mfd";
>>>> +
>>>> +               gpio_mute: gpio-mute {
>>>
>>> Node names should be generic:
>>>
>>> gpio {
>>>
>>> This also means you can't add another GPIO node in the future 
>>> and
>>> you'll have to live with "rockchip,rk3328-gpio-mute" covering 
>>> more
>>> than 1 GPIO if you do need to add more GPIOs.
>>
>>
>> As the first line describes, this GPIO controller is dedicated 
>> for the
>> GPIO_MUTE pin.
>> There's only one GPIO pin in the GRF_SOC_CON10 register. 
>> Therefore the
>> gpio_mute
>> name is proper IMHO.
>
> It's how many GPIOs in the GRF, not this register. What I'm 
> saying is
> when you come along later to add another GPIO in the GRF, you 
> had
> better just add it to this same node. I'm not going to accept 
> another
> GPIO controller node within the GRF. You have the cells to 
> support
> more than 1, so it would only be a driver change. The compatible
> string would then not be ideally named at that point. But 
> compatible
> strings are just unique identifiers, so it doesn't really matter 
> what
> the string is.
>

I'll try my best to introduce the situation here. The GRF, 
GPIO0~GPIO3
are register blocks in the RK3328 Soc. The GPIO0~GPIO3 contain 
registers
for GPIO operations like reading/writing data, setting direction,
interruption etc, which corresponds to the GPIO banks 
(gpio0~gpio3)
defined in rk3328.dtsi:

	pinctrl: pinctrl {
		compatible = "rockchip,rk3328-pinctrl";
		rockchip,grf = <&grf>;
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;

		gpio0: gpio0@ff210000 {
			compatible = "rockchip,gpio-bank";
			reg = <0x0 0xff210000 0x0 0x100>;
			interrupts = <GIC_SPI 51 
			IRQ_TYPE_LEVEL_HIGH>;
			clocks = <&cru PCLK_GPIO0>;

			gpio-controller;
			#gpio-cells = <2>;

			interrupt-controller;
			#interrupt-cells = <2>;
		};

		gpio1: gpio1@ff220000 {
                //...
		};

		gpio2: gpio2@ff230000 {
                //...
		};

		gpio3: gpio3@ff240000 {
                //...
		};
         }

However, these general GPIO pins has multiplexed functions and 
their
pull up/down and driving strength can also be configured. These 
settings
are manipulated by the GRF registers in pinctrl driver. Quoted 
from the
TRM, the GRF has the following function:

 - IOMUX control
 - Control the state of GPIO in power-down mode
 - GPIO PAD pull down and pull up control
 - Used for common system control
 - Used to record the system state

Therefore the functions of the GRF are messy and scattered in 
different
nodes. The so-called GPIO_MUTE does not belong to GPIO0~GPIO3. It 
is
manipulated by the GRF_SOC_CON10 register in the GRF block.

> I'm being told both "this is the only GPIO" and "the GRF has too 
> many
> different functions for us to tell you what they all are". So 
> which is
> it?
>
> Rob

They are both true, but lack of context. See the above 
description.

Thanks,
Levin
