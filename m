Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D75C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB79E214C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bGUnCxu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB79E214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeJSGzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:55:43 -0400
Received: from mail-eopbgr730051.outbound.protection.outlook.com ([40.107.73.51]:56050
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727695AbeJSGzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTbg2dZQ0FbiCzUe4kIiYkIa0XVAWKV4D3ypnfwKmb8=;
 b=bGUnCxu66K55HTutj8cIV4ai7VM3d7x2VDcktfWG3FgV2FqILjhYOYjULnVO8LngIpaGqwaVjmSnHeY2Gy/jHx+AqeCxk78kZBsQ4+eEsnoaSJNKynFoyd+AD3zS6UgfVg9kJXAgEBoTjCApKd1bkBvptpVFFK3z//5wwlSTpjE=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1340.namprd12.prod.outlook.com (10.168.238.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Thu, 18 Oct 2018 22:52:27 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.028; Thu, 18 Oct 2018
 22:52:27 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v5 11/13] arch/x86: Introduce QOS feature for AMD
Thread-Topic: [PATCH v5 11/13] arch/x86: Introduce QOS feature for AMD
Thread-Index: AQHUZzU++wGCeO3pYkOTqk+BG6z4tw==
Date:   Thu, 18 Oct 2018 22:52:27 +0000
Message-ID: <20181018225124.23043-12-babu.moger@amd.com>
References: <20181018225124.23043-1-babu.moger@amd.com>
In-Reply-To: <20181018225124.23043-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0044.namprd02.prod.outlook.com
 (2603:10b6:803:2e::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1340;20:1QXuU429lek3mLUtDgtEFDxn2aR5DtuqNe1TKKki5Qiw6yY0erEMuwKEfTuWeNWg7D7AQdkri655nXpTifaC+fnRM5neXs8VVPirEfhIIBjCibyE+Z9wm8nDZbY+cUwvmvaEs6uS4NOUXg0Tgxc5h3TLZghqU2TrcNjAKyDwGikeh7lJwxjjnDbJtBhbgdiCZN35bWYvG1Auy86bV86BWu8eCk92namJkHol/K7vYLi5DjQZIeisy+j3pCRAxyYi
x-ms-office365-filtering-correlation-id: 48287b5e-52fd-4e5c-dddd-08d6354c6074
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1340;
x-ms-traffictypediagnostic: DM5PR12MB1340:
x-microsoft-antispam-prvs: <DM5PR12MB13402348A75A25D2637FC04395F80@DM5PR12MB1340.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1340;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1340;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(199004)(189003)(43544003)(86362001)(54906003)(966005)(186003)(71200400001)(110136005)(102836004)(575784001)(478600001)(26005)(106356001)(76176011)(52116002)(105586002)(72206003)(1076002)(66066001)(81156014)(71190400001)(8676002)(8936002)(14454004)(5660300001)(7416002)(7406005)(2906002)(68736007)(99286004)(6486002)(6506007)(386003)(6116002)(81166006)(2501003)(7736002)(6512007)(446003)(2201001)(53936002)(14444005)(25786009)(97736004)(5250100002)(256004)(6306002)(6436002)(305945005)(11346002)(4326008)(3846002)(316002)(36756003)(476003)(486006)(2900100001)(2616005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1340;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZToPij877XC7aVyZI+Bq/SIWkrpugtRC3RPrU/FUUIMFQZvFj7hI6V6tDyZ6P+HmVmQKUxrqyH+j2NFZY5gHluxYDqIvSQONcl+jmy2gxFywI+VBkhF7UhGBvDbFuYFewesXYcgU6h0apf7pXhW695UIthQ21roQ+0nErFUnhUY1F/z14wxZs8uzHY7DlNg3CI8CZmsP0bljm6duPGM8XZWCWkJYl64pL9hqecCxMPmhXrtBBYfbqB29GlS+07uQUDWPmCz8CTfE33CyC93gwghfqkOHaPHNMXcpMZslRCUoseESRUPYpM8fuZZMX0BSYFazGwYJ3fwzPfX/7QoLa4ote2mhougZy/7BdjNAelk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48287b5e-52fd-4e5c-dddd-08d6354c6074
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 22:52:27.7436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1340
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

Adds following functions to take care of the differences.
rdt_get_mem_config_amd : MBA initialization function
parse_bw_amd : Bandwidth parsing
mba_wrmsr_amd: Writes bandwidth value
cbm_validate_amd : L3 cache bitmask validation

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl.c             | 69 +++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl.h             |  5 ++
 arch/x86/kernel/cpu/resctrl_ctrlmondata.c | 70 +++++++++++++++++++++++
 3 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
index 058c9b12a978..7a149075ed24 100644
--- a/arch/x86/kernel/cpu/resctrl.c
+++ b/arch/x86/kernel/cpu/resctrl.c
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
@@ -786,8 +824,13 @@ static bool __init rdt_cpu_has(int flag)
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
@@ -887,10 +930,32 @@ static __init void rdt_init_res_defs_intel(void)
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
diff --git a/arch/x86/kernel/cpu/resctrl.h b/arch/x86/kernel/cpu/resctrl.h
index 102bcffbefd7..54ba21b7de2c 100644
--- a/arch/x86/kernel/cpu/resctrl.h
+++ b/arch/x86/kernel/cpu/resctrl.h
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
 #endif /* _ASM_X86_RESCTRL_H */
diff --git a/arch/x86/kernel/cpu/resctrl_ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl_ctrlmondata.c
index 867da06223b5..d88898dba23d 100644
--- a/arch/x86/kernel/cpu/resctrl_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl_ctrlmondata.c
@@ -28,6 +28,52 @@
 #include <linux/slab.h>
 #include "resctrl.h"
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
+		 struct rdt_domain *d)
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

