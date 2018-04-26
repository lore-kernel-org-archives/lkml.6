Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756636AbeDZO3B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:29:01 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39973 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756308AbeDZO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:28:51 -0400
X-ME-Sender: <xms:IuLhWt9M3yz5wlTEjO-QEVIL8UHkAWmBqo2_yL-cdWRepu9x0peoZQ>
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Zi Yan <zi.yan@cs.rutgers.edu>, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [RFC PATCH 1/9] arc: mm: migrate: add pmd swap entry to support thp migration.
Date: Thu, 26 Apr 2018 10:27:56 -0400
Message-Id: <20180426142804.180152-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426142804.180152-1-zi.yan@sent.com>
References: <20180426142804.180152-1-zi.yan@sent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <zi.yan@cs.rutgers.edu>

Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-mm@kvack.org
---
 arch/arc/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 08fe33830d4b..246934105e61 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -383,7 +383,9 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 
 /* NOPs, to keep generic kernel happy */
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __pmd_to_swp_entry(pmd)	((swp_entry_t) { pmd_val(pmd) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+#define __swp_entry_to_pmd(x)	((pmd_t) { (x).val })
 
 #define kern_addr_valid(addr)	(1)
 
-- 
2.17.0
