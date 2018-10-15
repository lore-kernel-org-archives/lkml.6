Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11F0C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEED20869
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4C4AqCDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEED20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJPEno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:43:44 -0400
Received: from mail-sn1nam02on0073.outbound.protection.outlook.com ([104.47.36.73]:21027
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbeJPEnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLQ9635/cwIrdt15SoYM1O6TdfaS2H3heCSFUrbULGA=;
 b=4C4AqCDgg+vCUutqQxcNyuEeV8btYXx7cPgADyPLlcoYJPf/MjtsDX0zFe+kgM4SM+vdW65n6GsKxjtBNkaL+nDqXbUYL25NgjXikh0M1Y+CTHlnG4cHeeoaV1UcFtR/jS+jMAOJ5woOX84LTuEbrKiZMD7YQGA2OMm8RyTtxWg=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1850.namprd12.prod.outlook.com (10.175.86.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 20:56:01 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 20:56:01 +0000
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
Subject: [PATCH v4 13/13] MAINTAINERS: Update the file and documentation names
 in arch/x86
Thread-Topic: [PATCH v4 13/13] MAINTAINERS: Update the file and documentation
 names in arch/x86
Thread-Index: AQHUZMl60EbWPosxR0242NLdPGZ97g==
Date:   Mon, 15 Oct 2018 20:56:01 +0000
Message-ID: <20181015205514.25387-14-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1850;20:W8GoOb43Qs7m59hcY1lJTwhvkVHO5oq+LVJaMGCERXTx5nz95mMJxOLh//stxwcQ7sMUcJd6FyxhZoEyX7Ate1RfBDnfp1wFcTJvJBIBH538HVwGlZqUdPT9u9qFSoZ5z1no12VdbJwApiaqehfd9t9Q7KRtH7V9+pa1TwY0Q5jgC+05OGQ2PJrZdTJO2OE4734DP28Nm0vsroIdEVWOhOSp0bhHGDgxHmul3ZlWwGTCC3pv8h9AbyCW1y7MIS2n
x-ms-office365-filtering-correlation-id: b29a7a09-7690-4f66-1dfd-08d632e09cf9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1850;
x-ms-traffictypediagnostic: DM5PR12MB1850:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB1850106184DBC115B23AA93F95FD0@DM5PR12MB1850.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991067);SRVR:DM5PR12MB1850;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1850;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(1496009)(366004)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(54906003)(106356001)(81156014)(8676002)(52116002)(305945005)(105586002)(5660300001)(110136005)(2900100001)(6436002)(6512007)(53936002)(6486002)(2201001)(8936002)(81166006)(446003)(256004)(476003)(86362001)(11346002)(99286004)(5250100002)(36756003)(486006)(2501003)(478600001)(15650500001)(72206003)(97736004)(71190400001)(25786009)(76176011)(71200400001)(1076002)(2616005)(26005)(386003)(14454004)(6506007)(186003)(66066001)(102836004)(7736002)(7416002)(316002)(4326008)(68736007)(3846002)(14444005)(2906002)(6116002)(7406005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1850;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W70UclQUrQP3E6jjx6W0lZ0Rb6U/EaMUZ9d4vVXJ0EIgwL5PPfe2hFzP381RAVZtFxMXdRdL2wyD0uC9ti2U9memXxAOi1XwL4KhwXfOH/asEcaQbqW9hNKNEdJayGqHwG+E5FutZ48wnbdT4BI7YXbuYlSwcJJeYpsMBUn+xWyyOqt5X41pF7qiIFQgNZuyLfG4Bnzi+qLB2eoxNY4KDYjR7pj9/h9bVa8GUG6HUfzpNQ2XcA8BIIIs8Izxa7RVQmRrC6xV3Na7cVFIMl7VU5qVtOGnj15XEMgJ9mAIkqc6VAVl4R4WfEsePeOMYIwhpL99/MvI46buMWBvAZNeA6cMo2nGpQmVHtjZEBf0OcE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29a7a09-7690-4f66-1dfd-08d632e09cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 20:56:01.1481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
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

