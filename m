Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AB8JxZoikOEd7gVt4DBoERK8OEU8mUJ5G9W/bwMr3lxWaDJQQLaSc7Y5WLaDny0A2mEIbzaFSHk4
ARC-Seal: i=1; a=rsa-sha256; t=1524680033; cv=none;
        d=google.com; s=arc-20160816;
        b=IcxUgc54eHi+m2SiE37Nqq04+BDb7c/rAy6pf3zKJU4KorSOCNfsEydA2pCwaOjvws
         gvkwDwe3g3gX/sLtt//G9u8yUjBkgxULzd0sq3BIUDz3eqf+0pUsqr28hyIEYWgSSUu6
         JJ7DluRVDVS2e0SdpbfoGwpMHpoQTr1XYJPykK3KfzB/ybXdU0MiNFg5GP1aiOFmetm7
         8Xhvc5Tyd+R8Aeidg4ikvhK8H52fbeoty7D6PKk27+T97YswPuK+yVCCdCg90HjHKj5t
         c2xocnlTaxnbce2gn55MKFQdQxm6/15XHzGIiW0/Q8qgBmbrtREW0MAWmj7RA6o1OMoy
         q/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=XDU37WBeAPvE0180MMqBXluK6Y7Ek0ox3TJsV1NiA+Y=;
        b=T9RzjRkbvryCJqmhEPyUIwSMbrHzD9QWYNHh95xAl3ffBYM6k+XXOT2G+v66HGSLE7
         +6UAqdCyRBL9yV4rnnsW8vsq4TbgOLbODxwmtZAGSBCHiSDusRYXibGf/XJxKzk0/zZH
         EyISOvk99GIQS2QTI188/Bln3c8m40uZz7qDNJSk7+/dOCzeiSem3XqTet2oznV1gvwQ
         VVCgG9CO42IXEj03jzmNa/XXtTnVrJb7fKdw4J5DieZuFXxJU6vgnPKBiNWMhxdYNp13
         B6Q11BnXoewn3q4W7D1KcZElXRrdbeDRjzJcoO7GTL6v0LT74AvdwhfewP/6AqZswmaJ
         WeyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.36 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.36 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
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
Subject: [PATCH 3/5] X86: Hyper-V: Enhanced IPI enlightenment
Date: Wed, 25 Apr 2018 11:12:48 -0700
Message-Id: <20180425181250.8740-3-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180425181250.8740-1-kys@linuxonhyperv.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfP7v1q0aorBWrOHP0MQh3b/BMdehY2Y75Nw+G64D2MnR1iycXBEOEyw7PTUb368mBx+4csPBYSX7LOpqId1613erJlpSTHHfK0dxw1VSzoLNNcLSUmlM
 aF5H98ZMp7KyHgY4oaaIfLAE+eVm2leXnrnHyP0aXGtmmNN8hvSXdeCerwP4b/KuyjXgL+SSyAzk1D4lI96+7F0WrjjbHGHf2TbFcc6BFu37GqavZSQSw5zc
 s+oBmvFXF7YaGgRR5lfDhPbzHAfrUjpLg7PKpo6Fg4WeeFNGNCEx6RDjX09ICDWnYWI4SWhJFT36oZ5g0VX7tNNBz2SbmYM6hO3fXRM+beYdhS6nDc63QfES
 OnH+GFXiaHutxhjf82reYVZm6exT6D2J29sPvjyUqLIZAX2aggl7pqtFb3Uek0qf7e8fyIjLhZEOMJh5oX/oZqUMvs5As8iUUc8XfRaBf141aQ8TWQNeE6ku
 qfvqSD58PgTDkZdfqurz7LyRbxBqS5L34KAP9tCi6LtG6kIx81Hl8ZUZo0Htv4a7S+KvDZO1U5rE3yGmuT1DbiGqap4tEmq/fRUWTCWzVgi/0dhoxuMYWD/c
 VHyrmRSFeAd+aqiWsXwYKze3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598742890886726638?=
X-GMAIL-MSGID: =?utf-8?q?1598742890886726638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Support enhanced IPI enlightenments (to target more than 64 CPUs).

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c          | 49 ++++++++++++++++++++++++++++++++++++--
 arch/x86/include/asm/hyperv-tlfs.h |  1 +
 arch/x86/include/asm/mshyperv.h    | 39 ++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 7f3322ecfb01..fbb408b91e25 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -36,6 +36,12 @@ struct ipi_arg_non_ex {
 	u64 cpu_mask;
 };
 
+struct ipi_arg_ex {
+	u32 vector;
+	u32  reserved;
+	struct hv_vpset vp_set;
+};
+
 static struct apic orig_apic;
 
 static u64 hv_apic_icr_read(void)
@@ -97,6 +103,40 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
  * IPI implementation on Hyper-V.
  */
 
+static int __send_ipi_mask_ex(const struct cpumask *mask, int vector)
+{
+	int nr_bank = 0;
+	struct ipi_arg_ex **arg;
+	struct ipi_arg_ex *ipi_arg;
+	int ret = 1;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	arg = (struct ipi_arg_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	ipi_arg = *arg;
+	if (unlikely(!ipi_arg))
+		goto ipi_mask_ex_done;
+
+	ipi_arg->vector = vector;
+	ipi_arg->reserved = 0;
+	ipi_arg->vp_set.valid_bank_mask = 0;
+
+	if (!cpumask_equal(mask, cpu_present_mask)) {
+		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARCE_4K;
+		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
+	}
+	if (!nr_bank)
+		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
+
+	ret = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
+			      ipi_arg, NULL);
+
+ipi_mask_ex_done:
+	local_irq_restore(flags);
+	return ret;
+}
+
 static int __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	int cur_cpu, vcpu;
@@ -114,6 +154,9 @@ static int __send_ipi_mask(const struct cpumask *mask, int vector)
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return ret;
 
+	if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
+		return __send_ipi_mask_ex(mask, vector);
+
 	local_irq_save(flags);
 	arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
 
@@ -196,8 +239,10 @@ void __init hv_apic_init(void)
 	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
 		if (hyperv_pcpu_input_arg == NULL)
 			goto msr_based_access;
-
-		pr_info("Hyper-V: Using IPI hypercalls\n");
+		if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
+			pr_info("Hyper-V: Using ext hypercalls for IPI\n");
+		else
+			pr_info("Hyper-V: Using IPI hypercalls\n");
 		/*
 		 * Set the IPI entry points.
 		 */
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 646cf2ca2aaa..53ea30d768d9 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -344,6 +344,7 @@ struct hv_tsc_emulation_status {
 #define HVCALL_SEND_IPI				0x000b
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX  0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX   0x0014
+#define HVCALL_SEND_IPI_EX			0x0015
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f6045f3611de..956e8603bed2 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -259,6 +259,45 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
 	return hv_vp_index[cpu_number];
 }
 
+struct hv_vpset {
+	u64 format;
+	u64 valid_bank_mask;
+	u64 bank_contents[];
+};
+
+static inline int cpumask_to_vpset(struct hv_vpset *vpset,
+				    const struct cpumask *cpus)
+{
+	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
+
+	/* valid_bank_mask can represent up to 64 banks */
+	if (hv_max_vp_index / 64 >= 64)
+		return 0;
+
+	/*
+	 * Clear all banks up to the maximum possible bank as hv_flush_pcpu_ex
+	 * structs are not cleared between calls, we risk flushing unneeded
+	 * vCPUs otherwise.
+	 */
+	for (vcpu_bank = 0; vcpu_bank <= hv_max_vp_index / 64; vcpu_bank++)
+		vpset->bank_contents[vcpu_bank] = 0;
+
+	/*
+	 * Some banks may end up being empty but this is acceptable.
+	 */
+	for_each_cpu(cpu, cpus) {
+		vcpu = hv_cpu_number_to_vp_number(cpu);
+		vcpu_bank = vcpu / 64;
+		vcpu_offset = vcpu % 64;
+		__set_bit(vcpu_offset, (unsigned long *)
+			  &vpset->bank_contents[vcpu_bank]);
+		if (vcpu_bank >= nr_bank)
+			nr_bank = vcpu_bank + 1;
+	}
+	vpset->valid_bank_mask = GENMASK_ULL(nr_bank - 1, 0);
+	return nr_bank;
+}
+
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
 void hyper_alloc_mmu(void);
-- 
2.15.1
