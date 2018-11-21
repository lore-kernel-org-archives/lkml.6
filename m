Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E755C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4164214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j22+xPWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4164214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389579AbeKVHEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:04:49 -0500
Received: from mail-eopbgr680065.outbound.protection.outlook.com ([40.107.68.65]:32544
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733262AbeKVHEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usN6kaku0N79ay9SHWIruL9z5GbHbgAzPvHJRxMydd0=;
 b=j22+xPWs7w+UGVBK3gJw3mre1Mmrq1gnPo9+0tQ0iajI94jbGQdsmoVU9aHd3H2xdxDKxsKxsaXFjixE5dxZDHbkn2BmGBAa6xJm2Ph0GcB6COfx91zlNw9ZBjhBSf2aKS77xBOJLOa81fbsq2SAbg8OySrahUzhzeHMp08ETyk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1418.namprd12.prod.outlook.com (10.168.238.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 21 Nov 2018 20:28:45 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 20:28:45 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v9 11/13] x86/resctrl: Introduce QOS feature for AMD
Thread-Topic: [PATCH v9 11/13] x86/resctrl: Introduce QOS feature for AMD
Thread-Index: AQHUgdjNvCKX7FB3NUeryeyIEBYrnQ==
Date:   Wed, 21 Nov 2018 20:28:45 +0000
Message-ID: <20181121202811.4492-12-babu.moger@amd.com>
References: <20181121202811.4492-1-babu.moger@amd.com>
In-Reply-To: <20181121202811.4492-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0084.prod.exchangelabs.com (2603:10b6:800::52) To
 DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1418;20:U8ryuqX9GIUjkdP3ItX4QyPb+XtlxpNfA0C2lPfyYNE9VjKPncpjRwgPIOSbPRRCtFR46X1IA4HOgzLab80EPKRtZhmD8yQyvlgVzGTt5AxVpuzb9fky+DacCriHLBnhe6puod4K1UjhO7kReRHh3u53XkVlCCaQyFUbj0zYLu9v5Ozb7KPbntln+WOHVo2oAUmNtqahCKrdUq5ALAXzfOq5XG/fGs4PmD5mgbbnjP9RHAc6S4TZEJtekCjUdqYX
x-ms-office365-filtering-correlation-id: 26cbcda7-53f0-4e6e-76a9-08d64fefef9f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1418;
x-ms-traffictypediagnostic: DM5PR12MB1418:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB1418BC71A3656B56CB8D4B7795DA0@DM5PR12MB1418.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1418;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1418;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(478600001)(316002)(8936002)(1076002)(8676002)(81166006)(81156014)(54906003)(110136005)(5660300001)(71190400001)(71200400001)(99286004)(6116002)(3846002)(76176011)(6486002)(97736004)(6436002)(2906002)(2900100001)(6512007)(6306002)(52116002)(36756003)(105586002)(14454004)(446003)(6506007)(72206003)(4326008)(486006)(966005)(66066001)(476003)(106356001)(2501003)(2201001)(102836004)(7736002)(14444005)(256004)(386003)(305945005)(575784001)(11346002)(86362001)(7416002)(26005)(25786009)(53936002)(186003)(2616005)(68736007)(7406005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1418;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WNYwdaFIGzzxqXFYjaIXc/GeNXdzY8CL4lJZhHeTICZWoXmBWGKCx8pT3MDWjDuxN30ljJw0MugP/f5iHcsluDvVWBg5dGfQ5BwoVBCxLPeb6i4KPa3lIgho/IkdGDdVWlzg40S5VImR8/ZrzRTtK+XVjQFeTf/W1ovjp3kgg9vPKobdc+JY6hSmDKkVgWUbsyuDa2mB6h9WRNVzRG25cSul8SHeMl+cMF8tf4Jy3fys/CYujhvMJa4ry5Q7nU56p3+AlYGKm+l0TS6zBJ01wyI9Ody5VOQ6itG+xwbsFnZYYLxUCpzqsFi7q3S6V97/WtL2SjmnWw3nCXk9jp3ZZblnxj6j8BatHyZYYFq1FqU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cbcda7-53f0-4e6e-76a9-08d64fefef9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 20:28:45.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable QOS feature on AMD.
Following QoS sub-features are supported in AMD if the underlying
hardware supports it.
 - L3 Cache allocation enforcement
 - L3 Cache occupancy monitoring
 - L3 Code-Data Prioritization support
 - Memory Bandwidth Enforcement(Allocation)

The specification for this feature is available at
https://developer.amd.com/wp-content/resources/56375.pdf

There are differences in the way some of the features are implemented.
Separate those functions and add those as vendor specific functions.
The major difference is in MBA feature.
 - AMD uses CPUID leaf 0x80000020 to initialize the MBA features.
 - AMD uses direct bandwidth value instead of delay based on bandwidth
   values.
 - MSR register base addresses are different for MBA.
 - Also AMD allows non-contiguous L3 cache bit masks.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        | 69 +++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 70 +++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h    |  5 ++
 3 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c
index ba5a5b8c4681..2ec252be4ed9 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
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
@@ -255,7 +258,7 @@ static inline bool rdt_get_mb_table(struct rdt_resource=
 *r)
 	return false;
 }
=20
-static bool __get_mem_config(struct rdt_resource *r)
+static bool __get_mem_config_intel(struct rdt_resource *r)
 {
 	union cpuid_0x10_3_eax eax;
 	union cpuid_0x10_x_edx edx;
@@ -281,6 +284,30 @@ static bool __get_mem_config(struct rdt_resource *r)
 	return true;
 }
=20
+static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
+{
+	union cpuid_0x10_3_eax eax;
+	union cpuid_0x10_x_edx edx;
+	u32 ebx, ecx;
+
+	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
+	r->num_closid =3D edx.split.cos_max + 1;
+	r->default_ctrl =3D MAX_MBA_BW_AMD;
+
+	/* AMD does not use delay */
+	r->membw.delay_linear =3D false;
+
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
@@ -340,6 +367,15 @@ static int get_cache_id(int cpu, int level)
 	return -1;
 }
=20
+static void
+mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resour=
ce *r)
+{
+	unsigned int i;
+
+	for (i =3D m->low; i < m->high; i++)
+		wrmsrl(r->msr_base + i, d->ctrl_val[i]);
+}
+
 /*
  * Map the memory b/w percentage value to delay values
  * that can be written to QOS_MSRs.
@@ -793,8 +829,13 @@ static bool __init rdt_cpu_has(int flag)
=20
 static __init bool get_mem_config(void)
 {
-	if (rdt_cpu_has(X86_FEATURE_MBA))
-		return __get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
+	if (!rdt_cpu_has(X86_FEATURE_MBA))
+		return false;
+
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+		return __get_mem_config_intel(&rdt_resources_all[RDT_RESOURCE_MBA]);
+	else if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
+		return __rdt_get_mem_config_amd(&rdt_resources_all[RDT_RESOURCE_MBA]);
=20
 	return false;
 }
@@ -893,10 +934,32 @@ static __init void rdt_init_res_defs_intel(void)
 	}
 }
=20
+static __init void rdt_init_res_defs_amd(void)
+{
+	struct rdt_resource *r;
+
+	for_each_rdt_resource(r) {
+		if (r->rid =3D=3D RDT_RESOURCE_L3 ||
+		    r->rid =3D=3D RDT_RESOURCE_L3DATA ||
+		    r->rid =3D=3D RDT_RESOURCE_L3CODE ||
+		    r->rid =3D=3D RDT_RESOURCE_L2 ||
+		    r->rid =3D=3D RDT_RESOURCE_L2DATA ||
+		    r->rid =3D=3D RDT_RESOURCE_L2CODE)
+			r->cbm_validate =3D cbm_validate_amd;
+		else if (r->rid =3D=3D RDT_RESOURCE_MBA) {
+			r->msr_base =3D MSR_IA32_MBA_BW_BASE;
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
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl/ctrlmondata.c
index bfd7bdf8a156..286c03bb14a7 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -28,6 +28,52 @@
 #include <linux/slab.h>
 #include "internal.h"
=20
+/*
+ * Check whether MBA bandwidth percentage value is correct. The value is
+ * checked against the minimum and maximum bandwidth values specified by
+ * the hardware. The allocated bandwidth percentage is rounded to the next
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
+		 struct rdt_domain *d)
+{
+	unsigned long bw_val;
+
+	if (d->have_new_ctrl) {
+		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
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
+		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
+		return false;
+	}
+
+	if (val > r->default_ctrl) {
+		rdt_last_cmd_puts("Mask out of range\n");
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
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h
index 2fd4fd5d9da3..6f4f8567b972 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -11,6 +11,7 @@
 #define MSR_IA32_L3_CBM_BASE	0xc90
 #define MSR_IA32_L2_CBM_BASE	0xd10
 #define MSR_IA32_MBA_THRTL_BASE 0xd50
+#define MSR_IA32_MBA_BW_BASE	0xc0000200
=20
 #define MSR_IA32_QM_CTR		0x0c8e
 #define MSR_IA32_QM_EVTSEL	0x0c8d
@@ -34,6 +35,7 @@
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
 #define MBA_MAX_MBPS			U32_MAX
+#define MAX_MBA_BW_AMD			0x800
=20
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
@@ -448,6 +450,8 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_r=
esource *r,
 	      struct rdt_domain *d);
 int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
 		   struct rdt_domain *d);
+int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
+		 struct rdt_domain *d);
=20
 extern struct mutex rdtgroup_mutex;
=20
@@ -579,5 +583,6 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
+bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
=20
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
--=20
2.17.1

