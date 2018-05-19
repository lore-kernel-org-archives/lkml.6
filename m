Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeESAyM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 20:54:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39610 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeESAyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 20:54:07 -0400
X-Google-Smtp-Source: AB8JxZoFWz5KZvzO3gkPOMzHFDgQzVx5JG+RpcG6rBjwAUDyBIh7LQTs1ig9NgO54VS3XArJwBVwIQ==
Subject: Re: [PATCH v1] gpu: host1x: Utilize IOMMU mapping for firewall-copied
 buffers
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180518235231.9274-1-digetx@gmail.com>
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
Message-ID: <bfb264fe-8ebd-2e93-162f-f85e48fafbd3@gmail.com>
Date: Sat, 19 May 2018 03:54:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518235231.9274-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.05.2018 02:52, Dmitry Osipenko wrote:
> Map firewall-copied buffers into Host1x's IOVA space, otherwise Host1x
> CDMA can't access the command buffers and all submitted jobs fail if IOMMU
> and Host1x firewall are enabled in the kernels config.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/host1x/job.c | 58 +++++++++++++++++++++++++++++++++++-----
>  include/linux/host1x.h   |  4 ++-
>  2 files changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
> index e2f4a4d93d20..57384a5b5059 100644
> --- a/drivers/gpu/host1x/job.c
> +++ b/drivers/gpu/host1x/job.c
> @@ -449,10 +449,13 @@ static int validate(struct host1x_firewall *fw, struct host1x_job_gather *g)
>  
>  static inline int copy_gathers(struct host1x_job *job, struct device *dev)
>  {
> +	struct host1x *host = dev_get_drvdata(job->channel->dev->parent);
>  	struct host1x_firewall fw;
> +	dma_addr_t dma_addr;
>  	size_t size = 0;
>  	size_t offset = 0;
>  	unsigned int i;
> +	int err;
>  
>  	fw.job = job;
>  	fw.dev = dev;
> @@ -466,23 +469,55 @@ static inline int copy_gathers(struct host1x_job *job, struct device *dev)
>  		size += g->words * sizeof(u32);
>  	}
>  
> +	if (host->domain)
> +		size = iova_align(&host->iova, size);
> +
>  	/*
>  	 * Try a non-blocking allocation from a higher priority pools first,
>  	 * as awaiting for the allocation here is a major performance hit.
>  	 */
> -	job->gather_copy_mapped = dma_alloc_wc(dev, size, &job->gather_copy,
> -					       GFP_NOWAIT);
> +	job->gather_copy_mapped = dma_alloc_wc(dev, size,
> +					       &job->gather_copy_phys,
> + 					       GFP_NOWAIT);
>  
>  	/* the higher priority allocation failed, try the generic-blocking */
>  	if (!job->gather_copy_mapped)
>  		job->gather_copy_mapped = dma_alloc_wc(dev, size,
> -						       &job->gather_copy,
> +						       &job->gather_copy_phys,
>  						       GFP_KERNEL);
>  	if (!job->gather_copy_mapped)
>  		return -ENOMEM;
>  
>  	job->gather_copy_size = size;
>  
> +	if (host->domain) {
> +		unsigned long shift;
> +
> +		shift = iova_shift(&host->iova);
> +		job->gather_copy_iova_alloc = alloc_iova(
> +					&host->iova, size >> shift,
> +					host->iova_end >> shift, true);
> +		if (!job->gather_copy_iova_alloc)
> +			return -ENOMEM;
> +
> +		job->gather_copy_iova = iova_dma_addr(
> +				&host->iova, job->gather_copy_iova_alloc);
> +
> +		err = iommu_map(host->domain,
> +				job->gather_copy_iova,
> +				job->gather_copy_phys,
> +				size, IOMMU_READ);
> +		if (err) {
> +			__free_iova(&host->iova, job->gather_copy_iova_alloc);
> +			job->gather_copy_iova_alloc = NULL;
> +			return err;
> +		}
> +
> +		dma_addr = job->gather_copy_iova;
> +	} else {
> +		dma_addr = job->gather_copy_phys;
> +	}
> +
>  	for (i = 0; i < job->num_gathers; i++) {
>  		struct host1x_job_gather *g = &job->gathers[i];
>  		void *gather;
> @@ -494,7 +529,7 @@ static inline int copy_gathers(struct host1x_job *job, struct device *dev)
>  		host1x_bo_munmap(g->bo, gather);
>  
>  		/* Store the location in the buffer */
> -		g->base = job->gather_copy;
> +		g->base = dma_addr;
>  		g->offset = offset;
>  
>  		/* Validate the job */
> @@ -582,9 +617,20 @@ void host1x_job_unpin(struct host1x_job *job)
>  
>  	job->num_unpins = 0;
>  
> -	if (job->gather_copy_size)
> +	if (job->gather_copy_size) {
>  		dma_free_wc(job->channel->dev, job->gather_copy_size,
> -			    job->gather_copy_mapped, job->gather_copy);
> +			    job->gather_copy_mapped, job->gather_copy_phys);
> +
> +		if (job->gather_copy_iova_alloc) {
> +			iommu_unmap(host->domain,
> +				    job->gather_copy_iova,
> +				    job->gather_copy_size);
> +
> +			__free_iova(&host->iova, job->gather_copy_iova_alloc);
> +
> +			job->gather_copy_iova_alloc = NULL;
> +		}
> +	}
>  }
>  EXPORT_SYMBOL(host1x_job_unpin);
>  
> diff --git a/include/linux/host1x.h b/include/linux/host1x.h
> index 57d26406bdfd..536a678f81d4 100644
> --- a/include/linux/host1x.h
> +++ b/include/linux/host1x.h
> @@ -235,8 +235,10 @@ struct host1x_job {
>  	unsigned int num_slots;
>  
>  	/* Copy of gathers */
> +	struct iova *gather_copy_iova_alloc;
>  	size_t gather_copy_size;
> -	dma_addr_t gather_copy;
> +	dma_addr_t gather_copy_iova;
> +	dma_addr_t gather_copy_phys;
>  	u8 *gather_copy_mapped;
>  
>  	/* Check if register is marked as an address reg */
> 

Though much better would be to just skip the IOMMU initialization if firewall is
enabled. Please scratch this patch, I'll make another.
