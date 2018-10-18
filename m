Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64402C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1152D204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MxuMpwts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1152D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJSGzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:55:53 -0400
Received: from mail-eopbgr730051.outbound.protection.outlook.com ([40.107.73.51]:56050
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726507AbeJSGzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdzIAZgKSNVcKS9L33kNjUd1qfNWFrfxg5hZNEMs8bI=;
 b=MxuMpwtsNyJcq7oE5/GE1n0q2HOv0gGV/NgDe5ylASz5HXkIa7YkTGgySyJLCz3enHGuOVm7FigEXsUpgLVPc347vF1oui5irLzYCB2VmJoWnjKwOXAfHnlSkQqZTwj+tveZ/asObdP9UN09a6snlyyCpajwpFITts8IfPetmSc=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1340.namprd12.prod.outlook.com (10.168.238.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Thu, 18 Oct 2018 22:52:30 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.028; Thu, 18 Oct 2018
 22:52:30 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v5 12/13] Documentation/x86: Rename and update
 intel_rdt_ui.txt
Thread-Topic: [PATCH v5 12/13] Documentation/x86: Rename and update
 intel_rdt_ui.txt
Thread-Index: AQHUZzU/XvCpw08LpkaDqYQDrUIlDQ==
Date:   Thu, 18 Oct 2018 22:52:29 +0000
Message-ID: <20181018225124.23043-13-babu.moger@amd.com>
References: <20181018225124.23043-1-babu.moger@amd.com>
In-Reply-To: <20181018225124.23043-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0044.namprd02.prod.outlook.com
 (2603:10b6:803:2e::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1340;20:w6ZiM3C3MY/IEGvC/Tf2xdc2yHpE9DTkNGSEfQIxUMfskHPCpc21YV6vuFnVAZxYAlK10E1i4uFfs+nZIxJkbkLw0JX/Zrmt3o204Qj6XMXqHrkZxJbNdX8z3jfgqqCm+eyT4s5egrXpTNYLothbZhNDdaYPQvGYZpnRlVn6B/1EabQo4KuEloJE9qKdu77geUKR5pdwpqsQjA/EwV9vVQH+v/aInPtaaP9R70JiWq+sRMaTYUtNcipc/V/m+bFq
x-ms-office365-filtering-correlation-id: 6128a40e-1370-46a4-8f7b-08d6354c61e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1340;
x-ms-traffictypediagnostic: DM5PR12MB1340:
x-microsoft-antispam-prvs: <DM5PR12MB1340717B381B5E1E60860CA095F80@DM5PR12MB1340.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1340;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1340;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(199004)(189003)(86362001)(54906003)(186003)(71200400001)(110136005)(102836004)(478600001)(26005)(106356001)(76176011)(52116002)(105586002)(72206003)(1076002)(66066001)(81156014)(71190400001)(8676002)(8936002)(14454004)(5660300001)(7416002)(7406005)(2906002)(68736007)(15650500001)(99286004)(6486002)(6506007)(386003)(6116002)(81166006)(2501003)(7736002)(6512007)(446003)(2201001)(53936002)(14444005)(25786009)(97736004)(5250100002)(256004)(6436002)(305945005)(11346002)(4326008)(3846002)(316002)(36756003)(476003)(486006)(2900100001)(2616005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1340;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CVLqEkPI2QHRwtljigOofHDKqpK0mtjC5mchqnRE/P71eHuidGnPoNyqyPujHkSWC1thu4ETAeuGUUIG7KP0pcsmoDMqPYLZrU+RUJduWBfexWX1+o3ekGkSvfGnL9VmQVDd4oc7IhBBTm/9HBbVX5UUSCPL9Qf2ZDh0Hil1HFay3oT1I3tVFjSIBQFPMCCm6/ngO2v4MUTiq5P6QhvKQDzRN24CEicrCOA/+kZE16qrIwW/g4/0xq5+uxm1uFLagPjIyaq5/jjm1/ARh5L32QmD/li4mcSaVrTbBMex3UdeypOES4ytSJelBCcO7T+Y1AXl03aV3bDvXS327ycVY5yklzMLajsP3wlGAVYHXf4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6128a40e-1370-46a4-8f7b-08d6354c61e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 22:52:29.9682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1340
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

