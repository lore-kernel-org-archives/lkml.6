Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbeDZOaU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:30:20 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42169 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756573AbeDZO2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:28:52 -0400
X-ME-Sender: <xms:I-LhWro0Mex3PjAzcPqCfaNlr1Ff2YFIBeiTTDpWt9ioOllyBIFILw>
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Zi Yan <zi.yan@cs.rutgers.edu>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mips@linux-mips.org
Subject: [RFC PATCH 5/9] mips: mm: migrate: add pmd swap entry to support thp migration.
Date: Thu, 26 Apr 2018 10:28:00 -0400
Message-Id: <20180426142804.180152-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426142804.180152-1-zi.yan@sent.com>
References: <20180426142804.180152-1-zi.yan@sent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <zi.yan@cs.rutgers.edu>

Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org
Cc: linux-mm@kvack.org
---
 arch/mips/include/asm/pgtable-64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 0036ea0c7173..ec72e5b12965 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -366,6 +366,8 @@ static inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 #define __swp_offset(x)		((x).val >> 24)
 #define __swp_entry(type, offset) ((swp_entry_t) { pte_val(mk_swap_pte((type), (offset))) })
 #define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
+#define __pmd_to_swp_entry(pmd) ((swp_entry_t) { pmd_val(pmd) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+#define __swp_entry_to_pmd(x)	((pmd_t) { (x).val })
 
 #endif /* _ASM_PGTABLE_64_H */
-- 
2.17.0
