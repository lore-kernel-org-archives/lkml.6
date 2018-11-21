Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31BE214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cEdcJlWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31BE214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389616AbeKVHFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:05:41 -0500
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:42050
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730323AbeKVHEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2MP8pTfl2dx8Krh7yAFIbsBStVtePHolgVXumWl0LQ=;
 b=cEdcJlWQxoAUdtIiwgYvDJlmcuBaZF4rjQxsNBx+IvjNuyqipHdGZE+DylmJezaIfq+/4d7qsz9KoAg9BoyHM6aBg2rKcP3wzpbHxgtxj5XofHrWWTDUCZLADmJTW+W4ltZGXz+Rb12Cpx0pWneknJ4RYhEIDgDbndjWy6yRYX8=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1610.namprd12.prod.outlook.com (10.172.40.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 20:28:32 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 20:28:31 +0000
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
Subject: [PATCH v9 04/13] x86/resctrl: Bring all the macros to
 resctrl/internal.h
Thread-Topic: [PATCH v9 04/13] x86/resctrl: Bring all the macros to
 resctrl/internal.h
Thread-Index: AQHUgdjElIXMJYGTbUalTNfAFHBakA==
Date:   Wed, 21 Nov 2018 20:28:31 +0000
Message-ID: <20181121202811.4492-5-babu.moger@amd.com>
References: <20181121202811.4492-1-babu.moger@amd.com>
In-Reply-To: <20181121202811.4492-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0084.prod.exchangelabs.com (2603:10b6:800::52) To
 DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1610;20:oM415N9Q3C0rW33jWnmF8EKEa6vKoCXdIyhhS7GYWu/EI8q51A4lkgc29LKRJ5Trw9D5dCgExcJcHY71+qLmHT5W05RCf5aPqjhML31RuoFp/NJ4MfkbyEvo4stgGvQFMLbAzqcYUPk05AGQ2bTOkVuBE5E6+RWevxZuetZyGSq6fLhTYTKBwVGKdxTrEG8ndPTJfyrV5AX14R5Szm1uCu710ALBahLCp6vG3kwUiUNFhWknN7YT+7S8IjIVUpIh
x-ms-office365-filtering-correlation-id: 7c69aea2-5568-4dda-5fe4-08d64fefe74e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1610;
x-ms-traffictypediagnostic: DM5PR12MB1610:
x-microsoft-antispam-prvs: <DM5PR12MB1610090F43DDDBF7DE0E153195DA0@DM5PR12MB1610.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231442)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1610;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(54906003)(76176011)(52116002)(256004)(71200400001)(71190400001)(5660300001)(6436002)(36756003)(68736007)(6486002)(99286004)(486006)(7416002)(26005)(2201001)(575784001)(66066001)(14444005)(7406005)(102836004)(6506007)(186003)(386003)(476003)(7736002)(6512007)(3846002)(2501003)(6116002)(478600001)(2900100001)(8936002)(305945005)(11346002)(53936002)(14454004)(97736004)(81156014)(81166006)(316002)(2616005)(110136005)(105586002)(446003)(106356001)(86362001)(8676002)(1076002)(25786009)(72206003)(4326008)(2906002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1610;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: I8L6YKnQBd4jAEH0BuZcVYqi2NrDgIoPXjuLfkjK8CxbBo0mbpffeodkWWOcwZQ1UUjwHzun6dz8WzLQX7HnPllaSArkswykbadqvOpfEj4rp5HZeCfYiT4IlobvJPDEaYeyh+2Acg+i7dPfv+sZ3lfZjVOUqqUOdifUJZOYzptfmGaKioCWylHu41HPMaoGM4oAu2mU9Adz9aonmzn4xTj6fa7CCSzkEmK/5zCt3QUd4Sj2wjwKnkmKoqbJNtt7vUBOqBtEsCAmTO9uGA8lMmkB3de+d87RQ1AUFaW1QIU/zfvhxfJ7V/CeIBqxNO4ii9z63PpIJXmBgXB+Gm/CpGHzJ5HRP1JIGyHWjKINZ6g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c69aea2-5568-4dda-5fe4-08d64fefe74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 20:28:31.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring all the macros to resctrl/internal.h and rename the
registers with MSR_ prefix for consistency.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 22 ++++++++++------------
 arch/x86/kernel/cpu/resctrl/internal.h | 15 ++++++++++-----
 arch/x86/kernel/cpu/resctrl/monitor.c  |  3 ---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++--
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c
index 40380731c588..cf6491eeadc6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -33,9 +33,6 @@
 #include <asm/resctrl_sched.h>
 #include "internal.h"
=20
-#define MBA_IS_LINEAR	0x4
-#define MBA_MAX_MBPS	U32_MAX
-
 /* Mutex to protect rdtgroup access. */
 DEFINE_MUTEX(rdtgroup_mutex);
=20
@@ -72,7 +69,7 @@ struct rdt_resource rdt_resources_all[] =3D {
 		.rid			=3D RDT_RESOURCE_L3,
 		.name			=3D "L3",
 		.domains		=3D domain_init(RDT_RESOURCE_L3),
-		.msr_base		=3D IA32_L3_CBM_BASE,
+		.msr_base		=3D MSR_IA32_L3_CBM_BASE,
 		.msr_update		=3D cat_wrmsr,
 		.cache_level		=3D 3,
 		.cache =3D {
@@ -89,7 +86,7 @@ struct rdt_resource rdt_resources_all[] =3D {
 		.rid			=3D RDT_RESOURCE_L3DATA,
 		.name			=3D "L3DATA",
 		.domains		=3D domain_init(RDT_RESOURCE_L3DATA),
-		.msr_base		=3D IA32_L3_CBM_BASE,
+		.msr_base		=3D MSR_IA32_L3_CBM_BASE,
 		.msr_update		=3D cat_wrmsr,
 		.cache_level		=3D 3,
 		.cache =3D {
@@ -106,7 +103,7 @@ struct rdt_resource rdt_resources_all[] =3D {
 		.rid			=3D RDT_RESOURCE_L3CODE,
 		.name			=3D "L3CODE",
 		.domains		=3D domain_init(RDT_RESOURCE_L3CODE),
-		.msr_base		=3D IA32_L3_CBM_BASE,
+		.msr_base		=3D MSR_IA32_L3_CBM_BASE,
 		.msr_update		=3D cat_wrmsr,
 		.cache_level		=3D 3,
 		.cache =3D {
@@ -123,7 +120,7 @@ struct rdt_resource rdt_resources_all[] =3D {
 		.rid			=3D RDT_RESOURCE_L2,
 		.name			=3D "L2",
 		.domains		=3D domain_init(RDT_RESOURCE_L2),
-		.msr_base		=3D IA32_L2_CBM_BASE,
+		.msr_base		=3D MSR_IA32_L2_CBM_BASE,
 		.msr_update		=3D cat_wrmsr,
 		.cache_level		=3D 2,
 		.cache =3D {
@@ -140,7 +137,7 @@ struct rdt_resource rdt_resources_all[] =3D {
 		.rid			=3D RDT_RESOURCE_L2DATA,
 		.name			=3D "L2DATA",
 		.domains		=3D domain_init(RDT_RESOURCE_L2DATA),
-		.msr_base		=3D IA32_L2_CBM_BASE,
+		.msr_base		=3D MSR_IA32_L2_CBM_BASE,
 		.msr_update		=3D cat_wrmsr,
 		.cache_level		=3D 2,
 		.cache =3D {
@@ -157,7 +154,7 @@ struct rdt_resource rdt_resources_all[] =3D {
 		.rid			=3D RDT_RESOURCE_L2CODE,
 		.name			=3D "L2CODE",
 		.domains		=3D domain_init(RDT_RESOURCE_L2CODE),
-		.msr_base		=3D IA32_L2_CBM_BASE,
+		.msr_base		=3D MSR_IA32_L2_CBM_BASE,
 		.msr_update		=3D cat_wrmsr,
 		.cache_level		=3D 2,
 		.cache =3D {
@@ -174,7 +171,7 @@ struct rdt_resource rdt_resources_all[] =3D {
 		.rid			=3D RDT_RESOURCE_MBA,
 		.name			=3D "MB",
 		.domains		=3D domain_init(RDT_RESOURCE_MBA),
-		.msr_base		=3D IA32_MBA_THRTL_BASE,
+		.msr_base		=3D MSR_IA32_MBA_THRTL_BASE,
 		.msr_update		=3D mba_wrmsr,
 		.cache_level		=3D 3,
 		.parse_ctrlval		=3D parse_bw,
@@ -211,9 +208,10 @@ static inline void cache_alloc_hsw_probe(void)
 	struct rdt_resource *r  =3D &rdt_resources_all[RDT_RESOURCE_L3];
 	u32 l, h, max_cbm =3D BIT_MASK(20) - 1;
=20
-	if (wrmsr_safe(IA32_L3_CBM_BASE, max_cbm, 0))
+	if (wrmsr_safe(MSR_IA32_L3_CBM_BASE, max_cbm, 0))
 		return;
-	rdmsr(IA32_L3_CBM_BASE, l, h);
+
+	rdmsr(MSR_IA32_L3_CBM_BASE, l, h);
=20
 	/* If all the bits were set in MSR, return success */
 	if (l !=3D max_cbm)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h
index eeaee05522b5..cac360169205 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -6,11 +6,14 @@
 #include <linux/kernfs.h>
 #include <linux/jump_label.h>
=20
-#define IA32_L3_QOS_CFG		0xc81
-#define IA32_L2_QOS_CFG		0xc82
-#define IA32_L3_CBM_BASE	0xc90
-#define IA32_L2_CBM_BASE	0xd10
-#define IA32_MBA_THRTL_BASE	0xd50
+#define MSR_IA32_L3_QOS_CFG	0xc81
+#define MSR_IA32_L2_QOS_CFG	0xc82
+#define MSR_IA32_L3_CBM_BASE	0xc90
+#define MSR_IA32_L2_CBM_BASE	0xd10
+#define MSR_IA32_MBA_THRTL_BASE 0xd50
+
+#define MSR_IA32_QM_CTR		0x0c8e
+#define MSR_IA32_QM_EVTSEL	0x0c8d
=20
 #define L3_QOS_CDP_ENABLE	0x01ULL
=20
@@ -29,6 +32,8 @@
 #define MBM_CNTR_WIDTH			24
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
+#define MBA_IS_LINEAR			0x4
+#define MBA_MAX_MBPS			U32_MAX
=20
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c
index ebf408db8191..f33f11f69078 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -28,9 +28,6 @@
 #include <asm/cpu_device_id.h>
 #include "internal.h"
=20
-#define MSR_IA32_QM_CTR		0x0c8e
-#define MSR_IA32_QM_EVTSEL		0x0c8d
-
 struct rmid_entry {
 	u32				rmid;
 	int				busy;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c
index 2bf1f3227afa..cf159095b612 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1722,14 +1722,14 @@ static void l3_qos_cfg_update(void *arg)
 {
 	bool *enable =3D arg;
=20
-	wrmsrl(IA32_L3_QOS_CFG, *enable ? L3_QOS_CDP_ENABLE : 0ULL);
+	wrmsrl(MSR_IA32_L3_QOS_CFG, *enable ? L3_QOS_CDP_ENABLE : 0ULL);
 }
=20
 static void l2_qos_cfg_update(void *arg)
 {
 	bool *enable =3D arg;
=20
-	wrmsrl(IA32_L2_QOS_CFG, *enable ? L2_QOS_CDP_ENABLE : 0ULL);
+	wrmsrl(MSR_IA32_L2_QOS_CFG, *enable ? L2_QOS_CDP_ENABLE : 0ULL);
 }
=20
 static inline bool is_mba_linear(void)
--=20
2.17.1

