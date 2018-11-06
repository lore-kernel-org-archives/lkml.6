Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C210C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAACD2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cwy1I9TB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAACD2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbeKGBHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:07:18 -0500
Received: from mail-eopbgr820070.outbound.protection.outlook.com ([40.107.82.70]:17680
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389138AbeKGBHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLQ9635/cwIrdt15SoYM1O6TdfaS2H3heCSFUrbULGA=;
 b=cwy1I9TBnJgblx2lwAVHw31nPzGcwPRjkvbbMQUpt7gQajIBm9VVeJS91KIEWR9avXnS8u5Et41Xb14FjWMBpdHd3kr+La/h62rnFDr4bRoMoZ+WJbN3OMP+WNDos7oHGbjSUlrMkzKcbM6zLP6TY6gz9xAjga/kpIomGz0g/HQ=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1562.namprd12.prod.outlook.com (10.172.38.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Tue, 6 Nov 2018 15:41:28 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 15:41:28 +0000
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
Subject: [PATCH v6 14/14] MAINTAINERS: Update the file and documentation names
 in arch/x86
Thread-Topic: [PATCH v6 14/14] MAINTAINERS: Update the file and documentation
 names in arch/x86
Thread-Index: AQHUdecvNVR0j9a6pUSBjjPfjLSFfw==
Date:   Tue, 6 Nov 2018 15:41:28 +0000
Message-ID: <20181106154034.15386-15-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1562;20:z0BobYvllQvklQO9fpZnq8Vno6eKKRw3VGKNzyZxUqgSMuL6vo/emM9rAssflOvnmV5yRQhvkccw4DqBes6Io0YrW99QuD2k23CTytpb4eTb8zToWKE5LEeYSYdZ7kxifKtSsV8PE0cS4MjlNCnw6W6HZf/Y6LvRSmEjzuLNa3+JzjE8EkDwyPcl6cTE2FzXISD4hWtwbZUFIf7EglN1kjvDjUeEN23hSjM6g1epJ8bmPhtePuT5DOgfMT8H7brg
x-ms-office365-filtering-correlation-id: 64e64727-f630-47e1-5a3f-08d643fe5142
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1562;
x-ms-traffictypediagnostic: DM5PR12MB1562:
x-microsoft-antispam-prvs: <DM5PR12MB1562E58A17693050C73F1B8795CB0@DM5PR12MB1562.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1562;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1562;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(99286004)(54906003)(110136005)(2616005)(186003)(386003)(476003)(26005)(486006)(11346002)(6506007)(102836004)(316002)(3846002)(1076002)(71190400001)(71200400001)(6116002)(36756003)(6486002)(52116002)(76176011)(446003)(2906002)(81156014)(105586002)(106356001)(86362001)(2201001)(305945005)(7736002)(8676002)(72206003)(6512007)(8936002)(14444005)(53936002)(2900100001)(68736007)(478600001)(66066001)(6436002)(256004)(81166006)(14454004)(25786009)(97736004)(15650500001)(7406005)(7416002)(5660300001)(2501003)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1562;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R0epVU0sx2+/o2LxBlYID7IICW3T2kfWSvuwXFE0zq7wHDQsNavEARd4DiS8WcMPmcn291OtQjy1RsayWF/aCzFkQEv0dnG/1Mz9ETHo0lOXnUkV3kAKQWFI/CcdV1JwJssW5CgFyr4bLsTFBzdGAfWqRxUDjvzOTzmWaUDs/+HxwobMMV2ETBdtLday8WXSdyFFxS2IAjpvgvdN6ANSA/yjAsYy3EdbbVxXqzA+0IHXtl9P+MP6PODbrhVvUBlkw+gnFXRuwDYKRjIKgveovk5NValH90IPIr/EMzvxIeAzqNPDgjOBw4bFtTiM35eNM+SY3oIAMDUku43E9DPTpvfKQxiBN4Vde553DjIGovc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e64727-f630-47e1-5a3f-08d643fe5142
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 15:41:28.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1562
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

