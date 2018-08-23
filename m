Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436DCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58B52086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEYBvPCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58B52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbeHWMQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:16:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42928 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeHWMQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:16:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so2351515pff.9;
        Thu, 23 Aug 2018 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vm5WJYEScMr7UWDWXPbr88R9HWjvqSW7wxj8DCyVjYs=;
        b=gEYBvPCjdTml9yIgaT/W/ou3ACAqcWJwpC5ZL0E4EgrZoLqbUra2Rwg1DAYe8iKJhf
         zq3c95YV4k46qxBQyAKkdclcDfYUib1+cgop+zBiCUT1aekJgyWIbamjOYVe7O/+iXAv
         dOLLpwCgvXwZA2E8OixpCseW2sZuiHSRJBY6/fuOO0tBZ5/afFYhbAhwVul45WraIpvV
         HD75sXtJTgxrQ+i72/GsCGEUmKr5+KTPURlVS6aIMNqgVfAcIpT4Fzyt3IO0qOKyIFsa
         4AXjJ3xm8omnlemZtY23Zhj3RYm1ae2mTuUPQszHgEJ1W6R9eM/3gSxzLjUE4K08Od5c
         4yKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vm5WJYEScMr7UWDWXPbr88R9HWjvqSW7wxj8DCyVjYs=;
        b=rY/6W1qU244wrwm94t12ykrbhX7PACx1Q8BPeJXUiksKyKvhNf+aCYQRc1PXr9C7zH
         s4BhjxcCYGsxIg/OntnL2LMY3AOEH3nJTUx6/jnshWUr2uEavAIshBND75jOlQkVOX31
         CBJclJoOS/Wp4z+91RKcnYxbjOW7jydEnnTpMOgHB5nbfgWpCZr7ssBgVRRzq/UGg572
         Wpxg6AvLBvKZ2xMQ4LB4U5O+rJ3TezdwMUfS5a9kc3lxKcJWh2HggsCTMMekF/LkDsJI
         dvCdL9Uxxb1wxYfi3zSwbjNPKwuIzrPMrBCLpddrfr3gRqg3v6XyEFt7D4MkFiQc4cD8
         bwWQ==
X-Gm-Message-State: AOUpUlELo/LQDvBRHb+ODASUg0lToaQ/nEHIWKgPTXK1Uz45iI0MWsP7
        oWIzMMaxpboFbVVyrIRc5w0=
X-Google-Smtp-Source: AA+uWPyGlyWnj3nMPrxY4SPnBTjWZjcKNxEdhGijGKj4PrMsrgME/v8IMpsaIZLBPJdZiyrMNgxmmA==
X-Received: by 2002:a63:2e09:: with SMTP id u9-v6mr52325298pgu.294.1535014053904;
        Thu, 23 Aug 2018 01:47:33 -0700 (PDT)
Received: from roar.ozlabs.ibm.com. ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id w5-v6sm5170503pfn.44.2018.08.23.01.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 01:47:33 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, torvalds@linux-foundation.org,
        luto@kernel.org, x86@kernel.org, bp@alien8.de, will.deacon@arm.com,
        riel@surriel.com, jannh@google.com, ascannell@google.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma
Date:   Thu, 23 Aug 2018 18:47:09 +1000
Message-Id: <20180823084709.19717-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180823084709.19717-1-npiggin@gmail.com>
References: <20180823084709.19717-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic tlb_end_vma does not call invalidate_range mmu notifier,
and it resets resets the mmu_gather range, which means the notifier
won't be called on part of the range in case of an unmap that spans
multiple vmas.

ARM64 seems to be the only arch I could see that has notifiers and
uses the generic tlb_end_vma. I have not actually tested it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/asm-generic/tlb.h | 17 +++++++++++++----
 mm/memory.c               | 10 ----------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index e811ef7b8350..79cb76b89c26 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -15,6 +15,7 @@
 #ifndef _ASM_GENERIC__TLB_H
 #define _ASM_GENERIC__TLB_H
 
+#include <linux/mmu_notifier.h>
 #include <linux/swap.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -138,6 +139,16 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 	}
 }
 
+static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
+{
+	if (!tlb->end)
+		return;
+
+	tlb_flush(tlb);
+	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
+	__tlb_reset_range(tlb);
+}
+
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
@@ -186,10 +197,8 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 
 #define __tlb_end_vma(tlb, vma)					\
 	do {							\
-		if (!tlb->fullmm && tlb->end) {			\
-			tlb_flush(tlb);				\
-			__tlb_reset_range(tlb);			\
-		}						\
+		if (!tlb->fullmm)				\
+			tlb_flush_mmu_tlbonly(tlb);		\
 	} while (0)
 
 #ifndef tlb_end_vma
diff --git a/mm/memory.c b/mm/memory.c
index 7c58310734eb..c4a7b6cb17c8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -238,16 +238,6 @@ void arch_tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	__tlb_reset_range(tlb);
 }
 
-static void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
-{
-	if (!tlb->end)
-		return;
-
-	tlb_flush(tlb);
-	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
-	__tlb_reset_range(tlb);
-}
-
 static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
-- 
2.17.0

