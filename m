Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2361C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7141A2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VBfBTDLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7141A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeJLECI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:02:08 -0400
Received: from mail-eopbgr730078.outbound.protection.outlook.com ([40.107.73.78]:48688
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725742AbeJLECI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQLI/QDinuWv1ilYwLyRPx4CAdYTottrzQgyoglT+fI=;
 b=VBfBTDLKQUU+TbKODPJfzqM0y8Qs2puEa8OyJMUii/Y038NGDLjvHLY64BPLJQ02i397ge9x4ujaV/cJF5pmCJZCHbYt02HgG9kGS+imZdG93IhylCxQaFVMy+Ryqy8xyIXBduoTLnR0Kq30Xl8f9xJl7LF3Y+X3DzfZvNGVDmk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.141.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Thu, 11 Oct 2018 20:33:08 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 20:33:08 +0000
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
Subject: [PATCH v3 02/11] arch/x86: Rename the RDT functions and definitions
Thread-Topic: [PATCH v3 02/11] arch/x86: Rename the RDT functions and
 definitions
Thread-Index: AQHUYaGejOimsl+qUkq9JrCRHOwNbg==
Date:   Thu, 11 Oct 2018 20:33:08 +0000
Message-ID: <20181011203223.18157-3-babu.moger@amd.com>
References: <20181011203223.18157-1-babu.moger@amd.com>
In-Reply-To: <20181011203223.18157-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0062.namprd22.prod.outlook.com
 (2603:10b6:300:12a::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2440;20:fDrIcwbiGpdjWM8Hx3HDRV73F8n1PLMUK5KK0HPRi2GwA9q4T1QtbsKvahb7BtusEjRx2Nq47cjzyyddD2jrSfNy0t9uPCed4eDBKwM3yT/WTKfCKyH4acf5EfM9lj9v2buTdy0HHTkMgVXliktyptNn3qKM6UL429QnAscCxv+tLRMJEjws8CMMsic+1bNxR1BoB2jB4jfEZHwfS5bm8+6EkNgcqtiIQwfe3PxqYYBuYlIUoicZdDbi4InhYeDD
x-ms-office365-filtering-correlation-id: d39677eb-7fbb-4c82-15e0-08d62fb8c140
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2440;
x-ms-traffictypediagnostic: DM5PR12MB2440:
x-microsoft-antispam-prvs: <DM5PR12MB2440D0207FDA9E0182D6178595E10@DM5PR12MB2440.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(72170088055959)(269456686620040)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DM5PR12MB2440;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2440;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(53936002)(76176011)(6486002)(478600001)(99286004)(52116002)(4326008)(6512007)(81166006)(6436002)(81156014)(5250100002)(8676002)(14454004)(2501003)(446003)(26005)(102836004)(2906002)(186003)(3846002)(6116002)(1076002)(7736002)(305945005)(7416002)(54906003)(486006)(97736004)(11346002)(476003)(2616005)(2900100001)(8936002)(106356001)(316002)(110136005)(575784001)(86362001)(256004)(25786009)(386003)(6506007)(66066001)(36756003)(72206003)(2201001)(71200400001)(71190400001)(5660300001)(68736007)(14444005)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2440;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P0unA0ke+R+L+pF7+jjz4MUQ0GrVHQfqUBJ3WvA7BtMBpkMoi9UmoLQj8M6kiiw7hQrlKH7jMAxJc+B/lR5DJ7OUxOouPm0wJF0+sSMgXn/Lh64GcO5McOpglWHHGkZhM/kBOLH6oClT7aIF19lr5S47PIY8HOwWp8tw7iz2LTI716HNohiBMYhuT+W4B1wD6GbzegYuo8cSUFYJSg5YPUmkQrjOW7RrpgPoXcHXJVRp+2pVlBsDknOUB5w02BY8jckOgJFYVPUMPhkmc4ynG+8Jf2ZiTXqZlH+A+jD2sJCWacu3EyQ+pVRI6+MzvcVPv6euEyOJFnZxkksOLu179qIKI1ngQ1hKwDn3mpOKH60=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39677eb-7fbb-4c82-15e0-08d62fb8c140
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 20:33:08.6397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As AMD is starting to support RDT(or QOS) features, rename
the RDT functions and definitions to more generic names.

Replace intel_rdt to resctrl where applicable.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/resctrl_sched.h   | 24 ++++++++++++------------
 arch/x86/kernel/cpu/resctrl.c          | 26 +++++++++++++-------------
 arch/x86/kernel/cpu/resctrl.h          |  2 +-
 arch/x86/kernel/cpu/resctrl_monitor.c  | 11 ++++++-----
 arch/x86/kernel/cpu/resctrl_rdtgroup.c | 10 +++++-----
 arch/x86/kernel/process_32.c           |  2 +-
 arch/x86/kernel/process_64.c           |  2 +-
 7 files changed, 39 insertions(+), 38 deletions(-)

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
diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
index 3968b54902b1..07158963ca30 100644
--- a/arch/x86/kernel/cpu/resctrl.c
+++ b/arch/x86/kernel/cpu/resctrl.c
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
@@ -632,7 +632,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resou=
rce *r)
=20
 static void clear_closid_rmid(int cpu)
 {
-	struct intel_pqr_state *state =3D this_cpu_ptr(&pqr_state);
+	struct resctrl_pqr_state *state =3D this_cpu_ptr(&pqr_state);
=20
 	state->default_closid =3D 0;
 	state->default_rmid =3D 0;
@@ -641,7 +641,7 @@ static void clear_closid_rmid(int cpu)
 	wrmsr(IA32_PQR_ASSOC, 0, 0);
 }
=20
-static int intel_rdt_online_cpu(unsigned int cpu)
+static int resctrl_online_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
=20
@@ -667,7 +667,7 @@ static void clear_childcpus(struct rdtgroup *r, unsigne=
d int cpu)
 	}
 }
=20
-static int intel_rdt_offline_cpu(unsigned int cpu)
+static int resctrl_offline_cpu(unsigned int cpu)
 {
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -859,7 +859,7 @@ static __init bool get_rdt_resources(void)
=20
 static enum cpuhp_state rdt_online;
=20
-static int __init intel_rdt_late_init(void)
+static int __init resctrl_late_init(void)
 {
 	struct rdt_resource *r;
 	int state, ret;
@@ -870,8 +870,8 @@ static int __init intel_rdt_late_init(void)
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
@@ -883,20 +883,20 @@ static int __init intel_rdt_late_init(void)
 	rdt_online =3D state;
=20
 	for_each_alloc_capable_rdt_resource(r)
-		pr_info("Intel RDT %s allocation detected\n", r->name);
+		pr_info("RESCTRL %s allocation detected\n", r->name);
=20
 	for_each_mon_capable_rdt_resource(r)
-		pr_info("Intel RDT %s monitoring detected\n", r->name);
+		pr_info("RESCTRL %s monitoring detected\n", r->name);
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
diff --git a/arch/x86/kernel/cpu/resctrl.h b/arch/x86/kernel/cpu/resctrl.h
index a9d906767bb2..abf5c7e4c625 100644
--- a/arch/x86/kernel/cpu/resctrl.h
+++ b/arch/x86/kernel/cpu/resctrl.h
@@ -69,7 +69,7 @@ struct rmid_read {
 	u64			val;
 };
=20
-extern unsigned int intel_cqm_threshold;
+extern unsigned int resctrl_cqm_threshold;
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
diff --git a/arch/x86/kernel/cpu/resctrl_monitor.c b/arch/x86/kernel/cpu/re=
sctrl_monitor.c
index 211d97bcbde5..68dbdbbf47df 100644
--- a/arch/x86/kernel/cpu/resctrl_monitor.c
+++ b/arch/x86/kernel/cpu/resctrl_monitor.c
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
@@ -637,10 +637,11 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	intel_cqm_threshold =3D boot_cpu_data.x86_cache_size * 1024 / r->num_rmid=
;
+	resctrl_cqm_threshold =3D boot_cpu_data.x86_cache_size * 1024 /
+				r->num_rmid;
=20
 	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
-	intel_cqm_threshold /=3D r->mon_scale;
+	resctrl_cqm_threshold /=3D r->mon_scale;
=20
 	ret =3D dom_data_init(r);
 	if (ret)
diff --git a/arch/x86/kernel/cpu/resctrl_rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl_rdtgroup.c
index 7a0c9aad89f9..879ff9206f42 100644
--- a/arch/x86/kernel/cpu/resctrl_rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl_rdtgroup.c
@@ -288,7 +288,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *=
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
@@ -307,7 +307,7 @@ static void update_cpu_closid_rmid(void *info)
 	 * executing task might have its own closid selected. Just reuse
 	 * the context switch code.
 	 */
-	intel_rdt_sched_in();
+	resctrl_sched_in();
 }
=20
 /*
@@ -532,7 +532,7 @@ static void move_myself(struct callback_head *head)
=20
 	preempt_disable();
 	/* update PQR_ASSOC MSR to make resource group go into effect */
-	intel_rdt_sched_in();
+	resctrl_sched_in();
 	preempt_enable();
=20
 	kfree(callback);
@@ -916,7 +916,7 @@ static int max_threshold_occ_show(struct kernfs_open_fi=
le *of,
 {
 	struct rdt_resource *r =3D of->kn->parent->priv;
=20
-	seq_printf(seq, "%u\n", intel_cqm_threshold * r->mon_scale);
+	seq_printf(seq, "%u\n", resctrl_cqm_threshold * r->mon_scale);
=20
 	return 0;
 }
@@ -935,7 +935,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_op=
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

