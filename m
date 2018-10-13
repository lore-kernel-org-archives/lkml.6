Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E74EC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFE7205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+uV2466"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFE7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeJMWc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:32:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32801 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeJMWc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:32:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id s4-v6so7282942plp.0;
        Sat, 13 Oct 2018 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z2myOoj9IFC9zB8XQQZnHOE6BJZwQlrFqhO+Eu8mLO4=;
        b=t+uV2466XfgOFLuHl6DzFiiuwjVmpzL0K7lBpHsttTwTHEq/B1fDJQgBJ8brLhnfar
         pfWQwdWeGMBU8pxZns4d59yRC9zXXw9fhzbUgid71Wgqwj+piBSCbr/zID9oE8sH4YF7
         H4wgchAMDOtm1cMJEpRoAEy6FTZZwYA0aSn6b6UxJvwlqRPcYINVKnbUormwD44UBTbM
         X+hp+ixotgmNiUFf5/WaNt2m30TFIlHP1E5sa1HMUEVoh0J62ea98DHo+pdSrmSQJLmO
         HATwo/eTxWvj5TsWtA5RtB8c+fFctlDv7cTgMIL3VOdAHCuA/2e2f8wPMG6IAxGWyBO9
         1Olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z2myOoj9IFC9zB8XQQZnHOE6BJZwQlrFqhO+Eu8mLO4=;
        b=iY+jh/U2XuPgT5s5DhJARjR9suuxL7zrMCaRvs9bYPlLxKSxjQsv5T2+mXlgYPpdAD
         Jmgct6oBwe0jdZ5jLmdRktLi6PjqO1xDXJPhGiAZxFhnPw4KmPisX0Pt/LZUycKV+E7P
         QL0sMl74LlfZ0u1v8nnZ+Z+Gp1KjG8g6OVovstGaiafaJCbOiprYs8TGV3Bju1NbR1On
         mCUX0dS9xJlSyo86BxFaqWzRjwAlCBOSobByxE5IMpw2Bxfjb3gMUt6vVf1Cm8Cnd9M2
         YuaffTSiNYiQaHjuxMzJZoWTgWak/pUslUXrHP0PLz4uHsCMNka5n/zQS1OzyYnXJ57z
         ZBkg==
X-Gm-Message-State: ABuFfogzctuHsHC13giWNSJ2A6q/eM7EHJqa5dRIpyvSFj67WAka4xDk
        J5/Jt5o3sKzxeIf+NJlxTFjlsKfEt84=
X-Google-Smtp-Source: ACcGV631lWroPtRgeYzV7XUZoAm6GcI3n8pVNiMq/beeKilrp10gffyDr/4DHkWuaVQlz0ih5nBVAg==
X-Received: by 2002:a17:902:b943:: with SMTP id h3-v6mr10217074pls.5.1539442531071;
        Sat, 13 Oct 2018 07:55:31 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:55:30 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: [PATCH V4 12/15] x86/hyper-v: Add HvFlushGuestAddressList hypercall support
Date:   Sat, 13 Oct 2018 22:54:03 +0800
Message-Id: <20181013145406.4911-13-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Hyper-V provides HvFlushGuestAddressList() hypercall to flush EPT tlb
with specified ranges. This patch is to add the hypercall support.

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v2:
      Fix some coding style issues
        - Move HV_MAX_FLUSH_PAGES and HV_MAX_FLUSH_REP_COUNT to
	hyperv-tlfs.h.
	- Calculate HV_MAX_FLUSH_REP_COUNT in the macro definition
	- Use HV_MAX_FLUSH_REP_COUNT to define length of gpa_list in
	struct hv_guest_mapping_flush_list.

Change since v1:
       Add hyperv tlb flush struct to avoid use kvm tlb flush struct
in the hyperv file.
---
 arch/x86/hyperv/nested.c           | 84 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 32 +++++++++++++++
 arch/x86/include/asm/mshyperv.h    | 16 ++++++++
 3 files changed, 132 insertions(+)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index b8e60cc50461..a6fdfec63c7d 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -7,6 +7,7 @@
  *
  * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
  */
+#define pr_fmt(fmt)  "Hyper-V: " fmt
 
 
 #include <linux/types.h>
@@ -54,3 +55,86 @@ int hyperv_flush_guest_mapping(u64 as)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping);
+
+static int fill_flush_list(union hv_gpa_page_range gpa_list[],
+		int offset, u64 start_gfn, u64 pages)
+{
+	int gpa_n = offset;
+	u64 cur = start_gfn;
+	u64 additional_pages;
+
+	do {
+		/*
+		 * If flush requests exceed max flush count, go back to
+		 * flush tlbs without range.
+		 */
+		if (gpa_n >= HV_MAX_FLUSH_REP_COUNT)
+			return -ENOSPC;
+
+		additional_pages = min_t(u64, pages, HV_MAX_FLUSH_PAGES) - 1;
+
+		gpa_list[gpa_n].page.additional_pages = additional_pages;
+		gpa_list[gpa_n].page.largepage = false;
+		gpa_list[gpa_n].page.basepfn = cur;
+
+		pages -= additional_pages + 1;
+		cur += additional_pages + 1;
+		gpa_n++;
+	} while (pages > 0);
+
+	return gpa_n;
+}
+
+int hyperv_flush_guest_mapping_range(u64 as, struct hyperv_tlb_range *range)
+{
+	struct hv_guest_mapping_flush_list **flush_pcpu;
+	struct hv_guest_mapping_flush_list *flush;
+	u64 status = 0;
+	unsigned long flags;
+	int ret = -ENOTSUPP;
+	int gpa_n = 0;
+
+	if (!hv_hypercall_pg)
+		goto fault;
+
+	local_irq_save(flags);
+
+	flush_pcpu = (struct hv_guest_mapping_flush_list **)
+		this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	flush = *flush_pcpu;
+	if (unlikely(!flush)) {
+		local_irq_restore(flags);
+		goto fault;
+	}
+
+	flush->address_space = as;
+	flush->flags = 0;
+
+	if (!range->flush_list)
+		gpa_n = fill_flush_list(flush->gpa_list, gpa_n,
+				range->start_gfn, range->pages);
+	else if (range->parse_flush_list_func)
+		gpa_n = range->parse_flush_list_func(flush->gpa_list, gpa_n,
+				range->flush_list, fill_flush_list);
+	else
+		gpa_n = -1;
+
+	if (gpa_n < 0) {
+		local_irq_restore(flags);
+		goto fault;
+	}
+
+	status = hv_do_rep_hypercall(HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST,
+				     gpa_n, 0, flush, NULL);
+
+	local_irq_restore(flags);
+
+	if (!(status & HV_HYPERCALL_RESULT_MASK))
+		ret = 0;
+	else
+		ret = status;
+fault:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping_range);
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 00e01d215f74..cf59250c284a 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -10,6 +10,7 @@
 #define _ASM_X86_HYPERV_TLFS_H
 
 #include <linux/types.h>
+#include <asm/page.h>
 
 /*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
@@ -353,6 +354,7 @@ struct hv_tsc_emulation_status {
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
+#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 
 #define HV_X64_MSR_VP_ASSIST_PAGE_ENABLE	0x00000001
 #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
@@ -752,6 +754,36 @@ struct hv_guest_mapping_flush {
 	u64 flags;
 };
 
+/*
+ *  HV_MAX_FLUSH_PAGES = "additional_pages" + 1. It's limited
+ *  by the bitwidth of "additional_pages" in union hv_gpa_page_range.
+ */
+#define HV_MAX_FLUSH_PAGES (2048)
+
+/* HvFlushGuestPhysicalAddressList hypercall */
+union hv_gpa_page_range {
+	u64 address_space;
+	struct {
+		u64 additional_pages:11;
+		u64 largepage:1;
+		u64 basepfn:52;
+	} page;
+};
+
+/*
+ * All input flush parameters should be in single page. The max flush
+ * count is equal with how many entries of union hv_gpa_page_range can
+ * be populated into the input parameter page.
+ */
+#define HV_MAX_FLUSH_REP_COUNT (PAGE_SIZE - 2 * sizeof(u64) /	\
+				sizeof(union hv_gpa_page_range))
+
+struct hv_guest_mapping_flush_list {
+	u64 address_space;
+	u64 flags;
+	union hv_gpa_page_range gpa_list[HV_MAX_FLUSH_REP_COUNT];
+};
+
 /* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
 struct hv_tlb_flush {
 	u64 address_space;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f37704497d8f..19f49fbcf94d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -22,6 +22,16 @@ struct ms_hyperv_info {
 
 extern struct ms_hyperv_info ms_hyperv;
 
+struct hyperv_tlb_range {
+	u64 start_gfn;
+	u64 pages;
+	struct list_head *flush_list;
+	int (*parse_flush_list_func)(union hv_gpa_page_range gpa_list[],
+		int offset, struct list_head *flush_list,
+		int (*fill_flush_list)(union hv_gpa_page_range gpa_list[],
+		int offset, u64 start_gfn, u64 end_gfn));
+};
+
 /*
  * Generate the guest ID.
  */
@@ -348,6 +358,7 @@ void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
 int hyperv_flush_guest_mapping(u64 as);
+int hyperv_flush_guest_mapping_range(u64 as, struct hyperv_tlb_range *range);
 
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
@@ -368,6 +379,11 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 	return NULL;
 }
 static inline int hyperv_flush_guest_mapping(u64 as) { return -1; }
+static inline int hyperv_flush_guest_mapping_range(u64 as,
+		struct hyperv_tlb_range *range)
+{
+	return -1;
+}
 #endif /* CONFIG_HYPERV */
 
 #ifdef CONFIG_HYPERV_TSCPAGE
-- 
2.14.4

