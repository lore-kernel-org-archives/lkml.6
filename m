Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C42C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79744208D6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79744208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeHXQzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:55:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeHXQzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:55:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20FD940216E8;
        Fri, 24 Aug 2018 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-161.ams2.redhat.com [10.36.116.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87ED11003213;
        Fri, 24 Aug 2018 13:20:15 +0000 (UTC)
Subject: Re: [RFC 01/13] iommu: Introduce bind_guest_stage API
To:     "Liu, Yi L" <yi.l.liu@intel.com>, "\"eric.auger.pro"@gmail.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jean-philippe.brucker@arm.com,
        jacob.jun.pan@linux.intel.com,
        "yi.l.liu\"@linux.intel.com" <"\"eric.auger.pro"@gmail.co>,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jean-philippe.brucker@arm.com,
        jacob.jun.pan@linux.intel.com, "yi.l.liu\""@linux.intel.com,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-2-git-send-email-eric.auger@redhat.com>
 <A2975661238FB949B60364EF0F2C257439CCE9EE@SHSMSX104.ccr.corp.intel.com>
Cc:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <04f9fcdb-abc7-dded-f3cd-8c258e66983f@redhat.com>
Date:   Fri, 24 Aug 2018 15:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439CCE9EE@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 24 Aug 2018 13:20:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 24 Aug 2018 13:20:23 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi Liu,

On 08/24/2018 02:53 PM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
>> bounces@lists.linux-foundation.org] On Behalf Of Eric Auger
>> Sent: Thursday, August 23, 2018 8:17 PM
>> Subject: [RFC 01/13] iommu: Introduce bind_guest_stage API
>>
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>
>> In virtualization use case, when a guest is assigned
>> a PCI host device, protected by a virtual IOMMU on a guest,
>> the physical IOMMU must be programmed to be consistent with
>> the guest mappings. If the physical IOMMU supports two
>> translation stages it makes sense to program guest mappings
>> onto the first stage while to host owns the stage 2.
>>
>> In that case, it is mandated to trap on guest configuration
>> settings and pass those to the physical iommu driver.
>>
>> This patch adds a new API to the iommu subsystem that allows
>> to bind and unbind the guest configuration data to the host.
>>
>> A generic iommu_guest_stage_config struct is introduced in
>> a new iommu.h uapi header. This is going to be used by the VFIO
>> user API. We foresee at least 2 specialization of this struct,
>> for PASID table passing and ARM SMMUv3.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> This patch generalizes the API introduced by Jacob & co-authors in
>> https://lwn.net/Articles/754331/
>> ---
>>  drivers/iommu/iommu.c      | 19 +++++++++++++++
>>  include/linux/iommu.h      | 23 ++++++++++++++++++
>>  include/uapi/linux/iommu.h | 59
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 101 insertions(+)
>>  create mode 100644 include/uapi/linux/iommu.h
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 63b3756..5156172 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1326,6 +1326,25 @@ int iommu_attach_device(struct iommu_domain
>> *domain, struct device *dev)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_attach_device);
>>
>> +int iommu_bind_guest_stage(struct iommu_domain *domain, struct device *dev,
>> +			   struct iommu_guest_stage_config *cfg)
>> +{
>> +	if (unlikely(!domain->ops->bind_guest_stage))
>> +		return -ENODEV;
>> +
>> +	return domain->ops->bind_guest_stage(domain, dev, cfg);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_bind_guest_stage);
>> +
>> +void iommu_unbind_guest_stage(struct iommu_domain *domain, struct device
>> *dev)
>> +{
>> +	if (unlikely(!domain->ops->unbind_guest_stage))
>> +		return;
>> +
>> +	domain->ops->unbind_guest_stage(domain, dev);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_unbind_guest_stage);
>> +
>>  static void __iommu_detach_device(struct iommu_domain *domain,
>>  				  struct device *dev)
>>  {
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 19938ee..aec853d 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -25,6 +25,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/err.h>
>>  #include <linux/of.h>
>> +#include <uapi/linux/iommu.h>
>>
>>  #define IOMMU_READ	(1 << 0)
>>  #define IOMMU_WRITE	(1 << 1)
>> @@ -187,6 +188,8 @@ struct iommu_resv_region {
>>   * @domain_get_windows: Return the number of windows for a domain
>>   * @of_xlate: add OF master IDs to iommu grouping
>>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>> + * @bind_guest_stage: program the guest stage configuration
>> + * @unbind_guest_stage: unbind the guest stage and restore defaults
>>   */
>>  struct iommu_ops {
>>  	bool (*capable)(enum iommu_cap);
>> @@ -235,6 +238,11 @@ struct iommu_ops {
>>  	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
>>  	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device
>> *dev);
>>
>> +	int (*bind_guest_stage)(struct iommu_domain *domain, struct device *dev,
>> +				struct iommu_guest_stage_config *cfg);
>> +	void (*unbind_guest_stage)(struct iommu_domain *domain,
>> +				   struct device *dev);
>> +
>>  	unsigned long pgsize_bitmap;
>>  };
>>
>> @@ -296,6 +304,10 @@ extern int iommu_attach_device(struct iommu_domain
>> *domain,
>>  			       struct device *dev);
>>  extern void iommu_detach_device(struct iommu_domain *domain,
>>  				struct device *dev);
>> +extern int iommu_bind_guest_stage(struct iommu_domain *domain,
>> +		struct device *dev, struct iommu_guest_stage_config *cfg);
>> +extern void iommu_unbind_guest_stage(struct iommu_domain *domain,
>> +				     struct device *dev);
>>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>>  		     phys_addr_t paddr, size_t size, int prot);
>> @@ -696,6 +708,17 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct
>> fwnode_handle *fwnode)
>>  	return NULL;
>>  }
>>
>> +static inline
>> +int iommu_bind_guest_stage(struct iommu_domain *domain, struct device *dev,
>> +			   struct iommu_guest_stage_config *cfg)
>> +{
>> +	return -ENODEV;
>> +}
>> +static inline
>> +void iommu_unbind_guest_stage(struct iommu_domain *domain, struct device
>> *dev)
>> +{
>> +}
>> +
>>  #endif /* CONFIG_IOMMU_API */
>>
>>  #endif /* __LINUX_IOMMU_H */
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> new file mode 100644
>> index 0000000..2d1593c
>> --- /dev/null
>> +++ b/include/uapi/linux/iommu.h
>> @@ -0,0 +1,59 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * IOMMU user API definitions
>> + *
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef _UAPI_IOMMU_H
>> +#define _UAPI_IOMMU_H
>> +
>> +#include <linux/types.h>
>> +
>> +/**
>> + * PASID table data used to bind guest PASID table to the host IOMMU. This will
>> + * enable guest managed first level page tables.
>> + * @version: for future extensions and identification of the data format
>> + * @bytes: size of this structure
>> + * @base_ptr:	PASID table pointer
>> + * @pasid_bits:	number of bits supported in the guest PASID table, must be
>> less
>> + *		or equal than the host supported PASID size.
>> + */
>> +struct iommu_pasid_table_config {
>> +	__u32 version;
>> +#define PASID_TABLE_CFG_VERSION_1 1
>> +	__u32 bytes;
>> +	__u64 base_ptr;
>> +	__u8 pasid_bits;
>> +};
>> +
>> +/**
>> + * Stream Table Entry S1 info
>> + * @disabled: the smmu is disabled
>> + * @bypassed: stage 1 is bypassed
>> + * @aborted: aborted
>> + * @cdptr_dma: GPA of the Context Descriptor
>> + * @asid: address space identified associated to the CD
>> + */
>> +struct iommu_smmu_s1_config {
>> +	__u8 disabled;
>> +	__u8 bypassed;
>> +	__u8 aborted;
>> +	__u64 cdptr_dma;
> 
> If I'm getting it correctly, so with cdptr_dma configed on
> host, hardware can access guest's CD table when nested
> stage is setup on host. Is it? If yes, I think it is similar with
> the base_ptr field in struct iommu_pasid_table_config.

Yes you're right, this is similar to base_ptr.

Thanks

Eric
> 
>> +	__u16 asid;
>> +};
>> +
>> +struct iommu_guest_stage_config {
>> +#define PASID_TABLE	(1 << 0)
>> +#define SMMUV3_S1_CFG	(1 << 1)
>> +	__u32 flags;
>> +	union {
>> +		struct iommu_pasid_table_config pasidt;
>> +		struct iommu_smmu_s1_config smmu_s1;
>> +	};
>> +};
>> +
>> +#endif /* _UAPI_IOMMU_H */
> 
> Thanks,
> Yi Liu
> 
