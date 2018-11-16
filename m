Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275A6C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F932086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gCcRxDGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F932086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeKQHIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:08:51 -0500
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:47437
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729740AbeKQHIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc7SORPvf1F5SIBaxR8pl1oqP9s/lqp0LdSFSxkJMAM=;
 b=gCcRxDGUoi7EU3I9DM4RIHehrGFuMNasZeut3/FCAe2rKDFAzC+S6IzxFyK5lK0ObH7vfY/VU84ebZuqG1DxvI6Fxxo003IYNqwBGz+LbvRbYzOXLxctGKd6+ns+GVr+moimtl6VWpN/vk16K2m76dO8wc3iirul8ij5q1zStzQ=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1788.namprd12.prod.outlook.com (10.175.91.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Fri, 16 Nov 2018 20:54:28 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 20:54:28 +0000
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
Subject: [PATCH v8 04/13] arch/resctrl: Bring all the macros to resctrl.h
Thread-Topic: [PATCH v8 04/13] arch/resctrl: Bring all the macros to resctrl.h
Thread-Index: AQHUfe6Qs5vlQ6iqdk+YBrFobDu7Sw==
Date:   Fri, 16 Nov 2018 20:54:28 +0000
Message-ID: <20181116205407.10457-5-babu.moger@amd.com>
References: <20181116205407.10457-1-babu.moger@amd.com>
In-Reply-To: <20181116205407.10457-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:805:f2::18) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1788;20:OArg5B5ZQryjWtBZ2HT7YhHNlTYV+tIKbgUXxXOQOV9RO4lVyf+Lv6jzqmNJS9gpA4KMKxYPfPTFHW39hOWj5B050odOYN7oaCHXjqQUbCJoPit+Hx+mRZlMEnr2IOkZxgwLqHpeQicLfGYNlx9HH17zZFEidvhjYODAG65tfcma0YAy/8bskXfwVW2gjFQ8vL5+Bj+biseGHMkLotgrdAr5yXFvjv/nmZga1sp3y3krCQK37z3VQlKUEWiq6HJJ
x-ms-office365-filtering-correlation-id: 8a27d817-9223-4123-b89c-08d64c05b344
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1788;
x-ms-traffictypediagnostic: DM5PR12MB1788:
x-microsoft-antispam-prvs: <DM5PR12MB1788945845ED5405F5EC864995DD0@DM5PR12MB1788.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231415)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1788;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1788;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(366004)(376002)(199004)(189003)(6486002)(7406005)(478600001)(316002)(7416002)(7736002)(53936002)(25786009)(3846002)(97736004)(6116002)(68736007)(6512007)(54906003)(14454004)(110136005)(71190400001)(6436002)(2201001)(106356001)(14444005)(1076002)(4326008)(72206003)(575784001)(105586002)(71200400001)(66066001)(36756003)(305945005)(256004)(5660300001)(86362001)(81156014)(6506007)(52116002)(2906002)(11346002)(476003)(2616005)(486006)(76176011)(102836004)(26005)(386003)(99286004)(8676002)(186003)(2501003)(2900100001)(446003)(8936002)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1788;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: j5xM+RxPN27shWAzprYX1Ml0gL2viW/PIt07L0GidRkzkCPtZAGZb2kbFxwudf86/oN7txhnj11EfCt/Jvama/EWvYOMHZQ2Cxgy9osa3/P49XhxswXAyFvvh6XRuErl+WqsBUZ4DtLSxbdUYZlXHio0oBt/2MtRPlLN0xl0GnPgwrk3RbthMbNPjvV08rZYCgsKDWy5USRYJbwrRP6RPEzNblPDanale5NDIaZGtJcKK+1KNxKR9lybS2bLStVspovr4n86hp7AMmWKT0HPaWIeOiZNOyzgf3J+RuH+zu97l1uNYu2xFSXInlRnZH5jv2bG4HqmDwIh4mWTEfISnG+0EO1fh/DahJYcqVLGxh4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a27d817-9223-4123-b89c-08d64c05b344
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 20:54:28.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1788
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
index 4cea275c7c57..18c8222f326c 100644
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
index 6d654f7b0eba..9fd62263dabd 100644
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

