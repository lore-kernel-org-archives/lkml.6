Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50318C65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0666B2064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jiJVug1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0666B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbeJFD4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:56:25 -0400
Received: from mail-eopbgr720049.outbound.protection.outlook.com ([40.107.72.49]:19386
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729252AbeJFD4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGKAHN1QimIMAGpJdZQo/PhAhco+70lPm372Jq4pBdc=;
 b=jiJVug1EhbSfLPSQx+hKVrp50vwXzXBRgFTz2Fik5RLy0bcqkvg/INA5oL+Pa3hTfLFLzwHAGltECFPwS5q81lT0Z9sGE2l+wh5TgJIl66ImW99KuL8CxKjGgUlCF76H/fDinCQUiTU3Fc61NPYJ38WbXGddu6SyyMEo4SWNFFA=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1386.namprd12.prod.outlook.com (10.168.238.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Fri, 5 Oct 2018 20:55:46 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 20:55:45 +0000
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
Subject: [PATCH v2 03/11] arch/x86: Re-arrange RDT init code
Thread-Topic: [PATCH v2 03/11] arch/x86: Re-arrange RDT init code
Thread-Index: AQHUXO3JsNKmrSzmrEqtH7EINMS3OA==
Date:   Fri, 5 Oct 2018 20:55:45 +0000
Message-ID: <20181005205512.29545-4-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1386;20:+iKr9yWJu01y4f4eO+EzDUiCybfMqLqO+hzt5sT7kMkOt+YwKPEobeQayoI5jZwJyF/aGGFAk/GC0tXFqalKG5EdJIHpS4GSnB4qZamnwt2q/67cSxIfaodLrUB7iQrn8rSNv+dunVxVMH5pJ7/nl9O/Oh2SyqIwGSxIX8heZehO3UbXBygG0fOofGaMP+0aazofaGI5jeNbS57JVGu5hlXqLs+68XPCv6k8Bvu8Tb6XVZ0vzt1ynu57TATcngdZ
x-ms-office365-filtering-correlation-id: 7fcb6416-6a67-4f08-538d-08d62b04ebaa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1386;
x-ms-traffictypediagnostic: DM5PR12MB1386:
x-microsoft-antispam-prvs: <DM5PR12MB1386A88C3A9FD05F1CEDD32A95EB0@DM5PR12MB1386.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302102)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR12MB1386;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1386;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(186003)(99286004)(575784001)(86362001)(5660300001)(66066001)(476003)(305945005)(106356001)(316002)(5250100002)(6506007)(52116002)(97736004)(76176011)(486006)(7736002)(105586002)(386003)(102836004)(2501003)(26005)(81166006)(6486002)(4326008)(110136005)(81156014)(2906002)(6436002)(54906003)(71200400001)(6512007)(478600001)(72206003)(53936002)(8936002)(68736007)(71190400001)(11346002)(446003)(2616005)(6116002)(2900100001)(36756003)(256004)(1076002)(2201001)(25786009)(3846002)(7416002)(8676002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1386;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: prKJQG0/GtZOULUL8icOGE9A6O68MJGswRX2BQz0EtTHk3gujBouqRREAuFH91BTueYz7/gMA5XYLGt3lZRDt7rkOfqURPHH0mRa//TzLYlFDYF5DrAX+eVCwe3nwhrL9QZiZAjWCgXO2gN0kDoWKO5CZfIc8c0rROkKYQRpK4Y7YZaoHoSOMAzZzYhlS3z1XLvf/Z5YsI8McFzJeAqQfqoffK8eJY/hd4xo434CZMdkhec2U51e7Euk2SNr2ZSd7jO/NPL3uZAyt4gnZt7fSRkpX/ROAdMbzCrxlxV+fP1t6UqePjQzL1dgv+U3cFv60Wqk62bUwMMRYF28fLorEFgdyZZiwa6FmwcJZfwLNLw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcb6416-6a67-4f08-538d-08d62b04ebaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 20:55:45.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1386
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the call sequence for rdt_quirks and MBA feature.
This is in preparation to handle vendor differences in these
call sequences.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/rdt.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
index b361c63170d7..c3ac7f9a3a0f 100644
--- a/arch/x86/kernel/cpu/rdt.c
+++ b/arch/x86/kernel/cpu/rdt.c
@@ -789,6 +789,16 @@ static bool __init rdt_cpu_has(int flag)
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
@@ -813,10 +823,9 @@ static __init bool get_rdt_alloc_resources(void)
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
@@ -835,7 +844,7 @@ static __init bool get_rdt_mon_resources(void)
 	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
 }
=20
-static __init void rdt_quirks(void)
+static __init void rdt_quirks_intel(void)
 {
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_HASWELL_X:
@@ -850,9 +859,14 @@ static __init void rdt_quirks(void)
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
@@ -866,6 +880,9 @@ static int __init rdt_late_init(void)
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

