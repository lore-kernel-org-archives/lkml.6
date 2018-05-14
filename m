Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeENBXD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 21:23:03 -0400
Received: from regular1.263xmail.com ([211.150.99.130]:38599 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbeENBXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 21:23:02 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 183.57.25.242
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <190720c9aa907ec11ddbf1dbe58729fc>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v1 3/5] arm64: dts: rockchip: Add gpio-syscon10 to rk3328
To: Rob Herring <robh+dt@kernel.org>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wayne Chou <zxf@t-chip.com.cn>, Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org, David Wu <david.wu@rock-chips.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        William Wu <william.wu@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
 <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
 <CAL_JsqLK6S0iA=K1o=gpuJAxD6HxCSzHaJ6ZchuCz=GZ-Zb=Dg@mail.gmail.com>
From: Levin Du <djw@t-chip.com.cn>
Message-ID: <5218da3c-40d3-a44f-2b82-13cd4c522a1f@t-chip.com.cn>
Date: Mon, 14 May 2018 09:22:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLK6S0iA=K1o=gpuJAxD6HxCSzHaJ6ZchuCz=GZ-Zb=Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-05-11 8:22 PM, Rob Herring wrote:
> On Thu, May 10, 2018 at 4:16 AM,  <djw@t-chip.com.cn> wrote:
>> From: Levin Du <djw@t-chip.com.cn>
>>
>> Adding a new gpio controller named "gpio-syscon10" to rk3328, providing
>> access to the pins defined in the syscon GRF_SOC_CON10.
>>
>> Boards using these special pins to control regulators or LEDs, can now
>> utilize existing drivers like gpio-regulator and leds-gpio.
>>
>> Signed-off-by: Levin Du <djw@t-chip.com.cn>
>>
>> ---
>>
>> Changes in v1:
>> - Split from V0 and add to rk3328.dtsi for general use.
>>
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> index b8e9da1..73a822d 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> @@ -309,6 +309,12 @@
>>                          mode-loader = <BOOT_BL_DOWNLOAD>;
>>                  };
>>
>> +               gpio_syscon10: gpio-syscon10 {
> GPIO controller nodes should be named just 'gpio'.

'gpio' is a general name, and there're already gpio0~gpio3 for pinctrl 
GPIOs.

>> +                       compatible = "rockchip,gpio-syscon";
>> +                       gpio-controller;
>> +                       #gpio-cells = <2>;
>> +                       gpio,syscon-dev = <0 0x0428 0>;
> This property is not documented and takes a phandle.
See PATCH1 which allows fetching syscon from parent node .
This is also documented in 
Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
in PATCH2.

Thanks
Levin
