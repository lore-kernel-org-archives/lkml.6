Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeENB3G (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 21:29:06 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:39885 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbeENB3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 21:29:05 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 59.33.107.123
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <0400f9a35006a6ef6da6b3ffc794e228>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
Subject: Re: [PATCH v1 3/5] arm64: dts: rockchip: Add gpio-syscon10 to rk3328
To: Rob Herring <robh+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Wayne Chou <zxf@t-chip.com.cn>, Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        William Wu <william.wu@rock-chips.com>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
 <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
 <76f2bbde-e158-a186-f136-9fb610a810c5@arm.com>
 <3fdfcc9b-90b5-191c-37e0-c99389a4e872@t-chip.com.cn>
 <CAL_JsqLujC0nx9LpkWuSR0+fsZn4UJL9Ln6SHWyBmZ-7ErMzfw@mail.gmail.com>
From: Levin Du <djw@t-chip.com.cn>
Message-ID: <62ff43c8-8f98-1bc4-b208-c2bed4bf192e@t-chip.com.cn>
Date: Mon, 14 May 2018 09:28:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLujC0nx9LpkWuSR0+fsZn4UJL9Ln6SHWyBmZ-7ErMzfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-11 8:24 PM, Rob Herring wrote:
> On Thu, May 10, 2018 at 10:45 PM, Levin Du <djw@t-chip.com.cn> wrote:
>> On 2018-05-10 8:50 PM, Robin Murphy wrote:
>>> On 10/05/18 10:16, djw@t-chip.com.cn wrote:
>>>> From: Levin Du <djw@t-chip.com.cn>
>>>>
>>>> Adding a new gpio controller named "gpio-syscon10" to rk3328, providing
>>>> access to the pins defined in the syscon GRF_SOC_CON10.
>>>
>>> This is the GPIO_MUTE pin, right? The public TRM is rather vague, but
>>> cross-referencing against the datasheet and schematics implies that it's the
>>> "gpiomut_*" part of the GRF bit names which is most significant.
>>>
>>> It might be worth using a more descriptive name here, since "syscon10" is
>>> pretty much meaningless at the board level.
>>>
>>> Robin.
>>>
>> Previously I though other bits might be able to reference from syscon10,
>> other than GPIO_MUTE alone.
>> If it is renamed to gpio-mute, then the GPIO_MUTE pin is accessed as
>> `<&gpio-mute 1>`. Yet other
>> bits in syscon10 can also be referenced, say, `<&gpio-mute 10>`, which is
>> not good.
>>
>> I'd like to add a `gpio,syscon-bit` property to gpio-syscon, which overrides
>> the properties
>> of bit_count,  data_bit_offset and dir_bit_offset in the driver. For
> No. Once you are describing individual register bits, it is too low
> level for DT.

Okay. So I'll rename it to gpio_mute, and reference the output pin as 
<&gpio_mute 1>:

+               // Use <&gpio_mute 1> to ref to GPIO_MUTE pin
+		gpio_mute: gpio-mute {
+			compatible = "rockchip,gpio-syscon";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <0 0x0428 0>;
+		};
  	};


Thanks
Levin
