Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeCEKWp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:22:45 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36057 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbeCEKWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:22:41 -0500
X-Google-Smtp-Source: AG47ELsRGLaDBUm5NolbDbK78TPi76D6O2ntMfF7+Rraae8cGxdxbWoQbMQj+j1JiQm4vKMcAmey77ZNUES8pvgUpkM=
MIME-Version: 1.0
In-Reply-To: <20180302035102.10084-4-jeffy.chen@rock-chips.com>
References: <20180302035102.10084-1-jeffy.chen@rock-chips.com> <20180302035102.10084-4-jeffy.chen@rock-chips.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Mon, 5 Mar 2018 11:22:39 +0100
Message-ID: <CAFqH_50YFm7EYEtt=9AoCUwvVU+Vuw51PYx=hF_u=KBgKmPTDg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: Avoid wakeup when inserting
 the pen
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@google.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Dmitry Torokhov <dtor@google.com>, Doug Anderson <dianders@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Yao <markyao0591@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy,

Thanks for the patch.

2018-03-02 4:51 GMT+01:00 Jeffy Chen <jeffy.chen@rock-chips.com>:
> Add wakeup event action for Pen Insert gpio key, to avoid wakeup when
> inserting the pen.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v3: None
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
>
>  arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> index 191a6bcb1704..ef2de0057c5c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> @@ -134,6 +134,8 @@
>                 gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
>                 linux,code = <SW_PEN_INSERTED>;
>                 linux,input-type = <EV_SW>;
> +               /* Wakeup only when ejecting */
> +               wakeup-event-action = <EV_ACT_DEASSERTED>;
>                 wakeup-source;
>         };
>  };
> --
> 2.11.0
>
>

Works as expected on my Kevin

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
