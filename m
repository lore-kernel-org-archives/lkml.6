Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14878C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAEC2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAEC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeIFH0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:26:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:4599 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbeIFH0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:26:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 19:53:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="68742364"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 05 Sep 2018 19:53:04 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 03/12] iommu/vt-d: Move page table helpers into header
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-4-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A9F@SHSMSX101.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <08966280-44db-a9a8-bc54-93f698c87823@linux.intel.com>
Date:   Thu, 6 Sep 2018 10:52:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A9F@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/06/2018 10:15 AM, Tian, Kevin wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Thursday, August 30, 2018 9:35 AM
>>
>> So that they could also be used in other source files.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thank you, Kevin.

Best regards,
Lu Baolu

> 
>> ---
>>   drivers/iommu/intel-iommu.c | 43 -------------------------------------
>>   include/linux/intel-iommu.h | 43
>> +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 43 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index b0da4f765274..93cde957adc7 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -315,49 +315,6 @@ static inline void context_clear_entry(struct
>> context_entry *context)
>>   	context->hi = 0;
>>   }
>>
>> -/*
>> - * 0: readable
>> - * 1: writable
>> - * 2-6: reserved
>> - * 7: super page
>> - * 8-10: available
>> - * 11: snoop behavior
>> - * 12-63: Host physcial address
>> - */
>> -struct dma_pte {
>> -	u64 val;
>> -};
>> -
>> -static inline void dma_clear_pte(struct dma_pte *pte)
>> -{
>> -	pte->val = 0;
>> -}
>> -
>> -static inline u64 dma_pte_addr(struct dma_pte *pte)
>> -{
>> -#ifdef CONFIG_64BIT
>> -	return pte->val & VTD_PAGE_MASK;
>> -#else
>> -	/* Must have a full atomic 64-bit read */
>> -	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
>> -#endif
>> -}
>> -
>> -static inline bool dma_pte_present(struct dma_pte *pte)
>> -{
>> -	return (pte->val & 3) != 0;
>> -}
>> -
>> -static inline bool dma_pte_superpage(struct dma_pte *pte)
>> -{
>> -	return (pte->val & DMA_PTE_LARGE_PAGE);
>> -}
>> -
>> -static inline int first_pte_in_page(struct dma_pte *pte)
>> -{
>> -	return !((unsigned long)pte & ~VTD_PAGE_MASK);
>> -}
>> -
>>   /*
>>    * This domain is a statically identity mapping domain.
>>    *	1. This domain creats a static 1:1 mapping to all usable memory.
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 2173ae35f1dc..41791903a5e3 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -501,6 +501,49 @@ static inline void __iommu_flush_cache(
>>   		clflush_cache_range(addr, size);
>>   }
>>
>> +/*
>> + * 0: readable
>> + * 1: writable
>> + * 2-6: reserved
>> + * 7: super page
>> + * 8-10: available
>> + * 11: snoop behavior
>> + * 12-63: Host physcial address
>> + */
>> +struct dma_pte {
>> +	u64 val;
>> +};
>> +
>> +static inline void dma_clear_pte(struct dma_pte *pte)
>> +{
>> +	pte->val = 0;
>> +}
>> +
>> +static inline u64 dma_pte_addr(struct dma_pte *pte)
>> +{
>> +#ifdef CONFIG_64BIT
>> +	return pte->val & VTD_PAGE_MASK;
>> +#else
>> +	/* Must have a full atomic 64-bit read */
>> +	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
>> +#endif
>> +}
>> +
>> +static inline bool dma_pte_present(struct dma_pte *pte)
>> +{
>> +	return (pte->val & 3) != 0;
>> +}
>> +
>> +static inline bool dma_pte_superpage(struct dma_pte *pte)
>> +{
>> +	return (pte->val & DMA_PTE_LARGE_PAGE);
>> +}
>> +
>> +static inline int first_pte_in_page(struct dma_pte *pte)
>> +{
>> +	return !((unsigned long)pte & ~VTD_PAGE_MASK);
>> +}
>> +
>>   extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct
>> pci_dev *dev);
>>   extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
>>
>> --
>> 2.17.1
> 
> 
