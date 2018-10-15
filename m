Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCB2C7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DEA208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I4oGD+T8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DEA208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeJPEms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:42:48 -0400
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:26912
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbeJPEmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv35j3g/uj+9emp2Qs0Ms8T8rpiMQx3L70HcAj1xXLQ=;
 b=I4oGD+T8EhJyvfvKeVUUUrFiyyXwOxxdf1ag8CifUbeeKSiZsH3g4IBLppoEs/GkUY/kccC4L0meZ0Ecj0pZN8XZLaaSIjrIfY+90fRAyZEO8uR7wY445PVqAFBaqkyTD8Pzl75sfeUZbGkL94i69/R0kII4b0QJRCGJQl+kpUo=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2534.namprd12.prod.outlook.com (52.132.141.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 20:55:42 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 20:55:42 +0000
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
Subject: [PATCH v4 05/13] arch/x86: Introduce a new config parameter RESCTRL
Thread-Topic: [PATCH v4 05/13] arch/x86: Introduce a new config parameter
 RESCTRL
Thread-Index: AQHUZMlv0QYbne3YD06tMdASZbxO8Q==
Date:   Mon, 15 Oct 2018 20:55:42 +0000
Message-ID: <20181015205514.25387-6-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2534;20:hqolTOtKifjxU8vLbg9/LAYcLC/8heb2hxGpCwzOpnCtXx5rM03ltdLOWhgrD4SmQgmlgprv8B6y8JD30FtVbW/xdpVLNFN5co0xEcnYaiJvXyyxH10lFz0UutoYtH+7+Fjsj017miOERnwTYoypq/IxAFTvwSNsU1NOY/6DDeA61cEdImpTItJHzCbWZ2JKHBIuMN5WENeeqVWjvegUZPIBd6uO3H8xrftliUkrvuOSJiesBgKN9wu4ZilZkALo
x-ms-office365-filtering-correlation-id: 26cc3c31-3205-4621-46d0-08d632e09186
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2534;
x-ms-traffictypediagnostic: DM5PR12MB2534:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB2534D3B04131568326B0880B95FD0@DM5PR12MB2534.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:DM5PR12MB2534;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2534;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(2900100001)(66066001)(5250100002)(26005)(36756003)(186003)(110136005)(54906003)(6436002)(386003)(6506007)(52116002)(97736004)(7406005)(7416002)(76176011)(68736007)(6486002)(7736002)(106356001)(102836004)(99286004)(53936002)(2501003)(2906002)(446003)(305945005)(6512007)(5660300001)(105586002)(2616005)(11346002)(4326008)(1076002)(72206003)(25786009)(81156014)(316002)(476003)(81166006)(14444005)(6116002)(478600001)(486006)(256004)(2201001)(8936002)(71190400001)(86362001)(71200400001)(14454004)(575784001)(3846002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2534;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x0gj8UrNmqL9OBwLqQwQbMwga1BzfYEVmqa12OLBad+jH6Ymld1uMOnHsOuNr6Lk/UNl147fPXERq2Iie2nRmuzCbjCcnMciHZlcA6Bhn/5/Xco1o1SkkA6qr4lKLcxBnhUiMjNBkytBjP2nMhfgVcoFMZt4DWrh7fSkUESH1EprHKfpU/HA48U446MoJUaOOdyXYgAe0uqC+0mRcXOXRJnP6O/IaLEoCG/N5n1mMRc+glKWkRWjLPz7Va3izBnlBIQUfRjaS3wvSkVCKtkIhR+0BlWwXSngR2WEYZ/Hun8Df3kfrMbpmX1vpNJPlTUSrSZHkn8a6bL0vNh0uuS36hy97z0VI7erVpmoyGkFal0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cc3c31-3205-4621-46d0-08d632e09186
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 20:55:42.0427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
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

