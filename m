Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBHPhR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:37:17 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39599 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBHPhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:37:15 -0500
X-Google-Smtp-Source: AH8x225eDPuF36Xv5E4K4Ohyd2e8+GIq7O9PFdw9dpWrdb3SUQLAiF0hs6HCd70y/oSo/YStjVf9LGUqmXWbM3YL56Y=
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-17-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-17-ulfalizer@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 8 Feb 2018 16:37:14 +0100
Message-ID: <CANiq72kaCDcUHFuJ0P4CA-0KGgg+a8T+66p0aPwatAjfvDB8bA@mail.gmail.com>
Subject: Re: [PATCH 16/20] auxdisplay: img-ascii-lcd: Remove MIPS_SEAD3 dep.
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
        m.szyprowski@samsung.com, egtvedt@samfundet.no,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> The MIPS_SEAD3 symbol was removed in commit 64601cb1343f ("leds: Remove SEAD-3
> driver").

Commit 64601cb1343f did not remove the MIPS_SEAD3 symbol, it seemed to
a few months before, in 3f5f0a4475e1 ("MIPS: generic: Convert SEAD-3
to a generic board"). Can you please amend the description?

Thanks!
Miguel

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
