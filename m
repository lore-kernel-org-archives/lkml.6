Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AB8JxZqmqcacIVQHw35xzNEmuwN0zOF8R9AzwrrZxXybIi0KW9+5Iz3aTvBSdbN1XRcG1Owr5JEE
ARC-Seal: i=1; a=rsa-sha256; t=1525414167; cv=none;
        d=google.com; s=arc-20160816;
        b=qjvQW71y4OSRhDkZS7qm/oVuHbhwsvMJChWREe932kSLM7DTyFkQfW8HmhulRIScGL
         KEOowUkSA/qjwTIi+RhgYEDfQF5/wahaKbIZX7G91Rx9XFp4rR/xW1CuYHRa7PiyfHiV
         W/xZ20szjeIwvyGBo+tcsTTUO1+K9ymIIWBl08CjJ5DAQWKjI6wx9UQ8/GcJIilWnznT
         8zhCGFgbsNzY1iZvaUyCNMQznJSaUta00o8zD31WxTIthhJDqVPTtcTgqnMv3pBqw93Y
         hIo5TjSmk+wFBiUPRNcNiN5DdzcG1xoZuW2jqyfwF/mi5p6U7MbQ379IqeHC1hBcFnTQ
         xciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=wsOqoSrBGHUlsSuoCsJg0k+6yslRYsbQPQUN0IJKxGk=;
        b=EMMVOWIba250nSEVtTqRrWlCSoRzm1bPuSUhR3OAQm84WitObWH2YUASlm2H6efF25
         XuZaiRnNAcUs72aPJ2tM08w5q5dRJfC7Ogc44WMFZ4Qc3o2bS93Mm7ePCi7zqp5XXrwB
         3BHITs59a4nl4eMxADdD3LVIop+fMXjRVvWLJuw5y+M/JeMJBIklISLz/rMXfyh45Srb
         oyjpz8h8QeoxRpVBttE1ztewK8s5vWR4eHZDjsVc5vCDwFtMqFRNAGcLwVpV64cCCf6r
         5TmFShWDgXSO5lUt9I1FTEiu1sq6V2RrK8MfAlheQYe2tCTXvNmbn/lqvV3IZJLuQQd4
         9GLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.49 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.49 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
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
Subject: [PATCH V2 5/5] X86: Hyper-V: Consolidate the allocation of the hypercall input page
Date: Thu,  3 May 2018 23:08:23 -0700
Message-Id: <20180504060823.3345-5-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180504060823.3345-1-kys@linuxonhyperv.com>
References: <20180504060653.3240-1-kys@linuxonhyperv.com>
 <20180504060823.3345-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfNV2JWE5mptplZQi6+0d/8PMi/XWbdIFZknzwmUH0TY7ilibvceNzmk2sGMWBJzZXp7LVJ0ctGWM2WT6wZ1zguowbZNBTpeO5XuFTJcBdr42OE5eRLhE
 Lgx1H5TKYBnI68vHEouX+ufU/6sWl76lpzbQhsxzdi5yPxEUTgwXhd0ybiSf4NxgXF4dQ2evPGdtEX4NY0Y9ZFijTjnJh2BgNxyVTn2bUQOVs5IsEYOjInBJ
 AhJGTgnoLqJ1kjAJfeGOK1r+LCOdp2V06QIIa6qhe4yZyCb8pX6EkPqXyCJet63TpRC/GC8wj/J21DfWTYXVDkPn3PmA34V7AEX23P3fJnze6mAQRCtVLCnf
 iT8qVpLhi1NITpcTIuBJBhzHMFadZpGhCW+2mNH1W5Vabqwa6/c1zptumBxYVcg5BuD1Ydhpxq9kX5SMxz6n+anrWEPAt/kICTcHymroXY8bIKlTcftLU9Qd
 M26VeLtqRc/cvo/EqE53KQ+7OqsIH4tq0rnh4cIZSXawRDBgfuCuzGLm+oKO1DPxqzsI/q+RCaUIF6trEtOBWKRfj+/OUiIPoaVc2KSPS16zE2QwTa67r/1n
 NcYrHgMiyd0Oe1GSEuO1+ame
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599512685928931349?=
X-GMAIL-MSGID: =?utf-8?q?1599512685928931349?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Consolidate the allocation of the hypercall input page.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  2 --
 arch/x86/hyperv/mmu.c           | 30 ++++++------------------------
 arch/x86/include/asm/mshyperv.h |  1 -
 3 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6bc90d68ac8b..4c431e1c1eff 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -324,8 +324,6 @@ void __init hyperv_init(void)
 	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
-	hyper_alloc_mmu();
-
 	hv_apic_init();
 
 	/*
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index c9cd28f0bae4..5f053d7d1bd9 100644
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
 
@@ -257,14 +250,3 @@ void hyperv_setup_mmu_ops(void)
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
index 0ee82519957b..9aaa493f5756 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -294,7 +294,6 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
-void hyper_alloc_mmu(void);
 void hyperv_report_panic(struct pt_regs *regs, long err);
 bool hv_is_hyperv_initialized(void);
 void hyperv_cleanup(void);
-- 
2.15.1
