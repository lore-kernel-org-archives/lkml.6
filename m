Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B85C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D32121525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D32121525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbeITOFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:05:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbeITOFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 10:05:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6EDC031D931A;
        Thu, 20 Sep 2018 16:23:33 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 16:23:32 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: remove redundant continue
Date:   Thu, 20 Sep 2018 16:11:10 +0800
Message-ID: <1537431070-38261-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The continue will not truely skip any code. hence it is safe to
remove it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/hwmon/scpi-hwmon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 7e49da5..111d521 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -286,10 +286,8 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 		 * any thermal zones or if the thermal subsystem is
 		 * not configured.
 		 */
-		if (IS_ERR(z)) {
+		if (IS_ERR(z))
 			devm_kfree(dev, zone);
-			continue;
-		}
 	}
 
 	return 0;
-- 
1.7.12.4

