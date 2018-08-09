Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC073C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840472238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDNCO6DA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840472238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeHIUcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:32:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46215 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeHIUcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:32:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so3192953pfn.13;
        Thu, 09 Aug 2018 11:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nIuHCF9683iMYU2rHMsdILJuGo9/J5CkhRVd0dD+FUY=;
        b=RDNCO6DAKkOyJV0udkYO90nl7ou3VLUqZt5cpOaugzrYSVVLB1ZKWOIi31/PRWbDJl
         ygqgo4QMZYokvyCMHgDAM3q5OTB8Lz0bn0Q2pWgUKe1X+c3Xqs8/bmFlHBFpoMngHnHu
         4yVyGaoaducePqhIRQrz5vofy9whcy9SPuF6wmGRF3AkyzG1mEKI5bR7JwqCAqkibWRP
         5+sMssFpNsAmsO+tRP71oBm4LAZz7Py6kIdz18n/Y6vyUT4g3eKkVLt0+tJmeLCkRB5g
         xnz28N8WVyC0iP9JQqXhLOcUmZaStL6aNwiGC2zaRPaumUK9W1dH4RD+RLeDcoo9aUUq
         NgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=nIuHCF9683iMYU2rHMsdILJuGo9/J5CkhRVd0dD+FUY=;
        b=KWQ6FiBeA1Hrz4qbKMWQFqSjgx2FyYN04jPPxy13WTBhielf179z+Kfnh/hNOH4Vzc
         h3I6FE12yLoINFX2BIbcr861H9d18/pBLXy/EwZCPsMVQR0uCC1TC6aVh9tZ12v/L36n
         Y4ORH+qdyLgAm9spAu3VEVQwl6k1iQ9KCMdoyXPSTLXyljP9f8mBIL7CBPlC1/rNINUV
         BbsNlsC7CY8LDi97HKSnEgkNsHfGfT+pSj8yIEriS86gDd35i1oM/m2Gniect7aw82tW
         u30hAs45zR0ekb+L6sOWtPh5om59LZejwJEAoR2GxPymFs8D1cGWEXJaSg3QWer35GhG
         agiQ==
X-Gm-Message-State: AOUpUlHL7/564ZGlgDdBTn4Z08cyFOJv+sT4IxfgRk0rr2Rup+g6dsEK
        CTksNkzqLBO0to+amAJ0kVQ=
X-Google-Smtp-Source: AA+uWPxKsnV0AB7zVwcs3VzSoF1sItrzmf9cXWc96Vf4LkUQxBeXVMlPOkJy7sN0s+WtDMjxdAnNsw==
X-Received: by 2002:a63:2dc1:: with SMTP id t184-v6mr3153420pgt.62.1533837985008;
        Thu, 09 Aug 2018 11:06:25 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id l85-v6sm12880248pfk.34.2018.08.09.11.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:06:24 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 15/17] btrfs: reset zones of unused block groups
Date:   Fri, 10 Aug 2018 03:04:48 +0900
Message-Id: <20180809180450.5091-16-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For an HMZONED volume, a block group maps to a zone of the device. For
deleted unused block groups, the zone of the block group can be reset to
rewind the zone write pointer at the start of the zone.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/extent-tree.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a5f5935315c8..26989f6fe591 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2025,6 +2025,25 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
+
+			if (clear == BTRFS_CLEAR_OP_DISCARD &&
+			    btrfs_dev_is_sequential(stripe->dev,
+						    stripe->physical) &&
+			    stripe->length == stripe->dev->zone_size) {
+				ret = blkdev_reset_zones(stripe->dev->bdev,
+							 stripe->physical >> 9,
+							 stripe->length >> 9,
+							 GFP_NOFS);
+				if (ret)
+					discarded_bytes += stripe->length;
+				else
+					break;
+				set_bit(stripe->physical >>
+						stripe->dev->zone_size_shift,
+					stripe->dev->empty_zones);
+				continue;
+			}
+
 			req_q = bdev_get_queue(stripe->dev->bdev);
 			if (clear == BTRFS_CLEAR_OP_DISCARD &&
 			    !blk_queue_discard(req_q))
@@ -10958,7 +10977,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&space_info->lock);
 
 		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD);
+		trimming = btrfs_test_opt(fs_info, DISCARD) ||
+				btrfs_fs_incompat(fs_info, HMZONED);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
-- 
2.18.0

