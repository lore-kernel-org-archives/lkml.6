Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061E3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2951217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeLRHCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:02:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60832 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbeLRHCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:02:55 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 40325EB766027;
        Tue, 18 Dec 2018 15:02:52 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 15:02:43 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] regulator: act8945a-regulator: make symbol act8945a_pm static
Date:   Tue, 18 Dec 2018 07:10:21 +0000
Message-ID: <1545117021-178814-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:

drivers/regulator/act8945a-regulator.c:340:1: warning:
 symbol 'act8945a_pm' was not declared. Should it be static?

Fixes: 7482d6ecc68e ("regulator: act8945a-regulator: Implement PM functionalities")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/regulator/act8945a-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 90572b6..dc3942b 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -337,7 +337,7 @@ static int act8945a_suspend(struct device *pdev)
 	return regmap_write(act8945a->regmap, ACT8945A_SYS_CTRL, 0x42);
 }
 
-SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
+static SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
 
 static void act8945a_pmic_shutdown(struct platform_device *pdev)
 {



