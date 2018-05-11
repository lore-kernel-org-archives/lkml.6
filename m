Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbeEKLNJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:13:09 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45331 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbeEKLNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:13:05 -0400
X-Google-Smtp-Source: AB8JxZqlBZzCz//qx/nbxwvJupy2u1815uW+MQQUanBzB4J5E1gRLk/VlYTZXANGl/DmEafTOQ8tEg==
Subject: Re: [PATCH v1 7/9] iommu/tegra: gart: Provide single domain and group
 for all devices
From: Dmitry Osipenko <digetx@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180508181700.5169-1-digetx@gmail.com>
 <20180508181700.5169-8-digetx@gmail.com>
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
Message-ID: <2f966990-7961-63de-87ec-f6a67c95d0bf@gmail.com>
Date: Fri, 11 May 2018 14:12:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508181700.5169-8-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.05.2018 21:16, Dmitry Osipenko wrote:
> GART aperture is shared by all devices, hence there is a single IOMMU
> domain and group shared by these devices. Allocation of a group per
> device only wastes resources and allowance of having more than one domain
> is simply wrong because IOMMU mappings made by the users of "different"
> domains will stomp on each other.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 107 +++++++++----------------------------
>  1 file changed, 24 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 5b2d27620350..ebc105c201bd 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -19,7 +19,6 @@
>  
>  #include <linux/io.h>
>  #include <linux/iommu.h>
> -#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/slab.h>
> @@ -44,22 +43,17 @@
>  #define GART_PAGE_MASK						\
>  	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
>  
> -struct gart_client {
> -	struct device		*dev;
> -	struct list_head	list;
> -};
> -
>  struct gart_device {
>  	void __iomem		*regs;
>  	u32			*savedata;
>  	u32			page_count;	/* total remappable size */
>  	dma_addr_t		iovmm_base;	/* offset to vmm_area */
>  	spinlock_t		pte_lock;	/* for pagetable */
> -	struct list_head	client;
> -	spinlock_t		client_lock;	/* for client list */
>  	struct device		*dev;
>  
>  	struct iommu_device	iommu;		/* IOMMU Core handle */
> +	struct iommu_group	*group;		/* Common IOMMU group */
> +	struct gart_domain	*domain;	/* Unique IOMMU domain */
>  
>  	struct tegra_mc_gart_handle mc_gart_handle;
>  };
> @@ -169,81 +163,31 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
>  static int gart_iommu_attach_dev(struct iommu_domain *domain,
>  				 struct device *dev)
>  {
> -	struct gart_domain *gart_domain = to_gart_domain(domain);
> -	struct gart_device *gart = gart_domain->gart;
> -	struct gart_client *client, *c;
> -	int err = 0;
> -
> -	client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
> -	if (!client)
> -		return -ENOMEM;
> -	client->dev = dev;
> -
> -	spin_lock(&gart->client_lock);
> -	list_for_each_entry(c, &gart->client, list) {
> -		if (c->dev == dev) {
> -			dev_err(gart->dev,
> -				"%s is already attached\n", dev_name(dev));
> -			err = -EINVAL;
> -			goto fail;
> -		}
> -	}
> -	list_add(&client->list, &gart->client);
> -	spin_unlock(&gart->client_lock);
> -	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
>  	return 0;
> -
> -fail:
> -	devm_kfree(gart->dev, client);
> -	spin_unlock(&gart->client_lock);
> -	return err;
>  }
>  
>  static void gart_iommu_detach_dev(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> -	struct gart_domain *gart_domain = to_gart_domain(domain);
> -	struct gart_device *gart = gart_domain->gart;
> -	struct gart_client *c;
> -
> -	spin_lock(&gart->client_lock);
> -
> -	list_for_each_entry(c, &gart->client, list) {
> -		if (c->dev == dev) {
> -			list_del(&c->list);
> -			devm_kfree(gart->dev, c);
> -			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
> -			goto out;
> -		}
> -	}
> -	dev_err(gart->dev, "Couldn't find\n");
> -out:
> -	spin_unlock(&gart->client_lock);
>  }
>  
>  static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
>  {
> -	struct gart_domain *gart_domain;
> -	struct gart_device *gart;
> -
> -	if (type != IOMMU_DOMAIN_UNMANAGED)
> -		return NULL;
> +	struct gart_device *gart = gart_handle;
>  
> -	gart = gart_handle;
> -	if (!gart)
> +	if (type != IOMMU_DOMAIN_UNMANAGED || gart->domain)
>  		return NULL;
>  
> -	gart_domain = kzalloc(sizeof(*gart_domain), GFP_KERNEL);
> -	if (!gart_domain)
> -		return NULL;
> -
> -	gart_domain->gart = gart;
> -	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
> -	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
> +	gart->domain = kzalloc(sizeof(*gart->domain), GFP_KERNEL);
> +	if (gart->domain) {
> +		gart->domain->domain.geometry.aperture_start = gart->iovmm_base;
> +		gart->domain->domain.geometry.aperture_end = gart->iovmm_base +
>  					gart->page_count * GART_PAGE_SIZE - 1;
> -	gart_domain->domain.geometry.force_aperture = true;
> +		gart->domain->domain.geometry.force_aperture = true;
> +		gart->domain->gart = gart;
> +	}
>  
> -	return &gart_domain->domain;
> +	return &gart->domain->domain;
>  }

I've missed a NULL-check and locking here, this will be fixed in v2. For now
I'll wait for the review comments (please review).
