Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3093ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821632145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D0u1e+Uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821632145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbeIYBW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:22:58 -0400
Received: from mail-eopbgr710056.outbound.protection.outlook.com ([40.107.71.56]:63200
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732727AbeIYBW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXh20Uk03cnG3hWbjRafqBYh3ubligTHcVsr7IZCzWA=;
 b=D0u1e+Uoio8XBhyz83X4aWFjsGKNIzPD4Vxeaiy8UeQnmAO747C+A25VOylc+YX8RIMfx+/RLdcP8QQAczi6+BYW0sbTJhmZ8HrvLkRZIM3lU2hyytrdpRbmBspNz05j610m92sTtssdZ3yFGKUDTsBSJG+Bswfnp48Vp5HDpek=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2455.namprd12.prod.outlook.com (52.132.141.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 19:19:14 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de%5]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 19:19:14 +0000
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
Subject: [RFC PATCH 08/10] arch/x86: Introduce new config parameter AMD_QOS
Thread-Topic: [RFC PATCH 08/10] arch/x86: Introduce new config parameter
 AMD_QOS
Thread-Index: AQHUVDt5WR+pClx/YUCFssz1al6x+Q==
Date:   Mon, 24 Sep 2018 19:19:11 +0000
Message-ID: <20180924191841.29111-9-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2455;20:muGi4tAJtzqi49tJU/pEF0g4ea0TML/1iXwmOzmNiLg96Mp3+HkaU0CUnwzpXGk7e+T4VdWFL/P9/AJiPCgKG5YSShbUbsLaLvYrdZYiCooRt+aYUpWcnxAG0D9l81ets073aIWroZIYgzSsN4smOF3PxzmY0/npo2PWog0zhUHeCnAmy77jGb4TQpzfN61cFpAS+gjzAzUew6v39TL/AS5eqdG0qayDTydilakvbsdFBLFdP2ru+4yKRXuWqUle
x-ms-office365-filtering-correlation-id: 44c126df-1fab-494b-0319-08d622529bbb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2455;
x-ms-traffictypediagnostic: DM5PR12MB2455:
x-microsoft-antispam-prvs: <DM5PR12MB245538FA8371D371BA7B1D1A95170@DM5PR12MB2455.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB2455;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2455;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(97736004)(217873002)(256004)(14444005)(2501003)(5250100002)(316002)(2900100001)(52116002)(7736002)(68736007)(305945005)(5660300001)(6666003)(1076002)(76176011)(386003)(66066001)(6506007)(478600001)(72206003)(25786009)(7416002)(14454004)(4326008)(6436002)(106356001)(8936002)(8676002)(81156014)(81166006)(6512007)(36756003)(53936002)(26005)(2906002)(3846002)(6116002)(6486002)(54906003)(86362001)(110136005)(102836004)(186003)(2201001)(486006)(71200400001)(446003)(476003)(11346002)(99286004)(2616005)(71190400001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2455;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xSB/14RaL0HPYbNNM45mydR9qdhq4cV8gAuGl8Gk20c4ehKdOA8o3ptuBefrhMLQLqnlXzh/KGLLVriZWyv/HuRXJph//rrqDYVpVEhO0nE3QaJAqLKTN/9S6ZvDKzDE5hl+IaKj70S88NQIZjv8NPk+ji5UqsAtBNm+bf0WLsN7XgjPev1PMP/XhBrTSsFzF4/xvMT0JBG0Ge7zLkyfs9eqILQLwFXi9NzOcpnOnpeE3DJIrocF4ACbUcjb0/k36irzN5/247AVBQ7GBXLPcBa6sa+uFT/yNSTZiSWPcnTJwgB0IaQU/tJ2xiHaoDXuZXLo98MB9BMOFGbHTTPNYDmzevyy4SBM06Rp4+vib4w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c126df-1fab-494b-0319-08d622529bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 19:19:11.9384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
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

