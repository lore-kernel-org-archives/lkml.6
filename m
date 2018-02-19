Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeBSOwR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:52:17 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:44156 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752934AbeBSOwO (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:3:1>);
        Mon, 19 Feb 2018 09:52:14 -0500
Message-Id: <5A8AF2AA02000078001A91E9@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 19 Feb 2018 07:52:10 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/LDT: avoid warning in 32-bit builds with older gcc
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG() doesn't always imply "no return", and hence should be followed by
a return statement even if that's obviously (to a human) unreachable.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 arch/x86/include/asm/mmu_context.h |    1 +
 1 file changed, 1 insertion(+)

--- 4.16-rc2/arch/x86/include/asm/mmu_context.h
+++ 4.16-rc2-ix86-ldt_slot_va-retval/arch/x86/include/asm/mmu_context.h
@@ -74,6 +74,7 @@ static inline void *ldt_slot_va(int slot
 	return (void *)(LDT_BASE_ADDR + LDT_SLOT_STRIDE * slot);
 #else
 	BUG();
+	return (void *)fix_to_virt(FIX_HOLE);
 #endif
 }
 
