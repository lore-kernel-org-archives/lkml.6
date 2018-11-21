Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052FCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C97214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OSy2op4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C97214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbeKVHEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:04:36 -0500
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:42050
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732914AbeKVHEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPMRQnus3G1e4diRCVbXX129TloKmMK8UNgNM/jg2RQ=;
 b=OSy2op4jUcBACI15J2QTK7dkPVNSMGFK3XzmQnmDGL1Mq18nqZXrFdvXqN6WJuDjyzl3i9fi4Ens4+T64gjSfjBGYrJdNDmzXhrLNA61XKw8bGVwLQnubux1LpcFKkofVumzhod5a9joQsYokf5FBNof01jKWO07MUxnSir3Vzs=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1610.namprd12.prod.outlook.com (10.172.40.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 20:28:30 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 20:28:30 +0000
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
Subject: [PATCH v9 03/13] x86/resctrl: Re-arrange RDT init code
Thread-Topic: [PATCH v9 03/13] x86/resctrl: Re-arrange RDT init code
Thread-Index: AQHUgdjD47ro2rGux0SF8Zx1RnjAnw==
Date:   Wed, 21 Nov 2018 20:28:29 +0000
Message-ID: <20181121202811.4492-4-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1610;20:5NsHsuqQ77vVuTef+inHMkO6vTTbUosQzSmIB/U1rW2WZgfDIrv9b+G6ryselMNlcrBfs5YbVYXrxvItIQ6in1s2aM2wU5Thsv0HqF5KkdV9kF8JuzXAtBXrkndXHwti4bHbxZFssGnw+lDkmost6eINIEqE/Uru5glnUjWv65AH+vB15OjPYUyVdwo0MeySjSsieqX58aO1bd6fIu2t7UBiv96iFNY/0y+1ceO+3almoUaHsJwkQLo+76s487f4
x-ms-office365-filtering-correlation-id: e185c51a-073a-417a-f73a-08d64fefe621
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1610;
x-ms-traffictypediagnostic: DM5PR12MB1610:
x-microsoft-antispam-prvs: <DM5PR12MB16103B2C3FF7D263A12632F395DA0@DM5PR12MB1610.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231442)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1610;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(54906003)(76176011)(52116002)(256004)(71200400001)(71190400001)(5660300001)(6436002)(36756003)(68736007)(6486002)(99286004)(486006)(7416002)(26005)(2201001)(575784001)(66066001)(7406005)(102836004)(6506007)(186003)(386003)(476003)(7736002)(6512007)(3846002)(2501003)(6116002)(478600001)(2900100001)(8936002)(305945005)(11346002)(53936002)(14454004)(97736004)(81156014)(81166006)(316002)(2616005)(110136005)(105586002)(446003)(106356001)(86362001)(8676002)(1076002)(25786009)(72206003)(4326008)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1610;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lw8o1Jx9PCf1hjk4uNGnrzefumx3IqZCaOqCV1OCO0vZboYNVJssnEhaOAX6gXq4LCtPsLIlm/A1IyX/xEWjzUWJqSzHYhvq4xoGvX/fd4PNte86W5HnRSxtMh2gBNFktxcQAYVdEmsVXdwv2lCMksDxpbekTZ73V7tgYonFkn2DkUpiqx04PXao6svnOYd4IEybLf/aeMwbkEGlo7CZhJaHtKMODKNOg/h+/vjeKrnJFenYIeEdCezT4dMIotEmFSH3vY4CWrfkneCnb/bZWYyyj1h0beLpkb3rZfiP2sE1jzmi6kN20zzEHjjcv+tknW3s5LFfkGiQp2siWn6P3NihskPZySa04K9C8uXeszg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e185c51a-073a-417a-f73a-08d64fefe621
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 20:28:29.7986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the call sequence for rdt_quirks and MBA feature.
This is in preparation to handle vendor differences in these
call sequences. Rename the functions to make it bit more
meaningful.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c
index 0cf890ae0de2..40380731c588 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -259,7 +259,7 @@ static inline bool rdt_get_mb_table(struct rdt_resource=
 *r)
 	return false;
 }
=20
-static bool rdt_get_mem_config(struct rdt_resource *r)
+static bool __get_mem_config(struct rdt_resource *r)
 {
 	union cpuid_0x10_3_eax eax;
 	union cpuid_0x10_x_edx edx;
@@ -794,6 +794,14 @@ static bool __init rdt_cpu_has(int flag)
 	return ret;
 }
=20
+static __init bool get_mem_config(void)
+{
+	if (rdt_cpu_has(X86_FEATURE_MBA))
+		return __get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
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
+	if (get_mem_config())
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
+static __init void __check_quirks_intel(void)
 {
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_HASWELL_X:
@@ -855,9 +862,14 @@ static __init void rdt_quirks(void)
 	}
 }
=20
+static __init void check_quirks(void)
+{
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+		__check_quirks_intel();
+}
+
 static __init bool get_rdt_resources(void)
 {
-	rdt_quirks();
 	rdt_alloc_capable =3D get_rdt_alloc_resources();
 	rdt_mon_capable =3D get_rdt_mon_resources();
=20
@@ -871,6 +883,8 @@ static int __init resctrl_late_init(void)
 	struct rdt_resource *r;
 	int state, ret;
=20
+	check_quirks();
+
 	if (!get_rdt_resources())
 		return -ENODEV;
=20
--=20
2.17.1

