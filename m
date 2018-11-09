Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6A4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9345821019
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y6QeuPwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9345821019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeKJGfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:35:00 -0500
Received: from mail-co1nam03on0073.outbound.protection.outlook.com ([104.47.40.73]:18016
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728542AbeKJGe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcXlxSwEE3Bqw3Ny7A9vM7OAEzRQ4vjNzfH8gIZDcMc=;
 b=y6QeuPwIWINsk+ygjIqkGR81piw9A1qkIVjfHH53cl/IdAXLy+qU6r3nwF9E1x4Plzz+zLSV0/9f57NHBvz/MqaC4Z27JeL2YNXN5k5B4cG4pu/oP8c6CMcgniw0U0X3HluT2sKc1jP8HF1lRwxu0bnm/2WXXPiROYaMXpfh0mY=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2552.namprd12.prod.outlook.com (52.132.141.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 20:52:39 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 20:52:39 +0000
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
Subject: [PATCH v7 08/13] arch/x86: Add vendor check for MBA software
 controller
Thread-Topic: [PATCH v7 08/13] arch/x86: Add vendor check for MBA software
 controller
Thread-Index: AQHUeG4mMCa2d9nwLUy5bm9kss/GKQ==
Date:   Fri, 9 Nov 2018 20:52:39 +0000
Message-ID: <20181109205153.14811-9-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2552;20:F/ztYzuW2aXm26c025hA5MVPPAnyFtaypfrpAv6nBPagYvCN+ehZ7pAApt1fsJZLy1Qfiv1TFgZlYRKPEHyMzz+t5mAyWgiGRP12iAk5jTx3ZtXzTFi0XlE26nGBAaIH7ZNHZbUuYhZ2/jmZC44Q0Fq5Qccwv4MoKtMx3Hjg2Ezo/j9gZ6DFyg4wyZ08ec0WPmFqt2eyIeP8eEH7v7PGqzxomUHQScq4Ds9sVID7sK//eMILKeMd0ACsQRQgTK1i
x-ms-office365-filtering-correlation-id: 5ee1fb2f-ae80-4686-eb12-08d646854914
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2552;
x-ms-traffictypediagnostic: DM5PR12MB2552:
x-microsoft-antispam-prvs: <DM5PR12MB255260D631F322D1EE18EF3195C60@DM5PR12MB2552.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB2552;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2552;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(53936002)(478600001)(66066001)(26005)(71190400001)(6486002)(76176011)(2900100001)(102836004)(6506007)(386003)(71200400001)(52116002)(446003)(476003)(11346002)(2616005)(2906002)(99286004)(8676002)(186003)(6512007)(81166006)(81156014)(106356001)(105586002)(486006)(316002)(54906003)(110136005)(36756003)(2201001)(5660300001)(1076002)(6116002)(3846002)(14444005)(256004)(7416002)(25786009)(305945005)(7736002)(8936002)(6436002)(97736004)(68736007)(72206003)(14454004)(7406005)(86362001)(4326008)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2552;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K/qxUyCOALryFjSAuvvHGtNUT5b2AZc1uUSc394QY2BlWLpUlL6BRAoSL0fRCYZW/3wuk/FsNQCIPmohLGX6aIpyu7u1UfHeHtNpGTJYSEfQ6IHT4TaAIpgYvRJUiIkws87WKAr49Rl1tFupcQrlWR+iVgdcL9PVqK8l9RG4BkzsDcNX7q1KrzeSS7AmsKbUNrV+FVL3FWfmF+rYiFCWwiKAzK5uOgU3vZWORtHjmB615zu3/fM4mJP66cfAPKHn0VyDYKQ3kU+XfBZIMphsKB1mGGnws2uPMCn3Ou0RXutiLIa7iFTqj0FnS1ZS1bW10V3ryBgeHBBSODzPoJZYOBjvl/l26I7L4oSdNszXWG0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee1fb2f-ae80-4686-eb12-08d646854914
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 20:52:39.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2552
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

