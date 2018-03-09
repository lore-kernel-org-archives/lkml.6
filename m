Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3285773-1520555332-2-13459564587745644347
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
    t=1520555332; b=P2xE3zYf6yesndo7xUtKMDJQ/CfVGnBqn9JP1gvygWxbF6a
    a+lUsZg+z7kmshE9yQBeVNw66rgjMtBcpfXUxGJSOjXvl/Gy4JLRn3RBBKSH9pbu
    DYtUUhQsGx5pyZ/mO+CmQ7qzxzYs9btAQQ93KZIBce0D+bMDGCHXj1cK3cbEjuC7
    QyGwBdc9cevFpghnnz9Fs2Rue48ZmNc132O64bmV3KfDyxO8f+xEDaVgfA5t8pcZ
    GNZkeVOhbMoIbMXsM+HVqcMGUI5LYyRa4r2PTtlGQuCxnWMHk7lKgmoJ14EfcWZx
    K8owxPYTdlsbtRSrQAQczHfiqezdcqomXiAMI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520555332;
    bh=F5QmSVAbNX3Ljy7xp+CErEhonDbV+OERk0TRHYnd5xI=; b=mo2jkQ8r8doo
    zT82iZSekMM8ehuJEUDhycdB+P1htjrI3FqgGl2QuS5u1s+soLdUaWCbMGk1c1Xn
    rxsgT09Oloj+47B9dQ3QcGktnpdMgoc+5CFWpmhoMv0+glSjqtJsp6XdOhDMDkY7
    8b/0+jAXovOGFJuo67dpoiBRaC8GNM5SPZzSSSmcaycPXvfzdrMDIoqWiHadYXdQ
    zkdYHfDN8XSTceA8EJuL8NEEv8JOF2xtNcVWihFYyCgQHTzrZ+wy+ClJsrTn92rj
    nMSfFCQB3KjtObfoljobeQlWJFVJ0ogSztP4EQyLK5NFhKfe5w68YhJ4CUuIJAvt
    sj46fsKbjA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=DF9oHlvj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=DF9oHlvj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbeCIA2t (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 19:28:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39332 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeCIA2r (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 19:28:47 -0500
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v3] hugetlbfs: check for pgoff value overflow
Date: Thu,  8 Mar 2018 16:27:26 -0800
Message-Id: <20180309002726.7248-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
References: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8826 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803090004
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
Changes in v3
  * Use a simpler mask computation as suggested by Andrew Morton
Changes in v2
  * Use bitmask for overflow check as suggested by Yisheng Xie
  * Add explicit (from > to) check when setting up reservations
  * Cc stable

 fs/hugetlbfs/inode.c | 16 +++++++++++++---
 mm/hugetlb.c         |  6 ++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 8fe1b0aa2896..e46117dc006a 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -108,6 +108,15 @@ static void huge_pagevec_release(struct pagevec *pvec)
 	pagevec_reinit(pvec);
 }
 
+/*
+ * Mask used when checking the page offset value passed in via system
+ * calls.  This value will be converted to a loff_t which is signed.
+ * Therefore, we want to check the upper PAGE_SHIFT + 1 bits of the
+ * value.  The extra bit (- 1 in the shift value) is to take the sign
+ * bit into account.
+ */
+#define PGOFF_LOFFT_MAX (PAGE_MASK << (BITS_PER_LONG - (2 * PAGE_SHIFT) - 1))
+
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
@@ -127,12 +136,13 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_ops = &hugetlb_vm_ops;
 
 	/*
-	 * Offset passed to mmap (before page shift) could have been
-	 * negative when represented as a (l)off_t.
+	 * page based offset in vm_pgoff could be sufficiently large to
+	 * overflow a (l)off_t when converted to byte offset.
 	 */
-	if (((loff_t)vma->vm_pgoff << PAGE_SHIFT) < 0)
+	if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
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
