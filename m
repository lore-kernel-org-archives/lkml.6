Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54FFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06A321479
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Rt8i9rbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06A321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbeJFD40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:56:26 -0400
Received: from mail-eopbgr720071.outbound.protection.outlook.com ([40.107.72.71]:62615
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729319AbeJFD4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QEUG8bmkAG1PT78ZT12525D4bvdrCuNV4mgalmItTg=;
 b=Rt8i9rbAsxG7yF8SQcQ6/XGRuU0UaTsGfvcqUSDDHwNasHiXNxEL8Pf1qtFzGkbraXgiUYZM+XyQBScc4izpTY0ZAZ/BImlp76uRpXFsZXDdlZc7OTpldeNpajg1FKkCxGuY4+GEc5z9c0gtij9OHYSUSEocLCTw6QnkvlDKQrY=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2504.namprd12.prod.outlook.com (52.132.141.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Fri, 5 Oct 2018 20:55:49 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 20:55:49 +0000
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
Subject: [PATCH v2 04/11] arch/x86: Bring all the macros to rdt.h
Thread-Topic: [PATCH v2 04/11] arch/x86: Bring all the macros to rdt.h
Thread-Index: AQHUXO3LgAvfnhEnj0SaT9AACZMsaA==
Date:   Fri, 5 Oct 2018 20:55:49 +0000
Message-ID: <20181005205512.29545-5-babu.moger@amd.com>
References: <20181005205512.29545-1-babu.moger@amd.com>
In-Reply-To: <20181005205512.29545-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:404:b4::28) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2504;20:JkpnNGIUvx33VcKbbkeu7ISaSZgqV2LqELCMBKAjR3ysRVuiONbPo6rM82OBWe1rIlDTui8xIIAK0teFNHyZ2Ou4M3TLpciWfNLRkEmRuyw4rDXv/mW9RwIG5iGdAaA1eC7LMjnbHHTPpH+gYxhNI7K2A3qRiDhvc4fsaXKqHie7QhkYdHj85vQAxIUR8msj8DI+IS4IhoUUptF9Exc6GSgUmvPsqOn0CKUyxKTtZkD/i1NIP3OOueN7NB+Pv2J6
x-ms-office365-filtering-correlation-id: bdde1970-1b51-4763-b2c7-08d62b04edaf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2504;
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-microsoft-antispam-prvs: <DM5PR12MB25045CE222A300B72E177AF595EB0@DM5PR12MB2504.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302102)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:DM5PR12MB2504;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2504;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(110136005)(2201001)(256004)(36756003)(72206003)(102836004)(54906003)(14444005)(6512007)(305945005)(52116002)(25786009)(14454004)(53936002)(386003)(8936002)(478600001)(68736007)(105586002)(6506007)(66066001)(99286004)(86362001)(106356001)(2900100001)(575784001)(7416002)(4326008)(476003)(486006)(8676002)(6116002)(76176011)(3846002)(7736002)(71190400001)(71200400001)(316002)(2906002)(186003)(11346002)(2501003)(81156014)(81166006)(446003)(5660300001)(5250100002)(6486002)(6436002)(2616005)(97736004)(26005)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2504;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y9MBz+wZdfPB5NOcTU6DEwBcHrTRqUG+fwTNDet+IJ82CcFZSZKYKWEJCns4HILMFfQkmnyDvU+JAdq/BSn6uDJtVy0dovf2mwuvBS+7THHGNh7yvyCPmaBw4wAxGZwhHd8yU3aMXtlGnhS8CeWD2ZnG9Z4EbXCxvEjKi63d+vTa47UY5U0AFX8dTE7jvcJfXqo8OV5i23JQW3jAR+g5i/iv0f+X1ikqvcUiO/p9qyfjxbRMwSJDSkWYwh7AQMd53hLgjxuK5kjpa246dkOMsQ4LcbBml9oux6vb17+NeqiyqGoV+OxfYy8lUOMlQxNCq3hbqXQB71Q253v2WkUYp0smEn8f3sihuOQ1JSKAx9M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdde1970-1b51-4763-b2c7-08d62b04edaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 20:55:49.1300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring all the macros to rdt.h and rename for consistency.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/rdt.c         | 3 ---
 arch/x86/kernel/cpu/rdt.h         | 5 +++++
 arch/x86/kernel/cpu/rdt_monitor.c | 7 ++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
index c3ac7f9a3a0f..87fe073a0571 100644
--- a/arch/x86/kernel/cpu/rdt.c
+++ b/arch/x86/kernel/cpu/rdt.c
@@ -33,9 +33,6 @@
 #include <asm/rdt_sched.h>
 #include "rdt.h"
=20
-#define MBA_IS_LINEAR	0x4
-#define MBA_MAX_MBPS	U32_MAX
-
 /* Mutex to protect rdtgroup access. */
 DEFINE_MUTEX(rdtgroup_mutex);
=20
diff --git a/arch/x86/kernel/cpu/rdt.h b/arch/x86/kernel/cpu/rdt.h
index 1d7aa7e266af..8431af5c6825 100644
--- a/arch/x86/kernel/cpu/rdt.h
+++ b/arch/x86/kernel/cpu/rdt.h
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
diff --git a/arch/x86/kernel/cpu/rdt_monitor.c b/arch/x86/kernel/cpu/rdt_mo=
nitor.c
index 577514cd4a71..c8b95561f5be 100644
--- a/arch/x86/kernel/cpu/rdt_monitor.c
+++ b/arch/x86/kernel/cpu/rdt_monitor.c
@@ -28,9 +28,6 @@
 #include <asm/cpu_device_id.h>
 #include "rdt.h"
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

