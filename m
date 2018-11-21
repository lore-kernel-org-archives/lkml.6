Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C972EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D63214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PgeYxgsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D63214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbeKVHFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:05:17 -0500
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:42050
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732611AbeKVHEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibdQW+MZVn/+vDNBj2ZNQYmSh3/8F2i0NAeQC9BXwrM=;
 b=PgeYxgsw9rnc/H9SqD3WZEs+z1nRcwbilzBGrMiIuPuPTZc9y1tnbNK6s83eYumMEgu+aqNsLG147yvhUJITjf6t3bDxqVLEIOSoJWuWCNBk00WkShVg/jx6BO2KhZ4xsO/Uql0tVJCy/wOJV6pQynABtfvTuAFOLFpwQHbVzIw=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1610.namprd12.prod.outlook.com (10.172.40.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 20:28:39 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 20:28:39 +0000
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
Subject: [PATCH v9 08/13] x86/resctrl: Rename config parameter INTEL_RDT to
 RESCTRL
Thread-Topic: [PATCH v9 08/13] x86/resctrl: Rename config parameter INTEL_RDT
 to RESCTRL
Thread-Index: AQHUgdjJDk+O+V3h6k2SGuqiYf8Psw==
Date:   Wed, 21 Nov 2018 20:28:39 +0000
Message-ID: <20181121202811.4492-9-babu.moger@amd.com>
References: <20181121202811.4492-1-babu.moger@amd.com>
In-Reply-To: <20181121202811.4492-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0084.prod.exchangelabs.com (2603:10b6:800::52) To
 DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1610;20:lLLSXWyuNq+z9RfWLKk59uKVO5YbmHFjmHL4qmKLD+KQRnRLWak+UHO8HEWvrEKhzubOr96Dr35kETOuHfXMd/HGzqnRsgtl5MdW+DBLsonEecEntIlROPvM3y8jJFk4ZeQMVtpfP3VD/aKaBtOSYAz5+k6iTCmNCzD6rCAB7eO2txXAZGv7UmATls1BtW/ng5RfkLk6AASL2kOupbh7U9Yhp+2K5JSnVN82ougmhSjDiCtM5XN41uGwmAK03uW+
x-ms-office365-filtering-correlation-id: aa41b9c8-ff23-4ba9-29aa-08d64fefec07
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1610;
x-ms-traffictypediagnostic: DM5PR12MB1610:
x-microsoft-antispam-prvs: <DM5PR12MB161095EB4C5C472F2F0B2C4495DA0@DM5PR12MB1610.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231442)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1610;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(11346002)(305945005)(53936002)(2900100001)(8936002)(97736004)(81166006)(81156014)(14454004)(6512007)(478600001)(6116002)(2501003)(3846002)(25786009)(1076002)(4326008)(72206003)(2906002)(105586002)(110136005)(106356001)(446003)(2616005)(316002)(86362001)(8676002)(36756003)(6436002)(5660300001)(486006)(68736007)(6486002)(99286004)(256004)(52116002)(54906003)(76176011)(71200400001)(71190400001)(102836004)(6506007)(186003)(476003)(7736002)(386003)(7416002)(26005)(2201001)(66066001)(14444005)(575784001)(7406005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1610;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rqgwKyvNfoOOZULIZyogANY72rXC2uSehsgHKxgWfVAIjs05Xyo0d3tj8XeFvwIhLLlcVcjk+4Pm6gwKswUQY5JZ9sqgctDYih3EqXU9YzC2OJOwUt0wieSNc2il90FYcvLmHX8KTrXRyG8zwf66JBBMBIBqzSVtPKTsNPhiVhPAPNYNI/tGIo+CRleZpkXMWjilZQ+9bVvDCQa3qMA8opqA6sjjpjXr4X3dwkQIGHF+BtN0O6cqraJykk/SGrGN/GqvPEDaFZ/XbjkUEfU8/5KcG2lzoxF2Lj6/8l2SSn41LiJEEe8Cbhz0WfpTIBY6uz0nmOcs1VzOVe+eSYzN4YDzjtB+kftSvtntZn8uFiQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa41b9c8-ff23-4ba9-29aa-08d64fefec07
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 20:28:39.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resource control feature is supported by both Intel and AMD.
So, rename the INTEL_RDT to vendor neutral RESCTRL.

Now CONFIG_RESCTRL will be used for both Intel and AMD to enable
Resource Control support. Update the texts in config and condition
accordingly.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/Kconfig                     | 23 ++++++++++++++++-------
 arch/x86/include/asm/resctrl_sched.h |  4 ++--
 arch/x86/kernel/cpu/Makefile         |  2 +-
 arch/x86/kernel/cpu/resctrl/Makefile |  4 ++--
 include/linux/sched.h                |  2 +-
 5 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..36aad997caf8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -445,16 +445,25 @@ config RETPOLINE
 	  code are eliminated. Since this includes the syscall entry path,
 	  it is not entirely pointless.
=20
-config INTEL_RDT
-	bool "Intel Resource Director Technology support"
+config RESCTRL
+	bool "Resource Control support"
 	default n
-	depends on X86 && CPU_SUP_INTEL
+	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
 	help
-	  Select to enable resource allocation and monitoring which are
-	  sub-features of Intel Resource Director Technology(RDT). More
-	  information about RDT can be found in the Intel x86
-	  Architecture Software Developer Manual.
+	  Select to enable Resource Control feature support.
+
+	  These features are intended to provide the support for the allocation
+	  and monitoring of the usage of certain system resources by one or more
+	  processors.
+
+	  Intel refers to this feature as Intel Resource Director Technology
+	  (Intel(R) RDT). More information about RDT can be found in the
+	  Intel x86 Architecture Software Developer Manual.
+
+	  AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
+	  More information about AMD QoS can be found in AMD64 Technology
+	  Platform Quality of Service Extensions manual.
=20
 	  Say N if unsure.
=20
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
index 7dba9d611541..88d00e2224a7 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_CPU_SUP_UMC_32)		+=3D umc.o
 obj-$(CONFIG_X86_MCE)			+=3D mcheck/
 obj-$(CONFIG_MTRR)			+=3D mtrr/
 obj-$(CONFIG_MICROCODE)			+=3D microcode/
-obj-$(CONFIG_INTEL_RDT)			+=3D resctrl/
+obj-$(CONFIG_RESCTRL)			+=3D resctrl/
=20
 obj-$(CONFIG_X86_LOCAL_APIC)		+=3D perfctr-watchdog.o
=20
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/res=
ctrl/Makefile
index 04c9fd67fb3e..86a98e52e22a 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -2,6 +2,6 @@
 # Makefile for resource control feature code
 #
=20
-obj-$(CONFIG_INTEL_RDT)	+=3D core.o rdtgroup.o monitor.o
-obj-$(CONFIG_INTEL_RDT)	+=3D ctrlmondata.o pseudo_lock.o
+obj-$(CONFIG_RESCTRL)	+=3D core.o rdtgroup.o monitor.o
+obj-$(CONFIG_RESCTRL)	+=3D ctrlmondata.o pseudo_lock.o
 CFLAGS_pseudo_lock.o =3D -I$(src)
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

