Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754209AbeBZPJd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:09:33 -0500
Received: from foss.arm.com ([217.140.101.70]:51170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753952AbeBZPFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:05:00 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH v2 04/12] openrisc: Don't pull in all of linux/bitops.h in asm/cmpxchg.h
Date: Mon, 26 Feb 2018 15:04:52 +0000
Message-Id: <1519657500-15094-5-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The openrisc implementation of asm/cmpxchg.h pulls in linux/bitops.h
so that it can refer to BITS_PER_BYTE. It also transitively relies on
this pulling in linux/compiler.h for READ_ONCE.

Replace the #include with asm-generic/bits.h and linux/compiler.h

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/openrisc/include/asm/cmpxchg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
index d29f7db53906..94b578388fe2 100644
--- a/arch/openrisc/include/asm/cmpxchg.h
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -16,8 +16,9 @@
 #ifndef __ASM_OPENRISC_CMPXCHG_H
 #define __ASM_OPENRISC_CMPXCHG_H
 
+#include  <linux/compiler.h>
 #include  <linux/types.h>
-#include  <linux/bitops.h>
+#include  <asm-generic/bits.h>
 
 #define __HAVE_ARCH_CMPXCHG 1
 
-- 
2.1.4
