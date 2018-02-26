Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeBZPGY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:06:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51204 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754010AbeBZPFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:05:01 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH v2 12/12] arm64: bitops: Include <asm-generic/bitops/ext2-atomic-setbit.h>
Date: Mon, 26 Feb 2018 15:05:00 +0000
Message-Id: <1519657500-15094-13-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
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
