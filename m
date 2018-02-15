Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946151AbeBORzS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:55:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56002 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164190AbeBOPaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:30:15 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 5/5] arm64: bitops: Include <asm-generic/bitops/ext2-atomic-setbit.h>
Date: Thu, 15 Feb 2018 15:29:35 +0000
Message-Id: <1518708575-12284-6-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm-generic/bitops/ext2-atomic-setbit.h provides the ext2 atomic bitop
definitions, so we don't need to define our own.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/bitops.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/bitops.h b/arch/arm64/include/asm/bitops.h
index 817233fbf249..564ffe562b7a 100644
--- a/arch/arm64/include/asm/bitops.h
+++ b/arch/arm64/include/asm/bitops.h
@@ -37,11 +37,6 @@
 #include <asm-generic/bitops/atomic.h>
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
