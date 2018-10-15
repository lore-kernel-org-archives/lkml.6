Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B887C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418B8208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mCPv8pNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418B8208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeJPEnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:43:01 -0400
Received: from mail-by2nam03on0071.outbound.protection.outlook.com ([104.47.42.71]:6043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbeJPEnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdzIAZgKSNVcKS9L33kNjUd1qfNWFrfxg5hZNEMs8bI=;
 b=mCPv8pNM0WnM3WeJKhbUYMOo7a41rYjW82w9/eIEtOF8iLzDqiQOBpfJQiQr9wNPkn98djMv9b9IMTe0j53wEEoj7BiyeJvVMjtZyf4+ekSvpD0j6/snIykQpyaP+oYmn3UiZvV+UrQdJ5vMwyszJG+d/PMjZwT7xs1kJ/MoJn8=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2534.namprd12.prod.outlook.com (52.132.141.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 20:55:58 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 20:55:58 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: [PATCH v4 12/13] Documentation/x86: Rename and update
 intel_rdt_ui.txt
Thread-Topic: [PATCH v4 12/13] Documentation/x86: Rename and update
 intel_rdt_ui.txt
Thread-Index: AQHUZMl5fWWtGx9fnEWuIawonDqbGQ==
Date:   Mon, 15 Oct 2018 20:55:58 +0000
Message-ID: <20181015205514.25387-13-babu.moger@amd.com>
References: <20181015205514.25387-1-babu.moger@amd.com>
In-Reply-To: <20181015205514.25387-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:805:a2::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2534;20:VBkyl9F+YBduh27J+m6/fnWmVlZSQfed6HONjnFQcOt7V1mlFsjO6r3X5QI+L468uWLZDuMk0dmsjFHXGR4OIHbifau6mGv0blHtxxpx8jTmWl7BPKk7Fz3wUAyj8mm32VMlnrJjg/pd1H8Rpc+RV8kqxAgpCDAAsqJYZYvw33lxBNC1v7S/1/KkfNYCaXxDIUzPjmoMzAb9Pvlbt9eLi12/M6z4tifuFP0Q1Bb7iHzwqdqFNvpeuoySXcXQ8Tjr
x-ms-office365-filtering-correlation-id: 2a7d4d34-391b-42b3-1d68-08d632e09b94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2534;
x-ms-traffictypediagnostic: DM5PR12MB2534:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB25343FB7E24ED502EBAE6B1795FD0@DM5PR12MB2534.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:DM5PR12MB2534;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2534;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(2900100001)(66066001)(5250100002)(26005)(36756003)(186003)(110136005)(54906003)(6436002)(386003)(6506007)(52116002)(97736004)(7406005)(7416002)(76176011)(68736007)(6486002)(7736002)(106356001)(102836004)(99286004)(53936002)(2501003)(2906002)(446003)(305945005)(6512007)(5660300001)(105586002)(2616005)(11346002)(4326008)(1076002)(72206003)(25786009)(15650500001)(81156014)(316002)(476003)(81166006)(14444005)(6116002)(478600001)(486006)(256004)(2201001)(8936002)(71190400001)(86362001)(71200400001)(14454004)(3846002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2534;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e2owMplYV5/WvJwnnFtgJFzJoPYrcxGX6nx5OFV+4qUoephPkcwT7EoeXUzQbHIfsr2yvZbVWRVjhKbLhecEAslkj+dYg2wQuItvpXYnqDgY3pHxyGApwpS8oG0He2lb+n3+3lcsjzYFRHKHlxk06nGXy8BsNxbR+SItCklIqYDiuPyx1+DvsAAzDZHrnkRBSOCr81pDkkJ2ZLM2zkOcRwVD+dlstwL7sKdu9ilHgVPowH2PksG5xbfA8jMwmjimCRdG9c6R4BMAzK2KJB3sc1Llj4ykfLwT47I2uerawvaDN0SsWYEAmP2DoIXz+gOOiI5886P9MLh7HeZpxBsnSWmfZFeJaIN++VH26z1cSn4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7d4d34-391b-42b3-1d68-08d632e09b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 20:55:58.8035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
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

