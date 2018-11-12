Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67787C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3792F2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3792F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeKLLLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:11:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:55903 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeKLLLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:11:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2018 17:20:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,493,1534834800"; 
   d="scan'208";a="95502808"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2018 17:20:20 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [PATCH 1/1] iommu/vtd: Cleanup dma_remapping.h header
To:     Christoph Hellwig <hch@infradead.org>
References: <20181110070844.28353-1-baolu.lu@linux.intel.com>
 <20181110083506.GB28614@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <518f02b4-8c4f-9451-68f1-cb014c4cc6eb@linux.intel.com>
Date:   Mon, 12 Nov 2018 09:17:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181110083506.GB28614@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/10/18 4:35 PM, Christoph Hellwig wrote:
> On Sat, Nov 10, 2018 at 03:08:44PM +0800, Lu Baolu wrote:
>> Commit e61d98d8dad00 ("x64, x2apic/intr-remap: Intel vt-d, IOMMU
>> code reorganization") moved dma_remapping.h from drivers/pci/ to
>> current place. It is entirely VT-d specific, but uses a generic
>> name. This merges dma_remapping.h with include/linux/intel-iommu.h
>> and removes dma_remapping.h as the result.
> 
> This looks fine to me, thanks for doing the work.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you.

> 
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> @@ -34,7 +34,7 @@
>>   #include <drm/ttm/ttm_placement.h>
>>   #include <drm/ttm/ttm_bo_driver.h>
>>   #include <drm/ttm/ttm_module.h>
>> -#include <linux/dma_remapping.h>
>> +#include <linux/intel-iommu.h>
> 
> Btw, I don't think this driver has any business looking at Intel
> IOMMU driver internals, and the code doing so is more than gross.
> 
> Not really your job, but vmw_dma_select_mode really needs a rewrite with
> someone that has at least half a clue, and some taste.
> 
> Eventually we should also drop the intel_iommu_enabled export.
> 

Yes. Fair enough.

Best regards,
Lu Baolu
