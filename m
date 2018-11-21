Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65A9214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YnWMts+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65A9214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbeKVHEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:04:32 -0500
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:42050
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730323AbeKVHEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGEAsERYn16B+uugOD4boxCdgy0Jmk2puCIUSMZ7Ld8=;
 b=YnWMts+n0QiyspqX3eAXZX5sEpFgm4vylVuwVRoD3bOz6NgBxwX+5Nr9etxp6ZeQHpHeCeM6hOE9pUd11uwr4gnoz5ZNAfNweVLa7EQaMrSb2DdHr6wEUYbiojL9B9jk98fAsj1jAR9bThYlE1gRZm491HRv0ibAWZzi1WQvJk0=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1610.namprd12.prod.outlook.com (10.172.40.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 20:28:28 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 20:28:28 +0000
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
Subject: [PATCH v9 02/13] x86/resctrl: Rename the RDT functions and
 definitions
Thread-Topic: [PATCH v9 02/13] x86/resctrl: Rename the RDT functions and
 definitions
Thread-Index: AQHUgdjCBrbrcTp0yk+Ime1uormqtw==
Date:   Wed, 21 Nov 2018 20:28:27 +0000
Message-ID: <20181121202811.4492-3-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1610;20:gM9Edq987TJom/WZcNUa/WYVGvBMSQWij9gkma82wsV74qkD1M8nohy6LARHUtMV1xy+oVMX3HvOJuifo7amz013d69VLS+uZJFh4XMsnU9kcoAKxysNgCDK6SMz4JakFUgnzHwZZfs0Q9AgqPpv2XpY39/nFygYYkyQDAkKwiCJpSF5PYw5LaRmqc7bhRVu/uFjgnLgm83HdwwmxxUEKVwrno6MhoVn0ABKkl1ou5KqpL2R1+3O/ACrgWiI6GbK
x-ms-office365-filtering-correlation-id: b009123b-1edb-4c84-2c34-08d64fefe4f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1610;
x-ms-traffictypediagnostic: DM5PR12MB1610:
x-microsoft-antispam-prvs: <DM5PR12MB1610E19EE1453D290410CD9195DA0@DM5PR12MB1610.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231442)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1610;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(54906003)(76176011)(52116002)(4744004)(256004)(71200400001)(71190400001)(5660300001)(6436002)(36756003)(68736007)(6486002)(99286004)(486006)(7416002)(26005)(2201001)(575784001)(66066001)(14444005)(7406005)(102836004)(6506007)(186003)(386003)(476003)(7736002)(6512007)(3846002)(2501003)(6116002)(478600001)(2900100001)(8936002)(305945005)(11346002)(53936002)(14454004)(97736004)(81156014)(81166006)(316002)(2616005)(110136005)(105586002)(446003)(106356001)(86362001)(8676002)(1076002)(25786009)(72206003)(4326008)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1610;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CEJ1NJBH9Dn+8bWUqovoSMsbPBWMD2pY8MgPQTm5IOYL2iSXmph7ZDJGdrrwQHO9z7WQuKwmOlOZWqU/7NyLKZ5kD4lx7Mz9KoQQenOkoAJ7tvM/aybJ1I7tIFW7tco1htyU6XSZrW+eQtKv0xM8wOjHwqxWlTzB6AjMj36igtjxXP/jxIczxYr++MLJIFN2J3ft3w/5pFJDdsmu7KGD/OMRXsG4QU71v9nqyuB7rQHChWGXHZpaB5+96WSmKQDfnAzf82SMnx+Ytepm3KQsOTAzT8oXJwl6UsQ8tcqnaOy4zJOJratCszL45v0UarpE3RtQcDTpOmwvtPD96h2ne9gThlb9Cr2ieObRACnE7yg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b009123b-1edb-4c84-2c34-08d64fefe4f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 20:28:27.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As AMD is starting to support RESCTRL features, rename
the RDT functions and definitions to more generic names.

Replace intel_rdt to resctrl where applicable.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/resctrl_sched.h   | 24 +++++++++++-----------
 arch/x86/kernel/cpu/resctrl/core.c     | 28 +++++++++++++-------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 11 +++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++-----
 arch/x86/kernel/process_32.c           |  2 +-
 arch/x86/kernel/process_64.c           |  2 +-
 7 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/re=
sctrl_sched.h
index 9acb06b6f81e..6e082697a613 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl_sched.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_INTEL_RDT_SCHED_H
-#define _ASM_X86_INTEL_RDT_SCHED_H
+#ifndef _ASM_X86_RESCTRL_SCHED_H
+#define _ASM_X86_RESCTRL_SCHED_H
=20
 #ifdef CONFIG_INTEL_RDT
=20
@@ -10,7 +10,7 @@
 #define IA32_PQR_ASSOC	0x0c8f
=20
 /**
- * struct intel_pqr_state - State cache for the PQR MSR
+ * struct resctrl_pqr_state - State cache for the PQR MSR
  * @cur_rmid:		The cached Resource Monitoring ID
  * @cur_closid:	The cached Class Of Service ID
  * @default_rmid:	The user assigned Resource Monitoring ID
@@ -24,21 +24,21 @@
  * The cache also helps to avoid pointless updates if the value does
  * not change.
  */
-struct intel_pqr_state {
+struct resctrl_pqr_state {
 	u32			cur_rmid;
 	u32			cur_closid;
 	u32			default_rmid;
 	u32			default_closid;
 };
=20
-DECLARE_PER_CPU(struct intel_pqr_state, pqr_state);
+DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
=20
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
=20
 /*
- * __intel_rdt_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
+ * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
  * Following considerations are made so that this has minimal impact
  * on scheduler hot path:
@@ -51,9 +51,9 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  *   simple as possible.
  * Must be called with preemption disabled.
  */
-static void __intel_rdt_sched_in(void)
+static void __resctrl_sched_in(void)
 {
-	struct intel_pqr_state *state =3D this_cpu_ptr(&pqr_state);
+	struct resctrl_pqr_state *state =3D this_cpu_ptr(&pqr_state);
 	u32 closid =3D state->default_closid;
 	u32 rmid =3D state->default_rmid;
=20
@@ -78,16 +78,16 @@ static void __intel_rdt_sched_in(void)
 	}
 }
=20
-static inline void intel_rdt_sched_in(void)
+static inline void resctrl_sched_in(void)
 {
 	if (static_branch_likely(&rdt_enable_key))
-		__intel_rdt_sched_in();
+		__resctrl_sched_in();
 }
=20
 #else
=20
-static inline void intel_rdt_sched_in(void) {}
+static inline void resctrl_sched_in(void) {}
=20
 #endif /* CONFIG_INTEL_RDT */
=20
-#endif /* _ASM_X86_INTEL_RDT_SCHED_H */
+#endif /* _ASM_X86_RESCTRL_SCHED_H */
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c
index 27c4316bb691..0cf890ae0de2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -22,7 +22,7 @@
  * Software Developer Manual June 2016, volume 3, section 17.17.
  */
=20
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+#define pr_fmt(fmt)	"resctrl: " fmt
=20
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -40,12 +40,12 @@
 DEFINE_MUTEX(rdtgroup_mutex);
=20
 /*
- * The cached intel_pqr_state is strictly per CPU and can never be
+ * The cached resctrl_pqr_state is strictly per CPU and can never be
  * updated from a remote CPU. Functions which modify the state
  * are called with interrupts disabled and no preemption, which
  * is sufficient for the protection.
  */
-DEFINE_PER_CPU(struct intel_pqr_state, pqr_state);
+DEFINE_PER_CPU(struct resctrl_pqr_state, pqr_state);
=20
 /*
  * Used to store the max resource name width and max resource data width
@@ -639,7 +639,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resou=
rce *r)
=20
 static void clear_closid_rmid(int cpu)
 {
-	struct intel_pqr_state *state =3D this_cpu_ptr(&pqr_state);
+	struct resctrl_pqr_state *state =3D this_cpu_ptr(&pqr_state);
=20
 	state->default_closid =3D 0;
 	state->default_rmid =3D 0;
@@ -648,7 +648,7 @@ static void clear_closid_rmid(int cpu)
 	wrmsr(IA32_PQR_ASSOC, 0, 0);
 }
=20
-static int intel_rdt_online_cpu(unsigned int cpu)
+static int resctrl_online_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
=20
@@ -674,7 +674,7 @@ static void clear_childcpus(struct rdtgroup *r, unsigne=
d int cpu)
 	}
 }
=20
-static int intel_rdt_offline_cpu(unsigned int cpu)
+static int resctrl_offline_cpu(unsigned int cpu)
 {
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -866,7 +866,7 @@ static __init bool get_rdt_resources(void)
=20
 static enum cpuhp_state rdt_online;
=20
-static int __init intel_rdt_late_init(void)
+static int __init resctrl_late_init(void)
 {
 	struct rdt_resource *r;
 	int state, ret;
@@ -877,8 +877,8 @@ static int __init intel_rdt_late_init(void)
 	rdt_init_padding();
=20
 	state =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
-				  "x86/rdt/cat:online:",
-				  intel_rdt_online_cpu, intel_rdt_offline_cpu);
+				  "x86/resctrl/cat:online:",
+				  resctrl_online_cpu, resctrl_offline_cpu);
 	if (state < 0)
 		return state;
=20
@@ -890,20 +890,20 @@ static int __init intel_rdt_late_init(void)
 	rdt_online =3D state;
=20
 	for_each_alloc_capable_rdt_resource(r)
-		pr_info("Intel RDT %s allocation detected\n", r->name);
+		pr_info("%s allocation detected\n", r->name);
=20
 	for_each_mon_capable_rdt_resource(r)
-		pr_info("Intel RDT %s monitoring detected\n", r->name);
+		pr_info("%s monitoring detected\n", r->name);
=20
 	return 0;
 }
=20
-late_initcall(intel_rdt_late_init);
+late_initcall(resctrl_late_init);
=20
-static void __exit intel_rdt_exit(void)
+static void __exit resctrl_exit(void)
 {
 	cpuhp_remove_state(rdt_online);
 	rdtgroup_exit();
 }
=20
-__exitcall(intel_rdt_exit);
+__exitcall(resctrl_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h
index 1b36709591d8..eeaee05522b5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -69,7 +69,7 @@ struct rmid_read {
 	u64			val;
 };
=20
-extern unsigned int intel_cqm_threshold;
+extern unsigned int resctrl_cqm_threshold;
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c
index d492d4c0e8cc..ebf408db8191 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -73,7 +73,7 @@ unsigned int rdt_mon_features;
  * This is the threshold cache occupancy at which we will consider an
  * RMID available for re-allocation.
  */
-unsigned int intel_cqm_threshold;
+unsigned int resctrl_cqm_threshold;
=20
 static inline struct rmid_entry *__rmid_entry(u32 rmid)
 {
@@ -107,7 +107,7 @@ static bool rmid_dirty(struct rmid_entry *entry)
 {
 	u64 val =3D __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
=20
-	return val >=3D intel_cqm_threshold;
+	return val >=3D resctrl_cqm_threshold;
 }
=20
 /*
@@ -187,7 +187,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	list_for_each_entry(d, &r->domains, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
 			val =3D __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
-			if (val <=3D intel_cqm_threshold)
+			if (val <=3D resctrl_cqm_threshold)
 				continue;
 		}
=20
@@ -625,6 +625,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)
=20
 int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
+	unsigned int cl_size =3D boot_cpu_data.x86_cache_size;
 	int ret;
=20
 	r->mon_scale =3D boot_cpu_data.x86_cache_occ_scale;
@@ -637,10 +638,10 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	intel_cqm_threshold =3D boot_cpu_data.x86_cache_size * 1024 / r->num_rmid=
;
+	resctrl_cqm_threshold =3D cl_size * 1024 / r->num_rmid;
=20
 	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
-	intel_cqm_threshold /=3D r->mon_scale;
+	resctrl_cqm_threshold /=3D r->mon_scale;
=20
 	ret =3D dom_data_init(r);
 	if (ret)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c
index f5a76ca43f0f..2bf1f3227afa 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -298,7 +298,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *=
of,
 }
=20
 /*
- * This is safe against intel_rdt_sched_in() called from __switch_to()
+ * This is safe against resctrl_sched_in() called from __switch_to()
  * because __switch_to() is executed with interrupts disabled. A local cal=
l
  * from update_closid_rmid() is proteced against __switch_to() because
  * preemption is disabled.
@@ -317,7 +317,7 @@ static void update_cpu_closid_rmid(void *info)
 	 * executing task might have its own closid selected. Just reuse
 	 * the context switch code.
 	 */
-	intel_rdt_sched_in();
+	resctrl_sched_in();
 }
=20
 /*
@@ -542,7 +542,7 @@ static void move_myself(struct callback_head *head)
=20
 	preempt_disable();
 	/* update PQR_ASSOC MSR to make resource group go into effect */
-	intel_rdt_sched_in();
+	resctrl_sched_in();
 	preempt_enable();
=20
 	kfree(callback);
@@ -926,7 +926,7 @@ static int max_threshold_occ_show(struct kernfs_open_fi=
le *of,
 {
 	struct rdt_resource *r =3D of->kn->parent->priv;
=20
-	seq_printf(seq, "%u\n", intel_cqm_threshold * r->mon_scale);
+	seq_printf(seq, "%u\n", resctrl_cqm_threshold * r->mon_scale);
=20
 	return 0;
 }
@@ -945,7 +945,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_op=
en_file *of,
 	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
 		return -EINVAL;
=20
-	intel_cqm_threshold =3D bytes / r->mon_scale;
+	resctrl_cqm_threshold =3D bytes / r->mon_scale;
=20
 	return nbytes;
 }
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index d16207e7d1e5..dc4d92764d1a 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -302,7 +302,7 @@ __switch_to(struct task_struct *prev_p, struct task_str=
uct *next_p)
 	this_cpu_write(current_task, next_p);
=20
 	/* Load the Intel cache allocation PQR MSR. */
-	intel_rdt_sched_in();
+	resctrl_sched_in();
=20
 	return prev_p;
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index af73223ad6ba..5ada7354b5d4 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -536,7 +536,7 @@ __switch_to(struct task_struct *prev_p, struct task_str=
uct *next_p)
 	}
=20
 	/* Load the Intel cache allocation PQR MSR. */
-	intel_rdt_sched_in();
+	resctrl_sched_in();
=20
 	return prev_p;
 }
--=20
2.17.1

