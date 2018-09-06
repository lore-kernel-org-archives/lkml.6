Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD38C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945AE2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945AE2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeIFNZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:25:44 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:37031 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeIFNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:25:43 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25b90ea82be1-04f06; Thu, 06 Sep 2018 16:51:14 +0800 (CST)
X-RM-TRANSID: 2ee25b90ea82be1-04f06
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5b90ea8180a-e3d6f;
        Thu, 06 Sep 2018 16:51:14 +0800 (CST)
X-RM-TRANSID: 2eea5b90ea8180a-e3d6f
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vme: remove unneeded kfree
Date:   Thu,  6 Sep 2018 16:51:10 +0800
Message-Id: <1536223870-6324-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_device will call vme_dev_release to free vdev, kfree is
unnecessary here.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/vme/vme.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vme/vme.c b/drivers/vme/vme.c
index 92500f6..520a5f9 100644
--- a/drivers/vme/vme.c
+++ b/drivers/vme/vme.c
@@ -1890,7 +1890,6 @@ static int __vme_register_driver_bus(struct vme_driver *drv,
 
 err_reg:
 	put_device(&vdev->dev);
-	kfree(vdev);
 err_devalloc:
 	list_for_each_entry_safe(vdev, tmp, &drv->devices, drv_list) {
 		list_del(&vdev->drv_list);
-- 
1.9.1



