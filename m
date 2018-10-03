Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620C0C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2084B205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TODim2kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2084B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJCM1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:27:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40215 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeJCM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:27:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id n31-v6so1018528pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Cqq0i7ylJe74jn1ACvsUK1e2rkXVgkxFIlsiUTu7808=;
        b=TODim2kQ0afi2Mzt2YdnDn6Rd872JEy7oTwTxo1OODFL08Ry8tps1uF79sXC/cAvd0
         QGlleUfkBuog4XVObc41agp74je4ye8Mb1IqPALPtYXmjrw0m7YGsTOsLEWt1Bazd6HR
         NUXo4TLexP6xAiFrvWB96e1MSTC98VAnKdSqFlmbAgAcJ9hxsd7avHg6HgVk+YIb+efN
         MAj/bgk77ItIjY8nUbFIY5hKQNBrmUjVcysmQarBYnJPkxJ4Yg8lEKav80lw+rjwIgv9
         aRCg8Nk/xUeBWqkrykkWNKCcUsAVAnTF8zPK8oDC3FncjA8iFrHgn69nOMf3m58sNO0C
         +S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Cqq0i7ylJe74jn1ACvsUK1e2rkXVgkxFIlsiUTu7808=;
        b=a+u+2tTcX0cBEQUCUD7VdawCF5lDfkVYA65kH+6TkSN6E/vfRFm/Wdt7F1pOyr+Iiw
         Km6P8smavzi6OjFDjODyMVorGIqnYZtkFx+fAhRuampq0eY1DJU7ARrMqfaf4Ipvnc3c
         Jq03jcqugqyp817LGuU4vvIMJNzEoYeB7LzP0NpKCnHN4fAJeu74PlJtHDCydSMJR22X
         prc+pWAGUzghkBHj2ILA6mJWIUzdalCbeDyl8OZT26F0xqvhigPmqCG38ge+GJEQUnc8
         lwfrEwZ+64COz2Pc0huUBShOPL5P7lT7sWf25AYrulBAIb6df4TAoRY+c9aOnlYUe/zf
         dmqg==
X-Gm-Message-State: ABuFfogUbxP4R/0OGifYS/37stARroTsNQMStFubLrGpkzvm/WndRlrm
        e56wr26X6jRkw2Z5IZfj0j8=
X-Google-Smtp-Source: ACcGV630wSmUemq7owD39h99/1VVD3bHq1FR7Vrp6lgXQgUZZ/z0BfAxshyt/MgO22QnN9GF6Qq8Sw==
X-Received: by 2002:a65:498b:: with SMTP id r11-v6mr17528524pgs.153.1538545214843;
        Tue, 02 Oct 2018 22:40:14 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id k63-v6sm481663pga.36.2018.10.02.22.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:40:14 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 85EDD1643D0; Tue,  2 Oct 2018 22:40:13 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org
Subject: [PATCH 13/16] mm: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:59 -0700
Message-Id: <20181003053902.6910-14-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jan Kara <jack@suse.cz>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: <linux-mm@kvack.org>
---
 mm/khugepaged.c | 4 ++--
 mm/swap.c       | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a31d740e6cd1..80f12467ccb3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1225,7 +1225,7 @@ static void collect_mm_slot(struct mm_slot *mm_slot)
 {
 	struct mm_struct *mm = mm_slot->mm;
 
-	VM_BUG_ON(NR_CPUS != 1 && !spin_is_locked(&khugepaged_mm_lock));
+	lockdep_assert_held(&khugepaged_mm_lock);
 
 	if (khugepaged_test_exit(mm)) {
 		/* free mm_slot */
@@ -1665,7 +1665,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 	int progress = 0;
 
 	VM_BUG_ON(!pages);
-	VM_BUG_ON(NR_CPUS != 1 && !spin_is_locked(&khugepaged_mm_lock));
+	lockdep_assert_held(&khugepaged_mm_lock);
 
 	if (khugepaged_scan.mm_slot)
 		mm_slot = khugepaged_scan.mm_slot;
diff --git a/mm/swap.c b/mm/swap.c
index 26fc9b5f1b6c..c89eb442c0bf 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -824,8 +824,7 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
 	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
-	VM_BUG_ON(NR_CPUS != 1 &&
-		  !spin_is_locked(&lruvec_pgdat(lruvec)->lru_lock));
+	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
 
 	if (!list)
 		SetPageLRU(page_tail);
-- 
2.19.0

