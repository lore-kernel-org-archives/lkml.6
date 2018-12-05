Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB7DC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB54A20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ghSBNkOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB54A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeLERTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:19:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34078 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbeLERTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:19:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so10388367plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=/ooaWBxqU52fx4GnhtJLeZwXkoPAY2Jx4Y/ereta9V4=;
        b=ghSBNkOzJkzKxMVg1uwReJo+EztBjhDs4WJM6w/1E8eZ6zd9Idx2hDPfXSNK9aPzRA
         GkCrX6y4l5iMtcw2yNvd5di4mh/R9iCqaqnOvHd8SGrPsHaneMSL0EeFsElYGf3pwG3A
         IuO/ey6/VlNRaSzuhTYMtcqxe+sxxL0vtQ+BiCQ8v0UgsRAt0OZkcpoEWWngLoIqOC5m
         sKS0QiHLHwLG55EGmlk/k1DS3J/g+KGTlPYSW/vqFlpA574q1q96So+Y6uHvRbJd58Zf
         ooALjkYcZU3FQO/LEJ8LWBE4U0l50XpzmL7oOlB6etSVEvlVYlqFEQfgx3MMeObft66h
         j6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=/ooaWBxqU52fx4GnhtJLeZwXkoPAY2Jx4Y/ereta9V4=;
        b=dZ4rJWysVABu//HcauTnIGQHB1nslNAIzqM08SYa0oNTmKnmOLSV1nIGWLMGaw65YT
         wEujo6xoc6usa+AGtUwhlC2PnXGwPJQaSMUSRpGpoHtIDbizN+u0YWqBNmTtFZPSBlSz
         3bTqyZKn+mwb8gECIghEEa35nSYdHGcuJQ+/KTkNJaUr5GUb0YzV0A3muLv/bsaY7FOx
         ivhKhVntsmBKTFTZ0/ktsjYdC0OlY3J5E6S1lSTr53x6maL052QhpOX5mPSp5Xw5+lBY
         1QWMbnHIHPS9LXhs9dDTg/BCRgZyevfH+vGBnP1ec0RP50ypNIwYLW0fkwlqxy2qnXKa
         Jy9A==
X-Gm-Message-State: AA+aEWb8OgOYJsW5m8/qq/TfxcO9W/50evIVjqchUVvikGDEECSS7rDT
        RNa7Hq3ng9XKU1QA69oBdfqU6cWTH7g=
X-Google-Smtp-Source: AFSGD/UwjTIA4OoLHps7TlEBEP/nKQN75DpDDIOg5cq7CxQew3oWdP4VaWNPSKKX/yQPNDNPPNc11A==
X-Received: by 2002:a17:902:a601:: with SMTP id u1mr24864557plq.77.1544030380649;
        Wed, 05 Dec 2018 09:19:40 -0800 (PST)
Received: from [192.168.0.150] ([37.228.249.233])
        by smtp.gmail.com with ESMTPSA id b68sm32550608pfg.160.2018.12.05.09.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:19:39 -0800 (PST)
From:   James Sewart <jamessewart@arista.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: [RFC v2] iommu/vt-d: Allow iommu_domain_alloc to allocate
 IOMMU_DOMAIN_DMA
Message-Id: <E1FC52F0-B31C-4FB5-9C57-C72E5F4BCBCE@arista.com>
Date:   Wed, 5 Dec 2018 17:19:35 +0000
Cc:     linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dmitry Safonov <dima@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

There exists an issue in the logic used to determine domain association=20=

with devices. Currently the driver uses find_or_alloc_domain to either=20=

reuse an existing domain or allocate a new one if one isn=E2=80=99t =
found. Domains=20
should be shared between all members of an IOMMU group as this is the=20
minimum granularity that we can guarantee address space isolation.

The intel IOMMU driver exposes pci_device_group in intel_iommu_ops as =
the=20
function to call to determine the group of a device, this is implemented=20=

in the generic IOMMU code and checks: dma aliases, upstream pcie switch=20=

ACS, pci aliases, and pci function aliases. The find_or_alloc_domain =
code=20
currently only uses dma aliases to determine if a domain is shared. This=20=

causes a disconnect between IOMMU groups and domains. We have observed=20=

devices under a pcie switch each having their own domain but assigned =
the=20
same group.

One solution would be to fix the logic in find_or_alloc_domain to add=20
checks for the other conditions that a device may share a domain. =
However,=20
this duplicates code which the generic IOMMU code implements. Instead =
this=20
issue can be fixed by allowing the allocation of default_domain on the=20=

IOMMU group. This is not currently supported as the intel driver does =
not=20
allow allocation of domain type IOMMU_DOMAIN_DMA.

Allowing allocation of DMA domains has the effect that the =
default_domain=20
is non NULL and is attached to a device when initialising. This =
delegates=20
the handling of domains to the generic IOMMU code. Once this is=20
implemented it is possible to remove the lazy allocation of domains=20
entirely.

This patch implements DMA and identity domains to be allocated for=20
external management. As it isn=E2=80=99t known which device will be =
attached to a=20
domain, the dma domain is not initialised at alloc time. Instead it is=20=

allocated when attached. As we may lose RMRR mappings when attaching a=20=

device to a new domain, we also ensure these are mapped at attach time.

This will likely conflict with the work done for auxiliary domains by=20
Baolu but the code to accommodate won=E2=80=99t change much.

I had also started on a patch to remove find_or_alloc_domain and various=20=

functions that call it but had issues with edge cases such as=20
iommu_prepare_isa that is doing domain operations at IOMMU init time.

Cheers,
James.


---
 drivers/iommu/intel-iommu.c | 159 +++++++++++++++++++++++++-----------
 1 file changed, 110 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 41a4b8808802..6437cb2e9b22 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -351,6 +351,14 @@ static int hw_pass_through =3D 1;
 /* si_domain contains mulitple devices */
 #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
=20
+/* Domain managed externally, don't cleanup if it isn't attached
+ * to any devices. */
+#define DOMAIN_FLAG_NO_CLEANUP	(1 << 2)
+
+/* Set after domain initialisation. Used when allocating dma domains to
+ * defer domain initialisation until it is attached to a device */
+#define DOMAIN_FLAG_INITIALISED	(1 << 4)
+
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx =3D 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
@@ -624,6 +632,16 @@ static inline int domain_type_is_vm_or_si(struct =
dmar_domain *domain)
 				DOMAIN_FLAG_STATIC_IDENTITY);
 }
=20
+static inline int domain_managed_externally(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_NO_CLEANUP;
+}
+
+static inline int domain_is_initialised(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_INITIALISED;
+}
+
 static inline int domain_pfn_supported(struct dmar_domain *domain,
 				       unsigned long pfn)
 {
@@ -1717,7 +1735,7 @@ static void disable_dmar_iommu(struct intel_iommu =
*iommu)
=20
 		__dmar_remove_one_dev_info(info);
=20
-		if (!domain_type_is_vm_or_si(domain)) {
+		if (!domain_managed_externally(domain)) {
 			/*
 			 * The domain_exit() function  can't be called =
under
 			 * device_domain_lock, as it takes this lock =
itself.
@@ -1951,6 +1969,7 @@ static int domain_init(struct dmar_domain *domain, =
struct intel_iommu *iommu,
 	domain->pgd =3D (struct dma_pte =
*)alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
+	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
 	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -3234,11 +3253,9 @@ static int copy_translation_tables(struct =
intel_iommu *iommu)
 static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
-	struct dmar_rmrr_unit *rmrr;
 	bool copied_tables =3D false;
-	struct device *dev;
 	struct intel_iommu *iommu;
-	int i, ret;
+	int ret;
=20
 	/*
 	 * for each drhd
@@ -4529,7 +4522,7 @@ static int device_notifier(struct notifier_block =
*nb,
 		return 0;
=20
 	dmar_remove_one_dev_info(domain, dev);
-	if (!domain_type_is_vm_or_si(domain) && =
list_empty(&domain->devices))
+	if (!domain_managed_externally(domain) && =
list_empty(&domain->devices))
 		domain_exit(domain);
=20
 	return 0;
@@ -4930,6 +4923,7 @@ static int md_domain_init(struct dmar_domain =
*domain, int guest_width)
 	domain->pgd =3D (struct dma_pte =
*)alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
+	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -4938,28 +4932,65 @@ static struct iommu_domain =
*intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
+	int flags =3D DOMAIN_FLAG_NO_CLEANUP;
+	int nid;
=20
-	if (type !=3D IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
-
-	dmar_domain =3D alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
-	if (!dmar_domain) {
-		pr_err("Can't allocate dmar_domain\n");
-		return NULL;
-	}
-	if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-		pr_err("Domain initialization failed\n");
-		domain_exit(dmar_domain);
+	switch (type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		flags |=3D DOMAIN_FLAG_VIRTUAL_MACHINE | =
DOMAIN_FLAG_INITIALISED;
+		dmar_domain =3D alloc_domain(flags);
+		if (!dmar_domain) {
+			pr_err("Can't allocate dmar_domain\n");
+			return NULL;
+		}
+		if (md_domain_init(dmar_domain, =
DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+			pr_err("Domain initialization failed\n");
+			domain_exit(dmar_domain);
+			return NULL;
+		}
+		domain_update_iommu_cap(dmar_domain);
+		domain->geometry.aperture_start =3D 0;
+		domain->geometry.aperture_end   =3D =
__DOMAIN_MAX_ADDR(dmar_domain->gaw);
+		domain->geometry.force_aperture =3D true;
+		break;
+	case IOMMU_DOMAIN_DMA:
+		dmar_domain =3D alloc_domain(flags);
+		if (!dmar_domain) {
+			pr_err("Can't allocate dmar_domain\n");
+			return NULL;
+		}
+		/* init domain in device attach when we know IOMMU =
capabilities */
+		break;
+	case IOMMU_DOMAIN_IDENTITY:
+		flags |=3D DOMAIN_FLAG_STATIC_IDENTITY | =
DOMAIN_FLAG_INITIALISED;
+		dmar_domain =3D alloc_domain(flags);
+		if (!dmar_domain) {
+			pr_err("Can't allocate dmar_domain\n");
+			return NULL;
+		}
+		if (md_domain_init(dmar_domain, =
DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+			pr_err("Domain initialization failed\n");
+			domain_exit(dmar_domain);
+			return NULL;
+		}
+		domain_update_iommu_cap(dmar_domain);
+		for_each_online_node(nid) {
+			unsigned long start_pfn, end_pfn;
+			int i, ret;
+
+			for_each_mem_pfn_range(i, nid, &start_pfn, =
&end_pfn, NULL) {
+				ret =3D =
iommu_domain_identity_map(dmar_domain,
+						PFN_PHYS(start_pfn), =
PFN_PHYS(end_pfn));
+				if (ret)
+					return NULL;
+			}
+		}
+		break;
+	default:
 		return NULL;
 	}
-	domain_update_iommu_cap(dmar_domain);
-
-	domain =3D &dmar_domain->domain;
-	domain->geometry.aperture_start =3D 0;
-	domain->geometry.aperture_end   =3D =
__DOMAIN_MAX_ADDR(dmar_domain->gaw);
-	domain->geometry.force_aperture =3D true;
=20
-	return domain;
+	return &dmar_domain->domain;
 }
=20
 static void intel_iommu_domain_free(struct iommu_domain *domain)
@@ -4974,6 +5005,9 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 	struct intel_iommu *iommu;
 	int addr_width;
 	u8 bus, devfn;
+	struct dmar_rmrr_unit *rmrr;
+	struct device *i_dev;
+	int i, ret;
=20
 	if (device_is_rmrr_locked(dev)) {
 		dev_warn(dev, "Device is ineligible for IOMMU domain =
attach due to platform RMRR requirement.  Contact your platform =
vendor.\n");
@@ -4990,8 +5024,8 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 			dmar_remove_one_dev_info(old_domain, dev);
 			rcu_read_unlock();
=20
-			if (!domain_type_is_vm_or_si(old_domain) &&
-			     list_empty(&old_domain->devices))
+			if (list_empty(&old_domain->devices) &&
+			     !domain_managed_externally(old_domain))
 				domain_exit(old_domain);
 		}
 	}
@@ -5000,6 +5034,12 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
=20
+	/* Initialise domain with IOMMU capabilities if it isn't already =
initialised */
+	if (!domain_is_initialised(dmar_domain)) {
+		if (domain_init(dmar_domain, iommu, =
DEFAULT_DOMAIN_ADDRESS_WIDTH))
+			return -ENOMEM;
+	}
+
 	/* check if this iommu agaw is sufficient for max mapped address =
*/
 	addr_width =3D agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
@@ -5028,6 +5068,27 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 		dmar_domain->agaw--;
 	}
=20
+	if (domain_type_is_vm_or_si(dmar_domain))
+		goto out;
+
+	/* Ensure DMA domain has devices RMRR */
+	rcu_read_lock();
+	for_each_rmrr_units(rmrr) {
+		for_each_active_dev_scope(rmrr->devices, =
rmrr->devices_cnt,
+					  i, i_dev) {
+			if (i_dev !=3D dev)
+				continue;
+
+			ret =3D domain_prepare_identity_map(dev, =
dmar_domain,
+							  =
rmrr->base_address,
+							  =
rmrr->end_address);
+			if (ret)
+				dev_err(dev, "Mapping reserved region =
failed\n");
+		}
+	}
+	rcu_read_unlock();
+
+out:
 	return domain_add_dev_info(dmar_domain, dev);
 }
=20
--=20
2.17.1

