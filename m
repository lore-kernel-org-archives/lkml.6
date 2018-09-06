Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6241EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFCA206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFCA206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeIFF3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 01:29:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:24937 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbeIFF3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 01:29:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 17:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="68722788"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 05 Sep 2018 17:56:43 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/10] iommu/amd: Add default branch in
 amd_iommu_capable()
To:     Alex Williamson <alex.williamson@redhat.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-4-baolu.lu@linux.intel.com>
 <20180905133703.331c0c17@t450s.home>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e066cd56-6eb4-40b6-4ad0-05edf98b9c5a@linux.intel.com>
Date:   Thu, 6 Sep 2018 08:55:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905133703.331c0c17@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/06/2018 03:37 AM, Alex Williamson wrote:
> On Thu, 30 Aug 2018 12:09:15 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Otherwise, there will be a build warning:
>>
>> drivers/iommu/amd_iommu.c:3083:2: warning: enumeration value
>> 'IOMMU_CAP_AUX_DOMAIN' not handled in switch [-Wswitch]
>>
>> There is no functional change.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/amd_iommu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>> index 4e04fff23977..237ae6db4cfd 100644
>> --- a/drivers/iommu/amd_iommu.c
>> +++ b/drivers/iommu/amd_iommu.c
>> @@ -3077,6 +3077,8 @@ static bool amd_iommu_capable(enum iommu_cap cap)
>>   		return (irq_remapping_enabled == 1);
>>   	case IOMMU_CAP_NOEXEC:
>>   		return false;
>> +	default:
>> +		break;
>>   	}
>>   
>>   	return false;
> 
> Seems like a bug fix that doesn't need to be part of this RFC, send it
> separately.  Thanks,

Sure.

Best regards,
Lu Baolu
