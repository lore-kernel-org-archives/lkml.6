Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E5DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9205220B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umAubXu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9205220B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbeGKLKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:10:43 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41740 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeGKLKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:10:43 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so9020257ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Oaa0Ov0L/ZOvGS6M06Oh93oXejBQk3s1MXECgTWSd64=;
        b=umAubXu7+7XELtC7012+5jqa7JyFASIynVxhQUMwWyYywhFhurUB/m/5iUdkBVM1iQ
         U0tz8D0bGU1Odyj19ARMB+LiZ7hnbxLWzv4KC7vStAxUIlX6p3xmSrWmKvGmeVzq+7DV
         6oaWe2dyqtRAk3njrY9PbRQteLySbl/dTH3FSqKz/PFXCB39IJAFCUyH17ulSbY857MB
         S78AIx/z05g2Lpp2dOvd32PdopzqW0831KZsZ7gv5oYVYTb6U6ZQqdlzydVAI0Esvg+4
         ZY11u1qSU+6wq5FZtk+Z7bZmPO8/m0e4NUHyNZOuM2ae2GP7x8ANraFk2JkSwObdsJzR
         zBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Oaa0Ov0L/ZOvGS6M06Oh93oXejBQk3s1MXECgTWSd64=;
        b=JTKuZqSvnYnpm5gAteo/wkJqIS3fIR7zvQv/jM6V6r/6wfY4J/AO51YIAvcMEEGeDh
         kdXlqcqYaJ+5RMaWBdejJjKnqaUUe6jg9reJFMqZt1VPUtgEzZvQLp7gqmcl4OG0cWPl
         uAcS4ZS51Cg3odwNolvq7XkPZMcP0rCQZDTDfX7VkKJFZzuP3KxfLJxHgyPcZoVooytF
         nNE4DoyQb6FgaQWRElXVG0En+edy51M3m7uNxckthAA+P/5Zit3lYTHFexPuPojHmUk8
         f0sVms0ezKwo8cR0+Ui+Tj2o+Ns9zIuJuFAi7HPWSdqO+3Z7b8oeoSxaV3aNuYJWcAla
         xnOA==
X-Gm-Message-State: APt69E21hnYFLWzl7U4I4OD0IZ2jWrt1Cxnk3EPI4WH1A09FgHuRy05j
        VKHLasKJsSKM5yG8dx6SgUiypCVz
X-Google-Smtp-Source: AAOMgpeOJrKYA6aEA5jBgvNekcY0fz3enED+tRP7Qi1KLo25pY5ZbiZkBRo6K/mzOUGCasQraehLRA==
X-Received: by 2002:a17:902:42a3:: with SMTP id h32-v6mr27983134pld.72.1531307216143;
        Wed, 11 Jul 2018 04:06:56 -0700 (PDT)
Received: from bj03003pcul8.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l25-v6sm3767701pff.8.2018.07.11.04.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 04:06:55 -0700 (PDT)
From:   "Yandong.Zhao" <yandong77520@gmail.com>
To:     Dave.Martin@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, zhaoyd@thundersoft.com,
        zhaoxb@thundersoft.com, fanlc0801@thundersoft.com,
        Yandong Zhao <yandong77520@gmail.com>
Subject: [PATCH] arm64: neon: Fix function may_use_simd() return error status
Date:   Wed, 11 Jul 2018 19:06:28 +0800
Message-Id: <1531307188-12032-1-git-send-email-yandong77520@gmail.com>
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

Fixes: cb84d11e1625 ("arm64: neon: Remove support for nested or hardirq kernel-mode NEON")
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
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

