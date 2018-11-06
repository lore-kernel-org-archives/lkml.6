Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9059DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F2520869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c0jSQD5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F2520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbeKGBHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:07:45 -0500
Received: from mail-eopbgr810075.outbound.protection.outlook.com ([40.107.81.75]:22460
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389083AbeKGBHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSBiRHWECyoxJfzTRZD+7PccMX8FDciLWMmAGx5rNSI=;
 b=c0jSQD5vcF3HnzD3Ks8vwlE06OZQTtW9RJruZRutmIBjyWP63d/E9YImbCYkWSErTiyuX1fY5efPtBYE5XeITeben3bT1EpzhQRFq3tO7av4HXU9Lqk4OfOT7nDNpUvM7ZrJ1HnLJZGvq8SMxnCNZWeoGzZPV4uaPIgdeSjOh88=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1801.namprd12.prod.outlook.com (10.175.91.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 15:41:22 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 15:41:22 +0000
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
Subject: [PATCH v6 11/14] arch/x86: Add AMD feature bit X86_FEATURE_MBA in
 cpuid bits array
Thread-Topic: [PATCH v6 11/14] arch/x86: Add AMD feature bit X86_FEATURE_MBA
 in cpuid bits array
Thread-Index: AQHUdecq3QUa4GzIN0iDENh8g8615w==
Date:   Tue, 6 Nov 2018 15:41:21 +0000
Message-ID: <20181106154034.15386-12-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1801;20:/+D1y6tmwpGlvrXsTY9AT8CoHfx2yTiAxQCVq7S3S3+ZSgl/jznz5v6XBQsT7kYiTBt0q1w1TmrvZzQJVP8zGllcP00+KYtwfas1oNurNF0TFKL9O4XkiUqOTMYzGe57aIFjB3ApWga/K/XK3DbLiIMc9w3wjeOHWu5HdE6waxPeX5uoikgwvyDZJ1Q0fUDfikpv0ct7m0gHWlDyC8lU+msT+fVx/Rb4xm/pXXCOH+yQvZ9Kkm+TpH7RhIJ/DKZq
x-ms-office365-filtering-correlation-id: 393ae6aa-5f56-47ac-2f62-08d643fe4d3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1801;
x-ms-traffictypediagnostic: DM5PR12MB1801:
x-microsoft-antispam-prvs: <DM5PR12MB1801E2A1E2C6739F4926C5C795CB0@DM5PR12MB1801.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1801;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1801;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(476003)(6512007)(486006)(53936002)(2900100001)(76176011)(52116002)(26005)(186003)(102836004)(6506007)(446003)(11346002)(99286004)(4326008)(106356001)(386003)(105586002)(3846002)(6486002)(6116002)(1076002)(68736007)(66066001)(36756003)(14454004)(8676002)(81156014)(81166006)(2616005)(8936002)(7406005)(5660300001)(6436002)(316002)(2906002)(7416002)(305945005)(7736002)(54906003)(110136005)(25786009)(72206003)(86362001)(478600001)(71190400001)(2201001)(71200400001)(2501003)(97736004)(256004)(14444005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1801;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9wycv4/2TdiJ5Lqnlo4n5rz/CmGbrBtCxeqd1WxnhJ1y7mhOj+cG+8UqNFSBVIbGTx2VM9sUEVsJKBQ4gTN7R5nSvIobswufdeaZetzCRTEkwG2yy0/qZ5D+CVUgiqJZB7M2nDcoHHhnnfSERC3u32cJDHDE65U1BIuGPKNv3ximtZW00cLRrxw8k7e4PEwWzqVo74rHk5uygqvd89WS259l+P4NFx50eVGdjLZIB8kt/x0jSGK9mLKf0xKWHLzvG9Xe+pcPY2BKDnUopWsBNbb3Cxgtq1ORbFPRfDNGvl3M4tLVYlx1h3i+erHo5ICulw2F+8gdyJxbYQsYVOh7QCnCwkv8U1SZTzH5NrAdz7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393ae6aa-5f56-47ac-2f62-08d643fe4d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 15:41:21.9285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sherry Hurwitz <sherry.hurwitz@amd.com>

The feature bit X86_FEATURE_MBA is detected via CPUID leaf 0x80000008
EBX Bit 06. This bit indicates the support of AMD's MBA feature.

This feature is supported by both Intel and AMD. But they are detected
in different CPUID leaves.

Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/scattered.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c
index 772c219b6889..bd7853334b27 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -17,7 +17,11 @@ struct cpuid_bit {
 	u32 sub_leaf;
 };
=20
-/* Please keep the leaf sorted by cpuid_bit.level for faster search. */
+/*
+ * Please keep the leaf sorted by cpuid_bit.level for faster search.
+ * X86_FEATURE_MBA supported by both Intel and AMD. But the cpuid
+ * levels are different. Add a separate enty for each.
+ */
 static const struct cpuid_bit cpuid_bits[] =3D {
 	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
 	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
@@ -29,6 +33,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {
 	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
+	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SME,		CPUID_EAX,  0, 0x8000001f, 0 },
 	{ X86_FEATURE_SEV,		CPUID_EAX,  1, 0x8000001f, 0 },
 	{ 0, 0, 0, 0, 0 }
--=20
2.17.1

