Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeEUMGu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:06:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36403 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeEUMGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:06:49 -0400
X-Google-Smtp-Source: AB8JxZrHY74DNIFdQyS/RSvbfGIMxJQVddqi4DGniGcwbO73nHTq/HiVNNtJIeKXDJt9zfib66xooA==
Date: Mon, 21 May 2018 13:06:44 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com, joelaf@google.com, joel.opensrc@gmail.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Subject: Re: [PATCH v3 1/6] arm64: cpufeature: Allow early detect of specific
 features
Message-ID: <20180521120644.g527aawkutf3etzq@holly.lan>
References: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
 <1526902515-13769-2-git-send-email-julien.thierry@arm.com>
 <697af68e-3cee-4d0d-8493-106cc42eed3b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697af68e-3cee-4d0d-8493-106cc42eed3b@arm.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 12:45:22PM +0100, Suzuki K Poulose wrote:
> On 21/05/18 12:35, Julien Thierry wrote:
> > From: Daniel Thompson <daniel.thompson@linaro.org>
> > 
> > Currently it is not possible to detect features of the boot CPU
> > until the other CPUs have been brought up.
> > 
> > This prevents us from reacting to features of the boot CPU until
> > fairly late in the boot process. To solve this we allow a subset
> > of features (that are likely to be common to all clusters) to be
> > detected based on the boot CPU alone.
> > 
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > [julien.thierry@arm.com: check non-boot cpu missing early features, avoid
> > 			 duplicates between early features and normal
> > 			 features]
> > Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> nit: Since this is completely different from what Daniel started with,
> you could simply reset the author to yourself. The boot CPU feature was
> added keeping this user in mind.

Agree! It's no longer my patch.

If you want to retain any credit than Suggested-by: would make quite
sufficient.


Daniel.


> 
> The patch as such looks good to me.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> > ---
> >   arch/arm64/kernel/cpufeature.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 9d1b06d..e03e897 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1030,7 +1030,7 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
> >   	{
> >   		.desc = "GIC system register CPU interface",
> >   		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
> > -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
> >   		.matches = has_useable_gicv3_cpuif,
> >   		.sys_reg = SYS_ID_AA64PFR0_EL1,
> >   		.field_pos = ID_AA64PFR0_GIC_SHIFT,
> > --
> > 1.9.1
> > 
> 
