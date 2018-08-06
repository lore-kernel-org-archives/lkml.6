Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D54C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F9321A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F9321A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbeHFNm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:42:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:33660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbeHFNm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:42:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4F95AE70;
        Mon,  6 Aug 2018 11:34:18 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen/blkfront: remove unused macros
Date:   Mon,  6 Aug 2018 13:34:00 +0200
Message-Id: <20180806113403.24728-3-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180806113403.24728-1-jgross@suse.com>
References: <20180806113403.24728-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some macros not used anywhere.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index b5cedccb5d7d..94300dbe358b 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -251,14 +251,9 @@ static DEFINE_SPINLOCK(minor_lock);
 #define GRANTS_PER_INDIRECT_FRAME \
 	(XEN_PAGE_SIZE / sizeof(struct blkif_request_segment))
 
-#define PSEGS_PER_INDIRECT_FRAME	\
-	(GRANTS_INDIRECT_FRAME / GRANTS_PSEGS)
-
 #define INDIRECT_GREFS(_grants)		\
 	DIV_ROUND_UP(_grants, GRANTS_PER_INDIRECT_FRAME)
 
-#define GREFS(_psegs)	((_psegs) * GRANTS_PER_PSEG)
-
 static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo);
 static void blkfront_gather_backend_features(struct blkfront_info *info);
 static int negotiate_mq(struct blkfront_info *info);
-- 
2.13.7

