Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AB8JxZp0/h0Z11PJNK28Pc03CgLbTu7d6nk2EwhTXzaRB/MM9nLgoBKPkopB+SY6LazA03Zbyf9u
ARC-Seal: i=1; a=rsa-sha256; t=1524680034; cv=none;
        d=google.com; s=arc-20160816;
        b=mOPDQHXVloOMWULIE1cbX+J2AkIP4L5hvA5nH3GRDeKxEVUC+rK7NP4j1XJU+9IE/9
         dt7GmUe+3xgaWdJfmKZeCKfdniQdPz13nciiShGdXgR7K0viKNSmfYO1vVfU1kCE9AiB
         lzY9Q+xqWqczsLnaEWrs3ALIPiFOrXj8PKm+rZRH64XEhJpFwI9x3V/RA3pNr8jvxecr
         n4AXYtH0AAfTEuI+G6spKNQNHP+/oiN94vcnpkbhIBUQ8mUCtSuuW6K3wJPVS0X+v3ZL
         gSlHBMDIazgQUEwf2mNfGLVYiCReRUdb50aC68wfhnQNuEFoP+dxpRD4DqNN1LiUsBtj
         3hPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=HPC63XYpCM3Ww/njyWvhWkZ7etFT0nHgsXwOJQ/pX7Y=;
        b=qPIWPu/DQk47cjRRBPJTtDXsLOXJFzYJ25KI1MQySbDbxnQtuE3PpljZg/D4MGyk2+
         gtdIDrP//WItRlxBGLuLO0bqvfEJjDg0+uBWL7FjGWWT9wdymi1OMsclqXLmZGdbtE2h
         2vV9g0shgU2wo7f/6/EVwK5PuVtrsMy1+5rpv1z+UGIJHo1WTBLAzVzqhCwRA1+TYtPl
         aStVzLVUylA3qB+2uUP9fDTV4fKbtNbgJRfsJ+qoOuyRli6cbrwPi/5BaKcr4mL8D53l
         BO3Aq+BaF8PRu/o47vik683tXKUqJY5u4baoyKWuKhmDqRJxdCtdn9S7YGxFyDxgXv9q
         suQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.37 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.37 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	jasowang@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	sthemmin@microsoft.com,
	Michael.H.Kelley@microsoft.com,
	vkuznets@redhat.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Date: Wed, 25 Apr 2018 11:12:47 -0700
Message-Id: <20180425181250.8740-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180425181250.8740-1-kys@linuxonhyperv.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfJ8+7o4D3s0+1/XpeFTRuyqQx8ZTmYCzxn+Vk/8L32uWnwJZ3sKHbJSF+Uv9Orb0nWOEjB/CK1B8qJr5bsWdGNR2n/AekVJ09hzXq/f87iwbvi6YUR7D
 ASYc19uDndc92SJirBUZB+Mm/6B0G3D07/cZArx8YrEp+vD0SsY9h5HcOn5TLk+CfGY6989j/o5M4PPmUK8Y8u4FiVcXsZ95aSMzLgf2U47oars4XkVnQVsy
 Poi1Vx4f13idwSTNdYQmOVajdkdIudX1JF9ilcmeNIvWzNQv9BRNsI2NEuzD5M/TIOw78GYs1nStSSHKmbJ+F0xqzUvxaLeol7mHrzAZiFys15MfhbEyK+SQ
 +6mEkOgj3I8w0pdrPl+TZdW2RUA9FRhwDwbKE+lprmKyz0s0ygYqQLRHhFVpE6PqncOPwHXZztolH5rBghMQ9wh46h8vH8lOG2jXwtGsvRv3nkgrkvG/qJqy
 bLKkjw7Q0rScluM0fVUfZPHt5+cW1u3lYaoWD/a62whkYGSmierB3ktiEvAD9bAmlGQ09Fuzpknf9cwQ0L1XzbP8zCr5+J55FDVr+55X+APj0ZHxpur2jfQ4
 G3SsWIP8nWmEuMsVamOmBu8J
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598742891291551096?=
X-GMAIL-MSGID: =?utf-8?q?1598742891291551096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Hyper-V supports hypercalls to implement IPI; use them.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c          | 125 +++++++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c          |  17 +++++
 arch/x86/include/asm/hyperv-tlfs.h |   9 +++
 arch/x86/include/asm/mshyperv.h    |   1 +
 4 files changed, 152 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index e0a5b36208fc..7f3322ecfb01 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -30,6 +30,14 @@
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
 
+struct ipi_arg_non_ex {
+	u32 vector;
+	u32 reserved;
+	u64 cpu_mask;
+};
+
+static struct apic orig_apic;
+
 static u64 hv_apic_icr_read(void)
 {
 	u64 reg_val;
@@ -85,8 +93,125 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
 	wrmsr(HV_X64_MSR_EOI, val, 0);
 }
 
+/*
+ * IPI implementation on Hyper-V.
+ */
+
+static int __send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	int cur_cpu, vcpu;
+	struct ipi_arg_non_ex **arg;
+	struct ipi_arg_non_ex *ipi_arg;
+	int ret = 1;
+	unsigned long flags;
+
+	if (cpumask_empty(mask))
+		return 0;
+
+	if (!hv_hypercall_pg)
+		return ret;
+
+	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
+		return ret;
+
+	local_irq_save(flags);
+	arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	ipi_arg = *arg;
+	if (unlikely(!ipi_arg))
+		goto ipi_mask_done;
+
+
+	ipi_arg->vector = vector;
+	ipi_arg->reserved = 0;
+	ipi_arg->cpu_mask = 0;
+
+	for_each_cpu(cur_cpu, mask) {
+		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
+		if (vcpu >= 64)
+			goto ipi_mask_done;
+
+		__set_bit(vcpu, (unsigned long *)&ipi_arg->cpu_mask);
+	}
+
+	ret = hv_do_hypercall(HVCALL_SEND_IPI, ipi_arg, NULL);
+
+ipi_mask_done:
+	local_irq_restore(flags);
+	return ret;
+}
+
+static int __send_ipi_one(int cpu, int vector)
+{
+	struct cpumask mask = CPU_MASK_NONE;
+
+	cpumask_set_cpu(cpu, &mask);
+	return __send_ipi_mask(&mask, vector);
+}
+
+static void hv_send_ipi(int cpu, int vector)
+{
+	if (__send_ipi_one(cpu, vector))
+		orig_apic.send_IPI(cpu, vector);
+}
+
+static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	if (__send_ipi_mask(mask, vector))
+		orig_apic.send_IPI_mask(mask, vector);
+}
+
+static void hv_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
+{
+	unsigned int this_cpu = smp_processor_id();
+	struct cpumask new_mask;
+	const struct cpumask *local_mask;
+
+	cpumask_copy(&new_mask, mask);
+	cpumask_clear_cpu(this_cpu, &new_mask);
+	local_mask = &new_mask;
+	if (__send_ipi_mask(local_mask, vector))
+		orig_apic.send_IPI_mask_allbutself(mask, vector);
+}
+
+static void hv_send_ipi_allbutself(int vector)
+{
+	hv_send_ipi_mask_allbutself(cpu_online_mask, vector);
+}
+
+static void hv_send_ipi_all(int vector)
+{
+	if (__send_ipi_mask(cpu_online_mask, vector))
+		orig_apic.send_IPI_all(vector);
+}
+
+static void hv_send_ipi_self(int vector)
+{
+	if (__send_ipi_one(smp_processor_id(), vector))
+		orig_apic.send_IPI_self(vector);
+}
+
 void __init hv_apic_init(void)
 {
+	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
+		if (hyperv_pcpu_input_arg == NULL)
+			goto msr_based_access;
+
+		pr_info("Hyper-V: Using IPI hypercalls\n");
+		/*
+		 * Set the IPI entry points.
+		 */
+		orig_apic = *apic;
+
+		apic->send_IPI = hv_send_ipi;
+		apic->send_IPI_mask = hv_send_ipi_mask;
+		apic->send_IPI_mask_allbutself = hv_send_ipi_mask_allbutself;
+		apic->send_IPI_allbutself = hv_send_ipi_allbutself;
+		apic->send_IPI_all = hv_send_ipi_all;
+		apic->send_IPI_self = hv_send_ipi_self;
+	}
+
+msr_based_access:
 	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
 		pr_info("Hyper-V: Using MSR ased APIC access\n");
 		apic_set_eoi_write(hv_apic_eoi_write);
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 71e50fc2b7ef..a895662b6b4c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -91,12 +91,19 @@ EXPORT_SYMBOL_GPL(hv_vp_index);
 struct hv_vp_assist_page **hv_vp_assist_page;
 EXPORT_SYMBOL_GPL(hv_vp_assist_page);
 
+void  __percpu **hyperv_pcpu_input_arg;
+EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
+
 u32 hv_max_vp_index;
 
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
+	void **input_arg;
+
+	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	*input_arg = page_address(alloc_page(GFP_ATOMIC));
 
 	hv_get_vp_index(msr_vp_index);
 
@@ -217,6 +224,10 @@ static int hv_cpu_die(unsigned int cpu)
 {
 	struct hv_reenlightenment_control re_ctrl;
 	unsigned int new_cpu;
+	void **input_arg;
+
+	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	free_page((unsigned long)*input_arg);
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
@@ -260,6 +271,12 @@ void __init hyperv_init(void)
 	if ((ms_hyperv.features & required_msrs) != required_msrs)
 		return;
 
+	/* Allocate the per-CPU state for the hypercall input arg */
+	hyperv_pcpu_input_arg = alloc_percpu(void  *);
+
+	if (hyperv_pcpu_input_arg == NULL)
+		return;
+
 	/* Allocate percpu VP index */
 	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
 				    GFP_KERNEL);
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 416cb0e0c496..646cf2ca2aaa 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -164,6 +164,11 @@
  */
 #define HV_X64_DEPRECATING_AEOI_RECOMMENDED	(1 << 9)
 
+/*
+ * Recommend using cluster IPI hypercalls.
+ */
+#define HV_X64_CLUSTER_IPI_RECOMMENDED         (1 << 10)
+
 /* Recommend using the newer ExProcessorMasks interface */
 #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)
 
@@ -329,10 +334,14 @@ struct hv_tsc_emulation_status {
 #define HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_MASK	\
 		(~((1ull << HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_SHIFT) - 1))
 
+#define HV_IPI_LOW_VECTOR	0x10
+#define HV_IPI_HIGH_VECTOR	0xff
+
 /* Declare the various hypercall operations. */
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
 #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
+#define HVCALL_SEND_IPI				0x000b
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX  0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX   0x0014
 #define HVCALL_POST_MESSAGE			0x005c
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index bcced50037c1..f6045f3611de 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -122,6 +122,7 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
 #if IS_ENABLED(CONFIG_HYPERV)
 extern struct clocksource *hyperv_cs;
 extern void *hv_hypercall_pg;
+extern void  __percpu  **hyperv_pcpu_input_arg;
 
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
-- 
2.15.1
