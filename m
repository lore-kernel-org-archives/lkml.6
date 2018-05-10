Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935471AbeEJMux (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:50:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55496 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757217AbeEJMuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:50:52 -0400
Subject: Re: [PATCH v1 3/5] arm64: dts: rockchip: Add gpio-syscon10 to rk3328
To: djw@t-chip.com.cn, linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Wayne Chou <zxf@t-chip.com.cn>, Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        William Wu <william.wu@rock-chips.com>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
 <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <76f2bbde-e158-a186-f136-9fb610a810c5@arm.com>
Date: Thu, 10 May 2018 13:50:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/18 10:16, djw@t-chip.com.cn wrote:
> From: Levin Du <djw@t-chip.com.cn>
> 
> Adding a new gpio controller named "gpio-syscon10" to rk3328, providing
> access to the pins defined in the syscon GRF_SOC_CON10.

This is the GPIO_MUTE pin, right? The public TRM is rather vague, but 
cross-referencing against the datasheet and schematics implies that it's 
the "gpiomut_*" part of the GRF bit names which is most significant.

It might be worth using a more descriptive name here, since "syscon10" 
is pretty much meaningless at the board level.

Robin.

> Boards using these special pins to control regulators or LEDs, can now
> utilize existing drivers like gpio-regulator and leds-gpio.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> 
> ---
> 
> Changes in v1:
> - Split from V0 and add to rk3328.dtsi for general use.
> 
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index b8e9da1..73a822d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -309,6 +309,12 @@
>   			mode-loader = <BOOT_BL_DOWNLOAD>;
>   		};
>   
> +		gpio_syscon10: gpio-syscon10 {
> +			compatible = "rockchip,gpio-syscon";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <0 0x0428 0>;
> +		};
>   	};
>   
>   	uart0: serial@ff110000 {
> 
