Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15F5C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4D3214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DTxB87sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4D3214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389551AbeKVHEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:04:45 -0500
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:42050
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733262AbeKVHEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoQDlWIHz+jRfZhxlKKDhEL6hL/BCBonFNkMlnzbbvw=;
 b=DTxB87skMLVC45JzIDC+YPIs94nE0/LAi99TngEenlXbU6VIJoro+OYurtTnaCrg/xApVvsjVwqxB1xQ/xmcwzI1OCJkCm0bS97QkgtEYRAhgMR72xpVMioPVeTIX+bD/gUZLSfu9JLPsu512t8bXKEWlb9Mx0QinyGnGegJlHE=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1610.namprd12.prod.outlook.com (10.172.40.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 20:28:43 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 20:28:44 +0000
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
Subject: [PATCH v9 10/13] x86/resctrl: Fix the messages in rdt_last_cmd_printf
 and rdt_last_cmd_puts
Thread-Topic: [PATCH v9 10/13] x86/resctrl: Fix the messages in
 rdt_last_cmd_printf and rdt_last_cmd_puts
Thread-Index: AQHUgdjMVrzqDpyTukWUqoNJ1fFjgw==
Date:   Wed, 21 Nov 2018 20:28:43 +0000
Message-ID: <20181121202811.4492-11-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1610;20:WpFfahcJcloYzVHQnSH4JnguVU3/JC5op00vnrW4FbMATgsdg4YOiu2Fm4dLv2LWMsmqPbfEvqwhOx/9uEgD+FC2G6ykvvh1tzjUmXPtukXU5gvLV9WM0Yjdb/qYMyhedoHr/k2QpWoxDKA9c1i4k+ZiZ2KR7BrTpUVdvWI15f468JHsFdPD2MM/VMUSmiiNx8ijM9Fiw0I7avC11Zt2o6F8A5Au77af5eZ9imPpJAVCiL6qZcrq472+aX1J6Xqp
x-ms-office365-filtering-correlation-id: 6fedd9ba-bb40-406d-0e00-08d64fefee73
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1610;
x-ms-traffictypediagnostic: DM5PR12MB1610:
x-microsoft-antispam-prvs: <DM5PR12MB16106EDA2FCEABA82C2281B195DA0@DM5PR12MB1610.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231442)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1610;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(11346002)(305945005)(53936002)(2900100001)(8936002)(97736004)(81166006)(81156014)(14454004)(6512007)(478600001)(6116002)(2501003)(3846002)(25786009)(1076002)(4326008)(72206003)(2906002)(105586002)(110136005)(106356001)(446003)(2616005)(316002)(86362001)(8676002)(36756003)(6436002)(5660300001)(486006)(68736007)(6486002)(99286004)(256004)(4744004)(52116002)(54906003)(76176011)(71200400001)(71190400001)(102836004)(6506007)(186003)(476003)(7736002)(386003)(7416002)(26005)(2201001)(15650500001)(66066001)(14444005)(575784001)(7406005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1610;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WwxvTHF2tFgFSzTvTfnKq06fhus4U5cdqBBgGVkpdVIobHBLtxaQd71OYEmeFfeKZajZpe3yu3+debQTonQEyt8JoYXLy6Wp7SE6V8RQrzicV8dH/G45xMQFRfHkeiwV4wimV9GODnPLuxCTcAKkOS+qWcT75N9ekdjflqpq+vG9tk3a14nFRG3mcRi/Fr0g3/MTIuw0Lrs22NQt6J9jnglzgNV0FY7GxN8FJ6PGgjC2CcRXo8gm9syz8H0kbbf2VT0Vt4c3uBwssR+I8KCEsCO6+i/iWThKb+QeuPhna42PY2MWrZvqEFdjM7FT+ddavNDWqtrUr4F/ND9QRs+m1HopLBFhsEUVMfMKU/KzxiA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fedd9ba-bb40-406d-0e00-08d64fefee73
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 20:28:43.7674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the messages in rdt_last_cmd_printf and rdt_last_cmd_puts to make
it more meaningful and consistent.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 22 +++++++-------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 34 ++++++++++-----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 36 +++++++++++------------
 3 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl/ctrlmondata.c
index d2e0b99d453f..bfd7bdf8a156 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -70,7 +70,7 @@ int parse_bw_intel(struct rdt_parse_data *data, struct rd=
t_resource *r,
 	unsigned long bw_val;
=20
 	if (d->have_new_ctrl) {
-		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
+		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
=20
@@ -96,12 +96,12 @@ bool cbm_validate_intel(char *buf, u32 *data, struct rd=
t_resource *r)
=20
 	ret =3D kstrtoul(buf, 16, &val);
 	if (ret) {
-		rdt_last_cmd_printf("non-hex character in mask %s\n", buf);
+		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
 		return false;
 	}
=20
 	if (val =3D=3D 0 || val > r->default_ctrl) {
-		rdt_last_cmd_puts("mask out of range\n");
+		rdt_last_cmd_puts("Mask out of range\n");
 		return false;
 	}
=20
@@ -109,12 +109,12 @@ bool cbm_validate_intel(char *buf, u32 *data, struct =
rdt_resource *r)
 	zero_bit =3D find_next_zero_bit(&val, cbm_len, first_bit);
=20
 	if (find_next_bit(&val, cbm_len, zero_bit) < cbm_len) {
-		rdt_last_cmd_printf("mask %lx has non-consecutive 1-bits\n", val);
+		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
 		return false;
 	}
=20
 	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
-		rdt_last_cmd_printf("Need at least %d bits in mask\n",
+		rdt_last_cmd_printf("Need at least %d bits in the mask\n",
 				    r->cache.min_cbm_bits);
 		return false;
 	}
@@ -134,7 +134,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_r=
esource *r,
 	u32 cbm_val;
=20
 	if (d->have_new_ctrl) {
-		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
+		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
=20
@@ -144,7 +144,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_r=
esource *r,
 	 */
 	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP &&
 	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
-		rdt_last_cmd_printf("pseudo-locked region in hierarchy\n");
+		rdt_last_cmd_printf("Pseudo-locked region in hierarchy\n");
 		return -EINVAL;
 	}
=20
@@ -163,14 +163,14 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt=
_resource *r,
 	 * either is exclusive.
 	 */
 	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true)) {
-		rdt_last_cmd_printf("overlaps with exclusive group\n");
+		rdt_last_cmd_printf("Overlaps with exclusive group\n");
 		return -EINVAL;
 	}
=20
 	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, false)) {
 		if (rdtgrp->mode =3D=3D RDT_MODE_EXCLUSIVE ||
 		    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
-			rdt_last_cmd_printf("overlaps with other group\n");
+			rdt_last_cmd_printf("0verlaps with other group\n");
 			return -EINVAL;
 		}
 	}
@@ -292,7 +292,7 @@ static int rdtgroup_parse_resource(char *resname, char =
*tok,
 		if (!strcmp(resname, r->name) && rdtgrp->closid < r->num_closid)
 			return parse_line(tok, r, rdtgrp);
 	}
-	rdt_last_cmd_printf("unknown/unsupported resource name '%s'\n", resname);
+	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resnam=
e);
 	return -EINVAL;
 }
=20
@@ -323,7 +323,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file=
 *of,
 	 */
 	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
 		ret =3D -EINVAL;
-		rdt_last_cmd_puts("resource group is pseudo-locked\n");
+		rdt_last_cmd_puts("Resource group is pseudo-locked\n");
 		goto out;
 	}
=20
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cp=
u/resctrl/pseudo_lock.c
index 27d75c328d58..a4b037820ce2 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -213,7 +213,7 @@ static int pseudo_lock_cstates_constrain(struct pseudo_=
lock_region *plr)
 	for_each_cpu(cpu, &plr->d->cpu_mask) {
 		pm_req =3D kzalloc(sizeof(*pm_req), GFP_KERNEL);
 		if (!pm_req) {
-			rdt_last_cmd_puts("fail allocating mem for PM QoS\n");
+			rdt_last_cmd_puts("Failure to allocate mem for PM QoS\n");
 			ret =3D -ENOMEM;
 			goto out_err;
 		}
@@ -222,7 +222,7 @@ static int pseudo_lock_cstates_constrain(struct pseudo_=
lock_region *plr)
 					     DEV_PM_QOS_RESUME_LATENCY,
 					     30);
 		if (ret < 0) {
-			rdt_last_cmd_printf("fail to add latency req cpu%d\n",
+			rdt_last_cmd_printf("Failed to add latency req cpu%d\n",
 					    cpu);
 			kfree(pm_req);
 			ret =3D -1;
@@ -289,7 +289,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_r=
egion *plr)
 	plr->cpu =3D cpumask_first(&plr->d->cpu_mask);
=20
 	if (!cpu_online(plr->cpu)) {
-		rdt_last_cmd_printf("cpu %u associated with cache not online\n",
+		rdt_last_cmd_printf("CPU %u associated with cache not online\n",
 				    plr->cpu);
 		ret =3D -ENODEV;
 		goto out_region;
@@ -307,7 +307,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_r=
egion *plr)
 	}
=20
 	ret =3D -1;
-	rdt_last_cmd_puts("unable to determine cache line size\n");
+	rdt_last_cmd_puts("Unable to determine cache line size\n");
 out_region:
 	pseudo_lock_region_clear(plr);
 	return ret;
@@ -361,14 +361,14 @@ static int pseudo_lock_region_alloc(struct pseudo_loc=
k_region *plr)
 	 * KMALLOC_MAX_SIZE.
 	 */
 	if (plr->size > KMALLOC_MAX_SIZE) {
-		rdt_last_cmd_puts("requested region exceeds maximum size\n");
+		rdt_last_cmd_puts("Requested region exceeds maximum size\n");
 		ret =3D -E2BIG;
 		goto out_region;
 	}
=20
 	plr->kmem =3D kzalloc(plr->size, GFP_KERNEL);
 	if (!plr->kmem) {
-		rdt_last_cmd_puts("unable to allocate memory\n");
+		rdt_last_cmd_puts("Unable to allocate memory\n");
 		ret =3D -ENOMEM;
 		goto out_region;
 	}
@@ -665,7 +665,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 * default closid associated with it.
 	 */
 	if (rdtgrp =3D=3D &rdtgroup_default) {
-		rdt_last_cmd_puts("cannot pseudo-lock default group\n");
+		rdt_last_cmd_puts("Cannot pseudo-lock default group\n");
 		return -EINVAL;
 	}
=20
@@ -707,17 +707,17 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 */
 	prefetch_disable_bits =3D get_prefetch_disable_bits();
 	if (prefetch_disable_bits =3D=3D 0) {
-		rdt_last_cmd_puts("pseudo-locking not supported\n");
+		rdt_last_cmd_puts("Pseudo-locking not supported\n");
 		return -EINVAL;
 	}
=20
 	if (rdtgroup_monitor_in_progress(rdtgrp)) {
-		rdt_last_cmd_puts("monitoring in progress\n");
+		rdt_last_cmd_puts("Monitoring in progress\n");
 		return -EINVAL;
 	}
=20
 	if (rdtgroup_tasks_assigned(rdtgrp)) {
-		rdt_last_cmd_puts("tasks assigned to resource group\n");
+		rdt_last_cmd_puts("Tasks assigned to resource group\n");
 		return -EINVAL;
 	}
=20
@@ -727,13 +727,13 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	}
=20
 	if (rdtgroup_locksetup_user_restrict(rdtgrp)) {
-		rdt_last_cmd_puts("unable to modify resctrl permissions\n");
+		rdt_last_cmd_puts("Unable to modify resctrl permissions\n");
 		return -EIO;
 	}
=20
 	ret =3D pseudo_lock_init(rdtgrp);
 	if (ret) {
-		rdt_last_cmd_puts("unable to init pseudo-lock region\n");
+		rdt_last_cmd_puts("Unable to init pseudo-lock region\n");
 		goto out_release;
 	}
=20
@@ -770,7 +770,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 	if (rdt_mon_capable) {
 		ret =3D alloc_rmid();
 		if (ret < 0) {
-			rdt_last_cmd_puts("out of RMIDs\n");
+			rdt_last_cmd_puts("Out of RMIDs\n");
 			return ret;
 		}
 		rdtgrp->mon.rmid =3D ret;
@@ -1304,7 +1304,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtg=
rp)
 					"pseudo_lock/%u", plr->cpu);
 	if (IS_ERR(thread)) {
 		ret =3D PTR_ERR(thread);
-		rdt_last_cmd_printf("locking thread returned error %d\n", ret);
+		rdt_last_cmd_printf("Locking thread returned error %d\n", ret);
 		goto out_cstates;
 	}
=20
@@ -1322,13 +1322,13 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rd=
tgrp)
 		 * the cleared, but not freed, plr struct resulting in an
 		 * empty pseudo-locking loop.
 		 */
-		rdt_last_cmd_puts("locking thread interrupted\n");
+		rdt_last_cmd_puts("Locking thread interrupted\n");
 		goto out_cstates;
 	}
=20
 	ret =3D pseudo_lock_minor_get(&new_minor);
 	if (ret < 0) {
-		rdt_last_cmd_puts("unable to obtain a new minor number\n");
+		rdt_last_cmd_puts("Unable to obtain a new minor number\n");
 		goto out_cstates;
 	}
=20
@@ -1360,7 +1360,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtg=
rp)
=20
 	if (IS_ERR(dev)) {
 		ret =3D PTR_ERR(dev);
-		rdt_last_cmd_printf("failed to create character device: %d\n",
+		rdt_last_cmd_printf("Failed to create character device: %d\n",
 				    ret);
 		goto out_debugfs;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c
index fada488069cb..9da3dcc94f1a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -345,7 +345,7 @@ static int cpus_mon_write(struct rdtgroup *rdtgrp, cpum=
ask_var_t newmask,
 	/* Check whether cpus belong to parent ctrl group */
 	cpumask_andnot(tmpmask, newmask, &prgrp->cpu_mask);
 	if (cpumask_weight(tmpmask)) {
-		rdt_last_cmd_puts("can only add CPUs to mongroup that belong to parent\n=
");
+		rdt_last_cmd_puts("Can only add CPUs to mongroup that belong to parent\n=
");
 		return -EINVAL;
 	}
=20
@@ -470,14 +470,14 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open=
_file *of,
 	rdt_last_cmd_clear();
 	if (!rdtgrp) {
 		ret =3D -ENOENT;
-		rdt_last_cmd_puts("directory was removed\n");
+		rdt_last_cmd_puts("Directory was removed\n");
 		goto unlock;
 	}
=20
 	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED ||
 	    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
 		ret =3D -EINVAL;
-		rdt_last_cmd_puts("pseudo-locking in progress\n");
+		rdt_last_cmd_puts("Pseudo-locking in progress\n");
 		goto unlock;
 	}
=20
@@ -487,7 +487,7 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_f=
ile *of,
 		ret =3D cpumask_parse(buf, newmask);
=20
 	if (ret) {
-		rdt_last_cmd_puts("bad cpu list/mask\n");
+		rdt_last_cmd_puts("Bad cpu list/mask\n");
 		goto unlock;
 	}
=20
@@ -495,7 +495,7 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_f=
ile *of,
 	cpumask_andnot(tmpmask, newmask, cpu_online_mask);
 	if (cpumask_weight(tmpmask)) {
 		ret =3D -EINVAL;
-		rdt_last_cmd_puts("can only assign online cpus\n");
+		rdt_last_cmd_puts("Can only assign online cpus\n");
 		goto unlock;
 	}
=20
@@ -574,7 +574,7 @@ static int __rdtgroup_move_task(struct task_struct *tsk=
,
 		 */
 		atomic_dec(&rdtgrp->waitcount);
 		kfree(callback);
-		rdt_last_cmd_puts("task exited\n");
+		rdt_last_cmd_puts("Task exited\n");
 	} else {
 		/*
 		 * For ctrl_mon groups move both closid and rmid.
@@ -692,7 +692,7 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_=
file *of,
 	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED ||
 	    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
 		ret =3D -EINVAL;
-		rdt_last_cmd_puts("pseudo-locking in progress\n");
+		rdt_last_cmd_puts("Pseudo-locking in progress\n");
 		goto unlock;
 	}
=20
@@ -1158,14 +1158,14 @@ static bool rdtgroup_mode_test_exclusive(struct rdt=
group *rdtgrp)
 		list_for_each_entry(d, &r->domains, list) {
 			if (rdtgroup_cbm_overlaps(r, d, d->ctrl_val[closid],
 						  rdtgrp->closid, false)) {
-				rdt_last_cmd_puts("schemata overlaps\n");
+				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
 			}
 		}
 	}
=20
 	if (!has_cache) {
-		rdt_last_cmd_puts("cannot be exclusive without CAT/CDP\n");
+		rdt_last_cmd_puts("Cannot be exclusive without CAT/CDP\n");
 		return false;
 	}
=20
@@ -1206,7 +1206,7 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open=
_file *of,
 		goto out;
=20
 	if (mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
-		rdt_last_cmd_printf("cannot change pseudo-locked group\n");
+		rdt_last_cmd_printf("Cannot change pseudo-locked group\n");
 		ret =3D -EINVAL;
 		goto out;
 	}
@@ -1235,7 +1235,7 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open=
_file *of,
 			goto out;
 		rdtgrp->mode =3D RDT_MODE_PSEUDO_LOCKSETUP;
 	} else {
-		rdt_last_cmd_printf("unknown/unsupported mode\n");
+		rdt_last_cmd_printf("Unknown orunsupported mode\n");
 		ret =3D -EINVAL;
 	}
=20
@@ -2543,7 +2543,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgr=
p)
 			tmp_cbm =3D d->new_ctrl;
 			if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) <
 			    r->cache.min_cbm_bits) {
-				rdt_last_cmd_printf("no space on %s:%d\n",
+				rdt_last_cmd_printf("No space on %s:%d\n",
 						    r->name, d->id);
 				return -ENOSPC;
 			}
@@ -2560,7 +2560,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgr=
p)
 			continue;
 		ret =3D update_domains(r, rdtgrp->closid);
 		if (ret < 0) {
-			rdt_last_cmd_puts("failed to initialize allocations\n");
+			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			return ret;
 		}
 		rdtgrp->mode =3D RDT_MODE_SHAREABLE;
@@ -2583,7 +2583,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *pare=
nt_kn,
 	rdt_last_cmd_clear();
 	if (!prdtgrp) {
 		ret =3D -ENODEV;
-		rdt_last_cmd_puts("directory was removed\n");
+		rdt_last_cmd_puts("Directory was removed\n");
 		goto out_unlock;
 	}
=20
@@ -2591,7 +2591,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *pare=
nt_kn,
 	    (prdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP ||
 	     prdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED)) {
 		ret =3D -EINVAL;
-		rdt_last_cmd_puts("pseudo-locking in progress\n");
+		rdt_last_cmd_puts("Pseudo-locking in progress\n");
 		goto out_unlock;
 	}
=20
@@ -2599,7 +2599,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *pare=
nt_kn,
 	rdtgrp =3D kzalloc(sizeof(*rdtgrp), GFP_KERNEL);
 	if (!rdtgrp) {
 		ret =3D -ENOSPC;
-		rdt_last_cmd_puts("kernel out of memory\n");
+		rdt_last_cmd_puts("Kernel out of memory\n");
 		goto out_unlock;
 	}
 	*r =3D rdtgrp;
@@ -2640,7 +2640,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *pare=
nt_kn,
 	if (rdt_mon_capable) {
 		ret =3D alloc_rmid();
 		if (ret < 0) {
-			rdt_last_cmd_puts("out of RMIDs\n");
+			rdt_last_cmd_puts("Out of RMIDs\n");
 			goto out_destroy;
 		}
 		rdtgrp->mon.rmid =3D ret;
@@ -2728,7 +2728,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node=
 *parent_kn,
 	kn =3D rdtgrp->kn;
 	ret =3D closid_alloc();
 	if (ret < 0) {
-		rdt_last_cmd_puts("out of CLOSIDs\n");
+		rdt_last_cmd_puts("Out of CLOSIDs\n");
 		goto out_common_fail;
 	}
 	closid =3D ret;
--=20
2.17.1

