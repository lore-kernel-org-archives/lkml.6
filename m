Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04E1C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA78821479
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Zb+NqMZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA78821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJPEmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:42:46 -0400
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:26912
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbeJPEmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uOGDE15PHf+R68VyVOm2mqpYcMIEgDHaqFDQJ69Tp8=;
 b=Zb+NqMZz9wY5uTRztTXxjGhSgEERC72N69F8TVO1Eaf1UODxoiL5/YJTtNf7a3U4iUFfgN2WyTGsFFatt1tr9kasTKpwvRBlMTHrtCMSr0MEVcHnUPPit9SZr+r0i9PEAMM4p39/XFedyyZSQCAw0n9w3xo9UQcNvKIxSzigzVg=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2534.namprd12.prod.outlook.com (52.132.141.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 20:55:37 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 20:55:36 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: [PATCH v4 03/13] arch/x86: Re-arrange RDT init code
Thread-Topic: [PATCH v4 03/13] arch/x86: Re-arrange RDT init code
Thread-Index: AQHUZMlsSnBgKj3nV0S34pKMPPJ4Ww==
Date:   Mon, 15 Oct 2018 20:55:36 +0000
Message-ID: <20181015205514.25387-4-babu.moger@amd.com>
References: <20181015205514.25387-1-babu.moger@amd.com>
In-Reply-To: <20181015205514.25387-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:805:a2::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2534;20:G+z60/+E8jc0RaXn84PhUuVMRQRd/tyumMW3fsUxKJVQmgbz7Gv/ZrQVpeDeWTgvxxXr7B1QrkIySxZdkMOnKvj5dz2wcDNiFlaxOs8yI9YCqWd/Iee/e62IXTT7nahSPf2JO7Ef33HtI48cFx/ytmcr9oRPn9PqWQllbjnuuCLL9uv6n/lkoAQdyxtdvdSLu6NWH1j5YKMWLD5SYyO/Hmi3hkKz7/LgwO4wjBV6wXF0QLQyQXYYK/WcJCEO5NB1
x-ms-office365-filtering-correlation-id: 4625cbc6-48a5-4e59-e71a-08d632e08e7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2534;
x-ms-traffictypediagnostic: DM5PR12MB2534:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB2534F738093012FBF5FADEC195FD0@DM5PR12MB2534.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:DM5PR12MB2534;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2534;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(376002)(136003)(199004)(189003)(478600001)(6116002)(486006)(256004)(25786009)(476003)(81166006)(81156014)(316002)(14454004)(8676002)(8936002)(71190400001)(71200400001)(2201001)(3846002)(575784001)(86362001)(97736004)(52116002)(7416002)(76176011)(7406005)(386003)(6436002)(6506007)(6486002)(68736007)(5250100002)(66066001)(2900100001)(110136005)(186003)(54906003)(26005)(36756003)(305945005)(6512007)(446003)(5660300001)(4326008)(11346002)(1076002)(72206003)(105586002)(2616005)(99286004)(102836004)(106356001)(7736002)(2501003)(2906002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2534;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yliMS2Hh4WdbdVTANomJKZkrwHH7lp4Qosq6dN4LI6vULO6Bo6Fir/Nn/7WXjoAX+RuFo5VGo/RVWw4q3t0E+nbBeUSPW4QL31gd2HXJntglLP9d+tZJ5yK0etPbBBd1d4EIZ+HsavT2HujixrDJUdZTMhLzbDhGL16i7l2cMxiQ2uyAcO3dxERTPzsbppewh1CKw3NqZ9kCwwzDToUmTBrnAar4qQxropunIXcwnHeCLFy64MZg+xbuHLVzO4k9K+srxDXmHzwZVHlH0ENJ1b/YaEYNH7AlEKjfmymfXMjNQC6wT676GLGJNWEJsaR6NJWWC1BqfkjFRrodFdGtL1aJB0PmcGUJDdtrTePKvB8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4625cbc6-48a5-4e59-e71a-08d632e08e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 20:55:36.8400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
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
index 8afc0da6fa59..6c1199f7f28e 100644
--- a/arch/x86/kernel/cpu/resctrl.c
+++ b/arch/x86/kernel/cpu/resctrl.c
@@ -787,6 +787,16 @@ static bool __init rdt_cpu_has(int flag)
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
@@ -811,10 +821,9 @@ static __init bool get_rdt_alloc_resources(void)
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
@@ -833,7 +842,7 @@ static __init bool get_rdt_mon_resources(void)
 	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
 }
=20
-static __init void rdt_quirks(void)
+static __init void rdt_quirks_intel(void)
 {
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_HASWELL_X:
@@ -848,9 +857,14 @@ static __init void rdt_quirks(void)
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
@@ -864,6 +878,9 @@ static int __init resctrl_late_init(void)
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

