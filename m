Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeFALZ1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:25:27 -0400
Received: from foss.arm.com ([217.140.101.70]:50366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751989AbeFALZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:25:18 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv2 15/19] arm64: remove in-kernel call to sys_personality()
Date: Fri,  1 Jun 2018 12:24:37 +0100
Message-Id: <20180601112441.37810-16-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With pt_regs syscall wrappers, the calling convention for
sys_personality() will change. Use ksys_personality(), which is
functionally equivalent.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 31045f3fed92..a82c3f7a9a90 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -42,7 +42,7 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 	if (personality(personality) == PER_LINUX32 &&
 		!system_supports_32bit_el0())
 		return -EINVAL;
-	return sys_personality(personality);
+	return ksys_personality(personality);
 }
 
 /*
-- 
2.11.0
