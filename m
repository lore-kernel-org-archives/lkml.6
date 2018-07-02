Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B2DC6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9F4255F8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWfbcYK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9F4255F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932363AbeGBA5r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:57:47 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45681 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbeGBA5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:57:37 -0400
Received: by mail-oi0-f68.google.com with SMTP id m2-v6so5393795oim.12;
        Sun, 01 Jul 2018 17:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QznxYmIJyvjPvcW2d5RmodQzyafpankCZbir/u4uwqA=;
        b=hWfbcYK90ZFSVF7CPhjJqkZJkFXYwIcrJsA8qSWx2d9D2WE42OFwjIogQ+dK61wWbz
         xi/AtqTf8nmYTn8f4pqy1+JBT30ww2wcnqYTu7eoVodIDpP+TZWHMDT/FXyzAdefpARV
         5wQ1/0qZSWRw1YXfRjuAYtPIP8mBPfCYXh9NniKCeKHWyoogjOa2DT1w3EGp+AmrXlIE
         tFdlxKXMGne9l3mStfbdMZcPA83e1TKDEI6I2zpnkP4B7lNJWDAafslxzJ2yQAlAJicU
         uHj4bIKxemEsq6ZHHBFYSOJGobVExjGEmoZwNYQjTYvhWRKx/E4U+Fr7z2FOvKzaxXmq
         9mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QznxYmIJyvjPvcW2d5RmodQzyafpankCZbir/u4uwqA=;
        b=a86EzIIiD0X+HDbXApdoepXF1RgsSWxEqH/dnoULQx8QsI5wXzEe6wafTvFWHn1Rgm
         LQRYsSy+PoIfdXQ/Xov18rCdse8v1p/BUIMp2Btw9qqajSPwaA/xOZ7pUpgwFQfqXjD1
         jnvS8/EUt7qviiSUBF5lSUE284WOl4/sADrVIXCI7S5Q+muxYreIrB2n5sDn25GS8Qtc
         NPhwxKaJuc4sW8bsMvbeXQYUFy9omvi5ZNAFviZf5gsx9LdLWZ6uAo1IltfYuHzvt50F
         dyoZrEBegLf8CtqJch9yLvr4UbPg78mnegJC+6DlVn454NGIBeAlVTl7g+ZLUCILgMpW
         dokQ==
X-Gm-Message-State: APt69E1pTHeBKpAPo9KOmCYSpm+hOskxeuGM7CueGMN8zSXzk2nzLk/U
        UrN7XakYr79gM/HMq5cnIV7IIg==
X-Google-Smtp-Source: AAOMgpcQ8Y1bpOxRFXxcg5s3ok3Rqo7VC9R76sdBKKGJFLAcKfEcH4yxfhnFde/pthu9PzWlDeYRew==
X-Received: by 2002:aca:7517:: with SMTP id q23-v6mr12490591oic.352.1530493056827;
        Sun, 01 Jul 2018 17:57:36 -0700 (PDT)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4111672oix.30.2018.07.01.17.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 17:57:35 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/6] mm: get_user_pages: consolidate error handling
Date:   Sun,  1 Jul 2018 17:56:49 -0700
Message-Id: <20180702005654.20369-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702005654.20369-1-jhubbard@nvidia.com>
References: <20180702005654.20369-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

An upcoming patch requires a way to operate on each page that
any of the get_user_pages_*() variants returns.

In preparation for that, consolidate the error handling for
__get_user_pages(). This provides a single location (the "out:" label)
for operating on the collected set of pages that are about to be returned.

As long every use of the "ret" variable is being edited, rename
"ret" --> "err", so that its name matches its true role.
This also gets rid of two shadowed variable declarations, as a
tiny beneficial a side effect.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b70d7ba7cc13..73f0b3316fa7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -660,6 +660,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		struct vm_area_struct **vmas, int *nonblocking)
 {
 	long i = 0;
+	int err = 0;
 	unsigned int page_mask;
 	struct vm_area_struct *vma = NULL;
 
@@ -685,18 +686,19 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		if (!vma || start >= vma->vm_end) {
 			vma = find_extend_vma(mm, start);
 			if (!vma && in_gate_area(mm, start)) {
-				int ret;
-				ret = get_gate_page(mm, start & PAGE_MASK,
+				err = get_gate_page(mm, start & PAGE_MASK,
 						gup_flags, &vma,
 						pages ? &pages[i] : NULL);
-				if (ret)
-					return i ? : ret;
+				if (err)
+					goto out;
 				page_mask = 0;
 				goto next_page;
 			}
 
-			if (!vma || check_vma_flags(vma, gup_flags))
-				return i ? : -EFAULT;
+			if (!vma || check_vma_flags(vma, gup_flags)) {
+				err = -EFAULT;
+				goto out;
+			}
 			if (is_vm_hugetlb_page(vma)) {
 				i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &nr_pages, i,
@@ -709,23 +711,25 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		 * If we have a pending SIGKILL, don't keep faulting pages and
 		 * potentially allocating memory.
 		 */
-		if (unlikely(fatal_signal_pending(current)))
-			return i ? i : -ERESTARTSYS;
+		if (unlikely(fatal_signal_pending(current))) {
+			err = -ERESTARTSYS;
+			goto out;
+		}
 		cond_resched();
 		page = follow_page_mask(vma, start, foll_flags, &page_mask);
 		if (!page) {
-			int ret;
-			ret = faultin_page(tsk, vma, start, &foll_flags,
+			err = faultin_page(tsk, vma, start, &foll_flags,
 					nonblocking);
-			switch (ret) {
+			switch (err) {
 			case 0:
 				goto retry;
 			case -EFAULT:
 			case -ENOMEM:
 			case -EHWPOISON:
-				return i ? i : ret;
+				goto out;
 			case -EBUSY:
-				return i;
+				err = 0;
+				goto out;
 			case -ENOENT:
 				goto next_page;
 			}
@@ -737,7 +741,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 			 */
 			goto next_page;
 		} else if (IS_ERR(page)) {
-			return i ? i : PTR_ERR(page);
+			err = PTR_ERR(page);
+			goto out;
 		}
 		if (pages) {
 			pages[i] = page;
@@ -757,7 +762,9 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		start += page_increm * PAGE_SIZE;
 		nr_pages -= page_increm;
 	} while (nr_pages);
-	return i;
+
+out:
+	return i ? i : err;
 }
 
 static bool vma_permits_fault(struct vm_area_struct *vma,
-- 
2.18.0

