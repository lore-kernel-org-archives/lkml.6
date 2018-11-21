Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702D4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24889214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y1zrOTFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24889214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeKVHEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:04:38 -0500
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:5747
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732611AbeKVHEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ2r+IkOEIvV19D9FdFDh6s43vIAyqMyV4rBwts+l5I=;
 b=y1zrOTFVDUgah028IuQ3TnjLS0CYO0oQHrXDoaDVDe9Uu+XTzikaMl88XGXgvzQHjir2sQoa6ERSgJwxyf4yfb5v+6y8B6LdIWNatEOx2HqoaAle/sFgj6V+iQhAS9p0tvYAq3wI7kgE3r96Tbn1MfB0bpc+HKrYIVkZWyPvmn0=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1610.namprd12.prod.outlook.com (10.172.40.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 20:28:26 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 20:28:26 +0000
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
Subject: [PATCH v9 01/13] x86/resctrl: Rename and move rdt files to new
 directory
Thread-Topic: [PATCH v9 01/13] x86/resctrl: Rename and move rdt files to new
 directory
Thread-Index: AQHUgdjBl2NrXd2UBk6UhSXC0jUGsQ==
Date:   Wed, 21 Nov 2018 20:28:25 +0000
Message-ID: <20181121202811.4492-2-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1610;20:Ze0jEWSVhzOocnLVAbiuCyxWMduj19yPZ0E6K+XBTKv+6r2MKotWNqbxOIFkKgqG355ti793WSznhsxYu4ZmpPzx8lvzoFaZvBN/kk7mJgXpJw2s/pIS/7kEoFO7UHLARP4ngzkSRGNXu4ZOKTv62WUfe+qq7hInsqEppniADs+6kCXcNO4tGqQHKB8nHIK9VMaMprcGbdkVj2h/CPfwAfQfp0WlLRt55+u/bzJIUtw6H9rCzU3EUeOJ/j+/rTmE
x-ms-office365-filtering-correlation-id: f22fe41e-054f-4460-6129-08d64fefe3c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1610;
x-ms-traffictypediagnostic: DM5PR12MB1610:
x-microsoft-antispam-prvs: <DM5PR12MB1610BBAB0FEF0B8B7A7BAB1F95DA0@DM5PR12MB1610.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231442)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1610;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(54906003)(76176011)(52116002)(256004)(71200400001)(71190400001)(5660300001)(6436002)(36756003)(68736007)(6486002)(99286004)(486006)(7416002)(26005)(2201001)(575784001)(66066001)(14444005)(7406005)(102836004)(6506007)(186003)(386003)(476003)(7736002)(6512007)(3846002)(2501003)(6116002)(478600001)(2900100001)(8936002)(305945005)(11346002)(53936002)(14454004)(97736004)(81156014)(81166006)(316002)(2616005)(110136005)(105586002)(446003)(106356001)(86362001)(8676002)(1076002)(25786009)(72206003)(4326008)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1610;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BiaTi0/P/p4LP3pGG6ChqHpHE+DojfAn28QSKpTLyr/r54NXKt0imRVfhtFjOlnVJmw4fTuvoz8qPph7AKzji3wACsNuyGjIcs5p50/kT67CVNjc4czsfzw/RDYKeohVrpIuyah6mWSMYBVx9I5z4ZunK8qtzgJqpiH7wf4wRqiqqlmvAD308ty8sfaTEtCx1cXx7N+GcZgAvM5ggHCO6HQM7YzyGq9I2mTY/GgyHXEWi3H8ylDz9cpJO2bmTXpFvEIJiqPiDVxE/22amfoyh8XAUvw+3KHWBAhV9hMrE37FwxTdcYc2UVm8mPyvtTfN7JQLhpxpnQu3hLHSXSevXq9nVmo19JULJQlH1ecow+0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22fe41e-054f-4460-6129-08d64fefe3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 20:28:25.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New generation of AMD processors start supporting RDT(or QOS)
features. Together these features will be called as RESCTRL.
With more than one vendors supporting these features, it seems
more appropriate to rename these files.

Create a new directory with the name 'resctrl' and move all the
intel_rdt files to the new directory. This way all the resctrl
related code resides inside one directory.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 .../x86/include/asm/{intel_rdt_sched.h =3D> resctrl_sched.h} | 0
 arch/x86/kernel/cpu/Makefile                               | 5 +----
 arch/x86/kernel/cpu/resctrl/Makefile                       | 7 +++++++
 arch/x86/kernel/cpu/{intel_rdt.c =3D> resctrl/core.c}        | 4 ++--
 .../cpu/{intel_rdt_ctrlmondata.c =3D> resctrl/ctrlmondata.c} | 2 +-
 arch/x86/kernel/cpu/{intel_rdt.h =3D> resctrl/internal.h}    | 6 +++---
 .../kernel/cpu/{intel_rdt_monitor.c =3D> resctrl/monitor.c}  | 2 +-
 .../cpu/{intel_rdt_pseudo_lock.c =3D> resctrl/pseudo_lock.c} | 6 +++---
 .../pseudo_lock_event.h}                                   | 2 +-
 .../cpu/{intel_rdt_rdtgroup.c =3D> resctrl/rdtgroup.c}       | 4 ++--
 arch/x86/kernel/process_32.c                               | 2 +-
 arch/x86/kernel/process_64.c                               | 2 +-
 12 files changed, 23 insertions(+), 19 deletions(-)
 rename arch/x86/include/asm/{intel_rdt_sched.h =3D> resctrl_sched.h} (100%=
)
 create mode 100644 arch/x86/kernel/cpu/resctrl/Makefile
 rename arch/x86/kernel/cpu/{intel_rdt.c =3D> resctrl/core.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c =3D> resctrl/ctrlmonda=
ta.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt.h =3D> resctrl/internal.h} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_monitor.c =3D> resctrl/monitor.c} (9=
9%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c =3D> resctrl/pseudo_lo=
ck.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h =3D> resctrl/pse=
udo_lock_event.h} (95%)
 rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c =3D> resctrl/rdtgroup.c} =
(99%)

diff --git a/arch/x86/include/asm/intel_rdt_sched.h b/arch/x86/include/asm/=
resctrl_sched.h
similarity index 100%
rename from arch/x86/include/asm/intel_rdt_sched.h
rename to arch/x86/include/asm/resctrl_sched.h
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 347137e80bf5..7dba9d611541 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -35,13 +35,10 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+=3D centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+=3D transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+=3D umc.o
=20
-obj-$(CONFIG_INTEL_RDT)	+=3D intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_mo=
nitor.o
-obj-$(CONFIG_INTEL_RDT)	+=3D intel_rdt_ctrlmondata.o intel_rdt_pseudo_lock=
.o
-CFLAGS_intel_rdt_pseudo_lock.o =3D -I$(src)
-
 obj-$(CONFIG_X86_MCE)			+=3D mcheck/
 obj-$(CONFIG_MTRR)			+=3D mtrr/
 obj-$(CONFIG_MICROCODE)			+=3D microcode/
+obj-$(CONFIG_INTEL_RDT)			+=3D resctrl/
=20
 obj-$(CONFIG_X86_LOCAL_APIC)		+=3D perfctr-watchdog.o
=20
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/res=
ctrl/Makefile
new file mode 100644
index 000000000000..04c9fd67fb3e
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for resource control feature code
+#
+
+obj-$(CONFIG_INTEL_RDT)	+=3D core.o rdtgroup.o monitor.o
+obj-$(CONFIG_INTEL_RDT)	+=3D ctrlmondata.o pseudo_lock.o
+CFLAGS_pseudo_lock.o =3D -I$(src)
diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/resctrl/=
core.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt.c
rename to arch/x86/kernel/cpu/resctrl/core.c
index 44272b7107ad..27c4316bb691 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -30,8 +30,8 @@
 #include <linux/cpuhotplug.h>
=20
 #include <asm/intel-family.h>
-#include <asm/intel_rdt_sched.h>
-#include "intel_rdt.h"
+#include <asm/resctrl_sched.h>
+#include "internal.h"
=20
 #define MBA_IS_LINEAR	0x4
 #define MBA_MAX_MBPS	U32_MAX
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/=
cpu/resctrl/ctrlmondata.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
rename to arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 27937458c231..407d2179bfcb 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -26,7 +26,7 @@
 #include <linux/kernfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include "intel_rdt.h"
+#include "internal.h"
=20
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/resctrl/=
internal.h
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt.h
rename to arch/x86/kernel/cpu/resctrl/internal.h
index 3736f6dc9545..1b36709591d8 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_INTEL_RDT_H
-#define _ASM_X86_INTEL_RDT_H
+#ifndef _ASM_X86_RESCTRL_INTERNAL_H
+#define _ASM_X86_RESCTRL_INTERNAL_H
=20
 #include <linux/sched.h>
 #include <linux/kernfs.h>
@@ -568,4 +568,4 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
=20
-#endif /* _ASM_X86_INTEL_RDT_H */
+#endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/=
resctrl/monitor.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_monitor.c
rename to arch/x86/kernel/cpu/resctrl/monitor.c
index b0f3aed76b75..d492d4c0e8cc 100644
--- a/arch/x86/kernel/cpu/intel_rdt_monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -26,7 +26,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
-#include "intel_rdt.h"
+#include "internal.h"
=20
 #define MSR_IA32_QM_CTR		0x0c8e
 #define MSR_IA32_QM_EVTSEL		0x0c8d
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/=
cpu/resctrl/pseudo_lock.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
rename to arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 966ac0c20d67..27d75c328d58 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -24,14 +24,14 @@
=20
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/resctrl_sched.h>
 #include <asm/perf_event.h>
=20
 #include "../../events/perf_event.h" /* For X86_CONFIG() */
-#include "intel_rdt.h"
+#include "internal.h"
=20
 #define CREATE_TRACE_POINTS
-#include "intel_rdt_pseudo_lock_event.h"
+#include "pseudo_lock_event.h"
=20
 /*
  * MSR_MISC_FEATURE_CONTROL register enables the modification of hardware
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h b/arch/x86/k=
ernel/cpu/resctrl/pseudo_lock_event.h
similarity index 95%
rename from arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
rename to arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
index 2c041e6d9f05..428ebbd4270b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
@@ -39,5 +39,5 @@ TRACE_EVENT(pseudo_lock_l3,
=20
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE intel_rdt_pseudo_lock_event
+#define TRACE_INCLUDE_FILE pseudo_lock_event
 #include <trace/define_trace.h>
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl/rdtgroup.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
rename to arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f27b8115ffa2..f5a76ca43f0f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -35,8 +35,8 @@
=20
 #include <uapi/linux/magic.h>
=20
-#include <asm/intel_rdt_sched.h>
-#include "intel_rdt.h"
+#include <asm/resctrl_sched.h>
+#include "internal.h"
=20
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5046a3c9dec2..d16207e7d1e5 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -56,7 +56,7 @@
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/resctrl_sched.h>
 #include <asm/proto.h>
=20
 void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ea5ea850348d..af73223ad6ba 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -52,7 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/resctrl_sched.h>
 #include <asm/unistd.h>
 #ifdef CONFIG_IA32_EMULATION
 /* Not included via unistd.h */
--=20
2.17.1

