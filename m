Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeFAMke (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:40:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50114 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbeFAMjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:39:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EA02607E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org
Cc: toshi.kani@hpe.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v12 3/5] arm64: pgtable: Add p*d_page_vaddr helper macros
Date: Fri,  1 Jun 2018 18:09:16 +0530
Message-Id: <1527856758-27169-4-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper macros to give virtual references to page
tables. These will be used while freeing dangling
page tables.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/include/asm/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7c4c8f3..ef4047f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -580,6 +580,9 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 
 #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
 
+#define pmd_page_vaddr(pmd) __va(pmd_page_paddr(pmd))
+#define pud_page_vaddr(pud) __va(pud_page_paddr(pud))
+
 #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
 
 /* to find an entry in a page-table-directory */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
