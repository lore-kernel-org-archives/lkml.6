Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9493BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD55207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfBVHrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:47:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:54724 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfBVHrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:47:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 23:47:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,398,1544515200"; 
   d="scan'208";a="116908921"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2019 23:47:04 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jis Ben <jisben@google.com>
Subject: Re: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
To:     James Dong <xmdong@google.com>
References: <20190222024455.20802-1-xmdong@google.com>
 <cf965dec-1bae-1d98-e97c-6a84c0c9862f@linux.intel.com>
 <fe6dcb4e-03c4-0bbf-c51f-5964b20593dd@linux.intel.com>
 <CADcZez2q7aUL=ahHSGnfO2QDjKL052AePd=TsxkCK-O7EcW77Q@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <21c17b44-af9b-2f18-f109-ba4bb0635e61@linux.intel.com>
Date:   Fri, 22 Feb 2019 15:42:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CADcZez2q7aUL=ahHSGnfO2QDjKL052AePd=TsxkCK-O7EcW77Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/22/19 2:38 PM, James Dong wrote:
> 
> Tried this patch, and the same DMAR fault message came out.
> 
> Guess it is because of the iommu code path for hotplug devices. If a hotplug
> device is rescanned after removal, iommu_bus_notifier will be called as part
> of the notifier chains to handle BUS_NOTIFY_ADD_DEVICE event. Along the code
> path, intel_iommu_ops->add_device() created an iommu group for this hotplug
> device, but failed to create an iommu domain because of the default domain
> type IOMMU_DOMAIN_IDENTITY imposed by current IOMMU command line option got
> declined by intel_iommu_ops->domain_alloc().
> 
> In your patch, function find_or_alloc_domain() is not even in the code path
> of BUS_NOTIFY_ADD_DEVICE event notifier chain.
> 
> Please let us know if your have more concerns and suggestions.

Can I reproduce this with a local machine? If so, how should I do?

> 
> Best Regards,
> James

Best regards,
Lu Baolu
