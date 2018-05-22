Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeEVNck (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:32:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42587 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEVNch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:32:37 -0400
X-Google-Smtp-Source: AB8JxZomFn748sSrRNTMzsyn4Hj2/3oyXoFNxvM5i/croH+xAZSp60pZNZOo6+Ib1TyKX4nyQKlYdQ==
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: lustre-devel@lists.lustre.org
Cc: oleg.drokin@intel.com, andreas.dilger@intel.com,
        jsimmons@infradead.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Bornyakov <brnkv.i1@gmail.com>
Subject: [PATCH] staging: lustre: libcfs: add parens around macros args
Date: Tue, 22 May 2018 16:34:39 +0300
Message-Id: <20180522133439.12338-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One may call 'CFS_FAIL_TIMEOUT(id, secs + 5);' and get unexpected result
after macro substitution, viz., 'secs + 5' will turn into
'secs + 5 * 1000'

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 drivers/staging/lustre/include/linux/libcfs/libcfs_fail.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_fail.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_fail.h
index d6fc3164e7e7..f96b9a51554d 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_fail.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_fail.h
@@ -140,7 +140,7 @@ static inline int cfs_fail_timeout_set(u32 id, u32 value, int ms, int set)
 
 /* If id hit cfs_fail_loc, sleep for seconds or milliseconds */
 #define CFS_FAIL_TIMEOUT(id, secs) \
-	cfs_fail_timeout_set(id, 0, secs * 1000, CFS_FAIL_LOC_NOSET)
+	cfs_fail_timeout_set(id, 0, (secs) * 1000, CFS_FAIL_LOC_NOSET)
 
 #define CFS_FAIL_TIMEOUT_MS(id, ms) \
 	cfs_fail_timeout_set(id, 0, ms, CFS_FAIL_LOC_NOSET)
@@ -150,10 +150,10 @@ static inline int cfs_fail_timeout_set(u32 id, u32 value, int ms, int set)
  * sleep seconds or milliseconds
  */
 #define CFS_FAIL_TIMEOUT_ORSET(id, value, secs) \
-	cfs_fail_timeout_set(id, value, secs * 1000, CFS_FAIL_LOC_ORSET)
+	cfs_fail_timeout_set(id, value, (secs) * 1000, CFS_FAIL_LOC_ORSET)
 
 #define CFS_FAIL_TIMEOUT_RESET(id, value, secs) \
-	cfs_fail_timeout_set(id, value, secs * 1000, CFS_FAIL_LOC_RESET)
+	cfs_fail_timeout_set(id, value, (secs) * 1000, CFS_FAIL_LOC_RESET)
 
 #define CFS_FAIL_TIMEOUT_MS_ORSET(id, value, ms) \
 	cfs_fail_timeout_set(id, value, ms, CFS_FAIL_LOC_ORSET)
-- 
2.16.1
