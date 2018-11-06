Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6441FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A05920685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VO3Pb5h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A05920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbeKGBHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:07:05 -0500
Received: from mail-eopbgr820053.outbound.protection.outlook.com ([40.107.82.53]:42476
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388263AbeKGBHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtJ6MedT88NpL3SuUf3B1v2FeZ58lYz26a9RipfyyR8=;
 b=VO3Pb5h9kpnXkqGvXexJF8CCSoQ9g9Njv4OPmfhdZbxGioLUQNh8gbHSqHDg8IK3TKDm8ffc9cYiMC2Qlf+GZSCS6Ov8h1//xWeX5aA7xsaniFW8XrMZmCIxeqXp8vIHlv77LQtdH8USMxcljH27rda3nDSI3CmZDNGtYULPXm4=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1562.namprd12.prod.outlook.com (10.172.38.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Tue, 6 Nov 2018 15:41:15 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 15:41:15 +0000
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
Subject: [PATCH v6 08/14] arch/x86: Bring cbm_validate function into the
 resource structure
Thread-Topic: [PATCH v6 08/14] arch/x86: Bring cbm_validate function into the
 resource structure
Thread-Index: AQHUdecmKdX29nXpHUuxquLWyRojKA==
Date:   Tue, 6 Nov 2018 15:41:15 +0000
Message-ID: <20181106154034.15386-9-babu.moger@amd.com>
References: <20181106154034.15386-1-babu.moger@amd.com>
In-Reply-To: <20181106154034.15386-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0010.namprd04.prod.outlook.com
 (2603:10b6:803:21::20) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1562;20:fcyRfUT+yAcLsPE1fctSGmsUdofaUSMTnu2M6T6nUByiXLO48a/rvo6pFOCOyFtqj7H9QRJyt8Bw6B57jVnnVQTsHxFP0mZUbHIHtfRK3UrZoAL/lM9rCwyF7GzzRv5A16c1V5PWieBPVNb+ZxLoTMGiDDW/kzP1B/dfBkCSgDMH9bf48SEhvzVWyRF3wpqOqdu1hbt0bAd/2y43EHFOH3d7Dk0DXGYo6qF9igsTx8r/lweh9j7TyV1vZ0n1T8uv
x-ms-office365-filtering-correlation-id: e2c68132-a238-4544-2de3-08d643fe4941
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1562;
x-ms-traffictypediagnostic: DM5PR12MB1562:
x-microsoft-antispam-prvs: <DM5PR12MB1562B39C7FDF7B6D3641FAAD95CB0@DM5PR12MB1562.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1562;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1562;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(99286004)(54906003)(110136005)(2616005)(186003)(386003)(476003)(26005)(486006)(11346002)(6506007)(102836004)(316002)(3846002)(1076002)(71190400001)(71200400001)(6116002)(36756003)(6486002)(52116002)(76176011)(446003)(2906002)(81156014)(105586002)(575784001)(106356001)(86362001)(2201001)(305945005)(7736002)(8676002)(72206003)(6512007)(8936002)(14444005)(53936002)(2900100001)(68736007)(478600001)(66066001)(6436002)(256004)(81166006)(14454004)(25786009)(97736004)(7406005)(7416002)(5660300001)(2501003)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1562;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xjLjt+glk+2TK4FoNpYOZehwniu8+BB1qoO/nZHzo5PDX5mg16dBNnfFJFAllirF0ESVzdbOcfgT12E4rxcYJzTLdOUjkpJOy+qcV2vX7tjBDjvAHavo7HTmjwBM7kdDezQT27I0vBKGRgFcmEmASWevzT1ugqTQexKjEPTfFfxFfzWRIgrPwgCS2phsVJ/Q133h1JvP5Z7+9Pj/fXlnO1FRmwxbJjd408YvsVPAoz3rgQXDUFlJxrFbwcofa7QkDhNITA2q/0at6rE6ivHgq22lehVvaMIVsXceOa2oOoKhZsmzS+BS3OBSFJjKC/wVq5HgIhBoBxsKbHTy6/CWjB3bF+4qS+jugDr40Y8GNfU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c68132-a238-4544-2de3-08d643fe4941
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 15:41:15.2838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1562
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
 arch/x86/kernel/cpu/resctrl.c             |  9 ++++++++-
 arch/x86/kernel/cpu/resctrl.h             | 11 +++++++----
 arch/x86/kernel/cpu/resctrl_ctrlmondata.c |  4 ++--
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
index 3f77d5fcb2dc..7e4bea3bba98 100644
--- a/arch/x86/kernel/cpu/resctrl.c
+++ b/arch/x86/kernel/cpu/resctrl.c
@@ -879,7 +879,14 @@ static __init void rdt_init_res_defs_intel(void)
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
 			r->msr_base =3D IA32_MBA_THRTL_BASE;
 			r->msr_update =3D mba_wrmsr_intel;
 			r->parse_ctrlval =3D parse_bw_intel;
diff --git a/arch/x86/kernel/cpu/resctrl.h b/arch/x86/kernel/cpu/resctrl.h
index 8731b7c91c28..102bcffbefd7 100644
--- a/arch/x86/kernel/cpu/resctrl.h
+++ b/arch/x86/kernel/cpu/resctrl.h
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
 #endif /* _ASM_X86_RESCTRL_H */
diff --git a/arch/x86/kernel/cpu/resctrl_ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl_ctrlmondata.c
index 78089ae8683c..71aa1d971430 100644
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
--=20
2.17.1

