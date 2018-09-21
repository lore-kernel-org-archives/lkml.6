Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E1CECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649D721547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649D721547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbeIUH2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:28:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388299AbeIUH2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:28:54 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F0071FFBACB;
        Fri, 21 Sep 2018 09:42:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 09:42:25 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCHv2] hwmon: scpi-hwmon:  remove redundant continue
Date:   Fri, 21 Sep 2018 09:30:03 +0800
Message-ID: <1537493403-15745-1-git-send-email-zhongjiang@huawei.com>
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

