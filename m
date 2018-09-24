Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973DFECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470E92098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wTz+XBzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470E92098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbeIYBWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:22:45 -0400
Received: from mail-bn3nam01on0048.outbound.protection.outlook.com ([104.47.33.48]:45925
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732289AbeIYBWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFeCzuXF6LRDgQuhPZKKtGwJx4jLxtEH9fm2mYJ9Aqg=;
 b=wTz+XBzTnXr7mawNOeP/J8YLxYcXK6BMiHL9k1LaAiNlnm1ZDWocvH2mTaj4IvqWr2WlYaxfdMsLs5gatD7HoZmjNH8e0ZQ0iSRyhfuCdwW8FgibDFV7gUE+Wry9+R9Q2K8FgxuKra1YfUe687l7MA2ZrD6teGvyA6lNKPKtLA8=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2455.namprd12.prod.outlook.com (52.132.141.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 19:19:00 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de%5]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 19:19:00 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
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
Subject: [RFC PATCH 03/10] arch/x86: Re-arrange RDT init code
Thread-Topic: [RFC PATCH 03/10] arch/x86: Re-arrange RDT init code
Thread-Index: AQHUVDtyokQlIS2+10uA6u2YvHhBgQ==
Date:   Mon, 24 Sep 2018 19:19:00 +0000
Message-ID: <20180924191841.29111-4-babu.moger@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
In-Reply-To: <20180924191841.29111-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:805:16::22) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2455;20:fLm9ojqme5s+SyCLqOoUujeKW/Nq4MCJyN7vM/LAJ+PEA2qn0pCN8ujIaxU4k2/R0k+ejOm6jWtyiZY+EQaNFRwQ2FPKO+kfF1as2BGaVVT9tWIkPNfJ+1geckdRsb7DCrAVM+VzTGAnI+4IHWmNUXcctWzn76T9ZMCCeL/4+zMn2mhcAc2dtNdrR3m3YTeP+yrHXkxfPWvfhxlNbuPc7fHS3GzkLbkg+jdDfgmcKzteyV7gSegMZPY7ag90SdrM
x-ms-office365-filtering-correlation-id: dd50e52b-70cc-4bb0-af69-08d6225294f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2455;
x-ms-traffictypediagnostic: DM5PR12MB2455:
x-microsoft-antispam-prvs: <DM5PR12MB2455ABF54AA30EC66A3ECF9C95170@DM5PR12MB2455.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB2455;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2455;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(97736004)(217873002)(256004)(14444005)(2501003)(5250100002)(316002)(2900100001)(52116002)(7736002)(68736007)(305945005)(5660300001)(1076002)(76176011)(386003)(66066001)(6506007)(478600001)(72206003)(25786009)(7416002)(14454004)(4326008)(6436002)(106356001)(8936002)(8676002)(81156014)(81166006)(6512007)(36756003)(53936002)(26005)(2906002)(3846002)(6116002)(6486002)(54906003)(86362001)(110136005)(102836004)(186003)(2201001)(486006)(71200400001)(446003)(476003)(11346002)(99286004)(2616005)(71190400001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2455;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XFYjmJ4or9usD6vOavyvZsCOxd+HH07urRaLTPiP3y07raUpXvU1aDJn7YHNk2dpL7Pr8CJqLki/fQWAmg5lkI4qymIzR4p24tAXJY5xa6RsXOHLQbBOvF24h9J/UitY1rWjURGFqqgGPZNI67BhCggGBDlc4LRGKDNcJvU/OXE0wK8OkQxqwMw6YaDXlndmzar+XtzwssPc4Ihm88LjnqjLf7pBwwcbzAZzgb5GkHBUJOSNbaqbWyQJq+PP+vMl53azryIuhABq5jBVAs28nNhLdrSc8nq2iDJsX3rG8FYikOeYfH6ttZ/T247iPtYzwdTlnvTQjl3Vjysofa+j1RTKdRqnCfa9eNljPSncjMU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd50e52b-70cc-4bb0-af69-08d6225294f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 19:19:00.5884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-organize the RDT init code. Separate the call sequence for each
feature. That way, it is easy to call quirks or features separately
for each vendor if there are differences.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/rdt.c | 44 ++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
index b361c63170d7..736715b81fd8 100644
--- a/arch/x86/kernel/cpu/rdt.c
+++ b/arch/x86/kernel/cpu/rdt.c
@@ -813,10 +813,6 @@ static __init bool get_rdt_alloc_resources(void)
 		ret =3D true;
 	}
=20
-	if (rdt_cpu_has(X86_FEATURE_MBA)) {
-		if (rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]))
-			ret =3D true;
-	}
 	return ret;
 }
=20
@@ -831,11 +827,12 @@ static __init bool get_rdt_mon_resources(void)
=20
 	if (!rdt_mon_features)
 		return false;
+	else
+		return true;
=20
-	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
 }
=20
-static __init void rdt_quirks(void)
+static __init void rdt_quirks_intel(void)
 {
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_HASWELL_X:
@@ -850,13 +847,22 @@ static __init void rdt_quirks(void)
 	}
 }
=20
-static __init bool get_rdt_resources(void)
+static __init void rdt_quirks(void)
 {
-	rdt_quirks();
-	rdt_alloc_capable =3D get_rdt_alloc_resources();
-	rdt_mon_capable =3D get_rdt_mon_resources();
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+		rdt_quirks_intel();
+}
+
+static __init void rdt_detect_l3_mon(void)
+{
+	if (rdt_mon_capable)
+		rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
+}
=20
-	return (rdt_mon_capable || rdt_alloc_capable);
+static __init void rdt_check_mba(void)
+{
+	if (rdt_cpu_has(X86_FEATURE_MBA))
+		rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
 }
=20
 static enum cpuhp_state rdt_online;
@@ -866,8 +872,22 @@ static int __init rdt_late_init(void)
 	struct rdt_resource *r;
 	int state, ret;
=20
-	if (!get_rdt_resources())
+	/* Run quirks first */
+	rdt_quirks();
+
+	rdt_alloc_capable =3D get_rdt_alloc_resources();
+	rdt_mon_capable =3D get_rdt_mon_resources();
+
+	if (!(rdt_alloc_capable || rdt_mon_capable)) {
+		pr_info("RDT allocation or monitoring not detected\n");
 		return -ENODEV;
+	}
+
+	/* Detect l3 monitoring resources */
+	rdt_detect_l3_mon();
+
+	/* Check for Memory Bandwidth Allocation */
+	rdt_check_mba();
=20
 	rdt_init_padding();
=20
--=20
2.17.1

