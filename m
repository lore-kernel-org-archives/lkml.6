Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3867333-1522297100-2-11188334502044599395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522297099; b=UiPMsFP7cqmK+6AqmwAI9+LXMwln+wpgWlvAdDnPlayjNdT
    +MJbZcD8Q4SMrvcRNNCTQLE4lJfRJZmLrpfu75beNvXS43A3AH717ROgbLeMZWSD
    ARt9P8INhblXrxED9GKQm2e6Zru7uDcgvYNRiJOFmiW0t7XH9PC3qfep2QjItb54
    ZokDVHtZLRXFdYoSRNrGKfqr/LhvK034ikITrEGlwV6/v3Qcnknk3TqqiFMCHwGB
    rgx7I1J/u+vjI5U2c3h76ACNauVY6TZ5WhnZ6ZBC6veF1QuMqnp11Hm33BDHH/4+
    Z9R+AvqnX5PbSsNcAUx9wfchyYOVP5U47vyExQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522297099;
    bh=mBc7ERavmfRSdxeXynHW9K/+znG5yn8q02TYO7NFG40=; b=U6h67O5RfGWt
    G4hdK4b0LHKlB+9VfZk9diAEfywbPU2gG0j3ifIzSjxGuYc2uadHpNIfN5RtUZGL
    12hZZSqHjLasUTb6bIwxRtM2ZpyEQcs1qB8c1vvhDENkVK1kpT55A/4VSGzEVfXw
    DILIXJGeP/JgkXRPgPO+Wi3wWbfGP5O/cXjS/xNRDjfMSFWKTxOHP0T2gBj5pRoH
    2849CK9F3+nMkoV/4K9wzX/UTx24Rs+mrBVYaiPTS0w8v9KKR2hZIF4YjU/FnxWf
    eu9FpTpHPZFQDng58BpLjObZ8q9yoUfjLfcql+3MxyuVOxT5o0yVAMpZgYxTzRKa
    NA1z3mZJvA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=scIv/+FV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=scIv/+FV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCPT7IRJRkSCEG8Hf+O/+FTHA/exIdVy7KkGl164OXV7N76V1SAF8g3HX6bRSey00LFu6BK9vGHwFGCIxO4vpK/GPRBT6Nq6iXHeUJllNu79UYWfhJpm
    fOT3nSXQHkz8sZiSY2l0PrnEuejHUU1ZKzduoWb4NpEyRtqrztlo07EQUqSqY3bf0EXp9F18sNYGX0BXtKljbqZUFHP/z1vMHCowJlrswE2hrzMulOM7DkQc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=fes-6niNt7daO5jO9hAA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750716AbeC2ESR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 00:18:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57024 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeC2ESQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 00:18:16 -0400
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>, Dan Rue <dan.rue@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH 1/1] hugetlbfs: fix bug in pgoff overflow checking
Date: Wed, 28 Mar 2018 21:16:56 -0700
Message-Id: <20180329041656.19691-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180329041656.19691-1-mike.kravetz@oracle.com>
References: <20180329041656.19691-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803290046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a fix for a regression in 32 bit kernels caused by an
invalid check for pgoff overflow in hugetlbfs mmap setup.  The
check incorrectly specified that the size of a loff_t was the
same as the size of a long.  The regression prevents mapping
hugetlbfs files at offset greater than 4GB on 32 bit kernels.

Fix the check by using sizeof(loff_t) to get size.  In addition,
make sure pgoff + length can be represented by a signed long
huge page offset.  This check is only necessary on 32 bit kernels.

Fixes: 63489f8e8211 ("hugetlbfs: check for pgoff value overflow")
Cc: <stable@vger.kernel.org>
Reported-by: Dan Rue <dan.rue@linaro.org>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b9a254dcc0e7..8450a1d75dfa 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -116,7 +116,8 @@ static void huge_pagevec_release(struct pagevec *pvec)
  * bit into account.
  */
 #define PGOFF_LOFFT_MAX \
-	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
+	(((1UL << (PAGE_SHIFT + 1)) - 1) << \
+	 ((sizeof(loff_t) * BITS_PER_BYTE) - (PAGE_SHIFT + 1)))
 
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
@@ -138,21 +139,32 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 	/*
 	 * page based offset in vm_pgoff could be sufficiently large to
-	 * overflow a (l)off_t when converted to byte offset.
+	 * overflow a loff_t when converted to byte offset.
 	 */
-	if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
+	if ((loff_t)vma->vm_pgoff & (loff_t)PGOFF_LOFFT_MAX)
 		return -EINVAL;
 
-	/* must be huge page aligned */
+	/* vm_pgoff must be huge page aligned */
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
+	/*
+	 * Compute file offset of the end of this mapping
+	 */
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	/* check for overflow */
+
+	/* Check to ensure this did not overflow loff_t */
 	if (len < vma_len)
 		return -EINVAL;
 
+	/*
+	 * On 32 bit systems, this check is necessary to ensure the last page
+	 * of mapping can be represented as a signed long huge page index.
+	 */
+	if ((len >> huge_page_shift(h)) > LONG_MAX)
+		return -EINVAL;
+
 	inode_lock(inode);
 	file_accessed(file);
 
-- 
2.13.6
