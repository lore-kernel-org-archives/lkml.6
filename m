Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDCCC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6CA20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0QHvymS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6CA20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754417AbeGIIpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:45:51 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35319 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeGIIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:45:50 -0400
Received: by mail-pf0-f196.google.com with SMTP id q7-v6so12083967pff.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+iUsSxMVUZfSWmDBpKSUBNIqA1uGgtYN1NK9yrh6yXw=;
        b=O0QHvymSBxz7PXlCRnlgh5xvzvqbKx2q6tX/etXCwru3CSPaLu9Z5RFD2P2MKO6w69
         79Hb0YbvpT+tCmu6D2Xz8fb2AtIri2+IRcLCWJu2PxfL0KmU+vb4Wmr8p26zuv1lDi8M
         bJclEdCTZt5TDNh8+KddnQztdJ60ncQcYZrd1O5vMJYwiw9VGRE6IQmvI0X1jEScmaw0
         b3XSnFYE3Nnsn3ygxezLRESf3QNLnOHoD2OwWa0o8gJl7+C2Sg4gLPlJSXlGkXudbbLx
         AC3kC5w0FP4dKyQgwoj/e7Mn1yYovgpawxpao5h7tC79A7BwMUKKGqlKzUUVqqpNeTU0
         Iz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+iUsSxMVUZfSWmDBpKSUBNIqA1uGgtYN1NK9yrh6yXw=;
        b=rEd6dt8h9XZiihQfu+CpUdJuoJOz4NC6qxzqqTAFLP8mLcxM/UBu7Ah1SnqrUDQ9KJ
         idMQjfnxMwVM+YwPiCVzjW+n1h53IHkQAJ2nqEIBT6mUNP8HCQ2oPI0+X0khf6B7AReD
         sEDmoGWZ8Nh+2VL/iPIocz2Cfdaf2Tew98FDANWvNHOci0b518PuY3p10NCVYqSFm8rs
         csSUlID63k2XvLKqD3cf0eJYYMhKus6ZJUZHyxW8Sh5JTnMZPXt5wup+vYiiMGcDPPCc
         s3RfMDOO+eGN0F33JvofsltMTCXUPftGc0ttmfN9yPyuXlPXexnLHc/UJ2qrFy/TxdC0
         hAgA==
X-Gm-Message-State: APt69E3ZCIyOFJ4A0L4gqvD7TFpaJOIufsmYy3AlL7plHv9zVbVrdGZR
        ybz1DomCWwcj1cAsdUzPxQ8++I1t
X-Google-Smtp-Source: AAOMgpe4AKAusH+Q3r8IVoueb3+bv9W3zfJ15NLD0ebqUcvjm6xSqO6mf8NY2PwXLynxUsgP6lA+Yg==
X-Received: by 2002:a62:3481:: with SMTP id b123-v6mr20448231pfa.4.1531125949685;
        Mon, 09 Jul 2018 01:45:49 -0700 (PDT)
Received: from bj03003pcul8.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e9-v6sm2272902pgu.5.2018.07.09.01.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 01:45:49 -0700 (PDT)
From:   "Yandong.Zhao" <yandong77520@gmail.com>
To:     Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org
Cc:     zhaoyd@thundersoft.com, Yandong Zhao <yandong77520@gmail.com>
Subject: [PATCH] arm64: neon: Add preemption protection for kernel_neon_busy
Date:   Mon,  9 Jul 2018 16:45:35 +0800
Message-Id: <1531125935-19999-1-git-send-email-yandong77520@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yandong Zhao <yandong77520@gmail.com>

may_use_simd() can be called in any case and access kernel_neon_busy,
for example: BUG_ON(!may_use_simd()).  This patch ensures that
migration will not occur during program access to kernel_neon_busy.

Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
---
 arch/arm64/include/asm/simd.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index fa8b3fe..6580dcd 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -29,20 +29,12 @@
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
+	 * Operations for contexts where we do not want to do any checks for
+	 * preemptions.  Unless strictly necessary, always use this_cpu_*()
+	 * instead.
 	 */
 	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!raw_cpu_read(kernel_neon_busy);
+		!this_cpu_read(kernel_neon_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
-- 
1.9.1

