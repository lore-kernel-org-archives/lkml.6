Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D06DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338ED20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n8tj9XqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338ED20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJLEDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:03:05 -0400
Received: from mail-co1nam03on0052.outbound.protection.outlook.com ([104.47.40.52]:2515
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725742AbeJLEDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58nPSEItvyhntNyHxN+hVjHmR8ausPP3c/IyMSth3bA=;
 b=n8tj9XqYvRJHDljPWg0sv7yO3fUBQIh7nDu6R8Odxkds/ChKJvk6PQR7Q0Jk7atHMbtD0Uhx1k6ibsiJpL/YqZkCWuKQdNOrdYl8uyEIhHLL/wp6d/86E9O4JgBZayGLxsGhxXd8w+UHJ3tubQSjaKHZxfhTZZLRUZF0eJtcO5k=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2408.namprd12.prod.outlook.com (52.132.141.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Thu, 11 Oct 2018 20:33:31 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 20:33:31 +0000
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
Subject: [PATCH v3 08/11] arch/x86: Bring few more functions into the resource
 structure
Thread-Topic: [PATCH v3 08/11] arch/x86: Bring few more functions into the
 resource structure
Thread-Index: AQHUYaGsPeL1V3ojP0+Zpe4Ghnxe7g==
Date:   Thu, 11 Oct 2018 20:33:31 +0000
Message-ID: <20181011203223.18157-9-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2408;20:KLeyxtBFcbaVRUV480v51M8aJKS5GiDu0FPHifBLR1x0SDnX6omp+E1fUSplOGgHegjHTxUxwUOnwbkGmuJws7jhtdkV3buXl7Rfp9WgpB02775PT//3XHS8G3pZBEZKvvTbfZlmEEfUI7i1bRJWGcMrdlz3OCjtVU6EHUPJipLXeuZbqx+5uEQswjrCNFyDB2l9Yl2xmvs2i5z2HDGtv3+oy+UXGZqO4Fxrr7LBN56gbZHMxh8vE1xCvM0k4qve
x-ms-office365-filtering-correlation-id: c16f6b83-f4b0-4556-49e5-08d62fb8cefb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2408;
x-ms-traffictypediagnostic: DM5PR12MB2408:
x-microsoft-antispam-prvs: <DM5PR12MB2408A0AEA8FAC99008146F3195E10@DM5PR12MB2408.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:DM5PR12MB2408;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2408;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(25786009)(99286004)(52116002)(256004)(4326008)(54906003)(316002)(110136005)(68736007)(71200400001)(71190400001)(102836004)(36756003)(2900100001)(305945005)(66066001)(81166006)(106356001)(8676002)(7416002)(478600001)(14454004)(105586002)(8936002)(81156014)(6512007)(2501003)(5250100002)(11346002)(446003)(476003)(2616005)(97736004)(486006)(72206003)(6486002)(7736002)(53936002)(26005)(186003)(6436002)(2201001)(5660300001)(14444005)(86362001)(1076002)(386003)(575784001)(6506007)(3846002)(76176011)(2906002)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2408;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: STs86SsJbcGEld+UVCKqWOHZLgy2x5FULPNMTvGHLGkKc2QGq6tu6ql3OTkcRxCtll57Zz0OdhHi6eRN7zKBQUpuNI2Lrw4mp8BM3UGYlCSGg/c9oGZTXQQwQcNHTUS2fREV4yBP9jVKN3s97pgP6w8C4WZkCRsOqdRJFcPpSpsE+Wymosi2I0GIoahkYGVaaAHD+0EihBzyuWhFAxJVpNFzoRGJJlOi6q6zT0OIBpuX2m2u6xzZO+U6N7o4LnlyRnRjgbBzSs5iNRcb+Dx0qYs51v+UZ4j/HRX/Byps2UzvxV5LwmP2No376ZsawX6XmbAZO1t34Wh86GqHUggmO45G/tCIdl5r0HVX9lWK4i8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16f6b83-f4b0-4556-49e5-08d62fb8cefb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 20:33:31.7170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2408
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
 arch/x86/kernel/cpu/resctrl.c             | 10 +++++++++-
 arch/x86/kernel/cpu/resctrl.h             | 15 +++++++++++----
 arch/x86/kernel/cpu/resctrl_ctrlmondata.c |  4 ++--
 arch/x86/kernel/cpu/resctrl_monitor.c     | 10 +++++++---
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
index cff5564921c3..9eb5c102c300 100644
--- a/arch/x86/kernel/cpu/resctrl.c
+++ b/arch/x86/kernel/cpu/resctrl.c
@@ -872,10 +872,18 @@ static __init void rdt_init_res_defs_intel(void)
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
diff --git a/arch/x86/kernel/cpu/resctrl.h b/arch/x86/kernel/cpu/resctrl.h
index 8731b7c91c28..825d5571539e 100644
--- a/arch/x86/kernel/cpu/resctrl.h
+++ b/arch/x86/kernel/cpu/resctrl.h
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
 #endif /* _ASM_X86_RESCTRL_H */
diff --git a/arch/x86/kernel/cpu/resctrl_ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl_ctrlmondata.c
index 1da343b69f6e..867da06223b5 100644
--- a/arch/x86/kernel/cpu/resctrl_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl_ctrlmondata.c
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
diff --git a/arch/x86/kernel/cpu/resctrl_monitor.c b/arch/x86/kernel/cpu/re=
sctrl_monitor.c
index ad0107bc16a0..3c189e8624b9 100644
--- a/arch/x86/kernel/cpu/resctrl_monitor.c
+++ b/arch/x86/kernel/cpu/resctrl_monitor.c
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

