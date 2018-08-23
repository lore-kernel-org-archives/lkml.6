Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA33C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078152077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e85lCNW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078152077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbeHWMQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:16:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38225 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732623AbeHWMQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:16:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so2358500pfh.5;
        Thu, 23 Aug 2018 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IRhZgLPRx4tzi/e3fxP2vHoZGo1V/TLqfKDUUNoAm38=;
        b=e85lCNW5ZhdjUCei/RAj9byezOvy9sEmiiZkPkURq+UAHjwaE5/PxcfLUapq8XVJlx
         pWoX2yLTmaYHUL4Yfgg1iYWsY9wPSO8gwLR7qh58C5BrmBbJkiKMhK2whmZZpP3h+kd0
         MRW0MDqKR/7vgpjZJrJ7FIHLKjH/U0pfrvPoBQZXbhEQ0LNW2c4OBwVhhYET0X5XChl1
         YFAW706vZ4vJwGDdKbtiuwMAjyv7nyWXFnwwOMAjDaoOyMWikwDcvWDfaNLPI+JCr768
         /xJSyNYzqbXu6PKmfyoDn30oJq6Z+etT3FcNl6LjVJtUjvhPdfu883Zi+1ZQ1NE3vj8Q
         Wrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IRhZgLPRx4tzi/e3fxP2vHoZGo1V/TLqfKDUUNoAm38=;
        b=d+jlXY5R/69bF+LxfgJ00Qpb4eyUR8Kj5SVJL/fMtSVZIPFLAaMzl3Cvp+qQ4wRr+I
         plHTbNNPSqg4X0Mz3ZkgON1NVcyyN3WTvZH9GwudBdZ2oG2is39o8Wd74A+gu8Ok2sRU
         9dfD8f5NXV4whGI5xEcndKUL96ANClDtH8aWvi3OpHbqD6BHfGuKwCIqHwqU1rChdh9y
         moImbLYwqsTC8gGMjwIItOHk/HNj02t1MWfYiyfloJHOoMxGEBwDkbdZ8YfkZ0IcrJh3
         SLyeCcPVnNaFqfEf3TVIw8n3Zz4KAyKFe829VkG0FiFq8uQYGIYcDXWtkDpG5oiMAVuX
         T2xg==
X-Gm-Message-State: AOUpUlF1s3I9rycoRYB87Shg0YqhpH8ZT8JSKsH2hL97ObMpzruUMW3J
        qNuDo2kLMqdTmhWiMBujVRE=
X-Google-Smtp-Source: AA+uWPzgnKVeyGDrwd1X5Y4sSxuoZ5U4azvkGjVyP7iTgSuBQqhduD/7xVxtxH+hKFgoJPhXiXJFnA==
X-Received: by 2002:a63:1c47:: with SMTP id c7-v6mr16501905pgm.38.1535014048116;
        Thu, 23 Aug 2018 01:47:28 -0700 (PDT)
Received: from roar.ozlabs.ibm.com. ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id w5-v6sm5170503pfn.44.2018.08.23.01.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 01:47:27 -0700 (PDT)
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
Subject: [RFC PATCH 1/2] mm: move tlb_table_flush to tlb_flush_mmu_free
Date:   Thu, 23 Aug 2018 18:47:08 +1000
Message-Id: <20180823084709.19717-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180823084709.19717-1-npiggin@gmail.com>
References: <20180823084709.19717-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to call this from tlb_flush_mmu_tlbonly, it
logically belongs with tlb_flush_mmu_free. This allows some
code consolidation with a subsequent fix.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 19f47d7b9b86..7c58310734eb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -245,9 +245,6 @@ static void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 
 	tlb_flush(tlb);
 	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
-	tlb_table_flush(tlb);
-#endif
 	__tlb_reset_range(tlb);
 }
 
@@ -255,6 +252,9 @@ static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
 
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+	tlb_table_flush(tlb);
+#endif
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
 		free_pages_and_swap_cache(batch->pages, batch->nr);
 		batch->nr = 0;
-- 
2.17.0

