Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0946C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED3320644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jkYSNs4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED3320644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJLECm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:02:42 -0400
Received: from mail-eopbgr690056.outbound.protection.outlook.com ([40.107.69.56]:26601
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbeJLECm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJVzqlgvis4Gu/l4mXSPjhKe3XEUaLGSahaY+wzOtHM=;
 b=jkYSNs4tKvPTJKSBHeHW0CQFO8VwjXdvWIJ5y5zvYoFwqiqQHIKgLqLH+ISQJnAKRUIZ5+41i4u0Fn8LP6LhsxdhAM8W3g3eUGJuT4+OBfq9Hc2dzjSWStOkKZu7BFBIWdbkkgi9mMvcilLGMCTjGRuxHntalHasvr/DmoZrpXo=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1834.namprd12.prod.outlook.com (10.175.92.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Thu, 11 Oct 2018 20:33:43 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 20:33:43 +0000
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
Subject: [PATCH v3 11/11] arch/x86: Introduce QOS feature for AMD
Thread-Topic: [PATCH v3 11/11] arch/x86: Introduce QOS feature for AMD
Thread-Index: AQHUYaGzdGn1C/CPh0GP/0Avd8NAEA==
Date:   Thu, 11 Oct 2018 20:33:43 +0000
Message-ID: <20181011203223.18157-12-babu.moger@amd.com>
References: <20181011203223.18157-1-babu.moger@amd.com>
In-Reply-To: <20181011203223.18157-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0062.namprd22.prod.outlook.com
 (2603:10b6:300:12a::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1834;20:iq9fmtC2XFKtAlrxg25ptaFukvsWbQePw6IyBDywJGJs8RModPqdhhXeJ60ZN24ztLFRKWvVtKb5M38qV7CzucP21p5k8vlzAzchAnb2ZAz8B8p7PteMmJbPyYm4nXHGJs/kN+89c9TAdVGsjbBsADpBKtEm/gCDDe90OKvRLJ2e1iIoOGaWfHUYLeb9PhTtvx5t4LlQs6CoUp2kjO6q6KMvmW3IwtUvOknd+P84HnUXJjcpti6Swg107LFRrsJ4
x-ms-office365-filtering-correlation-id: 5b4d6418-07ef-416a-5be2-08d62fb8d5ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1834;
x-ms-traffictypediagnostic: DM5PR12MB1834:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB1834D05E89A022381C47023295E10@DM5PR12MB1834.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991062);SRVR:DM5PR12MB1834;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1834;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(39860400002)(396003)(43544003)(189003)(199004)(8936002)(110136005)(54906003)(8676002)(7416002)(66066001)(386003)(68736007)(6506007)(7736002)(99286004)(6116002)(52116002)(3846002)(76176011)(72206003)(5660300001)(478600001)(2900100001)(1076002)(966005)(186003)(102836004)(14454004)(476003)(6436002)(2201001)(53936002)(105586002)(71190400001)(71200400001)(2616005)(486006)(5250100002)(26005)(575784001)(6486002)(6512007)(6306002)(2501003)(86362001)(2906002)(305945005)(81166006)(81156014)(97736004)(316002)(256004)(446003)(106356001)(25786009)(11346002)(4326008)(14444005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1834;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sIQXpkcSLMguT9WwqyXgnvX+EEFQp74EiOox8jusPXzzXRfONt2/AxMi+Kq2RU6fYp1oKTlxMQ39TnWAhe0dM2KDk4ltuDwvd0aWt2Gkoisu0A5kZ1kqUv+tjzh12iLa7HM+E95GTyWOT88/enEutFEgkkkDAXjk9hPkH582mxADD/hTwNQ2ra8an06DV45MyKhBab0+iSEQjJcrRmqtmzoIMem2jk2GvNV1ogpIjgqP/JtezLAWVO0bJkqImDtOb90FJJyDNhC9PRU6lTNrjwkYWD7KsuD4i05Tc0twZF7JxKiv67Yb/E1H4FGSCOrtLzDTHOvTH+eJWkyE7D2as//SbQEyksjjpc6cdc1A9J4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4d6418-07ef-416a-5be2-08d62fb8d5ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 20:33:43.2421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1834
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
index 9eb5c102c300..b1e31ef52bc0 100644
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
@@ -888,10 +931,32 @@ static __init void rdt_init_res_defs_intel(void)
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
diff --git a/arch/x86/kernel/cpu/resctrl.h b/arch/x86/kernel/cpu/resctrl.h
index 825d5571539e..3b8b5ade77ab 100644
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
 #endif /* _ASM_X86_RESCTRL_H */
diff --git a/arch/x86/kernel/cpu/resctrl_ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl_ctrlmondata.c
index 867da06223b5..e071f2c6e36e 100644
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

