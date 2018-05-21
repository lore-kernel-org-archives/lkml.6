Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeEULpa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:45:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47930 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752708AbeEULp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:45:27 -0400
Subject: Re: [PATCH v3 1/6] arm64: cpufeature: Allow early detect of specific
 features
To: Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, christoffer.dall@arm.com, james.morse@arm.com,
        joelaf@google.com, joel.opensrc@gmail.com, daniel.thompson@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com
References: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
 <1526902515-13769-2-git-send-email-julien.thierry@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <697af68e-3cee-4d0d-8493-106cc42eed3b@arm.com>
Date: Mon, 21 May 2018 12:45:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526902515-13769-2-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/18 12:35, Julien Thierry wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Currently it is not possible to detect features of the boot CPU
> until the other CPUs have been brought up.
> 
> This prevents us from reacting to features of the boot CPU until
> fairly late in the boot process. To solve this we allow a subset
> of features (that are likely to be common to all clusters) to be
> detected based on the boot CPU alone.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> [julien.thierry@arm.com: check non-boot cpu missing early features, avoid
> 			 duplicates between early features and normal
> 			 features]
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>

nit: Since this is completely different from what Daniel started with,
you could simply reset the author to yourself. The boot CPU feature was
added keeping this user in mind.

The patch as such looks good to me.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   arch/arm64/kernel/cpufeature.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9d1b06d..e03e897 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1030,7 +1030,7 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
>   	{
>   		.desc = "GIC system register CPU interface",
>   		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
>   		.matches = has_useable_gicv3_cpuif,
>   		.sys_reg = SYS_ID_AA64PFR0_EL1,
>   		.field_pos = ID_AA64PFR0_GIC_SHIFT,
> --
> 1.9.1
> 
