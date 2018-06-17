Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D854C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE3D20895
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAn+YLjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE3D20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933557AbeFQB0G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 21:26:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39940 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932562AbeFQBZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 21:25:43 -0400
Received: by mail-oi0-f66.google.com with SMTP id f79-v6so11972427oib.7;
        Sat, 16 Jun 2018 18:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FeVrjoPVRRZyCyaiH643pOCRIcU631sOz5GKaUUbf2U=;
        b=HAn+YLjMNBKQNnGEZbhpWegEQZ0E5bRW2bqkfNeM6urOH4sfo+3ZZJmflyqH/fP3FV
         3su+xTuCXteuX8AUxPoI7CgO4BA8n7tjYhWJoE3unSuvF1DXfjoaFYVNqWVVzPYi2H79
         MCXKJ7/YuwXheWgOBlq+drpGd6TXC6kegNLLPuMKRc9y1F6JZ/+M3roWcReWY+XOTbWe
         X9VM2l3rsELKyHDoMkUnVTl+yxPDxPjGc9EKnM44S0Ta9yBB26lEYWB81NagEtc+iPPt
         XTQsPB8lSpKAc1ba6O36hwKqPLKFvRJVKJ5sxTT6G5IpTmqApTggBh/+9mLhUNokrk4h
         PbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FeVrjoPVRRZyCyaiH643pOCRIcU631sOz5GKaUUbf2U=;
        b=Wiz1eF+zpgkB08CbQsDkdBhuqx5FYAoYy0QhHnvUr7ic3TxOLDwGekAa+fF4vVoNb8
         MUzHPdj5mYD8o0I2N4RWpb+FiN0MCYPs0Sug8kRgw2PqkF4tiW36snnb7AwJevgD+Dy6
         U3a9RnIrCiu809l8I7NECSE+urV7TkKOmkWrkgxesqEe9zgp5od84O9aMd8iCq2L6nsX
         uWkTYvj5CQCygYDv4T3HDDPyz+6Dzx1cDQpjZAPHDidWbOQW21SVmaUMXBXjqsq/2zdG
         veptx2QFCwgvi8CnZV7l8umaq4K7K2E1Kq1Y1fZaZsez6AFv+BT+jyWS8CSw7tJ1mm/S
         Dgsw==
X-Gm-Message-State: APt69E2wT0vz9BPs2qzhS/qFlNMiPebbNzaE38UcfnORFTN3PePlGgf1
        f9UfGEnPQaiK25O7p+fK48Y=
X-Google-Smtp-Source: ADUXVKKBjUtB1RGyebUCknkJWt8kmgRf2mMvSOu/BOunbzuocKv7Qmd0CWM8RzACP2qOyJTc9ecokA==
X-Received: by 2002:aca:cf0a:: with SMTP id f10-v6mr4345274oig.258.1529198742662;
        Sat, 16 Jun 2018 18:25:42 -0700 (PDT)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id u13-v6sm4666912oiv.18.2018.06.16.18.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 18:25:41 -0700 (PDT)
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] consolidate get_user_pages error handling
Date:   Sat, 16 Jun 2018 18:25:09 -0700
Message-Id: <20180617012510.20139-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617012510.20139-1-jhubbard@nvidia.com>
References: <20180617012510.20139-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

In preparation for a subsequent patch, consolidate the error handling
for __get_user_pages(). This provides a single location (the "out:" label)
for operating on the collected set of pages that are about to be returned.

As long as we are already touching every use of the "ret" variable, fix
its name: "ret" --> "err". This also gets rid of two shadowed variable
declarations, as tiny beneficial a side effect.

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
2.17.1

