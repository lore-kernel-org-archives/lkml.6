Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C359C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 22:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F68206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 22:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeLOWib convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 17:38:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:35114 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbeLOWia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 17:38:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2018 14:38:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,358,1539673200"; 
   d="scan'208";a="126264857"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 15 Dec 2018 14:38:29 -0800
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 15 Dec 2018 14:38:29 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 15 Dec 2018 14:38:29 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.203]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.201]) with mapi id 14.03.0415.000;
 Sun, 16 Dec 2018 06:38:27 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Zeng, Xin" <xin.zeng@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [RFC PATCH 1/5] iommu: Add APIs for IOMMU PASID management
Thread-Topic: [RFC PATCH 1/5] iommu: Add APIs for IOMMU PASID management
Thread-Index: AQHUelOoaj4q5o5bw0yVukg2nF8lF6WAlpzw
Date:   Sat, 15 Dec 2018 22:38:26 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D8E060@SHSMSX104.ccr.corp.intel.com>
References: <20181112064501.2290-1-baolu.lu@linux.intel.com>
 <20181112064501.2290-2-baolu.lu@linux.intel.com>
In-Reply-To: <20181112064501.2290-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjBkNWIwYmQtYWQyMS00ZGFkLTgxNzktMDFjMGRlZjM1NjliIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSkVzWnpuU2VYNXB4dDJrYUNKT2Jydzd4bWYyeXVMdHpXWVp2eHdRdmZVWmlUQmRCTnVQYlJFQ0UwcnZ4M2l5ZSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Sunday, November 11, 2018 10:45 PM
> Subject: [RFC PATCH 1/5] iommu: Add APIs for IOMMU PASID management
> 
> This adds APIs for IOMMU drivers and device drivers to manage the PASIDs used for
> DMA transfer and translation. It bases on I/O ASID allocator for PASID namespace
> management and relies on vendor specific IOMMU drivers for paravirtual PASIDs.
> 
> Below APIs are added:
> 
> * iommu_pasid_init(pasid)
>   - Initialize a PASID consumer. The vendor specific IOMMU
>     drivers are able to set the PASID range imposed by IOMMU
>     hardware through a callback in iommu_ops.
> 
> * iommu_pasid_exit(pasid)
>   - The PASID consumer stops consuming any PASID.
> 
> * iommu_pasid_alloc(pasid, min, max, private, *ioasid)
>   - Allocate a PASID and associate a @private data with this
>     PASID. The PASID value is stored in @ioaisd if returning
>     success.
> 
> * iommu_pasid_free(pasid, ioasid)
>   - Free a PASID to the pool so that it could be consumed by
>     others.
> 
> This also adds below helpers to lookup or iterate PASID items associated with a
> consumer.
> 
> * iommu_pasid_for_each(pasid, func, data)
>   - Iterate PASID items of the consumer identified by @pasid,
>     and call @func() against each item. An error returned from
>     @func() will break the iteration.
> 
> * iommu_pasid_find(pasid, ioasid)
>   - Retrieve the private data associated with @ioasid.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/Kconfig |  1 +
>  drivers/iommu/iommu.c | 89 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h | 73 +++++++++++++++++++++++++++++++++++
>  3 files changed, 163 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig index
> d9a25715650e..39f2bb76c7b8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -1,6 +1,7 @@
>  # IOMMU_API always gets selected by whoever wants it.
>  config IOMMU_API
>  	bool
> +	select IOASID
> 
>  menuconfig IOMMU_SUPPORT
>  	bool "IOMMU Hardware Support"
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
> 0b7c96d1425e..570b244897bb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2082,3 +2082,92 @@ void iommu_detach_device_aux(struct iommu_domain
> *domain, struct device *dev)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(iommu_detach_device_aux);
> +
> +/*
> + * APIs for PASID used by IOMMU and the device drivers which depend
> + * on IOMMU.
> + */
> +struct iommu_pasid *iommu_pasid_init(struct bus_type *bus) {

I'm thinking about if using struct iommu_domain here is better
than struct bus_type. The major purpose is to pass iommu_ops
in it and route into iommu-sublayer. iommu_domain may be
better since some modules like vfio_iommu_type1 would use
iommu_domain more than bus type.

Thanks,
Yi Liu

