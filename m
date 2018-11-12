Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4BA2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4BA2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbeKLQiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:38:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:32354 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731284AbeKLQiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:38:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2018 22:45:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,494,1534834800"; 
   d="scan'208";a="95577304"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2018 22:45:42 -0800
Cc:     baolu.lu@linux.intel.com, ashok.raj@intel.com,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [PATCH v2 1/1] iommu/vtd: Cleanup dma_remapping.h header
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20181112064008.2102-1-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f6b5b607-d4f2-197c-bfc2-1b8786c15fcd@linux.intel.com>
Date:   Mon, 12 Nov 2018 14:43:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181112064008.2102-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/12/18 2:40 PM, Lu Baolu wrote:
> Commit e61d98d8dad00 ("x64, x2apic/intr-remap: Intel vt-d, IOMMU
> code reorganization") moved dma_remapping.h from drivers/pci/ to
> current place. It is entirely VT-d specific, but uses a generic
> name. This merges dma_remapping.h with include/linux/intel-iommu.h
> and removes dma_remapping.h as the result.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---

Just realized that I forgot to add the change log.

Change log:
v1->v2:
  - Add "Reviewed-by: Christoph Hellwig <hch@lst.de>"

Sorry about it.

Best regards,
Lu Baolu

>   arch/x86/kernel/tboot.c                    |  2 +-
>   drivers/gpu/drm/i915/i915_gem_execbuffer.c |  2 +-
>   drivers/gpu/drm/i915/intel_display.c       |  2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  2 +-
>   drivers/misc/mic/scif/scif_rma.c           |  2 +-
>   drivers/misc/mic/scif/scif_rma.h           |  2 +-
>   include/linux/dma_remapping.h              | 58 ----------------------
>   include/linux/intel-iommu.h                | 49 +++++++++++++++++-
>   8 files changed, 53 insertions(+), 66 deletions(-)
>   delete mode 100644 include/linux/dma_remapping.h
> 
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index a2486f444073..6e5ef8fb8a02 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -19,7 +19,7 @@
>    *
>    */
>   
> -#include <linux/dma_remapping.h>
> +#include <linux/intel-iommu.h>
>   #include <linux/init_task.h>
>   #include <linux/spinlock.h>
>   #include <linux/export.h>
> diff --git a/drivers/gpu/drm/i915/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> index 09187286d346..d8ccc77fdbaf 100644
> --- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> @@ -26,7 +26,7 @@
>    *
>    */
>   
> -#include <linux/dma_remapping.h>
> +#include <linux/intel-iommu.h>
>   #include <linux/reservation.h>
>   #include <linux/sync_file.h>
>   #include <linux/uaccess.h>
> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index 9741cc419e1b..45334a84fab1 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -47,7 +47,7 @@
>   #include <drm/drm_plane_helper.h>
>   #include <drm/drm_rect.h>
>   #include <drm/drm_atomic_uapi.h>
> -#include <linux/dma_remapping.h>
> +#include <linux/intel-iommu.h>
>   #include <linux/reservation.h>
>   
>   /* Primary plane formats for gen <= 3 */
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 61a84b958d67..c3e80a3b09fc 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -34,7 +34,7 @@
>   #include <drm/ttm/ttm_placement.h>
>   #include <drm/ttm/ttm_bo_driver.h>
>   #include <drm/ttm/ttm_module.h>
> -#include <linux/dma_remapping.h>
> +#include <linux/intel-iommu.h>
>   
>   #define VMWGFX_DRIVER_DESC "Linux drm driver for VMware graphics devices"
>   #define VMWGFX_CHIP_SVGAII 0
> diff --git a/drivers/misc/mic/scif/scif_rma.c b/drivers/misc/mic/scif/scif_rma.c
> index c824329f7012..b441f6b0c743 100644
> --- a/drivers/misc/mic/scif/scif_rma.c
> +++ b/drivers/misc/mic/scif/scif_rma.c
> @@ -15,7 +15,7 @@
>    * Intel SCIF driver.
>    *
>    */
> -#include <linux/dma_remapping.h>
> +#include <linux/intel-iommu.h>
>   #include <linux/pagemap.h>
>   #include <linux/sched/mm.h>
>   #include <linux/sched/signal.h>
> diff --git a/drivers/misc/mic/scif/scif_rma.h b/drivers/misc/mic/scif/scif_rma.h
> index fa6722279196..d90a06d4e93b 100644
> --- a/drivers/misc/mic/scif/scif_rma.h
> +++ b/drivers/misc/mic/scif/scif_rma.h
> @@ -53,7 +53,7 @@
>   #ifndef SCIF_RMA_H
>   #define SCIF_RMA_H
>   
> -#include <linux/dma_remapping.h>
> +#include <linux/intel-iommu.h>
>   #include <linux/mmu_notifier.h>
>   
>   #include "../bus/scif_bus.h"
> diff --git a/include/linux/dma_remapping.h b/include/linux/dma_remapping.h
> deleted file mode 100644
> index 21b3e7d33d68..000000000000
> --- a/include/linux/dma_remapping.h
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _DMA_REMAPPING_H
> -#define _DMA_REMAPPING_H
> -
> -/*
> - * VT-d hardware uses 4KiB page size regardless of host page size.
> - */
> -#define VTD_PAGE_SHIFT		(12)
> -#define VTD_PAGE_SIZE		(1UL << VTD_PAGE_SHIFT)
> -#define VTD_PAGE_MASK		(((u64)-1) << VTD_PAGE_SHIFT)
> -#define VTD_PAGE_ALIGN(addr)	(((addr) + VTD_PAGE_SIZE - 1) & VTD_PAGE_MASK)
> -
> -#define VTD_STRIDE_SHIFT        (9)
> -#define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
> -
> -#define DMA_PTE_READ (1)
> -#define DMA_PTE_WRITE (2)
> -#define DMA_PTE_LARGE_PAGE (1 << 7)
> -#define DMA_PTE_SNP (1 << 11)
> -
> -#define CONTEXT_TT_MULTI_LEVEL	0
> -#define CONTEXT_TT_DEV_IOTLB	1
> -#define CONTEXT_TT_PASS_THROUGH 2
> -/* Extended context entry types */
> -#define CONTEXT_TT_PT_PASID	4
> -#define CONTEXT_TT_PT_PASID_DEV_IOTLB 5
> -#define CONTEXT_TT_MASK (7ULL << 2)
> -
> -#define CONTEXT_DINVE		(1ULL << 8)
> -#define CONTEXT_PRS		(1ULL << 9)
> -#define CONTEXT_PASIDE		(1ULL << 11)
> -
> -struct intel_iommu;
> -struct dmar_domain;
> -struct root_entry;
> -
> -
> -#ifdef CONFIG_INTEL_IOMMU
> -extern int iommu_calculate_agaw(struct intel_iommu *iommu);
> -extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
> -extern int dmar_disabled;
> -extern int intel_iommu_enabled;
> -extern int intel_iommu_tboot_noforce;
> -#else
> -static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
> -{
> -	return 0;
> -}
> -static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
> -{
> -	return 0;
> -}
> -#define dmar_disabled	(1)
> -#define intel_iommu_enabled (0)
> -#endif
> -
> -
> -#endif
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index b0ae25837361..a58bc05d6798 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -26,7 +26,6 @@
>   #include <linux/iova.h>
>   #include <linux/io.h>
>   #include <linux/idr.h>
> -#include <linux/dma_remapping.h>
>   #include <linux/mmu_notifier.h>
>   #include <linux/list.h>
>   #include <linux/iommu.h>
> @@ -37,9 +36,36 @@
>   #include <asm/iommu.h>
>   
>   /*
> - * Intel IOMMU register specification per version 1.0 public spec.
> + * VT-d hardware uses 4KiB page size regardless of host page size.
>    */
> +#define VTD_PAGE_SHIFT		(12)
> +#define VTD_PAGE_SIZE		(1UL << VTD_PAGE_SHIFT)
> +#define VTD_PAGE_MASK		(((u64)-1) << VTD_PAGE_SHIFT)
> +#define VTD_PAGE_ALIGN(addr)	(((addr) + VTD_PAGE_SIZE - 1) & VTD_PAGE_MASK)
> +
> +#define VTD_STRIDE_SHIFT        (9)
> +#define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
> +
> +#define DMA_PTE_READ (1)
> +#define DMA_PTE_WRITE (2)
> +#define DMA_PTE_LARGE_PAGE (1 << 7)
> +#define DMA_PTE_SNP (1 << 11)
> +
> +#define CONTEXT_TT_MULTI_LEVEL	0
> +#define CONTEXT_TT_DEV_IOTLB	1
> +#define CONTEXT_TT_PASS_THROUGH 2
> +/* Extended context entry types */
> +#define CONTEXT_TT_PT_PASID	4
> +#define CONTEXT_TT_PT_PASID_DEV_IOTLB 5
> +#define CONTEXT_TT_MASK (7ULL << 2)
> +
> +#define CONTEXT_DINVE		(1ULL << 8)
> +#define CONTEXT_PRS		(1ULL << 9)
> +#define CONTEXT_PASIDE		(1ULL << 11)
>   
> +/*
> + * Intel IOMMU register specification per version 1.0 public spec.
> + */
>   #define	DMAR_VER_REG	0x0	/* Arch version supported by this IOMMU */
>   #define	DMAR_CAP_REG	0x8	/* Hardware supported capabilities */
>   #define	DMAR_ECAP_REG	0x10	/* Extended capabilities supported */
> @@ -632,4 +658,23 @@ bool context_present(struct context_entry *context);
>   struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>   					 u8 devfn, int alloc);
>   
> +#ifdef CONFIG_INTEL_IOMMU
> +extern int iommu_calculate_agaw(struct intel_iommu *iommu);
> +extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
> +extern int dmar_disabled;
> +extern int intel_iommu_enabled;
> +extern int intel_iommu_tboot_noforce;
> +#else
> +static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
> +{
> +	return 0;
> +}
> +static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
> +{
> +	return 0;
> +}
> +#define dmar_disabled	(1)
> +#define intel_iommu_enabled (0)
> +#endif
> +
>   #endif
> 
