Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966407AbeEYLaj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:30:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60302 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965907AbeEYLah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:30:37 -0400
Date: Fri, 25 May 2018 12:31:05 +0100
From: Will Deacon <will.deacon@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 7/8] iommu: Remove IOMMU_OF_DECLARE
Message-ID: <20180525113104.GA3255@arm.com>
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-8-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524175024.19874-8-robh@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 12:50:23PM -0500, Rob Herring wrote:
> Now that we use the driver core to stop deferred probe for missing
> drivers, IOMMU_OF_DECLARE can be removed.
> 
> This is slightly less optimal than having a list of built-in drivers in
> that we'll now defer probe twice before giving up. This shouldn't have a
> significant impact on boot times as past discussions about deferred
> probe have given no evidence of deferred probe having a substantial
> impact.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/iommu/arm-smmu-v3.c    |  2 --
>  drivers/iommu/arm-smmu.c       |  7 -------
>  drivers/iommu/exynos-iommu.c   |  2 --
>  drivers/iommu/ipmmu-vmsa.c     |  3 ---
>  drivers/iommu/msm_iommu.c      |  2 --
>  drivers/iommu/of_iommu.c       | 19 +------------------
>  drivers/iommu/qcom_iommu.c     |  2 --
>  drivers/iommu/rockchip-iommu.c |  2 --
>  include/linux/of_iommu.h       |  4 ----
>  9 files changed, 1 insertion(+), 42 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d647104bccc..22bdabd3d8e0 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2915,8 +2915,6 @@ static struct platform_driver arm_smmu_driver = {
>  };
>  module_platform_driver(arm_smmu_driver);
>  
> -IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3");
> -
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>  MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 69e7c60792a8..9dd7cbaa3b0c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2211,13 +2211,6 @@ static struct platform_driver arm_smmu_driver = {
>  };
>  module_platform_driver(arm_smmu_driver);
>  
> -IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1");
> -IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2");
> -IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400");
> -IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401");
> -IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500");
> -IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2");
> -
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
>  MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
>  MODULE_LICENSE("GPL v2");

For the SMMU drivers:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
