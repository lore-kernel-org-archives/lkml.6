Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeBHRfd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:35:33 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37200 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeBHRfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:35:31 -0500
X-Google-Smtp-Source: AH8x226dXm/hltQ4nYQV2r9uByQe1B2HsESzZ9Un16VZ6d6BnZmszLKTr5ClGsBk9lyAHrUzEWKYaHP+ingSMZzsU4w=
MIME-Version: 1.0
X-Originating-IP: [212.159.75.221]
In-Reply-To: <20180205012146.23981-17-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-17-ulfalizer@gmail.com>
From: James Hogan <james@albanarts.com>
Date: Thu, 8 Feb 2018 17:35:30 +0000
Message-ID: <CAAG0J98pFG=XFYAzQJ2+hROWWF1C=g-jePk6wh2EXsxX51TGVQ@mail.gmail.com>
Subject: Re: [PATCH 16/20] auxdisplay: img-ascii-lcd: Remove MIPS_SEAD3 dep.
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, Linus Walleij <linus.walleij@linaro.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mel Gorman <mgorman@techsingularity.net>, hch@lst.de,
        mina86@mina86.com, robh@kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>, paulus@ozlabs.org,
        Will Deacon <will.deacon@arm.com>, tony@atomide.com, npiggin@gmail.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 February 2018 at 01:21, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> The MIPS_SEAD3 symbol was removed in commit 64601cb1343f ("leds: Remove SEAD-3
> driver").
>
> Remove the MIPS_SEAD3 dependency from IMG_ASCII_LCD.

Its not a dependency, just a default (presumably so that existing
kernel configs get updated automatically).

Note that sead3 now uses MIPS_GENERIC (or more specifically
CONFIG_LEGACY_BOARD_SEAD3), but this driver is enabled in the config
snippets, e.g.:
arch/mips/configs/generic/board-sead-3.config
arch/mips/configs/generic/board-boston.config

so indeed there is no real need to replace MIPS_SEAD3 with anything here.

Cheers
James

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



-- 
James Hogan
