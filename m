Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D94CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3EF21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390939AbeLUXSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:18:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58434 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUXSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:18:15 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gaU3Y-0002iY-Rr; Fri, 21 Dec 2018 23:18:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bcache: fix indentation issue, remove tabs on a hunk of code
Date:   Fri, 21 Dec 2018 23:18:12 +0000
Message-Id: <20181221231812.16086-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a hunk of code that is indented one level too deep, fix this
by removing the extra tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/md/bcache/super.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 4dee119c3664..a697a3a923cd 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1615,21 +1615,21 @@ static void conditional_stop_bcache_device(struct cache_set *c,
 		 */
 		pr_warn("stop_when_cache_set_failed of %s is \"auto\" and cache is dirty, stop it to avoid potential data corruption.",
 			d->disk->disk_name);
-			/*
-			 * There might be a small time gap that cache set is
-			 * released but bcache device is not. Inside this time
-			 * gap, regular I/O requests will directly go into
-			 * backing device as no cache set attached to. This
-			 * behavior may also introduce potential inconsistence
-			 * data in writeback mode while cache is dirty.
-			 * Therefore before calling bcache_device_stop() due
-			 * to a broken cache device, dc->io_disable should be
-			 * explicitly set to true.
-			 */
-			dc->io_disable = true;
-			/* make others know io_disable is true earlier */
-			smp_mb();
-			bcache_device_stop(d);
+		/*
+		 * There might be a small time gap that cache set is
+		 * released but bcache device is not. Inside this time
+		 * gap, regular I/O requests will directly go into
+		 * backing device as no cache set attached to. This
+		 * behavior may also introduce potential inconsistence
+		 * data in writeback mode while cache is dirty.
+		 * Therefore before calling bcache_device_stop() due
+		 * to a broken cache device, dc->io_disable should be
+		 * explicitly set to true.
+		 */
+		dc->io_disable = true;
+		/* make others know io_disable is true earlier */
+		smp_mb();
+		bcache_device_stop(d);
 	} else {
 		/*
 		 * dc->stop_when_cache_set_failed == BCH_CACHED_STOP_AUTO
-- 
2.19.1

