Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeDQRz5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:55:57 -0400
Received: from foss.arm.com ([217.140.101.70]:46502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbeDQRz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:55:56 -0400
Subject: Re: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
To: "Hook, Gary" <ghook@amd.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
 <1523663790.2747.4.camel@intel.com>
 <10e422dd-a3ca-8ecb-50fa-e7f131a55a12@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <80b1e9e5-3048-391a-6d7d-adeeece1bf46@arm.com>
Date: Tue, 17 Apr 2018 18:55:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <10e422dd-a3ca-8ecb-50fa-e7f131a55a12@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/18 18:36, Hook, Gary wrote:
> On 4/13/2018 7:55 PM, Mehta, Sohil wrote:
>> On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
>>> +struct dentry *iommu_debugfs_setup(void)
>>> +{
>>> +    if (!debugfs_initialized())
>>
>> This check is probably not needed.
> 
> Ah, so it isn't. Thank you.
> 
>>
>>> +        return NULL;
>>> +
>>> +    if (!iommu_debugfs_dir)
>>> +        iommu_debugfs_dir = debugfs_create_dir("iommu",
>>> NULL);
>>> +
>>> +    if (iommu_debugfs_dir)
>>> +        pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN
>>> ENABLED IN THIS KERNEL\n");
>>> +
>>
>> As this gets called for each IOMMU, do you want to use pr_warn_once?
> 
> That works, yes.

Or I guess you could just roll the pr_warn() into the previous if() 
condition, i.e. only warn when the singleton debugfs_dir is actually 
created.

Robin.

> 
>>
>>> +    return iommu_debugfs_dir;
>>> +}
>>> +EXPORT_SYMBOL_GPL(iommu_debugfs_setup);
>>
>> -Sohil
>>
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
