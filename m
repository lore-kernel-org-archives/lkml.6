Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeDQAwc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 20:52:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:25175 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752981AbeDQAwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 20:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,461,1517904000";
   d="scan'208";a="33878543"
From: "Mehta, Sohil" <sohil.mehta@intel.com>
To: "gary.hook@amd.com" <gary.hook@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Topic: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Index: AQHT1eZcbGSq7dmBrE2nNUs46v6qOg==
Date: Tue, 17 Apr 2018 00:52:29 +0000
Message-ID: <1523926423.2747.19.camel@intel.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
         <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
In-Reply-To: <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.110.4]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5DC3B183190CD4097E64C96E61F3ED1@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3H0qaje028944

On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 5eb1121d54b9..0ca250f626d9 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU) += of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
> +obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o

Compiling amd_iommu_debugfs.c seems to depend only
on CONFIG_IOMMU_DEBUG. Can we prevent the code within
amd_iommu_debugfs.c from getting compiled when either CONFIG_AMD_IOMMU
or CONFIG_IOMMU_DEBUG is disabled?

>  obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>  obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
