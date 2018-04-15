Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeDOSWW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 14:22:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58710 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbeDOSWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 14:22:19 -0400
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 0/3] restructure memfd code
Date: Sun, 15 Apr 2018 11:21:16 -0700
Message-Id: <20180415182119.4517-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8864 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=685
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804150185
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a replacement for "Patch series restructure memfd code, v2"
which was previously in mmotm.  This previous series incorrectly moved
the memfd code out of shemm.c as a separate commit.  Please let me know
if there are any issues with the way code is restructured/moved in this
series.  Specifically, the last patch.

While redoing the series, all sparse warnings in mm/shmem.c are fixed
in patch 1.  Patch 2 updates comments, definitions, function names and
file checking such that patch 3 is code movement only.

v4 adds more cleanups in patch 2 before code movement.

Mike Kravetz (3):
  mm/shmem: add __rcu annotations and properly deref radix entry
  mm/shmem: update file sealing comments and file checking
  mm: restructure memfd code

 fs/Kconfig               |   3 +
 fs/fcntl.c               |   2 +-
 include/linux/memfd.h    |  16 +++
 include/linux/shmem_fs.h |  13 --
 mm/Makefile              |   1 +
 mm/memfd.c               | 345 +++++++++++++++++++++++++++++++++++++++++++++++
 mm/shmem.c               | 338 ++--------------------------------------------
 7 files changed, 377 insertions(+), 341 deletions(-)
 create mode 100644 include/linux/memfd.h
 create mode 100644 mm/memfd.c

-- 
2.13.6
