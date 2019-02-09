Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DDCC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8955421934
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738074;
	bh=dvR1nJMfzgWZnqjrYs8gGiZCI7ekIPKLaIMovEzrF3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RVZytGegCQS7v7Vzmv0YpFGQNX8skZyL9FW1srDTWRe6hSaMLpgh+J1bQSksccHBW
	 OS88bpfHx9X4W0xnmgAubwDuwWCX0UheeW5CVDX+60YFa9m207FrrUVNY57GldwWZb
	 4djpEbT7ed/MEn/9NOKM+SAWgnhduUtszvBuM5ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfBISrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:47:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfBISrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD5A21A4A;
        Sat,  9 Feb 2019 18:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738068;
        bh=dvR1nJMfzgWZnqjrYs8gGiZCI7ekIPKLaIMovEzrF3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0krOI0dvuExaGBtoh4frjfeKZ6+W2RYZEUWt+K/iCNMMeZmrP3Sr/I4g0uBbm2t7X
         Ac1w68N/21J87AVoiiEZ1DR1vLyCukF9jRQi7enpDa6r6toEeoEO483nLRre5611IF
         wpkaR7fc2AVyJcL8HQhd+Z5vOshgZDQvNl+qJkVg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 12/42] csky: fixup compile error with pte_alloc
Date:   Sat,  9 Feb 2019 13:47:04 -0500
Message-Id: <20190209184734.125935-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

[ Upstream commit 2a60aa14a9a0333b3eef58150bc1ef654f7321ef ]

Commit: 4cf58924951e remove the address argument of pte_alloc without
modify csky related code. linux-5.0-rc1 compile failed with csky.

Remove the unnecessary address testing in pte_alloc().

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/include/asm/pgalloc.h | 43 ++++++++++++++-------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index bf4f4a0e140e..d213bb47b717 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -24,41 +24,34 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern void pgd_init(unsigned long *p);
 
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
-					unsigned long address)
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
 	pte_t *pte;
-	unsigned long *kaddr, i;
+	unsigned long i;
 
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL,
-					 PTE_ORDER);
-	kaddr = (unsigned long *)pte;
-	if (address & 0x80000000)
-		for (i = 0; i < (PAGE_SIZE/4); i++)
-			*(kaddr + i) = 0x1;
-	else
-		clear_page(kaddr);
+	pte = (pte_t *) __get_free_page(GFP_KERNEL);
+	if (!pte)
+		return NULL;
+
+	for (i = 0; i < PAGE_SIZE/sizeof(pte_t); i++)
+		(pte + i)->pte_low = _PAGE_GLOBAL;
 
 	return pte;
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
-						unsigned long address)
+static inline struct page *pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *pte;
-	unsigned long *kaddr, i;
-
-	pte = alloc_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL, PTE_ORDER);
-	if (pte) {
-		kaddr = kmap_atomic(pte);
-		if (address & 0x80000000) {
-			for (i = 0; i < (PAGE_SIZE/4); i++)
-				*(kaddr + i) = 0x1;
-		} else
-			clear_page(kaddr);
-		kunmap_atomic(kaddr);
-		pgtable_page_ctor(pte);
+
+	pte = alloc_pages(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!pte)
+		return NULL;
+
+	if (!pgtable_page_ctor(pte)) {
+		__free_page(pte);
+		return NULL;
 	}
+
 	return pte;
 }
 
-- 
2.19.1

