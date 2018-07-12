Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91304C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E03720C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxTlqOyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E03720C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeGLDhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:37:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46292 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbeGLDhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:37:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so3328770pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 20:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZSMQG3UWTMh03TDWVFLAGndrQtG/y7AcrItNuGTQyF0=;
        b=RxTlqOykDHnM9xu7JR1rsfYULBcHML8TyzksiuNsJtQSqodMa9CcMZXLK83kPw66Rf
         yghFUhWpJsdFhs+sJmmuuiqeYqlyZoXv82OEP/WEkaiutcnkWG5If77i7V/3R9+bRIyK
         RSuxb0YWXamVDDcV6sp77ry8RPSl9N1wOIMHHMI9JkCr1UM1+I5oR6CvtB9D3nbWfZ4m
         IZWVA0IJjSM9jLQieYAiP6HSeXgLY7TcYpdP8JQgM+dXEOGH4oPgldA8ruiiyMGxSVfN
         FOAu2bnVOrbsQVasg8zfs7Drd7/ahV2YzajQiia8Fp7azX98mtCQK7zsn8ihqJNwJard
         Ku7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZSMQG3UWTMh03TDWVFLAGndrQtG/y7AcrItNuGTQyF0=;
        b=tJFUWNJpAJ39Tqgfxq8p+x6qLFHs6oc/KBrPMJEV6/aJZwm710Npras5zBDylEEvhz
         T2bDoWYoF/ki9Ad24ve5cinsScSUUj/gsizFCO9xssEI/uM0LMwUOk2CmvQsUB6P7dmf
         HRVJsiac8AZG86XJeADNtofADiJt8r8XOO/a1N9L7LuDStmjaxHFdvc+vf2VxlCAtnnA
         lJWu41karbUZ+iAt6/oNLeIG+dHAxcuUM8/TIGitJqvkc5EmbZcB2323RUZ+h949Upsn
         FDBIErxTgk46WGVhStnoePjhS1T1qGdXZDzAV4DE/owPRnvaYCE5gGRLpzC99nH0geNo
         81UQ==
X-Gm-Message-State: AOUpUlF1wfFVCEych4cr3NwPXszTjVbcXQA69MMdj/lxlQZEjf98aBnF
        jtCJqLFeVC9v5JIccpOdXz/ki8fw
X-Google-Smtp-Source: AAOMgpft5F8KKzv38GYj5nwhZwsQmZ2HyUlB8AI8W+mwRTy07ghvjIRORmnEVo4ldre/HaCMeNvdPA==
X-Received: by 2002:a65:6688:: with SMTP id b8-v6mr540613pgw.24.1531366215715;
        Wed, 11 Jul 2018 20:30:15 -0700 (PDT)
Received: from bj03003pcul8.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x6-v6sm48358448pfe.30.2018.07.11.20.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 20:30:14 -0700 (PDT)
From:   "Yandong.Zhao" <yandong77520@gmail.com>
To:     Dave.Martin@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, zhaoyd@thundersoft.com,
        zhaoxb@thundersoft.com, fanlc0801@thundersoft.com,
        Yandong Zhao <yandong77520@gmail.com>
Subject: [PATCH] arm64: neon: Fix function may_use_simd() return error status
Date:   Thu, 12 Jul 2018 11:29:38 +0800
Message-Id: <1531366178-17630-1-git-send-email-yandong77520@gmail.com>
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

This means that raw_cpu_read() is not sufficient. kernel_neon_busy
may appear true if the caller migrates during the execution of
raw_cpu_read() and the next task to be scheduled in on the initial
cpu calls kernel_neon_begin().

This patch replaces raw_cpu_read() with this_cpu_read() to protect
against this race.

Fixes: cb84d11e1625 ("arm64: neon: Remove support for nested or hardirq kernel-mode NEON")
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm..com>
Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
---
 arch/arm64/include/asm/simd.h | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index fa8b3fe..6495cc5 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -29,20 +29,15 @@
 static __must_check inline bool may_use_simd(void)
 {
 	/*
-	 * The raw_cpu_read() is racy if called with preemption enabled.
-	 * This is not a bug: kernel_neon_busy is only set when
-	 * preemption is disabled, so we cannot migrate to another CPU
-	 * while it is set, nor can we migrate to a CPU where it is set.
-	 * So, if we find it clear on some CPU then we're guaranteed to
-	 * find it clear on any CPU we could migrate to.
-	 *
-	 * If we are in between kernel_neon_begin()...kernel_neon_end(),
-	 * the flag will be set, but preemption is also disabled, so we
-	 * can't migrate to another CPU and spuriously see it become
-	 * false.
+	 * kernel_neon_busy is only set while preemption is disabled,
+	 * and is clear whenever preemption is enabled. Since
+	 * this_cpu_read() is atomic w.r.t. preemption, kernel_neon_busy
+	 * cannot change under our feet -- if it's set we cannot be
+	 * migrated, and if it's clear we cannot be migrated to a CPU
+	 * where it is set.
 	 */
 	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!raw_cpu_read(kernel_neon_busy);
+		!this_cpu_read(kernel_neon_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
-- 
1.9.1

