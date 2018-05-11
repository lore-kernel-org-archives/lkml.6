Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeEKUJ3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 16:09:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33586 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeEKUJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 16:09:27 -0400
X-Google-Smtp-Source: AB8JxZptIG9M8x46M1CLpcabcKuUTO2y3Z3gRyD+C5WuLZQIHOKlkSUlIHB6og6H2DqHs257u6WwCA==
Subject: Re: [PATCH v1 6/9] iommu/tegra: gart: Ignore devices without IOMMU
 phandle in DT
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180508181700.5169-1-digetx@gmail.com>
 <20180508181700.5169-7-digetx@gmail.com>
 <a3293da9-b750-6c5c-6f84-53b1aafc5e53@arm.com>
From: Dmitry Osipenko <digetx@gmail.com>
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
Message-ID: <000ce2c8-2b20-3fb5-8942-b9e60ba34422@gmail.com>
Date: Fri, 11 May 2018 18:34:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a3293da9-b750-6c5c-6f84-53b1aafc5e53@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 11.05.2018 14:34, Robin Murphy wrote:
> Hi Dmitry,
> 
> On 08/05/18 19:16, Dmitry Osipenko wrote:
>> GART can't handle all devices, ignore devices that aren't related to GART.
>> Device tree must explicitly assign GART IOMMU to the devices.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>   drivers/iommu/tegra-gart.c | 33 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>> index 39305224c48d..5b2d27620350 100644
>> --- a/drivers/iommu/tegra-gart.c
>> +++ b/drivers/iommu/tegra-gart.c
>> @@ -366,6 +366,26 @@ static void gart_iommu_remove_device(struct device *dev)
>>       iommu_device_unlink(&gart_handle->iommu, dev);
>>   }
>>   +static int gart_iommu_check_device(struct gart_device *gart,
>> +                   struct device *dev);
>> +
>> +struct iommu_group *gart_iommu_device_group(struct device *dev)
>> +{
>> +    int err;
>> +
>> +    err = gart_iommu_check_device(gart_handle, dev);
>> +    if (err)
>> +        return ERR_PTR(err);
>> +
>> +    return generic_device_group(dev);
>> +}
>> +
>> +static int gart_iommu_of_xlate(struct device *dev,
>> +                   struct of_phandle_args *args)
>> +{
>> +    return 0;
>> +}
>> +
>>   static const struct iommu_ops gart_iommu_ops = {
>>       .capable    = gart_iommu_capable,
>>       .domain_alloc    = gart_iommu_domain_alloc,
>> @@ -374,14 +394,24 @@ static const struct iommu_ops gart_iommu_ops = {
>>       .detach_dev    = gart_iommu_detach_dev,
>>       .add_device    = gart_iommu_add_device,
>>       .remove_device    = gart_iommu_remove_device,
>> -    .device_group    = generic_device_group,
>> +    .device_group    = gart_iommu_device_group,
>>       .map        = gart_iommu_map,
>>       .map_sg        = default_iommu_map_sg,
>>       .unmap        = gart_iommu_unmap,
>>       .iova_to_phys    = gart_iommu_iova_to_phys,
>>       .pgsize_bitmap    = GART_IOMMU_PGSIZES,
>> +    .of_xlate    = gart_iommu_of_xlate,
>>   };
>>   +static int gart_iommu_check_device(struct gart_device *gart,
>> +                   struct device *dev)
>> +{
>> +    if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &gart_iommu_ops)
>> +        return -ENODEV;
> 
> Conceptually, it would be better to verify this in .add_device *before* calling
> iommu_group_get_for_dev(). That would also align with what other drivers do, and
> let you save introducing the .device_group callback until the real
> implementation in the later patch.

Indeed, thank you for the suggestion.
