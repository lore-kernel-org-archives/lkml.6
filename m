Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B6CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE8F206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsDeDIPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE8F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJLNbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:31:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34784 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJLNbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:31:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id g12-v6so5316880pgs.1;
        Thu, 11 Oct 2018 23:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1XCFIhhXu5KYwGhfpBRnNL+5p8VFETRcpPOZd4dSpDA=;
        b=fsDeDIPQmKRnI18r/+2FwFVtak9RtcpCRBUnKBYyScKv96iejPuwkAQK5ZDewjXoiS
         1qRLlcBoDxq0ldinIPZe2PHajgJ2L0p1vsgKHiTEDhF/ZWNZfL6Yo4btB3G9pYx59v24
         7nAHOzUvqbXghHcTNGfOI/eXy88UQV+CFdHOoD2EC9t1CkIBJ70qB/nSZJCGToEXoaQb
         9EW+unarM6zGw5G9uHFgfhCnasiHFN4JCl/Gf7HQvce5U+YHL3VFrAk3uYr1k1v5e+CX
         JyLU88noyz2M50jztrqUyJLuWn/MWfb2V2TDjeakz+eDcn+pdPeKPN38/tDlBu4Hloy7
         Kp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1XCFIhhXu5KYwGhfpBRnNL+5p8VFETRcpPOZd4dSpDA=;
        b=kPHhqBoHENK/W5smzg6KNtJ6+yeLadiChHQ2ny4IASwNQjsyZZAPfr/3rLaKVzpzV4
         IQxzSnVt5P/aBPR+VM8ZcmDH6rqlyd5pLk+cSKm2KwF5hzxh8xDV6aL7zn1LMx1wop1R
         yB6GL9lhJ7fYe54Q2Nsc+e+O6jTPz7t/CMJ8IxzQrMNDEj9G0CtYHuiD5ZAA+kU8gWeR
         HtjTJpYTusymblbke5yPJW9hmFartm7Iw0FHh2I8wGjJ/6R63TlbMQC+12E8Jv8E4TPq
         MhxcXAZJQzniD3gxfdUm1t4/VkBOW0cdLE5khV2A1KhKzjEALwjIEnb5SSD+Y1tsmL11
         r33Q==
X-Gm-Message-State: ABuFfohZ7M6WXlU/TdcRqO82QZbs+hH5QUst1Pi9kSAUAh8WhDXGhHv1
        27SPiXgNhtLNnURkoRiXMNQ=
X-Google-Smtp-Source: ACcGV62XNUiEKULSVjMNvWsdYNkkuO1xneOLDXlNTd0PHbasw7NkAHpQ0s2S8aBqXpoWs/95W2x9bA==
X-Received: by 2002:a62:70c7:: with SMTP id l190-v6mr4652059pfc.186.1539324029162;
        Thu, 11 Oct 2018 23:00:29 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z3-v6sm368579pfm.150.2018.10.11.23.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 23:00:28 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/6] mm: get_user_pages: consolidate error handling
Date:   Thu, 11 Oct 2018 23:00:09 -0700
Message-Id: <20181012060014.10242-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012060014.10242-1-jhubbard@nvidia.com>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
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
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
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
2.19.1

