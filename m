Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA16C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161A92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161A92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966310AbeFSMyk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:54:40 -0400
Received: from foss.arm.com ([217.140.101.70]:49362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937861AbeFSMwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:52:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 251AF168F;
        Tue, 19 Jun 2018 05:52:41 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB5D33F7F4;
        Tue, 19 Jun 2018 05:52:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 216471AE3797; Tue, 19 Jun 2018 13:53:16 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        yamada.masahiro@socionext.com, Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH v2 9/9] arm64: bitops: Include <asm-generic/bitops/ext2-atomic-setbit.h>
Date:   Tue, 19 Jun 2018 13:53:14 +0100
Message-Id: <1529412794-17720-10-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
References: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm-generic/bitops/ext2-atomic-setbit.h provides the ext2 atomic bitop
definitions, so we don't need to define our own.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/bitops.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/bitops.h b/arch/arm64/include/asm/bitops.h
index 13501460be6b..10d536b1af74 100644
--- a/arch/arm64/include/asm/bitops.h
+++ b/arch/arm64/include/asm/bitops.h
@@ -38,11 +38,6 @@
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/non-atomic.h>
 #include <asm-generic/bitops/le.h>
-
-/*
- * Ext2 is defined to use little-endian byte ordering.
- */
-#define ext2_set_bit_atomic(lock, nr, p)	test_and_set_bit_le(nr, p)
-#define ext2_clear_bit_atomic(lock, nr, p)	test_and_clear_bit_le(nr, p)
+#include <asm-generic/bitops/ext2-atomic-setbit.h>
 
 #endif /* __ASM_BITOPS_H */
-- 
2.1.4

