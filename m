Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeFDJIg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:08:36 -0400
Received: from mail-pu1apc01hn0229.outbound.protection.outlook.com ([104.47.126.229]:61441
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751933AbeFDJId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:08:33 -0400
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
CC: Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [RFC Patch 1/3] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Topic: [RFC Patch 1/3] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Index: AQHT++OW1TQj7xYFtUGQsOkMiGidAQ==
Date: Mon, 4 Jun 2018 09:08:23 +0000
Message-ID: <20180604090749.489-2-Tianyu.Lan@microsoft.com>
References: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0014;7:b+aeClZjUUn3HkGsK7Nm55O2zCdggmdv742iipGboN62rwBCZKngnnX4aVgSPAVH/Vc9D9Yqq+aJC4t5qOwWHCFqVQzIJf+1j/Dr9fBUQZ+vwL2IepRetPcvb2URGPJGvTcugYpBI3iJ9v0/rTTr2djukTpNyAb7u8XbW5DWP6CLjtPSXebF9VNT7bPFHJaEgFJ/1tIYWYNRV93nTNEtUrFxTIE3kdX/fApAE+/8iZ0P8LgZ6PtStY4ZLtsi4Gws;20:kPAcNStUzupo2g33bwEPUlcOPnAcKguVMSqjSAiGPM3kILEHpQ0l/Aqs/Bf9rueFFnL/WHj/g7mrZtuRggTtclIRCQ04jYsBAvrGQ1TTVbBTQGgHOYhagVMFtyNrNavJ75SAUg++Ppl0tF/tfMCJ8KvL/MEC+DSuGIfHshRffTg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:SG2P15301MB0014;
x-ms-traffictypediagnostic: SG2P15301MB0014:
x-microsoft-antispam-prvs: <SG2P15301MB0014D44A0A7A7D36DDCCD0A992670@SG2P15301MB0014.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0014;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0014;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(6029001)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(36756003)(305945005)(5660300001)(10090500001)(97736004)(6436002)(7416002)(2900100001)(68736007)(3846002)(11346002)(446003)(6116002)(7736002)(25786009)(1076002)(476003)(486006)(5250100002)(2616005)(1671002)(478600001)(72206003)(26005)(105586002)(106356001)(86612001)(575784001)(86362001)(2906002)(99286004)(22452003)(316002)(54906003)(3280700002)(102836004)(6512007)(3660700001)(59246006)(59450400001)(76176011)(14454004)(6506007)(53936002)(8936002)(6486002)(66066001)(81166006)(81156014)(8676002)(10290500003)(4326008)(109986005)(22906009)(49343001)(2004002);DIR:OUT;SFP:1501;SCL:5;SRVR:SG2P15301MB0014;H:SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kctgbLtskJw+NEdAN7MVTOs4xMxPCkm5oxrWGPH4SKRm/dyTCKjBXX6rM5eJe2D5VdDAVOpYbbLCSvQxbF+FCobqF0PNd9R48mNAygp7cc3HF1Gk0CZkR/rtB7Th3GoFuMe6izcqRKSKvAn/HU6+S7YOPesj/DIl38kCoZ0erFnxtjokXnsTtqrwyaFBVGzq0N0XmAGCN1yiOe1pLqXKNOfaTocLPl/6VfcS5mKlJDR8IuOCDqV5RucMNz5y/mX8Fv7zUNQsiQt3JhiOQGeIO5Kxa0bffnxT6ZP5gPaPmzv5ZrU/NXRdaYZQCJQPW53WMynp2kPA/qWYz2nBXYT4awYQCUyuPPuxp85vtpOqCKd9EpSxE919JXH8FsVwexBVkKFYID3j24cd6qxJ7nJaTG+4TZQ1oYx2Y/leKASk9xU=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: aac85dd3-1493-4301-9b0a-08d5c9fab9db
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac85dd3-1493-4301-9b0a-08d5c9fab9db
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 09:08:23.4977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0014
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w5498fBR032350

Hyper-V provides a pv hypercall HvFlushGuestPhysicalAddressSpace to flush
nested VM address space mapping in l1 hypervisor and it's to reduce overhead
of flushing ept tlb among vcpus. This patch is to implement it.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/Makefile           |  2 +-
 arch/x86/hyperv/nested.c           | 64 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  8 +++++
 arch/x86/include/asm/mshyperv.h    |  2 ++
 4 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/hyperv/nested.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index b173d404e3df..b21ee65c4101 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,2 +1,2 @@
-obj-y			:= hv_init.o mmu.o
+obj-y			:= hv_init.o mmu.o nested.o
 obj-$(CONFIG_X86_64)	+= hv_apic.o
diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
new file mode 100644
index 000000000000..17f7c288eccc
--- /dev/null
+++ b/arch/x86/hyperv/nested.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V nested virtualization code.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ */
+
+
+#include <linux/types.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+#include <asm/tlbflush.h>
+
+int hyperv_flush_guest_mapping(u64 as)
+{
+	struct hv_guest_mapping_flush **flush_pcpu;
+	struct hv_guest_mapping_flush *flush;
+	u64 status = U64_MAX;
+	unsigned long flags;
+	int ret = -EFAULT;
+
+	if (!hv_hypercall_pg)
+		goto fault;
+
+	local_irq_save(flags);
+
+	flush_pcpu = (struct hv_guest_mapping_flush **)
+		this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	flush = *flush_pcpu;
+
+	if (unlikely(!flush)) {
+		local_irq_restore(flags);
+		goto fault;
+	}
+
+	flush->address_space = as;
+	flush->flags = 0;
+
+	status = hv_do_hypercall(HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE,
+				 flush, NULL);
+	local_irq_restore(flags);
+
+	if (!(status & HV_HYPERCALL_RESULT_MASK))
+		ret = 0;
+
+fault:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping);
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index b8c89265baf0..53bbeb08faea 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -309,6 +309,7 @@ struct ms_hyperv_tsc_page {
 #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
 
 /* Nested features (CPUID 0x4000000A) EAX */
+#define HV_X64_NESTED_GUSET_MAPPING_FLUSH	BIT(18)
 #define HV_X64_NESTED_MSR_BITMAP		BIT(19)
 
 struct hv_reenlightenment_control {
@@ -350,6 +351,7 @@ struct hv_tsc_emulation_status {
 #define HVCALL_SEND_IPI_EX			0x0015
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
+#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 
 #define HV_X64_MSR_VP_ASSIST_PAGE_ENABLE	0x00000001
 #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
@@ -741,6 +743,12 @@ struct ipi_arg_ex {
 	struct hv_vpset vp_set;
 };
 
+/* HvFlushGuestPhysicalAddressSpace hypercalls */
+struct hv_guest_mapping_flush {
+	u64 address_space;
+	u64 flags;
+};
+
 /* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
 struct hv_tlb_flush {
 	u64 address_space;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 3cd14311edfa..a6a615b49876 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -302,6 +302,7 @@ void hyperv_reenlightenment_intr(struct pt_regs *regs);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
+int hyperv_flush_guest_mapping(u64 as);
 
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
@@ -321,6 +322,7 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 {
 	return NULL;
 }
+static inline int hyperv_flush_guest_mapping(u64 as) { return -1; }
 #endif /* CONFIG_HYPERV */
 
 #ifdef CONFIG_HYPERV_TSCPAGE
-- 
2.14.3
