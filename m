Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA56AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7789D214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1Oh691tl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7789D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbeKVHFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:05:19 -0500
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:5747
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732914AbeKVHFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNRQpp9VoYdQS9iB+rj1+rmUMRiUA0yV6ifxRDDEyFk=;
 b=1Oh691tlCG+/C/kI0/BONtvtzFMqqdf7jejazLT0yD2XirE9mVVXgIdCVd+Q6nxXlDMCutD0EKa47jvC5fX2/EjoWDoZEzEFbfvtPDsvYtEnUDsavL+yo/7G4iGuHNt5A6RAZBlopC55pbfoEp10vEXzoJRLmpgRXLQCmg7kco4=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1610.namprd12.prod.outlook.com (10.172.40.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 20:28:35 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 20:28:35 +0000
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
Subject: [PATCH v9 06/13] x86/resctrl: Bring cbm_validate function into the
 resource structure
Thread-Topic: [PATCH v9 06/13] x86/resctrl: Bring cbm_validate function into
 the resource structure
Thread-Index: AQHUgdjHteND27eTzk+uRR9zyiZuwA==
Date:   Wed, 21 Nov 2018 20:28:35 +0000
Message-ID: <20181121202811.4492-7-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1610;20:wdbNDSvJ046+G2k0sjj73koHf5t+xoUI7oJNabMAdlcDqUJOqz1hjjjfrmpRcU1qTSRusISUnEXZfkzMJ3259hqcSNN6ch+s3mPo/i9KrrGTHxaLG058ZJIlYW3AyR8f3LCmFsN03pyj70rBpVV7f6yd1IKnhOZ+CTL2/9ZmY8u01H73qbQIl7T/vCymdFdGeVYyKbCqs2g5/O6C6SV9Mdix45a+eQe3zjQyjLfi0q+Kj7oxOYh87XSaTScY8owc
x-ms-office365-filtering-correlation-id: ac2e6b5c-27f0-4f94-9395-08d64fefe9a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1610;
x-ms-traffictypediagnostic: DM5PR12MB1610:
x-microsoft-antispam-prvs: <DM5PR12MB161057F3A4EC717D100C88C795DA0@DM5PR12MB1610.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231442)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1610;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(54906003)(76176011)(52116002)(256004)(71200400001)(71190400001)(5660300001)(6436002)(36756003)(68736007)(6486002)(99286004)(486006)(7416002)(26005)(2201001)(575784001)(66066001)(14444005)(7406005)(102836004)(6506007)(186003)(386003)(476003)(7736002)(6512007)(3846002)(2501003)(6116002)(478600001)(2900100001)(8936002)(305945005)(11346002)(53936002)(14454004)(97736004)(81156014)(81166006)(316002)(2616005)(110136005)(105586002)(446003)(106356001)(86362001)(8676002)(1076002)(25786009)(72206003)(4326008)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1610;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b/ViSfka9oF2FpzaUcRvX4XlIfz0MqqY0d6UTQ5whhvNEMtakWX6pLRwhjN0JfuUYQPILUZjONdFe6v/gNH7DTNiToWAK8KHFM1CtFUzgwNZBC/rQcFhDhgUkMxuszbAZRoKoEhCpaW8tDGl1SX2r/wUys0+1tVldtJtw4IJ7ep1TFIIdSKrbt2Fu3kQ2KIs9PGSoOGa//nm4jiKlN+AB1Sy0tpLfIcEX7H4KtQuqZQPOs+2wTf0WNzZR5wQlD7oYNuLm3uC44ASgn2s/yoyYfaHXYweukB3SIHsN8KhxXck5TWnakBaFx2tQ9rilVV5Vxtz1TVqW/lHDfaD2iZtcfHyCK3tM3yKJWNuGDk3msc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2e6b5c-27f0-4f94-9395-08d64fefe9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 20:28:35.7361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Idea is to bring all the functions that are different between the
vendors into resource structure and initialize them dynamically.
Add _intel suffix to Intel specific functions.

Following function is implemented separately for each vendors.
cbm_validate  : Cache bitmask validate function. AMD allows
                non-contiguous masks. So, use separate functions for
                Intel and AMD.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 ++--
 arch/x86/kernel/cpu/resctrl/internal.h    | 11 +++++++----
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c
index 3bd245b057c4..ba5a5b8c4681 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -878,7 +878,14 @@ static __init void rdt_init_res_defs_intel(void)
 	struct rdt_resource *r;
=20
 	for_each_rdt_resource(r) {
-		if (r->rid =3D=3D RDT_RESOURCE_MBA) {
+		if (r->rid =3D=3D RDT_RESOURCE_L3 ||
+		    r->rid =3D=3D RDT_RESOURCE_L3DATA ||
+		    r->rid =3D=3D RDT_RESOURCE_L3CODE ||
+		    r->rid =3D=3D RDT_RESOURCE_L2 ||
+		    r->rid =3D=3D RDT_RESOURCE_L2DATA ||
+		    r->rid =3D=3D RDT_RESOURCE_L2CODE)
+			r->cbm_validate =3D cbm_validate_intel;
+		else if (r->rid =3D=3D RDT_RESOURCE_MBA) {
 			r->msr_base =3D MSR_IA32_MBA_THRTL_BASE;
 			r->msr_update =3D mba_wrmsr_intel;
 			r->parse_ctrlval =3D parse_bw_intel;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl/ctrlmondata.c
index a8ae87e756e9..d2e0b99d453f 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
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
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h
index 7a7eeba55a1f..2fd4fd5d9da3 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -410,10 +410,11 @@ struct rdt_parse_data {
  * @cache:		Cache allocation related data
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
- * @evt_list:			List of monitoring events
- * @num_rmid:			Number of RMIDs available
- * @mon_scale:			cqm counter * mon_scale =3D occupancy in bytes
- * @fflags:			flags to choose base and info files
+ * @cbm_validate	Cache bitmask validate function
+ * @evt_list:		List of monitoring events
+ * @num_rmid:		Number of RMIDs available
+ * @mon_scale:		cqm counter * mon_scale =3D occupancy in bytes
+ * @fflags:		flags to choose base and info files
  */
 struct rdt_resource {
 	int			rid;
@@ -436,6 +437,7 @@ struct rdt_resource {
 	int (*parse_ctrlval)(struct rdt_parse_data *data,
 			     struct rdt_resource *r,
 			     struct rdt_domain *d);
+	bool (*cbm_validate)(char *buf, u32 *data, struct rdt_resource *r);
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
@@ -576,5 +578,6 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, un=
signed long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
+bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
=20
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
--=20
2.17.1

