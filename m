Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2619562-1527623536-2-15372814595049759127
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527623536; b=FgRVlQhtY2DdzNPZcEh/Pr7bCO8+4fCdy5e5aOYmp7Uul+F7Ix
    ZQqV0p7hqxX5Lpx4kKYWaBLnY1svUvUfgfGeUV/azR2Q55kWWJKxt1AO5qtK/m4g
    jDIyg51j5O5HdJProvoX6QZRhvW/4OSfF+QtKximnspNofnb7PhBxmtD8puQITmJ
    8Z29mwO2wfPy9TbMYc6SVsYWdE0tdSPaK3X0Wb73sK642VDnadPs1gjThLIoUn+N
    1946jd381trEY4g1K3HEdM5lziH4GIVXmC8fTkWi51xD0OJs8XGn/Vn+3Q61x92f
    DDB4hqRPvueyuLTahr3QdLEO77mGv+CjL2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527623536; bh=
    GEVHRWA+I7U/uPYPdhd3Qo9nyqtJEp60t3Enc3KKffg=; b=Cu1A+T0JCkPQ+Dny
    VnBR4nFeU8af5vMsRlOU0dZngvVhmWVinv/7+QF/XMuaK2/6CAzW13eBWJpUWLJq
    uNjE4IF3C1LMVacOgdOo8P5V04Y19PSPv4RuCMHBzMG8DPB/OhxzFTPOLi2lBsKq
    REDsTPeQEfll8q5i5sQvWl8O5X7uXA3iqb8XIZjKb4W6mu/lXTvw6N1qTHo/YGyB
    +RGQOt640Wo1NkeISLch9JbSnRGQKmceqaJRb+vCUnYLom2H27oMylVtLoNtbLZs
    KcQiXS6VAqdu5ty3w8+MQmtWja/BFV+A+5z8M+4b02ubO3a929y9o0ZNfqXaY5LZ
    47IYSg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHojtfLX4fO9lnpnizQG8WIjhLWFgH0R/qDRvBK6ReE4hwygbWVqV3IF0wWy8ZNbTrpRM3/psoKp/9KLbnXnk1BbteFUqyksUDrPjrk+gzgWz2EaG17B
    oRBJGJRaXog/t6AgaV348pCJ9vZgqwLffVcPmxJw4AqvkjO+J2Y3yhhN+SRR7KJ7oC7wwJ6BpH2A+PHxZ9Bb6Yaasvg59STPx7IRJgXXSHtZW7aaLDyy3Zch
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=hlXlmdzvIK86Jj8wux8A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966752AbeE2Tv6 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 15:51:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:7360 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966584AbeE2TvR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 15:51:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="232924742"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org
Subject: [PATCH v2 6/7] dm-snap: remove unnecessary direct_access() stub
Date: Tue, 29 May 2018 13:51:05 -0600
Message-Id: <20180529195106.14268-7-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
References: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
