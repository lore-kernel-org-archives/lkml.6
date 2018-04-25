Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1133472-1524680065-3-1832793273612107306
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524680064; b=k8fawUYQG/v9eVOP32b2i09n6LMq/ov4es3IML34NcIF/GB3GU
    6QwXYuFRaoZOF6JDTXguNj2GDIN2A6wGJq+IrlJAtll1zVM2oVC5BOqcLsZorREC
    vkNUlNswxCrOkQTZ7FtI/XjGfcjIIAjvnLXfVkroEQ55rUpVHz+5l3r+HBSiqI+J
    mBUUMqtdmjPGpoucewyxpm1/VroSRDxYx+ANcO9Fqy/XSEmBfTgeUXnSsEfqOvVo
    ljI8VEcP4bBh2LZlOs0qBiVEPbp5SN2BKft6sUimR7OnRrOfXackURhyRNWKpTbi
    TiPz1VXZTiFXdBFAToATLS6EFLEtr4tamgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1524680064; bh=vMkNPGcXtCSw1I0YbCWiuTd+P9v0rzH06ZHRV8uRxmk=; b=n
    AhCY/VGXq9e6/rnOLTkEhVWmeCdYtsRm5Bki5urVaRCdzo4DDlCRUKbsyYgxkrP/
    SkHC8xR02WZaNjtdrtdwjglupnJs6iliQTxvtBnnnJpHKtuovKIjt0tuge2X2Aa9
    MbKRO/SomHS/vEkQwzTW5thYZLyfyUbP8kHaOYEJAr0dkGdO5Z+DuvHpE/i9Ujyt
    v/hx9o4vvjW+Lzxkhy25xt9O57qAlVmqovyEMCT6JBxkSOQHsFnIefqDCyBQkKrH
    zhLNiuLPbJR/1D4QJKVSv27UDkooTjvHo+uF17wQkFo70k0h6wIrbw70j6YCSeSz
    kx6PGcsen8Ahes4QyDvwA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCGDsxsNNpwIhfdwWdA5LYT67G9elph7RHoMjJ7zNYviKuLLiHwGBTJLVZkrAMHfu/UUPWziUHD5UHSk5C6eHXrJHOWrljul3AGWIa0BFYw0aywWipFI
    R/y1JXw+IdsYEQ1SsDTsA3/7YviJfH1uNk8O08lp5ibHNpaH0J1hHBeO4iD5iKlaBzw9rc1I7Lm66Hp3u1CeyZxKxLAOoERp7d7JMFlbLHGXOw98LIRDstZC
    W1DAGP7ggnPsHBnD9ILhCg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=t6KZYu_9Gx1rVWOKQykA:9 a=e8JQVN7TN84JSXAK:21
    a=Vxt3iiAV_Dx-tngR:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 jasowang@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH 1/5] X86: Hyper-V: Enlighten APIC access
Date: Wed, 25 Apr 2018 11:12:46 -0700
Message-Id: <20180425181250.8740-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180425181110.8683-1-kys@linuxonhyperv.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfP3dQv1AtB5b4NXkE3+Gl5QqS/eH1xc28P99OFqjDpYCcwcDOqfxWGyjB31v7+C53u0FNOF007dy4oYjz4QdNytLA+Q5eghDYmQWREzxCE0TTgRMk93v
 e3rPX0bXY6Sv4kVilGsdEFnlQjzboyeYsRklW/gl8bOBacdOKg70QVnmOShTYFlZ8LfpPBI3d+gaiFBdd86qiKa2ouO03NgN9VX68mYkn/B2T20o+NdkQ43s
 awZsbZYSMZC+i0emaOg+KYBGQIZB27UzWaVrFMx6O8hTYZaRDDP5MzvQoNryRWjKXIi8+Xfy/ZOIf/hRGOnchfsWkd0EjT75Q37NBAn+9U58Cf9yklIzt2Pe
 hZtWmCZmUn67qnIK+2Zu5MJzYUh9S1pFmKZH6juyW7ikUVkDQB9EofYGXMfnCatiUvx/plQXVRwCWo+fHfyjPl1ZjYfQOSLfJ2tdeaE9/zHgOZ+RznrY2hdW
 D6tXtLnJWq2HqoLBBcOyQN503XL5oAp4Io3J1p923A2ywcaY53TEEshlXpI2/3sP14mMtmI1VQfXi3fMKkJbA/s8SbiPpHBAfBp6BV1i2NlXx/n0Cgtia0k+
 yFU8Lj6Sv/AXZ4YmogWEk6sr
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Hyper-V supports MSR based APIC access; implement
the enlightenment.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/hyperv/Makefile        |  2 +-
 arch/x86/hyperv/hv_apic.c       | 98 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c       |  5 ++-
 arch/x86/include/asm/mshyperv.h |  6 ++-
 4 files changed, 107 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_apic.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 367a8203cfcf..00ce4df01a09 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1 +1 @@
-obj-y		:= hv_init.o mmu.o
+obj-y		:= hv_init.o mmu.o hv_apic.o
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
new file mode 100644
index 000000000000..e0a5b36208fc
--- /dev/null
+++ b/arch/x86/hyperv/hv_apic.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V specific APIC code.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : K. Y. Srinivasan <kys@microsoft.com>
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
+#include <linux/types.h>
+#include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
+#include <linux/version.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/clockchips.h>
+#include <linux/hyperv.h>
+#include <linux/slab.h>
+#include <linux/cpuhotplug.h>
+
+static u64 hv_apic_icr_read(void)
+{
+	u64 reg_val;
+
+	rdmsrl(HV_X64_MSR_ICR, reg_val);
+	return reg_val;
+}
+
+static void hv_apic_icr_write(u32 low, u32 id)
+{
+	u64 reg_val;
+
+	reg_val = SET_APIC_DEST_FIELD(id);
+	reg_val = reg_val << 32;
+	reg_val |= low;
+
+	wrmsrl(HV_X64_MSR_ICR, reg_val);
+}
+
+static u32 hv_apic_read(u32 reg)
+{
+	u32 reg_val, hi;
+
+	switch (reg) {
+	case APIC_EOI:
+		rdmsr(HV_X64_MSR_EOI, reg_val, hi);
+		return reg_val;
+	case APIC_TASKPRI:
+		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
+		return reg_val;
+
+	default:
+		return native_apic_mem_read(reg);
+	}
+}
+
+static void hv_apic_write(u32 reg, u32 val)
+{
+	switch (reg) {
+	case APIC_EOI:
+		wrmsr(HV_X64_MSR_EOI, val, 0);
+		break;
+	case APIC_TASKPRI:
+		wrmsr(HV_X64_MSR_TPR, val, 0);
+		break;
+	default:
+		native_apic_mem_write(reg, val);
+	}
+}
+
+static void hv_apic_eoi_write(u32 reg, u32 val)
+{
+	wrmsr(HV_X64_MSR_EOI, val, 0);
+}
+
+void __init hv_apic_init(void)
+{
+	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
+		pr_info("Hyper-V: Using MSR ased APIC access\n");
+		apic_set_eoi_write(hv_apic_eoi_write);
+		apic->read      = hv_apic_read;
+		apic->write     = hv_apic_write;
+		apic->icr_write = hv_apic_icr_write;
+		apic->icr_read  = hv_apic_icr_read;
+	}
+}
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index cfecc2272f2d..71e50fc2b7ef 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -242,8 +242,9 @@ static int hv_cpu_die(unsigned int cpu)
  *
  * 1. Setup the hypercall page.
  * 2. Register Hyper-V specific clocksource.
+ * 3. Setup Hyper-V specific APIC entry points.
  */
-void hyperv_init(void)
+void __init hyperv_init(void)
 {
 	u64 guest_id, required_msrs;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
@@ -298,6 +299,8 @@ void hyperv_init(void)
 
 	hyper_alloc_mmu();
 
+	hv_apic_init();
+
 	/*
 	 * Register Hyper-V specific clocksource.
 	 */
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index b90e79610cf7..bcced50037c1 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -258,7 +258,7 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
 	return hv_vp_index[cpu_number];
 }
 
-void hyperv_init(void);
+void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
 void hyper_alloc_mmu(void);
 void hyperv_report_panic(struct pt_regs *regs, long err);
@@ -269,14 +269,16 @@ void hyperv_reenlightenment_intr(struct pt_regs *regs);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
+void hv_apic_init(void);
 #else /* CONFIG_HYPERV */
-static inline void hyperv_init(void) {}
+static __init  inline void hyperv_init(void) {}
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline void hyperv_cleanup(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
 static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
 static inline void clear_hv_tscchange_cb(void) {}
 static inline void hyperv_stop_tsc_emulation(void) {};
+static inline void hv_apic_init(void) {}
 static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 {
 	return NULL;
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
