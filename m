Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-703119-1520227153-2-3305709430836791936
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227152; b=mfb7kIUbnA83O5HE+tfBuqN8XJgN5oKdTWMyvUpRWPHwgAE
    Kr6u+/NYplc+cg1AqhEtuLZM31m8P6uGlYuy3ylunfikDQGnZaLbSPjJdiDAO19k
    re8RktAVTSxW0NB1YjM3C9RuiPnm1eo74QTfNju6/6yMwZfMIaqvJKV+7/+KPsxw
    ASZjuI1fYWAGmft1LwT3KG3Zkv7pqaXn94iCuNO+OPu+9LWyiCxHDViL6HURm356
    541jools0qhBvjJ45RkN3RMVtUETf0qyU6Gw/+PrNWxIVNxyiZEyw2/sNGaHbXsh
    n8W5UTF1iu5LQBHov1achiXNr11OXhqZ/G3zgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:cc:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227152; bh=iR0Ypt540VVBKqQIy1SC22eshmgvtcqyJgJdh3cncIo=; b=w
    IQmGMuCgssw2cFI8pF8nGY/kSfYY0DBmXSwvCC6zdYote+AGfYNgd9VV5jX/bV28
    3MbNwwXzl7NcrS+oJjrgUrQ1h+DADIg11t6lC4rJorfWb8BJJ1wR/QlOLpP1R/oi
    EAgN8ubgAHuVEKQOV1Iaryj5kSMnJvZUA1/atT5tx/11BwlosP+oapvfafrnwzDW
    jaANfWM7neqQlzAC4AGCHmXui7cYoszrhIN147wAllNA5ZcYiDPlnZ4pa6lBtfHi
    ZwBhKV67Lv7w54OLfwR+fw11myLWKTPfwRLQVwX1EAjt+WkCaaQrtMVVr/H8+PY3
    B6NyCKienv6x5UwVSSKFg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 08/12] Drivers: hv: vmbus: Implement Direct Mode for stimer0
Date: Sun,  4 Mar 2018 22:17:18 -0700
Message-Id: <20180305051722.19157-8-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051722.19157-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
 <20180305051722.19157-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfOOgjQbpPLEUACaNnRs532IZZhW10v2/CAvkpP8QMK38D5DC67IgtyT/OHtKlK+5mjKbPeFz3UPXZqLwpfv11xvUugHnytD+cR0gP9X27wKzA7mhHGrQ
 m6ZNpALEhnzk8IWiK6gUhQ85SB4/jTxJfXfTqqRqeVw9Mf0F2JjLGaW6xqVmV/kfnwfflPkLWNPJSOx8bEvJSQnapCE+MBLpVdewuCv+95yRDkQsHyppp8Ct
 JjCdlGKSAmyqZEtOiR3gheTEGqn56p5XgLPHRK9maUIKbGqF6x9hA806ywiHNhHFl18Hr2fpMbSqw2sZYWJYw36YH2iA9BP9WO3PqSlukf8lTRRUXz7x1gkC
 Dz+f/CtPcmLp9VOn7tkLqNy2vztMx9N0kJOtzvWaqxQ8SJWyp22+B24kX4Cl+n5AziBWSmNmlAhUbYtQ4MQB3H9YYXQn/xfYLoZaN+Id/hDRCJPUQD3z7Bkr
 Xdrj9ysu/6k0cMnpA7+A/C/pgFqyO5MBijyOgUdM83CWqebPptdbnkuEqVSoRwQGvsSUo8NH61XBvk9cclrX9x63MAwZtl4XOZevqn/V+7djfvFh4XD4zBfR
 fAiwzlwkToVeLOCx020/DCmipfEYj0kqlOF2RERdKMCtZnDG3E8A1O3Ze+giihLg/xA=
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
Cc: Michael Kelley <mhkelley@outlook.com>,
 Michael Kelley <mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Kelley <mhkelley@outlook.com>

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
 arch/x86/entry/entry_64.S          |  3 ++
 arch/x86/include/asm/hardirq.h     |  1 +
 arch/x86/include/asm/irq_vectors.h |  3 +-
 arch/x86/include/asm/mshyperv.h    | 13 +++++++++
 arch/x86/include/uapi/asm/hyperv.h |  3 ++
 arch/x86/kernel/cpu/mshyperv.c     | 40 ++++++++++++++++++++++++++
 arch/x86/kernel/irq.c              |  7 +++++
 drivers/hv/hv.c                    | 59 ++++++++++++++++++++++++++++++++++++--
 drivers/hv/hyperv_vmbus.h          |  4 ++-
 10 files changed, 131 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 16c2c022540d..e12d60873376 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -903,6 +903,9 @@ BUILD_INTERRUPT3(hyperv_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
 BUILD_INTERRUPT3(hyperv_reenlightenment_vector, HYPERV_REENLIGHTENMENT_VECTOR,
 		 hyperv_reenlightenment_intr)
 
+BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
+		 hv_stimer0_vector_handler)
+
 #endif /* CONFIG_HYPERV */
 
 ENTRY(page_fault)
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8971bd64d515..606118459133 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1106,6 +1106,9 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
 
 apicinterrupt3 HYPERV_REENLIGHTENMENT_VECTOR \
 	hyperv_reenlightenment_vector hyperv_reenlightenment_intr
+
+apicinterrupt3 HYPERV_STIMER0_VECTOR \
+	hv_stimer0_callback_vector hv_stimer0_vector_handler
 #endif /* CONFIG_HYPERV */
 
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 7c341a74ec8c..5ea2afd4c871 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -40,6 +40,7 @@ typedef struct {
 #endif
 #if IS_ENABLED(CONFIG_HYPERV)
 	unsigned int irq_hv_reenlightenment_count;
+	unsigned int hyperv_stimer0_count;
 #endif
 } ____cacheline_aligned irq_cpustat_t;
 
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index e71c1120426b..404c5fdff859 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -106,9 +106,10 @@
 
 #if IS_ENABLED(CONFIG_HYPERV)
 #define HYPERV_REENLIGHTENMENT_VECTOR	0xee
+#define HYPERV_STIMER0_VECTOR		0xed
 #endif
 
-#define LOCAL_TIMER_VECTOR		0xed
+#define LOCAL_TIMER_VECTOR		0xec
 
 #define NR_VECTORS			 256
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 25283f7eb299..e73c4d0c06ad 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -173,6 +173,19 @@ void hv_remove_kexec_handler(void);
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
index 099414345865..6c0c3a3b631c 100644
--- a/arch/x86/include/uapi/asm/hyperv.h
+++ b/arch/x86/include/uapi/asm/hyperv.h
@@ -77,6 +77,9 @@
 /* Crash MSR available */
 #define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE (1 << 10)
 
+/* stimer Direct Mode is available */
+#define HV_X64_STIMER_DIRECT_MODE_AVAILABLE	(1 << 19)
+
 /*
  * Feature identification: EBX indicates which flags were specified at
  * partition creation. The format is the same as the partition creation
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 9340f41ce8d3..4488cf0dd499 100644
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
@@ -257,6 +293,10 @@ static void __init ms_hyperv_init_platform(void)
 		alloc_intr_gate(HYPERV_REENLIGHTENMENT_VECTOR,
 				hyperv_reenlightenment_vector);
 
+	/* Setup the IDT for stimer0 */
+	if (ms_hyperv.misc_features & HV_X64_STIMER_DIRECT_MODE_AVAILABLE)
+		alloc_intr_gate(HYPERV_STIMER0_VECTOR,
+				hv_stimer0_callback_vector);
 #endif
 }
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 45fb4d2565f8..328d027d829d 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -150,6 +150,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 				   irq_stats(j)->irq_hv_reenlightenment_count);
 		seq_puts(p, "  Hyper-V reenlightenment interrupts\n");
 	}
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
index 31142b72f1b9..b1f6793acf4c 100644
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
@@ -116,11 +146,26 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
 {
 	union hv_timer_config timer_cfg;
 
+	timer_cfg.as_uint64 = 0;
 	timer_cfg.enable = 1;
 	timer_cfg.auto_enable = 1;
-	timer_cfg.sintx = VMBUS_MESSAGE_SINT;
+	if (direct_mode_enabled) {
+		/*
+		 * When it expires, the timer will directly interrupt
+		 * on the specified hardware vector/IRQ.
+		 */
+		timer_cfg.direct_mode = 1;
+		timer_cfg.apic_vector = stimer0_vector;
+		hv_enable_stimer0_percpu_irq(stimer0_irq);
+	} else {
+		/*
+		 * When it expires, the timer will generate a VMbus message,
+		 * to be handled by the normal VMbus interrupt handler.
+		 */
+		timer_cfg.direct_mode = 0;
+		timer_cfg.sintx = VMBUS_MESSAGE_SINT;
+	}
 	hv_init_timer_config(HV_X64_MSR_STIMER0_CONFIG, timer_cfg.as_uint64);
-
 	return 0;
 }
 
@@ -191,6 +236,11 @@ int hv_synic_alloc(void)
 		INIT_LIST_HEAD(&hv_cpu->chan_list);
 	}
 
+	if (direct_mode_enabled &&
+	    hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
+				hv_stimer0_isr))
+		goto err;
+
 	return 0;
 err:
 	return -ENOMEM;
@@ -292,6 +342,9 @@ void hv_synic_clockevents_cleanup(void)
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

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
