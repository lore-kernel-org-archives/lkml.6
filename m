Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046BFC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E6620666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E6620666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJBDuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:50:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51068 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJBDuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:50:12 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g75SU-0007VW-Qz; Mon, 01 Oct 2018 21:10:27 +0000
Subject: Re: [PATCH security-next v3 06/29] vmlinux.lds.h: Move LSM_TABLE into
 INIT_DATA
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     linux-arch@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-7-keescook@chromium.org>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <e95b8a6d-b2df-e4c4-aa98-9b85e587626e@canonical.com>
Date:   Mon, 1 Oct 2018 14:10:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925001832.18322-7-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> Since the struct lsm_info table is not an initcall, we can just move it
> into INIT_DATA like all the other tables.
> 
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>  arch/arc/kernel/vmlinux.lds.S        |  1 -
>  arch/arm/kernel/vmlinux-xip.lds.S    |  1 -
>  arch/arm64/kernel/vmlinux.lds.S      |  1 -
>  arch/h8300/kernel/vmlinux.lds.S      |  1 -
>  arch/microblaze/kernel/vmlinux.lds.S |  2 --
>  arch/powerpc/kernel/vmlinux.lds.S    |  2 --
>  arch/um/include/asm/common.lds.S     |  2 --
>  arch/xtensa/kernel/vmlinux.lds.S     |  1 -
>  include/asm-generic/vmlinux.lds.h    | 24 +++++++++++-------------
>  9 files changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
> index f35ed578e007..8fb16bdabdcf 100644
> --- a/arch/arc/kernel/vmlinux.lds.S
> +++ b/arch/arc/kernel/vmlinux.lds.S
> @@ -71,7 +71,6 @@ SECTIONS
>  		INIT_SETUP(L1_CACHE_BYTES)
>  		INIT_CALLS
>  		CON_INITCALL
> -		SECURITY_INITCALL
>  	}
>  
>  	.init.arch.info : {
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 3593d5c1acd2..8c74037ade22 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -96,7 +96,6 @@ SECTIONS
>  		INIT_SETUP(16)
>  		INIT_CALLS
>  		CON_INITCALL
> -		SECURITY_INITCALL
>  		INIT_RAM_FS
>  	}
>  
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 605d1b60469c..7d23d591b03c 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -166,7 +166,6 @@ SECTIONS
>  		INIT_SETUP(16)
>  		INIT_CALLS
>  		CON_INITCALL
> -		SECURITY_INITCALL
>  		INIT_RAM_FS
>  		*(.init.rodata.* .init.bss)	/* from the EFI stub */
>  	}
> diff --git a/arch/h8300/kernel/vmlinux.lds.S b/arch/h8300/kernel/vmlinux.lds.S
> index 35716a3048de..49f716c0a1df 100644
> --- a/arch/h8300/kernel/vmlinux.lds.S
> +++ b/arch/h8300/kernel/vmlinux.lds.S
> @@ -56,7 +56,6 @@ SECTIONS
>  	__init_begin = .;
>  	INIT_TEXT_SECTION(4)
>  	INIT_DATA_SECTION(4)
> -	SECURITY_INIT
>  	__init_end = .;
>  	_edata = . ;
>  	_begin_data = LOADADDR(.data);
> diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
> index 289d0e7f3e3a..e1f3e8741292 100644
> --- a/arch/microblaze/kernel/vmlinux.lds.S
> +++ b/arch/microblaze/kernel/vmlinux.lds.S
> @@ -117,8 +117,6 @@ SECTIONS {
>  		CON_INITCALL
>  	}
>  
> -	SECURITY_INIT
> -
>  	__init_end_before_initramfs = .;
>  
>  	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 07ae018e550e..105a976323aa 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -212,8 +212,6 @@ SECTIONS
>  		CON_INITCALL
>  	}
>  
> -	SECURITY_INIT
> -
>  	. = ALIGN(8);
>  	__ftr_fixup : AT(ADDR(__ftr_fixup) - LOAD_OFFSET) {
>  		__start___ftr_fixup = .;
> diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
> index 7adb4e6b658a..4049f2c46387 100644
> --- a/arch/um/include/asm/common.lds.S
> +++ b/arch/um/include/asm/common.lds.S
> @@ -53,8 +53,6 @@
>  	CON_INITCALL
>    }
>  
> -  SECURITY_INIT
> -
>    .exitcall : {
>  	__exitcall_begin = .;
>  	*(.exitcall.exit)
> diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
> index a1c3edb8ad56..b727b18a68ac 100644
> --- a/arch/xtensa/kernel/vmlinux.lds.S
> +++ b/arch/xtensa/kernel/vmlinux.lds.S
> @@ -197,7 +197,6 @@ SECTIONS
>      INIT_SETUP(XCHAL_ICACHE_LINESIZE)
>      INIT_CALLS
>      CON_INITCALL
> -    SECURITY_INITCALL
>      INIT_RAM_FS
>    }
>  
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5079a969e612..b31ea8bdfef9 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -203,6 +203,15 @@
>  #define EARLYCON_TABLE()
>  #endif
>  
> +#ifdef CONFIG_SECURITY
> +#define LSM_TABLE()	. = ALIGN(8);					\
> +			__start_lsm_info = .;				\
> +			KEEP(*(.lsm_info.init))				\
> +			__end_lsm_info = .;
> +#else
> +#define LSM_TABLE()
> +#endif
> +
>  #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
>  #define __OF_TABLE(cfg, name)	___OF_TABLE(cfg, name)
>  #define OF_TABLE(cfg, name)	__OF_TABLE(IS_ENABLED(cfg), name)
> @@ -597,7 +606,8 @@
>  	IRQCHIP_OF_MATCH_TABLE()					\
>  	ACPI_PROBE_TABLE(irqchip)					\
>  	ACPI_PROBE_TABLE(timer)						\
> -	EARLYCON_TABLE()
> +	EARLYCON_TABLE()						\
> +	LSM_TABLE()
>  
>  #define INIT_TEXT							\
>  	*(.init.text .init.text.*)					\
> @@ -786,17 +796,6 @@
>  		KEEP(*(.con_initcall.init))				\
>  		__con_initcall_end = .;
>  
> -#define SECURITY_INITCALL						\
> -		__start_lsm_info = .;					\
> -		KEEP(*(.lsm_info.init))					\
> -		__end_lsm_info = .;
> -
> -/* Older linker script style for security init. */
> -#define SECURITY_INIT							\
> -	.lsm_info.init : AT(ADDR(.lsm_info.init) - LOAD_OFFSET) {	\
> -		LSM_INFO						\
> -	}
> -
>  #ifdef CONFIG_BLK_DEV_INITRD
>  #define INIT_RAM_FS							\
>  	. = ALIGN(4);							\
> @@ -963,7 +962,6 @@
>  		INIT_SETUP(initsetup_align)				\
>  		INIT_CALLS						\
>  		CON_INITCALL						\
> -		SECURITY_INITCALL					\
>  		INIT_RAM_FS						\
>  	}
>  
> 

