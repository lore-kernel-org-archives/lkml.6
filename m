Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755110AbeEYCzz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:55:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:22225 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754765AbeEYCzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:55:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,438,1520924400";
   d="scan'208";a="42054624"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH 7/7] dm-error: remove unnecessary direct_access() stub
Date: Thu, 24 May 2018 20:55:18 -0600
Message-Id: <20180525025518.11405-8-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180525025518.11405-1-ross.zwisler@linux.intel.com>
References: <20180525025518.11405-1-ross.zwisler@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This stub was added so that we could use dm-error with
DM_TYPE_DAX_BIO_BASED mode devices.  That mode and the transition issues
associated with it no longer exist, so we can remove this dead code.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 drivers/md/dm-target.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 314d17ca6466..c4dbc15f7862 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -140,12 +140,6 @@ static void io_err_release_clone_rq(struct request *clone)
 {
 }
 
-static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
-{
-	return -EIO;
-}
-
 static struct target_type error_target = {
 	.name = "error",
 	.version = {1, 5, 0},
@@ -155,7 +149,6 @@ static struct target_type error_target = {
 	.map  = io_err_map,
 	.clone_and_map_rq = io_err_clone_and_map_rq,
 	.release_clone_rq = io_err_release_clone_rq,
-	.direct_access = io_err_dax_direct_access,
 };
 
 int __init dm_target_init(void)
-- 
2.14.3
