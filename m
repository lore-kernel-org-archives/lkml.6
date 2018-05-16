Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeEPNnq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:43:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43881 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEPNnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:43:43 -0400
X-Google-Smtp-Source: AB8JxZo+JaZDh5m7Kp4U08rEMae5Tp/uaqvhkHI7agMfI6NhS8MzgH72XtIqlDI+oZ1udt/ZDiNPhA==
Subject: Re: [PATCH v1 7/9] iommu/tegra: gart: Provide single domain and group
 for all devices
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180508181700.5169-1-digetx@gmail.com>
 <20180508181700.5169-8-digetx@gmail.com>
 <dd440bff-5bbd-e0c6-5ebb-e36b9ab5e843@arm.com>
 <cd04abc4-cade-b8c9-bcde-9d18e4f32519@gmail.com>
 <56d097b0-da3f-8635-9887-64e2df496d01@arm.com>
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
Message-ID: <8b17f72d-1285-9736-25cf-cb99187d03b4@gmail.com>
Date: Wed, 16 May 2018 16:43:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <56d097b0-da3f-8635-9887-64e2df496d01@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.2018 21:18, Robin Murphy wrote:
> On 11/05/18 21:05, Dmitry Osipenko wrote:
>> On 11.05.2018 15:32, Robin Murphy wrote:
>>> On 08/05/18 19:16, Dmitry Osipenko wrote:
>>>> GART aperture is shared by all devices, hence there is a single IOMMU
>>>> domain and group shared by these devices. Allocation of a group per
>>>> device only wastes resources and allowance of having more than one domain
>>>> is simply wrong because IOMMU mappings made by the users of "different"
>>>> domains will stomp on each other.
>>>
>>> Strictly, that reasoning is a bit backwards - allocating multiple groups is the
>>> conceptually-wrong thing if the GART cannot differentiate between different
>>> devices, whereas having multiple domains *exist* is no real problem, it's merely
>>> that only one can be active at any point in time (which will inherently become
>>> the case once all devices are grouped together).
>>
>> IIUC, the IOMMU domain represents the address space. There is only one address
>> space in a case of GART, the GART's aperture. So GART not only isn't
>> differentiating between different devices, but also between different domains.
> 
> Right, but that's the same as many other IOMMUs (exynos, rockchip, mtk, etc.) -
> the point is that an IOMMU domain represents *an* address space, but if nothing
> is attached to that domain, it's just a set of logical mappings which doesn't
> need to be backed by real hardware. It's specifically *because* these IOMMUs
> also can't differentiate between devices that things work out neatly - there's
> only one group, which can only be attached to a single domain at once, so there
> is never a time when more than one domain needs to be backed by hardware. Think
> of the IOMMU+devices as a CPU and the domains as processes ;)

\I think\ I understand what you are trying to convey. The "domain swapping"
functionality sounds like a good idea, but I don't see any practical application
to a such functionality right now. Your suggestion also feels a bit like an
implicit ad hoc to me, maybe we could extended IOMMU API to support somewhat
like "explicit domain swapping" for device drivers if multiple platforms will
need that.

In a case of the Tegra-GART driver, I'd prefer to allow having only a single
IOMMU domain in the system for the starter and implement other features on by
as-needed basis.

>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>    drivers/iommu/tegra-gart.c | 107 +++++++++----------------------------
>>>>    1 file changed, 24 insertions(+), 83 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>>>> index 5b2d27620350..ebc105c201bd 100644
>>>> --- a/drivers/iommu/tegra-gart.c
>>>> +++ b/drivers/iommu/tegra-gart.c
>>>> @@ -19,7 +19,6 @@
>>>>      #include <linux/io.h>
>>>>    #include <linux/iommu.h>
>>>> -#include <linux/list.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/of_device.h>
>>>>    #include <linux/slab.h>
>>>> @@ -44,22 +43,17 @@
>>>>    #define GART_PAGE_MASK                        \
>>>>        (~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
>>>>    -struct gart_client {
>>>> -    struct device        *dev;
>>>> -    struct list_head    list;
>>>> -};
>>>> -
>>>>    struct gart_device {
>>>>        void __iomem        *regs;
>>>>        u32            *savedata;
>>>>        u32            page_count;    /* total remappable size */
>>>>        dma_addr_t        iovmm_base;    /* offset to vmm_area */
>>>>        spinlock_t        pte_lock;    /* for pagetable */
>>>> -    struct list_head    client;
>>>> -    spinlock_t        client_lock;    /* for client list */
>>>>        struct device        *dev;
>>>>          struct iommu_device    iommu;        /* IOMMU Core handle */
>>>> +    struct iommu_group    *group;        /* Common IOMMU group */
>>>> +    struct gart_domain    *domain;    /* Unique IOMMU domain */
>>>>          struct tegra_mc_gart_handle mc_gart_handle;
>>>>    };
>>>> @@ -169,81 +163,31 @@ static inline bool gart_iova_range_valid(struct
>>>> gart_device *gart,
>>>>    static int gart_iommu_attach_dev(struct iommu_domain *domain,
>>>>                     struct device *dev)
>>>>    {
>>>> -    struct gart_domain *gart_domain = to_gart_domain(domain);
>>>> -    struct gart_device *gart = gart_domain->gart;
>>>> -    struct gart_client *client, *c;
>>>> -    int err = 0;
>>>> -
>>>> -    client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
>>>> -    if (!client)
>>>> -        return -ENOMEM;
>>>> -    client->dev = dev;
>>>> -
>>>> -    spin_lock(&gart->client_lock);
>>>> -    list_for_each_entry(c, &gart->client, list) {
>>>> -        if (c->dev == dev) {
>>>> -            dev_err(gart->dev,
>>>> -                "%s is already attached\n", dev_name(dev));
>>>> -            err = -EINVAL;
>>>> -            goto fail;
>>>> -        }
>>>> -    }
>>>> -    list_add(&client->list, &gart->client);
>>>> -    spin_unlock(&gart->client_lock);
>>>> -    dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
>>>>        return 0;
>>>> -
>>>> -fail:
>>>> -    devm_kfree(gart->dev, client);
>>>> -    spin_unlock(&gart->client_lock);
>>>> -    return err;
>>>>    }
>>>>      static void gart_iommu_detach_dev(struct iommu_domain *domain,
>>>>                      struct device *dev)
>>>>    {
>>>> -    struct gart_domain *gart_domain = to_gart_domain(domain);
>>>> -    struct gart_device *gart = gart_domain->gart;
>>>> -    struct gart_client *c;
>>>> -
>>>> -    spin_lock(&gart->client_lock);
>>>> -
>>>> -    list_for_each_entry(c, &gart->client, list) {
>>>> -        if (c->dev == dev) {
>>>> -            list_del(&c->list);
>>>> -            devm_kfree(gart->dev, c);
>>>> -            dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
>>>> -            goto out;
>>>> -        }
>>>> -    }
>>>> -    dev_err(gart->dev, "Couldn't find\n");
>>>> -out:
>>>> -    spin_unlock(&gart->client_lock);
>>>>    }
>>>
>>> The .detach_dev callback is optional in the core API now, so you can just remove
>>> the whole thing.
>>
>> Good catch, thanks!
>>
>>>
>>>>    static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
>>>>    {
>>>> -    struct gart_domain *gart_domain;
>>>> -    struct gart_device *gart;
>>>> -
>>>> -    if (type != IOMMU_DOMAIN_UNMANAGED)
>>>> -        return NULL;
>>>> +    struct gart_device *gart = gart_handle;
>>>>    -    gart = gart_handle;
>>>> -    if (!gart)
>>>> +    if (type != IOMMU_DOMAIN_UNMANAGED || gart->domain)
>>>
>>> Singleton domains are a little unpleasant given the way the IOMMU API expects
>>> things to work, but it looks fairly simple to avoid needing that at all. AFAICS
>>> you could move gart->savedata to something like gart_domain->ptes and keep it
>>> up-to-date in .map/.unmap, then in .attach_dev you just need to do something
>>> like:
>>>
>>>      if (gart_domain != gart->domain) {
>>>          do_gart_setup(gart, gart_domain->ptes);
>>>          gart->domain = gart_domain;
>>>      }
>>>
>>> to context-switch the hardware state when moving the group from one domain to
>>> another (and as a bonus you would no longer need to do anything for suspend,
>>> since resume can just look at the current domain too). If in practice there's
>>> only ever one domain allocated anyway, then there's no difference in memory
>>> overhead, but you still have the benefit of the driver being more consistent
>>> with others and allowing that flexibility if anyone ever did want to play
>>> with it.
>>
>> For the starter we'll have a single domain solely used by GPU with all its
>> sub-devices. Context switching will be handled by the Tegra's DRM driver. Later
>> we may consider introducing IOMMU support for the video decoder, at least to
>> provide memory isolation for the buffers to which decoder performs writing.
>>
>> Cross-driver context switching isn't that straightforward and I think Tegra-GART
>> driver shouldn't take care of context switching in any form and only perform
>> mapping / unmapping operations. There are couple variants of how to deal with
>> the context switching:
>>
>> 1. A simple solution could be to logically split the GART's aperture space into
>> different domains, but GART's aperture won't be utilized efficiently with this
>> approach, wasting IOVA space quite a lot.
>>
>> 2. In order to utilize aperture more efficiently, we are going to make DRM
>> driver to cache IOMMU mappings such that graphics buffer will be moved to the
>> cache-eviction list on unmapping and actually unmapped when that buffer isn't
>> in-use and there is no IOVA space for another buffer or on the buffers
>> destruction. We'll use DRM's MM scanning helper for that [0][1]. Maybe we could
>> share access to that MM helper with the video decoder somehow. Seems IOMMU API
>> isn't tailored for a such use-case, so probably having a custom
>> platform-specific API on top of the IOMMU API would be fine and with that we
>> could have cross-device/driver context switching handled by the custom API.
> 
> Yes, if the DRM driver has overall control of the domain, then drivers for other
> devices in the group are going to have to cooperate with it in terms of IOVA
> allocation. It might even make sense to have that inter-driver interface
> abstract things down to the map/unmap level, since with a limited aperture you
> really want to avoid mapping the same PA to two different IOVAs if at all possible.

Yeah, for now all that are just thoughts about the inter-driver interfaces and
whatnot, it's more important to get at least basic things up and running. So the
current plan is to go with a single IOMMU domain and make the DRM driver use it.

>> Please let me know if you have any other variants to suggest.
>>
>> [0]
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/drm/drm_mm.h
>>
>> [1]
>> https://github.com/grate-driver/linux/commit/16e017efaa343e23e5a7d2d498915764cc806054
>>
>>
>>>
>>>>            return NULL;
>>>>    -    gart_domain = kzalloc(sizeof(*gart_domain), GFP_KERNEL);
>>>> -    if (!gart_domain)
>>>> -        return NULL;
>>>> -
>>>> -    gart_domain->gart = gart;
>>>> -    gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
>>>> -    gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
>>>> +    gart->domain = kzalloc(sizeof(*gart->domain), GFP_KERNEL);
>>>> +    if (gart->domain) {
>>>> +        gart->domain->domain.geometry.aperture_start = gart->iovmm_base;
>>>> +        gart->domain->domain.geometry.aperture_end = gart->iovmm_base +
>>>>                        gart->page_count * GART_PAGE_SIZE - 1;
>>>> -    gart_domain->domain.geometry.force_aperture = true;
>>>> +        gart->domain->domain.geometry.force_aperture = true;
>>>> +        gart->domain->gart = gart;
>>>> +    }
>>>>    -    return &gart_domain->domain;
>>>> +    return &gart->domain->domain;
>>>>    }
>>>>      static void gart_iommu_domain_free(struct iommu_domain *domain)
>>>> @@ -251,18 +195,7 @@ static void gart_iommu_domain_free(struct iommu_domain
>>>> *domain)
>>>>        struct gart_domain *gart_domain = to_gart_domain(domain);
>>>>        struct gart_device *gart = gart_domain->gart;
>>>>    -    if (gart) {
>>>> -        spin_lock(&gart->client_lock);
>>>> -        if (!list_empty(&gart->client)) {
>>>> -            struct gart_client *c;
>>>> -
>>>> -            list_for_each_entry(c, &gart->client, list)
>>>> -                gart_iommu_detach_dev(domain, c->dev);
>>>> -        }
>>>> -        spin_unlock(&gart->client_lock);
>>>> -    }
>>>> -
>>>> -    kfree(gart_domain);
>>>> +    kfree(gart->domain);
>>>>    }
>>>>      static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
>>>> @@ -377,7 +310,7 @@ struct iommu_group *gart_iommu_device_group(struct device
>>>> *dev)
>>>>        if (err)
>>>>            return ERR_PTR(err);
>>>>    -    return generic_device_group(dev);
>>>> +    return gart_handle->group;
>>>
>>> You should take a reference per device, i.e.:
>>>
>>>      return iommu_group_ref_get(gart_handle->group);
>>>
>>> otherwise removing devices could unbalance things and result in the group
>>> getting freed prematurely.
>>
>> Seems more correctly would be to remove iommu_group_put() from
>> gart_iommu_add_device().
> 
> If you're confident that no bus code will ever result in add_device() getting
> called more than once for the same device, then you could get away with that.
> AFAIK it *shouldn't* happen, but I've never managed to convince myself that it
> *can't*
Having refcount incremented more times than decremented won't be a big problem
for the Tegra-GART driver since the singleton IOMMU group is allocated during of
driver probe once and then re-used by all devices. Let's go with keeping code
clean and simple where possible, and change it only if it will cause real problems.

>>>
>>>>    }
>>>>      static int gart_iommu_of_xlate(struct device *dev,
>>>> @@ -502,8 +435,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
>>>>          gart->dev = &pdev->dev;
>>>>        spin_lock_init(&gart->pte_lock);
>>>> -    spin_lock_init(&gart->client_lock);
>>>> -    INIT_LIST_HEAD(&gart->client);
>>>>        gart->regs = gart_regs;
>>>>        gart->iovmm_base = (dma_addr_t)res_remap->start;
>>>>        gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
>>>> @@ -517,6 +448,14 @@ static int tegra_gart_probe(struct platform_device *pdev)
>>>>            goto iommu_unregister;
>>>>        }
>>>>    +    gart->group = iommu_group_alloc();
>>>> +    if (IS_ERR(gart->group)) {
>>>> +        ret = PTR_ERR(gart->group);
>>>> +        goto free_savedata;
>>>> +    }
>>>> +
>>>> +    iommu_group_ref_get(gart->group);
>>>
>>> You already hold the initial reference from iommu_group_alloc(), so there's no
>>> need to take a second one at this point.
>>
>> Yes, looks like this refcount-bump isn't needed here. I'll revisit the
>> refcountings and correct them in v2 where necessary.
>>
>> Thank you very much for the review.
>>
