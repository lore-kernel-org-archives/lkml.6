Return-Path: <yi.l.liu@intel.com>
X-Google-Smtp-Source: AB8JxZqNuQAsDYOLzQHMHb7Hva1h3ld99BTPr1zA/m0AmrI0NhdxxHIpctPPWIqYLLk0V+5lsXDa
ARC-Seal: i=1; a=rsa-sha256; t=1526804268; cv=none;
        d=google.com; s=arc-20160816;
        b=zEuj7j/W7BhGWLCq+D8gSRGmDZG7tE6vmLTZVQtMcNn4YPYhwMv6m75OjCXdIwRyOn
         CuK4+bfOXvIcwnAh2bSMSc45DknQEx3jhsqQfi1wd7eZT62prG5p2SJbbToyHuxDePSz
         kdSGzrGlM3y+Gj2mMnvkGMQmYMDVncQINlCCOUJUi7xQtx6OkPVabvOv7N5pcnU/RsqV
         Bca+ofKuLtjlTfTgiJvuFK/ooEn5hRxgCZYWGrkXDLVOYC5+7mGfeHRfW3ZKVODvmggi
         aplNmgPlDq6tCT5XQWgGsPUsitPVp/ToNwZwqOhPOveCBzh6IHeUSnd4XiotdHE5hcFV
         CbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=2Xm3jU9yRiwyxQG4nkPCZvYsYi230wq3w73stnbGwsw=;
        b=i3GSYz4cpk9GPaxzKDKvI/VZqOlhA4MLR1Vf4Sd5KEcxcCE+9nIO5D4TUpuyqthKsd
         mFBwkaxTOg+THAYOiFg+6Z3XPLbnbDi3TVmq1AdmXhcm2DPuucvuEN2dTyEdziXmAmeW
         vZNJYszRO0Cov+scdKHDwHNZeqmgZjPMwybLMMtIiTTo54AFJ5ryCVc86C4/iNRmqcOC
         DGBCV9gX72XoIhOQryAQajoAFQNBnnxQOkXn6kolAQunkG92yrDp+yonPFSX9yCBqyui
         EXwemOLBPehVSbZX2xCkB+mF4JRCqQHGI5n7sZPKfol5YgEpLtZIXkyD9Wr6WHaFDgWX
         CxBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yi.l.liu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=yi.l.liu@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yi.l.liu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=yi.l.liu@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,422,1520924400";
   d="scan'208";a="43236986"
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Jean Delvare
	<khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Yi L <yi.l.liu@linux.intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML
	<linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: RE: [PATCH v4 10/22] iommu: introduce device fault data
Thread-Topic: [PATCH v4 10/22] iommu: introduce device fault data
Thread-Index: AQHT1cxs8lFP2WE/GEWKfhv4WmyUHaQ4ZabA
Date: Sun, 20 May 2018 08:17:43 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BF3E05@SHSMSX104.ccr.corp.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-11-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1523915351-54415-11-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTUyNTMwZTYtZTUzZi00MDcyLWJlMmUtNGVhMGE1ZWJiMTc5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS0VLcytTZ1RMNFdoTm51TndJeGRrdlVpTlVhQ2lHOEY1U29kc1wvTFloTDdxZEF0anVlQnlObHJmdDdrSnpWNEoifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910604906206?=
X-GMAIL-MSGID: =?utf-8?q?1600970312492683673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jacob,

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Tuesday, April 17, 2018 5:49 AM
>  include/linux/iommu.h | 102
> +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e963dbd..8968933 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -49,13 +49,17 @@ struct bus_type;
>  struct device;
>  struct iommu_domain;
>  struct notifier_block;
> +struct iommu_fault_event;
>=20
>  /* iommu fault flags */
> -#define IOMMU_FAULT_READ	0x0
> -#define IOMMU_FAULT_WRITE	0x1
> +#define IOMMU_FAULT_READ		(1 << 0)
> +#define IOMMU_FAULT_WRITE		(1 << 1)
> +#define IOMMU_FAULT_EXEC		(1 << 2)
> +#define IOMMU_FAULT_PRIV		(1 << 3)
>=20
>  typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
>  			struct device *, unsigned long, int, void *);
> +typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, voi=
d *);
>=20
>  struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be mapped    */
> @@ -264,6 +268,99 @@ struct iommu_device {
>  	struct device *dev;
>  };
>=20
> +/*  Generic fault types, can be expanded IRQ remapping fault */
> +enum iommu_fault_type {
> +	IOMMU_FAULT_DMA_UNRECOV =3D 1,	/* unrecoverable fault */
> +	IOMMU_FAULT_PAGE_REQ,		/* page request fault */
> +};
> +
> +enum iommu_fault_reason {
> +	IOMMU_FAULT_REASON_UNKNOWN =3D 0,
> +
> +	/* IOMMU internal error, no specific reason to report out */
> +	IOMMU_FAULT_REASON_INTERNAL,
> +
> +	/* Could not access the PASID table */
> +	IOMMU_FAULT_REASON_PASID_FETCH,
> +
> +	/*
> +	 * PASID is out of range (e.g. exceeds the maximum PASID
> +	 * supported by the IOMMU) or disabled.
> +	 */
> +	IOMMU_FAULT_REASON_PASID_INVALID,
> +
> +	/* Could not access the page directory (Invalid PASID entry) */
> +	IOMMU_FAULT_REASON_PGD_FETCH,
> +
> +	/* Could not access the page table entry (Bad address) */
> +	IOMMU_FAULT_REASON_PTE_FETCH,
> +
> +	/* Protection flag check failed */
> +	IOMMU_FAULT_REASON_PERMISSION,
> +};
> +
> +/**
> + * struct iommu_fault_event - Generic per device fault data
> + *
> + * - PCI and non-PCI devices
> + * - Recoverable faults (e.g. page request), information based on PCI AT=
S
> + * and PASID spec.
> + * - Un-recoverable faults of device interest
> + * - DMA remapping and IRQ remapping faults
> +
> + * @type contains fault type.
> + * @reason fault reasons if relevant outside IOMMU driver, IOMMU driver =
internal
> + *         faults are not reported
> + * @addr: tells the offending page address
> + * @pasid: contains process address space ID, used in shared virtual mem=
ory(SVM)
> + * @rid: requestor ID
> + * @page_req_group_id: page request group index
> + * @last_req: last request in a page request group
> + * @pasid_valid: indicates if the PRQ has a valid PASID
> + * @prot: page access protection flag, e.g. IOMMU_FAULT_READ,
> IOMMU_FAULT_WRITE
> + * @device_private: if present, uniquely identify device-specific
> + *                  private data for an individual page request.
> + * @iommu_private: used by the IOMMU driver for storing fault-specific
> + *                 data. Users should not modify this field before
> + *                 sending the fault response.
> + */
> +struct iommu_fault_event {
> +	enum iommu_fault_type type;
> +	enum iommu_fault_reason reason;
> +	u64 addr;
> +	u32 pasid;
> +	u32 page_req_group_id;
> +	u32 last_req : 1;
> +	u32 pasid_valid : 1;
> +	u32 prot;

I think userspace also needs to know the fault type, reason, pasid, addr, g=
oup_id,
prot. So the definition should be included in uapi/Linux/iommu.h.

This comment also applies to "struct page_response_msg". Qemu also wants to
pass the page response to host.

> +	u64 device_private;
> +	u64 iommu_private;

These two seems to be in kernel driver specific data. May split the iommu_f=
ault_event
definition into two parts. One part for the data required by both driver an=
d userspace.
One part for in kernel driver specific data.

Thanks,
Yi Liu
