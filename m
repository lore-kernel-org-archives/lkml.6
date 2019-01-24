Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D5C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657EB217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360848;
	bh=p3K4NDYfQsaHH/FNY+wlzafbCdSA7H9FE0L2gWPkGaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZqdyPphXxGHUcbw3tv0GnSHfEyuRTK+7uqFMSFRuKAVCZm6OSb+OQ9+9X8x0SiSAl
	 6mf7y/MPtZuiUh7Wy2a9vaUriAF89xeIeTvvwTlxmds1YFAcgw2P8rvkOxNR8bnq7+
	 31bCj/xQuUWz45euoMlcTIOakeGnl2LUTrOCAi6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfAXTZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730304AbfAXTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B4C218FD;
        Thu, 24 Jan 2019 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357907;
        bh=p3K4NDYfQsaHH/FNY+wlzafbCdSA7H9FE0L2gWPkGaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdaBummUU4yyENK+PVOAwIxfvzDFYLSmX8nuQC4MIp7Fl76Ekr3eJDwLGKBsf/zSn
         VL2zxLVIsWyZnKkuuZONzaUaOjogglBVOpTQr4YSKNManMN23uLCalplanauRerAO0
         FYd6JwZZCESQzVq9Jlfd0N0rofhkN4kZQGIsswME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <chao2.yu@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 003/104] f2fs: clean up argument of recover_data
Date:   Thu, 24 Jan 2019 20:18:52 +0100
Message-Id: <20190124190155.247485481@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao2.yu@samsung.com>

commit b7973f2378c619d0e17a075f13350bd58a9ebe3d upstream.

In recover_data, value of argument 'type' will be CURSEG_WARM_NODE all
the time, remove it for cleanup.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Picked as dependency of commit 6781eabba1bd "f2fs: give -EINVAL for
 norecovery and rw mount"]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/recovery.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -459,8 +459,7 @@ out:
 	return err;
 }
 
-static int recover_data(struct f2fs_sb_info *sbi,
-				struct list_head *head, int type)
+static int recover_data(struct f2fs_sb_info *sbi, struct list_head *head)
 {
 	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
@@ -469,7 +468,7 @@ static int recover_data(struct f2fs_sb_i
 	block_t blkaddr;
 
 	/* get node pages in the current segment */
-	curseg = CURSEG_I(sbi, type);
+	curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
 	blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
 	while (1) {
@@ -556,7 +555,7 @@ int recover_fsync_data(struct f2fs_sb_in
 	need_writecp = true;
 
 	/* step #2: recover data */
-	err = recover_data(sbi, &inode_list, CURSEG_WARM_NODE);
+	err = recover_data(sbi, &inode_list);
 	if (!err)
 		f2fs_bug_on(sbi, !list_empty(&inode_list));
 out:


