Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB42AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5582073F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RceGW/dM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5582073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeK2K6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:58:55 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38652 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbeK2K6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:58:55 -0500
Received: by mail-io1-f68.google.com with SMTP id l14so79326ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rAo7eNFTAOvntn7w4xkOfgHD9+s+0OjB6lQm+RJmv0M=;
        b=RceGW/dMCsIwSzYA+BCKQ1hPAic0MmXHH+Bv0oTZETuq4mDi/PquDGa55gM5fSMHdI
         VggyxXmDiNCUZApj6Aa7kRoygHXYQF5YMN57Zv/OhtBPUQFbQ8qC0nqm7U/yRxyAogNs
         oYWGXdGnIHOnnwtELU8mANCh3oA7uAMQjKwjyJusY1F1BFEhHr6QbzbV5YKknxfyEC0o
         SuiPg2FegoRjiG/vAkDb02ZHgOokJWJ3n8js30hgJqDhdrKaNji0fAJnz9AFytVRoGhM
         V42oVDTBcL47YUrOM7/2YtutndQUU7kfU8jDC8LENEngUgbeKBtmaVPo+vXfHLM6EgRk
         o1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rAo7eNFTAOvntn7w4xkOfgHD9+s+0OjB6lQm+RJmv0M=;
        b=aZ4sIaOp7wAFDa+fz/bLQynIkk2QHmqhG8TjLZqEPFLbwmtMIUr8tH/T6oj+IffxXJ
         toZsO00JPzdyCEsRUaoCIVbGfyPSmmYk2cPYxJWP4cvzSKaxXn0Eaz0FC23BKMOGFSnE
         oKzGZEac8UBqTQ6bkKd25Q8SFBY7+lI8IpFbJAQjpnU32vG0I45t7Dog9KOw/uRKq5EX
         L57vxz5dVDY47y4cBTZKrNELEOsbMIaHpG7TPY873SGxB1ij7YRolRvCLrNo+SEJMv7S
         vwczvYuSwbVT3MA10AKfdQfpC6W3CIblnoCotcCcejeSx7aMqB/8AheuBd7b1j8VMfVC
         zpyw==
X-Gm-Message-State: AA+aEWavZDzRtc5vGg8PULxKf3LYzFL1727pN7hAptAhNhNKIJe5kLTr
        fF7tCC3KHMfAuS0xGbxCd/JCYg==
X-Google-Smtp-Source: AFSGD/V9Qm30w/cfBPWe/3jTX2s8WyRXBQcuuMg/+p6yAp8qU54L97a8I7BrkKDHRow//lmJohx4NQ==
X-Received: by 2002:a6b:6a02:: with SMTP id x2mr18551104iog.204.1543449332685;
        Wed, 28 Nov 2018 15:55:32 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id y13sm31490ioa.56.2018.11.28.15.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 15:55:31 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mm: remove pte_lock_deinit()
Date:   Wed, 28 Nov 2018 16:55:25 -0700
Message-Id: <20181128235525.58780-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pagetable page doesn't touch page->mapping or have any used field
that overlaps with it. No need to clear mapping in dtor. In fact,
doing so might mask problems that otherwise would be detected by
bad_page().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5411de93a363..7c8f4fc9244e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1900,13 +1900,6 @@ static inline bool ptlock_init(struct page *page)
 	return true;
 }
 
-/* Reset page->mapping so free_pages_check won't complain. */
-static inline void pte_lock_deinit(struct page *page)
-{
-	page->mapping = NULL;
-	ptlock_free(page);
-}
-
 #else	/* !USE_SPLIT_PTE_PTLOCKS */
 /*
  * We use mm->page_table_lock to guard all pagetable pages of the mm.
@@ -1917,7 +1910,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct page *page) { return true; }
-static inline void pte_lock_deinit(struct page *page) {}
+static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline void pgtable_init(void)
@@ -1937,7 +1930,7 @@ static inline bool pgtable_page_ctor(struct page *page)
 
 static inline void pgtable_page_dtor(struct page *page)
 {
-	pte_lock_deinit(page);
+	ptlock_free(page);
 	__ClearPageTable(page);
 	dec_zone_page_state(page, NR_PAGETABLE);
 }
-- 
2.20.0.rc1.387.gf8505762e3-goog

