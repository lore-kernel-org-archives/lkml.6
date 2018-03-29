Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeC2ERQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 00:17:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51634 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeC2ERP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 00:17:15 -0400
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>, Dan Rue <dan.rue@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/1] fix regression in hugetlbfs overflow checking
Date: Wed, 28 Mar 2018 21:16:55 -0700
Message-Id: <20180329041656.19691-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=904
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803290046
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 63489f8e8211 ("hugetlbfs: check for pgoff value overflow")
introduced a regression in 32 bit kernels.  When creating the mask
to check vm_pgoff, it incorrectly specified that the size of a loff_t
was the size of a long.  This prevents mapping hugetlbfs files at
offsets greater than 4GB on 32 bit kernels.

The above is in the commit message.  63489f8e8211 has been sent upstream
and to stable, so cc'ing stable here as well.

I would appreciate some more eyes on this code.  There have been several
fixes and we keep running into issues.

Mike Kravetz (1):
  hugetlbfs: fix bug in pgoff overflow checking

 fs/hugetlbfs/inode.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.13.6
