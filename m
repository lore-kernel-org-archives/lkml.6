Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E27C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057D6217CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057D6217CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeHDNBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 09:01:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10631 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbeHDNBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 09:01:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A5437DDF507F2;
        Sat,  4 Aug 2018 19:01:08 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Sat, 4 Aug 2018 19:01:05 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <airlied@linux.ie>, <eric@anholt.net>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] gpu:p1111: Make sure of_device_id tables are NULL terminated
Date:   Sat, 4 Aug 2018 18:49:27 +0800
Message-ID: <1533379767-15629-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We prefer to of_device_id tables are NULL terminated. So make
vexpress_muxfpga_match is NULL terminated.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
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
1.7.12.4

