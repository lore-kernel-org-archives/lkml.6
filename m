Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AB8JxZoVRUYJD2QVTv8AE+Hq3KiYJBA3QN+SYWy/55cnzq7LudEz3Mor6K9mXLbXrpf6CzMv07L/
ARC-Seal: i=1; a=rsa-sha256; t=1525414166; cv=none;
        d=google.com; s=arc-20160816;
        b=AL+CfS5UYWRJJDIphsEPLpP6V2S1tuPyL9KoxkkXBYuwZ+NiSaZtvyQmazvWSa8q2q
         9qN64HM5Br1MubR9qRXR5M0HeaWrwO9rCyjSo/Knxg/TOomxGZaJek48HWGe6qCY0Ab/
         /jFl8/inQxLgt+XrFNrfNPiSk4pef1q4reWveiZ9rfxJMhbVV4sLeNBsvzFF7cxpRyQD
         J6LaJaj8YnjS8lFjKGlkwwbyUNkYRw7cCEZO7cWYKWbcoOp+QVOqaCppT49fK8Gg6MnI
         LT9tovUkpQok1yEspBby1/g8/czbey+oNPXL42++q6bAYAYeqd0cVOj8aaG0j9WbDfuJ
         /9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Bj7pVIWaUFZERTfx5E6Tkge/y1MHZ+1q9D1ZYJyL5Z8=;
        b=riX3nIsjjV6GabVVpbhhulprRUNY8DSmsazQdFBovPc8JBUgihIgwOf8ljLUNSVQdO
         mHB1R1XQEtLaUaH4tzlMtiI87HKYUT8VjTN5ptoj0HsoRt3TUbMHr6jPzSfV7SSuM3V1
         cYMYK0Yto6KDk09j7mjy4FRC/4vNYnKraFBvvNYNoEebQI/WPFBcEC/noqnQxpaZ1+uz
         AjR7hxsdflr8WRkgx5pPuKGUVJwr/atWW25rsx2BRTbO2fdFh5yzq5+JRDkFzfWAWfq7
         yqnFPOY92HOz+W2sy8943cgImr2FMdxdPq9EGjA8r208R4DO8nvCl3trpuuRZU24AnmE
         Pv/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
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
Subject: [PATCH V2 2/5] X86: Hyper-V: Enable IPI enlightenments
Date: Thu,  3 May 2018 23:08:20 -0700
Message-Id: <20180504060823.3345-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180504060823.3345-1-kys@linuxonhyperv.com>
References: <20180504060653.3240-1-kys@linuxonhyperv.com>
 <20180504060823.3345-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfJxoowwJpg6bD+qGFhrS2kwH1RyfGv7DND0ojyFHAFX9aP4dqBq5ZZ1L12KCYIpVZfObmLwZ0ACCOeg4cXPTKIiNNwVhrVn1PWizxB24uG6iB5nt7i7A
 1x72gQsnZ3I9dBJx1m9sriQLXqmfBpmGI9DsIbpxnnvM7HTCIeoTTylDDFwXO37HMldRT3AumRFOhEVAe3hJaEcGoZhRJlK9LAkwAcPnABhhsrssewKgSa0H
 MY6tLCpQcb5VMG15JU1KwfNugEHdg8tu+HbD1OKFXRVSz8iuoSJ/LuTagvUDe19DtE1NBimMQvnCV5Vukpy9hmvQhFWJLZyd1MHZUbQN0qR+KCWVyOvFYV7U
 VHGCiiBdVmXbLqtlBzIFtPxA049rbYsTcIJyaKMuyQs2z9oB34mN4xXP5wD4ue4/TJeK9t+KIh4L9jAS+AazgO9ZJ/RJzTGBh1SxZojOymlgSj6CVPZ47u2o
 uUd3KWGV2ZnXqC6UQp2ZibGmxFSsBcP9nMaiQof9Vn0E6MERjt0ph5gfKabigY/IDRVwOMCWv4F6mBEIQtw1ArSHZ30MhTSHoVdOgjWnCiflzA2PmZXWm8E8
 6dJrSkbM/IF2VesBlrd1ugJo
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599512684545315328?=
X-GMAIL-MSGID: =?utf-8?q?1599512684545315328?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Hyper-V supports hypercalls to implement IPI; use them.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c          | 118 +++++++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c          |  27 +++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  15 +++++
 arch/x86/include/asm/mshyperv.h    |   1 +
 4 files changed, 161 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 41f8b71ca19e..f52d08a7a343 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -31,6 +31,9 @@
 #include <asm/mshyperv.h>
 
 #if IS_ENABLED(CONFIG_HYPERV)
+
+static struct apic orig_apic;
+
 static u64 hv_apic_icr_read(void)
 {
 	u64 reg_val;
@@ -86,8 +89,123 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
 	wrmsr(HV_X64_MSR_EOI, val, 0);
 }
 
+/*
+ * IPI implementation on Hyper-V.
+ */
+static bool __send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	int cur_cpu, vcpu;
+	struct ipi_arg_non_ex **arg;
+	struct ipi_arg_non_ex *ipi_arg;
+	int ret = 1;
+	unsigned long flags;
+
+	if (cpumask_empty(mask))
+		return true;
+
+	if (!hv_hypercall_pg)
+		return false;
+
+	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
+		return false;
+
+	local_irq_save(flags);
+	arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	ipi_arg = *arg;
+	if (unlikely(!ipi_arg))
+		goto ipi_mask_done;
+
+	ipi_arg->vector = vector;
+	ipi_arg->reserved = 0;
+	ipi_arg->cpu_mask = 0;
+
+	for_each_cpu(cur_cpu, mask) {
+		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
+		/*
+		 * This particular version of the IPI hypercall can
+		 * only target upto 64 CPUs.
+		 */
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
+	return ((ret == 0) ? true : false);
+}
+
+static bool __send_ipi_one(int cpu, int vector)
+{
+	struct cpumask mask = CPU_MASK_NONE;
+
+	cpumask_set_cpu(cpu, &mask);
+	return __send_ipi_mask(&mask, vector);
+}
+
+static void hv_send_ipi(int cpu, int vector)
+{
+	if (!__send_ipi_one(cpu, vector))
+		orig_apic.send_IPI(cpu, vector);
+}
+
+static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	if (!__send_ipi_mask(mask, vector))
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
+	if (!__send_ipi_mask(local_mask, vector))
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
+	if (!__send_ipi_mask(cpu_online_mask, vector))
+		orig_apic.send_IPI_all(vector);
+}
+
+static void hv_send_ipi_self(int vector)
+{
+	if (!__send_ipi_one(smp_processor_id(), vector))
+		orig_apic.send_IPI_self(vector);
+}
+
 void __init hv_apic_init(void)
 {
+	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
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
 	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
 		pr_info("Hyper-V: Using MSR based APIC access\n");
 		apic_set_eoi_write(hv_apic_eoi_write);
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 71e50fc2b7ef..6bc90d68ac8b 100644
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
+	*input_arg = page_address(alloc_page(GFP_KERNEL));
 
 	hv_get_vp_index(msr_vp_index);
 
@@ -217,6 +224,16 @@ static int hv_cpu_die(unsigned int cpu)
 {
 	struct hv_reenlightenment_control re_ctrl;
 	unsigned int new_cpu;
+	unsigned long flags;
+	void **input_arg;
+	void *input_pg = NULL;
+
+	local_irq_save(flags);
+	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	input_pg = *input_arg;
+	*input_arg = NULL;
+	local_irq_restore(flags);
+	free_page((unsigned long)input_pg);
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
@@ -260,6 +277,16 @@ void __init hyperv_init(void)
 	if ((ms_hyperv.features & required_msrs) != required_msrs)
 		return;
 
+	/*
+	 * Allocate the per-CPU state for the hypercall input arg.
+	 * If this allocation fails, we will not be able to setup
+	 * (per-CPU) hypercall input page and thus this failure is
+	 * fatal on Hyper-V.
+	 */
+	hyperv_pcpu_input_arg = alloc_percpu(void  *);
+
+	BUG_ON(hyperv_pcpu_input_arg == NULL);
+
 	/* Allocate percpu VP index */
 	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
 				    GFP_KERNEL);
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 416cb0e0c496..332e786d4deb 100644
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
@@ -706,4 +715,10 @@ struct hv_enlightened_vmcs {
 #define HV_STIMER_AUTOENABLE		(1ULL << 3)
 #define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) & 0x0F)
 
+struct ipi_arg_non_ex {
+	u32 vector;
+	u32 reserved;
+	u64 cpu_mask;
+};
+
 #endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 162977b82e2e..1eff91599c2b 100644
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
