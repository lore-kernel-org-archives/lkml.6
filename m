Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F3BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE3D2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfA1O4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:56:23 -0500
Received: from foss.arm.com ([217.140.101.70]:46776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfA1O4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:56:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B05180D;
        Mon, 28 Jan 2019 06:56:22 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380063F589;
        Mon, 28 Jan 2019 06:56:20 -0800 (PST)
Subject: Re: [kvmtool PATCH v5 6/6] arm/kvm: arm64: Add a vcpu feature for
 pointer authentication
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-7-git-send-email-amit.kachhap@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <175e884b-928e-364b-c784-be2edbcf566d@arm.com>
Date:   Mon, 28 Jan 2019 14:56:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548658727-14271-7-git-send-email-amit.kachhap@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
> This is a runtime feature and can be enabled by --ptrauth option.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arm/aarch32/include/kvm/kvm-cpu-arch.h    | 2 ++
>  arm/aarch64/include/asm/kvm.h             | 3 +++
>  arm/aarch64/include/kvm/kvm-arch.h        | 1 +
>  arm/aarch64/include/kvm/kvm-config-arch.h | 4 +++-
>  arm/aarch64/include/kvm/kvm-cpu-arch.h    | 2 ++
>  arm/aarch64/kvm-cpu.c                     | 5 +++++
>  arm/include/arm-common/kvm-config-arch.h  | 1 +
>  arm/kvm-cpu.c                             | 7 +++++++
>  include/linux/kvm.h                       | 1 +
>  9 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arm/aarch32/include/kvm/kvm-cpu-arch.h b/arm/aarch32/include/kvm/kvm-cpu-arch.h
> index d28ea67..5779767 100644
> --- a/arm/aarch32/include/kvm/kvm-cpu-arch.h
> +++ b/arm/aarch32/include/kvm/kvm-cpu-arch.h
> @@ -13,4 +13,6 @@
>  #define ARM_CPU_ID		0, 0, 0
>  #define ARM_CPU_ID_MPIDR	5
>  
> +unsigned int kvm__cpu_ptrauth_get_feature(void) {}
> +

You probably want a return statement for this function.

>  #endif /* KVM__KVM_CPU_ARCH_H */
> diff --git a/arm/aarch64/include/asm/kvm.h b/arm/aarch64/include/asm/kvm.h
> index c286035..0fd183d 100644
> --- a/arm/aarch64/include/asm/kvm.h
> +++ b/arm/aarch64/include/asm/kvm.h
> @@ -98,6 +98,9 @@ struct kvm_regs {
>  #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
>  #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
>  
> +/* CPU uses address authentication and A key */
> +#define KVM_ARM_VCPU_PTRAUTH		4
> +
>  struct kvm_vcpu_init {
>  	__u32 target;
>  	__u32 features[7];
> diff --git a/arm/aarch64/include/kvm/kvm-arch.h b/arm/aarch64/include/kvm/kvm-arch.h
> index 9de623a..bd566cb 100644
> --- a/arm/aarch64/include/kvm/kvm-arch.h
> +++ b/arm/aarch64/include/kvm/kvm-arch.h
> @@ -11,4 +11,5 @@
>  
>  #include "arm-common/kvm-arch.h"
>  
> +
>  #endif /* KVM__KVM_ARCH_H */
> diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
> index 04be43d..2074684 100644
> --- a/arm/aarch64/include/kvm/kvm-config-arch.h
> +++ b/arm/aarch64/include/kvm/kvm-config-arch.h
> @@ -8,7 +8,9 @@
>  			"Create PMUv3 device"),				\
>  	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
>  			"Specify random seed for Kernel Address Space "	\
> -			"Layout Randomization (KASLR)"),
> +			"Layout Randomization (KASLR)"),		\
> +	OPT_BOOLEAN('\0', "ptrauth", &(cfg)->has_ptrauth,		\
> +			"Enable address authentication"),
>  
>  #include "arm-common/kvm-config-arch.h"
>  
> diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> index a9d8563..f7b64b7 100644
> --- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
> +++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> @@ -17,4 +17,6 @@
>  #define ARM_CPU_CTRL		3, 0, 1, 0
>  #define ARM_CPU_CTRL_SCTLR_EL1	0
>  
> +unsigned int kvm__cpu_ptrauth_get_feature(void);
> +>  #endif /* KVM__KVM_CPU_ARCH_H */
> diff --git a/arm/aarch64/kvm-cpu.c b/arm/aarch64/kvm-cpu.c
> index 1b29374..10da2cb 100644
> --- a/arm/aarch64/kvm-cpu.c
> +++ b/arm/aarch64/kvm-cpu.c
> @@ -123,6 +123,11 @@ void kvm_cpu__reset_vcpu(struct kvm_cpu *vcpu)
>  		return reset_vcpu_aarch64(vcpu);
>  }
>  
> +unsigned int kvm__cpu_ptrauth_get_feature(void)
> +{
> +	return (1UL << KVM_ARM_VCPU_PTRAUTH);
> +}
> +

Couldn't this be a simple:
#define PTRAUTH_FEATURE (1UL << KVM_ARM_VCPU_PTRAUTH)

And just define it to 0 for the aarch32 side?

Cheers,

-- 
Julien Thierry
