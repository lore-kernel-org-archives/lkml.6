Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeEKMWn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeEKMWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:22:41 -0400
X-Google-Smtp-Source: AB8JxZpAhksO5WppRD2zB6t8on3dUus0jS3NnvoiF1JMYD/8DB0M/Uht2teguj8wTRHaKzyKv+v6vAMbREhroI+uxYs=
MIME-Version: 1.0
In-Reply-To: <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn> <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 11 May 2018 07:22:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLK6S0iA=K1o=gpuJAxD6HxCSzHaJ6ZchuCz=GZ-Zb=Dg@mail.gmail.com>
Message-ID: <CAL_JsqLK6S0iA=K1o=gpuJAxD6HxCSzHaJ6ZchuCz=GZ-Zb=Dg@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] arm64: dts: rockchip: Add gpio-syscon10 to rk3328
To: djw@t-chip.com.cn
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 4:16 AM,  <djw@t-chip.com.cn> wrote:
> From: Levin Du <djw@t-chip.com.cn>
>
> Adding a new gpio controller named "gpio-syscon10" to rk3328, providing
> access to the pins defined in the syscon GRF_SOC_CON10.
>
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
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index b8e9da1..73a822d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -309,6 +309,12 @@
>                         mode-loader = <BOOT_BL_DOWNLOAD>;
>                 };
>
> +               gpio_syscon10: gpio-syscon10 {

GPIO controller nodes should be named just 'gpio'.

> +                       compatible = "rockchip,gpio-syscon";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       gpio,syscon-dev = <0 0x0428 0>;

This property is not documented and takes a phandle.

> +               };
>         };
>
>         uart0: serial@ff110000 {
> --
> 2.7.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
