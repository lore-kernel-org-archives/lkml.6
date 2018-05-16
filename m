Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-968028-1526507687-2-4461919058368232222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526507686; b=ZYo7tCOYMWaQFn9DU3ftbuIEC7WiqjCNsHJwYrTBJrcqPZ0W+h
    A7NTMgIL1fC4CK5QGryfhMZp98NdGXohJSASyiG1KqxHBHQPxd4Wm1hklIHdT6gn
    dF7lU2LXtnrod3vfGNJykmq7jxzeW3DEZFHfnkx8ant0SlayDQ+LDur1bbRgv2Vs
    /EKSbGqxmAlCeDm89Sz791HLCbXVvgYPW+8daOapPGFM2dO5baw5tisiaWmQIl0b
    qp0t2M4YD+NRg8NDDbCGyglxfXqykU0ycG5jFNg/h/qqossYOdOVQSH3fKcQBMWl
    793Aq+kRzIKteliLlcjRuUe7rhg3I9Ronbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1526507686; bh=Ym37+g2qqVqX7JOyb7PipOHNyLlxanRTrqBQWtmptpg=; b=e
    y6mVPWCXcfDPPSNYa8Qo0R7n7SMyULyVlzzK9gy8gi6BqRhF9/hzHb08Uf43u3uf
    /UaJGXHKjTqOtDGowiH2lIOkzfn1qTnFSZv5bR/hfURAfSXGWF0kIfcCJwQqqwDl
    tvfKaugMq6folm3CxR6HWbYFBKOpR0kUYVjHRgskFAXey8vk10r6V93Bpu/4gCsc
    Zb/eJM1DS+hA4BPpBSCmV2Ztpni19jhkpIPyxsLjLdnXWbKGQR3bHtcmyHzedeXs
    DMgeorHpozR/PPK6KiaUqneRRJ4AwvzGaydWKeLu9hIKp9N8jBa2IvMGtsgJYimZ
    yfG5cl2k0S6kA30uF8dLw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxonhyperv.com
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxonhyperv.com
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAgGTAxt9RTH7Px78CXXT74q3VB/RxVWAlhLJcX4NIRTDtZxB2HyvF0jiIBWvRM/Ia1ik1CLtwFap4UH7uM9jCL/u0q/0dh7EJbCAcO2r/GfIepVCGKR
    9qeck+y+533c6yH69zBZ4kQt6wIoVv4tg6VuRGuEgRz0hxfsWfAf9W4qLy2aBjD0AJkOK7nKTMme4oiuJ1+f3ffZp/vtNBSuYE/DBqbjvlV3sL02t9W0AB+e
    46nUgOMv2AqhhNRJl8VWJg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=B6DdsUvr_YSjyFDRc8kA:9 a=AWzn4iIbjoiPw4bM:21
    a=UsPVE7iq9aVaSCaM:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 jasowang@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V3 2/5] X86: Hyper-V: Enable IPI enlightenments
Date: Wed, 16 May 2018 14:53:31 -0700
Message-Id: <20180516215334.6547-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516215334.6547-1-kys@linuxonhyperv.com>
References: <20180516215144.6481-1-kys@linuxonhyperv.com>
 <20180516215334.6547-1-kys@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfMP0L6ue/h9HFASHrq7rbNUKfc7oDrf8/JtWSrMxjeUUK7kw2+/tHhvxjLUeceGbb0FblBrRQzfjRrNjt0oqmpxCYQpTSACfwwgsbXzrtz8SkfUBfljy
 O1SkeFMV/1itKeEQoOhzmQ0ARL8XY9iT4CC9AQjOMNJAMCL2OA9nd3u3jI2+Ca4vdMipQxuphEH3vo23oKNVNxyEOgtnuAi2ecoO9kxKrPPLfiJke8z0VWJ2
 M13uH/rz22YDeeBKzG/GW4gPm5ldPwTVj9yGGq7rZneChFkgsoXnhrJD4aCWLnoQuoJn+bXRvqZo+QAN0rBtsb2OXrj9A8j9iRQfqtFccFJrschpRW0zx8pu
 VINEjZL1sDLW++TydVWfSnulZT/5q9jrQE6LesSrKBUTBOl03yRQ6loJpqGB0WIwCst65aIPxHKXIjU5FC8//QRhrQP7X0qcKurdmrLsr5FSbMmc8mLgCtAo
 2IU7KiiBIqGD0FAL8m6nIOtkEsHr9mQO/8T3WEWJCjKXpqCeQNG1yarHM+4MeYkx0RGrcE7s9J/iMAX/BoPPaPXosc7fzx7Bo72dF1SfhA1WCOM786r6J5r4
 bs2ZrdRxNm1nHqPt68IpylP+
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

Hyper-V supports hypercalls to implement IPI; use them.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c          | 117 +++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c          |  27 +++++++
 arch/x86/include/asm/hyperv-tlfs.h |  15 ++++
 arch/x86/include/asm/mshyperv.h    |   1 +
 4 files changed, 160 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index ca20e31d311c..3e0de61f1a7c 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -33,6 +33,8 @@
 #ifdef CONFIG_X86_64
 #if IS_ENABLED(CONFIG_HYPERV)
 
+static struct apic orig_apic;
+
 static u64 hv_apic_icr_read(void)
 {
 	u64 reg_val;
@@ -88,8 +90,123 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
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
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
