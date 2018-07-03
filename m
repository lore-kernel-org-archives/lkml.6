Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83076C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F12124899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F12124899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754558AbeGCHEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:04:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54341 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753983AbeGCHE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:04:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6374K16189834
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 00:04:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6374KEZ189831;
        Tue, 3 Jul 2018 00:04:20 -0700
Date:   Tue, 3 Jul 2018 00:04:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-d8e6b232cfdd5d141c03e40a14c1c781480ea05e@git.kernel.org>
Cc:     kys@microsoft.com, mikelley@microsoft.com,
        Michael.H.Kelley@microsoft.com, haiyangz@microsoft.com,
        hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Tianyu.Lan@microsoft.com, mingo@kernel.org, vkuznets@redhat.com,
        sthemmin@microsoft.com
Reply-To: haiyangz@microsoft.com, hpa@zytor.com, tglx@linutronix.de,
          kys@microsoft.com, mikelley@microsoft.com,
          Michael.H.Kelley@microsoft.com, Tianyu.Lan@microsoft.com,
          mingo@kernel.org, vkuznets@redhat.com, sthemmin@microsoft.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180622170625.30688-3-vkuznets@redhat.com>
References: <20180622170625.30688-3-vkuznets@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyper-v: Use 'fast' hypercall for
 HVCALL_SEND_IPI
Git-Commit-ID: d8e6b232cfdd5d141c03e40a14c1c781480ea05e
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

Commit-ID:  d8e6b232cfdd5d141c03e40a14c1c781480ea05e
Gitweb:     https://git.kernel.org/tip/d8e6b232cfdd5d141c03e40a14c1c781480ea05e
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Fri, 22 Jun 2018 19:06:23 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 09:00:33 +0200

x86/hyper-v: Use 'fast' hypercall for HVCALL_SEND_IPI

Current Hyper-V TLFS (v5.0b) claims that HvCallSendSyntheticClusterIpi
hypercall can't be 'fast' (passing parameters through registers) but
apparently this is not true, Windows always uses 'fast' version. We can
do the same in Linux too.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: devel@linuxdriverproject.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Link: https://lkml.kernel.org/r/20180622170625.30688-3-vkuznets@redhat.com

---
 arch/x86/hyperv/hv_apic.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index f68855499391..90055f89223b 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -128,10 +128,8 @@ ipi_mask_ex_done:
 static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	int cur_cpu, vcpu;
-	struct ipi_arg_non_ex **arg;
-	struct ipi_arg_non_ex *ipi_arg;
+	struct ipi_arg_non_ex ipi_arg;
 	int ret = 1;
-	unsigned long flags;
 
 	if (cpumask_empty(mask))
 		return true;
@@ -145,16 +143,8 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
 		return __send_ipi_mask_ex(mask, vector);
 
-	local_irq_save(flags);
-	arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	ipi_arg = *arg;
-	if (unlikely(!ipi_arg))
-		goto ipi_mask_done;
-
-	ipi_arg->vector = vector;
-	ipi_arg->reserved = 0;
-	ipi_arg->cpu_mask = 0;
+	ipi_arg.vector = vector;
+	ipi_arg.cpu_mask = 0;
 
 	for_each_cpu(cur_cpu, mask) {
 		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
@@ -165,13 +155,13 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 		if (vcpu >= 64)
 			goto ipi_mask_done;
 
-		__set_bit(vcpu, (unsigned long *)&ipi_arg->cpu_mask);
+		__set_bit(vcpu, (unsigned long *)&ipi_arg.cpu_mask);
 	}
 
-	ret = hv_do_hypercall(HVCALL_SEND_IPI, ipi_arg, NULL);
+	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
+				     ipi_arg.cpu_mask);
 
 ipi_mask_done:
-	local_irq_restore(flags);
 	return ((ret == 0) ? true : false);
 }
 
