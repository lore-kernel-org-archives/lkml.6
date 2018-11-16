Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7FDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FBC2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pz7Dq0k/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FBC2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbeKQHJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:09:11 -0500
Received: from mail-eopbgr680051.outbound.protection.outlook.com ([40.107.68.51]:9744
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725824AbeKQHJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXagI1L++l0psjyDFttQU8Hm7t2K0n0JmeLF0op/EuQ=;
 b=pz7Dq0k/3+0O3fYbwE+Juixaui4GEM3Pd6cDwmwS7ghIPDgCVbCSF/LfEjBh2MJd3eyzt7blIiZfb9KDAqttorq4EWqjjuibB2/SzXTk8EtYxCSZk89O+xM/kIWfQ0fAodkgfKIqzaXzateL/Jw6nTgIppThPbHhFEOXMJgemn0=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1788.namprd12.prod.outlook.com (10.175.91.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Fri, 16 Nov 2018 20:54:26 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 20:54:26 +0000
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
Subject: [PATCH v8 03/13] arch/resctrl: Re-arrange RDT init code
Thread-Topic: [PATCH v8 03/13] arch/resctrl: Re-arrange RDT init code
Thread-Index: AQHUfe6PY68KWCX7TUy3HUgk7ikpIA==
Date:   Fri, 16 Nov 2018 20:54:26 +0000
Message-ID: <20181116205407.10457-4-babu.moger@amd.com>
References: <20181116205407.10457-1-babu.moger@amd.com>
In-Reply-To: <20181116205407.10457-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:805:f2::18) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1788;20:QhFQ9c6C9+yC3D06JDMjEHXEZlr1eTMxZnwxgTZ8yJb7ielT91iWheH4fXYyhqggPQBl9NLcHsl1PbbkoaALP1xrmROefpJZQBzBoevvXrxydgXWgbgDyir9n1Cxx3AL1DYqq4z2oHf3HbH2CiBk4fgGKNBrGDywpJ7UexuEcFEE5biiB74MONGfXzHnTg4KRYL1dJnRJ0RF8GDMCdEK9EJUjkzyly30TU+uSkCIZDzDPCCMdKn9N4HUKGNtqOZL
x-ms-office365-filtering-correlation-id: 566922dc-9305-4c3e-4117-08d64c05b209
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1788;
x-ms-traffictypediagnostic: DM5PR12MB1788:
x-microsoft-antispam-prvs: <DM5PR12MB1788243AFADF62833EA566E295DD0@DM5PR12MB1788.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231415)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1788;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1788;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(366004)(376002)(199004)(189003)(6486002)(7406005)(478600001)(316002)(7416002)(7736002)(53936002)(25786009)(3846002)(97736004)(6116002)(68736007)(6512007)(54906003)(14454004)(110136005)(71190400001)(6436002)(2201001)(106356001)(1076002)(4326008)(72206003)(105586002)(71200400001)(66066001)(36756003)(305945005)(256004)(5660300001)(86362001)(81156014)(6506007)(52116002)(2906002)(11346002)(476003)(2616005)(486006)(76176011)(102836004)(26005)(386003)(99286004)(8676002)(186003)(2501003)(2900100001)(446003)(8936002)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1788;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: muhgCIdAwCqc8j+/UwCOJBuurz86SbLwYZojwIjWIwudZdhokUMHgRNG8AeettF4AC09OIrvKyMUb/Is7CzhAhx3TXgYY3JAMS6D+oOUUgSPlTJCUXwOOPDxiAz55LQMzhuogd6H8CE0uHcF5rSIljxmQDqoXBaC+Ao9k3RzfEK2AZnqQDjfMo0AXn/v0josszdEFdu/COL69+jt1uND2Y96ylps5bgvduYMKwqC7rKelAn3wF+QQ91/WolOxvlmtoPMcAiOt3ymdg75fxyHUHC1muGetbdnQso+1JGcPP8Uic9kTDOz1X3GGAt+KzbCemELWsND9KSp7l0J45gQ9LiuR2hhuZPJEWEYkHtjrCk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566922dc-9305-4c3e-4117-08d64c05b209
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 20:54:26.7223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the call sequence for rdt_quirks and MBA feature.
This is in preparation to handle vendor differences in these
call sequences.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
index 5d526dc45751..4cea275c7c57 100644
--- a/arch/x86/kernel/cpu/resctrl.c
+++ b/arch/x86/kernel/cpu/resctrl.c
@@ -794,6 +794,14 @@ static bool __init rdt_cpu_has(int flag)
 	return ret;
 }
=20
+static __init bool rdt_mba_config(void)
+{
+	if (rdt_cpu_has(X86_FEATURE_MBA))
+		return rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
+
+	return false;
+}
+
 static __init bool get_rdt_alloc_resources(void)
 {
 	bool ret =3D false;
@@ -818,10 +826,9 @@ static __init bool get_rdt_alloc_resources(void)
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
@@ -840,7 +847,7 @@ static __init bool get_rdt_mon_resources(void)
 	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
 }
=20
-static __init void rdt_quirks(void)
+static __init void rdt_quirks_intel(void)
 {
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_HASWELL_X:
@@ -855,9 +862,14 @@ static __init void rdt_quirks(void)
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
@@ -871,6 +883,9 @@ static int __init resctrl_late_init(void)
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

