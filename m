Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8F0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF362083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF362083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeHaMlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:41:46 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:48968 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeHaMlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:41:45 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65b88fdc401f-7c349; Fri, 31 Aug 2018 16:35:18 +0800 (CST)
X-RM-TRANSID: 2ee65b88fdc401f-7c349
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5b88fdc5729-5ac8b;
        Fri, 31 Aug 2018 16:35:18 +0800 (CST)
X-RM-TRANSID: 2eea5b88fdc5729-5ac8b
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     mark@fasheh.com, jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: Fix unneeded null check
Date:   Fri, 31 Aug 2018 16:35:14 +0800
Message-Id: <1535704514-26559-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

null check for kfree is unnecessary, so remove it.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>w
---
 fs/ocfs2/aops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 302cd7c..da578ad 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -1392,8 +1392,7 @@ static int ocfs2_unwritten_check(struct inode *inode,
 unlock:
 	spin_unlock(&oi->ip_lock);
 out:
-	if (new)
-		kfree(new);
+	kfree(new);
 	return ret;
 }
 
-- 
1.9.1



