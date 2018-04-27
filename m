Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758123AbeD0MCH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:02:07 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46844 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757565AbeD0MCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:02:02 -0400
X-Google-Smtp-Source: AB8JxZopugnmrA32E4LV1yWzwzmA6J7f/RNyjzf5s/pQw/FmEUxtyOHPUg/tjcVE8Rj2rgI3zjhlLA==
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
To: Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1523304324.git.digetx@gmail.com>
 <f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
 <20180427100202.GO30388@ulmo>
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
Message-ID: <1980b5a2-3921-04f5-0519-ba926ac66e3d@gmail.com>
Date: Fri, 27 Apr 2018 15:01:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427100202.GO30388@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.2018 13:02, Thierry Reding wrote:
> On Mon, Apr 09, 2018 at 11:07:22PM +0300, Dmitry Osipenko wrote:
>> Currently GART writes one page entry at a time. More optimal would be to
>> aggregate the writes and flush BUS buffer in the end, this gives map/unmap
>> 10-40% (depending on size of mapping) performance boost compared to a
>> flushing after each entry update.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-gart.c | 63 +++++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 48 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>> index 4a0607669d34..9f59f5f17661 100644
>> --- a/drivers/iommu/tegra-gart.c
>> +++ b/drivers/iommu/tegra-gart.c
>> @@ -36,7 +36,7 @@
>>  #define GART_APERTURE_SIZE	SZ_32M
>>  
>>  /* bitmap of the page sizes currently supported */
>> -#define GART_IOMMU_PGSIZES	(SZ_4K)
>> +#define GART_IOMMU_PGSIZES	GENMASK(24, 12)
> 
> That doesn't look right. The GART really only supports 4 KiB pages. You
> seem to be "emulating" more page sizes here in order to improve mapping
> performance. That seems wrong to me. I'm wondering if this couldn't be
> improved by a similar factor by simply moving the flushing into an
> implementation of ->iotlb_sync().
> 
> That said, it seems like ->iotlb_sync() is only used for unmapping, but
> I don't see a reason why iommu_map() wouldn't need to call it as well
> after going through several calls to ->map(). It seems to me like a
> driver that implements ->iotlb_sync() would want to use it to optimize
> for both the mapping and unmapping cases.

I vaguely remember looking at the IOMMU syncing, but decided to try at first the
way this patch is. I'll be happy to switch to map/unmap syncing, let's see what
Joerg would suggest.

> Joerg, I've gone over the git log and header files and I see no mention
> of why the TLB flush interface isn't used for mapping. Do you recall any
> special reasons why the same shouldn't be applied for mapping? Would you
> accept any patches doing this?
