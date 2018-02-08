Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeBHUvh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:51:37 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46871 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHUvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:51:35 -0500
X-Google-Smtp-Source: AH8x225EnT0FDEGa3XhgA1qRbWEsVY1vpeUGZqJZQuK0UrcXdY2Hyjw2iFyngC831vAJILwuTkuF4w==
Date: Thu, 08 Feb 2018 12:51:33 -0800 (PST)
X-Google-Original-Date: Thu, 08 Feb 2018 10:36:28 PST (-0800)
Subject: Re: [PATCH 07/20] riscv: Remove ARCH_WANT_OPTIONAL_GPIOLIB select
In-Reply-To: <CAFkk2KSUeepo0mSKeV9r2uMO1=euVV2L6QpsMAO0Ew6znG+BRQ@mail.gmail.com>
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
Message-ID: <mhng-300ca2ca-2316-487a-aaa8-9e61b5b67b30@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Feb 2018 17:30:57 PST (-0800), ulfalizer@gmail.com wrote:
> On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> The ARCH_WANT_OPTIONAL_GPIOLIB symbol was removed in commit 65053e1a7743
>> ("gpio: delete ARCH_[WANTS_OPTIONAL|REQUIRE]_GPIOLIB"). GPIOLIB should
>> just be selected explicitly if needed.
>>
>> Remove the ARCH_WANT_OPTIONAL_GPIOLIB select from RISCV.
>>
>> See commit 0145071b3314 ("x86: Do away with
>> ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") and commit da9a1c6767 ("arm64: do
>> away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") as well.
>>
>> Discovered with the
>> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
>> script.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
>>  arch/riscv/Kconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index ff69c77b9e78..716e90e60e5c 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -19,7 +19,6 @@ config RISCV
>>         select GENERIC_STRNLEN_USER
>>         select GENERIC_SMP_IDLE_THREAD
>>         select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
>> -       select ARCH_WANT_OPTIONAL_GPIOLIB
>>         select HAVE_MEMBLOCK
>>         select HAVE_MEMBLOCK_NODE_MAP
>>         select HAVE_DMA_API_DEBUG
>> --
>> 2.14.1
>>
>
> There's also a select of a globally undefined symbol RISCV_IRQ_INTC
> here. I couldn't dig up any historical or unmerged definition for it
> either. Googling just gets you the select.

It looks like this slipped through, the symbol has been renamed RISCV_INTC.  A 
patch to remove it is

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

(and like the other ones, if you want it through my tree just say something)
