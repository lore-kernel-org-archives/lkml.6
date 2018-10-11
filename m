Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580E2C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABBD20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CcJj2hQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABBD20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJLECz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:02:55 -0400
Received: from mail-eopbgr730048.outbound.protection.outlook.com ([40.107.73.48]:63968
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725742AbeJLECy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc+s/iSR5nXT5ugLWFMGlNwEZhkRF55FbYM/omSxytk=;
 b=CcJj2hQoictWziKLfyCPvkxA6wsfPHieFFzkgKDesYeFYSvnax/ymSnW7oErBH1SNrzL9QCeNtjwBF1e7pB0OntMBUGUkrnDCFzvsmxslYpSwhwvrNziqGDEArczj+LfuTCMfMVjRdh6wkt3Qr9xR24VNS1z2ctCgvL89skWOxw=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.141.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Thu, 11 Oct 2018 20:33:16 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 20:33:16 +0000
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
Subject: [PATCH v3 04/11] arch/x86: Bring all the macros to resctrl.h
Thread-Topic: [PATCH v3 04/11] arch/x86: Bring all the macros to resctrl.h
Thread-Index: AQHUYaGj9B4XGjTP+E61ywGb6sfEIQ==
Date:   Thu, 11 Oct 2018 20:33:16 +0000
Message-ID: <20181011203223.18157-5-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2440;20:7KOGNcXfZQS5sSRgBZEq3Ck/GOXpWN+HvsZQjRPlplGtXjXGa/+HnASdI7SQN/EEwT2FN+pw2/b2fMhWp03rjNPcpgm8TBgm5k5IRp0QW7QlqnWpAJBqzj9/7MQYpn+Jb9K0gfY51W5NkuunRi8yCqIr6HtJ+j2majofbZXcAwNFbrBjkJKihfihxdaTtwhuxvllrRTAED1AAtVcZhV0G2Hhdu+BxZvnFtmUnhb8bh/vxEGBmVV4NDW2amha7dyx
x-ms-office365-filtering-correlation-id: 5baf8c48-9351-4417-6449-08d62fb8c5e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2440;
x-ms-traffictypediagnostic: DM5PR12MB2440:
x-microsoft-antispam-prvs: <DM5PR12MB2440F3F9D2DAA433DBA8EAFC95E10@DM5PR12MB2440.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DM5PR12MB2440;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2440;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(53936002)(76176011)(6486002)(478600001)(99286004)(52116002)(4326008)(6512007)(81166006)(6436002)(81156014)(5250100002)(8676002)(14454004)(2501003)(446003)(26005)(102836004)(2906002)(186003)(3846002)(6116002)(1076002)(7736002)(305945005)(7416002)(54906003)(486006)(97736004)(11346002)(476003)(2616005)(2900100001)(8936002)(106356001)(316002)(110136005)(575784001)(86362001)(256004)(25786009)(386003)(6506007)(66066001)(36756003)(72206003)(2201001)(71200400001)(71190400001)(5660300001)(68736007)(14444005)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2440;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AGHEbp5+KujZTrrzBBt+9oGrE0RdyiJeZ8nVa5W0CKzyNlkftVaWh4HSvdWpCjTh6cg6Il3Xr6ZkDaUVenq0LnXlt3kQaT6OjQ45Qe/er49GaWa+aEXZZyKY+ypkcbLCGJg6svvcpuX6qwYbQANLSD7BLC9ZzDDcgFfCcfDmeSUqo+mvQn4sPPviooKANxIiZ4Td5RZuceYTEl+Cl+ydEu+R8ALW97cT16sRDBVLrpKi8dhkg+/rhaod8bFSSJhJoKKAiduGoNkDEk2h6VT9sc7zT3XrZhTyrkoJFxXWHpzWVECe0+WfyiGddUqhHOmxSSQRCim+IEhrySAO2cO5JpXHrEy6Clc0vqsRxFb9J78=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baf8c48-9351-4417-6449-08d62fb8c5e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 20:33:16.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
index 2c564301e008..9c5480750069 100644
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

