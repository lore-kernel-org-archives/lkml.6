Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B891EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A7C20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A7C20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeKHMDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:03:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:1769 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbeKHMDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:03:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 18:30:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="94535525"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Nov 2018 18:30:30 -0800
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 06/12] iommu/vt-d: Add second level page table
 interface
To:     "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-7-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FB11@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e987773c-a547-01e4-a04f-1f34506420ac@linux.intel.com>
Date:   Thu, 8 Nov 2018 10:27:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D5FB11@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/7/18 3:13 PM, Liu, Yi L wrote:
> Hi Baolu,
> 
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Monday, November 5, 2018 1:32 PM
>>
>> This adds the interfaces to setup or tear down the structures
>> for second level page table translations. This includes types
>> of second level only translation and pass through.
> 
> A little bit refining to the description:)
> "This patch adds interfaces for setup or tear down second level
> translation in PASID granularity. Translation type includes second
> level only type and pass-through type."
> 
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> 
> [...]
> 
>> +
>> +void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>> +				 struct device *dev, int pasid)
>> +{
>> +	struct pasid_entry *pte;
> 
> pte is confusing as it is similar with pte in paging structures. may use
> pt_entry or just pasid_entry. This comment applies to other "pte"s in
> this patch.

"pte" in this file means "pasid table entry", not "page table entry".
This file holds code to handle pasid table related staff. It has nothing
to do with paging structure. I think there should be no confusion here.
:-)

Best regards,
Lu Baolu
