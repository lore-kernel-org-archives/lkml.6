Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD3ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F42E214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tRtSSUqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F42E214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbeIYBWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:22:47 -0400
Received: from mail-eopbgr690052.outbound.protection.outlook.com ([40.107.69.52]:6650
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732289AbeIYBWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r83cwQyrBfpZQIvnQs3FljSQ6YNQMFNUY5RyTP1Ot/s=;
 b=tRtSSUqW/+DOZ5hYZvIIBoaVu16M4xQLBLOPL8vzXzXAqMEj9U4NC+qRVSdF+V7LsrE4E/GSHLiAxZskquL7SfcnlVDcWeIc6PEDST55AAQ2oQGcIAYH4h2/ql5jAVuGd6liGiRm8BErwkezN706Pf8QmiErPJo8nssWWE30d70=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1548.namprd12.prod.outlook.com (10.172.37.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 19:19:05 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de%5]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 19:19:05 +0000
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
Subject: [RFC PATCH 05/10] arch/x86: Use new config parameter PLATFORM_QOS for
 compilation
Thread-Topic: [RFC PATCH 05/10] arch/x86: Use new config parameter
 PLATFORM_QOS for compilation
Thread-Index: AQHUVDt1u0P6psZw/ESGt4VVVy41ww==
Date:   Mon, 24 Sep 2018 19:19:04 +0000
Message-ID: <20180924191841.29111-6-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1548;20:PUK0/l0vFb6JE7SY3S0gSt3aouZHlYsIZNojvhc3IdYzURckUur2jqI7aPuyxgdZ1UJXDJXPtdtS+LrMxJxLLcTq7Ht1bAAAzbFvwwVkNvyqw3sBC4SlBU4c1hc8u2o7+RkZ214bSmpN/NLiYuPwgm5pgdGCSOb7pzn5Ssbm5CGa1QDUtww2T6ZCco+hoaUV7p3Na7mNpPAC6L3SaRHXKnR7xXGtzIUnUDewH/bxY8+9oseSwwMrxt6CHhURbqgl
x-ms-office365-filtering-correlation-id: 3338d60b-f636-4113-16ae-08d622529777
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1548;
x-ms-traffictypediagnostic: DM5PR12MB1548:
x-microsoft-antispam-prvs: <DM5PR12MB1548AE4F8A735AD5F4D820AA95170@DM5PR12MB1548.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB1548;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1548;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(5250100002)(2501003)(186003)(4326008)(2900100001)(14454004)(6506007)(2906002)(386003)(256004)(316002)(53936002)(76176011)(68736007)(102836004)(36756003)(105586002)(99286004)(14444005)(97736004)(106356001)(81156014)(8936002)(5660300001)(476003)(110136005)(81166006)(1076002)(26005)(71190400001)(7416002)(486006)(2201001)(6116002)(3846002)(6512007)(217873002)(478600001)(86362001)(305945005)(52116002)(8676002)(25786009)(66066001)(446003)(6436002)(72206003)(54906003)(11346002)(7736002)(6486002)(2616005)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1548;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RIDX5XDgkkU9k7ycwe2IBIf95BAaxXuNgD2Kx8f2pKzI0MImqjJG9Q/1upECJ4O9QH7vvWaqKfo3B21zMQu+W5lW+362gafcfVt9ytLEDdSnKm3QumwKNGYpW5UusNsm19I2dJHUe1FW5a90QFWzDorcJP2NPkWghEXYgdYz1Q5ecrMoO5pJGKgqHcTrzeWKzkDUKZRYq9Ylm9Pb/DOxYUru4CQvi302FREab49k78BcQFf4fbnYeB4JO7RBn08YQ/Nuf2J81aTNSH6HhnoV3bnYAl3Ko/X/s8CdBGVCUfy/zBywMVrLNS0oL03uHZaZoR5R5o3jvnXMiBMLOMx//WmPfkmq529//7qgAHVjpeY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3338d60b-f636-4113-16ae-08d622529777
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 19:19:04.8924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use newly added config parameter PLATFORM_QOS to compile sources.
This is common parameter across both Intel and AMD.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/rdt_sched.h | 4 ++--
 arch/x86/kernel/cpu/Makefile     | 4 ++--
 include/linux/sched.h            | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/rdt_sched.h b/arch/x86/include/asm/rdt_sc=
hed.h
index 666bf9acb41d..6018a362d1cf 100644
--- a/arch/x86/include/asm/rdt_sched.h
+++ b/arch/x86/include/asm/rdt_sched.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_RDT_SCHED_H
 #define _ASM_X86_RDT_SCHED_H
=20
-#ifdef CONFIG_INTEL_RDT
+#ifdef CONFIG_PLATFORM_QOS
=20
 #include <linux/sched.h>
 #include <linux/jump_label.h>
@@ -88,6 +88,6 @@ static inline void rdt_sched_in(void)
=20
 static inline void rdt_sched_in(void) {}
=20
-#endif /* CONFIG_INTEL_RDT */
+#endif /* CONFIG_PLATFORM_QOS */
=20
 #endif /* _ASM_X86_RDT_SCHED_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 6c35d89f174f..8655adc84f11 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -35,8 +35,8 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+=3D centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+=3D transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+=3D umc.o
=20
-obj-$(CONFIG_INTEL_RDT)	+=3D rdt.o rdt_rdtgroup.o rdt_monitor.o
-obj-$(CONFIG_INTEL_RDT)	+=3D rdt_ctrlmondata.o rdt_pseudo_lock.o
+obj-$(CONFIG_PLATFORM_QOS)	+=3D rdt.o rdt_rdtgroup.o rdt_monitor.o
+obj-$(CONFIG_PLATFORM_QOS)	+=3D rdt_ctrlmondata.o rdt_pseudo_lock.o
 CFLAGS_rdt_pseudo_lock.o =3D -I$(src)
=20
 obj-$(CONFIG_X86_MCE)			+=3D mcheck/
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57d7bc9..1a4d00b7a5b1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -985,7 +985,7 @@ struct task_struct {
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
 #endif
-#ifdef CONFIG_INTEL_RDT
+#ifdef CONFIG_PLATFORM_QOS
 	u32				closid;
 	u32				rmid;
 #endif
--=20
2.17.1

