Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474859-5-3830351021718120300
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474858; b=bqghrx9rQhkouGwH6G8D3EqkfhqOS2NaScH5o6X7jqqQ7Cb
    nhlK2LnXBPLSqCPScWrwFVnZYTy+e7s6w9kOY2iDg7GYAWu3on+slTle+YfOaHGX
    QPoNADG6m6PwId2FjkWqaCWDRhRJAPOIVlIthdWgCUoRL7P/ZPDFwdD6iEDKSpnE
    RTo3pgc+m+Bsco1v92Bxumn1GIrEoZOK3fbXR6t14tOIgfeKfQosyouN9wDuXIZd
    kmt/kyUo//doHX5ORMHB82pBri2nGhrTs5jvndRwLNfpUVTpGL2XZOsqfZ3KF5pS
    M0Hg3Ql0a8hHSnliYHeeXNcGIZlsIwyQtGYRveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474858; bh=zI/VqY
    Y2znBXH4jEB8MnT1FRX8hYrgAO/4WyD0dMt4M=; b=Z5sULpQlcERcnwRKGOi91u
    8FaAvGePlXanRRED/xe+/tM/KPmcH+iH8W+bpI+lJTvGwZtD4rByj58ftuyQO2hE
    W856UcIwS371gXFUQCnOwn2cx4AOFBMouYW9BRDV86aYAp8KXiVHJPqM+HjlwI0c
    Onc2Wzgye4gz6IN/3W1NSqD3ENgKM2lGHSjHfacVbM8bkIznTBnzgswnbv/JetyG
    Ky4IFUvzxAhcxobA1e53AxO/l4XDycgdEfP5SaB0eDGIy4f6E3RzTdfj+bWe1biF
    gXRb//99HsYhnKOgba7Li4C2yQHn1oraq9mleJrUezPkv3Kr8EjT7TUfblkaZmxQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mQ2fZbGn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdeivdegnecuvehluhhsthgvrhfuihiivgepvdei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mQ2fZbGn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdeivdegnecuvehluhhsthgvrhfuihiivgepvdei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933318AbeCSPyB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:54:01 -0400
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:57771
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934055AbeCSPuM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiri Bohac <jbohac@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Baoquan He <bhe@redhat.com>, Toshi Kani <toshi.kani@hpe.com>,
        David Airlie <airlied@linux.ie>,
        "yinghai@kernel.org" <yinghai@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 110/124] x86/gart: Exclude GART aperture from
 vmcore
Thread-Topic: [PATCH AUTOSEL for 4.15 110/124] x86/gart: Exclude GART aperture
 from vmcore
Thread-Index: AQHTv5nOdjfYYF1vT0GL5qU0FIGldQ==
Date: Mon, 19 Mar 2018 15:49:04 +0000
Message-ID: <20180319154645.11350-110-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:rUOxtwSrf4/uHgMtsNHBQtCKWwZZyuYkEEjQkDDB98MioP4pWt0JnRJFg3Kql5quW8pVRHn7IkEbDbW06AFbfeADL9tMuwJzAZQ9WO1An7+zWHHPJiinqjbQwGUArW4WZpY7cv31dGblQXL+lQ6IC5NB7Ent9LhCzz6qE2esYaQqu9NqLO8RIqpleePppRLpV6vmraVW8HxvTo+h+RQwEODgoE9Ag+Fu2WvzbygOPJJbBSoQmaUT5qDsiFNHk672;20:5+J28Ja2YTH07He+DYoAQBvcYmrjFxDpqLspWH639aElxwyJukSs9lxB915P4nQXgMdGLIofyRmrySvqD1up8oBzAT7qIE/0z2HGCE4kVSSqQKkumvZdXQAiZ4ogvl84D+I3SHBAme30/HLU+ETjX7cxpPNCnu+q4ZxfT5E1mao=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1cfbb76-9126-43b2-b08a-08d58db10ac1
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109272B5FBE140EF2D7C9A9FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(227479698468861)(89211679590171)(258649278758335)(211936372134217)(42068640409301)(153496737603132)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(14454004)(966005)(76176011)(66066001)(6512007)(6306002)(5250100002)(10090500001)(7416002)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ytRaWb269muxzYIoRZl3DVM7vlIlWsuovZWeKbcq+QprhUFVxvuWqa1jmly9ydYpOLFBKRh5TFQCDsK4GFEF0es6P+Fw5a4zuz/gHP5a2tPtNBSHZIDj8mdlNRs7Oktrd5j2Acz6ExdVFUUc4RYIIJ1ZNRoA13qkFGNe4eKxR54O+pI9j1X6/TguGGIP2g0p9EHgsq4g/Ad8iCiLafLj3dMJR36XSU8F0ByctSz0A6Tk+nT2HEdawXgxsRasyM8KVSSlugy6Fwb+hcn6eIXJ5lv83hx3QuKQK1XOPbQy6B5fTjKfdZo0hYzhyfe4LJe09HMl8SPmJD/CY4CQbzrNDw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cfbb76-9126-43b2-b08a-08d58db10ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:04.0655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Bohac <jbohac@suse.cz>

[ Upstream commit 2a3e83c6f96c513f43ce5a8c9034608ea584a255 ]

On machines where the GART aperture is mapped over physical RAM
/proc/vmcore contains the remapped range and reading it may cause hangs or
reboots.

In the past, the GART region was added into the resource map, implemented
by commit 56dd669a138c ("[PATCH] Insert GART region into resource map")

However, inserting the iomem_resource from the early GART code caused
resource conflicts with some AGP drivers (bko#72201), which got avoided by
reverting the patch in commit 707d4eefbdb3 ("Revert [PATCH] Insert GART
region into resource map"). This revert introduced the /proc/vmcore bug.

The vmcore ELF header is either prepared by the kernel (when using the
kexec_file_load syscall) or by the kexec userspace (when using the kexec_lo=
ad
syscall). Since we no longer have the GART iomem resource, the userspace
kexec has no way of knowing which region to exclude from the ELF header.

Changes from v1 of this patch:
Instead of excluding the aperture from the ELF header, this patch
makes /proc/vmcore return zeroes in the second kernel when attempting to
read the aperture region. This is done by reusing the
gart_oldmem_pfn_is_ram infrastructure originally intended to exclude XEN
balooned memory. This works for both, the kexec_file_load and kexec_load
syscalls.

[Note that the GART region is the same in the first and second kernels:
regardless whether the first kernel fixed up the northbridge/bios setting
and mapped the aperture over physical memory, the second kernel finds the
northbridge properly configured by the first kernel and the aperture
never overlaps with e820 memory because the second kernel has a fake e820
map created from the crashkernel memory regions. Thus, the second kernel
keeps the aperture address/size as configured by the first kernel.]

register_oldmem_pfn_is_ram can only register one callback and returns an er=
ror
if the callback has been registered already. Since XEN used to be the only =
user
of this function, it never checks the return value. Now that we have more t=
han
one user, I added a WARN_ON just in case agp, XEN, or any other future user=
 of
register_oldmem_pfn_is_ram were to step on each other's toes.

Fixes: 707d4eefbdb3 ("Revert [PATCH] Insert GART region into resource map")
Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: David Airlie <airlied@linux.ie>
Cc: yinghai@kernel.org
Cc: joro@8bytes.org
Cc: kexec@lists.infradead.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Link: https://lkml.kernel.org/r/20180106010013.73suskgxm7lox7g6@dwarf.suse.=
cz
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/aperture_64.c | 46 +++++++++++++++++++++++++++++++++++++++=
+++-
 arch/x86/xen/mmu_hvm.c        |  2 +-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index f5d92bc3b884..2c4d5ece7456 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -30,6 +30,7 @@
 #include <asm/dma.h>
 #include <asm/amd_nb.h>
 #include <asm/x86_init.h>
+#include <linux/crash_dump.h>
=20
 /*
  * Using 512M as goal, in case kexec will load kernel_big
@@ -56,6 +57,33 @@ int fallback_aper_force __initdata;
=20
 int fix_aperture __initdata =3D 1;
=20
+#ifdef CONFIG_PROC_VMCORE
+/*
+ * If the first kernel maps the aperture over e820 RAM, the kdump kernel w=
ill
+ * use the same range because it will remain configured in the northbridge=
.
+ * Trying to dump this area via /proc/vmcore may crash the machine, so exc=
lude
+ * it from vmcore.
+ */
+static unsigned long aperture_pfn_start, aperture_page_count;
+
+static int gart_oldmem_pfn_is_ram(unsigned long pfn)
+{
+	return likely((pfn < aperture_pfn_start) ||
+		      (pfn >=3D aperture_pfn_start + aperture_page_count));
+}
+
+static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+{
+	aperture_pfn_start =3D aper_base >> PAGE_SHIFT;
+	aperture_page_count =3D (32 * 1024 * 1024) << aper_order >> PAGE_SHIFT;
+	WARN_ON(register_oldmem_pfn_is_ram(&gart_oldmem_pfn_is_ram));
+}
+#else
+static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+{
+}
+#endif
+
 /* This code runs before the PCI subsystem is initialized, so just
    access the northbridge directly. */
=20
@@ -435,8 +463,16 @@ int __init gart_iommu_hole_init(void)
=20
 out:
 	if (!fix && !fallback_aper_force) {
-		if (last_aper_base)
+		if (last_aper_base) {
+			/*
+			 * If this is the kdump kernel, the first kernel
+			 * may have allocated the range over its e820 RAM
+			 * and fixed up the northbridge
+			 */
+			exclude_from_vmcore(last_aper_base, last_aper_order);
+
 			return 1;
+		}
 		return 0;
 	}
=20
@@ -473,6 +509,14 @@ int __init gart_iommu_hole_init(void)
 		return 0;
 	}
=20
+	/*
+	 * If this is the kdump kernel _and_ the first kernel did not
+	 * configure the aperture in the northbridge, this range may
+	 * overlap with the first kernel's memory. We can't access the
+	 * range through vmcore even though it should be part of the dump.
+	 */
+	exclude_from_vmcore(aper_alloc, aper_order);
+
 	/* Fix up the north bridges */
 	for (i =3D 0; i < amd_nb_bus_dev_ranges[i].dev_limit; i++) {
 		int bus, dev_base, dev_limit;
diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index 2cfcfe4f6b2a..dd2ad82eee80 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -75,6 +75,6 @@ void __init xen_hvm_init_mmu_ops(void)
 	if (is_pagetable_dying_supported())
 		pv_mmu_ops.exit_mmap =3D xen_hvm_exit_mmap;
 #ifdef CONFIG_PROC_VMCORE
-	register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram);
+	WARN_ON(register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram));
 #endif
 }
--=20
2.14.1
