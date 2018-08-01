Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15564C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA027208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA027208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbeHALsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:48:12 -0400
Received: from shelob.surriel.com ([96.67.55.147]:55950 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389205AbeHALsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:48:11 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fkny6-00010M-Df; Wed, 01 Aug 2018 06:02:58 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, mingo@kernel.org, peterz@infradead.org,
        luto@kernel.org, x86@kernel.org, efault@gmx.de,
        dave.hansen@intel.com, Rik van Riel <riel@surriel.com>
Subject: [PATCH 05/11] mm,tlb: turn dummy defines into inline functions
Date:   Wed,  1 Aug 2018 06:02:49 -0400
Message-Id: <20180801100255.4278-6-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801100255.4278-1-riel@surriel.com>
References: <20180801100255.4278-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn the dummy tlb_flush_remove_tables* defines into inline functions,
in order to get compiler type checking, etc.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 include/asm-generic/tlb.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index e811ef7b8350..eb57062d9dd3 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -309,8 +309,13 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
  * pointing to about-to-be-freed page table memory.
  */
 #ifndef HAVE_TLB_FLUSH_REMOVE_TABLES
-#define tlb_flush_remove_tables(mm) do {} while (0)
-#define tlb_flush_remove_tables_local(mm) do {} while (0)
+static inline void tlb_flush_remove_tables(struct mm_struct *mm)
+{
+}
+
+static inline void tlb_flush_remove_tables_local(struct mm_struct *mm)
+{
+}
 #endif
 
 #endif /* _ASM_GENERIC__TLB_H */
-- 
2.14.4

