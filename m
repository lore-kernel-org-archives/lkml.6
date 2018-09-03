Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1688C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A102077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A102077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeICM7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:59:39 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:37527 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeICM7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:59:39 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55b8cf37b71f-b2368; Mon, 03 Sep 2018 16:40:27 +0800 (CST)
X-RM-TRANSID: 2ee55b8cf37b71f-b2368
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55b8cf37a901-0ac36;
        Mon, 03 Sep 2018 16:40:27 +0800 (CST)
X-RM-TRANSID: 2ee55b8cf37a901-0ac36
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: drm: Fix vexpress_muxfpga_match terminate error
Date:   Mon,  3 Sep 2018 16:40:24 +0800
Message-Id: <1535964024-23841-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vexpress_muxfpga_match needs NULL terminate, fix it.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/gpu/drm/pl111/pl111_vexpress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_vexpress.c b/drivers/gpu/drm/pl111/pl111_vexpress.c
index a534b22..5fa0441 100644
--- a/drivers/gpu/drm/pl111/pl111_vexpress.c
+++ b/drivers/gpu/drm/pl111/pl111_vexpress.c
@@ -111,7 +111,8 @@ static int vexpress_muxfpga_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id vexpress_muxfpga_match[] = {
-	{ .compatible = "arm,vexpress-muxfpga", }
+	{ .compatible = "arm,vexpress-muxfpga", },
+	{}
 };
 
 static struct platform_driver vexpress_muxfpga_driver = {
-- 
1.9.1



