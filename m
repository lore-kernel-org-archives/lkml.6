Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB057C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF53216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5r6tBaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF53216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeI1MB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:01:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43845 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbeI1MB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:01:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so3493861pfi.10;
        Thu, 27 Sep 2018 22:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FVIsmZsD2UYUIajD9wCWvufUKrPcgTlr9PeHswP0yEs=;
        b=n5r6tBaCfMwQJkMX1wNstsmX0XTetJz0PQnc4I6TTdGn5A0pBCYos1RpuFTQmM5hee
         ePBsKuqJClD80pR5uM+cOaCDaDiobtXHd4BugZ9R1lWYdqV3kMb/O1cbQx2j6jifnfPC
         OHYQKA1Z4f1/VkcgCqMJNMdxpDWpZCbVSPHwavstfckQEu0JsDhU4QTn82HhYQaLSXNS
         ektAk+Q6/Mat3WtnRAVZRR08nDBFtuDcbTkGsWB7Ps0t2T+XjWP3iYeWCvxEHdDTJ28d
         nP3DII/FHRK+Rc+fskScXoB3LUkO6/aUlAvFZvg/5NPsorwoQLAdV3O/w5WAONvGXDG/
         ylsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVIsmZsD2UYUIajD9wCWvufUKrPcgTlr9PeHswP0yEs=;
        b=BoEo53AJS/8oAuWR7d34NX+QvzL4/G2yGO2YlZxvsUwIdBDpLZDYRAw4niq47PtX0k
         PZSp/VJtNnKuyBkg2MIe6N33AivSLUe84LYpGQM2O2O6N9cghUM3T3tJT1fo1z6zr1p7
         oiGlmW1hXsSPJERQBd8KIqyomZLMmeLczVVByqXGwf4Jf+i93p26YBmHJK2/OJabig+H
         Cbr5PYP4NCUF5p4INTC+MV38h8j07cN6RSfDBJRvIckVAyn1okinSobbUjK5kLSkXQXM
         u1Vhpi8yxDdfBFw48i8Xoo/Lnyst8kUsPzneKVgDDZiz+3t7tPS3SmscsfQMOVD6iq0g
         pSTg==
X-Gm-Message-State: ABuFfohEh3QtXmxuO8ftZkDKICERNZC6TpM8RNEvL9wMemWVf7L0OUyT
        yxXXCtl1EDiBVmvPIty6IaY=
X-Google-Smtp-Source: ACcGV63VBR+76bN61j/R5pu3ZYOFO30IL/SSRAT4nbQ6f5aCW7Pi+BLOjTjb+ceaQUz6DgMOBj4qfg==
X-Received: by 2002:a62:12c9:: with SMTP id 70-v6mr14833644pfs.140.1538113197825;
        Thu, 27 Sep 2018 22:39:57 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id u9-v6sm6569953pfi.104.2018.09.27.22.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 22:39:56 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/4] mm: get_user_pages: consolidate error handling
Date:   Thu, 27 Sep 2018 22:39:46 -0700
Message-Id: <20180928053949.5381-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928053949.5381-1-jhubbard@nvidia.com>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
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

