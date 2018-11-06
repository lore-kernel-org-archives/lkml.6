Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40811C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F271B20685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dS1cpYym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F271B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbeKGBG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:06:59 -0500
Received: from mail-eopbgr740077.outbound.protection.outlook.com ([40.107.74.77]:65176
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388907AbeKGBG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv35j3g/uj+9emp2Qs0Ms8T8rpiMQx3L70HcAj1xXLQ=;
 b=dS1cpYym6qztAIR5NwuPt39Nu82CVdOQQjOFLtzhM5tNSGOvlVj7ePNwMKU5Qt3mseN+3b66oPLF0g21XMi+iIz+1oLxhGXWzSiwGdoQsDjQDNabvSOuDl+WzCa7j6xeijOngaf+BG2S21S9bFHA59aSFGhcj55No/GIYlh8T7Y=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1275.namprd12.prod.outlook.com (10.168.237.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 15:41:08 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 15:41:08 +0000
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
Subject: [PATCH v6 05/14] arch/x86: Introduce a new config parameter RESCTRL
Thread-Topic: [PATCH v6 05/14] arch/x86: Introduce a new config parameter
 RESCTRL
Thread-Index: AQHUdecilzEZl4eUzkirwOPTF+Q9Lg==
Date:   Tue, 6 Nov 2018 15:41:08 +0000
Message-ID: <20181106154034.15386-6-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1275;20:oJg8fBh4PrxqgOmCskKSXUcV8/3N/2tWx3igZSNDt7Xnm1QWhKOS8vWUB4WrSCjmEHnCP3+a+mGwGWpb5Bk0CLXVyBmT5XmNYXtrUfVYC8Jx/lHug8xc1sxLcwGY7KGzu+HBe1gakVod7eBedzZ1M9BDBkFeluAwCabLZuHq0x7RdFV4Db3yhM9m0IoOmd6bBYo46J6+QAraCpWbrnxhU7dG4lLZdhIqr8VUCwjcs2fP6hmDRcRxkmBu9em3gfOb
x-ms-office365-filtering-correlation-id: 179f6f6d-748e-4a06-e9ba-08d643fe453e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1275;
x-ms-traffictypediagnostic: DM5PR12MB1275:
x-microsoft-antispam-prvs: <DM5PR12MB12757AACB6B53ADA02CB573D95CB0@DM5PR12MB1275.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1275;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1275;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(186003)(6486002)(97736004)(4326008)(486006)(6506007)(386003)(256004)(14444005)(2501003)(305945005)(26005)(6512007)(5660300001)(8936002)(7416002)(2906002)(6436002)(2900100001)(7406005)(81156014)(68736007)(446003)(53936002)(66066001)(86362001)(25786009)(575784001)(7736002)(71200400001)(476003)(71190400001)(81166006)(2201001)(2616005)(11346002)(99286004)(54906003)(478600001)(1076002)(3846002)(110136005)(102836004)(14454004)(316002)(72206003)(8676002)(36756003)(52116002)(76176011)(105586002)(106356001)(6116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1275;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BHf8/BggH9bIfzHCSzTeShMFqy4OiyAb0AIR1FGVMDfZL+tL4qTmgEq/IEPHyJzJRbbxDZyHfZqMOzq6zzZf5IWaOhkQLFGses6gZF1LnC9UKoE0k95H9UxTwhPIrr+3fZ1/QAcOI33TlcdPv9NvMwN4upUMphkBZdEvdMMnSVJNTnlXyXSAul6Y5W02THhgb4iYBaEM8pP+bJJtHJUm7SkBH6wDhxppz9ili/D7OJ8EUtDsDQ7PznXudYIbLlBa1iTpthvGx9ITolI8BSUraGSOkW8Ww93+Ia1MvIMoswryUm4Q0YHFlRJIuoVA5GKxGHoghgiSw52DZD4hVlYWeomGmiNiQU7rwiy5VWfjee4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179f6f6d-748e-4a06-e9ba-08d643fe453e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 15:41:08.5321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces a new config parameter RESCTRL.

This will be used as a common config parameter for both Intel and AMD.
Each vendor will have their own config parameter to enable RDT feature.
One for Intel(INTEL_RDT) and one for AMD(AMD_QOS). It can be enabled or
disabled separately. The new parameter RESCTRL will be dependent on
INTEL_RDT or AMD_QOS.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..91a703ebdc04 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -458,6 +458,10 @@ config INTEL_RDT
=20
 	  Say N if unsure.
=20
+config RESCTRL
+	def_bool y
+	depends on X86 && INTEL_RDT
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
--=20
2.17.1

