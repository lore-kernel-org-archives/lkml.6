Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941DCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486262087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486262087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeH1Og2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:36:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49229 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeH1Og2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:36:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fubUw-0005or-BG; Tue, 28 Aug 2018 10:45:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: remove unused pointer inode
Date:   Tue, 28 Aug 2018 11:45:21 +0100
Message-Id: <20180828104521.5167-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer inode is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
variable ‘inode’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/btrfs/inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c32ca4ca3540..b6921ed5c07b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2750,12 +2750,9 @@ static void relink_file_extents(struct new_sa_defrag_extent *new)
 	struct btrfs_path *path;
 	struct sa_defrag_extent_backref *backref;
 	struct sa_defrag_extent_backref *prev = NULL;
-	struct inode *inode;
 	struct rb_node *node;
 	int ret;
 
-	inode = new->inode;
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return;
-- 
2.17.1

