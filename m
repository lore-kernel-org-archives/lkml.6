Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8212AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335AB20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QMHJAdPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335AB20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeKJGe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:34:57 -0500
Received: from mail-eopbgr740074.outbound.protection.outlook.com ([40.107.74.74]:39808
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728302AbeKJGez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjvmQoXHltYj2bwnEMzrmnG6F9+A4sudshaqtUvgCUc=;
 b=QMHJAdPrN6soI5aV6/onkk07lINFFboTAApQ1LU2hcOkm9zsTbddq9stH3I8WUDvpGuCeZzwXg/fwtqnjCX9C7K026a3Pc9O83b+0wDassEHjnUWFlDmAskuPILIdkdrHo5JNt6AZZ2kt/rYncMYuG9JlXrtaIdurVaJTTa+ghs=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1675.namprd12.prod.outlook.com (10.172.40.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Fri, 9 Nov 2018 20:52:31 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 20:52:31 +0000
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
Subject: [PATCH v7 04/13] arch/x86: Bring all the macros to resctrl.h
Thread-Topic: [PATCH v7 04/13] arch/x86: Bring all the macros to resctrl.h
Thread-Index: AQHUeG4hJDBHzpKgRkOEqIKd1h+Qew==
Date:   Fri, 9 Nov 2018 20:52:31 +0000
Message-ID: <20181109205153.14811-5-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1675;20:Pa54CmRuLrtX8ajVXz1C+jjYVY3vRHyOKjiQHRr6HMNWtdNXG+YtQIbSArcTsQC9h6r2laHNzmdDNGb03+3o6Iea+EygB8REg2M47kQ7ty0TZ6GeKXR07a9xOjeARcwzSgitcNdx+7fKS70nN/8JdOuEI5ZmHSZ3BPoohZoiw4RApYoHlh9b7PdMveKvcc+RFgLK/uaf8vrpOPDDT3DmDtROJu+ZjSWVpwBWulNk/pgiwfvSGSoQdfk1SQbStEAf
x-ms-office365-filtering-correlation-id: 9de58d4d-94b3-4aca-90d7-08d646854433
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1675;
x-ms-traffictypediagnostic: DM5PR12MB1675:
x-microsoft-antispam-prvs: <DM5PR12MB1675F0B1EB29477EB627EA2895C60@DM5PR12MB1675.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1675;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1675;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(305945005)(4326008)(14454004)(6116002)(66066001)(72206003)(36756003)(105586002)(6486002)(3846002)(6436002)(102836004)(386003)(6506007)(6512007)(478600001)(99286004)(2906002)(5660300001)(25786009)(86362001)(2900100001)(68736007)(575784001)(2501003)(2201001)(26005)(11346002)(7406005)(81156014)(446003)(81166006)(486006)(476003)(2616005)(186003)(1076002)(52116002)(53936002)(8936002)(7736002)(106356001)(14444005)(256004)(110136005)(71200400001)(76176011)(71190400001)(8676002)(54906003)(316002)(7416002)(97736004)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1675;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fIEGvbs2dOLiBxQeeSfZnIJHrSuyES21jcIYvEre6EAjSva//DblMUVBHsLuOKAff+JhW0tLPKQPVBLqxVUXJIkBMNJzVixwI8y0H1NQzI7Je+6vSd4dzAiTT8Qz1pAE8QAiDHpsTXfc62eVAKinaCI86ixlRTLyBjo6mtyT8zu+2J9n6QVYsXEL1x8pZ1G18nURo/7OjctZAQL80i7wFfCx2/SzvyC842aEqZfrUP7WPM1tswSSowwqFz8gN0UuGlKXVmBzQG/3e0vZcdgsCdf95EFi4P/VJtyQAIeDkKfgkIqJSIwZrQapqjJJU0DPCNp4V5aYNW7rxAbTSX5SJ564WSIPZKlhygjzV4D5K7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de58d4d-94b3-4aca-90d7-08d646854433
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 20:52:31.0920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring all the macros to resctrl.h and rename for consistency.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl.c         | 3 ---
 arch/x86/kernel/cpu/resctrl.h         | 5 +++++
 arch/x86/kernel/cpu/resctrl_monitor.c | 7 ++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
index fd5320dddddc..ddb2c65a309a 100644
--- a/arch/x86/kernel/cpu/resctrl.c
+++ b/arch/x86/kernel/cpu/resctrl.c
@@ -33,9 +33,6 @@
 #include <asm/resctrl_sched.h>
 #include "resctrl.h"
=20
-#define MBA_IS_LINEAR	0x4
-#define MBA_MAX_MBPS	U32_MAX
-
 /* Mutex to protect rdtgroup access. */
 DEFINE_MUTEX(rdtgroup_mutex);
=20
diff --git a/arch/x86/kernel/cpu/resctrl.h b/arch/x86/kernel/cpu/resctrl.h
index abf5c7e4c625..e5f7bf6a8d09 100644
--- a/arch/x86/kernel/cpu/resctrl.h
+++ b/arch/x86/kernel/cpu/resctrl.h
@@ -12,6 +12,9 @@
 #define IA32_L2_CBM_BASE	0xd10
 #define IA32_MBA_THRTL_BASE	0xd50
=20
+#define IA32_QM_CTR		0x0c8e
+#define IA32_QM_EVTSEL		0x0c8d
+
 #define L3_QOS_CDP_ENABLE	0x01ULL
=20
 #define L2_QOS_CDP_ENABLE	0x01ULL
@@ -29,6 +32,8 @@
 #define MBM_CNTR_WIDTH			24
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
+#define MBA_IS_LINEAR			0x4
+#define MBA_MAX_MBPS			U32_MAX
=20
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
diff --git a/arch/x86/kernel/cpu/resctrl_monitor.c b/arch/x86/kernel/cpu/re=
sctrl_monitor.c
index 68dbdbbf47df..ad0107bc16a0 100644
--- a/arch/x86/kernel/cpu/resctrl_monitor.c
+++ b/arch/x86/kernel/cpu/resctrl_monitor.c
@@ -28,9 +28,6 @@
 #include <asm/cpu_device_id.h>
 #include "resctrl.h"
=20
-#define MSR_IA32_QM_CTR		0x0c8e
-#define MSR_IA32_QM_EVTSEL		0x0c8d
-
 struct rmid_entry {
 	u32				rmid;
 	int				busy;
@@ -97,8 +94,8 @@ static u64 __rmid_read(u32 rmid, u32 eventid)
 	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
 	 * are error bits.
 	 */
-	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
-	rdmsrl(MSR_IA32_QM_CTR, val);
+	wrmsr(IA32_QM_EVTSEL, eventid, rmid);
+	rdmsrl(IA32_QM_CTR, val);
=20
 	return val;
 }
--=20
2.17.1

