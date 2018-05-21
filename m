Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeEUHg7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 03:36:59 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40640 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeEUHgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 03:36:55 -0400
X-Google-Smtp-Source: AB8JxZrqB28xv4WQZhoobEeO1WaN9pfEH18z0ThKnWBWbwF4h80ZkeqC0Sv7127PFIZJ6Twp1Pcfqw==
Subject: Re: [PATCH v1 4/5] ARM: tegra: Don't apply CPU erratas in insecure
 mode
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20180520101542.12206-1-digetx@gmail.com>
 <20180520101542.12206-5-digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <57fceed2-6ca4-8dcf-dd0c-5e4432c086b9@gmail.com>
Date: Mon, 21 May 2018 10:36:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180520101542.12206-5-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.2018 13:15, Dmitry Osipenko wrote:
> CPU isn't allowed to touch secure registers while running under secure
> monitor. Hence skip applying CPU erratas in the reset handler if Trusted
> Foundations firmware presents.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/reset-handler.S | 27 +++++++++++++++++++--------
>  arch/arm/mach-tegra/reset.c         |  3 +++
>  arch/arm/mach-tegra/reset.h         |  4 +++-
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
> index 805f306fa6f7..d84c74a95806 100644
> --- a/arch/arm/mach-tegra/reset-handler.S
> +++ b/arch/arm/mach-tegra/reset-handler.S
> @@ -121,6 +121,12 @@ ENTRY(__tegra_cpu_reset_handler)
>  	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
>  
>  	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
> +
> +	adr	r12, __tegra_cpu_reset_handler_data
> +	ldr	r0, [r12, #RESET_DATA(TF_PRESENT)]
> +	cmp	r0, #0
> +	bne	after_errata
> +
>  #ifdef CONFIG_ARCH_TEGRA_2x_SOC
>  t20_check:
>  	cmp	r6, #TEGRA20
> @@ -155,7 +161,6 @@ after_errata:
>  	and	r10, r10, #0x3			@ R10 = CPU number
>  	mov	r11, #1
>  	mov	r11, r11, lsl r10  		@ R11 = CPU mask
> -	adr	r12, __tegra_cpu_reset_handler_data
>  
>  #ifdef CONFIG_SMP
>  	/* Does the OS know about this CPU? */
> @@ -169,10 +174,9 @@ after_errata:
>  	cmp	r6, #TEGRA20
>  	bne	1f
>  	/* If not CPU0, don't let CPU0 reset CPU1 now that CPU1 is coming up. */
> -	mov32	r5, TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET
>  	mov	r0, #CPU_NOT_RESETTABLE
>  	cmp	r10, #0
> -	strneb	r0, [r5, #__tegra20_cpu1_resettable_status_offset]
> +	strneb	r0, [r12, #RESET_DATA(RESETTABLE_STATUS)]
>  1:
>  #endif
>  
> @@ -278,13 +282,20 @@ ENDPROC(__tegra_cpu_reset_handler)
>  	.type	__tegra_cpu_reset_handler_data, %object
>  	.globl	__tegra_cpu_reset_handler_data
>  __tegra_cpu_reset_handler_data:
> -	.rept	TEGRA_RESET_DATA_SIZE
> -	.long	0
> -	.endr
> +	.long	0	/* TEGRA_RESET_MASK_PRESENT */
> +	.long	0	/* TEGRA_RESET_MASK_LP1 */
> +	.long	0	/* TEGRA_RESET_MASK_LP2 */
> +	.long	0	/* TEGRA_RESET_STARTUP_SECONDARY */
> +	.long	0	/* TEGRA_RESET_STARTUP_LP2 */
> +	.long	0	/* TEGRA_RESET_STARTUP_LP1 */
> +
>  	.globl	__tegra20_cpu1_resettable_status_offset
>  	.equ	__tegra20_cpu1_resettable_status_offset, \
>  					. - __tegra_cpu_reset_handler_start
> -	.byte	0
> -	.align L1_CACHE_SHIFT
> +	.long	0	/* TEGRA_RESET_RESETTABLE_STATUS */
>  
> +	.globl	__tegra_tf_present
> +	.equ	__tegra_tf_present, . - __tegra_cpu_reset_handler_start

I've noticed that __tegra_tf_present shouldn't belong to this patch, I've missed
to remove it while was rebasing.

Also, it occurred to me that it will be much better to remove the whole array
__tegra_cpu_reset_handler_data definition in the asm and get back to the
original ".rept   TEGRA_RESET_DATA_SIZE" instead. That will make this part of
code much nicer, I'll change that in v2.

Russell / Thierry, please give you acks-reviews where appropriate and let me
know if I should change anything else in v2, thanks.

> +	.long	0	/* TEGRA_RESET_TF_PRESENT */
> +	.align L1_CACHE_SHIFT
>  ENTRY(__tegra_cpu_reset_handler_end)
> diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
> index dc558892753c..b02ae7699842 100644
> --- a/arch/arm/mach-tegra/reset.c
> +++ b/arch/arm/mach-tegra/reset.c
> @@ -24,6 +24,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/firmware.h>
>  #include <asm/hardware/cache-l2x0.h>
> +#include <asm/trusted_foundations.h>
>  
>  #include "iomap.h"
>  #include "irammap.h"
> @@ -89,6 +90,8 @@ static void __init tegra_cpu_reset_handler_enable(void)
>  
>  void __init tegra_cpu_reset_handler_init(void)
>  {
> +	__tegra_cpu_reset_handler_data[TEGRA_RESET_TF_PRESENT] =
> +		trusted_foundations_registered();
>  
>  #ifdef CONFIG_SMP
>  	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
> diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
> index 9c479c7925b8..0d9ddc022ece 100644
> --- a/arch/arm/mach-tegra/reset.h
> +++ b/arch/arm/mach-tegra/reset.h
> @@ -25,7 +25,9 @@
>  #define TEGRA_RESET_STARTUP_SECONDARY	3
>  #define TEGRA_RESET_STARTUP_LP2		4
>  #define TEGRA_RESET_STARTUP_LP1		5
> -#define TEGRA_RESET_DATA_SIZE		6
> +#define TEGRA_RESET_RESETTABLE_STATUS	6
> +#define TEGRA_RESET_TF_PRESENT		7
> +#define TEGRA_RESET_DATA_SIZE		8
>  
>  #ifndef __ASSEMBLY__
>  
> 
