Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5ADC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C7821486
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iBEzqhbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C7821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJSGza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:55:30 -0400
Received: from mail-by2nam01on0052.outbound.protection.outlook.com ([104.47.34.52]:11824
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbeJSGz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv35j3g/uj+9emp2Qs0Ms8T8rpiMQx3L70HcAj1xXLQ=;
 b=iBEzqhbhFa7mvS0YA6y3yOh45CU6bEZb42C6GMJ979qPTQRKuZEyz2umd+qoEnqXTRzJF05C5Q5QiEl38M1yPqSZ63h+EXGXD3rXpXNF0H8apa3/PudMSnBLqMT90rdsEKCPxIxp4T9Nl1g3NAtFCa/bUib8FlyDGwKp5z/AiYc=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1818.namprd12.prod.outlook.com (10.175.91.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Thu, 18 Oct 2018 22:52:13 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.028; Thu, 18 Oct 2018
 22:52:13 +0000
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
Subject: [PATCH v5 05/13] arch/x86: Introduce a new config parameter RESCTRL
Thread-Topic: [PATCH v5 05/13] arch/x86: Introduce a new config parameter
 RESCTRL
Thread-Index: AQHUZzU1ygGYNTz/v0CnFQROJmeP7w==
Date:   Thu, 18 Oct 2018 22:52:13 +0000
Message-ID: <20181018225124.23043-6-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1818;20:RokZIIRieetbimDo8JyMBDQhW1iPTdxfArWdr5lx3Hlygo0Az5VyrTtWZt7gLQcfBzi7rtbCDrmqo18KpizvAFq8ota4A804aW18GKmbixc13vsgdtpM26lRMYVcMaUl0ejaS7SIDkI1I6W4Mn7PxAA5s9mryTWAR94YJoL6/3HK9jTAilAGpbMj3IfqXCXahPXUrhk6zQc66yhevDtpcVTfHyw7ZMzWfROPm1jXD0VonBjQakuBDavLp8LJuLAM
x-ms-office365-filtering-correlation-id: 31880e52-8bbd-4f0d-370b-08d6354c57f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1818;
x-ms-traffictypediagnostic: DM5PR12MB1818:
x-microsoft-antispam-prvs: <DM5PR12MB1818D6DCF58B65D1C7B5DC6F95F80@DM5PR12MB1818.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1818;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1818;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(110136005)(478600001)(2201001)(8936002)(5660300001)(7406005)(14454004)(7416002)(1076002)(6486002)(6512007)(5250100002)(6436002)(68736007)(72206003)(54906003)(66066001)(106356001)(3846002)(186003)(26005)(86362001)(2616005)(2906002)(476003)(99286004)(81166006)(102836004)(81156014)(6116002)(53936002)(486006)(52116002)(446003)(36756003)(76176011)(386003)(316002)(2501003)(7736002)(11346002)(6506007)(8676002)(2900100001)(25786009)(575784001)(305945005)(71200400001)(71190400001)(105586002)(14444005)(256004)(97736004)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1818;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e4UBYhwQs2JtUnI0fkl5tDUUN7mUAzw2Kl08RPP8qCCFpb3zn0cKufuFHXOVVMaHEsgky3hQiEIT893FByjzPGHGb25Qq8RSR8cxvQM3+7NUuy+d6UgMKUZy2YDqSfasjINOdbKWRZDLYMC6Ht94sEz42QJvrau1rDDsz7gbZtImnLxFohXk0spWrhM3XmABmkn86dVwrCwRxv8HvYGCRVYJLe9wyNixG3DOvyBsSBPFn2X2lvjDzU7eRE5UjCniSuRJnnhVO0RY47iPEq6+ufVV+wB+WlVt+5SUywoiBIb9B0yyNChAf5zWGzAphDpBxYgP8aYVVgp2luQfWsiyy6CRWPgtm/o0HpCACo5i1yo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31880e52-8bbd-4f0d-370b-08d6354c57f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 22:52:13.4654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1818
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

