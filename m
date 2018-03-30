Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3951265-1522429442-2-14372729029154380548
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522429442; b=Y1xkyI9BnCP0cMwpFOqc9Qy1LKWLe+Q+XTnzQpUFgWOgawTZP+
    eSXw9yanRkHVGh7s7dAx9KU5smwivvIn5ucFtTwDCTUzF8x+h0WJtmrqdV1WtJ6D
    MO/VB+Hdru6kiKG4oqXPGOZjLqfSL+0yqUNxMp+wkrsWCBj12GrLIrcyci8cRSe4
    dwdVujijJzIFsHVbT5oHWrcrxOS8w86a46xGxgEY3iWapHGLhGiQy+P+m3AsHKlG
    1AEwh79yoWotR5Qp6Y4szBPrZUMiCHCseI85jFhB6gb+VsyO47qR/yf1eEWi74kV
    CEvdTeB9Mz0ltFFGiE4eDWwn22JxoXuByJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522429442; bh=
    hQr0JpfO5sqYfOd7K/CM4JKMtpNUO7BS2MHOPxhai8I=; b=mh7WuPPqX2AKmr5J
    pyoPPF3tQbvwwtDAHOcqQDZ/Z51RY/e8juYuvF2j32QqxqHLYrFgsbG2Z03HAuNX
    bPefytHcME5saHUnUDuKS1+s/afLs6HUmSjI4YvwA/OqgcxUlR15YTctviDIkHjW
    Qxi33sWdc+vyZomT+aRJaUieFLPFPnuFzqBFBs827UKXGlfQI6SNhI+pZHDno+6I
    1lx0cXk6JgRthUGMOQQH88ItTWWxzW2Ew4r3mtuqPEY5Y6qSRPev3qxNxrM2eSFR
    NVNfSk9gNQghmGcetbISB2oJ4jQliGOd1RzBwW1HFK8yS/oDaRd5NcAiRmejvV6k
    JIqlWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=D0kKWHzY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
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
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=D0kKWHzY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLYfJ6Zx7e3H9rsB7H6HaZVYmgBjEyEqTHbO9VSgsbezCIhtRQxIWlWgHvNRa2odt3wtYEK018lsWuIbCkNHsla9OO8kpMRKsHXMimXwEsJqfe7VBuqF
    nrDlf0PE+x5cfomk0rMNpjY2jqo20wxFgbfwPzsJH8IjmFHdPRgkjLgNgER9a2CL9cPnOOhheYzA7byHHcRsdAlStfKDz4bncOug2tjkAo7jPljDun1wsjuY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=98uq9BB7OUXLZNVQ-LcA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeC3RD6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 13:03:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43302 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeC3RD5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Mar 2018 13:03:57 -0400
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>, Dan Rue <dan.rue@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v2] hugetlbfs: fix bug in pgoff overflow checking
Date: Fri, 30 Mar 2018 07:54:02 -0700
Message-Id: <20180330145402.5053-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180329041656.19691-1-mike.kravetz@oracle.com>
References: <20180329041656.19691-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8847 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803300148
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a fix for a regression in 32 bit kernels caused by an
invalid check for pgoff overflow in hugetlbfs mmap setup.  The
check incorrectly specified that the size of a loff_t was the
same as the size of a long.  The regression prevents mapping
hugetlbfs files at offsets greater than 4GB on 32 bit kernels.

On 32 bit kernels conversion from a page based unsigned long can
not overflow a loff_t byte offset.  Therefore, skip this check
if sizeof(unsigned long) != sizeof(loff_t).

Fixes: 63489f8e8211 ("hugetlbfs: check for pgoff value overflow")
Cc: <stable@vger.kernel.org>
Reported-by: Dan Rue <dan.rue@linaro.org>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b9a254dcc0e7..d508c7844681 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -138,10 +138,14 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 	/*
 	 * page based offset in vm_pgoff could be sufficiently large to
-	 * overflow a (l)off_t when converted to byte offset.
+	 * overflow a loff_t when converted to byte offset.  This can
+	 * only happen on architectures where sizeof(loff_t) ==
+	 * sizeof(unsigned long).  So, only check in those instances.
 	 */
-	if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
-		return -EINVAL;
+	if (sizeof(unsigned long) == sizeof(loff_t)) {
+		if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
+			return -EINVAL;
+	}
 
 	/* must be huge page aligned */
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
-- 
2.13.6
