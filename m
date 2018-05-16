Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-969494-1526507688-2-7130028934480604546
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526507687; b=K4Bh/fZnHzWsCFE2sF9wkhdc3Nzt/AtZyjutVKg35WaDeXc+Bj
    5gjBAPX7wPjD8VdW8FzC+AuMHvUNwqu2G+q0+YhtktAd2QzCU92B5oWwa0dHWXE8
    zupqcGYx5BIimK6JNY8GdG1P+BYyiZ7MH7fJc2rFSpRXnUQvH0AK5a9GJO5Cb2XA
    H558cym+6pnbjuw9rYzx+o73ElMKev/zi+TUq/kQ8pWrON6uzhMhgEEGpp4SGcNM
    eNijqOVr3neGJnwJG4jKZt+5LSmaUXjFwt4jUybWzaVBuLKiEccUn1dFzBVzRyiD
    svFg/J4VIEhYLoEouUKX6cQ0uFtOeOD3nmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1526507687; bh=RR0uF6JVJOnuRiM91+hUjiaWeWOx/JVgXzbwi7QFxhM=; b=T
    PWb6YoVwB0aAl2v1V5Zrh4R0VBtUEYL+fHyjCfMDXoO+S28Ckwpz3zCI2WuV5pO0
    b9RfsICxjCxHQbrBboIlv4FuvBu6IjOyhZ0fWONXA75at4NAzkjwea6YZ+fqGQQ9
    wak+hU2TimiLwHIh1Fkav1gHZ3LtDgbfazyluuSmRti70fHRY3suHxy2gTT5opWy
    +NBlO62sIZMKfPT10kLad6Y7K4ssmcBpawDYgR0V0wk7jKTnx1Ng8PqLOYPxOfxv
    RFtsxzfORioYWvVXJflYLEQk5NyJt2G5EphY4Hikdflusuj/i68RQX+bP8ZDWyir
    Z1s0qxfEv9mkN2v4ZhLow==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxonhyperv.com
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxonhyperv.com
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPJszsO7VOxwzvcBMnb/KirVf3/XuVDlXybJC5LYTl1J0b2eS0bV/M3mNmbNjY6bEvxnzIL6662l+XaMGMInLapBb1H9ZIQsmNGTBgWpEYQYCR0OXUrw
    w2gEc+Z2AcqefQmVk0Yi3TiDmR4QJ0ErUvd5OMZxhFuDIJv85GqfR+XXSK4CyoU12+q5Q289IRFIqaoHSwBOsUY/AxABB63moQqUkJ8nBEC3K7IAj8PJXSLG
    7af6RXC9yVjCKhnfiVYzzg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=yvwLqIFR9Ez4KeATXzUA:9 a=9GswoeB6NbrnVYbo:21
    a=OYX-I8NWV6dXnrGg:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 jasowang@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V3 1/5] X86: Hyper-V: Enlighten APIC access
Date: Wed, 16 May 2018 14:53:30 -0700
Message-Id: <20180516215334.6547-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516215144.6481-1-kys@linuxonhyperv.com>
References: <20180516215144.6481-1-kys@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfKNpYgW1EW8hl4GaASx9vqVdSaD4KtGYMKUiLn+MK48AaLr9tCsN/WGGC4ZmmUbgoB12hhNNBhivp7bEnTXVQp0RAvZs/8J69ZF3q6OgKIW04iuNLhPp
 UVPaeQqZkDLkTkStsAsCRz485Onbed5X0ZOIEeiBQRMmk7BYh4ubg2+E525IjjMHzll8OTtdTHqEs+roXjcG22Vb5pODY8pj2zXjWz1T+QSIWcGu3msUsK8i
 r8783L/4La76t4FiEQ0xjGAg3fpPejpXDDFWV4SsSTI0zfPxFqdiBbd7D6t4WEhjd7lAa/4W8bjW1TOSd69Rl3hlwqYZQrjyb4qnd67c7kqmp5KywKlrEJzv
 E1Xc2HQm9EK9tvPk+WIuahsbjti050GFnGgqPh3PeQ2sw/TABR+SLPqtrVmcmigHDW071bwKbJ/PUYlrh/DosPEDRzi0ekVC/rhU4/dHwSeVbkPQIIdS4coX
 YHDgsixxdREDk7pBA2cYYexY06m2qbt7TV7bsdCA9UGRFGIF/BdIRG8gxCCzZuXp/Yymmm6yFCdi0wAXB3fjLPHJV68qBx5t+1LolUTrnEMMgvmFQoYm/8Jt
 XHr1EybRYHTIPA5qeNjC63CM
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/Makefile        |   2 +-
 arch/x86/hyperv/hv_apic.c       | 104 ++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c       |   5 +-
 arch/x86/include/asm/mshyperv.h |   4 +-
 4 files changed, 112 insertions(+), 3 deletions(-)
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
index 000000000000..ca20e31d311c
--- /dev/null
+++ b/arch/x86/hyperv/hv_apic.c
@@ -0,0 +1,104 @@
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
+#include <linux/version.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/clockchips.h>
+#include <linux/hyperv.h>
+#include <linux/slab.h>
+#include <linux/cpuhotplug.h>
+#include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
+
+#ifdef CONFIG_X86_64
+#if IS_ENABLED(CONFIG_HYPERV)
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
+		pr_info("Hyper-V: Using MSR based APIC access\n");
+		apic_set_eoi_write(hv_apic_eoi_write);
+		apic->read      = hv_apic_read;
+		apic->write     = hv_apic_write;
+		apic->icr_write = hv_apic_icr_write;
+		apic->icr_read  = hv_apic_icr_read;
+	}
+}
+
+#endif /* CONFIG_HYPERV */
+#endif /* CONFIG_X86_64 */
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
index b90e79610cf7..162977b82e2e 100644
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
@@ -269,6 +269,7 @@ void hyperv_reenlightenment_intr(struct pt_regs *regs);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
+void hv_apic_init(void);
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline bool hv_is_hyperv_initialized(void) { return false; }
@@ -277,6 +278,7 @@ static inline void hyperv_setup_mmu_ops(void) {}
 static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
 static inline void clear_hv_tscchange_cb(void) {}
 static inline void hyperv_stop_tsc_emulation(void) {};
+static inline void hv_apic_init(void) {}
 static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 {
 	return NULL;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
