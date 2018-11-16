Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05812C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13E12086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IxK1jdNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13E12086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbeKQHIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:08:43 -0500
Received: from mail-eopbgr820074.outbound.protection.outlook.com ([40.107.82.74]:39637
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729502AbeKQHIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcXlxSwEE3Bqw3Ny7A9vM7OAEzRQ4vjNzfH8gIZDcMc=;
 b=IxK1jdNWcr2fKL+tnTIfa42C0dVRlALphyawI4cb+gktlwc8ZcGw2H+phw34ldXL3ZsZxGcpJJMSykJlGMttmSeKYa+iryPvWoc6t25KlPKZcoRUWpCiraoBjUw63IodyICvOTIH8QLWFPmVAWatcFhtdhs97KSpxPStSuh83Oo=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1577.namprd12.prod.outlook.com (10.172.39.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 16 Nov 2018 20:54:37 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 20:54:37 +0000
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
Subject: [PATCH v8 08/13] arch/resctrl: Add vendor check for MBA software
 controller
Thread-Topic: [PATCH v8 08/13] arch/resctrl: Add vendor check for MBA software
 controller
Thread-Index: AQHUfe6W4fraBQ3PHkCFJBY4rIaeVg==
Date:   Fri, 16 Nov 2018 20:54:37 +0000
Message-ID: <20181116205407.10457-9-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1577;20:shVCa6MYBoyBNWljZYsVl3EKIdu86QD7qlyaRruHtOsI5ixIfzhWky38AVto3Nd4GRVEaI09UeHCUF78uzzCZpJiIo7DwQntt0gqRomdn98rXL99HusTLnV8NXwTc465lvpotvRoKgndAW8FkTA3osXBEU/FWIYxBtlv126yLv+xzvzyoSKv/VaUWMliHAlBC6fN88bPoE8jfT3uObBGLGFzKy14ns6xulGtvQqoQYcYfJM+bF+QCwZF9VqDd6jv
x-ms-office365-filtering-correlation-id: a98a9b9b-66d1-4e79-4c5a-08d64c05b863
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1577;
x-ms-traffictypediagnostic: DM5PR12MB1577:
x-microsoft-antispam-prvs: <DM5PR12MB15771731BACA95F310B139C095DD0@DM5PR12MB1577.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231415)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1577;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1577;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(189003)(199004)(36756003)(316002)(66066001)(81156014)(6506007)(68736007)(2906002)(26005)(7736002)(102836004)(110136005)(72206003)(8676002)(8936002)(305945005)(478600001)(6486002)(386003)(2900100001)(97736004)(2501003)(54906003)(5660300001)(81166006)(52116002)(99286004)(1076002)(3846002)(6116002)(186003)(76176011)(486006)(7416002)(7406005)(6436002)(476003)(2201001)(2616005)(11346002)(4326008)(25786009)(446003)(106356001)(71190400001)(71200400001)(14444005)(256004)(105586002)(14454004)(6512007)(53936002)(86362001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1577;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 93riyn5AME6L6wPe1TvKNaLRBhuy0po90wD0vEaHAda8SkFAArfEGlrPDS9toySAPh0r7om31JBhWzkTdHW5xsC9duCZG8ixn3cpYBsygQ7Hab9NCT2JWrqhQ2qkWKz6vhecabAwJ2Le8taZMfafGm1bX8OFPOAs5igvO77usc3FEgVFjeBzevKSBMn312HecoxCOi1Jt/2RfrXRUi6hIBYN33tNjIr0xQZyRVgoG2diOv28nMSkYSiR5uKJ7ajmBESRddDKyRTTrxYVdqD/tUNLUg7JArjv4vnIcznUkyHNsAegPAE8WGm8oQXabpfJxwZRZ4omRJFiy+M6+W7gy3tu93ogC/3n6WhE2cn2Afw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98a9b9b-66d1-4e79-4c5a-08d64c05b863
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 20:54:37.4308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MBA software controller support is available only on Intel.

Suggested-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl_rdtgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl_rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl_rdtgroup.c
index 8b6b4a8bb7ca..022a56096024 100644
--- a/arch/x86/kernel/cpu/resctrl_rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl_rdtgroup.c
@@ -1878,7 +1878,10 @@ static int parse_rdtgroupfs_options(char *data)
 			if (ret)
 				goto out;
 		} else if (!strcmp(token, "mba_MBps")) {
-			ret =3D set_mba_sc(true);
+			if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+				ret =3D set_mba_sc(true);
+			else
+				ret =3D -EINVAL;
 			if (ret)
 				goto out;
 		} else {
--=20
2.17.1

