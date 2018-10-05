Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C12D21477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nWb4RX8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C12D21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbeJFD4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:56:40 -0400
Received: from mail-eopbgr720088.outbound.protection.outlook.com ([40.107.72.88]:35778
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729478AbeJFD4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPRh9xPR4XTKcScbE9D/C0Y0f3TeV2y9WDQlReWCNK8=;
 b=nWb4RX8TFG4KXerVEiExjFk5SmOoZYYoOJcdEFeDZpJcuEm4yeXk43p6sdzNiOmlcxh73YFfSaf4fT1yzke8PsKJSMsdh+p6FMS8JQwkWxZgV0ukUA/gnhxUYLa+6IXpQrkrY0Wb13gYQrY/bGRAnZRTHteNA/Jcy14GTpn2fEQ=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1386.namprd12.prod.outlook.com (10.168.238.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Fri, 5 Oct 2018 20:56:09 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 20:56:09 +0000
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
Subject: [PATCH v2 10/11] arch/x86: Add AMD feature bit X86_FEATURE_MBA in
 cpuid bits array
Thread-Topic: [PATCH v2 10/11] arch/x86: Add AMD feature bit X86_FEATURE_MBA
 in cpuid bits array
Thread-Index: AQHUXO3XVg8FNh2kP0quKwJeL3SsAg==
Date:   Fri, 5 Oct 2018 20:56:09 +0000
Message-ID: <20181005205512.29545-11-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1386;20:jrcB0B/WfX1Yv5PvaB2DXCTGuEZyLLmqd+kboIc1y61BAL40ZfTZ/ztB6eoLSTA9Dh+zv53o9qF2lJGb469gJNamblrimzDKWPFGnv0lKm/hJCjaYSiMvrL4EaRs7sJ5dIU2OuNfLvbzGa+UUX0PIhKv3Ks8BP9mIofFkwAKeuLiqog+3VORjB034ngeKrX5bNiOzJGsBrNbKcGllzIDrVJFTjd0QQavcuoHMtgI4vF3rv5BUBYaiNAq8Lb1A0mU
x-ms-office365-filtering-correlation-id: bfc58b52-7844-48bf-0182-08d62b04f9e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1386;
x-ms-traffictypediagnostic: DM5PR12MB1386:
x-microsoft-antispam-prvs: <DM5PR12MB1386BDB612B28509B804A9C795EB0@DM5PR12MB1386.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302102)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR12MB1386;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1386;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(186003)(99286004)(86362001)(5660300001)(66066001)(476003)(305945005)(106356001)(316002)(5250100002)(6506007)(52116002)(97736004)(76176011)(486006)(7736002)(105586002)(386003)(102836004)(2501003)(26005)(81166006)(6486002)(4326008)(110136005)(81156014)(2906002)(6436002)(54906003)(71200400001)(6512007)(478600001)(72206003)(53936002)(8936002)(68736007)(71190400001)(11346002)(446003)(14444005)(2616005)(6116002)(2900100001)(36756003)(256004)(1076002)(2201001)(25786009)(3846002)(7416002)(8676002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1386;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wHKKYm6E1CsGgFeKYTOQOu7VlmCtnwjTJPidD+o2iauM0QeETYuEqjh9prytv27h4+Ol7aO5infAEDYGIcfHiYBSLCwHFSrMVi5J7DIUEL7T9mvfzxxpYUCjywxiLcY0+HlgzsMb/AcG8tuR1xfdRudJgy5LabJzi7QEI2f/EKK1N3NOVjOsoO0Vo30FhZCkivKd7L8BIs4aPlAzR81iVm4ttl/pveNNmYhaumFxxtaCoFNJsrKXkMSp+txGXC8ppGoQC5PP1OV9EiuPF9EgCR1bm0qf6zN0qaocXiQC2ZtrYteX2v3i7GuqJtZCWzqaEligfJW7tgsBUbeOULD93RYSEZ1b1Wjy14bo5FXEkI8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc58b52-7844-48bf-0182-08d62b04f9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 20:56:09.6146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1386
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sherry Hurwitz <sherry.hurwitz@amd.com>

The feature bit X86_FEATURE_MBA is detected via CPUID leaf 0x80000008
EBX Bit 06. This bit indicates the support of AMD's MBA feature.

This feature is supported by both Intel and AMD. But they are detected
different CPUID leaves.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>
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

