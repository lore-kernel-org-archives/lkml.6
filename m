Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E15EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24642098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YPLprcVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24642098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbeIYBWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:22:42 -0400
Received: from mail-eopbgr710076.outbound.protection.outlook.com ([40.107.71.76]:17984
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732289AbeIYBWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP6CgJg5ZgFzH4jDIc0MGtIRLFVYDDORZ6dCPxlox9M=;
 b=YPLprcVQKMd2JmGHeAz4yH6Bfzbun9NP38RkzjyR+0hviFYzPfc4feN5VU9Mrf2UugVw5mTbx0TXyUmrsIXuCyH+w6ZpG/D/a9EqW+KiDOtd73ujdRlIKt1yNFgQ0kKu2UMKJO4fD2dJfXrynwJZRw7s2JwkMgfKfAeEeELyjj8=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2455.namprd12.prod.outlook.com (52.132.141.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 19:18:58 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de%5]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 19:18:58 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
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
Subject: [RFC PATCH 02/10] arch/x86: Rename the RDT functions and definitions
Thread-Topic: [RFC PATCH 02/10] arch/x86: Rename the RDT functions and
 definitions
Thread-Index: AQHUVDtxz4ONi9hqmkO88hIjQWMl+w==
Date:   Mon, 24 Sep 2018 19:18:58 +0000
Message-ID: <20180924191841.29111-3-babu.moger@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
In-Reply-To: <20180924191841.29111-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:805:16::22) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2455;20:UEI85aOyDRMPP90iSSWv3GahVYkE/aGeTAG7sJ2+sWaJbcWDhKKBXcr80+V7jbUg9u6tGeDtpi5vSWG/9S93VUMJ8g0XNU9TZWqnvWMD++d4G65zq4JTCDP5d1zr6qQTaxVcpcjgNKtR9nDbLVt2EAIvut5utnDq+KrNpOysjlTXOMnLTouxwkKWtFE6as2WLCuMYgnBiPHNFB+vC9dMSlH/Kpxjzp14LzMqiTj7trIZIl2txYZsibtowd3aL52v
x-ms-office365-filtering-correlation-id: 4052d9c7-761c-440d-5c52-08d6225293b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2455;
x-ms-traffictypediagnostic: DM5PR12MB2455:
x-microsoft-antispam-prvs: <DM5PR12MB2455798686B7244B4548973295170@DM5PR12MB2455.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB2455;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2455;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(97736004)(217873002)(256004)(14444005)(2501003)(5250100002)(316002)(2900100001)(52116002)(7736002)(68736007)(305945005)(5660300001)(1076002)(76176011)(386003)(66066001)(6506007)(478600001)(72206003)(25786009)(7416002)(14454004)(4326008)(6436002)(106356001)(8936002)(8676002)(81156014)(81166006)(6512007)(36756003)(53936002)(26005)(2906002)(3846002)(6116002)(6486002)(575784001)(54906003)(86362001)(110136005)(102836004)(186003)(2201001)(486006)(71200400001)(446003)(476003)(11346002)(99286004)(2616005)(71190400001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2455;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: V3u+qcf/OQIc9dyg4mV5Myh3eDT6lzW5kBbpFIspqq+LZOsaS/9WnWz+nthU7rkFKO4hhK/BumyZkZ0g6VrhxOLbUSfymtM66Z3+lI8DM6YJwgvu9mkDnR71+sRoL5WXBcNac04ZRYoz/c5XgMUtkdbWfGalmbDn+SDwztwwZ40IkdJAOxZcEO4t7yghFOe8NfOjGovAgf2I6RgtTrLJ+1eXu/w5maiFOqg4Dbixve2phTD6acM279wKafgnlhQG6ZgJtZHXKrPimNBTGvuIZBIrNx5hafB4j570riizc52OdDQz55YoFK6KDg3MXf7H8XnXJOYGttDK6Z8MceWA+ciu/yFJ3vRfmwzbXLT/11s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4052d9c7-761c-440d-5c52-08d6225293b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 19:18:58.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As AMD is starting to support RDT(or QOS) features, rename
the RDT functions and definitions to more generic names.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/rdt_sched.h   | 22 +++++++++++-----------
 arch/x86/kernel/cpu/rdt.c          | 24 ++++++++++++------------
 arch/x86/kernel/cpu/rdt.h          |  8 ++++----
 arch/x86/kernel/cpu/rdt_monitor.c  | 10 +++++-----
 arch/x86/kernel/cpu/rdt_rdtgroup.c | 10 +++++-----
 arch/x86/kernel/process_32.c       |  2 +-
 arch/x86/kernel/process_64.c       |  2 +-
 7 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/rdt_sched.h b/arch/x86/include/asm/rdt_sc=
hed.h
index 9acb06b6f81e..666bf9acb41d 100644
--- a/arch/x86/include/asm/rdt_sched.h
+++ b/arch/x86/include/asm/rdt_sched.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_INTEL_RDT_SCHED_H
-#define _ASM_X86_INTEL_RDT_SCHED_H
+#ifndef _ASM_X86_RDT_SCHED_H
+#define _ASM_X86_RDT_SCHED_H
=20
 #ifdef CONFIG_INTEL_RDT
=20
@@ -24,21 +24,21 @@
  * The cache also helps to avoid pointless updates if the value does
  * not change.
  */
-struct intel_pqr_state {
+struct rdt_pqr_state {
 	u32			cur_rmid;
 	u32			cur_closid;
 	u32			default_rmid;
 	u32			default_closid;
 };
=20
-DECLARE_PER_CPU(struct intel_pqr_state, pqr_state);
+DECLARE_PER_CPU(struct rdt_pqr_state, pqr_state);
=20
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
=20
 /*
- * __intel_rdt_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
+ * __rdt_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
  * Following considerations are made so that this has minimal impact
  * on scheduler hot path:
@@ -51,9 +51,9 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  *   simple as possible.
  * Must be called with preemption disabled.
  */
-static void __intel_rdt_sched_in(void)
+static void __rdt_sched_in(void)
 {
-	struct intel_pqr_state *state =3D this_cpu_ptr(&pqr_state);
+	struct rdt_pqr_state *state =3D this_cpu_ptr(&pqr_state);
 	u32 closid =3D state->default_closid;
 	u32 rmid =3D state->default_rmid;
=20
@@ -78,16 +78,16 @@ static void __intel_rdt_sched_in(void)
 	}
 }
=20
-static inline void intel_rdt_sched_in(void)
+static inline void rdt_sched_in(void)
 {
 	if (static_branch_likely(&rdt_enable_key))
-		__intel_rdt_sched_in();
+		__rdt_sched_in();
 }
=20
 #else
=20
-static inline void intel_rdt_sched_in(void) {}
+static inline void rdt_sched_in(void) {}
=20
 #endif /* CONFIG_INTEL_RDT */
=20
-#endif /* _ASM_X86_INTEL_RDT_SCHED_H */
+#endif /* _ASM_X86_RDT_SCHED_H */
diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
index 28d6cd254ba9..b361c63170d7 100644
--- a/arch/x86/kernel/cpu/rdt.c
+++ b/arch/x86/kernel/cpu/rdt.c
@@ -40,12 +40,12 @@
 DEFINE_MUTEX(rdtgroup_mutex);
=20
 /*
- * The cached intel_pqr_state is strictly per CPU and can never be
+ * The cached rdt_pqr_state is strictly per CPU and can never be
  * updated from a remote CPU. Functions which modify the state
  * are called with interrupts disabled and no preemption, which
  * is sufficient for the protection.
  */
-DEFINE_PER_CPU(struct intel_pqr_state, pqr_state);
+DEFINE_PER_CPU(struct rdt_pqr_state, pqr_state);
=20
 /*
  * Used to store the max resource name width and max resource data width
@@ -634,7 +634,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resou=
rce *r)
=20
 static void clear_closid_rmid(int cpu)
 {
-	struct intel_pqr_state *state =3D this_cpu_ptr(&pqr_state);
+	struct rdt_pqr_state *state =3D this_cpu_ptr(&pqr_state);
=20
 	state->default_closid =3D 0;
 	state->default_rmid =3D 0;
@@ -643,7 +643,7 @@ static void clear_closid_rmid(int cpu)
 	wrmsr(IA32_PQR_ASSOC, 0, 0);
 }
=20
-static int intel_rdt_online_cpu(unsigned int cpu)
+static int rdt_online_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
=20
@@ -669,7 +669,7 @@ static void clear_childcpus(struct rdtgroup *r, unsigne=
d int cpu)
 	}
 }
=20
-static int intel_rdt_offline_cpu(unsigned int cpu)
+static int rdt_offline_cpu(unsigned int cpu)
 {
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -861,7 +861,7 @@ static __init bool get_rdt_resources(void)
=20
 static enum cpuhp_state rdt_online;
=20
-static int __init intel_rdt_late_init(void)
+static int __init rdt_late_init(void)
 {
 	struct rdt_resource *r;
 	int state, ret;
@@ -873,7 +873,7 @@ static int __init intel_rdt_late_init(void)
=20
 	state =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/rdt/cat:online:",
-				  intel_rdt_online_cpu, intel_rdt_offline_cpu);
+				  rdt_online_cpu, rdt_offline_cpu);
 	if (state < 0)
 		return state;
=20
@@ -885,20 +885,20 @@ static int __init intel_rdt_late_init(void)
 	rdt_online =3D state;
=20
 	for_each_alloc_capable_rdt_resource(r)
-		pr_info("Intel RDT %s allocation detected\n", r->name);
+		pr_info("RDT %s allocation detected\n", r->name);
=20
 	for_each_mon_capable_rdt_resource(r)
-		pr_info("Intel RDT %s monitoring detected\n", r->name);
+		pr_info("RDT %s monitoring detected\n", r->name);
=20
 	return 0;
 }
=20
-late_initcall(intel_rdt_late_init);
+late_initcall(rdt_late_init);
=20
-static void __exit intel_rdt_exit(void)
+static void __exit rdt_exit(void)
 {
 	cpuhp_remove_state(rdt_online);
 	rdtgroup_exit();
 }
=20
-__exitcall(intel_rdt_exit);
+__exitcall(rdt_exit);
diff --git a/arch/x86/kernel/cpu/rdt.h b/arch/x86/kernel/cpu/rdt.h
index 4e588f36228f..c15417a6b1af 100644
--- a/arch/x86/kernel/cpu/rdt.h
+++ b/arch/x86/kernel/cpu/rdt.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_INTEL_RDT_H
-#define _ASM_X86_INTEL_RDT_H
+#ifndef _ASM_X86_RDT_H
+#define _ASM_X86_RDT_H
=20
 #include <linux/sched.h>
 #include <linux/kernfs.h>
@@ -69,7 +69,7 @@ struct rmid_read {
 	u64			val;
 };
=20
-extern unsigned int intel_cqm_threshold;
+extern unsigned int rdt_cqm_threshold;
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
@@ -559,4 +559,4 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
=20
-#endif /* _ASM_X86_INTEL_RDT_H */
+#endif /* _ASM_X86_RDT_H */
diff --git a/arch/x86/kernel/cpu/rdt_monitor.c b/arch/x86/kernel/cpu/rdt_mo=
nitor.c
index 2898a61cbdd9..577514cd4a71 100644
--- a/arch/x86/kernel/cpu/rdt_monitor.c
+++ b/arch/x86/kernel/cpu/rdt_monitor.c
@@ -73,7 +73,7 @@ unsigned int rdt_mon_features;
  * This is the threshold cache occupancy at which we will consider an
  * RMID available for re-allocation.
  */
-unsigned int intel_cqm_threshold;
+unsigned int rdt_cqm_threshold;
=20
 static inline struct rmid_entry *__rmid_entry(u32 rmid)
 {
@@ -107,7 +107,7 @@ static bool rmid_dirty(struct rmid_entry *entry)
 {
 	u64 val =3D __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
=20
-	return val >=3D intel_cqm_threshold;
+	return val >=3D rdt_cqm_threshold;
 }
=20
 /*
@@ -187,7 +187,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	list_for_each_entry(d, &r->domains, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
 			val =3D __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
-			if (val <=3D intel_cqm_threshold)
+			if (val <=3D rdt_cqm_threshold)
 				continue;
 		}
=20
@@ -637,10 +637,10 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	intel_cqm_threshold =3D boot_cpu_data.x86_cache_size * 1024 / r->num_rmid=
;
+	rdt_cqm_threshold =3D boot_cpu_data.x86_cache_size * 1024 / r->num_rmid;
=20
 	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
-	intel_cqm_threshold /=3D r->mon_scale;
+	rdt_cqm_threshold /=3D r->mon_scale;
=20
 	ret =3D dom_data_init(r);
 	if (ret)
diff --git a/arch/x86/kernel/cpu/rdt_rdtgroup.c b/arch/x86/kernel/cpu/rdt_r=
dtgroup.c
index c4a226ebf4e9..159b56980715 100644
--- a/arch/x86/kernel/cpu/rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/rdt_rdtgroup.c
@@ -281,7 +281,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *=
of,
 }
=20
 /*
- * This is safe against intel_rdt_sched_in() called from __switch_to()
+ * This is safe against rdt_sched_in() called from __switch_to()
  * because __switch_to() is executed with interrupts disabled. A local cal=
l
  * from update_closid_rmid() is proteced against __switch_to() because
  * preemption is disabled.
@@ -300,7 +300,7 @@ static void update_cpu_closid_rmid(void *info)
 	 * executing task might have its own closid selected. Just reuse
 	 * the context switch code.
 	 */
-	intel_rdt_sched_in();
+	rdt_sched_in();
 }
=20
 /*
@@ -525,7 +525,7 @@ static void move_myself(struct callback_head *head)
=20
 	preempt_disable();
 	/* update PQR_ASSOC MSR to make resource group go into effect */
-	intel_rdt_sched_in();
+	rdt_sched_in();
 	preempt_enable();
=20
 	kfree(callback);
@@ -909,7 +909,7 @@ static int max_threshold_occ_show(struct kernfs_open_fi=
le *of,
 {
 	struct rdt_resource *r =3D of->kn->parent->priv;
=20
-	seq_printf(seq, "%u\n", intel_cqm_threshold * r->mon_scale);
+	seq_printf(seq, "%u\n", rdt_cqm_threshold * r->mon_scale);
=20
 	return 0;
 }
@@ -928,7 +928,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_op=
en_file *of,
 	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
 		return -EINVAL;
=20
-	intel_cqm_threshold =3D bytes / r->mon_scale;
+	rdt_cqm_threshold =3D bytes / r->mon_scale;
=20
 	return nbytes;
 }
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 931b2d0cb95e..d9e7e5668fe1 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -302,7 +302,7 @@ __switch_to(struct task_struct *prev_p, struct task_str=
uct *next_p)
 	this_cpu_write(current_task, next_p);
=20
 	/* Load the Intel cache allocation PQR MSR. */
-	intel_rdt_sched_in();
+	rdt_sched_in();
=20
 	return prev_p;
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index c029782a9216..3b38d37b7742 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -536,7 +536,7 @@ __switch_to(struct task_struct *prev_p, struct task_str=
uct *next_p)
 	}
=20
 	/* Load the Intel cache allocation PQR MSR. */
-	intel_rdt_sched_in();
+	rdt_sched_in();
=20
 	return prev_p;
 }
--=20
2.17.1

