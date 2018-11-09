Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E861C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E8820827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RmGgcIPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E8820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeKJGfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:35:03 -0500
Received: from mail-co1nam03on0042.outbound.protection.outlook.com ([104.47.40.42]:30256
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728542AbeKJGfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNAdVvS0eseoxudrkXA/+m8NeNUn8fPkQoEZZk0dCEY=;
 b=RmGgcIPsnk3i4lN6Jr+98xdzwAtMRYyWHmbosBp5MciE72JsWb3e3MhRoJvM00TBWPwN+4L6npGHGG/LXAx8Q2FgBByq62fy6ipCkpkMCWPwIAZ6UalnMYqkcpPpy8EheSpbVFicmUkxAKZ1G6xQ+lqhtTl+F3Rk+jUcwRB5QZM=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2552.namprd12.prod.outlook.com (52.132.141.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 20:52:41 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 20:52:41 +0000
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
Subject: [PATCH v7 09/13] arch/x86: Update the RESCTRL config parameter
Thread-Topic: [PATCH v7 09/13] arch/x86: Update the RESCTRL config parameter
Thread-Index: AQHUeG4nv6lxTCaPrEKl3rrNprxbIQ==
Date:   Fri, 9 Nov 2018 20:52:41 +0000
Message-ID: <20181109205153.14811-10-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2552;20:5xuTi47smdFzM3BQo5F43Psl5LciZrfl/tjc6Jk2D9V23fqidq9/oj/t5rhrvm2qI6+ROuYGrVRSLD5vOxvg8OO1d/P+UPo+/59moTN17kJof3AfutlL/hN9NtLOU2voyvvebsY2ps+iCuyVRGNkSBhs1iogiGiZiqG8duCkXul6hNI2Pln0wRHTxl3gXcCWvrByG9e6jWVOl3P267u8IEcA+XvkgZlTp/hC5vANBKngivluL718oSd0edke7VBf
x-ms-office365-filtering-correlation-id: 7e9f5199-ce3f-4667-a70e-08d646854a4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2552;
x-ms-traffictypediagnostic: DM5PR12MB2552:
x-microsoft-antispam-prvs: <DM5PR12MB25528F2F781BDA2FE1794DC395C60@DM5PR12MB2552.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB2552;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2552;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(53936002)(478600001)(66066001)(26005)(71190400001)(6486002)(76176011)(2900100001)(102836004)(6506007)(386003)(71200400001)(52116002)(446003)(476003)(11346002)(2616005)(2906002)(99286004)(8676002)(186003)(6512007)(81166006)(81156014)(106356001)(105586002)(486006)(316002)(54906003)(110136005)(36756003)(2201001)(5660300001)(1076002)(6116002)(3846002)(14444005)(256004)(7416002)(25786009)(305945005)(7736002)(8936002)(6436002)(97736004)(68736007)(72206003)(14454004)(7406005)(86362001)(4326008)(15650500001)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2552;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Utsk6t3y9g6Jtx1gSzndV/RQPhm4Zji0pym4F0I8Jwvi1vCofZWA+dGzSW65BT7ZxIAxQW1dIuhs4ctBKv/3XShbyTGKRvP9etz9dPlYjvPPJp3hcuywXFllnylrkpNkR/RgINd8xklGu4KkjWBheoK/NsY70M7UV2WbYV0WmGO82oRAcnYVRMw9bxwvCo/pWftaUKkwtzIHrqWPcZ7e1C0b5fuZHEGTkwiihY2MSynhH0QXPmJ5okCBgjRprIA8Ze1X/kUZ28qpslqv9ucW4EWt+vhd09VLS6RlAXua9B0M/smXwHqnG1i2KoW+ah6QIokFTbKtpLo3pAs98GEZudgzPtdn568cbli3lR6llb0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9f5199-ce3f-4667-a70e-08d646854a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 20:52:41.2251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_RESCTRL will be used for both Intel and AMD to enable
Resource Control feature. Update the details and condition accordingly.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/Kconfig | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4aae7aba4d61..c5ef3afa89a6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -448,13 +448,22 @@ config RETPOLINE
 config RESCTRL
 	bool "Resource Control feature support"
 	default n
-	depends on X86 && CPU_SUP_INTEL
+	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
 	help
-	  Select to enable resource allocation and monitoring which are
-	  sub-features of Intel Resource Director Technology(RDT). More
-	  information about RDT can be found in the Intel x86
-	  Architecture Software Developer Manual.
+	  Select to enable Resource Control feature support.
+
+	  These features are intended to provide the support for the allocation
+	  and monitoring the usage of certain system resources by one or more
+	  processors.
+
+	  Intel refers this feature as Intel Resource Director Technology
+	  (Intel(R) RDT). More information about RDT can be found in the
+	  Intel x86 Architecture Software Developer Manual.
+
+	  AMD refers this feature as AMD Platform Quality of Service(AMD QoS).
+	  More information about AMD QoS can be found in AMD64 Technology
+	  Platform Quality of Service Extensions manual.
=20
 	  Say N if unsure.
=20
--=20
2.17.1

