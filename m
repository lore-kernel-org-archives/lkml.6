Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D852DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C77D208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZeCaym6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C77D208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeGJCV4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:21:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39577 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932824AbeGJCVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:21:50 -0400
Received: by mail-pf0-f193.google.com with SMTP id s21-v6so14997344pfm.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 19:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vDKwRhBT3xRWEawJSRgrGiYt4RPW/JhbX7FaiHY8aIw=;
        b=kZeCaym6SRHjpAsekCH79GJNC24Q9erSL9P+hGDiFAGB3JRNdoJMrAJPotfgowSQYY
         jajY4d2YMAy3c0/LaIvswbiGSfhdq0m6bysmcF49yqWhsd0IwrF1GYYTZTXz5mokM8kG
         0cwvVhjB1W7Ylv2T7yQ6o79Q6Q10ukk9iZwFST+xNeWywN9i2oZSI+hsU3+jtxukju5l
         8l+3j5lc0GxZlxdZ7Vf0RW7ZLohL4S3T0EDxh4Dovmc2lHOEr8wEHRmMQ2mb4FCPPPeR
         rEs5vG0kvNSUh6hPOvHpY/dOelcBG4Q0PmuZ17mj2vNHuGVFXWTHIpScAiwOOcxTRBNC
         ULkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vDKwRhBT3xRWEawJSRgrGiYt4RPW/JhbX7FaiHY8aIw=;
        b=a4vyo4YfMtih3LxdCsg8goBgPP42MtFOdHpfP68EcI+kcwZVcuN07IVvyTFI/UcMlX
         RwvRzewJjZkbcH23mM9LMTmtBTfej2/wxbR6eCKZG2tCzS65Rau2fEit3YM5FvJq7qx5
         yC+rRWmOxrd+/F16+Re39ItwCDaHM9PEH3rDw8DsBsVrrJb5oV4IO2KtpKheRhQJGffP
         kcB2NBcmmufb4wlBjirX6OHk8+XBIpFwQuQ6x8suUbyKgb7+iZxyV7RK/kkEPRCuSCjO
         PtK47QDyGjdLNBexszweLBqodambSFwAJioiKf1w2MNYva+mfqmRvwOAO+ya8nZV45qS
         P7Vg==
X-Gm-Message-State: APt69E0WI143FTCybvCpyqnd1HXYCfNommoJwStM2znXUKeQQlEm+8Sl
        59zyHdUg9tX8WtpOUaocXNY=
X-Google-Smtp-Source: AAOMgpdSM5yfvTnzqD0Joitp3/svAjmD5nxmuFc6rE292NBfSzY12Da9A9m7vKPtKYw/XGQUNR0jkA==
X-Received: by 2002:a62:384:: with SMTP id 126-v6mr6271152pfd.11.1531189309736;
        Mon, 09 Jul 2018 19:21:49 -0700 (PDT)
Received: from bj03003pcul8.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x28-v6sm26331105pfk.55.2018.07.09.19.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 19:21:49 -0700 (PDT)
From:   "Yandong.Zhao" <yandong77520@gmail.com>
To:     Dave.Martin@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, zhaoyd@thundersoft.com,
        zhaoxb@thundersoft.com, fanlc0801@thundersoft.com,
        Yandong Zhao <yandong77520@gmail.com>
Subject: [PATCH] arm64: neon: Fix function may_use_simd() return error status
Date:   Tue, 10 Jul 2018 10:21:40 +0800
Message-Id: <1531189300-26216-1-git-send-email-yandong77520@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yandong Zhao <yandong77520@gmail.com>

Operations for contexts where we do not want to do any checks for
preemptions.  Unless strictly necessary, always use this_cpu_read()
instead.  Because of the kernel_neon_busy here we have to make sure
that it is the current cpu.

Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
---
 arch/arm64/include/asm/simd.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index fa8b3fe..8b97f8b 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -29,7 +29,8 @@
 static __must_check inline bool may_use_simd(void)
 {
 	/*
-	 * The raw_cpu_read() is racy if called with preemption enabled.
+	 * The this_cpu_read() is racy if called with preemption enabled,
+	 * since the task my subsequently migrate to another CPU.
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

