Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0DEC65BD1
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F45621480
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtFCbeUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F45621480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeJFJv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 05:51:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36908 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeJFJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 05:51:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id az3-v6so7619642plb.4;
        Fri, 05 Oct 2018 19:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FVIsmZsD2UYUIajD9wCWvufUKrPcgTlr9PeHswP0yEs=;
        b=TtFCbeUQABKwJQNsY1ARZNCx4FpkA64f1mZStu96EEXotHAt9mhWVKYMxISGgZIuAy
         e9XH9h3UlTqIpFJMnHvv/F8ZM3YpgWBol0G9MgMTvKLfdMDQz8waroBAE9BLt5i93eVi
         unxz3ToLsqxZShV8nWoWz6xE75lLYMtfFYZa6ryBouDtkU2CFbENDu0gwAipIPucI4/f
         f0dfgBXLY34NZf5lVhC7Qpdg5v8kHXASNVpHN+Fzx8XoIQ0xnffM0N42BrjnGZSmJbKE
         YHf+gQbLgTWl94iN98FCxVLbs7fd8BDOird5jcNZ0YsgMma0hW3XG/ZtLeo0SFW8+VQ9
         z43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVIsmZsD2UYUIajD9wCWvufUKrPcgTlr9PeHswP0yEs=;
        b=Zy4hxmTA+QTudPryYRt/LBenb43SipAeeeA+JYpVicfCEx2cznd7tr0jKV4+ZV0boH
         QzA1Famlsjg2bLDdKCh1Q8SNG+J4Fx7ugCKhnsRGZIy9VGSHACdDIEEf3mfA2JXDiFs/
         PonFBbl4mHVcNa2QKF5kzxDHto/NwSwDT3UXvne3lgLh8cLz7pkuNk7P9rUrTns5RZrn
         G0LX1Hrxk5u6nEMoo7woH8cJduuyBZz3yfgPvH+0dq9dLsV3f3sxdBXyCbw984UO2aP2
         kLnT8moDmcnLCIuZfXct9l6X7deaaXXBkfanXLlWeClyuXhWYKQ56wltflq7Pk0hCYab
         DIjw==
X-Gm-Message-State: ABuFfojgEjPZ62dcd/gHT0Htc6CMJra0eay4DFKl43SMRI7kQyvIZWmH
        6o17LVDYKDRkhP/CScA/L5s=
X-Google-Smtp-Source: ACcGV62BmgctjFnuEzcUrQCVuDXjZsdW3sOw7lJYocd8SSwA0nJNtMPSF930/XkeU2sheSeUcgT72w==
X-Received: by 2002:a17:902:a618:: with SMTP id u24-v6mr14096438plq.77.1538794193757;
        Fri, 05 Oct 2018 19:49:53 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id n63-v6sm3962785pfn.9.2018.10.05.19.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 19:49:52 -0700 (PDT)
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
Subject: [PATCH v3 1/3] mm: get_user_pages: consolidate error handling
Date:   Fri,  5 Oct 2018 19:49:47 -0700
Message-Id: <20181006024949.20691-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181006024949.20691-1-jhubbard@nvidia.com>
References: <20181006024949.20691-1-jhubbard@nvidia.com>
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

