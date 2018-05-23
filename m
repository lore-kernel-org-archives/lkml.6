Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932454AbeEWKGO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:06:14 -0400
Received: from foss.arm.com ([217.140.101.70]:52286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932258AbeEWKGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:06:12 -0400
Subject: Re: [PATCH 04/14] arm64: Add ARCH_WORKAROUND_2 probing
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc: Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-5-marc.zyngier@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <0f980dce-170e-1d43-5927-c5d508839001@arm.com>
Date: Wed, 23 May 2018 11:06:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522150648.28297-5-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 05/22/2018 04:06 PM, Marc Zyngier wrote:
> As for Spectre variant-2, we rely on SMCCC 1.1 to provide the
> discovery mechanism for detecting the SSBD mitigation.
> 
> A new capability is also allocated for that purpose, and a
> config option.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm64/Kconfig               |  9 ++++++
>   arch/arm64/include/asm/cpucaps.h |  3 +-
>   arch/arm64/kernel/cpu_errata.c   | 69 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index eb2cf4938f6d..b2103b4df467 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -938,6 +938,15 @@ config HARDEN_EL2_VECTORS
>   
>   	  If unsure, say Y.
>   
> +config ARM64_SSBD
> +	bool "Speculative Store Bypass Disable" if EXPERT
> +	default y
> +	help
> +	  This enables mitigation of the bypassing of previous stores
> +	  by speculative loads.
> +
> +	  If unsure, say Y.
> +
>   menuconfig ARMV8_DEPRECATED
>   	bool "Emulate deprecated/obsolete ARMv8 instructions"
>   	depends on COMPAT
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index bc51b72fafd4..5b2facf786ba 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -48,7 +48,8 @@
>   #define ARM64_HAS_CACHE_IDC			27
>   #define ARM64_HAS_CACHE_DIC			28
>   #define ARM64_HW_DBM				29
> +#define ARM64_SSBD			30

NIT: Could you indent 30 the same way as the other number?

Reviewed-by: Julien Grall <julien.grall@arm.com>

Cheers,

-- 
Julien Grall
