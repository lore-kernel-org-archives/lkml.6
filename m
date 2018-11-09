Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD6C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5B520827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3OL4PIkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5B520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeKJGe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:34:58 -0500
Received: from mail-eopbgr740074.outbound.protection.outlook.com ([40.107.74.74]:39808
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbeKJGe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9rRlHpBSex4QfJp4TCxeNlshgnsKYuz5jpHGmc9PxM=;
 b=3OL4PIkFH4veSKAxspaWIgPL3LKA6fzc3H2hHKbssSQ70VsYJionroA//qrRDXtk81Hz270PnstqXNKqxlkha+9R0/rc1ntuMGGleS8W9K5QolOUMCPVvoxHeH8xYbooJaIN4XNU3t+WtWLLtnNDeN2RcozwfGd446ydNgVe5sU=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1675.namprd12.prod.outlook.com (10.172.40.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Fri, 9 Nov 2018 20:52:33 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 20:52:33 +0000
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
Subject: [PATCH v7 05/13] arch/x86: Rename config parameter INTEL_RDT to
 RESCTRL
Thread-Topic: [PATCH v7 05/13] arch/x86: Rename config parameter INTEL_RDT to
 RESCTRL
Thread-Index: AQHUeG4jkwUagbuMaEC9NB4PZPOGrQ==
Date:   Fri, 9 Nov 2018 20:52:33 +0000
Message-ID: <20181109205153.14811-6-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1675;20:mJR8BEyf4nmcZtdmekp1o2OfdTZk/uvd5++HOGAXuiQX22jvXReA8paQu1jULOwlgAwzq/c9bQwDzuXrpfdofPUolw5OUz173x6cm8IYQgH/K7Cdf+3KX+p0EoTOQ/QFTtvMkF4NmP6SuGjsGyq2OdfFMcNsGbPnGI6MSXXun1JnXQBleI1vF60aJyL54R6qBwoZj2uLjgqn/dFfAxXiWhwVUihK46NrsGdH2byNDxMRt66Cg4kAH67W00Qhwvrp
x-ms-office365-filtering-correlation-id: a7650bf4-1374-4c70-5aab-08d64685456d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1675;
x-ms-traffictypediagnostic: DM5PR12MB1675:
x-microsoft-antispam-prvs: <DM5PR12MB1675705A9AFF01603A045A9595C60@DM5PR12MB1675.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1675;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1675;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(305945005)(4326008)(14454004)(6116002)(66066001)(72206003)(36756003)(105586002)(6486002)(3846002)(6436002)(102836004)(386003)(6506007)(6512007)(478600001)(99286004)(2906002)(5660300001)(25786009)(86362001)(2900100001)(68736007)(575784001)(2501003)(2201001)(26005)(11346002)(7406005)(81156014)(446003)(81166006)(486006)(476003)(2616005)(186003)(1076002)(52116002)(53936002)(8936002)(7736002)(106356001)(14444005)(256004)(110136005)(71200400001)(76176011)(71190400001)(8676002)(54906003)(316002)(7416002)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1675;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nD28ryUKakmSGVWFXEV9r0XDQB8eLxR6E8Az24HPZjAmAjqgRs/fi1MoMcdS5OTJw+ZaitZf5tmSx6FGCbXinh+jd0LolllFlrtKMo36DIjbXoj6Kd8XGlSHxKAU1fbke9fJEMkBApXpEutcR7R15S/31XH12Q0IZAGDl/bDlXwYwNKCe791HjMZPfljWNpcijCshPd2gFSh9oi2AEoXZmGF0j+v8oWgbn8wy89yF2w/kTBOqpgdT7foGtnmAr67jLxlUyksMLuhIgX1CdSqlqMHfPd0lpqvgXyZZ/JhoAbcIaC86rC7/f1oahcDABKVcH/GQdCR8oHDM/ABsKON07A9nPTcoDyJwOgexLDtUy4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7650bf4-1374-4c70-5aab-08d64685456d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 20:52:33.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
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

