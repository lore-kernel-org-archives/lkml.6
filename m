Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B5CC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5145208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gupJycpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5145208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754272AbeGHOR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 10:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752750AbeGHORZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 10:17:25 -0400
Received: from localhost.localdomain (unknown [49.77.239.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 239C5208CC;
        Sun,  8 Jul 2018 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531059445;
        bh=HREfa+M5zlriFx9vVca5i0PmK2v/2lb4GUQUZ9c1RNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gupJycpHA2MsNXVYdvnS2yKuoh1uCwA1O0e2Oifu2sLTE782AIxd/8z4PLZQt3MIZ
         0ELHT58eefn3xWlueetKTF4PuCWg2SCTdXJ+ukoPDs3zEOK41bt04syf9o2tf/CzHd
         ifIO8zPrRjok+VWgHo+IN3EBjjyFXxBm+qr06Xbc=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/5] f2fs: clean up with IS_INODE()
Date:   Sun,  8 Jul 2018 22:16:54 +0800
Message-Id: <20180708141657.24641-2-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
In-Reply-To: <20180708141657.24641-1-chao@kernel.org>
References: <20180708141657.24641-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8211f5c288a1..b0ab39d83235 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -122,7 +122,7 @@ static bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct page *page
 	if (!f2fs_sb_has_inode_chksum(sbi->sb))
 		return false;
 
-	if (!RAW_IS_INODE(F2FS_NODE(page)) || !(ri->i_inline & F2FS_EXTRA_ATTR))
+	if (!IS_INODE(page) || !(ri->i_inline & F2FS_EXTRA_ATTR))
 		return false;
 
 	if (!F2FS_FITS_IN_INODE(ri, le16_to_cpu(ri->i_extra_isize),
-- 
2.16.2.17.g38e79b1fd

