Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11070C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA86A213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cm7pVV10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA86A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeJFD4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:56:19 -0400
Received: from mail-eopbgr720078.outbound.protection.outlook.com ([40.107.72.78]:47664
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728341AbeJFD4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaNOOYOwHG1rCuj4a9mwxrK/4Xya8ukluLi5HvPA3rU=;
 b=Cm7pVV109vnz5X+7IUNId98inHB8RiA1S/aCSHfT3RFgyXzrK0LkbDZiLiVYDLKhgkwqo0+LoyWLfpW8hmC2+e9CxzOEYyKdLLf3uNUbbBu0ALd2qJQGbA88wP65lIXeGL8vzIucXhmHiCGNnUDeXWb6LFUeAbdNsyAh9jsFlVk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2504.namprd12.prod.outlook.com (52.132.141.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Fri, 5 Oct 2018 20:55:39 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 20:55:39 +0000
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
Subject: [PATCH v2 01/11] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Topic: [PATCH v2 01/11] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Index: AQHUXO3FhE3rddQXr0iDhqiTp63CXg==
Date:   Fri, 5 Oct 2018 20:55:38 +0000
Message-ID: <20181005205512.29545-2-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2504;20:Aa7DxWyrNIFDrM16EcEtffQEmeMxdjIsnyO9JlaNxjtXoZexYK7Xp+AJiBVHrrSaugsH0NtwWd98Mtb/BpZsq/85B1v/1n+YEU1fpFhyzKFKynJGaM4gKtsStq3BZ77qkVYbusyvjxOgVVtW3Q8VP0dUoZyoO5Lpnj7qOO25ujSOzbtf/7dDDJVqtFq0DFrQckXGwX0Td7yGKV4jEDYSDBy+VkCGNDKgomHuEpgfAp+bs+8d1HICsn9/I+qF62vW
x-ms-office365-filtering-correlation-id: da92c038-6f83-4692-213c-08d62b04e76b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2504;
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-microsoft-antispam-prvs: <DM5PR12MB2504A9019BA0B549D6B5444F95EB0@DM5PR12MB2504.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302102)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:DM5PR12MB2504;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2504;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(110136005)(2201001)(256004)(36756003)(72206003)(102836004)(54906003)(14444005)(6512007)(305945005)(52116002)(25786009)(14454004)(53936002)(386003)(8936002)(478600001)(68736007)(105586002)(6506007)(66066001)(99286004)(86362001)(106356001)(2900100001)(575784001)(7416002)(4326008)(476003)(486006)(8676002)(6116002)(76176011)(3846002)(7736002)(71190400001)(71200400001)(316002)(2906002)(186003)(11346002)(2501003)(81156014)(81166006)(446003)(5660300001)(5250100002)(6486002)(6436002)(2616005)(97736004)(26005)(1076002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2504;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YXvxiiwzV1KeGdZLbG2iHEKNXp91rW2RfA4+XV69b3zV5ZWHaPAyrjdGSMxfNkikZgBkNkWvqCvQ1RCks+EliSzZ+uE1GqmaOHKQF8timQjyAG96YECAJjXujD3RBgKOPV0fldP/Gb5DN0OuwkYCyP6iP3z8TtWCSflwtiO36qlG/dznMo/LGlHtUC1lZjUblP40bObDJ4GCpBXjU4hElAb0rwz2PMnehD5pAjhMnpBdKNU23OT1LWc58JLgRzTFKm+dw05cbrIkKykcFTXuDmTbLh79KOqvJV4xidkh9KSdEGMhsFAqZutYF8UIADfLcWzkZjUp9edGehCKalPRpAglkM+nevNfvp6CP7HzUu4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da92c038-6f83-4692-213c-08d62b04e76b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 20:55:38.7706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New generation of AMD processors start support RDT(or QOS) features.
With more than one vendors supporting these features, it seems more
appropriate to rename these files.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/{intel_rdt_sched.h =3D> rdt_sched.h}     | 0
 arch/x86/kernel/cpu/Makefile                                | 6 +++---
 arch/x86/kernel/cpu/{intel_rdt.c =3D> rdt.c}                  | 4 ++--
 arch/x86/kernel/cpu/{intel_rdt.h =3D> rdt.h}                  | 0
 .../cpu/{intel_rdt_ctrlmondata.c =3D> rdt_ctrlmondata.c}      | 2 +-
 arch/x86/kernel/cpu/{intel_rdt_monitor.c =3D> rdt_monitor.c}  | 2 +-
 .../cpu/{intel_rdt_pseudo_lock.c =3D> rdt_pseudo_lock.c}      | 6 +++---
 ...ntel_rdt_pseudo_lock_event.h =3D> rdt_pseudo_lock_event.h} | 2 +-
 .../x86/kernel/cpu/{intel_rdt_rdtgroup.c =3D> rdt_rdtgroup.c} | 4 ++--
 arch/x86/kernel/process_32.c                                | 2 +-
 arch/x86/kernel/process_64.c                                | 2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)
 rename arch/x86/include/asm/{intel_rdt_sched.h =3D> rdt_sched.h} (100%)
 rename arch/x86/kernel/cpu/{intel_rdt.c =3D> rdt.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt.h =3D> rdt.h} (100%)
 rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c =3D> rdt_ctrlmondata.c=
} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_monitor.c =3D> rdt_monitor.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c =3D> rdt_pseudo_lock.c=
} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h =3D> rdt_pseudo_=
lock_event.h} (95%)
 rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c =3D> rdt_rdtgroup.c} (99%=
)

diff --git a/arch/x86/include/asm/intel_rdt_sched.h b/arch/x86/include/asm/=
rdt_sched.h
similarity index 100%
rename from arch/x86/include/asm/intel_rdt_sched.h
rename to arch/x86/include/asm/rdt_sched.h
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 347137e80bf5..6c35d89f174f 100644
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
+obj-$(CONFIG_INTEL_RDT)	+=3D rdt.o rdt_rdtgroup.o rdt_monitor.o
+obj-$(CONFIG_INTEL_RDT)	+=3D rdt_ctrlmondata.o rdt_pseudo_lock.o
+CFLAGS_rdt_pseudo_lock.o =3D -I$(src)
=20
 obj-$(CONFIG_X86_MCE)			+=3D mcheck/
 obj-$(CONFIG_MTRR)			+=3D mtrr/
diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/rdt.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt.c
rename to arch/x86/kernel/cpu/rdt.c
index abb71ac70443..28d6cd254ba9 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/rdt.c
@@ -30,8 +30,8 @@
 #include <linux/cpuhotplug.h>
=20
 #include <asm/intel-family.h>
-#include <asm/intel_rdt_sched.h>
-#include "intel_rdt.h"
+#include <asm/rdt_sched.h>
+#include "rdt.h"
=20
 #define MBA_IS_LINEAR	0x4
 #define MBA_MAX_MBPS	U32_MAX
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/rdt.h
similarity index 100%
rename from arch/x86/kernel/cpu/intel_rdt.h
rename to arch/x86/kernel/cpu/rdt.h
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/=
cpu/rdt_ctrlmondata.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
rename to arch/x86/kernel/cpu/rdt_ctrlmondata.c
index 0f53049719cd..812cc5c5e39e 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/rdt_ctrlmondata.c
@@ -26,7 +26,7 @@
 #include <linux/kernfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include "intel_rdt.h"
+#include "rdt.h"
=20
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/=
rdt_monitor.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_monitor.c
rename to arch/x86/kernel/cpu/rdt_monitor.c
index b0f3aed76b75..2898a61cbdd9 100644
--- a/arch/x86/kernel/cpu/intel_rdt_monitor.c
+++ b/arch/x86/kernel/cpu/rdt_monitor.c
@@ -26,7 +26,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
-#include "intel_rdt.h"
+#include "rdt.h"
=20
 #define MSR_IA32_QM_CTR		0x0c8e
 #define MSR_IA32_QM_EVTSEL		0x0c8d
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/=
cpu/rdt_pseudo_lock.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
rename to arch/x86/kernel/cpu/rdt_pseudo_lock.c
index 40f3903ae5d9..6105a2af3216 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/rdt_pseudo_lock.c
@@ -23,13 +23,13 @@
=20
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/rdt_sched.h>
 #include <asm/perf_event.h>
=20
-#include "intel_rdt.h"
+#include "rdt.h"
=20
 #define CREATE_TRACE_POINTS
-#include "intel_rdt_pseudo_lock_event.h"
+#include "rdt_pseudo_lock_event.h"
=20
 /*
  * MSR_MISC_FEATURE_CONTROL register enables the modification of hardware
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h b/arch/x86/k=
ernel/cpu/rdt_pseudo_lock_event.h
similarity index 95%
rename from arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
rename to arch/x86/kernel/cpu/rdt_pseudo_lock_event.h
index 2c041e6d9f05..5c6eda48bdc1 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/rdt_pseudo_lock_event.h
@@ -39,5 +39,5 @@ TRACE_EVENT(pseudo_lock_l3,
=20
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE intel_rdt_pseudo_lock_event
+#define TRACE_INCLUDE_FILE rdt_pseudo_lock_event
 #include <trace/define_trace.h>
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu=
/rdt_rdtgroup.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
rename to arch/x86/kernel/cpu/rdt_rdtgroup.c
index 1b8e86a5d5e1..5ecf73c833d3 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/rdt_rdtgroup.c
@@ -35,8 +35,8 @@
=20
 #include <uapi/linux/magic.h>
=20
-#include <asm/intel_rdt_sched.h>
-#include "intel_rdt.h"
+#include <asm/rdt_sched.h>
+#include "rdt.h"
=20
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5046a3c9dec2..931b2d0cb95e 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -56,7 +56,7 @@
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/rdt_sched.h>
 #include <asm/proto.h>
=20
 void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ea5ea850348d..c029782a9216 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -52,7 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/rdt_sched.h>
 #include <asm/unistd.h>
 #ifdef CONFIG_IA32_EMULATION
 /* Not included via unistd.h */
--=20
2.17.1

