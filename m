Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660AEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1815B21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dv0+q00f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfBKQlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:41:52 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:58720 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfBKQlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:41:52 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 1BB6010C06E4;
        Mon, 11 Feb 2019 08:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549903311; bh=fBVZ5ijoAMyIT1n3yfPcdbUEUPLWh1eYHuDbKsa91gs=;
        h=From:To:CC:Subject:Date:References:From;
        b=dv0+q00fCFs4pjqEqjDW022Gj86wwmenhj7sxULppaLz9XTmnE1qwPgO+M5Snnh/5
         3yAejhcnKuMHGnBULPbnX5bzljCKSP4D603vWHfQexIM/1JWUk5hSbU94MKZDRmI/I
         59fXoxelopUD8kIBH9nnPjP7ck59qYrprejFu0XXCSEiIM/Yv5eg5ckhefoU6u7zpO
         /jdc9ueytJT0JXdDaOni0f1/lGpIbm3ScBESJXngF58eOBW515ceZnB0NG13BDusPf
         y+j8X5QjGliAATvF9a0v53fn1F1n1Ych188DsPxayjsZkOYknUv8iMQXuzN/u+Y7eb
         ii535rHZSmDpg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3013DA005A;
        Mon, 11 Feb 2019 16:41:49 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 11 Feb 2019 08:41:49 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>
CC:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dma-mapping: add a kconfig symbol for
 arch_setup_dma_ops availability
Thread-Topic: [PATCH 1/2] dma-mapping: add a kconfig symbol for
 arch_setup_dma_ops availability
Thread-Index: AQHUvGGrA+k+qWH4WEmqF3XgiW9roA==
Date:   Mon, 11 Feb 2019 16:41:49 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146433294@US01WEMBX2.internal.synopsys.com>
References: <20190204081420.15083-1-hch@lst.de>
 <20190204081420.15083-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Eugeniy=0A=
=0A=
As resident ARC DMA expert can you please this a quick spin.=0A=
=0A=
-Vineet=0A=
=0A=
On 2/4/19 12:14 AM, Christoph Hellwig wrote:=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  arch/arc/Kconfig                     |  1 +=0A=
>  arch/arc/include/asm/Kbuild          |  1 +=0A=
>  arch/arc/include/asm/dma-mapping.h   | 13 -------------=0A=
>  arch/arm/Kconfig                     |  1 +=0A=
>  arch/arm/include/asm/dma-mapping.h   |  4 ----=0A=
>  arch/arm64/Kconfig                   |  1 +=0A=
>  arch/arm64/include/asm/dma-mapping.h |  4 ----=0A=
>  arch/mips/Kconfig                    |  1 +=0A=
>  arch/mips/include/asm/dma-mapping.h  | 10 ----------=0A=
>  arch/mips/mm/dma-noncoherent.c       |  8 ++++++++=0A=
>  include/linux/dma-mapping.h          | 12 ++++++++----=0A=
>  kernel/dma/Kconfig                   |  3 +++=0A=
>  12 files changed, 24 insertions(+), 35 deletions(-)=0A=
>  delete mode 100644 arch/arc/include/asm/dma-mapping.h=0A=
>=0A=
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig=0A=
> index 376366a7db81..2ab27d88eb1c 100644=0A=
> --- a/arch/arc/Kconfig=0A=
> +++ b/arch/arc/Kconfig=0A=
> @@ -11,6 +11,7 @@ config ARC=0A=
>  	select ARC_TIMERS=0A=
>  	select ARCH_HAS_DMA_COHERENT_TO_PFN=0A=
>  	select ARCH_HAS_PTE_SPECIAL=0A=
> +	select ARCH_HAS_SETUP_DMA_OPS=0A=
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU=0A=
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE=0A=
>  	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC=0A=
> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild=0A=
> index caa270261521..b41f8881ecc8 100644=0A=
> --- a/arch/arc/include/asm/Kbuild=0A=
> +++ b/arch/arc/include/asm/Kbuild=0A=
> @@ -3,6 +3,7 @@ generic-y +=3D bugs.h=0A=
>  generic-y +=3D compat.h=0A=
>  generic-y +=3D device.h=0A=
>  generic-y +=3D div64.h=0A=
> +generic-y +=3D dma-mapping.h=0A=
>  generic-y +=3D emergency-restart.h=0A=
>  generic-y +=3D extable.h=0A=
>  generic-y +=3D ftrace.h=0A=
> diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dm=
a-mapping.h=0A=
> deleted file mode 100644=0A=
> index c946c0a83e76..000000000000=0A=
> --- a/arch/arc/include/asm/dma-mapping.h=0A=
> +++ /dev/null=0A=
> @@ -1,13 +0,0 @@=0A=
> -// SPDX-License-Identifier:  GPL-2.0=0A=
> -// (C) 2018 Synopsys, Inc. (www.synopsys.com)=0A=
> -=0A=
> -#ifndef ASM_ARC_DMA_MAPPING_H=0A=
> -#define ASM_ARC_DMA_MAPPING_H=0A=
> -=0A=
> -#include <asm-generic/dma-mapping.h>=0A=
> -=0A=
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,=0A=
> -			const struct iommu_ops *iommu, bool coherent);=0A=
> -#define arch_setup_dma_ops arch_setup_dma_ops=0A=
> -=0A=
> -#endif=0A=
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig=0A=
> index 664e918e2624..c1cf44f00870 100644=0A=
> --- a/arch/arm/Kconfig=0A=
> +++ b/arch/arm/Kconfig=0A=
> @@ -12,6 +12,7 @@ config ARM=0A=
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE=0A=
>  	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE=0A=
>  	select ARCH_HAS_PHYS_TO_DMA=0A=
> +	select ARCH_HAS_SETUP_DMA_OPS=0A=
>  	select ARCH_HAS_SET_MEMORY=0A=
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL=0A=
>  	select ARCH_HAS_STRICT_MODULE_RWX if MMU=0A=
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dm=
a-mapping.h=0A=
> index 31d3b96f0f4b..a224b6e39e58 100644=0A=
> --- a/arch/arm/include/asm/dma-mapping.h=0A=
> +++ b/arch/arm/include/asm/dma-mapping.h=0A=
> @@ -96,10 +96,6 @@ static inline unsigned long dma_max_pfn(struct device =
*dev)=0A=
>  }=0A=
>  #define dma_max_pfn(dev) dma_max_pfn(dev)=0A=
>  =0A=
> -#define arch_setup_dma_ops arch_setup_dma_ops=0A=
> -extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 siz=
e,=0A=
> -			       const struct iommu_ops *iommu, bool coherent);=0A=
> -=0A=
>  #ifdef CONFIG_MMU=0A=
>  #define arch_teardown_dma_ops arch_teardown_dma_ops=0A=
>  extern void arch_teardown_dma_ops(struct device *dev);=0A=
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig=0A=
> index a4168d366127..63909f318d56 100644=0A=
> --- a/arch/arm64/Kconfig=0A=
> +++ b/arch/arm64/Kconfig=0A=
> @@ -22,6 +22,7 @@ config ARM64=0A=
>  	select ARCH_HAS_KCOV=0A=
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE=0A=
>  	select ARCH_HAS_PTE_SPECIAL=0A=
> +	select ARCH_HAS_SETUP_DMA_OPS=0A=
>  	select ARCH_HAS_SET_MEMORY=0A=
>  	select ARCH_HAS_STRICT_KERNEL_RWX=0A=
>  	select ARCH_HAS_STRICT_MODULE_RWX=0A=
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/as=
m/dma-mapping.h=0A=
> index 95dbf3ef735a..de96507ee2c1 100644=0A=
> --- a/arch/arm64/include/asm/dma-mapping.h=0A=
> +++ b/arch/arm64/include/asm/dma-mapping.h=0A=
> @@ -29,10 +29,6 @@ static inline const struct dma_map_ops *get_arch_dma_o=
ps(struct bus_type *bus)=0A=
>  	return NULL;=0A=
>  }=0A=
>  =0A=
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,=0A=
> -			const struct iommu_ops *iommu, bool coherent);=0A=
> -#define arch_setup_dma_ops	arch_setup_dma_ops=0A=
> -=0A=
>  #ifdef CONFIG_IOMMU_DMA=0A=
>  void arch_teardown_dma_ops(struct device *dev);=0A=
>  #define arch_teardown_dma_ops	arch_teardown_dma_ops=0A=
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig=0A=
> index 0d14f51d0002..dc5d70f674e0 100644=0A=
> --- a/arch/mips/Kconfig=0A=
> +++ b/arch/mips/Kconfig=0A=
> @@ -1118,6 +1118,7 @@ config DMA_MAYBE_COHERENT=0A=
>  =0A=
>  config DMA_PERDEV_COHERENT=0A=
>  	bool=0A=
> +	select ARCH_HAS_SETUP_DMA_OPS=0A=
>  	select DMA_NONCOHERENT=0A=
>  =0A=
>  config DMA_NONCOHERENT=0A=
> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/=
dma-mapping.h=0A=
> index 20dfaad3a55d..34de7b17b41b 100644=0A=
> --- a/arch/mips/include/asm/dma-mapping.h=0A=
> +++ b/arch/mips/include/asm/dma-mapping.h=0A=
> @@ -15,14 +15,4 @@ static inline const struct dma_map_ops *get_arch_dma_o=
ps(struct bus_type *bus)=0A=
>  #endif=0A=
>  }=0A=
>  =0A=
> -#define arch_setup_dma_ops arch_setup_dma_ops=0A=
> -static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,=
=0A=
> -				      u64 size, const struct iommu_ops *iommu,=0A=
> -				      bool coherent)=0A=
> -{=0A=
> -#ifdef CONFIG_DMA_PERDEV_COHERENT=0A=
> -	dev->dma_coherent =3D coherent;=0A=
> -#endif=0A=
> -}=0A=
> -=0A=
>  #endif /* _ASM_DMA_MAPPING_H */=0A=
> diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoheren=
t.c=0A=
> index cb38461391cb..0606fc87b294 100644=0A=
> --- a/arch/mips/mm/dma-noncoherent.c=0A=
> +++ b/arch/mips/mm/dma-noncoherent.c=0A=
> @@ -159,3 +159,11 @@ void arch_dma_cache_sync(struct device *dev, void *v=
addr, size_t size,=0A=
>  =0A=
>  	dma_sync_virt(vaddr, size, direction);=0A=
>  }=0A=
> +=0A=
> +#ifdef CONFIG_DMA_PERDEV_COHERENT=0A=
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,=0A=
> +		const struct iommu_ops *iommu, bool coherent)=0A=
> +{=0A=
> +	dev->dma_coherent =3D coherent;=0A=
> +}=0A=
> +#endif=0A=
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h=0A=
> index b904d55247ab..2b20d60e6158 100644=0A=
> --- a/include/linux/dma-mapping.h=0A=
> +++ b/include/linux/dma-mapping.h=0A=
> @@ -671,11 +671,15 @@ static inline int dma_coerce_mask_and_coherent(stru=
ct device *dev, u64 mask)=0A=
>  	return dma_set_mask_and_coherent(dev, mask);=0A=
>  }=0A=
>  =0A=
> -#ifndef arch_setup_dma_ops=0A=
> +#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS=0A=
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,=0A=
> +		const struct iommu_ops *iommu, bool coherent);=0A=
> +#else=0A=
>  static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,=
=0A=
> -				      u64 size, const struct iommu_ops *iommu,=0A=
> -				      bool coherent) { }=0A=
> -#endif=0A=
> +		u64 size, const struct iommu_ops *iommu, bool coherent)=0A=
> +{=0A=
> +}=0A=
> +#endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */=0A=
>  =0A=
>  #ifndef arch_teardown_dma_ops=0A=
>  static inline void arch_teardown_dma_ops(struct device *dev) { }=0A=
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig=0A=
> index ca88b867e7fe..c44599d128e8 100644=0A=
> --- a/kernel/dma/Kconfig=0A=
> +++ b/kernel/dma/Kconfig=0A=
> @@ -19,6 +19,9 @@ config ARCH_HAS_DMA_COHERENCE_H=0A=
>  config HAVE_GENERIC_DMA_COHERENT=0A=
>  	bool=0A=
>  =0A=
> +config ARCH_HAS_SETUP_DMA_OPS=0A=
> +	bool=0A=
> +=0A=
>  config ARCH_HAS_SYNC_DMA_FOR_DEVICE=0A=
>  	bool=0A=
>  =0A=
=0A=
