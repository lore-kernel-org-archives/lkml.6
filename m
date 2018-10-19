Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE9BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9842D2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9842D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeJSWcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:32:47 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59834 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727547AbeJSWcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:32:47 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from lsun@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Oct 2018 16:31:26 +0200
Received: from bu-lab53.mtbu.labs.mlnx (bu-lab53.mtbu.labs.mlnx [10.15.8.107])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w9JEQOc5018953;
        Fri, 19 Oct 2018 17:26:24 +0300
Received: from bu-lab53.mtbu.labs.mlnx (localhost [127.0.0.1])
        by bu-lab53.mtbu.labs.mlnx (8.14.7/8.14.7) with ESMTP id w9JEQNxb059404;
        Fri, 19 Oct 2018 10:26:23 -0400
Received: (from lsun@localhost)
        by bu-lab53.mtbu.labs.mlnx (8.14.7/8.14.7/Submit) id w9JEQLeY059403;
        Fri, 19 Oct 2018 10:26:21 -0400
From:   Liming Sun <lsun@mellanox.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        David Woods <dwoods@mellanox.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] mmc: dw_mmc-bluefield: simplify the probe() function
Date:   Fri, 19 Oct 2018 10:26:14 -0400
Message-Id: <d9e592c4b8082f77fc219764a26f50dec434d8fc.1539890997.git.lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes the unnecessary of-node check since the
dw_mci_bluefield_match[] structure has only one entry.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/host/dw_mmc-bluefield.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
index 54c3fbb..ed8f225 100644
--- a/drivers/mmc/host/dw_mmc-bluefield.c
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -52,16 +52,7 @@ static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 
 static int dw_mci_bluefield_probe(struct platform_device *pdev)
 {
-	const struct dw_mci_drv_data *drv_data = NULL;
-	const struct of_device_id *match;
-
-	if (pdev->dev.of_node) {
-		match = of_match_node(dw_mci_bluefield_match,
-				      pdev->dev.of_node);
-		drv_data = match->data;
-	}
-
-	return dw_mci_pltfm_register(pdev, drv_data);
+	return dw_mci_pltfm_register(pdev, &bluefield_drv_data);
 }
 
 static struct platform_driver dw_mci_bluefield_pltfm_driver = {
-- 
1.8.3.1

