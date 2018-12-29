Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7092C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 08:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86275218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 08:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeL2IyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 03:54:08 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:53959 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeL2IyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 03:54:08 -0500
Received: from localhost.localdomain ([90.126.241.217])
        by mwinf5d85 with ME
        id Hku01z0024i89ZE03ku0uR; Sat, 29 Dec 2018 09:54:06 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 29 Dec 2018 09:54:06 +0100
X-ME-IP: 90.126.241.217
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bbrezillon@kernel.org, pgaj@cadence.com, yuehaibing@huawei.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] i3c: master: Fix an error checking typo in 'cdns_i3c_master_probe()'
Date:   Sat, 29 Dec 2018 01:05:40 +0100
Message-Id: <20181229000540.25283-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a cut'n'paste typo.
Checking 'master->sysclk' is expected here.

Fixes: 603f2bee2c54 ("i3c: master: Add driver for Cadence IP")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/i3c/master/i3c-master-cdns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index bbd79b8b1a80..8889a4fdb454 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1556,8 +1556,8 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 		return PTR_ERR(master->pclk);
 
 	master->sysclk = devm_clk_get(&pdev->dev, "sysclk");
-	if (IS_ERR(master->pclk))
-		return PTR_ERR(master->pclk);
+	if (IS_ERR(master->sysclk))
+		return PTR_ERR(master->sysclk);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.19.1

