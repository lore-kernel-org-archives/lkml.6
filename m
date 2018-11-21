Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A737C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01847214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b8SbxH/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01847214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbeKVHEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:04:47 -0500
Received: from mail-eopbgr680065.outbound.protection.outlook.com ([40.107.68.65]:32544
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387434AbeKVHEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUBVFugSU70KiKB6AIPYggQbteBXZS/cYsIpp5Vd0/Q=;
 b=b8SbxH/HQllCoRzMc7TD00oCd/EDY//RPUZfgPfOW2XcsPHr8Tpec7MPqYksh/w5OVy97FrXJStpX5ewXtNMfG9YumutAPEwXQFYJmJLYb6b9s8FlI35s76M1yhBVqybS1uO3u8h8guNIwkeXjwUwqvt9BtaH4iuY5OhKTxJx5M=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1418.namprd12.prod.outlook.com (10.168.238.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 21 Nov 2018 20:28:47 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 20:28:47 +0000
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
Subject: [PATCH v9 12/13] Documentation: Rename and update intel_rdt_ui.txt to
 resctrl_ui.txt
Thread-Topic: [PATCH v9 12/13] Documentation: Rename and update
 intel_rdt_ui.txt to resctrl_ui.txt
Thread-Index: AQHUgdjOHVsZNGPDEkqNOUfX+Nq52g==
Date:   Wed, 21 Nov 2018 20:28:47 +0000
Message-ID: <20181121202811.4492-13-babu.moger@amd.com>
References: <20181121202811.4492-1-babu.moger@amd.com>
In-Reply-To: <20181121202811.4492-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0084.prod.exchangelabs.com (2603:10b6:800::52) To
 DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1418;20:5wvV45gaREluIoH+YG5z6Qj1LWeVo3xNpHozgOP9TqWm2cWx3ehN3+Y0Zw9oJO0HDEGtapg70cS8bXjYh4wzT4h2610VPnzkXo+478YxpAq7WuUKtLKB9hgMA1uIVIOOaz62k9yYP4RwRXGfhfpKa6w4T7A7A+5cO4PynUtPdjGwtPMZNh1W6A9wP0LMIx3ttQ+lf6M72wykYaDzjy+qBcNDZbzjE0ZZBXOukCHyTAgVRnvV/U1ec8vfoTsaNBUT
x-ms-office365-filtering-correlation-id: 235b52ab-69a2-4191-df5a-08d64feff0cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1418;
x-ms-traffictypediagnostic: DM5PR12MB1418:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB1418907CBB4A3C311526CB1F95DA0@DM5PR12MB1418.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1418;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1418;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(478600001)(316002)(8936002)(1076002)(8676002)(81166006)(81156014)(54906003)(110136005)(5660300001)(71190400001)(71200400001)(99286004)(6116002)(3846002)(76176011)(6486002)(97736004)(6436002)(2906002)(2900100001)(6512007)(52116002)(36756003)(105586002)(14454004)(446003)(6506007)(72206003)(4326008)(486006)(66066001)(476003)(106356001)(2501003)(2201001)(102836004)(15650500001)(7736002)(14444005)(256004)(386003)(305945005)(11346002)(86362001)(7416002)(26005)(25786009)(53936002)(186003)(2616005)(68736007)(7406005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1418;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ris3dJJ7Wrf3EFi03kr+gpBd3JQ5AykOmPTb/tB/Ueb7ABlbw+eq4SlUXX6RC8XSr/FHqmEGewQ44JnqEyl5UBETbNK5qX5+SkyGbkJG7uXeNPMy08RTbOyFz1GXApqEwJ+4M7Tzm7TTYOdu4jDM5+QhJK1Dq7/B90DL85BTpi+1X6V8B3gdzX5mQDLh9Bb2EivX9ym/G3LW9BEPJQIPulQxufyX4UjtHL/qlmRdzucfQ4jPtRraTwZ/1w2fglXKp4Z+4TsmsfNRc671TWnFj18VC9HsZROyflwhdHr4+7i/ePPocvKzZKX+nnQWXcW2HtOBjeW+Yc2Vv5ncJ1ysZrkTyhn/paDD5hTve+hVAr8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235b52ab-69a2-4191-df5a-08d64feff0cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 20:28:47.7049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
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
index 52b10945ff75..d9aed8303984 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/resctrl_ui.txt
@@ -1,4 +1,7 @@
-User Interface for Resource Allocation in Intel Resource Director Technolo=
gy
+User Interface for Resource Control feature
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
+This feature is enabled by the CONFIG_RESCTRL and the X86 /proc/cpuinfo
+flag bits:
 RDT (Resource Director Technology) Allocation - "rdt_a"
 CAT (Cache Allocation Technology) - "cat_l3", "cat_l2"
 CDP (Code and Data Prioritization ) - "cdp_l3", "cdp_l2"
--=20
2.17.1

