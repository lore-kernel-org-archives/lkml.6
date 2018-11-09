Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8C7C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9D220827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xr7+Wf+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9D220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbeKJGgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:36:02 -0500
Received: from mail-eopbgr740074.outbound.protection.outlook.com ([40.107.74.74]:39808
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbeKJGex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h/QaNXKt4Rs6dEBRTJFXKljvcXqaM8ZpxyzXRq+7ms=;
 b=xr7+Wf+Ktm65o9BGGDoh8C4txqksvp/SSXPoG/7DpvUf6TXWHhiDJ3jqZV0sCJYnSLHnQRosJ+nDBWwBO+mC2IdAJGmlbimUTSFcpDF6GLBJpHr2aqmfg2uP/VMwBgd75nhs7Fz6BDPCxUz5Z+YtqlBHmkkfNJEtThlvRXs5GRs=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1675.namprd12.prod.outlook.com (10.172.40.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Fri, 9 Nov 2018 20:52:29 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 20:52:29 +0000
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
Subject: [PATCH v7 03/13] arch/x86: Re-arrange RDT init code
Thread-Topic: [PATCH v7 03/13] arch/x86: Re-arrange RDT init code
Thread-Index: AQHUeG4gtVeqAbYB7UCtAL3NUjVDAg==
Date:   Fri, 9 Nov 2018 20:52:29 +0000
Message-ID: <20181109205153.14811-4-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1675;20:GW0Wg7ZsTtt1s9V9jjEEdiAU5iiM1rXHYv01sIiPNtOi8YvF6EjBKeSHcV3mRzlH046sS/+9VNS+R4cX0P1snqfKXchBaW+Ga2EZGnSklLzgVygCe257sdvLPuLBK0LT78gXsmXOsXuvgjZeUawEjQiRVObl3bQnssv+3ylW8iaKRYw7rmLS+Cca8s2HdmhPaTgH7mj2gCslaazNPiMrGRSeGVA7kBzLbAhFSoX+MVD6hNXamgGAu5dfkWobV6Bc
x-ms-office365-filtering-correlation-id: 6d7c0c81-cf14-46ea-fa71-08d646854307
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1675;
x-ms-traffictypediagnostic: DM5PR12MB1675:
x-microsoft-antispam-prvs: <DM5PR12MB16757DB16F0FC95C4346317695C60@DM5PR12MB1675.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1675;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1675;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(305945005)(4326008)(14454004)(6116002)(66066001)(72206003)(36756003)(105586002)(6486002)(3846002)(6436002)(102836004)(386003)(6506007)(6512007)(478600001)(99286004)(2906002)(5660300001)(25786009)(86362001)(2900100001)(68736007)(2501003)(2201001)(26005)(11346002)(7406005)(81156014)(446003)(81166006)(486006)(476003)(2616005)(186003)(1076002)(52116002)(53936002)(8936002)(7736002)(106356001)(256004)(110136005)(71200400001)(76176011)(71190400001)(8676002)(54906003)(316002)(7416002)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1675;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WDNe9SMlOGnOMFFCo1lvwZ+88FP0p4ggTysNzxc12eRqgmCvVe8Dt5xqPyOJA4aPgVbqw9ztk8yoxazcO8nGE5/DL+7JqZn/gBLGZVCRYe08X5ITfBpU/WpFTN0wffszGxEQMzGrvZnnoL7L0xIvv6oWYgNnPv92gF4cZYq4MoI3aLpRi9MHqtGIFpEV8wRc4hgLsnntzJry/+ocUp6KRfz1yZp26R+lxxvOd+1Hk+XFGypU7YGvmJ49TusRzSXBzjgVXkTE8tfOj4nYNOQ/tp0Apg0/AVTxCCtn4Za7BSkp7kdDcjIGLVMrpACqv8V6Tm7Is79szdJOTNFbIaHoQdbaNZSaG7ZJAZ4pUloOjDk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7c0c81-cf14-46ea-fa71-08d646854307
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 20:52:29.0316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
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

