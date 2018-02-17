Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750980AbeBQAcO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 19:32:14 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41804 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbeBQAcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 19:32:12 -0500
X-Google-Smtp-Source: AH8x2270Yq482ilufLHVXH2kPukP/qEqPenuLcDyKOav4jghJUcZyuqIqgwlyxq2xOJMEdXcDyxN3A==
Date: Fri, 16 Feb 2018 16:32:11 -0800 (PST)
X-Google-Original-Date: Fri, 16 Feb 2018 16:32:09 PST (-0800)
Subject: Re: [PATCH] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
In-Reply-To: <20180213224937.GF4290@saruman>
CC: matt.redfearn@mips.com, antonynpavlov@gmail.com,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: jhogan@kernel.org
Message-ID: <mhng-e6250604-af06-4308-abe1-b5bc8f4c8b75@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 14:49:37 PST (-0800), jhogan@kernel.org wrote:
> On Tue, Feb 13, 2018 at 01:48:18PM -0800, Palmer Dabbelt wrote:
>> On Fri, 09 Feb 2018 05:22:52 PST (-0800), matt.redfearn@mips.com wrote:
>> > When these are included into arch Kconfig files, maintaining
>> > alphabetical ordering of the selects means these get split up. To allow
>> > for keeping things tidier and alphabetical, rename the selects to
>> > GENERIC_LIB_*
>> >
>> > Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>> 
>> Thanks!  Do you want me to take this in my tree?
>> 
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> Since a new version of the "MIPS: use generic GCC library routines from
> lib/" series would depend on it, and it makes sense for that series to
> go via the MIPS tree, I think it would be simpler for this patch to also
> be taken (with your ack) via the MIPS tree. Is that okay?

That's great, thanks!

>
> Thanks
> James
>
>> 
>> > ---
>> >  arch/riscv/Kconfig |  6 +++---
>> >  lib/Kconfig        | 12 ++++++------
>> >  lib/Makefile       | 12 ++++++------
>> >  3 files changed, 15 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index 2c6adf12713a..5f1e2188d029 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -99,9 +99,9 @@ config ARCH_RV32I
>> >  	bool "RV32I"
>> >  	select CPU_SUPPORTS_32BIT_KERNEL
>> >  	select 32BIT
>> > -	select GENERIC_ASHLDI3
>> > -	select GENERIC_ASHRDI3
>> > -	select GENERIC_LSHRDI3
>> > +	select GENERIC_LIB_ASHLDI3
>> > +	select GENERIC_LIB_ASHRDI3
>> > +	select GENERIC_LIB_LSHRDI3
>> >
>> >  config ARCH_RV64I
>> >  	bool "RV64I"
>> > diff --git a/lib/Kconfig b/lib/Kconfig
>> > index c5e84fbcb30b..946d0890aad6 100644
>> > --- a/lib/Kconfig
>> > +++ b/lib/Kconfig
>> > @@ -584,20 +584,20 @@ config STRING_SELFTEST
>> >
>> >  endmenu
>> >
>> > -config GENERIC_ASHLDI3
>> > +config GENERIC_LIB_ASHLDI3
>> >  	bool
>> >
>> > -config GENERIC_ASHRDI3
>> > +config GENERIC_LIB_ASHRDI3
>> >  	bool
>> >
>> > -config GENERIC_LSHRDI3
>> > +config GENERIC_LIB_LSHRDI3
>> >  	bool
>> >
>> > -config GENERIC_MULDI3
>> > +config GENERIC_LIB_MULDI3
>> >  	bool
>> >
>> > -config GENERIC_CMPDI2
>> > +config GENERIC_LIB_CMPDI2
>> >  	bool
>> >
>> > -config GENERIC_UCMPDI2
>> > +config GENERIC_LIB_UCMPDI2
>> >  	bool
>> > diff --git a/lib/Makefile b/lib/Makefile
>> > index d11c48ec8ffd..7e1ef77e86a3 100644
>> > --- a/lib/Makefile
>> > +++ b/lib/Makefile
>> > @@ -252,9 +252,9 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
>> >  obj-$(CONFIG_PARMAN) += parman.o
>> >
>> >  # GCC library routines
>> > -obj-$(CONFIG_GENERIC_ASHLDI3) += ashldi3.o
>> > -obj-$(CONFIG_GENERIC_ASHRDI3) += ashrdi3.o
>> > -obj-$(CONFIG_GENERIC_LSHRDI3) += lshrdi3.o
>> > -obj-$(CONFIG_GENERIC_MULDI3) += muldi3.o
>> > -obj-$(CONFIG_GENERIC_CMPDI2) += cmpdi2.o
>> > -obj-$(CONFIG_GENERIC_UCMPDI2) += ucmpdi2.o
>> > +obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
>> > +obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
>> > +obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
>> > +obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
>> > +obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>> > +obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
