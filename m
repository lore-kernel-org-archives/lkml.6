Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D4FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E542098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W7qIpr5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E542098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbeIYBWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:22:45 -0400
Received: from mail-eopbgr690067.outbound.protection.outlook.com ([40.107.69.67]:62813
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732497AbeIYBWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yeiyWFz4+t14IssR+IULHoul0BuHuFxthkiyKm7tZQ=;
 b=W7qIpr5ThbougNmsYhmWzbgpsyd0pi5BmtBAkSXBpH6p4P1W7PXZWFoskbIPhPJxDKeBJKFRAF7tEYR3812MCvnO6AwQdtsps9YBdQlTgtqgcDD7dxNLCGuibW/2DwudIjuJ3OUF+qJwTVGdnUaxBEegkIbjWlXT4IVMm/zUnCA=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1548.namprd12.prod.outlook.com (10.172.37.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 19:19:02 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de%5]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 19:19:02 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
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
Subject: [RFC PATCH 04/10] arch/x86: Introduce a new config parameter
 PLATFORM_QOS
Thread-Topic: [RFC PATCH 04/10] arch/x86: Introduce a new config parameter
 PLATFORM_QOS
Thread-Index: AQHUVDtzN9VFbMj450WdafQxmMpopw==
Date:   Mon, 24 Sep 2018 19:19:02 +0000
Message-ID: <20180924191841.29111-5-babu.moger@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
In-Reply-To: <20180924191841.29111-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:805:16::22) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1548;20:66z7cgL4BjC+7mJwjRL/BSSLmVxqScO48S7YlloGs5QgXTr+6mnC0BmvoSUX0v7B4Oow/1xHObcApgDgVRup954w8t9K7kES6xBXimoYkP0J4W3VqBO/4x7aF7lc0zDQHa2ExFHTXZ682PvWNi8mIqY06KPeVLYTIbJAj33RFRSV8B08QVd8UQylXpSCDVG3W25LsAtC4WsqK1fEWyfKOS4wT84Pz4ePvgrSitdpZUEvYVRCK2dBkVhmrepePIt5
x-ms-office365-filtering-correlation-id: 776e3c83-eb7e-4c14-8322-08d622529635
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1548;
x-ms-traffictypediagnostic: DM5PR12MB1548:
x-microsoft-antispam-prvs: <DM5PR12MB15484FC7FD260A19E61BAE4295170@DM5PR12MB1548.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB1548;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1548;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(5250100002)(2501003)(186003)(4326008)(2900100001)(14454004)(6506007)(2906002)(386003)(256004)(316002)(53936002)(76176011)(68736007)(102836004)(36756003)(105586002)(99286004)(14444005)(97736004)(106356001)(81156014)(8936002)(5660300001)(476003)(110136005)(81166006)(1076002)(26005)(71190400001)(7416002)(486006)(2201001)(6116002)(3846002)(6512007)(217873002)(478600001)(575784001)(86362001)(305945005)(52116002)(8676002)(25786009)(66066001)(446003)(6436002)(72206003)(54906003)(11346002)(7736002)(6486002)(2616005)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1548;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ha5buBvMzmlMJeH7wS9RyY99C4VNE6plVuwjcfLmfRakfNZ1sZXbJiiayaUKqT/kh8OPaPI36FC4LIrYwv1YQ4jF3l0d3O6i1avacT1MhrXXNJ2mrIoejk2mVfRisIGnAOr7eGkol5i9csNgKDbtgI+DTzTxB28P3XlC/vHcfcebaEkUteZOEufxXiZ1Bar10956xmsm1FExxEROm3EeEsRKFF+6EeOEL1fdDHiqm58rsAb3A6sxNeLBSTfCc2IKH0vW0bEapvOG5/wOU2jSMDvflDAeDxpnDGb04c/BdINp4vBc6GXFe+wwfXAWLjpCotezX8w9/Vq7z9xXomnGdkvo19PXe1aHpcchUvhvi44=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776e3c83-eb7e-4c14-8322-08d622529635
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 19:19:02.6689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces a new config parameter PLATFORM_QOS.

This will be used as a common config parameter for both Intel and AMD.
Each vendor will have their own config parameter to enable RDT feature.
One for Intel(INTEL_RDT) and one for AMD(AMD_QOS). It can be enabled or
disabled separately. The new parameter PLATFORM_QOS will be dependent
on INTEL_RDT or AMD_QOS.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..7f2da780a327 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -458,6 +458,10 @@ config INTEL_RDT
=20
 	  Say N if unsure.
=20
+config PLATFORM_QOS
+	def_bool y
+	depends on X86 && INTEL_RDT
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
--=20
2.17.1

