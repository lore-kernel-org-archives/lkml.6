Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B468BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC5921477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="obCZnYEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC5921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJDKGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeJDKGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:06:52 -0400
Received: from localhost.localdomain (unknown [58.212.179.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0212098A;
        Thu,  4 Oct 2018 03:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538622943;
        bh=44eLEbIDtbDssyjHlhs3vZAiWMSqo3qPyT3hfV83gaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obCZnYEzsCUxjUBOSgb595opXQ/y1DbboLMgG9Ogsc0IZ8Hanj99sZGGET1BoFPxr
         zEJGI5s8E7A3PBE+G+EURJMJE+rrdbkO1XgeyYryBstgilKku9TgHK/BmmTvQUeM/B
         M6Kxnn+ycDLzglMONtWW2TOJIZXLb0N0SvFkVRWM=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: remove unused sbi->trigger_ssr_threshold
Date:   Thu,  4 Oct 2018 11:15:19 +0800
Message-Id: <20181004031520.4096-2-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004031520.4096-1-chao@kernel.org>
References: <20181004031520.4096-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Commit a2a12b679f36 ("f2fs: export SSR allocation threshold") introduced
two threshold .min_ssr_sections and .trigger_ssr_threshold, but only
.min_ssr_sections is used, so just remove redundant one for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c4d30c090399..2297492fc56d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1218,7 +1218,6 @@ struct f2fs_sb_info {
 	unsigned int total_valid_node_count;	/* valid node block count */
 	loff_t max_file_blocks;			/* max block index of file */
 	int dir_level;				/* directory level */
-	unsigned int trigger_ssr_threshold;	/* threshold to trigger ssr */
 	int readdir_ra;				/* readahead inode in readdir */
 
 	block_t user_block_count;		/* # of user blocks */
-- 
2.18.0

