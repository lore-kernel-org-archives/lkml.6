Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EF0ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9F32098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ri8fB71h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9F32098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbeIYBW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:22:56 -0400
Received: from mail-eopbgr710056.outbound.protection.outlook.com ([40.107.71.56]:63200
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731044AbeIYBWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MweYzh4FnRzsJsxCQQ26wcfPMaUbkg4CLXL/wZsPZgo=;
 b=Ri8fB71hAfyjLzYpLIDjpFF7UT8H8+vECsPClYdnHznU0NTSiwSOX7Q9e4nNP8xRmENH2UPQKyX/fj+Zem/VRH4qNjAPfsmEx7O/65gsNcd0UItOZWt8g7fkqh/wRcMYGGOuU/AcHmaaYWaIdrjDNT6IuPzg5DJQ3g5EOye6egQ=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2455.namprd12.prod.outlook.com (52.132.141.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 19:19:10 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de%5]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 19:19:10 +0000
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
Subject: [RFC PATCH 07/10] arch/x86: Bring few more functions into the
 resource structure
Thread-Topic: [RFC PATCH 07/10] arch/x86: Bring few more functions into the
 resource structure
Thread-Index: AQHUVDt4YuH74QyC9kKLTMNotdmRdA==
Date:   Mon, 24 Sep 2018 19:19:09 +0000
Message-ID: <20180924191841.29111-8-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2455;20:M7bAtmMnq+foci8MlbVtJBEZ/LmTPQSgNolv/54AHniOBQruspdQQgpV3pHh+TX78Xrl0/OA/oFB9AflOWplUyovZjtQRgTFc+fH95VOzyfGUft+kL6bwST9VoeWAEJI9PkThDx3jftkRC5BepfwDA6NPESxmBBTGpgQ8eewxnliKaLzF2WBEgWo9lAWGCyeYKH/+k/PrX4NB3vcWQmj8xzbXseGobWSpVMqgPNC8Eg0+0ZxenRIcH3N/Jgo9g0t
x-ms-office365-filtering-correlation-id: 8b182d94-937f-4e8e-fe1c-08d622529a76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2455;
x-ms-traffictypediagnostic: DM5PR12MB2455:
x-microsoft-antispam-prvs: <DM5PR12MB2455A9A241FB7029A3DE5EA395170@DM5PR12MB2455.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(72170088055959)(269456686620040)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB2455;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2455;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(97736004)(217873002)(256004)(14444005)(2501003)(5250100002)(316002)(2900100001)(52116002)(7736002)(68736007)(305945005)(5660300001)(1076002)(76176011)(386003)(66066001)(6506007)(478600001)(72206003)(25786009)(7416002)(14454004)(4326008)(6436002)(106356001)(8936002)(8676002)(81156014)(81166006)(6512007)(36756003)(53936002)(26005)(2906002)(3846002)(6116002)(6486002)(575784001)(54906003)(86362001)(110136005)(102836004)(186003)(2201001)(486006)(71200400001)(446003)(476003)(11346002)(99286004)(2616005)(71190400001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2455;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OSkwh4lBSNvfiLLAUgz7ypiqEcsc7QzDG9A/6PHz1dyzmt6P+7LFa3R0cc+PQx5fY7cb5d2vfdgXvTjRlDELMruWLazKAVRpbgKfBZOjgLiH00quVqrwifZA6JWGdV3N/h0yzAtqRUNce9dwdPhd2nT+Wc80oxdHLmrErzFrUBhFFFDAXkbkvcnPnpx0NdDM4hUDpRFW+cQiGFa4cIfk27MBEYcaacAvvZC3gGAaNeDKgyQR3SVfFjs1HCSR+7b5esU1afkkl/d9lTHklhh6bAJgBg1NKa/9bsflS+MBtJt5vhaepjGafCqBndJfhMoAKhKyBcsOFIYSSEIEB8Ps0ywJE4MfcjWl0X+17jc9Gc8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b182d94-937f-4e8e-fe1c-08d622529a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 19:19:09.8559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring all resource functions that are different between the vendors
into resource structure and initialize them dynamically.

Implement these functions separately for each vendors.
update_mba_bw : Feedback loop bandwidth update functionality is not
                needed for AMD.
cbm_validate  : Cache bitmask validate function. AMD allows
                non-contiguous masks. So, use separate functions for
                Intel and AMD.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/rdt.c             | 17 +++++++++++++----
 arch/x86/kernel/cpu/rdt.h             | 19 +++++++++++++------
 arch/x86/kernel/cpu/rdt_ctrlmondata.c |  4 ++--
 arch/x86/kernel/cpu/rdt_monitor.c     | 10 +++++++---
 4 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
index 6dec45bf81d6..ae26b9b3fafa 100644
--- a/arch/x86/kernel/cpu/rdt.c
+++ b/arch/x86/kernel/cpu/rdt.c
@@ -867,10 +867,19 @@ static __init void rdt_init_res_defs_intel(void)
 	struct rdt_resource *r;
=20
 	for_each_rdt_resource(r) {
-		if (r->rid =3D=3D RDT_RESOURCE_MBA) {
-			r->msr_base =3D IA32_MBA_THRTL_BASE;
-			r->msr_update =3D mba_wrmsr;
-			r->parse_ctrlval =3D parse_bw;
+		if ((r->rid =3D=3D RDT_RESOURCE_L3) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L3DATA) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L3CODE) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2DATA) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2CODE))
+			r->cbm_validate =3D cbm_validate;
+
+		else if (r->rid =3D=3D RDT_RESOURCE_MBA) {
+			 r->msr_base =3D IA32_MBA_THRTL_BASE;
+			 r->msr_update =3D mba_wrmsr;
+			 r->parse_ctrlval =3D parse_bw;
+			 r->update_mba_bw =3D update_mba_bw;
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/rdt.h b/arch/x86/kernel/cpu/rdt.h
index 2569c10c37f4..7205157d359b 100644
--- a/arch/x86/kernel/cpu/rdt.h
+++ b/arch/x86/kernel/cpu/rdt.h
@@ -386,9 +386,9 @@ static inline bool is_mbm_event(int e)
  * struct rdt_resource - attributes of an RDT resource
  * @rid:		The index of the resource
  * @alloc_enabled:	Is allocation enabled on this machine
- * @mon_enabled:		Is monitoring enabled for this feature
+ * @mon_enabled:	Is monitoring enabled for this feature
  * @alloc_capable:	Is allocation available on this machine
- * @mon_capable:		Is monitor feature available on this machine
+ * @mon_capable:	Is monitor feature available on this machine
  * @name:		Name to use in "schemata" file
  * @num_closid:		Number of CLOSIDs available
  * @cache_level:	Which cache level defines scope of this resource
@@ -400,10 +400,12 @@ static inline bool is_mbm_event(int e)
  * @cache:		Cache allocation related data
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
- * @evt_list:			List of monitoring events
- * @num_rmid:			Number of RMIDs available
- * @mon_scale:			cqm counter * mon_scale =3D occupancy in bytes
- * @fflags:			flags to choose base and info files
+ * @update_mba_bw:	Feedback loop for MBA software controllerer function
+ * @cbm_validate	Cache bitmask validate function
+ * @evt_list:		List of monitoring events
+ * @num_rmid:		Number of RMIDs available
+ * @mon_scale:		cqm counter * mon_scale =3D occupancy in bytes
+ * @fflags:		flags to choose base and info files
  */
 struct rdt_resource {
 	int			rid;
@@ -425,6 +427,9 @@ struct rdt_resource {
 	const char		*format_str;
 	int (*parse_ctrlval)	(void *data, struct rdt_resource *r,
 				 struct rdt_domain *d);
+	void (*update_mba_bw)   (struct rdtgroup *rgrp,
+				 struct rdt_domain *dom_mbm);
+	bool (*cbm_validate)    (char *buf, u32 *data, struct rdt_resource *r);
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
@@ -562,5 +567,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, un=
signed long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
+void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm);
+bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r);
=20
 #endif /* _ASM_X86_RDT_H */
diff --git a/arch/x86/kernel/cpu/rdt_ctrlmondata.c b/arch/x86/kernel/cpu/rd=
t_ctrlmondata.c
index 0565c564b297..5a282b6c4bd7 100644
--- a/arch/x86/kernel/cpu/rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/rdt_ctrlmondata.c
@@ -88,7 +88,7 @@ int parse_bw(void *_buf, struct rdt_resource *r, struct r=
dt_domain *d)
  *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
  * Additionally Haswell requires at least two bits set.
  */
-static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
+bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
 	unsigned long first_bit, zero_bit, val;
 	unsigned int cbm_len =3D r->cache.cbm_len;
@@ -153,7 +153,7 @@ int parse_cbm(void *_data, struct rdt_resource *r, stru=
ct rdt_domain *d)
 		return -EINVAL;
 	}
=20
-	if (!cbm_validate(data->buf, &cbm_val, r))
+	if ((r->cbm_validate) && !(r->cbm_validate(data->buf, &cbm_val, r)))
 		return -EINVAL;
=20
 	if ((rdtgrp->mode =3D=3D RDT_MODE_EXCLUSIVE ||
diff --git a/arch/x86/kernel/cpu/rdt_monitor.c b/arch/x86/kernel/cpu/rdt_mo=
nitor.c
index 577514cd4a71..0dc0260f10d9 100644
--- a/arch/x86/kernel/cpu/rdt_monitor.c
+++ b/arch/x86/kernel/cpu/rdt_monitor.c
@@ -361,7 +361,7 @@ void mon_event_count(void *info)
  * throttle MSRs already have low percentage values.  To avoid
  * unnecessarily restricting such rdtgroups, we also increase the bandwidt=
h.
  */
-static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mb=
m)
+void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
@@ -520,6 +520,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	unsigned long delay =3D msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
 	struct rdtgroup *prgrp, *crgrp;
 	int cpu =3D smp_processor_id();
+	struct rdt_resource *r_mba;
 	struct list_head *head;
 	struct rdt_domain *d;
=20
@@ -539,8 +540,11 @@ void mbm_handle_overflow(struct work_struct *work)
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
 			mbm_update(d, crgrp->mon.rmid);
=20
-		if (is_mba_sc(NULL))
-			update_mba_bw(prgrp, d);
+		if (is_mba_sc(NULL)) {
+			r_mba =3D &rdt_resources_all[RDT_RESOURCE_MBA];
+			if (r_mba->update_mba_bw)
+				r_mba->update_mba_bw(prgrp, d);
+		}
 	}
=20
 	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
--=20
2.17.1

