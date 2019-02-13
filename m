Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6547C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BB62073D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550057357;
	bh=t0WtODaM7AuQlwBZLOMx9abPkOFEhW4NyoY8KPN44Hk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kGwkLnle2RGZ6Iq6Sj4K9+k88qktI856k1J8QbGYs7B62sgWKMmdIeNbtRJmUuHtn
	 lXba67TLSMrAm/NtvgeU3Rw/U8IBM48jjVLpLhKiE2VqwzWmZhzUYC8F1MUuQeyzJu
	 nI9DvtbiXuFErNjzHQzMTGSI3ZfJvGcJkkBr/1YE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403961AbfBML3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:29:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37234 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403930AbfBML3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:29:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so1014156pfh.4;
        Wed, 13 Feb 2019 03:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZP4eZYg4uMuESOTns7x6z0Gns1FpDtn/SzQe1DyPZ2c=;
        b=fBMsPRyi5W07JhLDu6G7haXyioP2Nu9geoYYaXXao12x4/GcGBKANyupnDaTtheYrx
         CBRu4eUMgDG8Imk1kCi7cLRQhdjs9hYBR6XrREMCo+ul2XWUK07iJSzf0RrzfmuKWl6D
         HmS6ZH84nN8L6FYoydqnzV+FOQabKtRzxrGfCe9sxFsgqjFJmA4gV1ZwOYqz/ltjabEb
         vDmM6fGwz/iR5z+iESZj4VVrl8ZOzr7SmlMVqPiUmifjPRavafgaKH7nL1UkhWF0IOdg
         aYwymCh4A6LcwzdeTZkgYtiP5T3CwARnboi65AmwqmbV4djTXFhq+iF1kPdbFDE/6klb
         d7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZP4eZYg4uMuESOTns7x6z0Gns1FpDtn/SzQe1DyPZ2c=;
        b=KfCVfn73jUtyPaGHKoOPK6s1vBfKF/lyU46jI6K6dYL1x7I71BYtk6shrJ2SVkHsQo
         BmdXrnE05HWZMrO/v7aonTL/6NffMtL4sRCkBVI5dhSIEIAwz7Kq4WWJP0fWcvhcYvGR
         tuuLk8mpnAEmwDp/y4LJLFwuiCQzw4z/FrBlkY+gfmTJABt99Aoz5LHZOsWfpc3LHRM1
         guY52JEStvNvzqMx8GCz+wbzBAeFCs7vXtNgVhgPJFpyVOuS+wWMPG4Q/l7U8perv6tU
         eTBDlEjEtTLkSnpKMonpOCScElzEdV9shlqOfK13e2ihmucJeRywi5sPN0EwvkhW0XPL
         PS7Q==
X-Gm-Message-State: AHQUAubrv6cxmvlqsVnpG/LkvRuXZ4qXWMSzMRj7hhjiEnp8ti7/bpBA
        miSKDZ8bR35atKMuQoavKrWq5miW
X-Google-Smtp-Source: AHgI3IazGpHnKo0uva+QDysHCoFLMqAktO841uduCRt0cTupKZWBIYuAxV8TGgMRyaYbmf6asGY5SA==
X-Received: by 2002:a63:5813:: with SMTP id m19mr12411pgb.294.1550057353027;
        Wed, 13 Feb 2019 03:29:13 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id e19sm6968911pfn.145.2019.02.13.03.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 03:29:11 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, stable@vger.kernel.org
Subject: [PATCH] mm: Fix the pgtable leak
Date:   Wed, 13 Feb 2019 20:29:00 +0900
Message-Id: <20190213112900.33963-1-minchan@kernel.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[1] was backported to v4.9 stable tree but it introduces pgtable
memory leak because with fault retrial, preallocated pagetable
could be leaked in second iteration.
To fix the problem, this patch backport [2].

[1] 5cf3e5ff95876, mm, memcg: fix reclaim deadlock with writeback
[2] b0b9b3df27d10, mm: stop leaking PageTables

Fixes: 5cf3e5ff95876 ("mm, memcg: fix reclaim deadlock with writeback")
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Liu Bo <bo.liu@linux.alibaba.com>
Cc: <stable@vger.kernel.org> [4.9]
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/memory.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 35d8217bb0467..47248dc0b9e1a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3329,15 +3329,24 @@ static int do_fault(struct fault_env *fe)
 {
 	struct vm_area_struct *vma = fe->vma;
 	pgoff_t pgoff = linear_page_index(vma, fe->address);
+	int ret;
 
 	/* The VMA was not fully populated on mmap() or missing VM_DONTEXPAND */
 	if (!vma->vm_ops->fault)
-		return VM_FAULT_SIGBUS;
-	if (!(fe->flags & FAULT_FLAG_WRITE))
-		return do_read_fault(fe, pgoff);
-	if (!(vma->vm_flags & VM_SHARED))
-		return do_cow_fault(fe, pgoff);
-	return do_shared_fault(fe, pgoff);
+		ret = VM_FAULT_SIGBUS;
+	else if (!(fe->flags & FAULT_FLAG_WRITE))
+		ret = do_read_fault(fe, pgoff);
+	else if (!(vma->vm_flags & VM_SHARED))
+		ret = do_cow_fault(fe, pgoff);
+	else
+		ret = do_shared_fault(fe, pgoff);
+
+	/* preallocated pagetable is unused: free it */
+	if (fe->prealloc_pte) {
+		pte_free(vma->vm_mm, fe->prealloc_pte);
+		fe->prealloc_pte = 0;
+	}
+	return ret;
 }
 
 static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
-- 
2.20.1.791.gb4d0f1c61a-goog

