Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2618787-1527623536-2-12292311551804681446
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527623535; b=e9l0BBrm1ibdRh08GhVuDPuUGqC28lTA+uEo3u+JTzlcF/ABRd
    SMjZEWAQMutSUGk57DIAcWJj9gpk1BI7Jew7Tjhx3TflzG7vWtvvwbnB9CdbVa9s
    8SEnjUA1Iini34mxODUXaDx8tZx4tm2RwVsK7UDD0nBN4uGlXlzInxfOouvbNv31
    +NtzdB9lyiKZv9PiBEUzMIyyZuZasxhXrgRdFNVb9NNdb8d5amV7xkVBDwErcZH+
    MykYqlNbwr9fLkdVsA+gCxroYwuUzhpvtC7K/12jsARUzaIWf6C9Cof9sXhXwVWU
    umVuf0pOynXf0JEy0SQCxOpCY3GFwnuj1lKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527623535; bh=
    IWu1lzEgpo5loHW4YSCxCR5mjG3eyIay5aPzdTc9V+g=; b=hM2dS4/Ye83OO3gN
    jBCFPAFoMi3bIYELC7v8HPSq94cgr4l+n8qLsY8YapRJ+HnwbrlFbCZe8e/bZWTV
    Ev50wUfeDjslA8lSOu7pY/WEiKF0e3g6y6OrvMhyx/53S9gUU8nIfOa1HrEiyXV3
    TCJic4X53n833VKhD9D5cPODMtcQ9PWwZF0lHX08Bw3M71hGVUEglogfH6hLSULB
    GDs4/AleNfhftiFTq0y52Ah1cSFR525NbeB2HIdXrvk7Mj/3E+2LWoJZdlr/15+M
    IKEBRggaM3DX0h3uVXJdxqVHKIoUE2UKRSu4gfVFQCFgkfW+d0sx9oLD3vlheU0M
    e2rXPA==
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
X-CM-Envelope: MS4wfL1KplK/dPlkF6JptY/pHTVMhRhipWJYxeWCdsHQHKK2NWBlM0E4wSS0n+R2dZwRLn9elpMI0J7P7ZF/Z4BiyLQZxvXxGi8l1NbDO4/+BYA5yaRTuC4M
    rhgwLS4ZyhrgAuUMxwbcIV2KArnWkH6TaESqRPRz4hoiphLiyTXeeViTJE/NUcYzeQD/QmQj+otXMDoEnYBEAkYyz//cPypTxt5v70i8B5k1YP014qpJbomQ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=NrGJ7ScZm8x91R0ERz0A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966693AbeE2Tvz (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 15:51:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:7359 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966529AbeE2TvR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 15:51:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="232924743"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org
Subject: [PATCH v2 7/7] dm-error: remove unnecessary direct_access() stub
Date: Tue, 29 May 2018 13:51:06 -0600
Message-Id: <20180529195106.14268-8-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
References: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
