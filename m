Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A1AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF44C20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ISpqfZWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfAOO02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:26:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36155 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAOO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:26:27 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so2700581edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 06:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4lzSCAuAoW9iwfDUZ4nlE06FXEzsmJuNPwYxwN/FLuQ=;
        b=ISpqfZWhAyl9OpnGPTm5nrM3s+N4RLtWBbRY/wyuqYM/I1XtX1eKgTViC7bh84rfFg
         9dkjTGmkoCdIx3ojBDO0LDhYqlrrkKWxMGE3ec1oXQGIW+I8JSD1aK+eZ3tSbzQ9idF1
         XIzSoR7F7TJc0WDoYnAAQRc+1r219H7NDV0Hd0zueZAQA8ESRGMlu/efZTjwTOp3UY4Y
         W60P4DiRx9bC5gWXFIb70UKK7iPPcHtKWVwhI9RXkxS/dGejAMmbH9CFGqnR/7PTVbjE
         rAS1Vj/rQtdFHRxg5UbUAR0f2/W/Prwj11q7YTJSxX1vd/ab0ITfbx8q7ZYut3tStEHX
         fDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4lzSCAuAoW9iwfDUZ4nlE06FXEzsmJuNPwYxwN/FLuQ=;
        b=DpEfmpB4B7sXrPSMGxF8vH42TPRE1s187yrbqNIe0SxQVk59OXxm/l52fOOVLT2AQ7
         2WwPTEeHogdMah2mGclHeirQ4lDJ1UCmdwbjHTu1BKYYppLSzbPHJMkeEcGmfGpEx8Kt
         tRUhpI/biyeXpJALPfgdWSMRXhLfrGBJDIDRYtLiSKMCzNWxaw5yXPP/f2BcCVo+R2cQ
         N6eQ9LAKIuA3D3tcklzchAxYg1vMgpcbMB/TVrhDbeIjwudr/cnLBL9KMr4KxVF9XS2d
         LSAigzxfBrEgZa2WXG912PbGxx74aocaM6Z9APB8VFM/Xl95XXOYJI4f8EeeZsRmh79m
         3kBQ==
X-Gm-Message-State: AJcUukeUJ8GsCfwPfvzWfv5Fjy3uqVBkoyXGVB9PmK0mJWeJ2h+Wskh6
        7Hojxc2VI+i1x9anrihmv7xRSA==
X-Google-Smtp-Source: ALg8bN4iJ8KiHHFCv/jRxMK9p6WFRKCwpIKCwztWaAPfbqX2wX7Q9ljxZAklOooyT9cOXPn7APndXw==
X-Received: by 2002:a50:8a45:: with SMTP id i63mr3691640edi.262.1547562384230;
        Tue, 15 Jan 2019 06:26:24 -0800 (PST)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r23-v6sm2780196eji.64.2019.01.15.06.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 06:26:23 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC v2] iommu/vt-d: Allow iommu_domain_alloc to allocate
 IOMMU_DOMAIN_DMA
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <20190107120453.7bbaa4b2@jacob-builder>
Date:   Tue, 15 Jan 2019 14:26:07 +0000
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <30DC6AA0-B87C-43C5-A0A8-76CEC49FE30A@arista.com>
References: <E1FC52F0-B31C-4FB5-9C57-C72E5F4BCBCE@arista.com>
 <20190107120453.7bbaa4b2@jacob-builder>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jacob,

> On 7 Jan 2019, at 20:04, Jacob Pan <jacob.jun.pan@linux.intel.com> =
wrote:
>=20
> On Wed, 5 Dec 2018 17:19:35 +0000
> James Sewart <jamessewart@arista.com> wrote:
>=20
>> Hey,
>>=20
>> There exists an issue in the logic used to determine domain
>> association with devices. Currently the driver uses
>> find_or_alloc_domain to either reuse an existing domain or allocate a
>> new one if one isn=E2=80=99t found. Domains should be shared between =
all
>> members of an IOMMU group as this is the minimum granularity that we
>> can guarantee address space isolation.
>>=20
>> The intel IOMMU driver exposes pci_device_group in intel_iommu_ops as
>> the function to call to determine the group of a device, this is
>> implemented in the generic IOMMU code and checks: dma aliases,
>> upstream pcie switch ACS, pci aliases, and pci function aliases. The
>> find_or_alloc_domain code currently only uses dma aliases to
>> determine if a domain is shared. This causes a disconnect between
>> IOMMU groups and domains. We have observed devices under a pcie
>> switch each having their own domain but assigned the same group.
>>=20
>> One solution would be to fix the logic in find_or_alloc_domain to add=20=

>> checks for the other conditions that a device may share a domain.
>> However, this duplicates code which the generic IOMMU code
>> implements. Instead this issue can be fixed by allowing the
>> allocation of default_domain on the IOMMU group. This is not
>> currently supported as the intel driver does not allow allocation of
>> domain type IOMMU_DOMAIN_DMA.
>>=20
>> Allowing allocation of DMA domains has the effect that the
>> default_domain is non NULL and is attached to a device when
>> initialising. This delegates the handling of domains to the generic
>> IOMMU code. Once this is implemented it is possible to remove the
>> lazy allocation of domains entirely.
>>=20
> This can also consolidate the domain storage, i.e. move domain from
> device_domain_info to iommu_group.

The plan was to have a patchset that first added the functionality =
below,=20
making use of the group domain storage but keeping the lazy allocation.=20=

Then subsequent patches that remove the lazy allocation. To also remove=20=

the device_domain_info it looks like some of the information there might=20=

need moving into the domain?

>> This patch implements DMA and identity domains to be allocated for=20
>> external management. As it isn=E2=80=99t known which device will be =
attached
>> to a domain, the dma domain is not initialised at alloc time. Instead
>> it is allocated when attached. As we may lose RMRR mappings when
>> attaching a device to a new domain, we also ensure these are mapped
>> at attach time.
>>=20
>> This will likely conflict with the work done for auxiliary domains by=20=

>> Baolu but the code to accommodate won=E2=80=99t change much.
>>=20
>> I had also started on a patch to remove find_or_alloc_domain and
>> various functions that call it but had issues with edge cases such as=20=

>> iommu_prepare_isa that is doing domain operations at IOMMU init time.
>>=20
>> Cheers,
>> James.
>>=20
>>=20
>> ---
>> drivers/iommu/intel-iommu.c | 159
>> +++++++++++++++++++++++++----------- 1 file changed, 110
>> insertions(+), 49 deletions(-)
>>=20
>> diff --git a/drivers/iommu/intel-iommu.c =
b/drivers/iommu/intel-iommu.c
>> index 41a4b8808802..6437cb2e9b22 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -351,6 +351,14 @@ static int hw_pass_through =3D 1;
>> /* si_domain contains mulitple devices */
>> #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
>>=20
>> +/* Domain managed externally, don't cleanup if it isn't attached
>> + * to any devices. */
>> +#define DOMAIN_FLAG_NO_CLEANUP	(1 << 2)
>> +
> the name NO_CLEANUP is a little counter intuitive to me, should it be
> called UNINITIALISED?

I don=E2=80=99t think uninitialised is accurate, the domain may be =
initialised. It=20
is used to distinguish between domains allocated by the external API,=20
which we shouldn=E2=80=99t automatically cleanup, and domains allocated =
internally,=20
which should. I agree a better name could be found.

>> +/* Set after domain initialisation. Used when allocating dma domains
>> to
>> + * defer domain initialisation until it is attached to a device */
>> +#define DOMAIN_FLAG_INITIALISED	(1 << 4)
>> +
>> #define for_each_domain_iommu(idx, domain)			\
>> 	for (idx =3D 0; idx < g_num_of_iommus; idx++)		\
>> 		if (domain->iommu_refcnt[idx])
>> @@ -624,6 +632,16 @@ static inline int domain_type_is_vm_or_si(struct
>> dmar_domain *domain) DOMAIN_FLAG_STATIC_IDENTITY);
>> }
>>=20
>> +static inline int domain_managed_externally(struct dmar_domain
>> *domain) +{
>> +	return domain->flags & DOMAIN_FLAG_NO_CLEANUP;
>> +}
>> +
>> +static inline int domain_is_initialised(struct dmar_domain *domain)
>> +{
>> +	return domain->flags & DOMAIN_FLAG_INITIALISED;
>> +}
>> +
>> static inline int domain_pfn_supported(struct dmar_domain *domain,
>> 				       unsigned long pfn)
>> {
>> @@ -1717,7 +1735,7 @@ static void disable_dmar_iommu(struct
>> intel_iommu *iommu)=20
>> 		__dmar_remove_one_dev_info(info);
>>=20
>> -		if (!domain_type_is_vm_or_si(domain)) {
>> +		if (!domain_managed_externally(domain)) {
>> 			/*
>> 			 * The domain_exit() function  can't be
>> called under
>> 			 * device_domain_lock, as it takes this lock
>> itself. @@ -1951,6 +1969,7 @@ static int domain_init(struct
>> dmar_domain *domain, struct intel_iommu *iommu, domain->pgd =3D =
(struct
>> dma_pte *)alloc_pgtable_page(domain->nid); if (!domain->pgd)
>> 		return -ENOMEM;
>> +	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
>> 	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
>> 	return 0;
>> }
>> @@ -3234,11 +3253,9 @@ static int copy_translation_tables(struct
>> intel_iommu *iommu) static int __init init_dmars(void)
>> {
>> 	struct dmar_drhd_unit *drhd;
>> -	struct dmar_rmrr_unit *rmrr;
>> 	bool copied_tables =3D false;
>> -	struct device *dev;
>> 	struct intel_iommu *iommu;
>> -	int i, ret;
>> +	int ret;
>>=20
>> 	/*
>> 	 * for each drhd
>> @@ -4529,7 +4522,7 @@ static int device_notifier(struct
>> notifier_block *nb, return 0;
>>=20
>> 	dmar_remove_one_dev_info(domain, dev);
>> -	if (!domain_type_is_vm_or_si(domain) &&
>> list_empty(&domain->devices))
>> +	if (!domain_managed_externally(domain) &&
>> list_empty(&domain->devices)) domain_exit(domain);
>>=20
>> 	return 0;
>> @@ -4930,6 +4923,7 @@ static int md_domain_init(struct dmar_domain
>> *domain, int guest_width) domain->pgd =3D (struct dma_pte
>> *)alloc_pgtable_page(domain->nid); if (!domain->pgd)
>> 		return -ENOMEM;
>> +	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
>> 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
>> 	return 0;
>> }
>> @@ -4938,28 +4932,65 @@ static struct iommu_domain
>> *intel_iommu_domain_alloc(unsigned type) {
>> 	struct dmar_domain *dmar_domain;
>> 	struct iommu_domain *domain;
>> +	int flags =3D DOMAIN_FLAG_NO_CLEANUP;
>> +	int nid;
>>=20
>> -	if (type !=3D IOMMU_DOMAIN_UNMANAGED)
>> -		return NULL;
>> -
>> -	dmar_domain =3D alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
>> -	if (!dmar_domain) {
>> -		pr_err("Can't allocate dmar_domain\n");
>> -		return NULL;
>> -	}
>> -	if (md_domain_init(dmar_domain,
>> DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
>> -		pr_err("Domain initialization failed\n");
>> -		domain_exit(dmar_domain);
>> +	switch (type) {
>> +	case IOMMU_DOMAIN_UNMANAGED:
>> +		flags |=3D DOMAIN_FLAG_VIRTUAL_MACHINE |
>> DOMAIN_FLAG_INITIALISED;
>> +		dmar_domain =3D alloc_domain(flags);
>> +		if (!dmar_domain) {
>> +			pr_err("Can't allocate dmar_domain\n");
>> +			return NULL;
>> +		}
>> +		if (md_domain_init(dmar_domain,
>> DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
>> +			pr_err("Domain initialization failed\n");
>> +			domain_exit(dmar_domain);
>> +			return NULL;
>> +		}
>> +		domain_update_iommu_cap(dmar_domain);
>> +		domain->geometry.aperture_start =3D 0;
>> +		domain->geometry.aperture_end   =3D
>> __DOMAIN_MAX_ADDR(dmar_domain->gaw);
>> +		domain->geometry.force_aperture =3D true;
>> +		break;
>> +	case IOMMU_DOMAIN_DMA:
>> +		dmar_domain =3D alloc_domain(flags);
>> +		if (!dmar_domain) {
>> +			pr_err("Can't allocate dmar_domain\n");
>> +			return NULL;
>> +		}
>> +		/* init domain in device attach when we know IOMMU
>> capabilities */
>> +		break;
>> +	case IOMMU_DOMAIN_IDENTITY:
>> +		flags |=3D DOMAIN_FLAG_STATIC_IDENTITY |
>> DOMAIN_FLAG_INITIALISED;
>> +		dmar_domain =3D alloc_domain(flags);
>> +		if (!dmar_domain) {
>> +			pr_err("Can't allocate dmar_domain\n");
>> +			return NULL;
>> +		}
>> +		if (md_domain_init(dmar_domain,
>> DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
>> +			pr_err("Domain initialization failed\n");
>> +			domain_exit(dmar_domain);
>> +			return NULL;
>> +		}
>> +		domain_update_iommu_cap(dmar_domain);
>> +		for_each_online_node(nid) {
>> +			unsigned long start_pfn, end_pfn;
>> +			int i, ret;
>> +
>> +			for_each_mem_pfn_range(i, nid, &start_pfn,
>> &end_pfn, NULL) {
>> +				ret =3D
>> iommu_domain_identity_map(dmar_domain,
>> +						PFN_PHYS(start_pfn),
>> PFN_PHYS(end_pfn));
>> +				if (ret)
>> +					return NULL;
>> +			}
>> +		}
>> +		break;
>> +	default:
>> 		return NULL;
>> 	}
>> -	domain_update_iommu_cap(dmar_domain);
>> -
>> -	domain =3D &dmar_domain->domain;
>> -	domain->geometry.aperture_start =3D 0;
>> -	domain->geometry.aperture_end   =3D
>> __DOMAIN_MAX_ADDR(dmar_domain->gaw);
>> -	domain->geometry.force_aperture =3D true;
>>=20
>> -	return domain;
>> +	return &dmar_domain->domain;
>> }
>>=20
>> static void intel_iommu_domain_free(struct iommu_domain *domain)
>> @@ -4974,6 +5005,9 @@ static int intel_iommu_attach_device(struct
>> iommu_domain *domain, struct intel_iommu *iommu;
>> 	int addr_width;
>> 	u8 bus, devfn;
>> +	struct dmar_rmrr_unit *rmrr;
>> +	struct device *i_dev;
>> +	int i, ret;
>>=20
>> 	if (device_is_rmrr_locked(dev)) {
>> 		dev_warn(dev, "Device is ineligible for IOMMU domain
>> attach due to platform RMRR requirement.  Contact your platform
>> vendor.\n"); @@ -4990,8 +5024,8 @@ static int
>> intel_iommu_attach_device(struct iommu_domain *domain,
>> dmar_remove_one_dev_info(old_domain, dev); rcu_read_unlock();=20
>> -			if (!domain_type_is_vm_or_si(old_domain) &&
>> -			     list_empty(&old_domain->devices))
>> +			if (list_empty(&old_domain->devices) &&
>> +			     !domain_managed_externally(old_domain))
>> 				domain_exit(old_domain);
> If the old_domain is allocated by lazy DMA map call, the default =
domain
> is not used in any case, right? why can't you use the default domain
> for map call? I guess that is the next step?

With just this patch the default domain will be attached to all devices=20=

during generic IOMMU code initialisation. A device may or may not have =
had=20
a domain lazy allocated at this point depending on whether a map call =
has=20
been made yet, i.e. for RMRR.

After the default domain is attached, subsequent map calls will use the=20=

default domain.

>> 		}
>> 	}
>> @@ -5000,6 +5034,12 @@ static int intel_iommu_attach_device(struct
>> iommu_domain *domain, if (!iommu)
>> 		return -ENODEV;
>>=20
>> +	/* Initialise domain with IOMMU capabilities if it isn't
>> already initialised */
>> +	if (!domain_is_initialised(dmar_domain)) {
>> +		if (domain_init(dmar_domain, iommu,
>> DEFAULT_DOMAIN_ADDRESS_WIDTH))
>> +			return -ENOMEM;
>> +	}
>> +
>> 	/* check if this iommu agaw is sufficient for max mapped
>> address */ addr_width =3D agaw_to_width(iommu->agaw);
>> 	if (addr_width > cap_mgaw(iommu->cap))
>> @@ -5028,6 +5068,27 @@ static int intel_iommu_attach_device(struct
>> iommu_domain *domain, dmar_domain->agaw--;
>> 	}
>>=20
>> +	if (domain_type_is_vm_or_si(dmar_domain))
>> +		goto out;
>> +
>> +	/* Ensure DMA domain has devices RMRR */
>> +	rcu_read_lock();
>> +	for_each_rmrr_units(rmrr) {
>> +		for_each_active_dev_scope(rmrr->devices,
>> rmrr->devices_cnt,
>> +					  i, i_dev) {
>> +			if (i_dev !=3D dev)
> why do we need to go through all devices, can we deduce the =
information
> from device_domain_info? If RMRR is already mapped during init_dmar.

I am unsure the best way to implement this. Currently RMRR structures =
are=20
setup so that we find applicable devices inside the RMRR struct, rather=20=

than finding the RMRR via a device struct. I don=E2=80=99t think you can =
get the=20
RMRR info for a device via the device_domain_info struct.

I realised after posting this that the desired behaviour is already=20
implemented by intel_iommu_get_resv_regions. Currently this function is=20=

used for exposing RMRR information via sysfs, but it is also used for=20
group domains to make identity mappings. We would automatically get the=20=

desired behaviour by supporting default_domain.

The RMRR mappings done in init_dmar are lost when attaching a new domain=20=

and I think they can/should be removed. I=E2=80=99m unsure if it is =
desirable to=20
inherit mappings of an old domain when attaching a new one, given the=20
generic IOMMU code will try to remap the RMRR regions anyway.

>> +				continue;
>> +
>> +			ret =3D domain_prepare_identity_map(dev,
>> dmar_domain,
>> +
>> rmrr->base_address,
>> +
>> rmrr->end_address);
>> +			if (ret)
>> +				dev_err(dev, "Mapping reserved
>> region failed\n");
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +
>> +out:
> Isn't it duplicate with the RMRR setup in init_dmars? I am guessing,
> for device with RMRR, we can reuse the domain setup up during init
> time, just inherit the mappings.

As I said above I don=E2=80=99t think this is the best way to implement =
RMRR=E2=80=99s. It=20
will be tricky to correctly inherit mappings and it will be simpler to=20=

remove RMRR setup in init_dmars and instead delegate the mapping to the=20=

generic IOMMU steup.

>=20
>> 	return domain_add_dev_info(dmar_domain, dev);
>> }

