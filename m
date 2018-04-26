Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932138AbeDZO3E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:29:04 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40417 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756467AbeDZO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:28:51 -0400
X-ME-Sender: <xms:IuLhWs2jFFyNusyS8hhBParYeuukhatyxMvXkfuvWMl2VfXmKWgd9g>
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Zi Yan <zi.yan@cs.rutgers.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Steve Capper <steve.capper@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 3/9] arm64: mm: migrate: add pmd swap entry to support thp migration.
Date: Thu, 26 Apr 2018 10:27:58 -0400
Message-Id: <20180426142804.180152-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426142804.180152-1-zi.yan@sent.com>
References: <20180426142804.180152-1-zi.yan@sent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <zi.yan@cs.rutgers.edu>

Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org
---
 arch/arm64/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7e2c27e63cd8..1cdc9d3db2c7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -742,7 +742,9 @@ extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
 #define __swp_entry(type,offset) ((swp_entry_t) { ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __pmd_to_swp_entry(pmd)	((swp_entry_t) { pmd_val(pmd) })
 #define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
+#define __swp_entry_to_pmd(swp)	((pmd_t) { (swp).val })
 
 /*
  * Ensure that there are not more swap files than can be encoded in the kernel
-- 
2.17.0
