Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6260C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6038020644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uj5CUAiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6038020644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJLECv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:02:51 -0400
Received: from mail-eopbgr690085.outbound.protection.outlook.com ([40.107.69.85]:54329
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbeJLECv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv35j3g/uj+9emp2Qs0Ms8T8rpiMQx3L70HcAj1xXLQ=;
 b=uj5CUAiI71DXX/fUzQCT0mHdxTj/sTVHY8kVWpyjWFCR8XMjGfVWocmlaCtFUMyLfXiTt558a+cIop2rxw/MDOWuVM9yAGWQ4+mnboUbcE2JVgZehLQLM4qdaZhlIPyGMrj/qO0i/bhB4DyaT/rHLFwve3GoyP6uONNea9lh3Uo=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.141.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Thu, 11 Oct 2018 20:33:20 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 20:33:20 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/11] arch/x86: Introduce a new config parameter RESCTRL
Thread-Topic: [PATCH v3 05/11] arch/x86: Introduce a new config parameter
 RESCTRL
Thread-Index: AQHUYaGlntupCJjr8UaO/c/54WqitQ==
Date:   Thu, 11 Oct 2018 20:33:20 +0000
Message-ID: <20181011203223.18157-6-babu.moger@amd.com>
References: <20181011203223.18157-1-babu.moger@amd.com>
In-Reply-To: <20181011203223.18157-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0062.namprd22.prod.outlook.com
 (2603:10b6:300:12a::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2440;20:6DDfELUomT4KGfTyG/umRCCAJlQClx10H5nZkdcvvvhDB/8+cKrGoxPDddDonNaetF+v+ogEqmynul7cEDKtS7/OnMYfXBbIWV1RaVBwiGJvgpZAOy2rDEuauXso3ZIqgpJa3N0fb78+dM/USvdFBb+IPAYW4Qc8aS9l5EMEMn1h5VYNR55IiYh/TocuCXEuJQ+SxkZKAmwoKxDxDLkFFSGq0yap+AjXDw4hSSMeFgTkg2rSM0rhPIQJ+fkHjRcA
x-ms-office365-filtering-correlation-id: 017ef2c5-34c0-4736-567a-08d62fb8c82d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2440;
x-ms-traffictypediagnostic: DM5PR12MB2440:
x-microsoft-antispam-prvs: <DM5PR12MB24408177EBCB4D8C442980B495E10@DM5PR12MB2440.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DM5PR12MB2440;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2440;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(53936002)(76176011)(6486002)(478600001)(99286004)(52116002)(4326008)(6512007)(81166006)(6436002)(81156014)(5250100002)(8676002)(14454004)(2501003)(446003)(26005)(102836004)(2906002)(186003)(3846002)(6116002)(1076002)(7736002)(305945005)(7416002)(54906003)(486006)(97736004)(11346002)(476003)(2616005)(2900100001)(8936002)(106356001)(316002)(110136005)(575784001)(86362001)(256004)(25786009)(386003)(6506007)(66066001)(36756003)(72206003)(2201001)(71200400001)(71190400001)(5660300001)(68736007)(14444005)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2440;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WYWctA1Z9I8xKVF7r+evq3YxMSbbJEb3sAkKyV4zJLVywFD6WJGqpIJ0FHNwO4Ha5llDdxQvIPmqqHRY+3BsdlQHh/Hj683Mg33jDjzoHPS9pV5X5GZo1Gm7nhXN4tBAjen7PS/S79W6y7R+QqVTCFi2FNAXfJte1tXhbIFaQT1dstExETfoPvt4G+ntGB8OXpWqdKwefpJmjen43B1w/ysluvQ+8k2EoMmAYnk7Gq1gJIdtUBds8OrB+lSmF358A0y4J7a+R+Oa4VFaQW0fkmpq2Q9KkvpaI16wFOF55tFs3MxRRvkRIlrLfQ2DFKBqXdfLgjQEcSh7HBAvFUGQGHZ8tjYeRKetrpXQoYxAQ0o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017ef2c5-34c0-4736-567a-08d62fb8c82d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 20:33:20.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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

