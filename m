Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C46C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94F52086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a/JWaP+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94F52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbeKGBHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:07:17 -0500
Received: from mail-eopbgr820083.outbound.protection.outlook.com ([40.107.82.83]:61067
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389070AbeKGBHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdzIAZgKSNVcKS9L33kNjUd1qfNWFrfxg5hZNEMs8bI=;
 b=a/JWaP+PNWKIZKj76sbGjXk7wf8338YceiHOty+O5VR2gqHA/zKkAu0jVZJg68BPO9uxiIwGTlgt2NwsFw0Od8yx29y6m6jmc01OltvpHvNUp2/4dkU2W/6BoKt3Low6p6+qCHhIHQfCjulHfYdFX+ieyzfa0L1W2VY/ZL6Zxx4=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1562.namprd12.prod.outlook.com (10.172.38.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Tue, 6 Nov 2018 15:41:26 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 15:41:26 +0000
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
Subject: [PATCH v6 13/14] Documentation/x86: Rename and update
 intel_rdt_ui.txt
Thread-Topic: [PATCH v6 13/14] Documentation/x86: Rename and update
 intel_rdt_ui.txt
Thread-Index: AQHUdectZ4UKh59MskOOj3g4CGTUhw==
Date:   Tue, 6 Nov 2018 15:41:26 +0000
Message-ID: <20181106154034.15386-14-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1562;20:4hCIiLeWFRAytvNSJeSE5qpQG625yXJoS28JIuwWsgkz/Mql/MEsxNcAmoEyvSTR0+nyNn6E928z8LJRZIGauWvGVq3+Y1HEOg7Uz5dWx0BKlMNyzB9MG/OyBJqL6T4+LzjB34FvtbAhmcoRLplYRPXyNvF3ZVG2fyNxwxFxvM4cVgzuMzq6i+05qi/Qrg40zz+j74Ih5YWTX9Xz0g1p2TXTvX5CdkZ4qIPjJNrTOo6JPiOKFM3MiV2ujOIvqLFU
x-ms-office365-filtering-correlation-id: 779fa042-2ce0-4ef6-d8f8-08d643fe4fe2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1562;
x-ms-traffictypediagnostic: DM5PR12MB1562:
x-microsoft-antispam-prvs: <DM5PR12MB1562180E62F20B1B53CD4D9B95CB0@DM5PR12MB1562.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1562;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1562;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(99286004)(54906003)(110136005)(2616005)(186003)(386003)(476003)(26005)(486006)(11346002)(6506007)(102836004)(316002)(3846002)(1076002)(71190400001)(71200400001)(6116002)(36756003)(6486002)(52116002)(76176011)(446003)(2906002)(81156014)(105586002)(106356001)(86362001)(2201001)(305945005)(7736002)(8676002)(72206003)(6512007)(8936002)(14444005)(53936002)(2900100001)(68736007)(478600001)(66066001)(6436002)(256004)(81166006)(14454004)(25786009)(97736004)(15650500001)(7406005)(7416002)(5660300001)(2501003)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1562;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KA6bm510cmRPUfJ2TZJQGVM1QrsnFn/KckC+x6jKjUN1+UfX1BBrXMfwBzRo50bfk+++VoN6YyCoGXDpcJOiYv6rUTHb5QCvJ+BN20wfEeD7cYtvKRYFuF12d1MIoB2ZCeUu9d86qsN1TKvW8U9e6t+q2EOLiVyAyhoHTyZae4jvZxJV5ThPScnCsZXnR42DMRyWIG3rCXocbDhMQzhnCNe+uRF0vWa00JOuQSEqw4kDquOR6nPgjN6NRstMCAtvUJbI1PdkHHXXPOhaOuYS9+6DL7Z4Hnz0x2smCU08psAuJbsd/KZ8KlYz/R9niNY2umA0MW28KleDI3uGmxQnjKF8j6eJmHXSaxVhsz9C7qQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779fa042-2ce0-4ef6-d8f8-08d643fe4fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 15:41:26.4657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1562
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename intel_rdt_ui.txt to generic resctrl_ui.txt and update the
documentation for AMD.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/x86/{intel_rdt_ui.txt =3D> resctrl_ui.txt} | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
 rename Documentation/x86/{intel_rdt_ui.txt =3D> resctrl_ui.txt} (99%)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/resctrl=
_ui.txt
similarity index 99%
rename from Documentation/x86/intel_rdt_ui.txt
rename to Documentation/x86/resctrl_ui.txt
index 52b10945ff75..c4e2349482b8 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/resctrl_ui.txt
@@ -1,4 +1,7 @@
-User Interface for Resource Allocation in Intel Resource Director Technolo=
gy
+User Interface for RESCTRL feature
+
+Intel refers to this feature as Intel Resource Director Technology(Intel(R=
) RDT).
+AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
=20
 Copyright (C) 2016 Intel Corporation
=20
@@ -6,8 +9,8 @@ Fenghua Yu <fenghua.yu@intel.com>
 Tony Luck <tony.luck@intel.com>
 Vikas Shivappa <vikas.shivappa@intel.com>
=20
-This feature is enabled by the CONFIG_INTEL_RDT Kconfig and the
-X86 /proc/cpuinfo flag bits:
+This feature is enabled by the CONFIG_INTEL_RDT Kconfig(for Intel) or
+CONFIG_AMD_QOS(for AMD) and the X86 /proc/cpuinfo flag bits:
 RDT (Resource Director Technology) Allocation - "rdt_a"
 CAT (Cache Allocation Technology) - "cat_l3", "cat_l2"
 CDP (Code and Data Prioritization ) - "cdp_l3", "cdp_l2"
--=20
2.17.1

