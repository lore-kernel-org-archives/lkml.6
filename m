Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932468AbeEWKLH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:11:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52402 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932258AbeEWKLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:11:06 -0400
Subject: Re: [PATCH 06/14] arm64: ssbd: Add global mitigation state accessor
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc: Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-7-marc.zyngier@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <af0780d1-5c13-be8f-7401-1c5c54b1dfe0@arm.com>
Date: Wed, 23 May 2018 11:11:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522150648.28297-7-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 05/22/2018 04:06 PM, Marc Zyngier wrote:
> We're about to need the mitigation state in various parts of the
> kernel in order to do the right thing for userspace and guests.
> 
> Let's expose an accessor that will let other subsystems know
> about the state.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Cheers,

> ---
>   arch/arm64/include/asm/cpufeature.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 9bc548e22784..1bacdf57f0af 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -543,6 +543,16 @@ static inline u64 read_zcr_features(void)
>   #define ARM64_SSBD_FORCE_ENABLE		2
>   #define ARM64_SSBD_MITIGATED		3
>   
> +static inline int arm64_get_ssbd_state(void)
> +{
> +#ifdef CONFIG_ARM64_SSBD
> +	extern int ssbd_state;
> +	return ssbd_state;
> +#else
> +	return ARM64_SSBD_UNKNOWN;
> +#endif
> +}
> +
>   #endif /* __ASSEMBLY__ */
>   
>   #endif
> 

-- 
Julien Grall
