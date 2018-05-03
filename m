Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeECOXI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:23:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeECOXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:23:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AEE8601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [RFC/RFT] Add noats flag to boot parameters
To: Joerg Roedel <joro@8bytes.org>
Cc: Gil Kupfer <gilkup@gmail.com>, dwmw2@infradead.org,
        bhelgaas@google.com, iommu@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        nadav.amit@gmail.com, Gil Kupfer <gilkup@cs.technion.ac.il>,
        Will Deacon <will.deacon@arm.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
 <20180503133459.waawna3ebtu3udn6@8bytes.org>
 <359d736a-a7ac-f0e4-f4db-dc7bb506481c@codeaurora.org>
 <20180503135920.o2rdh3exai7qmkvu@8bytes.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5cf699f1-90c1-5ad8-07fe-a65042395d05@codeaurora.org>
Date: Thu, 3 May 2018 10:23:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503135920.o2rdh3exai7qmkvu@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Bjorn,

On 5/3/2018 9:59 AM, Joerg Roedel wrote:
> On Thu, May 03, 2018 at 09:46:34AM -0400, Sinan Kaya wrote:
>> I also like the idea in general.
>> Minor nit..
>>
>> Shouldn't this be an iommu parameter rather than a PCI kernel command line parameter?
>> We now have an iommu.passthrough argument that prevents page translation.
>>
>> Doesn't this fit into the same category especially when it is the IOMMU drivers that
>> call ATS functions for enablement not the PCI drivers.
> 
> ATS is a bit of a grey area between PCI and IOMMU, but since ATS is
> PCI-specific and the code to enable/disable it is in PCI as well, I
> think the parameter makes sense for PCI too.
> 

OK. Bjorn was interested in having a command line driven feature enables in driver/pci
directory with bitmasks for each optional PCI spec capability rather than noXYZ feature.

This would allow us to troubleshoot code breakage as well as the platform bring up to
turn off all optional features.

Sounds like this would be a good match for that work.


> 
> 	Joerg
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
