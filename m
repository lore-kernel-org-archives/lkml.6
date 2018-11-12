Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BA3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFCA22353
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFCA22353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeKLR1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:27:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:53474 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbeKLR1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:27:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2018 23:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,494,1534834800"; 
   d="scan'208";a="95609361"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2018 23:35:04 -0800
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v2 1/1] iommu/vtd: Cleanup dma_remapping.h header
To:     "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20181112064008.2102-1-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D6242F@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <164d65da-f879-7a5f-2833-03b750b89f29@linux.intel.com>
Date:   Mon, 12 Nov 2018 15:32:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D6242F@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/12/18 3:20 PM, Liu, Yi L wrote:
>> bounces@lists.linux-foundation.org] On Behalf Of Lu Baolu
>> Sent: Monday, November 12, 2018 2:40 PM
>> Subject: [PATCH v2 1/1] iommu/vtd: Cleanup dma_remapping.h header
>>
>> Commit e61d98d8dad00 ("x64, x2apic/intr-remap: Intel vt-d, IOMMU
>> code reorganization") moved dma_remapping.h from drivers/pci/ to
>> current place. It is entirely VT-d specific, but uses a generic
>> name. This merges dma_remapping.h with include/linux/intel-iommu.h
>> and removes dma_remapping.h as the result.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Sohil Mehta <sohil.mehta@intel.com>
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
> 
> Reviewed-by: Liu, Yi L <yi.l.liu@intel.com>
> 
> Just out of curious, did you considered to modify the original file
> name to be an intel specific file name? What makes you believe
> merging the file content to intel-iommu.h is better?

I don't think we need multiple headers for VT-d specific things.

Best regards,
Lu Baolu
