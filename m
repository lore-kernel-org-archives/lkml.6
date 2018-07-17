Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DAFECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919612086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919612086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeGQPcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:32:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51437 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbeGQPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:32:33 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ffRRp-0005lX-7u; Tue, 17 Jul 2018 14:59:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: remove redundant variable 'moved'
Date:   Tue, 17 Jul 2018 15:59:28 +0100
Message-Id: <20180717145928.29494-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable 'moved' s being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'moved' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/gfs2/dir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index d97ad89955d1..e37002560c11 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -1011,7 +1011,7 @@ static int dir_split_leaf(struct inode *inode, const struct qstr *name)
 	u64 bn, leaf_no;
 	__be64 *lp;
 	u32 index;
-	int x, moved = 0;
+	int x;
 	int error;
 
 	index = name->hash >> (32 - dip->i_depth);
@@ -1113,8 +1113,6 @@ static int dir_split_leaf(struct inode *inode, const struct qstr *name)
 
 			if (!prev)
 				prev = dent;
-
-			moved = 1;
 		} else {
 			prev = dent;
 		}
-- 
2.17.1

