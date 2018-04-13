Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDMXzQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 19:55:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:59211 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751793AbeDMXzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 19:55:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,446,1517904000";
   d="scan'208";a="220308799"
From: "Mehta, Sohil" <sohil.mehta@intel.com>
To: "gary.hook@amd.com" <gary.hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
Thread-Topic: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
Thread-Index: AQHTzamw6oujwkjOD0OO/ytoQI5d2qP/4BsA
Date: Fri, 13 Apr 2018 23:55:13 +0000
Message-ID: <1523663790.2747.4.camel@intel.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
         <152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
In-Reply-To: <152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.110.4]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA8854F17CA5E549851DD7A6F0711176@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3DNtLj5002627

On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
> 
> 
> +struct dentry *iommu_debugfs_setup(void)
> +{
> +	if (!debugfs_initialized())

This check is probably not needed.

> +		return NULL;
> +
> +	if (!iommu_debugfs_dir)
> +		iommu_debugfs_dir = debugfs_create_dir("iommu",
> NULL);
> +
> +	if (iommu_debugfs_dir)
> +		pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN
> ENABLED IN THIS KERNEL\n");
> +

As this gets called for each IOMMU, do you want to use pr_warn_once?

> +	return iommu_debugfs_dir;
> +}
> +EXPORT_SYMBOL_GPL(iommu_debugfs_setup);

-Sohil
