Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A8EECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79D4204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NsXoviET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79D4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJSGzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:55:20 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:52049
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbeJSGzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY6JzK22kpiong5lSlaGxlX2H50xvQehKAfOlKntON8=;
 b=NsXoviET5hYw2hz5CZ2r0wQDG5Q2H0fIAj81H0BwedqC7wVOGEFKR589zjg5PZ9JltmkGJvd8sw0/x0cLTn45TbNT8HvGjCg+7VJpjAzU9pROSva/mstGx9Jpb4YYwmKUv9eerF3heTpYtL2GUveK0v/x5TsGVjuZwZeFSRh5gI=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1818.namprd12.prod.outlook.com (10.175.91.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Thu, 18 Oct 2018 22:52:03 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.028; Thu, 18 Oct 2018
 22:52:03 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v5 01/13] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Topic: [PATCH v5 01/13] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Index: AQHUZzUvI61B+FGrjUadJKac7DOK7A==
Date:   Thu, 18 Oct 2018 22:52:03 +0000
Message-ID: <20181018225124.23043-2-babu.moger@amd.com>
References: <20181018225124.23043-1-babu.moger@amd.com>
In-Reply-To: <20181018225124.23043-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0044.namprd02.prod.outlook.com
 (2603:10b6:803:2e::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1818;20:ZUzfHJFgjK7Qsdvv2HDsIxNYJpN/NJ+qRuCCUxmrpzqRc8FM7ou7PmZGXjOYpyW0LBF9BXAuQHY8ViSBQ6SNEJh1EK64uzPZFXkVkPqnenFIL4gAqG9Os8VSXNK1lLxzkQrZwni35IVxjGnBspAVF2JN6jYu5B5sKJldjqKeZCW8PoyYF4KdOp3UY5Gx2Js9+e6ZkDfUy92KKX04Od9+Kudkw3/DARqCHsic9YiF9mPZ4KtnN11K5Ud9n+/vsQEi
x-ms-office365-filtering-correlation-id: 7f0dc2b4-3c8c-40c4-bf6e-08d6354c51e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1818;
x-ms-traffictypediagnostic: DM5PR12MB1818:
x-microsoft-antispam-prvs: <DM5PR12MB1818E1042C8C31F7D74C36E395F80@DM5PR12MB1818.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1818;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1818;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(110136005)(478600001)(2201001)(8936002)(5660300001)(7406005)(14454004)(7416002)(1076002)(6486002)(6512007)(5250100002)(6436002)(68736007)(72206003)(54906003)(66066001)(106356001)(3846002)(186003)(26005)(86362001)(2616005)(2906002)(476003)(99286004)(81166006)(102836004)(81156014)(6116002)(53936002)(486006)(52116002)(446003)(36756003)(76176011)(386003)(316002)(2501003)(7736002)(11346002)(6506007)(8676002)(2900100001)(25786009)(575784001)(305945005)(71200400001)(71190400001)(105586002)(14444005)(256004)(97736004)(4326008)(41533002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1818;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Smax+hTGTB6L1S0vmD7lSGRwmltPwJftOjPiY6qS6inoLndMA/bB4o43G1ypmG0tMqvloH9bMn7T0YjGDRbz1FnK6s6lQAK6AZbmnDvgrYIko3lHl8OfLhdpCjqZkubKSfwUovRTnAlazb7lC8FraSUSJrkdp/fcbBjXEo7HmI3DifC0yoxM2+8bTCV3MHcZiuj6801lxo4gu9e46MfoHtROJMufI9vM/q1/2S1Mw1q7rz9LXd9t6CMLGYoSk9nECoZzF/iKEDwTMTfs0eHtjKFcgPEBMAsJImrK9dlqMCuFpM6xew+eYfVWNOEYtxQXxvh+HmUlztfdBqpKs11C7ukZdMxiI7QOKWON8K4oTwk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0dc2b4-3c8c-40c4-bf6e-08d6354c51e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 22:52:03.3572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New generation of AMD processors start supporting RDT(or QOS) features.
With more than one vendors supporting these features, it seems more
appropriate to rename these files.

Changed intel_rdt to resctrl where applicable.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/{intel_rdt_sched.h =3D> resctrl_sched.h} | 0
 arch/x86/kernel/cpu/Makefile                                | 6 +++---
 arch/x86/kernel/cpu/{intel_rdt.c =3D> resctrl.c}              | 4 ++--
 arch/x86/kernel/cpu/{intel_rdt.h =3D> resctrl.h}              | 6 +++---
 .../cpu/{intel_rdt_ctrlmondata.c =3D> resctrl_ctrlmondata.c}  | 2 +-
 .../kernel/cpu/{intel_rdt_monitor.c =3D> resctrl_monitor.c}   | 2 +-
 .../cpu/{intel_rdt_pseudo_lock.c =3D> resctrl_pseudo_lock.c}  | 6 +++---
 ..._rdt_pseudo_lock_event.h =3D> resctrl_pseudo_lock_event.h} | 2 +-
 .../kernel/cpu/{intel_rdt_rdtgroup.c =3D> resctrl_rdtgroup.c} | 4 ++--
 arch/x86/kernel/process_32.c                                | 2 +-
 arch/x86/kernel/process_64.c                                | 2 +-
 11 files changed, 18 insertions(+), 18 deletions(-)
 rename arch/x86/include/asm/{intel_rdt_sched.h =3D> resctrl_sched.h} (100%=
)
 rename arch/x86/kernel/cpu/{intel_rdt.c =3D> resctrl.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt.h =3D> resctrl.h} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c =3D> resctrl_ctrlmonda=
ta.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_monitor.c =3D> resctrl_monitor.c} (9=
9%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c =3D> resctrl_pseudo_lo=
ck.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h =3D> resctrl_pse=
udo_lock_event.h} (95%)
 rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c =3D> resctrl_rdtgroup.c} =
(99%)

diff --git a/arch/x86/include/asm/intel_rdt_sched.h b/arch/x86/include/asm/=
resctrl_sched.h
similarity index 100%
rename from arch/x86/include/asm/intel_rdt_sched.h
rename to arch/x86/include/asm/resctrl_sched.h
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 347137e80bf5..222cf8cc078d 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -35,9 +35,9 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+=3D centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+=3D transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+=3D umc.o
=20
-obj-$(CONFIG_INTEL_RDT)	+=3D intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_mo=
nitor.o
-obj-$(CONFIG_INTEL_RDT)	+=3D intel_rdt_ctrlmondata.o intel_rdt_pseudo_lock=
.o
-CFLAGS_intel_rdt_pseudo_lock.o =3D -I$(src)
+obj-$(CONFIG_INTEL_RDT)	+=3D resctrl.o resctrl_rdtgroup.o resctrl_monitor.=
o
+obj-$(CONFIG_INTEL_RDT)	+=3D resctrl_ctrlmondata.o resctrl_pseudo_lock.o
+CFLAGS_resctrl_pseudo_lock.o =3D -I$(src)
=20
 obj-$(CONFIG_X86_MCE)			+=3D mcheck/
 obj-$(CONFIG_MTRR)			+=3D mtrr/
diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/resctrl.=
c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt.c
rename to arch/x86/kernel/cpu/resctrl.c
index 1214f3f7ec6d..3968b54902b1 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/resctrl.c
@@ -30,8 +30,8 @@
 #include <linux/cpuhotplug.h>
=20
 #include <asm/intel-family.h>
-#include <asm/intel_rdt_sched.h>
-#include "intel_rdt.h"
+#include <asm/resctrl_sched.h>
+#include "resctrl.h"
=20
 #define MBA_IS_LINEAR	0x4
 #define MBA_MAX_MBPS	U32_MAX
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/resctrl.=
h
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt.h
rename to arch/x86/kernel/cpu/resctrl.h
index 3736f6dc9545..a9d906767bb2 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/resctrl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_INTEL_RDT_H
-#define _ASM_X86_INTEL_RDT_H
+#ifndef _ASM_X86_RESCTRL_H
+#define _ASM_X86_RESCTRL_H
=20
 #include <linux/sched.h>
 #include <linux/kernfs.h>
@@ -568,4 +568,4 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
=20
-#endif /* _ASM_X86_INTEL_RDT_H */
+#endif /* _ASM_X86_RESCTRL_H */
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/=
cpu/resctrl_ctrlmondata.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
rename to arch/x86/kernel/cpu/resctrl_ctrlmondata.c
index 0f53049719cd..0c40a2e0a9b6 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl_ctrlmondata.c
@@ -26,7 +26,7 @@
 #include <linux/kernfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include "intel_rdt.h"
+#include "resctrl.h"
=20
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/=
resctrl_monitor.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_monitor.c
rename to arch/x86/kernel/cpu/resctrl_monitor.c
index b0f3aed76b75..211d97bcbde5 100644
--- a/arch/x86/kernel/cpu/intel_rdt_monitor.c
+++ b/arch/x86/kernel/cpu/resctrl_monitor.c
@@ -26,7 +26,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
-#include "intel_rdt.h"
+#include "resctrl.h"
=20
 #define MSR_IA32_QM_CTR		0x0c8e
 #define MSR_IA32_QM_EVTSEL		0x0c8d
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/=
cpu/resctrl_pseudo_lock.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
rename to arch/x86/kernel/cpu/resctrl_pseudo_lock.c
index 41aeb431e834..67c747b6c61e 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl_pseudo_lock.c
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
+#include "resctrl.h"
=20
 #define CREATE_TRACE_POINTS
-#include "intel_rdt_pseudo_lock_event.h"
+#include "resctrl_pseudo_lock_event.h"
=20
 /*
  * MSR_MISC_FEATURE_CONTROL register enables the modification of hardware
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h b/arch/x86/k=
ernel/cpu/resctrl_pseudo_lock_event.h
similarity index 95%
rename from arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
rename to arch/x86/kernel/cpu/resctrl_pseudo_lock_event.h
index 2c041e6d9f05..d354851ed66c 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/resctrl_pseudo_lock_event.h
@@ -39,5 +39,5 @@ TRACE_EVENT(pseudo_lock_l3,
=20
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE intel_rdt_pseudo_lock_event
+#define TRACE_INCLUDE_FILE resctrl_pseudo_lock_event
 #include <trace/define_trace.h>
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl_rdtgroup.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
rename to arch/x86/kernel/cpu/resctrl_rdtgroup.c
index dbc7fc98b60a..7a0c9aad89f9 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl_rdtgroup.c
@@ -35,8 +35,8 @@
=20
 #include <uapi/linux/magic.h>
=20
-#include <asm/intel_rdt_sched.h>
-#include "intel_rdt.h"
+#include <asm/resctrl_sched.h>
+#include "resctrl.h"
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

