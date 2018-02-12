Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AH8x225/A0PpyyL8K+mRXb14P7TXJ8r/WBCi/RrvD15hyJCzylh1pdAEIzqOyMqBw4E+p37q8qsY
ARC-Seal: i=1; a=rsa-sha256; t=1518395678; cv=none;
        d=google.com; s=arc-20160816;
        b=fN8xNyv+8vzS1x76+kn8wKF1OT3qf82OBNivPSbft505suPGxXIcuJblxwmoe24rWO
         9JNOX25dw9IVRqbvNFjZ/iaK6At2GXZTBCllc7dmgpR+vQ3yaN7d5OiJ0so47Kdzsr+0
         cmwkjN6WH6pbgmiOYcSGyrn3urvznyhChpeQ4iNDyYIz3idsuDdlCF4+pHPsAHtMejgz
         Ett1A8xvdIgYyEznX3eULO6cC3qMjL0cLJjk5CD8n0wgOs1RSgCVIXLxFHT6F/sF2JM1
         eSSCc5OrQ4K870rOzhcKsynJXzEMuhO8ktTlE80xm7guRXpEcyTQbgc0qjgMfO0pMNyz
         jFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=EA3Neul88egmMUxchbj3qYQhFNdn0c6y7ZjYJDth6Zo=;
        b=JSSo2zc4KRyDqzFAFA3WmQuJoo/4zzNFq4kWK393C1pJXRzi7H5tkzoN8LQPFemrai
         bfdMWRCLxuvJHuocgE0nEXCV8G2KYqOkGJbjNv8KHyn6nKUJiimt1CPutRXtrMvzmNzR
         uHRBCGwTScBsT30KsDv59k/fm6nNjoBhDG5B4pqkFeQ5cOmUTBy3E/64kX6BOp8Geay6
         pj1CIVmW5PUBA+417W8P3QmX2s1PbKHOXpyaVScpuL4dGTTrXjUxdZaEz90MasnOLZtZ
         yYYFZ7d5ZuGfSY25gcySsWsjk0rdNaw0Aj94FeEELpb1MYMcPFylylA74O9RciRbrQyo
         v/Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: Michael Kelley <mikelley@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 08/12] Drivers: hv: vmbus: Implement Direct Mode for stimer0
Date: Sun, 11 Feb 2018 17:33:16 -0700
Message-Id: <20180212003320.6748-8-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212003320.6748-1-kys@exchange.microsoft.com>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfFBS4iFExjF+Ue2BP7ayEqngObyuDahQMBHeSI8RIlYOOQ2N7YSuR5UI1lb7Zqa8jHhm8zuUUdfrSVaLBMO2X8j5ssNCUS+y7V6unuCQOVBcg2D0W96Y
 BNuMi34GnE/zshj/D79Srfok51UxK5FXmC+5TnVJzdRH4/vN5jJncB/SFGgm193fRiy5SuAIQQxZpDMx65o6Su4iAfsKTGShAkkVZIkNdMZlq/AWQxnjCYx9
 g5RAvRpuy+Cn36f59pYjw5KYGNKJG8dnKlH7j73MnUC951OlTTwH8xpOycHj5Q9OqkEkmXq+yVMj1B1OLn4yeWL37Ko3gcG7ofP9KtiYDc0oY9nnUvlUlYgc
 Zc6hVzxA3Zt649f6QRgriK6uCMghGhmYOrcJgXcnX/QMl/g9ojzroz5Oet82QnpZXaVGda8ZeroOl1Oo3wuGyj9ylxg0OaLeCsz4e8uXlppT0TJQk4zl6NyF
 OEKTp9wDtXK0otRXTK99JQ+CSc4D3LAcjqyhkn3/un7G7McWM3t+rlaYE8hNmU2IVoWZkrjziQLV03foZr6yQ5cVIm4ncqcK+SdN2dQPwE0Wpmp8Bae0OSks
 NeH8ZMM+sfG+ywCjnCHs/cRO
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153266380237670?=
X-GMAIL-MSGID: =?utf-8?q?1592153266380237670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Kelley <mikelley@microsoft.com>

The 2016 version of Hyper-V offers the option to operate the guest VM
per-vcpu stimer's in Direct Mode, which means the timer interupts on its
own vector rather than queueing a VMbus message. Direct Mode reduces
timer processing overhead in both the hypervisor and the guest, and
avoids having timer interrupts pollute the VMbus interrupt stream for
the synthetic NIC and storage.  This patch enables Direct Mode by
default on stimer0 when running on a version of Hyper-V that supports
it.

In prep for coming support of Hyper-V on ARM64, the arch independent
portion of the code contains calls to routines that will be populated
on ARM64 but are not needed and do nothing on x86.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/entry/entry_32.S          |  3 ++
 arch/x86/entry/entry_64.S          |  2 ++
 arch/x86/include/asm/hardirq.h     |  3 ++
 arch/x86/include/asm/irq_vectors.h |  7 ++++-
 arch/x86/include/asm/mshyperv.h    | 13 ++++++++
 arch/x86/include/uapi/asm/hyperv.h |  3 ++
 arch/x86/kernel/cpu/mshyperv.c     | 41 ++++++++++++++++++++++++-
 arch/x86/kernel/irq.c              |  9 ++++++
 drivers/hv/hv.c                    | 61 ++++++++++++++++++++++++++++++++++++--
 drivers/hv/hyperv_vmbus.h          |  4 ++-
 10 files changed, 141 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2a35b1e0fb90..e36f75bdbecc 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -895,6 +895,9 @@ BUILD_INTERRUPT3(xen_hvm_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
 BUILD_INTERRUPT3(hyperv_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
 		 hyperv_vector_handler)
 
+BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
+		 hv_stimer0_vector_handler)
+
 #endif /* CONFIG_HYPERV */
 
 ENTRY(page_fault)
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index a83570495162..4a9bdfed8588 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1245,6 +1245,8 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
 #if IS_ENABLED(CONFIG_HYPERV)
 apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
 	hyperv_callback_vector hyperv_vector_handler
+apicinterrupt3 HYPERV_STIMER0_VECTOR \
+	hv_stimer0_callback_vector hv_stimer0_vector_handler
 #endif /* CONFIG_HYPERV */
 
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 51cc979dd364..c788343f93d9 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -38,6 +38,9 @@ typedef struct {
 #if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
 	unsigned int irq_hv_callback_count;
 #endif
+#if IS_ENABLED(CONFIG_HYPERV)
+	unsigned int hyperv_stimer0_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 67421f649cfa..6accf0b6491b 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -103,7 +103,12 @@
 #endif
 
 #define MANAGED_IRQ_SHUTDOWN_VECTOR	0xef
-#define LOCAL_TIMER_VECTOR		0xee
+
+#if IS_ENABLED(CONFIG_HYPERV)
+#define HYPERV_STIMER0_VECTOR		0xee
+#endif
+
+#define LOCAL_TIMER_VECTOR		0xed
 
 #define NR_VECTORS			 256
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index b52af150cbd8..2bd73b4240e9 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -172,6 +172,19 @@ void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
 void hv_remove_crash_handler(void);
 
+/*
+ * Routines for stimer0 Direct Mode handling.
+ * On x86/x64, there are no percpu actions to take.
+ */
+void hv_stimer0_vector_handler(struct pt_regs *regs);
+void hv_stimer0_callback_vector(void);
+int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void));
+void hv_remove_stimer0_irq(int irq);
+
+static inline void hv_enable_stimer0_percpu_irq(int irq) {}
+static inline void hv_disable_stimer0_percpu_irq(int irq) {}
+
+
 #if IS_ENABLED(CONFIG_HYPERV)
 extern struct clocksource *hyperv_cs;
 extern void *hv_hypercall_pg;
diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
index 1a5bfead93b4..7213cb8448cf 100644
--- a/arch/x86/include/uapi/asm/hyperv.h
+++ b/arch/x86/include/uapi/asm/hyperv.h
@@ -74,6 +74,9 @@
 /* Crash MSR available */
 #define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE (1 << 10)
 
+/* stimer Direct Mode is available */
+#define HV_X64_STIMER_DIRECT_MODE_AVAILABLE	(1 << 19)
+
 /*
  * Feature identification: EBX indicates which flags were specified at
  * partition creation. The format is the same as the partition creation
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 85eb5fc180c8..dfcb8d2a88ae 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -37,6 +37,7 @@ EXPORT_SYMBOL_GPL(ms_hyperv);
 
 #if IS_ENABLED(CONFIG_HYPERV)
 static void (*vmbus_handler)(void);
+static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
 static void (*hv_crash_handler)(struct pt_regs *regs);
 
@@ -69,6 +70,41 @@ void hv_remove_vmbus_irq(void)
 EXPORT_SYMBOL_GPL(hv_setup_vmbus_irq);
 EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
 
+/*
+ * Routines to do per-architecture handling of stimer0
+ * interrupts when in Direct Mode
+ */
+
+__visible void __irq_entry hv_stimer0_vector_handler(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	entering_irq();
+	inc_irq_stat(hyperv_stimer0_count);
+	if (hv_stimer0_handler)
+		hv_stimer0_handler();
+	ack_APIC_irq();
+
+	exiting_irq();
+	set_irq_regs(old_regs);
+}
+
+int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
+{
+	*vector = HYPERV_STIMER0_VECTOR;
+	*irq = 0;   /* Unused on x86/x64 */
+	hv_stimer0_handler = handler;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_setup_stimer0_irq);
+
+void hv_remove_stimer0_irq(int irq)
+{
+	/* We have no way to deallocate the interrupt gate */
+	hv_stimer0_handler = NULL;
+}
+EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
+
 void hv_setup_kexec_handler(void (*handler)(void))
 {
 	hv_kexec_handler = handler;
@@ -249,8 +285,11 @@ static void __init ms_hyperv_init_platform(void)
 	 */
 	x86_platform.apic_post_init = hyperv_init;
 	hyperv_setup_mmu_ops();
-	/* Setup the IDT for hypervisor callback */
+	/* Setup the IDTs for hypervisor callback and for stimer0 */
 	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, hyperv_callback_vector);
+	if (ms_hyperv.misc_features & HV_X64_STIMER_DIRECT_MODE_AVAILABLE)
+		alloc_intr_gate(HYPERV_STIMER0_VECTOR,
+				hv_stimer0_callback_vector);
 #endif
 }
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 68e1867cca80..e1154f0b582c 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -141,6 +141,15 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 				   irq_stats(j)->irq_hv_callback_count);
 		seq_puts(p, "  Hypervisor callback interrupts\n");
 	}
+#endif
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (test_bit(HYPERV_STIMER0_VECTOR, system_vectors)) {
+		seq_printf(p, "%*s: ", prec, "HVS");
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ",
+				   irq_stats(j)->hyperv_stimer0_count);
+		seq_puts(p, "  Hyper-V stimer0 interrupts\n");
+	}
 #endif
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
 #if defined(CONFIG_X86_IO_APIC)
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 31142b72f1b9..4d56cc3a8dad 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -27,7 +27,7 @@
 #include <linux/vmalloc.h>
 #include <linux/hyperv.h>
 #include <linux/version.h>
-#include <linux/interrupt.h>
+#include <linux/random.h>
 #include <linux/clockchips.h>
 #include <asm/hyperv.h>
 #include <asm/mshyperv.h>
@@ -38,6 +38,17 @@ struct hv_context hv_context = {
 	.synic_initialized	= false,
 };
 
+/*
+ * If false, we're using the old mechanism for stimer0 interrupts
+ * where it sends a VMbus message when it expires. The old
+ * mechanism is used when running on older versions of Hyper-V
+ * that don't support Direct Mode. While Hyper-V provides
+ * four stimer's per CPU, Linux uses only stimer0.
+ */
+static bool direct_mode_enabled;
+static int stimer0_irq;
+static int stimer0_vector;
+
 #define HV_TIMER_FREQUENCY (10 * 1000 * 1000) /* 100ns period */
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
@@ -53,6 +64,8 @@ int hv_init(void)
 	if (!hv_context.cpu_context)
 		return -ENOMEM;
 
+	direct_mode_enabled = ms_hyperv.misc_features &
+			HV_X64_STIMER_DIRECT_MODE_AVAILABLE;
 	return 0;
 }
 
@@ -91,6 +104,21 @@ int hv_post_message(union hv_connection_id connection_id,
 	return status & 0xFFFF;
 }
 
+/*
+ * ISR for when stimer0 is operating in Direct Mode.  Direct Mode
+ * does not use VMbus or any VMbus messages, so process here and not
+ * in the VMbus driver code.
+ */
+
+static void hv_stimer0_isr(void)
+{
+	struct hv_per_cpu_context *hv_cpu;
+
+	hv_cpu = this_cpu_ptr(hv_context.cpu_context);
+	hv_cpu->clk_evt->event_handler(hv_cpu->clk_evt);
+	add_interrupt_randomness(stimer0_vector, 0);
+}
+
 static int hv_ce_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
 {
@@ -108,6 +136,8 @@ static int hv_ce_shutdown(struct clock_event_device *evt)
 {
 	hv_init_timer(HV_X64_MSR_STIMER0_COUNT, 0);
 	hv_init_timer_config(HV_X64_MSR_STIMER0_CONFIG, 0);
+	if (direct_mode_enabled)
+		hv_disable_stimer0_percpu_irq(stimer0_irq);
 
 	return 0;
 }
@@ -116,9 +146,29 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
 {
 	union hv_timer_config timer_cfg;
 
+	timer_cfg.as_uint64 = 0;
 	timer_cfg.enable = 1;
 	timer_cfg.auto_enable = 1;
-	timer_cfg.sintx = VMBUS_MESSAGE_SINT;
+	if (direct_mode_enabled)
+		/*
+		 * When it expires, the timer will directly interrupt
+		 * on the specified hardware vector/IRQ.
+		 */
+		{
+		timer_cfg.direct_mode = 1;
+		timer_cfg.apic_vector = stimer0_vector;
+		hv_enable_stimer0_percpu_irq(stimer0_irq);
+		}
+	else
+		/*
+		 * When it expires, the timer will generate a VMbus message,
+		 * to be handled by the normal VMbus interrupt handler.
+		 */
+		{
+		timer_cfg.direct_mode = 0;
+		timer_cfg.sintx = VMBUS_MESSAGE_SINT;
+		}
+
 	hv_init_timer_config(HV_X64_MSR_STIMER0_CONFIG, timer_cfg.as_uint64);
 
 	return 0;
@@ -191,6 +241,10 @@ int hv_synic_alloc(void)
 		INIT_LIST_HEAD(&hv_cpu->chan_list);
 	}
 
+	if (direct_mode_enabled && hv_setup_stimer0_irq(
+		&stimer0_irq, &stimer0_vector, hv_stimer0_isr))
+		goto err;
+
 	return 0;
 err:
 	return -ENOMEM;
@@ -292,6 +346,9 @@ void hv_synic_clockevents_cleanup(void)
 	if (!(ms_hyperv.features & HV_X64_MSR_SYNTIMER_AVAILABLE))
 		return;
 
+	if (direct_mode_enabled)
+		hv_remove_stimer0_irq(stimer0_irq);
+
 	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 22300ec7b556..36d34fe3ccb3 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -57,7 +57,9 @@ union hv_timer_config {
 		u64 periodic:1;
 		u64 lazy:1;
 		u64 auto_enable:1;
-		u64 reserved_z0:12;
+		u64 apic_vector:8;
+		u64 direct_mode:1;
+		u64 reserved_z0:3;
 		u64 sintx:4;
 		u64 reserved_z1:44;
 	};
-- 
2.15.1
