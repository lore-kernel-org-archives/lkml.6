Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2833181-1520543422-2-5947582768209289975
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520543421; b=jmO3p+VQMDX3sNFsLKbMsAjCEDOlgvFhG88VodBWlIdiILN
    imJvBRzOWl0EmsEPIArqah+HhBKsaOAj156t7k2dWQfFom0TFhsZBIlimfyoJG+s
    sgz9zl+rugGPdmOHkcr20PlTuQxSuvYQvS31B1PKb0WOOUc6mAUVz2w3pTOYofQg
    s8u+4yy0At2K2G/kkop2HEjnevdzvvazee2snZqSn8k7Gmbp4UKHtQtD0NdGODT2
    wV/4On6HF26ALwdBbhwrsY9FfDX9REcyfMB6GtB7hOpF+wbSI1RL1TSXnO5SQHeL
    uW1bu5Nd4F7Op3rBUkdfbYCvGSuiedA9ipLakNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520543421;
    bh=zBU1XsWgfoqtLwohs663fzPirzz8qCqxuzBG50K5ghA=; b=iF96T1qhJp5Z
    09tvFtsc4vWGOVRjJTySIVW/qNxIwKUoh20CM/pE7J2fFUX6dDNs8SZ9hUoMTlki
    Yt8T1X6dL2mIZJ7cspDCkcrkpovEQC9IenlqApdoJDvyo3JHZPnGz+S3tx9nbKMs
    OxjFCD3+dgapfkfgft1GkAeGWTDm2anqOLa7mkfJ2BbIQHxXREKgcypnFShVN7tr
    NNXcPpGOGbY5s+Ux1munWt8n4hTAvZEzZMOarTQYBa9QOWR5bX8Nw+3O04H9tHuK
    yNkRSFiFoa9scysKqS2bjZ2eoU675+Hta2N6svio4D2iE1qDESbkgOyFomqJGkNm
    JIUSQV3scg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=BIkuNTeL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=BIkuNTeL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbeCHVKT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 16:10:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36380 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbeCHVKS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 16:10:18 -0500
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v2] hugetlbfs: check for pgoff value overflow
Date: Thu,  8 Mar 2018 13:05:02 -0800
Message-Id: <20180308210502.15952-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
References: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8826 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080228
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A vma with vm_pgoff large enough to overflow a loff_t type when
converted to a byte offset can be passed via the remap_file_pages
system call.  The hugetlbfs mmap routine uses the byte offset to
calculate reservations and file size.

A sequence such as:
  mmap(0x20a00000, 0x600000, 0, 0x66033, -1, 0);
  remap_file_pages(0x20a00000, 0x600000, 0, 0x20000000000000, 0);
will result in the following when task exits/file closed,
  kernel BUG at mm/hugetlb.c:749!
Call Trace:
  hugetlbfs_evict_inode+0x2f/0x40
  evict+0xcb/0x190
  __dentry_kill+0xcb/0x150
  __fput+0x164/0x1e0
  task_work_run+0x84/0xa0
  exit_to_usermode_loop+0x7d/0x80
  do_syscall_64+0x18b/0x190
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

The overflowed pgoff value causes hugetlbfs to try to set up a
mapping with a negative range (end < start) that leaves invalid
state which causes the BUG.

The previous overflow fix to this code was incomplete and did not
take the remap_file_pages system call into account.

Fixes: 045c7a3f53d9 ("hugetlbfs: fix offset overflow in hugetlbfs mmap")
Cc: <stable@vger.kernel.org>
Reported-by: Nic Losby <blurbdust@gmail.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
Changes in v2
  * Use bitmask for overflow check as suggested by Yisheng Xie
  * Add explicit (from > to) check when setting up reservations
  * Cc stable

 fs/hugetlbfs/inode.c | 11 ++++++++---
 mm/hugetlb.c         |  6 ++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 8fe1b0aa2896..dafffa6affae 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -111,6 +111,7 @@ static void huge_pagevec_release(struct pagevec *pvec)
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
+	unsigned long ovfl_mask;
 	loff_t len, vma_len;
 	int ret;
 	struct hstate *h = hstate_file(file);
@@ -127,12 +128,16 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_ops = &hugetlb_vm_ops;
 
 	/*
-	 * Offset passed to mmap (before page shift) could have been
-	 * negative when represented as a (l)off_t.
+	 * page based offset in vm_pgoff could be sufficiently large to
+	 * overflow a (l)off_t when converted to byte offset.
 	 */
-	if (((loff_t)vma->vm_pgoff << PAGE_SHIFT) < 0)
+	ovfl_mask = (1UL << (PAGE_SHIFT + 1)) - 1;
+	ovfl_mask <<= ((sizeof(unsigned long) * BITS_PER_BYTE) -
+		       (PAGE_SHIFT + 1));
+	if (vma->vm_pgoff & ovfl_mask)
 		return -EINVAL;
 
+	/* must be huge page aligned */
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7c204e3d132b..8eeade0a0b7a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4374,6 +4374,12 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct resv_map *resv_map;
 	long gbl_reserve;
 
+	/* This should never happen */
+	if (from > to) {
+		VM_WARN(1, "%s called with a negative range\n", __func__);
+		return -EINVAL;
+	}
+
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
-- 
2.13.6
