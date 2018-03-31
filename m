Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeCaIiW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 04:38:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37187 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbeCaIiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 04:38:20 -0400
X-Google-Smtp-Source: AIpwx49qP1MAcIXxAdWLCu0Sc3qLhDyom0oWmFLHdefFOQGGM6Bk3DBiZ1PaOtTk+JbXM/nr674Qtg==
Date: Sat, 31 Mar 2018 10:38:16 +0200
From: Ingo Molnar <mingo@kernel.org>
To: yamada.masahiro@socionext.com, tglx@linutronix.de,
        michal.lkml@markovi.net, linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        caoj.fnst@cn.fujitsu.com
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/build] x86/build: Don't pass in -D__KERNEL__ multiple
 times
Message-ID: <20180331083816.mwa4jo7xmuch2vze@gmail.com>
References: <20180316084944.3997-1-caoj.fnst@cn.fujitsu.com>
 <tip-d6289f36aa7d5893d091a7a0c67eee7798719f03@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-d6289f36aa7d5893d091a7a0c67eee7798719f03@git.kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot for Cao jin <tipbot@zytor.com> wrote:

> Commit-ID:  d6289f36aa7d5893d091a7a0c67eee7798719f03
> Gitweb:     https://git.kernel.org/tip/d6289f36aa7d5893d091a7a0c67eee7798719f03
> Author:     Cao jin <caoj.fnst@cn.fujitsu.com>
> AuthorDate: Fri, 16 Mar 2018 16:49:44 +0800
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Sat, 31 Mar 2018 08:02:07 +0200
> 
> x86/build: Don't pass in -D__KERNEL__ multiple times
> 
> Some .<target>.cmd files under arch/x86 are showing two instances of
> -D__KERNEL__, like arch/x86/boot/ and arch/x86/realmode/rm/.
> 
> __KERNEL__ is already defined in KBUILD_CPPFLAGS in the top Makefile,
> so it can be dropped safely.
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kbuild@vger.kernel.org
> Link: http://lkml.kernel.org/r/20180316084944.3997-1-caoj.fnst@cn.fujitsu.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/Makefile                 | 3 +--
>  arch/x86/boot/compressed/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index d798e36d103c..a517852dad55 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -31,8 +31,7 @@ endif
>  CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
>  M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
>  
> -REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -D__KERNEL__ \
> -		   -DDISABLE_BRANCH_PROFILING \
> +REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
>  		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
>  		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
>  		   -mno-mmx -mno-sse
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index f25e1530e064..f484ae0ece93 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -26,7 +26,7 @@ KCOV_INSTRUMENT		:= n
>  targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
>  	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
>  
> -KBUILD_CFLAGS := -m$(BITS) -D__KERNEL__ -O2
> +KBUILD_CFLAGS := -m$(BITS) -O2
>  KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>  cflags-$(CONFIG_X86_32) := -march=i386

Dropped this patch, it's totally untested, the build fails on x86-64 defconfig 
already.

Thanks,

	Ingo
