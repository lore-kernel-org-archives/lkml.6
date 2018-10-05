Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C2FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC9421473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ljj/QPia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC9421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbeJFD4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:56:48 -0400
Received: from mail-eopbgr720042.outbound.protection.outlook.com ([40.107.72.42]:58409
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728367AbeJFD4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXh20Uk03cnG3hWbjRafqBYh3ubligTHcVsr7IZCzWA=;
 b=Ljj/QPiamL1snuRPO5jSRr8hy0/ng571TeIcmn7vSSszV8K5EqDFAPYAh9C3w598ApBn/9sAXFDGmQnCwSTx2NMbgCbktG1OTnYnemJ3sWHa8AM8f6ZwValtQVShG0vDqdCJrkaiBBNrvT/x8sBZugO3TqPm12dQ96qXmg4/Ebc=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2504.namprd12.prod.outlook.com (52.132.141.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Fri, 5 Oct 2018 20:56:06 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 20:56:06 +0000
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
Subject: [PATCH v2 09/11] arch/x86: Introduce new config parameter AMD_QOS
Thread-Topic: [PATCH v2 09/11] arch/x86: Introduce new config parameter
 AMD_QOS
Thread-Index: AQHUXO3VfSqeFnz9REGv/ZtKx28M2Q==
Date:   Fri, 5 Oct 2018 20:56:06 +0000
Message-ID: <20181005205512.29545-10-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2504;20:unYICXx71z2apem2jezKKqs1idu+03n7ChmKB6as4y+gcv6JWGZCgGRuCbu9JuopRRExRZ50IBpCgQkZYJYJKBXeb4jZ7vjUpQ555/+Z/lOAE+2rMUUMmxmApFiK4lkkzt+jF6nqsbhfk/ohi6W6aBliidjQjHBScn8kdM3ACHdIsS+rQFjQy8ZI8STgHyV03AKDj4OppOK79GYrhnJvtbE5vSAgLHfp8YcNNNeD7xSe0amuoDssFQ6JM1mcZ2H0
x-ms-office365-filtering-correlation-id: 84565deb-bba6-441e-dd50-08d62b04f7d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2504;
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-microsoft-antispam-prvs: <DM5PR12MB25048DC17FDA950DC99CBE1695EB0@DM5PR12MB2504.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302102)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:DM5PR12MB2504;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2504;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(110136005)(2201001)(256004)(36756003)(72206003)(102836004)(54906003)(14444005)(6512007)(305945005)(52116002)(25786009)(14454004)(53936002)(386003)(8936002)(478600001)(68736007)(105586002)(6506007)(66066001)(99286004)(86362001)(106356001)(2900100001)(7416002)(4326008)(476003)(486006)(8676002)(6116002)(76176011)(3846002)(7736002)(71190400001)(71200400001)(316002)(2906002)(186003)(11346002)(2501003)(81156014)(81166006)(446003)(5660300001)(5250100002)(6486002)(6436002)(2616005)(97736004)(26005)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2504;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GiFFFeh9/0hNWNEKjS8g34YskmtYYbiyyU/fgcF7HKfLXvE7t3DzipjKlpMVm6KBgRPRZD7LTeSKJhOdf29ASax6L8B/ywt+/GRJHshDbO2/OgieoLo44E84wdUYnvDi8y1UA/BXf8xrkbLbY2vNY3lpvkGRgpLFt1ElJUzyiHsRCRU3WL/XUz4XVgYYQOhhhxdp4oKeu4zHTBtSUtWsFH33tltPmWDaIyfM9ag+aiJQnaC5Fz+9Z4LSpAEf3I/6gR1gzBpdYFl/r4a8pRKWAv3ZmH61/AU08JfwoyuBjb3v6B3rmeJdn9+X24Y0lz/5HkFkt+0+Ift2NhmwW2O/mqYqRsTPoObXtcvmkTbHAmk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84565deb-bba6-441e-dd50-08d62b04f7d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 20:56:06.2552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces the new config parameter AMD_QOS. This parameter will be
used to enable cache and memory bandwidth allocation and monitoring
features on AMD processors. This will enable common config parameter
PLATFORM_QOS if selected.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/Kconfig | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7f2da780a327..0bfb5f4f32f2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -458,9 +458,24 @@ config INTEL_RDT
=20
 	  Say N if unsure.
=20
+config AMD_QOS
+	bool "AMD Quality of Service support"
+	default n
+	depends on X86 && CPU_SUP_AMD
+	select KERNFS
+	help
+	  Select to enable cache and memory bandwidth enforcement and monitoring
+	  features of AMD processors. These features are intended to provide
+	  support for the monitoring of the usage of certain system resources
+	  by one or more processors and for the separate allocation and
+	  enforcement of limits on the use of certain system resources by one or
+	  more processors.
+
+	  Say N if unsure.
+
 config PLATFORM_QOS
 	def_bool y
-	depends on X86 && INTEL_RDT
+	depends on X86 && (INTEL_RDT || AMD_QOS)
=20
 if X86_32
 config X86_BIGSMP
--=20
2.17.1

