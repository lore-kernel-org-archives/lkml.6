Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FABC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1182086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1182086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeKHV4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:56:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14637 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbeKHV4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:56:21 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 797D26EBACD68;
        Thu,  8 Nov 2018 20:21:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 8 Nov 2018 20:20:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Yue Haibing <yuehaibing@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ufs: remove set but not used variable 'usb3'
Date:   Thu, 8 Nov 2018 12:30:35 +0000
Message-ID: <1541680235-158692-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1534815222-101634-1-git-send-email-yuehaibing@huawei.com>
References: <1534815222-101634-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

fs/ufs/super.c: In function 'ufs_statfs':
fs/ufs/super.c:1409:32: warning:
 variable 'usb3' set but not used [-Wunused-but-set-variable]

It not used any more after commit
c596961d1b4c ("ufs: fix s_size/s_dsize users")

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 fs/ufs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index a4e07e9..6a5db06 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1406,11 +1406,9 @@ static int ufs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct super_block *sb = dentry->d_sb;
 	struct ufs_sb_private_info *uspi= UFS_SB(sb)->s_uspi;
 	unsigned  flags = UFS_SB(sb)->s_flags;
-	struct ufs_super_block_third *usb3;
 	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
 
 	mutex_lock(&UFS_SB(sb)->s_lock);
-	usb3 = ubh_get_usb_third(uspi);
 	
 	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
 		buf->f_type = UFS2_MAGIC;



