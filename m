Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADDAC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57FE213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57FE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeJIE3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:29:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39946 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeJIE3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:29:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g9css-0008L2-2A; Mon, 08 Oct 2018 21:16:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][md-next] md: remove redundant code that is no longer reachable
Date:   Mon,  8 Oct 2018 22:16:09 +0100
Message-Id: <20181008211609.9650-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

And earlier commit removed the error label to two statements that
are now never reachable.  Since this code is now dead code, remove it.

Detected by CoverityScan, CID#1462409 ("Structurally dead code")

Fixes: d5d885fd514f ("md: introduce new personality funciton start()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/md/raid5-cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index e6e925add700..ec3a5ef7fee0 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -3151,8 +3151,6 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 	set_bit(MD_HAS_JOURNAL, &conf->mddev->flags);
 	return 0;
 
-	rcu_assign_pointer(conf->log, NULL);
-	md_unregister_thread(&log->reclaim_thread);
 reclaim_thread:
 	mempool_exit(&log->meta_pool);
 out_mempool:
-- 
2.17.1

