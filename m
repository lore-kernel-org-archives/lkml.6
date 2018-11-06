Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419F8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDF320869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cx/sS/6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDF320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389115AbeKGBHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:07:11 -0500
Received: from mail-eopbgr810075.outbound.protection.outlook.com ([40.107.81.75]:22460
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389070AbeKGBHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66HO1TwWcIjKI7QCwONxIcZ6WfojcBLi3L4cjKOE+jo=;
 b=Cx/sS/6fZbYmcYs9UlTyOKYe6BiqoB0OzV5hbmRKVwaRI8rzZGpDPNJeesLEdN3FKLqrndlAjHpi9dcTRNpz7JRJ5JOizkkXWD2nuae5p4LhQLxBE+xVD/SBqNFTKf3US0RwuLI3y7Z4WWaEeFbvRGx1CoI2zA0ko5udIMGjmyw=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1801.namprd12.prod.outlook.com (10.175.91.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 15:41:19 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 15:41:19 +0000
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
Subject: [PATCH v6 10/14] arch/x86: Introduce new config parameter AMD_QOS
Thread-Topic: [PATCH v6 10/14] arch/x86: Introduce new config parameter
 AMD_QOS
Thread-Index: AQHUdecpVy/Q+WrjJ067QFLpn9FgHw==
Date:   Tue, 6 Nov 2018 15:41:19 +0000
Message-ID: <20181106154034.15386-11-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1801;20:uJAUf0NyzwfddA7GxofibP3x6Ve2fYQ5HbjOlM8zwb3Q/CGji29RhFyiwMXVP3wwhgUN0Rv4BnSjSVeGLgC0OwPzr0mi4J/bt2A6gMX150g4IZBzvNXiQFNUbO76IsOjDhYFKg317zwcw9bbMeqpBvRzymka4q1iCUixh5LLs9JwAXtJkWBu/l3l+Dmi84PJ8Nfo59um4lrqbB6OyHa4N+bA32IdfgsuuezZAuJME0igmvttKAypCVbMs/rYYB5i
x-ms-office365-filtering-correlation-id: 43bdea50-1561-4dfc-c20d-08d643fe4be7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1801;
x-ms-traffictypediagnostic: DM5PR12MB1801:
x-microsoft-antispam-prvs: <DM5PR12MB18016237A92F88D88C7955AA95CB0@DM5PR12MB1801.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1801;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1801;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(476003)(6512007)(486006)(53936002)(2900100001)(76176011)(52116002)(26005)(186003)(102836004)(6506007)(446003)(11346002)(99286004)(4326008)(106356001)(386003)(105586002)(3846002)(6486002)(6116002)(1076002)(68736007)(66066001)(36756003)(14454004)(8676002)(81156014)(81166006)(2616005)(8936002)(7406005)(5660300001)(6436002)(316002)(2906002)(7416002)(305945005)(7736002)(54906003)(110136005)(25786009)(72206003)(86362001)(478600001)(71190400001)(2201001)(71200400001)(2501003)(97736004)(256004)(14444005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1801;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: I5ztsEjqM5kRHBiyjBnFOmVBsZSSnbngLgqyXLuEzfxM30Usamosrebaui+PHh+mKzTIJ8fkCeuQCDbSaFxo+3Qi8p6+qopY6hcduW4WNEQpZsxEVCKuMAOun8c9IppxvbXzmGroy4VHPK66nXfBJhnBskjfWhCB994ztBY+mfldE0SbH8/kC1gGwp44koycBTr+7QUrNjp0D3wLBliP2iQcoVhbTLNHCy6y3OSjmdLxQMHKK0o855V7vUjbMu2OozRnEk8svCzr1C1Ct7/wJ+2UhRfQA8j5aBxHNp6GRlTvNmdMgysVvSEXKOPkQnpJWUlupj3XP5/mPeDAqwayMh5HHIntQKvioontgNYzVTw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bdea50-1561-4dfc-c20d-08d643fe4be7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 15:41:19.7180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces the new config parameter AMD_QOS. This parameter will be
used to enable cache and memory bandwidth allocation and monitoring
features on AMD processors. This will enable common config parameter
RESCTRL if selected.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/Kconfig | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 91a703ebdc04..9cd21e536b65 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -458,9 +458,24 @@ config INTEL_RDT
=20
 	  Say N if unsure.
=20
+config AMD_QOS
+	bool "AMD Quality of Service support"
+	default n
+	depends on CPU_SUP_AMD
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
 config RESCTRL
 	def_bool y
-	depends on X86 && INTEL_RDT
+	depends on X86 && (INTEL_RDT || AMD_QOS)
=20
 if X86_32
 config X86_BIGSMP
--=20
2.17.1

