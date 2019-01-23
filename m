Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B7C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A039021726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfAWObr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:31:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfAWObr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:31:47 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E073367EF03EA0CFB764;
        Wed, 23 Jan 2019 22:31:43 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 22:31:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <laurent.pinchart@ideasonboard.com>,
        <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] usb: gadget: Remove dead branch code
Date:   Wed, 23 Jan 2019 22:31:36 +0800
Message-ID: <20190123143136.15704-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'num' is a u8 variable, it never greater than 255,
So the if branch is dead code and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/gadget/function/uvc_configfs.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index bc1e2af..8fe85cb 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -1570,10 +1570,6 @@ uvcg_uncompressed_##cname##_store(struct config_item *item,		\
 	if (ret)							\
 		goto end;						\
 									\
-	if (num > 255) {						\
-		ret = -EINVAL;						\
-		goto end;						\
-	}								\
 	u->desc.aname = num;						\
 	ret = len;							\
 end:									\
@@ -1767,10 +1763,6 @@ uvcg_mjpeg_##cname##_store(struct config_item *item,			\
 	if (ret)							\
 		goto end;						\
 									\
-	if (num > 255) {						\
-		ret = -EINVAL;						\
-		goto end;						\
-	}								\
 	u->desc.aname = num;						\
 	ret = len;							\
 end:									\
-- 
2.7.0


