Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeENJtp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:49:45 -0400
Received: from foss.arm.com ([217.140.101.70]:38342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752633AbeENJr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:47:58 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: [PATCH 14/18] arm64: remove in-kernel call to sys_personality()
Date: Mon, 14 May 2018 10:46:36 +0100
Message-Id: <20180514094640.27569-15-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514094640.27569-1-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
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
