Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CA0C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F2920652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F2920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeIFGuW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:50:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:8615 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeIFGuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:50:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 19:17:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="87583677"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga001.fm.intel.com with ESMTP; 05 Sep 2018 19:15:31 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 5 Sep 2018 19:15:31 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 5 Sep 2018 19:15:30 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.150]) with mapi id 14.03.0319.002;
 Thu, 6 Sep 2018 10:15:28 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 03/12] iommu/vt-d: Move page table helpers into header
Thread-Topic: [PATCH v2 03/12] iommu/vt-d: Move page table helpers into
 header
Thread-Index: AQHUQAHvQ6+D9j7BN0OKWrCwSnidcqTijsnA
Date:   Thu, 6 Sep 2018 02:15:27 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A9F@SHSMSX101.ccr.corp.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-4-baolu.lu@linux.intel.com>
In-Reply-To: <20180830013524.28743-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzViYWViNWMtMGVhOS00ZWM1LTkyOGItMjQ1MTVjNWNiM2UyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTFRuV1wvb3BMV05jUnJET0l5dFwvZjd6NjNqNXYzQVUwSlF1U0Y0eHpNK3lmKzFVXC9uWkRxUWJqMzF1bklEREdUWiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Thursday, August 30, 2018 9:35 AM
> 
> So that they could also be used in other source files.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  drivers/iommu/intel-iommu.c | 43 -------------------------------------
>  include/linux/intel-iommu.h | 43
> +++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index b0da4f765274..93cde957adc7 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -315,49 +315,6 @@ static inline void context_clear_entry(struct
> context_entry *context)
>  	context->hi = 0;
>  }
> 
> -/*
> - * 0: readable
> - * 1: writable
> - * 2-6: reserved
> - * 7: super page
> - * 8-10: available
> - * 11: snoop behavior
> - * 12-63: Host physcial address
> - */
> -struct dma_pte {
> -	u64 val;
> -};
> -
> -static inline void dma_clear_pte(struct dma_pte *pte)
> -{
> -	pte->val = 0;
> -}
> -
> -static inline u64 dma_pte_addr(struct dma_pte *pte)
> -{
> -#ifdef CONFIG_64BIT
> -	return pte->val & VTD_PAGE_MASK;
> -#else
> -	/* Must have a full atomic 64-bit read */
> -	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
> -#endif
> -}
> -
> -static inline bool dma_pte_present(struct dma_pte *pte)
> -{
> -	return (pte->val & 3) != 0;
> -}
> -
> -static inline bool dma_pte_superpage(struct dma_pte *pte)
> -{
> -	return (pte->val & DMA_PTE_LARGE_PAGE);
> -}
> -
> -static inline int first_pte_in_page(struct dma_pte *pte)
> -{
> -	return !((unsigned long)pte & ~VTD_PAGE_MASK);
> -}
> -
>  /*
>   * This domain is a statically identity mapping domain.
>   *	1. This domain creats a static 1:1 mapping to all usable memory.
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 2173ae35f1dc..41791903a5e3 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -501,6 +501,49 @@ static inline void __iommu_flush_cache(
>  		clflush_cache_range(addr, size);
>  }
> 
> +/*
> + * 0: readable
> + * 1: writable
> + * 2-6: reserved
> + * 7: super page
> + * 8-10: available
> + * 11: snoop behavior
> + * 12-63: Host physcial address
> + */
> +struct dma_pte {
> +	u64 val;
> +};
> +
> +static inline void dma_clear_pte(struct dma_pte *pte)
> +{
> +	pte->val = 0;
> +}
> +
> +static inline u64 dma_pte_addr(struct dma_pte *pte)
> +{
> +#ifdef CONFIG_64BIT
> +	return pte->val & VTD_PAGE_MASK;
> +#else
> +	/* Must have a full atomic 64-bit read */
> +	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
> +#endif
> +}
> +
> +static inline bool dma_pte_present(struct dma_pte *pte)
> +{
> +	return (pte->val & 3) != 0;
> +}
> +
> +static inline bool dma_pte_superpage(struct dma_pte *pte)
> +{
> +	return (pte->val & DMA_PTE_LARGE_PAGE);
> +}
> +
> +static inline int first_pte_in_page(struct dma_pte *pte)
> +{
> +	return !((unsigned long)pte & ~VTD_PAGE_MASK);
> +}
> +
>  extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct
> pci_dev *dev);
>  extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
> 
> --
> 2.17.1

