Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CA7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A98B208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o32CTB56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A98B208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbeGKBM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:12:59 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42101 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbeGKBM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:12:59 -0400
Received: by mail-pl0-f66.google.com with SMTP id f4-v6so4181979plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 18:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Gh1xSTK7suDrphdjWXpp6/987jaNirGsBi7IiQd6BHE=;
        b=o32CTB56jerpSN2l7y+pmMSrRMR7H9hd6dPJNSopigef73DPzQ3rSsqwQoPUQNDZAw
         lTRFO7T1nW4NKdHicywl4rTJR6rhUzJcBOy68Y5Ri/7vO7M0PmN4v5zHDr4EQHr3azSL
         /xdDhNBfcH7AwURGv9BR2KOyxWHZqOMu46URF/u/RPz0LtbqH12jzr5tsSQYOk2OR5Pg
         LyKWl2HNC2Y4JIZZuErPbPUJvdqBvxpySm2yKPTSLFsR8PjWAvswGAZzkSnA0rJPz+xa
         DUMXEbb4fWMagUo25H1WR2FRUPyIadPsgPvlvzuKkbT1qV3uVnbEH4A6T6CTJlVmPolX
         vCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gh1xSTK7suDrphdjWXpp6/987jaNirGsBi7IiQd6BHE=;
        b=ofhtaZ64azrvOh/OtGj3pSLIV5DvgbNOUPVVUNSYYzuyjCV3yln2CHio8iidSYjNdt
         OBMfkafx4sJYC3t3hm4srPGyuKVLqjytaR9s+koKYAduuTt1QSXtHO/CBEgIOiKbkE6z
         9pTc/WwqUEToKrT20/wb364GUVP1/Wwp/SNTyeJc/ETMuMsXD+34zB6JDkUblzrwGuAG
         GeCPvV+CGwWjD+46tsvu558KPRKW4tlaLVYQEZfAjgvIdW7Q6GrUtAd3W5pGVY6BcjDj
         2Gczt/aluZU2/TkJjI8ROJWnPRfgQ39ZG6AN9rRT8GI8F437AU/k2jrbkKM/4Sk9Yr5j
         rqkQ==
X-Gm-Message-State: APt69E3OkVL1iybza1mz5r3HYGSWwWPWfrU4yM3Bi6Ty3de7/0S9D7cQ
        h6nLZ7R98l95Gr5p1so73ts=
X-Google-Smtp-Source: AAOMgpdLVQvgiSP8EFPSmvejJRDncy3XUIyvIjbzcN+uavriOi8RhZeRiJ8nbbLlkQr9/lD7BxrM1w==
X-Received: by 2002:a17:902:7106:: with SMTP id a6-v6mr27203111pll.28.1531271476865;
        Tue, 10 Jul 2018 18:11:16 -0700 (PDT)
Received: from bj03003pcul8.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x68-v6sm31428546pfb.138.2018.07.10.18.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 18:11:15 -0700 (PDT)
From:   "Yandong.Zhao" <yandong77520@gmail.com>
To:     Dave.Martin@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, zhaoyd@thundersoft.com,
        zhaoxb@thundersoft.com, fanlc0801@thundersoft.com,
        Yandong Zhao <yandong77520@gmail.com>
Subject: [PATCH] arm64: neon: Fix function may_use_simd() return error status
Date:   Wed, 11 Jul 2018 09:09:59 +0800
Message-Id: <1531271399-1768-1-git-send-email-yandong77520@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yandong Zhao <yandong77520@gmail.com>

It does not matter if the caller of may_use_simd() migrates to
another cpu after the call, but it is still important that the
kernel_neon_busy percpu instance that is read matches the cpu the
task is running on at the time of the read.

This means that raw_cpu_read() is not sufficient.  kernel_neon_busy
may appear true if the caller migrates during the execution of
raw_cpu_read() and the next task to be scheduled in on the initial
cpu calls kernel_neon_begin().

This patch replaces raw_cpu_read() with this_cpu_read() to protect
against this race.

Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
---
 arch/arm64/include/asm/simd.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index fa8b3fe..784a8c2 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -29,7 +29,8 @@
 static __must_check inline bool may_use_simd(void)
 {
 	/*
-	 * The raw_cpu_read() is racy if called with preemption enabled.
+	 * The this_cpu_read() is racy if called with preemption enabled,
+	 * since the task may subsequently migrate to another CPU.
 	 * This is not a bug: kernel_neon_busy is only set when
 	 * preemption is disabled, so we cannot migrate to another CPU
 	 * while it is set, nor can we migrate to a CPU where it is set.
@@ -42,7 +43,7 @@ static __must_check inline bool may_use_simd(void)
 	 * false.
 	 */
 	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!raw_cpu_read(kernel_neon_busy);
+		!this_cpu_read(kernel_neon_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
-- 
1.9.1

