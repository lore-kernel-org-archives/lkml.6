Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeC2Bnr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 21:43:47 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37080 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751167AbeC2Bnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 21:43:46 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38303239"
Subject: Re: [PATCH] x86/build: drop a superfluous macro
From: Cao jin <caoj.fnst@cn.fujitsu.com>
To: <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
References: <20180316084944.3997-1-caoj.fnst@cn.fujitsu.com>
Message-ID: <fb8f9dc9-69f9-6142-55f0-cf479c71e08d@cn.fujitsu.com>
Date: Thu, 29 Mar 2018 09:43:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316084944.3997-1-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: AAA824D0EFCD.AC1A3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On 03/16/2018 04:49 PM, Cao jin wrote:
> Some .<target>.cmd files under arch/x86 report -D__KERNEL__ appears two
> times in the command line, like arch/x86/boot, arch/x86/realmode/rm.
> It is already defined in KBUILD_CPPFLAGS from top Makefile. so it can be
> dropped saftely from these Makefiles.
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  arch/x86/Makefile                 | 3 +--
>  arch/x86/boot/compressed/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index a20eacd9c7e9..592489a15d94 100644
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
> index 4b7575b00563..78e3400c22d7 100644
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
> 

-- 
Sincerely,
Cao jin
