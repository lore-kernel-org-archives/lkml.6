Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA9C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3573F20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FT22uemb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3573F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeKJGfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:35:19 -0500
Received: from mail-co1nam03on0060.outbound.protection.outlook.com ([104.47.40.60]:51328
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728674AbeKJGfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUBVFugSU70KiKB6AIPYggQbteBXZS/cYsIpp5Vd0/Q=;
 b=FT22uemb91kP3MZfjINdZbE25irYL15jL9dQVgp22M3I0dpM5X9z8B/sDMo9ctjj7ysid+kWv3tdyp9SKyQmX50AiAsEjbDp5II5EhBXHG+at8j4jA9hu/9u2kjNJNbvV+D80JxnVxXe7JFK63PgPF/EtgwSiHXo0cZOlk+KOZE=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2552.namprd12.prod.outlook.com (52.132.141.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 20:52:47 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 20:52:47 +0000
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
Subject: [PATCH v7 12/13] Documentation/x86: Rename and update
 intel_rdt_ui.txt
Thread-Topic: [PATCH v7 12/13] Documentation/x86: Rename and update
 intel_rdt_ui.txt
Thread-Index: AQHUeG4rk5PYfE3BQEKRlM3Eow51vg==
Date:   Fri, 9 Nov 2018 20:52:47 +0000
Message-ID: <20181109205153.14811-13-babu.moger@amd.com>
References: <20181109205153.14811-1-babu.moger@amd.com>
In-Reply-To: <20181109205153.14811-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0005.namprd07.prod.outlook.com
 (2603:10b6:803:28::15) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2552;20:L0Q63lsoPx8gbyzzhkS/SzMAWhprzRk5osimQQbzZByxrNJx4nYBMdLjhpcbQ+MkRszdSB6xcvZF1kUdl+FkbUWoVS8bQ04GAAHEfzA/I3EI4OpsmEm3hdJQBLWkUSH92N0qckkFQFCajZ8x38SSnb6RD+TT4JpWOGsYlEGfH0+lCIap/TNTd2bZKLSGn7OfWuuPfZdO9ozehyfi58MVWrUgwKN6B5MCXe+GSv9qhj1QyJt5gyXe1ikLZXKKYmXm
x-ms-office365-filtering-correlation-id: 242e17c8-472f-4992-7e83-08d646854dd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2552;
x-ms-traffictypediagnostic: DM5PR12MB2552:
x-microsoft-antispam-prvs: <DM5PR12MB2552031925BD7A6D306FAB5395C60@DM5PR12MB2552.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB2552;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2552;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(53936002)(478600001)(66066001)(26005)(71190400001)(6486002)(76176011)(2900100001)(102836004)(6506007)(386003)(71200400001)(52116002)(446003)(476003)(11346002)(2616005)(2906002)(99286004)(8676002)(186003)(6512007)(81166006)(81156014)(106356001)(105586002)(486006)(316002)(54906003)(110136005)(36756003)(2201001)(5660300001)(1076002)(6116002)(3846002)(14444005)(256004)(7416002)(25786009)(305945005)(7736002)(8936002)(6436002)(97736004)(68736007)(72206003)(14454004)(7406005)(86362001)(4326008)(15650500001)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2552;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SihmjffnFGRlcpDtxs6w1ZBaZuvKErMRTuDaEBcJG4DX2EhvaJJtU8UdrLXdA7Es2X5O/Aa4hiQTOYr6xG6b+vDB0BJ/dEOjZFq5rQkNTmxnIoat/kG1gJxVpHrCUzqMEYAkcohl48VG6P7lhtfXI4G2c2PcjqO0h7dun6Hin0ZboSStGzGp8slLqmhajP5umqLDprFcGHwrLH+eUhjqssfUBH+vtMGG+7cx/8IZNhoaMeIu+RWyp4rj+hlx3hIhrUg/ovXEwa0CXRHaqK8qft7D/6sllrqp1WZQQugaGRnSEUPQWrp3VuYHi9WwZ9ZgBnBeKAFdXYsRekOAHB9BiQrxewhAXQIjMekw8ERVTwo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242e17c8-472f-4992-7e83-08d646854dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 20:52:47.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2552
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

