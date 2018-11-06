Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8329C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767A920685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="059OSgG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767A920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389062AbeKGBHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:07:06 -0500
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:34136
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388819AbeKGBHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h/QaNXKt4Rs6dEBRTJFXKljvcXqaM8ZpxyzXRq+7ms=;
 b=059OSgG/m8jCeyh+r2V+tXvYUWoZ2CdQss87wSb9ZuichKBThHDluLK0jD1m8gocoeouqhV2DfgZXksIPt7vOjQYSLo0ai89ukv+rHmE/q8Z3MOj62FsHKOAI6UUcwJMnwcoZlRkxpRv0lURDFp4pTdwTkg4vVi4AwlvGribbb8=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1354.namprd12.prod.outlook.com (10.168.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 15:41:03 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 15:41:03 +0000
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
Subject: [PATCH v6 03/14] arch/x86: Re-arrange RDT init code
Thread-Topic: [PATCH v6 03/14] arch/x86: Re-arrange RDT init code
Thread-Index: AQHUdecgxUi/yNG/+0yyn4TAC3gE+g==
Date:   Tue, 6 Nov 2018 15:41:03 +0000
Message-ID: <20181106154034.15386-4-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1354;20:IHWE8IsvwIq+MJUQztHg4ezkhlcyC/Htm5n9x6vIaxkBsDCnVU872ZZsdwm9TxGSWsu+6t1XK8vM+GaIXUXHNfn52xgbvGChyY3gLZKBSetjImYNZAKISk23ADIP7TPo82EVd9d55zw9CPVpVVDcCrVYjCT9Pk15IsbGl2BSNTvQsGdXro0x1V3mFU5dVUcm2jgO0JV/ciyYm/p0XzX9SBaICsMUDLwu+g7Uxl4rYqAXjUlZbJgDt9LhpCfTrP1V
x-ms-office365-filtering-correlation-id: a78e4323-a9f5-4c7a-db9a-08d643fe4252
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1354;
x-ms-traffictypediagnostic: DM5PR12MB1354:
x-microsoft-antispam-prvs: <DM5PR12MB13549B589C638819B165AF8D95CB0@DM5PR12MB1354.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1354;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1354;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(189003)(199004)(2906002)(54906003)(76176011)(5660300001)(3846002)(6116002)(1076002)(53936002)(478600001)(25786009)(36756003)(110136005)(7406005)(7416002)(14454004)(66066001)(4326008)(6486002)(2900100001)(68736007)(305945005)(7736002)(6512007)(2201001)(6506007)(86362001)(26005)(102836004)(99286004)(97736004)(486006)(2501003)(386003)(11346002)(256004)(81166006)(81156014)(6436002)(316002)(72206003)(8936002)(8676002)(52116002)(71190400001)(186003)(2616005)(476003)(446003)(106356001)(71200400001)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1354;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5dAhs5BuYxoEwhcvxqXYNsTLgiHITa5cRY9YHzY3ftiKD4IbufvkEALxUzUeBc5+tRrF2RGP9oJhCTMG4EYohsPLQwkKUa77kPhdU+icI+TbaUO1VHRYS33eqT+vY4Vq26bu9Ozdjm8RV0gZ6AJY8nyl86LoTT3RHTTJBMZ9p81ozZeGV0YaxvJzgWeXltIbaA1IWtOmTeN7mGqpi+bduKsqd2GVrEscp5uFhcqc+L5/ztxzHycvwpoK3wKSDolaEZBnmOAT4Mb5S/PUumfGTyuPEvegoW3VaRZUwOrvYR947HL3mYJyAmQClT2qNmNtCY6Op3wNHIDuR3DTplA3oXsMAT4bYYUCxTbEb2kBpPo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78e4323-a9f5-4c7a-db9a-08d643fe4252
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 15:41:03.6196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the call sequence for rdt_quirks and MBA feature.
This is in preparation to handle vendor differences in these
call sequences.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
index 5d526dc45751..fd5320dddddc 100644
--- a/arch/x86/kernel/cpu/resctrl.c
+++ b/arch/x86/kernel/cpu/resctrl.c
@@ -794,6 +794,16 @@ static bool __init rdt_cpu_has(int flag)
 	return ret;
 }
=20
+static __init bool rdt_mba_config(void)
+{
+	if (rdt_cpu_has(X86_FEATURE_MBA)) {
+		if (rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]))
+			return true;
+	}
+
+	return false;
+}
+
 static __init bool get_rdt_alloc_resources(void)
 {
 	bool ret =3D false;
@@ -818,10 +828,9 @@ static __init bool get_rdt_alloc_resources(void)
 		ret =3D true;
 	}
=20
-	if (rdt_cpu_has(X86_FEATURE_MBA)) {
-		if (rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]))
-			ret =3D true;
-	}
+	if (rdt_mba_config())
+		ret =3D true;
+
 	return ret;
 }
=20
@@ -840,7 +849,7 @@ static __init bool get_rdt_mon_resources(void)
 	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
 }
=20
-static __init void rdt_quirks(void)
+static __init void rdt_quirks_intel(void)
 {
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_HASWELL_X:
@@ -855,9 +864,14 @@ static __init void rdt_quirks(void)
 	}
 }
=20
+static __init void rdt_quirks(void)
+{
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+		rdt_quirks_intel();
+}
+
 static __init bool get_rdt_resources(void)
 {
-	rdt_quirks();
 	rdt_alloc_capable =3D get_rdt_alloc_resources();
 	rdt_mon_capable =3D get_rdt_mon_resources();
=20
@@ -871,6 +885,9 @@ static int __init resctrl_late_init(void)
 	struct rdt_resource *r;
 	int state, ret;
=20
+	/* Run quirks first */
+	rdt_quirks();
+
 	if (!get_rdt_resources())
 		return -ENODEV;
=20
--=20
2.17.1

