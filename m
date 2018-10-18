Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24397C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCED9214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e/fBCYws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCED9214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeJSGzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:55:38 -0400
Received: from mail-eopbgr730047.outbound.protection.outlook.com ([40.107.73.47]:20824
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727697AbeJSGzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66HO1TwWcIjKI7QCwONxIcZ6WfojcBLi3L4cjKOE+jo=;
 b=e/fBCYwsbbpd6zHADOOE9pleqIIdJS8g+YcGsdv2E1PgXqEM/UZJlRwXCPq1PVg7oR97KdVsciYFmHdoxUp8VcA2j9FlgSHv57T6y6sRUgW6ZbZdBzVUhcLvi9ZBqddcPHdeM8+qNPXLQZKp0CyLMx9ibJSiWlo30mRxi2u0Y3Q=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1340.namprd12.prod.outlook.com (10.168.238.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Thu, 18 Oct 2018 22:52:23 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.028; Thu, 18 Oct 2018
 22:52:23 +0000
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
Subject: [PATCH v5 09/13] arch/x86: Introduce new config parameter AMD_QOS
Thread-Topic: [PATCH v5 09/13] arch/x86: Introduce new config parameter
 AMD_QOS
Thread-Index: AQHUZzU7pwMubyxrAUGuisc8cDpmeQ==
Date:   Thu, 18 Oct 2018 22:52:23 +0000
Message-ID: <20181018225124.23043-10-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1340;20:beAKygyXvAYLvoxpgIA5IYYUFTLH35386zOz4W2exhbNOgcPGxIBTG8I+ePC4F4Sa9qa4rYCRJhgvmaD1N+sVasIZcNhljlgJQFFx+aQNSTNBVVVd+aGT7E8+CxIQxvePsZOnoCmOMrQeYW6kvA9MXrwDv15H+E157x+Q5E2s6liL1vVTO1NpQKwJN7hICbXPQh6AqvI0m9y6BeuW2EEgtzuJZ2Hfcl2UGOzvIr7jT0OyG7wADWucxLwubl0qZqt
x-ms-office365-filtering-correlation-id: 7c4d288d-85f7-411b-78b5-08d6354c5dbf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1340;
x-ms-traffictypediagnostic: DM5PR12MB1340:
x-microsoft-antispam-prvs: <DM5PR12MB1340507BB1153B34B120031C95F80@DM5PR12MB1340.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1340;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1340;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(199004)(189003)(86362001)(54906003)(186003)(71200400001)(110136005)(102836004)(478600001)(26005)(106356001)(76176011)(52116002)(105586002)(72206003)(1076002)(66066001)(81156014)(71190400001)(8676002)(8936002)(14454004)(5660300001)(7416002)(7406005)(2906002)(68736007)(99286004)(6486002)(6506007)(386003)(6116002)(81166006)(2501003)(7736002)(6512007)(446003)(2201001)(53936002)(14444005)(25786009)(97736004)(5250100002)(256004)(6436002)(305945005)(11346002)(4326008)(3846002)(316002)(36756003)(476003)(486006)(2900100001)(2616005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1340;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x3IELLHKVTujeUt4cuxfMlym+ACouZZJM0roKdsSb8ohtn5U0iA75v0Me7myUD3y9u5gcnL1h+YcWCxP7d1KxSPvTf+N4JKS/KXnCy2QTYE0gJtM5MNAsRdPPpB6KuUgr8HPenCUxwz5HCUjm8IKEgxnrWBMWo7CvUZutgYNMZ/wdZe3Vr+xOrYiCl7jma3ilYdV9VJobqHmjDUanMJVkY3Zbp8reUKcJtS3pogVM3SyngBNgv277ZTTpxYS5HgP1E82EKJw3itUKWFccGqvtfnzibhpp0fAkBiT/XfkySprd5sZMxc/4VVws2uXTSP/Cxce2hibM8V8b+mgTnFckfuVnd8TVi9kJl6BXKuDdYk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4d288d-85f7-411b-78b5-08d6354c5dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 22:52:23.0743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces the new config parameter AMD_QOS. This parameter will be
used to enable cache and memory bandwidth allocation and monitoring
features on AMD processors. This will enable common config parameter
RESCTRL if selected.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/Kconfig | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 91a703ebdc04..9cd21e536b65 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -458,9 +458,24 @@ config INTEL_RDT
=20
 	  Say N if unsure.
=20
+config AMD_QOS
+	bool "AMD Quality of Service support"
+	default n
+	depends on CPU_SUP_AMD
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
 config RESCTRL
 	def_bool y
-	depends on X86 && INTEL_RDT
+	depends on X86 && (INTEL_RDT || AMD_QOS)
=20
 if X86_32
 config X86_BIGSMP
--=20
2.17.1

