Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B4FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6672083C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6672083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeH1SLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:11:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52771 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH1SLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:11:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fuepn-0001rl-GV; Tue, 28 Aug 2018 14:19:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: remove unused pointer 'eb'
Date:   Tue, 28 Aug 2018 15:19:07 +0100
Message-Id: <20180828141907.10826-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'eb' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'eb' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ocfs2/alloc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index a342f008e42f..d1cbb27808e2 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -5106,8 +5106,6 @@ int ocfs2_split_extent(handle_t *handle,
 	 * rightmost extent list.
 	 */
 	if (path->p_tree_depth) {
-		struct ocfs2_extent_block *eb;
-
 		ret = ocfs2_read_extent_block(et->et_ci,
 					      ocfs2_et_get_last_eb_blk(et),
 					      &last_eb_bh);
@@ -5115,8 +5113,6 @@ int ocfs2_split_extent(handle_t *handle,
 			mlog_errno(ret);
 			goto out;
 		}
-
-		eb = (struct ocfs2_extent_block *) last_eb_bh->b_data;
 	}
 
 	if (rec->e_cpos == split_rec->e_cpos &&
-- 
2.17.1

