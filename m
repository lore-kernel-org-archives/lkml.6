Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeBEBbR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:31:17 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41937 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeBEBa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:30:59 -0500
X-Google-Smtp-Source: AH8x225PslVZEvVM3aCfG/wsPi6rUvPqr0sAxID6nWwbP3Z3eHggEvJc5bkfqun/7I9EyqploB04w80vFkbxioC8eOU=
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-8-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-8-ulfalizer@gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 5 Feb 2018 02:30:57 +0100
Message-ID: <CAFkk2KSUeepo0mSKeV9r2uMO1=euVV2L6QpsMAO0Ew6znG+BRQ@mail.gmail.com>
Subject: Re: [PATCH 07/20] riscv: Remove ARCH_WANT_OPTIONAL_GPIOLIB select
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, Linus Walleij <linus.walleij@linaro.org>,
        vgupta@synopsys.com, mgorman@techsingularity.net, hch@lst.de,
        mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org,
        paulus@ozlabs.org, will.deacon@arm.com, tony@atomide.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> The ARCH_WANT_OPTIONAL_GPIOLIB symbol was removed in commit 65053e1a7743
> ("gpio: delete ARCH_[WANTS_OPTIONAL|REQUIRE]_GPIOLIB"). GPIOLIB should
> just be selected explicitly if needed.
>
> Remove the ARCH_WANT_OPTIONAL_GPIOLIB select from RISCV.
>
> See commit 0145071b3314 ("x86: Do away with
> ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") and commit da9a1c6767 ("arm64: do
> away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") as well.
>
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  arch/riscv/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ff69c77b9e78..716e90e60e5c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -19,7 +19,6 @@ config RISCV
>         select GENERIC_STRNLEN_USER
>         select GENERIC_SMP_IDLE_THREAD
>         select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
> -       select ARCH_WANT_OPTIONAL_GPIOLIB
>         select HAVE_MEMBLOCK
>         select HAVE_MEMBLOCK_NODE_MAP
>         select HAVE_DMA_API_DEBUG
> --
> 2.14.1
>

There's also a select of a globally undefined symbol RISCV_IRQ_INTC
here. I couldn't dig up any historical or unmerged definition for it
either. Googling just gets you the select.

Cheers,
Ulf
