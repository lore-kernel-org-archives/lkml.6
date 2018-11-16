Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45378C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006EE20883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tum0hG+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006EE20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbeKQHIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:08:52 -0500
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:47437
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729502AbeKQHIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9rRlHpBSex4QfJp4TCxeNlshgnsKYuz5jpHGmc9PxM=;
 b=tum0hG+kiFn9YcEKQo6bBv9kge0H8T6MW/a2BKP8CgR9QeasUdSPqh4JSwoIvjKV/vrDiIkkdRfIW9zhmkTz3cyqDO20vB7Rgd8yOKMBkCmPqcaQC8pcqpqPC0OwgtmifWO9V79FptfzpB0+RqD9lqPOJ4sKn3Dx6rsjPGiVzqk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1788.namprd12.prod.outlook.com (10.175.91.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Fri, 16 Nov 2018 20:54:31 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 20:54:31 +0000
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
Subject: [PATCH v8 05/13] arch/resctrl: Rename config parameter INTEL_RDT to
 RESCTRL
Thread-Topic: [PATCH v8 05/13] arch/resctrl: Rename config parameter INTEL_RDT
 to RESCTRL
Thread-Index: AQHUfe6S6lG2NdRHyEiL+FwaPftriQ==
Date:   Fri, 16 Nov 2018 20:54:30 +0000
Message-ID: <20181116205407.10457-6-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1788;20:H/K7FyBIcmzKyn63guBaF/yIc5Z2YBQGKaVTtwuJqfykcbs6oKrmQUZRUIVY5mhrW4biPo6ELuKAvYQzmEP2Tmq2xrZj0IzQIz0b4p6jFrf/q7FqOH0aQWV0GOdvO/jULj9f2Zghwj3BPeEFt8HQw3tG9Bv9udCB3+XQaReMrKomoVMpmno00J0t8RPEH6a0SlpcyHDdnXO3D94DbanPazKYeN7NZesZFjzQK+IsO+W8bLek0tHpGGLy2lucDm10
x-ms-office365-filtering-correlation-id: b1b519b3-e944-44b5-5368-08d64c05b482
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1788;
x-ms-traffictypediagnostic: DM5PR12MB1788:
x-microsoft-antispam-prvs: <DM5PR12MB1788D5994F64616FE6A5CD7D95DD0@DM5PR12MB1788.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231415)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1788;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1788;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(366004)(376002)(199004)(189003)(6486002)(7406005)(478600001)(316002)(7416002)(7736002)(53936002)(25786009)(3846002)(97736004)(6116002)(68736007)(6512007)(54906003)(14454004)(110136005)(71190400001)(6436002)(2201001)(106356001)(14444005)(1076002)(4326008)(72206003)(575784001)(105586002)(71200400001)(66066001)(36756003)(305945005)(256004)(5660300001)(86362001)(81156014)(6506007)(52116002)(2906002)(11346002)(476003)(2616005)(486006)(76176011)(102836004)(26005)(386003)(99286004)(8676002)(186003)(2501003)(2900100001)(446003)(8936002)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1788;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HGJblG5L0IE35w8htkFenPiJ814NDbxBXc2fkp19qMqqzJWFsycRWvqSIf4kxboOuLxsKh2tu0POVDaxLO5ulmEH63SEMac0dsJL5PhwTNJMqFiQqMALFcSNnM2DwZHclnd7shJrDBQa06sTNnenfEvPDbHYGfXrmpGIU+9axkr7qWv4fWzhMtqFZ4bqGQNjzt+HvTCKPLJm7kODFnVFm8gi1guRikDoFH4yLAES36jUy9cKuS8n510KjtkmiBXfqb50IAeaABUhVsnkS/ZWyCBC6+f2nxQLxEHfXVs8O+P+h7lCu5kCg0HSzI2mJHP9ud9ehrvr02/YiSihrwFcbXBnWmoJIOyDyYGvRamFLFE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b519b3-e944-44b5-5368-08d64c05b482
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 20:54:30.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now Resource control feature is supported by both Intel and AMD.
Rename the INTEL_RDT to vendor neutral RESCTRL.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/Kconfig                     | 4 ++--
 arch/x86/include/asm/resctrl_sched.h | 4 ++--
 arch/x86/kernel/cpu/Makefile         | 4 ++--
 include/linux/sched.h                | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..4aae7aba4d61 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -445,8 +445,8 @@ config RETPOLINE
 	  code are eliminated. Since this includes the syscall entry path,
 	  it is not entirely pointless.
=20
-config INTEL_RDT
-	bool "Intel Resource Director Technology support"
+config RESCTRL
+	bool "Resource Control feature support"
 	default n
 	depends on X86 && CPU_SUP_INTEL
 	select KERNFS
diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/re=
sctrl_sched.h
index 6e082697a613..54990fe2a3ae 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl_sched.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_RESCTRL_SCHED_H
 #define _ASM_X86_RESCTRL_SCHED_H
=20
-#ifdef CONFIG_INTEL_RDT
+#ifdef CONFIG_RESCTRL
=20
 #include <linux/sched.h>
 #include <linux/jump_label.h>
@@ -88,6 +88,6 @@ static inline void resctrl_sched_in(void)
=20
 static inline void resctrl_sched_in(void) {}
=20
-#endif /* CONFIG_INTEL_RDT */
+#endif /* CONFIG_RESCTRL */
=20
 #endif /* _ASM_X86_RESCTRL_SCHED_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 222cf8cc078d..79279953c5f9 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -35,8 +35,8 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+=3D centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+=3D transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+=3D umc.o
=20
-obj-$(CONFIG_INTEL_RDT)	+=3D resctrl.o resctrl_rdtgroup.o resctrl_monitor.=
o
-obj-$(CONFIG_INTEL_RDT)	+=3D resctrl_ctrlmondata.o resctrl_pseudo_lock.o
+obj-$(CONFIG_RESCTRL)	+=3D resctrl.o resctrl_rdtgroup.o resctrl_monitor.o
+obj-$(CONFIG_RESCTRL)	+=3D resctrl_ctrlmondata.o resctrl_pseudo_lock.o
 CFLAGS_resctrl_pseudo_lock.o =3D -I$(src)
=20
 obj-$(CONFIG_X86_MCE)			+=3D mcheck/
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57d7bc9..c4cf94c447b2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -985,7 +985,7 @@ struct task_struct {
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
 #endif
-#ifdef CONFIG_INTEL_RDT
+#ifdef CONFIG_RESCTRL
 	u32				closid;
 	u32				rmid;
 #endif
--=20
2.17.1

