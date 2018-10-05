Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74780C65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2414921477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="117jzVKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2414921477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbeJFD4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:56:43 -0400
Received: from mail-eopbgr720040.outbound.protection.outlook.com ([40.107.72.40]:39680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728367AbeJFD4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+/BVU75dUtWfBQzbWcT+xkdCL61qh+iBf5DWlsgKCg=;
 b=117jzVKE9Mu/8tEaBlztiSbHm0a2c6LRMNuBfqQygiq/2MUKuqFNDslv+Dow6dAW/48td8K6HCDsjwMbM52nZujFfa+C2rtrbmABwSzHIXkfXSbmt2VUrEiLu2UglEWPfVTB9t4KCxApfA9RSnVGw8P4zQ1D4FO3XMhJDxrc/Wk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1386.namprd12.prod.outlook.com (10.168.238.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Fri, 5 Oct 2018 20:56:13 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 20:56:13 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/11] arch/x86: Introduce QOS feature for AMD
Thread-Topic: [PATCH v2 11/11] arch/x86: Introduce QOS feature for AMD
Thread-Index: AQHUXO3Z2o9MCgYFMEiGmGBlhxoHGA==
Date:   Fri, 5 Oct 2018 20:56:12 +0000
Message-ID: <20181005205512.29545-12-babu.moger@amd.com>
References: <20181005205512.29545-1-babu.moger@amd.com>
In-Reply-To: <20181005205512.29545-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:404:b4::28) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1386;20:KFFcVSsu/XAW2EyTPEXN/4Op/UlNxHnBs9Gq1SR/vsDspxQvlMeE1iZSNWJ/RzSBakzeoYMrkQ/9mfmEJEvDma/hLG89F80xO8q9thgkKZ421US8eZnvAAlYKIQvuiDQ7q2XyMf9Q9/LlfwCMQzM3dz3QkDcJnks3T6z0ZlHUI31fJ0BDAjzTGcHocGUr8qJ9uUkmF0NSE3/muqkAdkEh32yGTyRjKJAOqN7VXvSIgNQKxPj9bfIwNPLJCHbtt46
x-ms-office365-filtering-correlation-id: 0917f92f-6898-4295-fe6c-08d62b04fbe5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1386;
x-ms-traffictypediagnostic: DM5PR12MB1386:
x-microsoft-antispam-prvs: <DM5PR12MB1386299E217BCBB027E692F795EB0@DM5PR12MB1386.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(269456686620040)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302102)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR12MB1386;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1386;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(43544003)(186003)(99286004)(575784001)(86362001)(5660300001)(66066001)(476003)(305945005)(106356001)(316002)(5250100002)(6506007)(52116002)(97736004)(76176011)(486006)(7736002)(105586002)(386003)(102836004)(2501003)(26005)(81166006)(6486002)(4326008)(110136005)(81156014)(2906002)(6436002)(54906003)(71200400001)(6512007)(478600001)(72206003)(53936002)(8936002)(68736007)(71190400001)(11346002)(446003)(14444005)(2616005)(6116002)(2900100001)(36756003)(256004)(1076002)(2201001)(25786009)(3846002)(7416002)(8676002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1386;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2+I+U7wCW421EIySV1KquTdbbIrfP77W2uof1q9Fktq+u+mS8kSaiFNbiFVy3iuZjIXaVX/SJ8YTyMkImlJCJbcZyBL/NT4SIbAK6ABbnaAe4MM43N68XcUDXHdF7UvsUvfCm+0rPewCEHF3INP7Fbvv78kyUkkr5XzbzAr+DSroPNBZyFxc4CUTsLbZlYWXjUZtGc55/i+I5rsT/iO6Oy5hjebkJVmuGbOjwYv7243QCm542A6FEoIBwWs0DS7g9Jqa086iszBupzkyc+bMRGWgViW9V6cT/HOODKIefYjCke6c37fwKfhuhtcSdjR1OqMEDIZbgRhW4rAI0tR/QjCcX43DGcRjy3BdCTIaR0k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0917f92f-6898-4295-fe6c-08d62b04fbe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 20:56:13.0052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1386
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables QOS feature on AMD.
Following QoS sub-features are supported in AMD if the underlying
hardware supports it.
 - L3 Cache allocation enforcement
 - L3 Cache occupancy monitoring
 - L3 Code-Data Prioritization support
 - Memory Bandwidth Enforcement(Allocation)

There are differences in the way some of the features are implemented.
Separate those functions and add those as vendor specific functions.
The major difference is in MBA feature.
 - AMD uses CPUID leaf 0x80000020 to initialize the MBA features.
 - AMD uses direct bandwidth value instead of delay based on bandwidth
   values.
 - MSR register base addresses are different for MBA.
 - Also AMD allows non-contiguous L3 cache bit masks.

Adds following functions to take care of the differences.
rdt_get_mem_config_amd : MBA initialization function
parse_bw_amd : Bandwidth parsing
mba_wrmsr_amd: Writes bandwidth value
cbm_validate_amd : L3 cache bitmask validation

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/rdt.c             | 69 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/rdt.h             |  5 ++
 arch/x86/kernel/cpu/rdt_ctrlmondata.c | 70 +++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
index c7c2dbaae7bb..99b3a69457c7 100644
--- a/arch/x86/kernel/cpu/rdt.c
+++ b/arch/x86/kernel/cpu/rdt.c
@@ -61,6 +61,9 @@ mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m=
,
 		struct rdt_resource *r);
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *=
r);
+static void
+mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
+	      struct rdt_resource *r);
=20
 #define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].domains)
=20
@@ -280,6 +283,31 @@ static bool rdt_get_mem_config(struct rdt_resource *r)
 	return true;
 }
=20
+static bool rdt_get_mem_config_amd(struct rdt_resource *r)
+{
+	union cpuid_0x10_3_eax eax;
+	union cpuid_0x10_x_edx edx;
+	u32 ebx, ecx;
+
+	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
+	r->num_closid =3D edx.split.cos_max + 1;
+	r->default_ctrl =3D MAX_MBA_BW_AMD;
+
+	/* AMD does not use delay. Set delay_linear to false by default */
+	r->membw.delay_linear =3D false;
+
+	/* FIX ME - May need to be read from MSR */
+	r->membw.min_bw =3D 0;
+	r->membw.bw_gran =3D 1;
+	/* Max value is 2048, Data width should be 4 in decimal */
+	r->data_width =3D 4;
+
+	r->alloc_capable =3D true;
+	r->alloc_enabled =3D true;
+
+	return true;
+}
+
 static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 {
 	union cpuid_0x10_1_eax eax;
@@ -339,6 +367,16 @@ static int get_cache_id(int cpu, int level)
 	return -1;
 }
=20
+static void
+mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resour=
ce *r)
+{
+	unsigned int i;
+
+	/*  Write the bw values for mba. */
+	for (i =3D m->low; i < m->high; i++)
+		wrmsrl(r->msr_base + i, d->ctrl_val[i]);
+}
+
 /*
  * Map the memory b/w percentage value to delay values
  * that can be written to QOS_MSRs.
@@ -788,8 +826,13 @@ static bool __init rdt_cpu_has(int flag)
 static __init bool rdt_mba_config(void)
 {
 	if (rdt_cpu_has(X86_FEATURE_MBA)) {
-		if (rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]))
-			return true;
+		if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL) {
+			if (rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]))
+				return true;
+		} else if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD) {
+			if (rdt_get_mem_config_amd(&rdt_resources_all[RDT_RESOURCE_MBA]))
+				return true;
+		}
 	}
=20
 	return false;
@@ -890,10 +933,32 @@ static __init void rdt_init_res_defs_intel(void)
 	}
 }
=20
+static __init void rdt_init_res_defs_amd(void)
+{
+	struct rdt_resource *r;
+
+	for_each_rdt_resource(r) {
+		if ((r->rid =3D=3D RDT_RESOURCE_L3) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L3DATA) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L3CODE) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2DATA) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2CODE))
+			r->cbm_validate =3D cbm_validate_amd;
+		else if (r->rid =3D=3D RDT_RESOURCE_MBA) {
+			r->msr_base =3D IA32_MBA_BW_BASE;
+			r->msr_update =3D mba_wrmsr_amd;
+			r->parse_ctrlval =3D parse_bw_amd;
+		}
+	}
+}
+
 static __init void rdt_init_res_defs(void)
 {
 	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
 		rdt_init_res_defs_intel();
+	else if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
+		rdt_init_res_defs_amd();
 }
=20
 static enum cpuhp_state rdt_online;
diff --git a/arch/x86/kernel/cpu/rdt.h b/arch/x86/kernel/cpu/rdt.h
index cb7e5a4739fc..4bc8c5594650 100644
--- a/arch/x86/kernel/cpu/rdt.h
+++ b/arch/x86/kernel/cpu/rdt.h
@@ -11,6 +11,7 @@
 #define IA32_L3_CBM_BASE	0xc90
 #define IA32_L2_CBM_BASE	0xd10
 #define IA32_MBA_THRTL_BASE	0xd50
+#define IA32_MBA_BW_BASE	0xc0000200
=20
 #define IA32_QM_CTR		0x0c8e
 #define IA32_QM_EVTSEL		0x0c8d
@@ -34,6 +35,7 @@
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
 #define MBA_MAX_MBPS			U32_MAX
+#define MAX_MBA_BW_AMD			0x800
=20
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
@@ -451,6 +453,8 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_r=
esource *r,
 	      struct rdt_domain *d);
 int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
 		   struct rdt_domain *d);
+int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
+		 struct rdt_domain *d);
=20
 extern struct mutex rdtgroup_mutex;
=20
@@ -583,5 +587,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_d=
omain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void update_mba_bw_intel(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm=
);
 bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
+bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
=20
 #endif /* _ASM_X86_RDT_H */
diff --git a/arch/x86/kernel/cpu/rdt_ctrlmondata.c b/arch/x86/kernel/cpu/rd=
t_ctrlmondata.c
index af8506003ee8..f9eb0de5ba96 100644
--- a/arch/x86/kernel/cpu/rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/rdt_ctrlmondata.c
@@ -28,6 +28,52 @@
 #include <linux/slab.h>
 #include "rdt.h"
=20
+/*
+ * Check whether MBA bandwidth percentage value is correct. The value is
+ * checked against the minimum and max bandwidth values specified by the
+ * hardware. The allocated bandwidth percentage is rounded to the next
+ * control step available on the hardware.
+ */
+static bool bw_validate_amd(char *buf, unsigned long *data,
+			    struct rdt_resource *r)
+{
+	unsigned long bw;
+	int ret;
+
+	ret =3D kstrtoul(buf, 10, &bw);
+	if (ret) {
+		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
+		return false;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
+				    r->membw.min_bw, r->default_ctrl);
+		return false;
+	}
+
+	*data =3D roundup(bw, (unsigned long)r->membw.bw_gran);
+	return true;
+}
+
+int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
+	     struct rdt_domain *d)
+{
+	unsigned long bw_val;
+
+	if (d->have_new_ctrl) {
+		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
+		return -EINVAL;
+	}
+
+	if (!bw_validate_amd(data->buf, &bw_val, r))
+		return -EINVAL;
+	d->new_ctrl =3D bw_val;
+	d->have_new_ctrl =3D true;
+
+	return 0;
+}
+
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
@@ -123,6 +169,30 @@ bool cbm_validate_intel(char *buf, u32 *data, struct r=
dt_resource *r)
 	return true;
 }
=20
+/*
+ * Check whether a cache bit mask is valid. AMD allows non-contiguous
+ * bitmasks
+ */
+bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r)
+{
+	unsigned long val;
+	int ret;
+
+	ret =3D kstrtoul(buf, 16, &val);
+	if (ret) {
+		rdt_last_cmd_printf("non-hex character in mask %s\n", buf);
+		return false;
+	}
+
+	if (val > r->default_ctrl) {
+		rdt_last_cmd_puts("mask out of range\n");
+		return false;
+	}
+
+	*data =3D val;
+	return true;
+}
+
 /*
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
--=20
2.17.1

