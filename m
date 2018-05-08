Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754882AbeEHMmY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:42:24 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52450 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbeEHMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:42:22 -0400
Date: Tue, 8 May 2018 13:42:00 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: maxime.ripard@bootlin.com, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com, f.fainelli@gmail.com,
        opendmb@gmail.com, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 01/12] ARM: Allow this header to be included by
 assembly files
Message-ID: <20180508124200.GM16141@n2100.armlinux.org.uk>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
 <20180504190545.5114-2-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180504190545.5114-2-mylene.josserand@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 09:05:34PM +0200, Mylène Josserand wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> The constants defined in this file are equally useful in assembly and C
> source files. The arm64 architecture version of this file allows
> inclusion in both assembly and C source files, so this this commit adds
> that capability to the arm architecture version so that the constants
> don't need to be defined in multiple places.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

> ---
>  arch/arm/include/asm/cputype.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index cb546425da8a..e7632f536633 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -2,9 +2,6 @@
>  #ifndef __ASM_ARM_CPUTYPE_H
>  #define __ASM_ARM_CPUTYPE_H
>  
> -#include <linux/stringify.h>
> -#include <linux/kernel.h>
> -
>  #define CPUID_ID	0
>  #define CPUID_CACHETYPE	1
>  #define CPUID_TCM	2
> @@ -98,6 +95,11 @@
>  /* Qualcomm implemented cores */
>  #define ARM_CPU_PART_SCORPION		0x510002d0
>  
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/stringify.h>
> +#include <linux/kernel.h>
> +
>  extern unsigned int processor_id;
>  
>  #ifdef CONFIG_CPU_CP15
> @@ -326,4 +328,6 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
>  #define cpuid_feature_extract(reg, field) \
>  	cpuid_feature_extract_field(read_cpuid_ext(reg), field)
>  
> +#endif /* __ASSEMBLY__ */
> +
>  #endif
> -- 
> 2.11.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
