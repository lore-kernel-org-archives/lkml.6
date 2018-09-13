Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99715C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C1020861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C1020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeIMS2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:28:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbeIMS2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:28:20 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 58137FE5FBD20;
        Thu, 13 Sep 2018 21:18:48 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Thu, 13 Sep 2018
 21:18:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jmorris@namei.org>, <serge@hallyn.com>, <casey@schaufler-ca.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] Smack: remove set but not used variable 'root_inode'
Date:   Thu, 13 Sep 2018 21:18:11 +0800
Message-ID: <20180913131811.25432-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

security/smack/smackfs.c: In function 'smk_fill_super':
security/smack/smackfs.c:2856:16: warning:
 variable 'root_inode' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/smack/smackfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index f4e91c5..8972da4 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2855,7 +2855,6 @@ static int smk_fill_super(struct super_block *sb, void *data, size_t data_size,
 			  int silent)
 {
 	int rc;
-	struct inode *root_inode;
 
 	static const struct tree_descr smack_files[] = {
 		[SMK_LOAD] = {
@@ -2919,8 +2918,6 @@ static int smk_fill_super(struct super_block *sb, void *data, size_t data_size,
 		return rc;
 	}
 
-	root_inode = d_inode(sb->s_root);
-
 	return 0;
 }
 
-- 
2.7.0


