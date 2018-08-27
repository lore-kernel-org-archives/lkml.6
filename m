Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721FFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A9C208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Lk1A2TOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A9C208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeH0Wqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:46:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36546 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Wqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:46:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so11899pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=Mf1CUNt9aY5s1Fk8Qz6A3zvNqfxMlvET8CozUWm+yGc=;
        b=Lk1A2TOlLTVLMWvZSNDtCLbHkBm8rITG0vKxP46FTqx6Yf0CLNY0wycGQriezg4Y/3
         M7k2u+ru/ZxeDfjGAjs72ezTIEhIf8BZ5KiO5wQMuL/3zD5Mkf1Rc75BLrneDrN1PIkl
         XROi63SMScQPp0wMlVPug6X9UCuXNcyrDw51kCxUut+cCA/MbmKAtinQ4l6fmQ/Ukm1a
         mPkqxfNR6FL/4meZ1IJVAcN5Z8Pxga5P8B0hyUocmMXCZm8gy2vdZLwOmvDCI4UpeqbJ
         O9XSi+qbWzWOKJY8H1xOORqAmcIrfgux6VSQefDGU2bOrU7DOeMDfpJ2u/dBwcUnD/9k
         v+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=Mf1CUNt9aY5s1Fk8Qz6A3zvNqfxMlvET8CozUWm+yGc=;
        b=BO3WldcWqQo0p8zsw5ER6RlPjXTSHp/mW9YlGbAl3MHaEXlZJ1GW0VAMx+0L/xjaBW
         654sE3l6fzA5zzcz5QyuRjFBzgteEmKsBTHaCmS/0VvtetqeztOV1YuHzHqYpePQm0Y7
         IrTbzYV3nUCYpfdf9lbuJJE3d9UumaoL8+oYBqZpSqYhK/X06YfNBlYyN1WXf0NrWi/+
         ZVnU6TpU4f5GxhnK8razYroydDxj6SBmh8vSMIR0d0r36LbLjF/9Vwu/KB6M+hTFlj/M
         mLzPMstue7/Z3cIVTH+pYvr9NPn35ghAUOlr8SpTuYfEb1lbHxXZhWbT5y5/wQFQ+E7p
         ZNMw==
X-Gm-Message-State: APzg51ABygZHUbf5e+HLuo0gBZEgbJ7y/Mn86WpUNfAaCQi/Jnd2KIq/
        Wl0jR5zGaC48dDVriXOiiTHRHQ==
X-Google-Smtp-Source: ANB0VdZJoA3goGtlO7qXDK/12eVKa8cz81pVChEBlIb7maiKNhXMIh+y7YMgoiqE3XjvoEA6pvqZIw==
X-Received: by 2002:a65:668f:: with SMTP id b15-v6mr13517996pgw.426.1535396319788;
        Mon, 27 Aug 2018 11:58:39 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id w72-v6sm14999pfa.26.2018.08.27.11.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 11:58:38 -0700 (PDT)
Subject: [PATCH 1/8] RISC-V: Provide a cleaner raw_smp_processor_id()
Date:   Mon, 27 Aug 2018 11:42:36 -0700
Message-Id: <20180827184243.25344-2-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827184243.25344-1-palmer@sifive.com>
References: <20180827184243.25344-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, atish.patra@wdc.com,
        dmitriy@oss-tech.org, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, Greg KH <gregkh@linuxfoundation.org>,
        jeremy.linton@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure how I managed to miss this the first time, but this is much
better.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/include/asm/smp.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 36016845461d..27fd085188df 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -14,11 +14,6 @@
 #ifndef _ASM_RISCV_SMP_H
 #define _ASM_RISCV_SMP_H
 
-/* This both needs asm-offsets.h and is used when generating it. */
-#ifndef GENERATING_ASM_OFFSETS
-#include <asm/asm-offsets.h>
-#endif
-
 #include <linux/cpumask.h>
 #include <linux/irqreturn.h>
 
@@ -33,13 +28,12 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
 /* Hook for the generic smp_call_function_single() routine. */
 void arch_send_call_function_single_ipi(int cpu);
 
-/*
- * This is particularly ugly: it appears we can't actually get the definition
- * of task_struct here, but we need access to the CPU this task is running on.
- * Instead of using C we're using asm-offsets.h to get the current processor
- * ID.
- */
-#define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
+/* Obtains the hart ID of the currently executing task.  This relies on
+ * THREAD_INFO_IN_TASK, but we define that unconditionally. */
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+#define get_ti()                ((struct thread_info *)get_current())
+#define raw_smp_processor_id()  (get_ti()->cpu)
+#endif
 
 #endif /* CONFIG_SMP */
 
-- 
2.16.4

