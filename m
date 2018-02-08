Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeBHSeY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:34:24 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36791 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeBHSeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:34:20 -0500
X-Google-Smtp-Source: AH8x224914zinsZehvy90aapQ9G89PG19YI8/gqyB7s/BS/vlycUkHqDzLswUigot3/ryQxmSlU/Sw==
Date: Thu, 08 Feb 2018 10:34:19 -0800 (PST)
X-Google-Original-Date: Thu, 08 Feb 2018 10:33:51 PST (-0800)
Subject: Re: [PATCH 07/20] riscv: Remove ARCH_WANT_OPTIONAL_GPIOLIB select
In-Reply-To: <20180205012146.23981-8-ulfalizer@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, Christoph Hellwig <hch@lst.de>,
        mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org,
        paulus@ozlabs.org, Will Deacon <will.deacon@arm.com>, tony@atomide.com,
        npiggin@gmail.com, yamada.masahiro@socionext.com, ulfalizer@gmail.com,
        albert@sifive.com, linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@sifive.com>
To: ulfalizer@gmail.com
Message-ID: <mhng-dc5e58a4-aab6-4d59-bb59-5a5ff20db392@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Feb 2018 17:21:19 PST (-0800), ulfalizer@gmail.com wrote:
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
>  	select GENERIC_STRNLEN_USER
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
> -	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select HAVE_MEMBLOCK
>  	select HAVE_MEMBLOCK_NODE_MAP
>  	select HAVE_DMA_API_DEBUG

Thanks!

(If you want these through my tree, just say something.)

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
