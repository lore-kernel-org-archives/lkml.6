Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD17FC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FCD2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnBPsSfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FCD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeJEK7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 06:59:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43725 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbeJEK7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 06:59:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id p24-v6so4408335pff.10;
        Thu, 04 Oct 2018 21:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FVIsmZsD2UYUIajD9wCWvufUKrPcgTlr9PeHswP0yEs=;
        b=jnBPsSfK5fSXGwduKnZGAGaMGRRYua4ihkiQF/kSRjRfwYA7Nki2njxBsluBQp1a2N
         zJoaFzdL6stH9ZpgKFPj3ZAgP+bbvg0sGgjF2xk4+CTaXJU6EYIzpO14aVEeJNm21Ez6
         rgn2EBLW6zUyMoGUFhRmQquZsjsA4YOr2ZgVH/rUGJ0CHEGDXEQujR26l2PawuGebxWo
         9634LJicJryqBps2Ker4hPLHAIFzDZEOcp4X0IHkcbpB2nkg0LO/dOc+G/0UlqKJDh7w
         O88lGtgflHTsV4BLHfZNYEdINT3cQAYIVuodOJ7bMRiEa1jlVruRwEqlmf/+9PIbrPlo
         bhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVIsmZsD2UYUIajD9wCWvufUKrPcgTlr9PeHswP0yEs=;
        b=hfg8zsWWC6lYL5aGU1FBG0kxA0+lWIuDw7aYLLGJS8/2n9sgy/cY+vMXO0KLkG9FsK
         xReBuqZN3QLeM8DVKAgp7ANxeUJFxVOACS1JsHHFlgIY5go1YMFS6ubjC+k7xswta4hH
         bqpfUZPfe8WlHTqVZlxo4RlY5uJgRVTSsKLaRL+23JupEtR4BX0PO9UqHoTZ782ajE5W
         xlLPIQyn0Uhz+b/zOc3jsFOfwhWXFeZsMYvnL8WVHSpHHj0SE0yeA3o7L8FBcjx2Kkz7
         9mzgXUPIkW4TR/MfH8Uc0SA0Yn7uSo0WkCNi2lHW33jYRa/O5jxuP83KJS3R/q1lmjS/
         GJ8w==
X-Gm-Message-State: ABuFfoi+GNWUsNOvI4GjfU3QXAmpj40ynEohIAU7Fr/xN0p1jMyRjPvw
        ZT5xRiIYcDn+x7u9+ceCygvt5O5R
X-Google-Smtp-Source: ACcGV63oi1zgzhFKtBbotOp0wxv3Zx7L4Yb5NK6heXq7C8ZXXTl2TMHDg76/I8sW8MkGluw2iX8tEg==
X-Received: by 2002:a62:4799:: with SMTP id p25-v6mr9886156pfi.197.1538712150072;
        Thu, 04 Oct 2018 21:02:30 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c2-v6sm8787899pfo.107.2018.10.04.21.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 21:02:29 -0700 (PDT)
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
Subject: [PATCH v2 1/3] mm: get_user_pages: consolidate error handling
Date:   Thu,  4 Oct 2018 21:02:23 -0700
Message-Id: <20181005040225.14292-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005040225.14292-1-jhubbard@nvidia.com>
References: <20181005040225.14292-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1abc8b4afff6..05ee7c18e59a 100644
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
2.19.0

