Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756CDECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B99221471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B99221471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeIRNJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:09:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727404AbeIRNJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:09:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8B7C556D9BB;
        Tue, 18 Sep 2018 15:37:42 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Tue, 18 Sep 2018 15:37:39 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <airlied@linux.ie>, <maxime.ripard@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: sun4i: Fix a uninitialized variable warning.
Date:   Tue, 18 Sep 2018 15:25:20 +0800
Message-ID: <1537255520-41614-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

drivers/gpu/drm/sun4i/sun4i_tcon.c:1088: warning: 'has_lvds_alt' may be used uninitialized in this function [-Wmaybe-uninitialized]
bool has_lvds_rst, has_lvds_alt, can_lvds;

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c78cd35..563cc8f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1086,7 +1086,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	struct device_node *remote;
 	struct sun4i_tcon *tcon;
 	struct reset_control *edp_rstc;
-	bool has_lvds_rst, has_lvds_alt, can_lvds;
+	bool has_lvds_rst, has_lvds_alt = false, can_lvds;
 	int ret;
 
 	engine = sun4i_tcon_find_engine(drv, dev->of_node);
-- 
1.7.12.4

