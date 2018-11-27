Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C32C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793A620873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793A620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbeK0U6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:58:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726825AbeK0U6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:58:17 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAR9wwkN063806
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:00:55 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p10js8m6j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:00:54 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 27 Nov 2018 10:00:52 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 10:00:48 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wARA0lR857475258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 10:00:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D768CA4059;
        Tue, 27 Nov 2018 10:00:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B62A4051;
        Tue, 27 Nov 2018 10:00:47 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.155])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Nov 2018 10:00:47 +0000 (GMT)
Date:   Tue, 27 Nov 2018 12:00:45 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/5] userfaultfd: shmem: add i_size checks
References: <20181126173452.26955-5-aarcange@redhat.com>
 <20181127065733.83FBA208E4@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127065733.83FBA208E4@mail.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18112710-0028-0000-0000-00000322192D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112710-0029-0000-0000-000023DE213A
Message-Id: <20181127100044.GA16502@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 27, 2018 at 06:57:32AM +0000, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 4c27fe4c4c84 userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support.
> 
> The bot has tested the following trees: v4.19.4, v4.14.83, 
> 
> v4.19.4: Build OK!
> v4.14.83: Failed to apply! Possible dependencies:
>     2a70f6a76bb8 ("memcg, thp: do not invoke oom killer on thp charges")
>     2cf855837b89 ("memcontrol: schedule throttling if we are congested")
> 
> 
> How should we proceed with this patch?

Below is the same patch backported to 4.14.83. With it the patch 5/5 in the
series applies cleanly.

From 89135f0df0323f38c0b036c87688f5a7e3cfa9e9 Mon Sep 17 00:00:00 2001
From: Andrea Arcangeli <aarcange@redhat.com>
Date: Mon, 26 Nov 2018 12:34:51 -0500
Subject: [PATCH v4.14.83] userfaultfd: shmem: add i_size checks

With MAP_SHARED: recheck the i_size after taking the PT lock, to
serialize against truncate with the PT lock. Delete the page from the
pagecache if the i_size_read check fails.

With MAP_PRIVATE: check the i_size after the PT lock before mapping
anonymous memory or zeropages into the MAP_PRIVATE shmem mapping.

A mostly irrelevant cleanup: like we do the delete_from_page_cache()
pagecache removal after dropping the PT lock, the PT lock is a
spinlock so drop it before the sleepable page lock.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Hugh Dickins <hughd@google.com>
Reported-by: Jann Horn <jannh@google.com>
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/shmem.c       | 18 ++++++++++++++++--
 mm/userfaultfd.c | 26 ++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8019118..70b9fb9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2238,6 +2238,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	struct page *page;
 	pte_t _dst_pte, *dst_pte;
 	int ret;
+	pgoff_t offset, max_off;
 
 	ret = -ENOMEM;
 	if (!shmem_inode_acct_block(inode, 1))
@@ -2275,6 +2276,12 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	__SetPageSwapBacked(page);
 	__SetPageUptodate(page);
 
+	ret = -EFAULT;
+	offset = linear_page_index(dst_vma, dst_addr);
+	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	if (unlikely(offset >= max_off))
+		goto out_release;
+
 	ret = mem_cgroup_try_charge(page, dst_mm, gfp, &memcg, false);
 	if (ret)
 		goto out_release;
@@ -2293,8 +2300,14 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (dst_vma->vm_flags & VM_WRITE)
 		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
 
-	ret = -EEXIST;
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+
+	ret = -EFAULT;
+	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	if (unlikely(offset >= max_off))
+		goto out_release_uncharge_unlock;
+
+	ret = -EEXIST;
 	if (!pte_none(*dst_pte))
 		goto out_release_uncharge_unlock;
 
@@ -2312,13 +2325,14 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
-	unlock_page(page);
 	pte_unmap_unlock(dst_pte, ptl);
+	unlock_page(page);
 	ret = 0;
 out:
 	return ret;
 out_release_uncharge_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
+	delete_from_page_cache(page);
 out_release_uncharge:
 	mem_cgroup_cancel_charge(page, memcg, false);
 out_release:
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 5dbfcac0..5d70fdb 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -34,6 +34,8 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	void *page_kaddr;
 	int ret;
 	struct page *page;
+	pgoff_t offset, max_off;
+	struct inode *inode;
 
 	if (!*pagep) {
 		ret = -ENOMEM;
@@ -74,8 +76,17 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (dst_vma->vm_flags & VM_WRITE)
 		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
 
-	ret = -EEXIST;
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	if (dst_vma->vm_file) {
+		/* the shmem MAP_PRIVATE case requires checking the i_size */
+		inode = dst_vma->vm_file->f_inode;
+		offset = linear_page_index(dst_vma, dst_addr);
+		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+		ret = -EFAULT;
+		if (unlikely(offset >= max_off))
+			goto out_release_uncharge_unlock;
+	}
+	ret = -EEXIST;
 	if (!pte_none(*dst_pte))
 		goto out_release_uncharge_unlock;
 
@@ -109,11 +120,22 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 	pte_t _dst_pte, *dst_pte;
 	spinlock_t *ptl;
 	int ret;
+	pgoff_t offset, max_off;
+	struct inode *inode;
 
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
-	ret = -EEXIST;
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	if (dst_vma->vm_file) {
+		/* the shmem MAP_PRIVATE case requires checking the i_size */
+		inode = dst_vma->vm_file->f_inode;
+		offset = linear_page_index(dst_vma, dst_addr);
+		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+		ret = -EFAULT;
+		if (unlikely(offset >= max_off))
+			goto out_unlock;
+	}
+	ret = -EEXIST;
 	if (!pte_none(*dst_pte))
 		goto out_unlock;
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
-- 
2.7.4

 
> --
> Thanks,
> Sasha
> 

-- 
Sincerely yours,
Mike.

