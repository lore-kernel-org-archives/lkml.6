Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C58C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E13B2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr1Bdd18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfAFNdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 08:33:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45915 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfAFNdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 08:33:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so19512455pgc.12;
        Sun, 06 Jan 2019 05:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vfmcRA7rT28gwHLfFKyRxilDywRI1mQZldc5K70wYIo=;
        b=Jr1Bdd18ae2pQeAlv+/eQfwtdHoqjk1Uq3yzu4EOHfZIKO/6DCPElHbuyEIEikGKIv
         K7n0LACDFZ5Dtd3XcDAiK20vT85yHt5CMM2kIymU9rb43X77OHg+WbhwTDat3ZiIePC0
         BbZWU99fBtSS5WmQfyC8bIejsjFr4Rv6QrP1k2p+7zgwr/UxpTGQjlrrBuBJdHiuX2XJ
         oUkVSUZEEsFvQX8Z/veWfcVBKmxQ2/tzHaev8i3FTVDvGh1vbesW7wCeDSleuBCTFeu4
         bxflowWkZRa9ETEVAih3WJsniAWT74yyEqEk7oYHAYvIM6gVBWt8mZvX9UOdPHbMg0hF
         m1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vfmcRA7rT28gwHLfFKyRxilDywRI1mQZldc5K70wYIo=;
        b=tDPuyfhFrOrQGkEZmbvVAH2fvuGKOEhnJ/zhv2WveTI83/BLHqhew/EhSDGuhkhiM1
         mvU+x78aEC5gLB27kqn5vRRTxxEjHon/4gl7a8+tcN95oDZIeBGJDg5nkiOtvHTETVqA
         fCP2IXJrWRtLVzauGv+uHOVpI2EsH/QecYitNV4IjcA5GO4GQwlOrrmjrtPtuDWWGWcn
         ky63ySnN1dqnUpXTLzVsDDrE8jxJpCSLGEOuhxVXbBSxHyyS21B6oC9zbNlP63KMWgIX
         dmfszyqywz/BzWNoAJ4wzYyc34vEbVYNcEWFhwJnZswLFH04o0v3kaLw9gUUH9XvXy6q
         OHdg==
X-Gm-Message-State: AJcUukeXSKs+fXYZV3hpia2gbBoGvEH9/BQ5fQeR9unWWU3G6VcWZFh1
        DIkCfH+aSxq2+jeqNGJt/Pk=
X-Google-Smtp-Source: ALg8bN6plNRHWDYfm7jBCCj7GRVxlL99jd7K2XH9lv+ti416/VDZpTrje4bQXP3hZYhZdqkfVGsQog==
X-Received: by 2002:a63:e80e:: with SMTP id s14mr7698280pgh.30.1546781587507;
        Sun, 06 Jan 2019 05:33:07 -0800 (PST)
Received: from localhost.localdomain ([49.207.51.61])
        by smtp.gmail.com with ESMTPSA id q199sm126957822pfc.97.2019.01.06.05.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Jan 2019 05:33:06 -0800 (PST)
From:   G SatishKumar <gsatish.ldd@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, palmer@sifive.com,
        linux-arch@vger.kernel.org, G SatishKumar <gsatish.ldd@gmail.com>
Subject: [PATCH] RISCV:IRQ: Support IRQ_WORK interrupts with self IPI
Date:   Sun,  6 Jan 2019 19:02:58 +0530
Message-Id: <1546781578-8126-1-git-send-email-gsatish.ldd@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch adds, IRQ Work interrupts support to RISCV arch.

	This patch is based on the arm32 patch ARM 7872/1
	which ports cleanly.

	Done set of changes based on RISCV SMP process.

	commit bf18525fd793 ("ARM: 7872/1: Support arch_irq_work_raise()
		via self IPIs")
	Author: Stephen Boyd <sboyd at codeaurora.org>
	Date:   Tue Oct 29 20:32:56 2013 +0100

	By default, IRQ work is run from the tick interrupt (see
	irq_work_run() in update_process_times()). When we're in full
	NOHZ mode, restarting the tick requires the use of IRQ work and
	if the only place we run IRQ work is in the tick interrupt we
	have an unbreakable cycle. Implement arch_irq_work_raise() via
	self IPIs to break this cycle and get the tick started again.
	Note that we implement this via IPIs which are only available on
	SMP builds. This shouldn't be a problem because full NOHZ is only
	supported on SMP builds anyway.

root@(none):~# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  8:        134        112         73         75  SiFive PLIC   8  virtio0
 10:        123        131        142        126  SiFive PLIC  10  ttyS0
IPI0:       798        549        285        373  Rescheduling interrupts
IPI1:        53          8        101        181  Function call interrupts
IPI2:         0          0          0          0  IRQ work interrupts
Err:          0

Signed-off-by: G SatishKumar <gsatish.ldd@gmail.com>
---
 arch/riscv/kernel/smp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 57b1383..8953e73 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -23,6 +23,7 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/irq_work.h>
 
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
@@ -31,6 +32,7 @@
 enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
+	IPI_IRQ_WORK,
 	IPI_MAX
 };
 
@@ -94,6 +96,11 @@ void riscv_software_interrupt(void)
 			generic_smp_call_function_interrupt();
 		}
 
+		if (ops & (1 << IPI_IRQ_WORK)) {
+			stats[IPI_IRQ_WORK]++;
+			irq_work_run();
+		}
+
 		BUG_ON((ops >> IPI_MAX) != 0);
 
 		/* Order data access and bit testing. */
@@ -121,6 +128,7 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
+	[IPI_IRQ_WORK]		= "IRQ work interrupts"
 };
 
 void show_ipi_stats(struct seq_file *p, int prec)
@@ -162,6 +170,14 @@ void smp_send_reschedule(int cpu)
 	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	send_ipi_message(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
+}
+#endif
+
+
 /*
  * Performs an icache flush for the given MM context.  RISC-V has no direct
  * mechanism for instruction cache shoot downs, so instead we send an IPI that
-- 
2.7.4

