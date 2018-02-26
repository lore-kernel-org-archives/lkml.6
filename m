Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754250AbeBZPGp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:06:45 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51176 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753987AbeBZPFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:05:01 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH v2 05/12] sh: Don't pull in all of linux/bitops.h in asm/cmpxchg-xchg.h
Date: Mon, 26 Feb 2018 15:04:53 +0000
Message-Id: <1519657500-15094-6-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sh implementation of asm/cmpxchg-xchg.h pulls in linux/bitops.h
so that it can refer to BITS_PER_BYTE. It also transitively relies on
this pulling in linux/compiler.h for READ_ONCE.

Replace the #include with asm-generic/bits.h and linux/compiler.h

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/sh/include/asm/cmpxchg-xchg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/cmpxchg-xchg.h b/arch/sh/include/asm/cmpxchg-xchg.h
index 1e881f5db659..41c290efa3c4 100644
--- a/arch/sh/include/asm/cmpxchg-xchg.h
+++ b/arch/sh/include/asm/cmpxchg-xchg.h
@@ -8,7 +8,8 @@
  * This work is licensed under the terms of the GNU GPL, version 2.  See the
  * file "COPYING" in the main directory of this archive for more details.
  */
-#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <asm-generic/bits.h>
 #include <asm/byteorder.h>
 
 /*
-- 
2.1.4
