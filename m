Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749C0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F9D24899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F9D24899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754462AbeGCHFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:05:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbeGCHFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:05:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6375QhK189945
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 00:05:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6375PfI189942;
        Tue, 3 Jul 2018 00:05:25 -0700
Date:   Tue, 3 Jul 2018 00:05:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-58ec5e9c9044bd7e1c0bcc6ad822b2e909f49732@git.kernel.org>
Cc:     haiyangz@microsoft.com, Michael.H.Kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, sthemmin@microsoft.com,
        Tianyu.Lan@microsoft.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: haiyangz@microsoft.com, Michael.H.Kelley@microsoft.com,
          kys@microsoft.com, vkuznets@redhat.com, sthemmin@microsoft.com,
          Tianyu.Lan@microsoft.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20180622170625.30688-5-vkuznets@redhat.com>
References: <20180622170625.30688-5-vkuznets@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyper-v: Trace PV IPI send
Git-Commit-ID: 58ec5e9c9044bd7e1c0bcc6ad822b2e909f49732
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  58ec5e9c9044bd7e1c0bcc6ad822b2e909f49732
Gitweb:     https://git.kernel.org/tip/58ec5e9c9044bd7e1c0bcc6ad822b2e909f49732
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Fri, 22 Jun 2018 19:06:25 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 09:00:34 +0200

x86/hyper-v: Trace PV IPI send

Trace Hyper-V PV IPIs the same way we do PV TLB flush.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: devel@linuxdriverproject.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Link: https://lkml.kernel.org/r/20180622170625.30688-5-vkuznets@redhat.com

---
 arch/x86/hyperv/hv_apic.c           |  4 ++++
 arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index ee962784d25b..657a2b8c738a 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -31,6 +31,8 @@
 #include <asm/mshyperv.h>
 #include <asm/apic.h>
 
+#include <asm/trace/hyperv.h>
+
 static struct apic orig_apic;
 
 static u64 hv_apic_icr_read(void)
@@ -134,6 +136,8 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	struct ipi_arg_non_ex ipi_arg;
 	int ret = 1;
 
+	trace_hyperv_send_ipi_mask(mask, vector);
+
 	if (cpumask_empty(mask))
 		return true;
 
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index 4253bca99989..9c0d4b588e3f 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -28,6 +28,21 @@ TRACE_EVENT(hyperv_mmu_flush_tlb_others,
 		      __entry->addr, __entry->end)
 	);
 
+TRACE_EVENT(hyperv_send_ipi_mask,
+	    TP_PROTO(const struct cpumask *cpus,
+		     int vector),
+	    TP_ARGS(cpus, vector),
+	    TP_STRUCT__entry(
+		    __field(unsigned int, ncpus)
+		    __field(int, vector)
+		    ),
+	    TP_fast_assign(__entry->ncpus = cpumask_weight(cpus);
+			   __entry->vector = vector;
+		    ),
+	    TP_printk("ncpus %d vector %x",
+		      __entry->ncpus, __entry->vector)
+	);
+
 #endif /* CONFIG_HYPERV */
 
 #undef TRACE_INCLUDE_PATH
