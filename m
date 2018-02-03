Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517680983-2-7904985665469591424
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680982; b=v+l0YSqM58HixL7h/Wb2C+gZETIfT13u7wHI8NcaI/Qy1y/
    8GKnwrq7GMOjf8ZTXNkpcDIHZn2pu3P0p7zAAtMQYqLedKlM0e7eAVO2GMbgxMLZ
    Vo8nj3dKu64q4IZA/vBaGKKU93ACwdU352jkaRMxZratHITYWyS27jQalTMUfSNi
    y3UDe82/MkVQe9PGj3F35zJEswGjoEUt1emuN2nArU6/Yyk8JcItjiitzoRpHSxF
    guBQ50zpwwcn0LRfKmeSr12cjKzR/3S8j2N3Jy1kYuqKh4lunvmnvjsi8G4Ic76J
    9khcIKzhfGT/2SBuzjla/Q1KKLd6n88MT+T2lxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680982; bh=kBpq0X
    B67AqyWhARhe85KWKjhTieJFSmTweHBNApwMs=; b=JzhBlIwRAUD+UlE8Hq8dAZ
    +SSy6h4GvkIyoNqB0bXm/WYsy7w/NM1r4atPaDYNPnmzB5nbqQ7WkeUgvrlwTLS2
    r4TFHoq6YsggtJTPLRlUQ4YUtMIOkODsFRyKgCgMzAgLyMbCQ0+5+BqJYSobHi7a
    T2cTwAlvZeVH0wbS78LqNxBJ0zxJoS/muUueU9PNLqUpfWzsatdwZk5lk/Hz2wUB
    BU+h9HYzLs1c6kOkzDAgVxUHfixsW4+xL+RqgnCusebxNEm2FP/IjnsTpwqS6T1T
    kk9mgs9Vp2p44OEBFwhJcd6ajakLG/fQlV/6IzW9b/sYE/gMCvM1A2zSh4FrBOzA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cup1ecL7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cup1ecL7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753184AbeBCSC7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:02:59 -0500
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:19232
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753047AbeBCSCN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 045/110] xen/balloon: Mark unallocated host
 memory as UNUSABLE
Thread-Topic: [PATCH AUTOSEL for 4.14 045/110] xen/balloon: Mark unallocated
 host memory as UNUSABLE
Thread-Index: AQHTnRjsqZPmsZPEk0i+tod3BmZEag==
Date: Sat, 3 Feb 2018 18:00:50 +0000
Message-ID: <20180203180015.29073-45-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:75r8DoOmfaG/P/oMqd2j53mF0UcDV6uAomWNOmmCtXDVsDt8ilr/Qu2xHcj8P8xxs4QzXVJ+98Q68mim05ajctG2iQZwzhcjHPv9+ZNsKbzUIi1cC3qojqgVB4vtE1l2lQzBgIX6kUzOuijlBiagfMTZ676eQrJMkOPlmOsG7Do5XcRwT6QuNNSt8ClO49n5jKbQKnIeldCC4xATDLHN2yYVdyJt9sAlMg2wXheslq9ehyTuq1lG3SdY/Ykx3fH3
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7538541-9ae3-496d-ec4c-08d56b3023a5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB10925FBE560B7BEEA40A3D1EFBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(59450400001)(6506007)(76176011)(6346003)(10090500001)(575784001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 0u3w0OAEMedtqvmzFVuhQsK5Eb+IjNuJyklnk64bTWgjbugaaZ2aBppJMqpJi/+eNJCysOcesb2AI/XAvSwJLQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7538541-9ae3-496d-ec4c-08d56b3023a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:50.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

[ Upstream commit b3cf8528bb21febb650a7ecbf080d0647be40b9f ]

Commit f5775e0b6116 ("x86/xen: discard RAM regions above the maximum
reservation") left host memory not assigned to dom0 as available for
memory hotplug.

Unfortunately this also meant that those regions could be used by
others. Specifically, commit fa564ad96366 ("x86/PCI: Enable a 64bit BAR
on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)") may try to map those
addresses as MMIO.

To prevent this mark unallocated host memory as E820_TYPE_UNUSABLE (thus
effectively reverting f5775e0b6116) and keep track of that region as
a hostmem resource that can be used for the hotplug.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/xen/enlighten.c | 81 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 arch/x86/xen/setup.c     |  6 ++--
 drivers/xen/balloon.c    | 65 ++++++++++++++++++++++++++++++++------
 include/xen/balloon.h    |  5 +++
 4 files changed, 144 insertions(+), 13 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index d669e9d89001..c9081c6671f0 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1,8 +1,12 @@
+#ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
+#include <linux/bootmem.h>
+#endif
 #include <linux/cpu.h>
 #include <linux/kexec.h>
=20
 #include <xen/features.h>
 #include <xen/page.h>
+#include <xen/interface/memory.h>
=20
 #include <asm/xen/hypercall.h>
 #include <asm/xen/hypervisor.h>
@@ -331,3 +335,80 @@ void xen_arch_unregister_cpu(int num)
 }
 EXPORT_SYMBOL(xen_arch_unregister_cpu);
 #endif
+
+#ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
+void __init arch_xen_balloon_init(struct resource *hostmem_resource)
+{
+	struct xen_memory_map memmap;
+	int rc;
+	unsigned int i, last_guest_ram;
+	phys_addr_t max_addr =3D PFN_PHYS(max_pfn);
+	struct e820_table *xen_e820_table;
+	const struct e820_entry *entry;
+	struct resource *res;
+
+	if (!xen_initial_domain())
+		return;
+
+	xen_e820_table =3D kmalloc(sizeof(*xen_e820_table), GFP_KERNEL);
+	if (!xen_e820_table)
+		return;
+
+	memmap.nr_entries =3D ARRAY_SIZE(xen_e820_table->entries);
+	set_xen_guest_handle(memmap.buffer, xen_e820_table->entries);
+	rc =3D HYPERVISOR_memory_op(XENMEM_machine_memory_map, &memmap);
+	if (rc) {
+		pr_warn("%s: Can't read host e820 (%d)\n", __func__, rc);
+		goto out;
+	}
+
+	last_guest_ram =3D 0;
+	for (i =3D 0; i < memmap.nr_entries; i++) {
+		if (xen_e820_table->entries[i].addr >=3D max_addr)
+			break;
+		if (xen_e820_table->entries[i].type =3D=3D E820_TYPE_RAM)
+			last_guest_ram =3D i;
+	}
+
+	entry =3D &xen_e820_table->entries[last_guest_ram];
+	if (max_addr >=3D entry->addr + entry->size)
+		goto out; /* No unallocated host RAM. */
+
+	hostmem_resource->start =3D max_addr;
+	hostmem_resource->end =3D entry->addr + entry->size;
+
+	/*
+	 * Mark non-RAM regions between the end of dom0 RAM and end of host RAM
+	 * as unavailable. The rest of that region can be used for hotplug-based
+	 * ballooning.
+	 */
+	for (; i < memmap.nr_entries; i++) {
+		entry =3D &xen_e820_table->entries[i];
+
+		if (entry->type =3D=3D E820_TYPE_RAM)
+			continue;
+
+		if (entry->addr >=3D hostmem_resource->end)
+			break;
+
+		res =3D kzalloc(sizeof(*res), GFP_KERNEL);
+		if (!res)
+			goto out;
+
+		res->name =3D "Unavailable host RAM";
+		res->start =3D entry->addr;
+		res->end =3D (entry->addr + entry->size < hostmem_resource->end) ?
+			    entry->addr + entry->size : hostmem_resource->end;
+		rc =3D insert_resource(hostmem_resource, res);
+		if (rc) {
+			pr_warn("%s: Can't insert [%llx - %llx) (%d)\n",
+				__func__, res->start, res->end, rc);
+			kfree(res);
+			goto  out;
+		}
+	}
+
+ out:
+	kfree(xen_e820_table);
+}
+#endif /* CONFIG_XEN_BALLOON_MEMORY_HOTPLUG */
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index c114ca767b3b..6e0d2086eacb 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -808,7 +808,6 @@ char * __init xen_memory_setup(void)
 	addr =3D xen_e820_table.entries[0].addr;
 	size =3D xen_e820_table.entries[0].size;
 	while (i < xen_e820_table.nr_entries) {
-		bool discard =3D false;
=20
 		chunk_size =3D size;
 		type =3D xen_e820_table.entries[i].type;
@@ -824,11 +823,10 @@ char * __init xen_memory_setup(void)
 				xen_add_extra_mem(pfn_s, n_pfns);
 				xen_max_p2m_pfn =3D pfn_s + n_pfns;
 			} else
-				discard =3D true;
+				type =3D E820_TYPE_UNUSABLE;
 		}
=20
-		if (!discard)
-			xen_align_and_add_e820_region(addr, chunk_size, type);
+		xen_align_and_add_e820_region(addr, chunk_size, type);
=20
 		addr +=3D chunk_size;
 		size -=3D chunk_size;
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index f77e499afddd..065f0b607373 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -257,10 +257,25 @@ static void release_memory_resource(struct resource *=
resource)
 	kfree(resource);
 }
=20
+/*
+ * Host memory not allocated to dom0. We can use this range for hotplug-ba=
sed
+ * ballooning.
+ *
+ * It's a type-less resource. Setting IORESOURCE_MEM will make resource
+ * management algorithms (arch_remove_reservations()) look into guest e820=
,
+ * which we don't want.
+ */
+static struct resource hostmem_resource =3D {
+	.name   =3D "Host RAM",
+};
+
+void __attribute__((weak)) __init arch_xen_balloon_init(struct resource *r=
es)
+{}
+
 static struct resource *additional_memory_resource(phys_addr_t size)
 {
-	struct resource *res;
-	int ret;
+	struct resource *res, *res_hostmem;
+	int ret =3D -ENOMEM;
=20
 	res =3D kzalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
@@ -269,13 +284,42 @@ static struct resource *additional_memory_resource(ph=
ys_addr_t size)
 	res->name =3D "System RAM";
 	res->flags =3D IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
=20
-	ret =3D allocate_resource(&iomem_resource, res,
-				size, 0, -1,
-				PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
-	if (ret < 0) {
-		pr_err("Cannot allocate new System RAM resource\n");
-		kfree(res);
-		return NULL;
+	res_hostmem =3D kzalloc(sizeof(*res), GFP_KERNEL);
+	if (res_hostmem) {
+		/* Try to grab a range from hostmem */
+		res_hostmem->name =3D "Host memory";
+		ret =3D allocate_resource(&hostmem_resource, res_hostmem,
+					size, 0, -1,
+					PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
+	}
+
+	if (!ret) {
+		/*
+		 * Insert this resource into iomem. Because hostmem_resource
+		 * tracks portion of guest e820 marked as UNUSABLE noone else
+		 * should try to use it.
+		 */
+		res->start =3D res_hostmem->start;
+		res->end =3D res_hostmem->end;
+		ret =3D insert_resource(&iomem_resource, res);
+		if (ret < 0) {
+			pr_err("Can't insert iomem_resource [%llx - %llx]\n",
+				res->start, res->end);
+			release_memory_resource(res_hostmem);
+			res_hostmem =3D NULL;
+			res->start =3D res->end =3D 0;
+		}
+	}
+
+	if (ret) {
+		ret =3D allocate_resource(&iomem_resource, res,
+					size, 0, -1,
+					PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
+		if (ret < 0) {
+			pr_err("Cannot allocate new System RAM resource\n");
+			kfree(res);
+			return NULL;
+		}
 	}
=20
 #ifdef CONFIG_SPARSEMEM
@@ -287,6 +331,7 @@ static struct resource *additional_memory_resource(phys=
_addr_t size)
 			pr_err("New System RAM resource outside addressable RAM (%lu > %lu)\n",
 			       pfn, limit);
 			release_memory_resource(res);
+			release_memory_resource(res_hostmem);
 			return NULL;
 		}
 	}
@@ -765,6 +810,8 @@ static int __init balloon_init(void)
 	set_online_page_callback(&xen_online_page);
 	register_memory_notifier(&xen_memory_nb);
 	register_sysctl_table(xen_root);
+
+	arch_xen_balloon_init(&hostmem_resource);
 #endif
=20
 #ifdef CONFIG_XEN_PV
diff --git a/include/xen/balloon.h b/include/xen/balloon.h
index 4914b93a23f2..61f410fd74e4 100644
--- a/include/xen/balloon.h
+++ b/include/xen/balloon.h
@@ -44,3 +44,8 @@ static inline void xen_balloon_init(void)
 {
 }
 #endif
+
+#ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
+struct resource;
+void arch_xen_balloon_init(struct resource *hostmem_resource);
+#endif
--=20
2.11.0
