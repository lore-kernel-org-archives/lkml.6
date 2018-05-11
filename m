Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEKUJp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 16:09:45 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33529 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeEKUJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 16:09:43 -0400
X-Google-Smtp-Source: AB8JxZooHMPFIe2T8cvJ+oHFLtHO0lOaNfRtkuP0fFpCe4aKv2ONVCroZN0aP6GQ75J4SYJFDqzYbw==
From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 8/9] iommu: Introduce iotlb_sync_map callback
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180508181700.5169-1-digetx@gmail.com>
 <20180508181700.5169-9-digetx@gmail.com>
 <da823a61-5bda-042b-c61f-d0d98f9b6e6f@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <fd1fc335-bd06-d7ac-7839-786957144cf8@gmail.com>
Date: Fri, 11 May 2018 22:58:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <da823a61-5bda-042b-c61f-d0d98f9b6e6f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.2018 16:02, Robin Murphy wrote:
> On 08/05/18 19:16, Dmitry Osipenko wrote:
>> Introduce iotlb_sync_map() callback that is invoked in the end of
>> iommu_map(). This new callback allows IOMMU drivers to avoid syncing
>> on mapping of each contiguous chunk and sync only when whole mapping
>> is completed, optimizing performance of the mapping operation.
> 
> This looks like a reasonable compromise - for users of
> IO_PGTABLE_QUIRK_TLBI_ON_MAP we can leave the implicit add_flush() in place for
> each individual map call, but at least move the sync() out to this callback,
> which should still be beneficial overall.
> 
> Modulo one possible nit below,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>   drivers/iommu/iommu.c | 8 ++++++--
>>   include/linux/iommu.h | 1 +
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index d2aa23202bb9..39b2ee66aa96 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1508,13 +1508,14 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
>>   int iommu_map(struct iommu_domain *domain, unsigned long iova,
>>             phys_addr_t paddr, size_t size, int prot)
>>   {
>> +    const struct iommu_ops *ops = domain->ops;
>>       unsigned long orig_iova = iova;
>>       unsigned int min_pagesz;
>>       size_t orig_size = size;
>>       phys_addr_t orig_paddr = paddr;
>>       int ret = 0;
>>   -    if (unlikely(domain->ops->map == NULL ||
>> +    if (unlikely(ops->map == NULL ||
>>                domain->pgsize_bitmap == 0UL))
>>           return -ENODEV;
>>   @@ -1543,7 +1544,7 @@ int iommu_map(struct iommu_domain *domain, unsigned
>> long iova,
>>           pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
>>                iova, &paddr, pgsize);
>>   -        ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
>> +        ret = ops->map(domain, iova, paddr, pgsize, prot);
>>           if (ret)
>>               break;
>>   @@ -1552,6 +1553,9 @@ int iommu_map(struct iommu_domain *domain, unsigned
>> long iova,
>>           size -= pgsize;
>>       }
>>   +    if (ops->iotlb_sync_map)
>> +        ops->iotlb_sync_map(domain);
> 
> Is it worth trying to skip this in the error case when we're just going to undo
> it immediately?

I can imagine an IOMMU driver that could handle syncing of mapping differently
from the unmapping, in this case it may not worth skipping sync_map in the error
case.
