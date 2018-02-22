Return-Path: <jcrouse@codeaurora.org>
X-Google-Smtp-Source: AH8x225AjlhRUbwPlChYW2tzDRZLstSrvteWn/cEUaaCecgbaZFAKJdPTPbVi9aMRgN6yk2Qu08d
ARC-Seal: i=1; a=rsa-sha256; t=1519343525; cv=none;
        d=google.com; s=arc-20160816;
        b=qtIXSOdzw0o/KSWPSXpXyNsEZeZ6AqrvKt+JvFoV3B3uL8cbQryswwecAvDWPDsQbj
         9dg9/HyUqTHsWSyfUL8MDPhCio78vbhBNoT5CrL2o3w6OjOm2Yu7u0MhU8jFCvAizZmr
         2qEsTpI+C79URDrG2vQQ7WZ0Ov/IlRRDbGSlatnFOxt+0OOr96dnyQuErRWpPfi4f3qu
         rPuYPREvKl+xbdR6LJt5OAN79XQFPvoou2TsetCTLa2qV/QoBF47ad+t07z/DcEd09mJ
         CI0FwN79+hPWy9CcEBYrXEIAjK1+g+Hq+lFJjvi+v+ZeXqEzqiykrikIKyExQpjpaPQ0
         1Mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dmarc-filter
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=AhNeCVaWoPArUjcEK4nHJHm3xlXnaG7f39vsag9YQ0o=;
        b=oQmNC3zZZPyMOBnIrbpayZunji4mSLp9CnUw7zx+HSztCjuCcRrMTnvaHqSOH5Rcfu
         y0T6TTpb8iXG8JPOi8KXsU98bIA8CF2sY/baEC2XXcc6awgAkAq26Ubv+VLTdHUCQwmR
         d6q3m2XXszi0u5ptUrCqTdPnnIv0bHJ67T6xOz0fWbVGka2KXYaffBP9Dwe4Av2o8u2B
         zW8ze9wNokeH/L7lgNS1CCBAE1wXEjvMFo0VJX6FhMzUD60MQin4k1+q/AyySc3ebxov
         VHkfDAhWVxgrkTZBDJinKDuAknKk8i5MJfj8I7f56Teb1x/b76tHOyc0tB3sdzAzwz9t
         OZIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XKCij5hO;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XKCij5hO;
       spf=pass (google.com: domain of jcrouse@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=jcrouse@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XKCij5hO;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XKCij5hO;
       spf=pass (google.com: domain of jcrouse@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=jcrouse@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6B1660712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Thu, 22 Feb 2018 16:52:00 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
	rjw@rjwysocki.net, robin.murphy@arm.com, will.deacon@arm.com,
	robdclark@gmail.com, iommu@lists.linux-foundation.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, airlied@linux.ie,
	gregkh@linuxfoundation.org, sboyd@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
Message-ID: <20180222235200.GA18743@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Vivek Gautam <vivek.gautam@codeaurora.org>,
	joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
	rjw@rjwysocki.net, robin.murphy@arm.com, will.deacon@arm.com,
	robdclark@gmail.com, iommu@lists.linux-foundation.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, airlied@linux.ie,
	gregkh@linuxfoundation.org, sboyd@codeaurora.org,
	linux-arm-msm@vger.kernel.org
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737865178016622?=
X-GMAIL-MSGID: =?utf-8?q?1593147156246021225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 04:01:19PM +0530, Vivek Gautam wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> The smmu device probe/remove and add/remove master device callbacks
> gets called when the smmu is not linked to its master, that is without
> the context of the master device. So calling runtime apis in those places
> separately.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [vivek: Cleanup pm runtime calls]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 9e2f917e16c2..c024f69c1682 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> -	int irq;
> +	int ret, irq;
>  
>  	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>  		return;
>  
> +	ret = pm_runtime_get_sync(smmu->dev);
> +	if (ret)
> +		return;
> +
>  	/*
>  	 * Disable the context bank and free the page tables before freeing
>  	 * it.
> @@ -932,6 +936,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>  
>  	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>  	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> +
> +	pm_runtime_put_sync(smmu->dev);
>  }
>  
>  static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> @@ -1407,14 +1413,22 @@ static int arm_smmu_add_device(struct device *dev)
>  	while (i--)
>  		cfg->smendx[i] = INVALID_SMENDX;
>  
> -	ret = arm_smmu_master_alloc_smes(dev);
> +	ret = pm_runtime_get_sync(smmu->dev);
>  	if (ret)
>  		goto out_cfg_free;

Hey Vivek, I just hit a problem with this on sdm845. It turns out that
pm_runtime_get_sync() returns a positive 1 if the device is already active.

I hit this in the GPU code. The a6xx has two platform devices that each use a
different sid on the iommu. The GPU is probed normally from a platform driver
and it in turn initializes the GMU device by way of a phandle.

Because the GMU isn't probed with a platform driver we need to call
of_dma_configure() on the device to set up the IOMMU for the device which ends
up calling through this path and we discover that the smmu->dev is already
powered (pm_runtime_get_sync returns 1).

I'm not immediately sure if this is a bug on sdm845 or not because a cursory
inspection says that the SMMU device shouldn't be powered at this time but there
might be a connection that I'm not seeing. Obviously if the SMMU was left
powered thats a bad thing. But putting that aside it is obvious that this
code should be accommodating of the possibility that the device is already
powered, and so this should be

if (ret < 0)
	goto out_cfg_free;

With that the GPU/GMU successfully comes up on Sean Paul's display testing
branch.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
