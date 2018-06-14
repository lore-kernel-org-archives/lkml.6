Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9CDA9C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F42205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lKa7TRl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F42205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965173AbeFNX5D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:57:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47720 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965096AbeFNX5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=epiBw9gycriQOso7ozHvBnXwCsVqI4zK2fKSuC+lyck=; b=lKa7TRl95GKwurtb3Omtq7Kpw+
        MsKQhYNhAGkWFKLZhpUiHGP/0dAkwQNXnp27ADCjGNQS/eAbIRG81XUymzqRVlG0Bkg4UwFtdQlj8
        g/2e5JtNxJx1qoYp30ShfbscuGrnrcmG0wgVCLTFvazKdpE/U8iJPLmqzcZHA2Q+SqkwWck8cp/cj
        qRpk078pJDS/54dZbjJjIAh+t+PuTEPkDTOMU26zVdqePmcFilU+eR+XMbLRvMNpkiX9rcy/WX9Ph
        ilDc2NQwSCvPDiSqj6Ig24rNz4k94zV7HH0w6K+gWRHHv/A89OhYqPwZMmcyiXQaErCRnhJ54ov7K
        CthLEkYw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTc6t-00013d-C5; Thu, 14 Jun 2018 23:56:59 +0000
Subject: Re: [PATCH v9 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To:     Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, linux-kernel@vger.kernel.org
References: <152883965482.1936.13657625103232933481.stgit@taos>
 <152883969032.1936.15155267369758178246.stgit@taos>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ae7f8610-de9a-1c0f-478f-3f7f1c6956c4@infradead.org>
Date:   Thu, 14 Jun 2018 16:56:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152883969032.1936.15155267369758178246.stgit@taos>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 02:41 PM, Gary R Hook wrote:
> Implement a skeleton framework for debugfs support in the AMD
> IOMMU.  Add an AMD-specific Kconfig boolean that depends upon
> general enablement of DebugFS in the IOMMU.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>

Gary,

Looks good to me.  Thanks.

> ---
>  drivers/iommu/Kconfig             |   12 ++++++++++++
>  drivers/iommu/Makefile            |    1 +
>  drivers/iommu/amd_iommu_debugfs.c |   33 +++++++++++++++++++++++++++++++++
>  drivers/iommu/amd_iommu_init.c    |    6 ++++--
>  drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>  drivers/iommu/amd_iommu_types.h   |    5 +++++
>  6 files changed, 61 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/amd_iommu_debugfs.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f9af25ac409f..5a9cef113763 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -146,6 +146,18 @@ config AMD_IOMMU_V2
>  	  hardware. Select this option if you want to use devices that support
>  	  the PCI PRI and PASID interface.
>  
> +config AMD_IOMMU_DEBUGFS
> +	bool "Enable AMD IOMMU internals in DebugFS"
> +	depends on AMD_IOMMU && IOMMU_DEBUGFS
> +	---help---
> +	  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!
> +
> +	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY, -REALLY- KNOW WHAT YOU ARE DOING!!!
> +	  Exposes AMD IOMMU device internals in DebugFS.
> +
> +	  This option is -NOT- intended for production environments, and should
> +	  not generally be enabled.
> +
>  # Intel IOMMU support
>  config DMAR_TABLE
>  	bool
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 74cfbc392862..47fd6ea9de2d 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
> +obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
>  obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>  obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o


-- 
~Randy
