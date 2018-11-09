Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA79C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C12720840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HmhFmY1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C12720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeKJGe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:34:58 -0500
Received: from mail-co1nam03on0073.outbound.protection.outlook.com ([104.47.40.73]:18016
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728434AbeKJGe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtJ6MedT88NpL3SuUf3B1v2FeZ58lYz26a9RipfyyR8=;
 b=HmhFmY1m1VJ4tJ8WongeA4TPTJFwffB830w+kbYM/+WShXe4K75ujrbmRyRBgjYTsagVx2XvNEZVP1oZM9nY+fF/EvCtHtmKXIJghPMDuyAzPsJDKFQ7KHA4iQRZIuiaiXnAQ2ZZ7zYLjEjkyhp3gTQHRgFMhQCnEzve5Dm+754=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2552.namprd12.prod.outlook.com (52.132.141.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 20:52:37 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 20:52:37 +0000
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
Subject: [PATCH v7 07/13] arch/x86: Bring cbm_validate function into the
 resource structure
Thread-Topic: [PATCH v7 07/13] arch/x86: Bring cbm_validate function into the
 resource structure
Thread-Index: AQHUeG4lDDRQ+zyXlUOykxB7fiv6+g==
Date:   Fri, 9 Nov 2018 20:52:37 +0000
Message-ID: <20181109205153.14811-8-babu.moger@amd.com>
References: <20181109205153.14811-1-babu.moger@amd.com>
In-Reply-To: <20181109205153.14811-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0005.namprd07.prod.outlook.com
 (2603:10b6:803:28::15) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2552;20:1hUajfBzLDP0yFZik6jumhsN3H6JzIT/TJrodpmDs3AyxQr/HoknLSxWmsbSUUByBN75weSKa+Sneqds1kevGULTfWWdjrepsBfqnbtaSli2yHv1g4eiQKnytIjEUBxlbM+l4i6iFXGMOhZ1QJTwJYwFhhIrMiUdE+lVpzliTYEwCsjeDJX7nwFRzoMjZkMbBD57Pd6xrrxPtqNAHxtiA4vJnMqh/C0yNu504pZjy+re1f6ds0LwKVJNsI1lqvDr
x-ms-office365-filtering-correlation-id: e29f82c2-130f-4837-d6b0-08d6468547d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2552;
x-ms-traffictypediagnostic: DM5PR12MB2552:
x-microsoft-antispam-prvs: <DM5PR12MB25525A33DA457B463AFFC4D895C60@DM5PR12MB2552.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB2552;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2552;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(53936002)(478600001)(66066001)(26005)(71190400001)(6486002)(76176011)(2900100001)(102836004)(6506007)(386003)(71200400001)(52116002)(446003)(476003)(11346002)(2616005)(2906002)(99286004)(8676002)(186003)(6512007)(81166006)(81156014)(106356001)(105586002)(486006)(316002)(54906003)(110136005)(36756003)(2201001)(5660300001)(1076002)(6116002)(3846002)(14444005)(256004)(7416002)(25786009)(305945005)(7736002)(8936002)(6436002)(97736004)(68736007)(72206003)(14454004)(7406005)(86362001)(575784001)(4326008)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2552;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CEBTsGs79zs95N099rpKSBPeESmQXpTpez6A5Y/FHAURbz60DJ5vcoOksulJjWggvZf23HtivayxZZbIqEuyQGALnIu4Ep73MiC/DfYcKEKsrJuyBHbL6uN+YFZD+AOKmqUwJbz66C4Ub1PUctjyo091r+4eka0X9U+LIb/zbsjZEznChjVvKdZZuMZtyK5PIBljRUAlXUA6l+W2dl2VsdwBLS0AseMm8ij5zmrB2mjNJYvZFa2k+pOM4EqNZmI03dM6vEFd0rrnOqD28PWBT21EOluuCMp7MGY+aZ/w1219psPLjbiDD5L3dg7ZuK9FalABOsvm5V9pziDrTLZAvXSDTlp4ntYUXNkyK5wuu9I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29f82c2-130f-4837-d6b0-08d6468547d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 20:52:37.1723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2552
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

