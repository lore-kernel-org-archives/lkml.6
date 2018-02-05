Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeBEB6w (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:58:52 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38954 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeBEB6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:58:45 -0500
X-Google-Smtp-Source: AH8x2266Xz+MAGpkDrck1k6PJmVxBDaIT6TvKbtWVqrPoAOfOUp9pcONFI6dmfEuThIjM9YnOBGi9QOYf2g9xStIYeY=
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-17-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-17-ulfalizer@gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 5 Feb 2018 02:58:44 +0100
Message-ID: <CAFkk2KSQ9EBYn0dFhU7qbWXj2nYOu-SL7DfuE99NwiEeOpKBaw@mail.gmail.com>
Subject: Re: [PATCH 16/20] auxdisplay: img-ascii-lcd: Remove MIPS_SEAD3 dep.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        paul.burton@mips.com
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        tfiga@chromium.org, Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, Tony Lindgren <tony@atomide.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> The MIPS_SEAD3 symbol was removed in commit 64601cb1343f ("leds: Remove SEAD-3
> driver").
>
> Remove the MIPS_SEAD3 dependency from IMG_ASCII_LCD.
>
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  drivers/auxdisplay/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 2c2ed9cf8796..3cba78d36eec 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -137,7 +137,7 @@ config CFAG12864B_RATE
>  config IMG_ASCII_LCD
>         tristate "Imagination Technologies ASCII LCD Display"
>         depends on HAS_IOMEM
> -       default y if MIPS_MALTA || MIPS_SEAD3
> +       default y if MIPS_MALTA
>         select SYSCON
>         help
>           Enable this to support the simple ASCII LCD displays found on
> --
> 2.14.1
>

The SYSCON symbol selected here is also globally undefined. Maybe
MFD_SYSCON was intended.

Cheers,
Ulf
