Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B0CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 22:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD1E2176D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 22:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD1E2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeHEALd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 20:11:33 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.113]:33275 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728883AbeHEALd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 20:11:33 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id BEB48400CEB9E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Aug 2018 17:08:28 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id m4iqfqsLpaSeym4iqfPW1q; Sat, 04 Aug 2018 17:08:28 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=33986 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fm4iq-002rf7-5p; Sat, 04 Aug 2018 17:08:28 -0500
Date:   Sat, 4 Aug 2018 17:08:27 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mm/kasan/kasan_init: use true and false for boolean values
Message-ID: <20180804220827.GA12559@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.50.82
X-Source-L: No
X-Exim-ID: 1fm4iq-002rf7-5p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:33986
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 mm/kasan/kasan_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
index 7a2a2f1..c742dc5 100644
--- a/mm/kasan/kasan_init.c
+++ b/mm/kasan/kasan_init.c
@@ -42,7 +42,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
 #else
 static inline bool kasan_p4d_table(pgd_t pgd)
 {
-	return 0;
+	return false;
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 3
@@ -54,7 +54,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
 #else
 static inline bool kasan_pud_table(p4d_t p4d)
 {
-	return 0;
+	return false;
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -66,7 +66,7 @@ static inline bool kasan_pmd_table(pud_t pud)
 #else
 static inline bool kasan_pmd_table(pud_t pud)
 {
-	return 0;
+	return false;
 }
 #endif
 pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
-- 
2.7.4

