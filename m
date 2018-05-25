Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755303AbeEYC4g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:56:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:22228 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754762AbeEYCzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:55:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,438,1520924400";
   d="scan'208";a="42054623"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH 6/7] dm-snap: remove unnecessary direct_access() stub
Date: Thu, 24 May 2018 20:55:17 -0600
Message-Id: <20180525025518.11405-7-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180525025518.11405-1-ross.zwisler@linux.intel.com>
References: <20180525025518.11405-1-ross.zwisler@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This stub was added so that we could use dm-snap with DM_TYPE_DAX_BIO_BASED
mode devices.  That mode and the transition issues associated with it no
longer exist, so we can remove this dead code.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 drivers/md/dm-snap.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 216035be5661..0143b158d52d 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2305,13 +2305,6 @@ static int origin_map(struct dm_target *ti, struct bio *bio)
 	return do_origin(o->dev, bio);
 }
 
-static long origin_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
-{
-	DMWARN("device does not support dax.");
-	return -EIO;
-}
-
 /*
  * Set the target "max_io_len" field to the minimum of all the snapshots'
  * chunk sizes.
@@ -2371,7 +2364,6 @@ static struct target_type origin_target = {
 	.postsuspend = origin_postsuspend,
 	.status  = origin_status,
 	.iterate_devices = origin_iterate_devices,
-	.direct_access = origin_dax_direct_access,
 };
 
 static struct target_type snapshot_target = {
-- 
2.14.3
