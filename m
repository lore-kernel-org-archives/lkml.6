Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AIpwx4+tOyitMjyiPzbaQhoIF9Q0d/QVw8cGvCRPE89ZUQkW3adWl8Kx3Ij3v+0gdYZ13hACJ6CB
ARC-Seal: i=1; a=rsa-sha256; t=1524680034; cv=none;
        d=google.com; s=arc-20160816;
        b=kfmIlDby7NVKOrhcC4nFsoOpKC3kGScgkSiZzN5oP1UBv8f4z8RR4CFZSu2HFzWSfi
         6Hpx4iaSR/J7xSuyNghdzTIoEx2EAt25WoDQPRFkSiCDLbifrggk1VMqdVWYd3NNsW6z
         y6Ap5INN/+TYp8upsvGM7npW1bJ7uT/Puk0TZD3eQX7FObUyVbAreD9nc9vKRHWnREnZ
         4g5lAf2Ie89TmEznBwQWvhoqfA365wwYWrAfxolzkbFD+ROnPX0v3oWz4j29caKlmz3J
         +ltVPtDCI5ypgQj/2VglFMACXW23YDY6AP4aafv9i81dEEGORMSG0nqxTuoKUxdxF+6O
         36KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gFbKq7oglGyheGL061j2i3WsRFbvcSKooT1J5u3wd6o=;
        b=OuZxHvovwf3RaEoOuixA+dXopytw94nqaCaLpkNmoIn/LxHGUPxMpHlsQ4g4nM2vV5
         AQpHRf9noLoJijHeBhYPEeLKGigtza8KwEwca5ehJMcaeEI1YDwFPG3fqJn6d2IzL3EF
         4srfWFm+acoqVoR96SRx+LinQbZMIprtt0LymXJfyvdvapPRYqtF/kn5wgnr6W0LZEuy
         gBbkncrs4nmlmK0hkoOhe8Kf5/fbMAROPBbx5M47Csv/kPwl/zxjy29mpzKrWWcFLsC4
         UuYMIal2IxF00DuoaCqrpjB8GMtAL6l+Zzf6/IbIJvsgsd+IuKfB7IB3I6e+z5U6AlfW
         Ifbg==
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
Subject: [PATCH 5/5] X86: Hyper-V: Consolidate the allocation of the hypercall input page
Date: Wed, 25 Apr 2018 11:12:50 -0700
Message-Id: <20180425181250.8740-5-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180425181250.8740-1-kys@linuxonhyperv.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfF+YQRvckSE3NznmVOAns93K8bIwlSeIowyFdltd7dg61ubPjnN9eF9BpezmYVQsDNMdFT2kBiuVO+PrKc7DO5oh09rKzjnLk+lnNZmsFtVZyvVXfWos
 ouy8STjayzc9inMmpRDRb9XPIvoW2OeveiwZKsups5/E2AZDE9rCxNhtMYVJufSKvXqvT0dUZQBvYged5J46pWNH6TCtmET48T/ueCQ/HbTGZYZb9v999Ijl
 fZuRfKGQYWVQTEzjAxZnfPSJEC3zS8oG6k9HNo0bSiXnY/ZcgUwa3XaFF25tx1j/lURsnbj41Qi+dHvvbmk87C2HwApCV9aLIfq46QyiKdTb/NzyCKs1AxXG
 vjLD3+ygROXbRzFgyA0YNknrdOGDDscAf/H3aN22V28mamRcLZqy5WXkqiCklvHaYvP0EJfLUKvzWCRdcvl9MRSoaBDYQxI/YV3wCw51Dwe5xJk+2p6io0PF
 HhUzd8vzB0HBaoUbJzQN6KMGqNQ68kKSGmkCQrwOIoL/V/FRZFDXS9fL3l5zmna+Upbtg0IHFCQJFbCbXeQPH2CwaB5O+a7MpbhFAPlSctyMQlCN8yJ8+XCa
 8ky5kZc9TLa7VmozTKN6yI1R
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598742891262366400?=
X-GMAIL-MSGID: =?utf-8?q?1598742891262366400?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Consolidate the allocation of the hypercall input page.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  2 --
 arch/x86/hyperv/mmu.c           | 33 +++++++++------------------------
 arch/x86/include/asm/mshyperv.h |  1 -
 3 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a895662b6b4c..72befd0e2c35 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -314,8 +314,6 @@ void __init hyperv_init(void)
 	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
-	hyper_alloc_mmu();
-
 	hv_apic_init();
 
 	/*
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index c9cd28f0bae4..c4466af72e77 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -32,9 +32,6 @@ struct hv_flush_pcpu_ex {
 /* Each gva in gva_list encodes up to 4096 pages to flush */
 #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
 
-static struct hv_flush_pcpu __percpu **pcpu_flush;
-
-static struct hv_flush_pcpu_ex __percpu **pcpu_flush_ex;
 
 /*
  * Fills in gva_list starting from offset. Returns the number of items added.
@@ -77,7 +74,7 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 
 	trace_hyperv_mmu_flush_tlb_others(cpus, info);
 
-	if (!pcpu_flush || !hv_hypercall_pg)
+	if (!hv_hypercall_pg)
 		goto do_native;
 
 	if (cpumask_empty(cpus))
@@ -85,10 +82,8 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 
 	local_irq_save(flags);
 
-	flush_pcpu = this_cpu_ptr(pcpu_flush);
-
-	if (unlikely(!*flush_pcpu))
-		*flush_pcpu = page_address(alloc_page(GFP_ATOMIC));
+	flush_pcpu = (struct hv_flush_pcpu **)
+		     this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	flush = *flush_pcpu;
 
@@ -164,7 +159,7 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
 	trace_hyperv_mmu_flush_tlb_others(cpus, info);
 
-	if (!pcpu_flush_ex || !hv_hypercall_pg)
+	if (!hv_hypercall_pg)
 		goto do_native;
 
 	if (cpumask_empty(cpus))
@@ -172,10 +167,8 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
 	local_irq_save(flags);
 
-	flush_pcpu = this_cpu_ptr(pcpu_flush_ex);
-
-	if (unlikely(!*flush_pcpu))
-		*flush_pcpu = page_address(alloc_page(GFP_ATOMIC));
+	flush_pcpu = (struct hv_flush_pcpu_ex **)
+		     this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	flush = *flush_pcpu;
 
@@ -249,6 +242,9 @@ void hyperv_setup_mmu_ops(void)
 	if (!(ms_hyperv.hints & HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED))
 		return;
 
+	if (hyperv_pcpu_input_arg == NULL)
+		return;
+
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED)) {
 		pr_info("Using hypercall for remote TLB flush\n");
 		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
@@ -257,14 +253,3 @@ void hyperv_setup_mmu_ops(void)
 		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others_ex;
 	}
 }
-
-void hyper_alloc_mmu(void)
-{
-	if (!(ms_hyperv.hints & HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED))
-		return;
-
-	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
-		pcpu_flush = alloc_percpu(struct hv_flush_pcpu *);
-	else
-		pcpu_flush_ex = alloc_percpu(struct hv_flush_pcpu_ex *);
-}
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 956e8603bed2..9931f9908fe2 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -300,7 +300,6 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
-void hyper_alloc_mmu(void);
 void hyperv_report_panic(struct pt_regs *regs, long err);
 bool hv_is_hyperv_initialized(void);
 void hyperv_cleanup(void);
-- 
2.15.1
