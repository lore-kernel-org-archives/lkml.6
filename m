Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14117C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D071220672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D071220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLGSkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:40:04 -0500
Received: from foss.arm.com ([217.140.101.70]:51934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeLGSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:40:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7253E15AD;
        Fri,  7 Dec 2018 10:40:03 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597523F5AF;
        Fri,  7 Dec 2018 10:40:00 -0800 (PST)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/13] arm64: add comments about EC exception levels
Date:   Fri,  7 Dec 2018 18:39:19 +0000
Message-Id: <20181207183931.4285-2-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207183931.4285-1-kristina.martsenko@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it clear which exceptions can't be taken to EL1 or EL2, add
comments next to the ESR_ELx_EC_* macro definitions.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/esr.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 676de2ec1762..23602a0083ad 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -29,23 +29,23 @@
 #define ESR_ELx_EC_CP14_MR	(0x05)
 #define ESR_ELx_EC_CP14_LS	(0x06)
 #define ESR_ELx_EC_FP_ASIMD	(0x07)
-#define ESR_ELx_EC_CP10_ID	(0x08)
+#define ESR_ELx_EC_CP10_ID	(0x08)	/* EL2 only */
 /* Unallocated EC: 0x09 - 0x0B */
 #define ESR_ELx_EC_CP14_64	(0x0C)
 /* Unallocated EC: 0x0d */
 #define ESR_ELx_EC_ILL		(0x0E)
 /* Unallocated EC: 0x0F - 0x10 */
 #define ESR_ELx_EC_SVC32	(0x11)
-#define ESR_ELx_EC_HVC32	(0x12)
-#define ESR_ELx_EC_SMC32	(0x13)
+#define ESR_ELx_EC_HVC32	(0x12)	/* EL2 only */
+#define ESR_ELx_EC_SMC32	(0x13)	/* EL2 and above */
 /* Unallocated EC: 0x14 */
 #define ESR_ELx_EC_SVC64	(0x15)
-#define ESR_ELx_EC_HVC64	(0x16)
-#define ESR_ELx_EC_SMC64	(0x17)
+#define ESR_ELx_EC_HVC64	(0x16)	/* EL2 and above */
+#define ESR_ELx_EC_SMC64	(0x17)	/* EL2 and above */
 #define ESR_ELx_EC_SYS64	(0x18)
 #define ESR_ELx_EC_SVE		(0x19)
 /* Unallocated EC: 0x1A - 0x1E */
-#define ESR_ELx_EC_IMP_DEF	(0x1f)
+#define ESR_ELx_EC_IMP_DEF	(0x1f)	/* EL3 only */
 #define ESR_ELx_EC_IABT_LOW	(0x20)
 #define ESR_ELx_EC_IABT_CUR	(0x21)
 #define ESR_ELx_EC_PC_ALIGN	(0x22)
@@ -68,7 +68,7 @@
 /* Unallocated EC: 0x36 - 0x37 */
 #define ESR_ELx_EC_BKPT32	(0x38)
 /* Unallocated EC: 0x39 */
-#define ESR_ELx_EC_VECTOR32	(0x3A)
+#define ESR_ELx_EC_VECTOR32	(0x3A)	/* EL2 only */
 /* Unallocted EC: 0x3B */
 #define ESR_ELx_EC_BRK64	(0x3C)
 /* Unallocated EC: 0x3D - 0x3F */
-- 
2.11.0

