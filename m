Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628F9C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D382064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D382064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeIJID3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:03:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbeIJID3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:03:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 38B9683396A47;
        Mon, 10 Sep 2018 11:11:36 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Mon, 10 Sep 2018
 11:11:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ath9k-devel@qca.qualcomm.com>, <kvalo@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ath9k: debug: remove set but not used variable 'fops_dump_nfcal'
Date:   Mon, 10 Sep 2018 11:11:28 +0800
Message-ID: <20180910031128.12164-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'fops_dump_nfcal' is not used since commit 4447d815fd0f ("ath: ath9k: use debugfs_create_devm_seqfile() helper for seq_file entries")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/ath/ath9k/debug.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index 0a6eb8a..c871b7e 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -990,19 +990,6 @@ static int read_file_dump_nfcal(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int open_file_dump_nfcal(struct inode *inode, struct file *f)
-{
-	return single_open(f, read_file_dump_nfcal, inode->i_private);
-}
-
-static const struct file_operations fops_dump_nfcal = {
-	.read = seq_read,
-	.open = open_file_dump_nfcal,
-	.owner = THIS_MODULE,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 #ifdef CONFIG_ATH9K_BTCOEX_SUPPORT
 static ssize_t read_file_btcoex(struct file *file, char __user *user_buf,
 				size_t count, loff_t *ppos)
-- 
2.7.0


