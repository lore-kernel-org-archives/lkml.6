Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4B9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003C32089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W/NmIFRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003C32089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbeKQHJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:09:06 -0500
Received: from mail-eopbgr740089.outbound.protection.outlook.com ([40.107.74.89]:8224
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730129AbeKQHIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLQ9635/cwIrdt15SoYM1O6TdfaS2H3heCSFUrbULGA=;
 b=W/NmIFRXTukszb9MpI04zIBNneqwc0qZ0gUuM1fLL+XHJMApiFNfVEsjKRdY5T4BQZ5njQiHg9kI8f/rANfQ8OY33TAWgfFUs2tEhFlSxyg/cgKlge5xrjZ+wRJVK1VVmqnDMUgFMyYLc+A8B1719nUyWNMW8wpbz+2blIMa9Bk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1131.namprd12.prod.outlook.com (10.168.236.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Fri, 16 Nov 2018 20:54:48 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 20:54:48 +0000
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
Subject: [PATCH v8 13/13] MAINTAINERS: Update the file and documentation names
 in arch/x86
Thread-Topic: [PATCH v8 13/13] MAINTAINERS: Update the file and documentation
 names in arch/x86
Thread-Index: AQHUfe6cH1Er/wBzb0uwSwNZYQkBpw==
Date:   Fri, 16 Nov 2018 20:54:48 +0000
Message-ID: <20181116205407.10457-14-babu.moger@amd.com>
References: <20181116205407.10457-1-babu.moger@amd.com>
In-Reply-To: <20181116205407.10457-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:805:f2::18) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1131;20:LbMV7w3xnOw4hnBfl5PlZG1Bz4z8j8K6DfLT2PvgW9vx3BIpPNKnHXGyyV4M5u08f8BoZjV1qNk2u9JuniNWXKtnxuSUw7nY6YGbFD5KArqEL8tlwxpKR3+GkKOQz0ot/LzpOKhJoz54PmvsKNSRjXS6gaF1tfJmHpy3E2m8O2MBio6soyIPhSy9Xh0IcH7FmoxjvEkRTPZ0mCMLOdDFES148GBu+p8pLFLs69DMkeMzCy4KOEmrcZ4TdERH/8kX
x-ms-office365-filtering-correlation-id: 97019413-3829-4050-de83-08d64c05bebe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1131;
x-ms-traffictypediagnostic: DM5PR12MB1131:
x-microsoft-antispam-prvs: <DM5PR12MB1131A5C15631BC28C2740AA195DD0@DM5PR12MB1131.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3002001)(93006095)(93001095)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1131;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1131;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(81166006)(14454004)(2201001)(6436002)(2616005)(86362001)(6486002)(446003)(110136005)(8936002)(476003)(486006)(97736004)(54906003)(2900100001)(1076002)(81156014)(36756003)(7736002)(11346002)(305945005)(2501003)(7416002)(8676002)(6512007)(7406005)(68736007)(2906002)(15650500001)(99286004)(71200400001)(71190400001)(256004)(14444005)(386003)(5660300001)(106356001)(72206003)(76176011)(53936002)(105586002)(52116002)(6506007)(3846002)(25786009)(186003)(102836004)(26005)(6116002)(478600001)(66066001)(4326008)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1131;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ph8XCx32n4QsKvnUjyKPuxeAvtrJaN9no0rZcdIDxl9Ym4SkAmWU9TsonOobqkog03AmI2cG2LsOWhUS4LVBBgblLZVcK75C6IfSL3/e5Wmfacq8ySwPfv1a9fTRDPHzgjXpfw8cJYEq1WNoqdQJxsV/NhFligyLVBXlpg10avvjjFs1DQH4FtuuYlAhEWFCo5U1vc0RcDCqAzBpyJ8sbcX9QibB77VjEkEUADL/H5LdX2GDpCxxJaSr0wyVL6IHkXzOvSfI3H2xVm3BsRfrnLdRxbH+Sw9MrZN7o8HsVOkGWXuRwV7Uw099vwLNL2cNj+Y741+PrB6r+VmUx2H9egLleYU5WKWu++BQuT2LC/o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97019413-3829-4050-de83-08d64c05bebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 20:54:48.0592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the MAINTAINERS to reflect the changed file(and documentation)
names in arch/x86/kernel/cpu. The file names have changed from
intel_rdt* to resctrl*.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48a65c3a4189..7643dba289c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12267,9 +12267,9 @@ M:	Fenghua Yu <fenghua.yu@intel.com>
 M:	Reinette Chatre <reinette.chatre@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	arch/x86/kernel/cpu/intel_rdt*
-F:	arch/x86/include/asm/intel_rdt_sched.h
-F:	Documentation/x86/intel_rdt*
+F:	arch/x86/kernel/cpu/resctrl*
+F:	arch/x86/include/asm/resctrl_sched.h
+F:	Documentation/x86/resctrl*
=20
 READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
--=20
2.17.1

