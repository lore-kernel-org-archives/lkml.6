Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B928C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163E420883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rg9O3dm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163E420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbeKQHJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:09:26 -0500
Received: from mail-eopbgr820085.outbound.protection.outlook.com ([40.107.82.85]:21933
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729534AbeKQHIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJJx0lqCD1MDotEAjLdCcbiK2/E0IW5p1C3PEV2stQE=;
 b=rg9O3dm9dA63WGUsjqK6tFA+tuqax79b/GUMQXjaAs2AkwZuvzqhzR6Fev8/91jnh+X0dLD2D/patkZpAIaGvsCSgIiyz+jVre/yhCLZ+wD+OAjDkcQ13xLHu+64UWrRs2ix2D3AhGNDsQ76KKOx93FDbsUsfPouwEVGbckGrzU=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1577.namprd12.prod.outlook.com (10.172.39.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 16 Nov 2018 20:54:43 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 20:54:43 +0000
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
Subject: [PATCH v8 11/13] arch/resctrl: Introduce QOS feature for AMD
Thread-Topic: [PATCH v8 11/13] arch/resctrl: Introduce QOS feature for AMD
Thread-Index: AQHUfe6ZF6iH/8UL+0202oqHqJO23g==
Date:   Fri, 16 Nov 2018 20:54:43 +0000
Message-ID: <20181116205407.10457-12-babu.moger@amd.com>
References: <20181116205407.10457-1-babu.moger@amd.com>
In-Reply-To: <20181116205407.10457-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:805:f2::18) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1577;20:5erTs/46ht8WXbQWtLcgFNrLaBA28qEsN/eJqhRpW7k1NouZxbyYU2lbCXlrN/282OgF8Hmr0hdsLVum5VcVmGevc0g+xMDelm10FMNVdMqon8g+aLZx1ko4I6wAUl14XcvvS3WNWlsIcTCadSe2V+XMhmUNbQvosuCN/zsVlxgy8fD2ZwqbfirZVJG8u9FEDBSM0fclLYTobPw12rM3FCDQAl+IVBCQJYbP7adIkXY5E8d1lKdcloJuURePW5AT
x-ms-office365-filtering-correlation-id: 3559afcb-663d-4dbc-e0e7-08d64c05bc30
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1577;
x-ms-traffictypediagnostic: DM5PR12MB1577:
x-microsoft-antispam-prvs: <DM5PR12MB1577279406C03EADDC7DDD2795DD0@DM5PR12MB1577.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231415)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1577;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1577;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(189003)(199004)(43544003)(36756003)(316002)(66066001)(81156014)(6506007)(68736007)(2906002)(26005)(7736002)(102836004)(110136005)(72206003)(8676002)(8936002)(305945005)(478600001)(6486002)(386003)(2900100001)(97736004)(2501003)(54906003)(5660300001)(81166006)(52116002)(99286004)(1076002)(3846002)(6116002)(186003)(76176011)(486006)(7416002)(7406005)(6436002)(476003)(2201001)(2616005)(11346002)(4326008)(25786009)(446003)(106356001)(71190400001)(71200400001)(14444005)(256004)(105586002)(14454004)(6512007)(6306002)(53936002)(86362001)(966005)(575784001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1577;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rFY+vjFyRqQRunUHms/XZwT+sxu5BOpc17fPhoedtZZ0sKsD5GMHfuW6vCaiFzDhWlK1VOExhljMcubmChtT/hDWw7ugGqxkXvAOdb/ogMmb/oE0S409UK8FoHvV4wkqL3nV6bKwNYiT6wxTG/YnJYggIEA2VOnvrGkb232DzSqe4gUVELMayp8faHVR0w+j1SakLmG0iH6PaoHxkxEqIaPG2U8mRiRfEDmGmU8F8khqzLn73Kvb83sPavVTKdVERsQjnKVqCHZVMBKa4+QJwbUt3l+4xmRjbh5I8QRhwbqJZ9FAZRYv6VxJOXhwLPDt5P5DfPmuu8xIuvynUIg506c5AFcp68EdLCX/sBoCd6c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3559afcb-663d-4dbc-e0e7-08d64c05bc30
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 20:54:43.7612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1577
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
 arch/x86/kernel/cpu/resctrl.c             | 68 +++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl.h             |  5 ++
 arch/x86/kernel/cpu/resctrl_ctrlmondata.c | 70 +++++++++++++++++++++++
 3 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
index 3f26c7c114e7..0d700ab7fcf9 100644
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
@@ -792,8 +830,12 @@ static bool __init rdt_cpu_has(int flag)
=20
 static __init bool rdt_mba_config(void)
 {
-	if (rdt_cpu_has(X86_FEATURE_MBA))
-		return rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
+	if (rdt_cpu_has(X86_FEATURE_MBA)) {
+		if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+			return rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
+		else if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
+			return rdt_get_mem_config_amd(&rdt_resources_all[RDT_RESOURCE_MBA]);
+	}
=20
 	return false;
 }
@@ -892,10 +934,32 @@ static __init void rdt_init_res_defs_intel(void)
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
index 71aa1d971430..b6ceb4db9322 100644
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

