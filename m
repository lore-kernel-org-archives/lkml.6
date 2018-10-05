Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A98C65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F69521473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x1AP7RMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F69521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbeJFD4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:56:39 -0400
Received: from mail-eopbgr720056.outbound.protection.outlook.com ([40.107.72.56]:14656
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729252AbeJFD4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKhID44x7MRJ0NBps4ZEs9eiCoRYjXbTK+HYrYA85sE=;
 b=x1AP7RMCq14O6XzUothh4ivgxqUFe10lPnX4PqFtblmnproq+yBGxcsf5SaLbMfDztvXCRk2Reza0Zh33CRG8WpP8G9EfjYbOMrA6snxt0bCFVz5SBco4l7XwPGIYmOQtknE4/2D9U4p0JakSXy7QRPqCwHHAb4leYSezDbk9LA=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2504.namprd12.prod.outlook.com (52.132.141.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Fri, 5 Oct 2018 20:56:02 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 20:56:03 +0000
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
Subject: [PATCH v2 08/11] arch/x86: Bring few more functions into the resource
 structure
Thread-Topic: [PATCH v2 08/11] arch/x86: Bring few more functions into the
 resource structure
Thread-Index: AQHUXO3TWC0Trwkd70ui0vhf9YkUgw==
Date:   Fri, 5 Oct 2018 20:56:02 +0000
Message-ID: <20181005205512.29545-9-babu.moger@amd.com>
References: <20181005205512.29545-1-babu.moger@amd.com>
In-Reply-To: <20181005205512.29545-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:404:b4::28) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2504;20:9Ib/6lXnROxCT98JUxk2KNqAp+CzfJRVEtpuOu/yC+o+vXhtAaJo2xUtSUH//GRWkkDBeeMgmWDf16F+lG96wnaIWgcoxWGNT/7Lksmdgvpp+vf19KN9tVS60kPiPonhaFDYRWAzzsJrxGumZW70S8B5wXYNQSsGvo9/Am/YRYVlgDpI4GCT3aUirIi7+tx9MnfR881is7O5dogqOncU+K/t7GScveZIY8LB18STkJ0GU+c2WOEMrSUy3Rndrcj8
x-ms-office365-filtering-correlation-id: 97af5e77-494a-48cc-b95e-08d62b04f5ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2504;
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-microsoft-antispam-prvs: <DM5PR12MB25043FA1767FAA6989B0EF0F95EB0@DM5PR12MB2504.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302102)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:DM5PR12MB2504;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2504;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(110136005)(2201001)(256004)(36756003)(72206003)(102836004)(54906003)(14444005)(6512007)(305945005)(52116002)(25786009)(14454004)(53936002)(386003)(8936002)(478600001)(68736007)(105586002)(6506007)(66066001)(99286004)(86362001)(106356001)(2900100001)(575784001)(7416002)(4326008)(476003)(486006)(8676002)(6116002)(76176011)(3846002)(7736002)(71190400001)(71200400001)(316002)(2906002)(186003)(11346002)(2501003)(81156014)(81166006)(446003)(5660300001)(5250100002)(6486002)(6436002)(2616005)(97736004)(26005)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2504;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xlkNdwjahM7ihr9zzmRaKkf9Vsa/trdlWRduzoH6fwf8+OXRR0qU2ZxgfUlO9oMY+f79IMaIBu2Hu6sE6CjaHL6MIqGZzLVJoEYHHeXYrkWp3AEI5HvE/SugjTUj9To/lkTi2Z/12QoLHA1sPgyff72v6kIIOG1d39M7pFkaOESeeUZworFFxkelnR5qSQLNQBIS5ZSPO0YwdDBn3CR8ksdXdrMPrsnkrONf1zzmGCIVOSnSllADyw8L/h/fv3mhv1P8A275tU052Rb5h+Y/SbAwGkJmIXSIonUmSRQ6woecFrg24AAlKEbdxHqQxMa/qfL7on1q4S/aqowwi3N6QUO55gkIF+ztWIt0xj1oc4o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97af5e77-494a-48cc-b95e-08d62b04f5ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 20:56:02.8020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring all resource functions that are different between the vendors
into resource structure and initialize them dynamically.
Add _intel suffix to Intel specific functions.

Implement these functions separately for each vendors.
update_mba_bw : Feedback loop bandwidth update functionality is not
                needed for AMD.
cbm_validate  : Cache bitmask validate function. AMD allows
                non-contiguous masks. So, use separate functions for
                Intel and AMD.
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/rdt.c             | 10 +++++++++-
 arch/x86/kernel/cpu/rdt.h             | 15 +++++++++++----
 arch/x86/kernel/cpu/rdt_ctrlmondata.c |  4 ++--
 arch/x86/kernel/cpu/rdt_monitor.c     | 10 +++++++---
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
index 9680a43d9485..c7c2dbaae7bb 100644
--- a/arch/x86/kernel/cpu/rdt.c
+++ b/arch/x86/kernel/cpu/rdt.c
@@ -874,10 +874,18 @@ static __init void rdt_init_res_defs_intel(void)
 	struct rdt_resource *r;
=20
 	for_each_rdt_resource(r) {
-		if (r->rid =3D=3D RDT_RESOURCE_MBA) {
+		if ((r->rid =3D=3D RDT_RESOURCE_L3) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L3DATA) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L3CODE) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2DATA) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2CODE))
+			r->cbm_validate =3D cbm_validate_intel;
+		else if (r->rid =3D=3D RDT_RESOURCE_MBA) {
 			r->msr_base =3D IA32_MBA_THRTL_BASE;
 			r->msr_update =3D mba_wrmsr_intel;
 			r->parse_ctrlval =3D parse_bw_intel;
+			r->update_mba_bw =3D update_mba_bw_intel;
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/rdt.h b/arch/x86/kernel/cpu/rdt.h
index 42bf239313a0..cb7e5a4739fc 100644
--- a/arch/x86/kernel/cpu/rdt.h
+++ b/arch/x86/kernel/cpu/rdt.h
@@ -410,10 +410,12 @@ struct rdt_parse_data {
  * @cache:		Cache allocation related data
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
- * @evt_list:			List of monitoring events
- * @num_rmid:			Number of RMIDs available
- * @mon_scale:			cqm counter * mon_scale =3D occupancy in bytes
- * @fflags:			flags to choose base and info files
+ * @update_mba_bw:	Feedback loop for MBA software controller function
+ * @cbm_validate	Cache bitmask validate function
+ * @evt_list:		List of monitoring events
+ * @num_rmid:		Number of RMIDs available
+ * @mon_scale:		cqm counter * mon_scale =3D occupancy in bytes
+ * @fflags:		flags to choose base and info files
  */
 struct rdt_resource {
 	int			rid;
@@ -436,6 +438,9 @@ struct rdt_resource {
 	int (*parse_ctrlval)(struct rdt_parse_data *data,
 			     struct rdt_resource *r,
 			     struct rdt_domain *d);
+	void (*update_mba_bw)(struct rdtgroup *rgrp,
+			      struct rdt_domain *dom_mbm);
+	bool (*cbm_validate)(char *buf, u32 *data, struct rdt_resource *r);
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
@@ -576,5 +581,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, un=
signed long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
+void update_mba_bw_intel(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm=
);
+bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
=20
 #endif /* _ASM_X86_RDT_H */
diff --git a/arch/x86/kernel/cpu/rdt_ctrlmondata.c b/arch/x86/kernel/cpu/rd=
t_ctrlmondata.c
index ee3e8389d8d2..af8506003ee8 100644
--- a/arch/x86/kernel/cpu/rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/rdt_ctrlmondata.c
@@ -88,7 +88,7 @@ int parse_bw_intel(struct rdt_parse_data *data, struct rd=
t_resource *r,
  *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
  * Additionally Haswell requires at least two bits set.
  */
-static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
+bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
 {
 	unsigned long first_bit, zero_bit, val;
 	unsigned int cbm_len =3D r->cache.cbm_len;
@@ -148,7 +148,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_r=
esource *r,
 		return -EINVAL;
 	}
=20
-	if (!cbm_validate(data->buf, &cbm_val, r))
+	if (r->cbm_validate && !r->cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
=20
 	if ((rdtgrp->mode =3D=3D RDT_MODE_EXCLUSIVE ||
diff --git a/arch/x86/kernel/cpu/rdt_monitor.c b/arch/x86/kernel/cpu/rdt_mo=
nitor.c
index c8b95561f5be..cd621237a6bb 100644
--- a/arch/x86/kernel/cpu/rdt_monitor.c
+++ b/arch/x86/kernel/cpu/rdt_monitor.c
@@ -358,7 +358,7 @@ void mon_event_count(void *info)
  * throttle MSRs already have low percentage values.  To avoid
  * unnecessarily restricting such rdtgroups, we also increase the bandwidt=
h.
  */
-static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mb=
m)
+void update_mba_bw_intel(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm=
)
 {
 	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
@@ -517,6 +517,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	unsigned long delay =3D msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
 	struct rdtgroup *prgrp, *crgrp;
 	int cpu =3D smp_processor_id();
+	struct rdt_resource *r_mba;
 	struct list_head *head;
 	struct rdt_domain *d;
=20
@@ -536,8 +537,11 @@ void mbm_handle_overflow(struct work_struct *work)
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

