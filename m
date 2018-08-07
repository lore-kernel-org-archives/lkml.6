Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AC6C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB12A21916
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB12A21916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeHGGQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:16:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbeHGGQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:16:05 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B45AA617A3DAE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 12:03:42 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Tue, 7 Aug 2018
 12:03:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] nds32: add NULL entry to the end of_device_id array
Date:   Tue, 7 Aug 2018 12:03:13 +0800
Message-ID: <20180807040313.6944-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure of_device_id tables are NULL terminated.
Found by coccinelle spatch "misc/of_table.cocci"

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/nds32/kernel/atl2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/atl2c.c b/arch/nds32/kernel/atl2c.c
index 0c6d031..0c5386e 100644
--- a/arch/nds32/kernel/atl2c.c
+++ b/arch/nds32/kernel/atl2c.c
@@ -9,7 +9,8 @@
 
 void __iomem *atl2c_base;
 static const struct of_device_id atl2c_ids[] __initconst = {
-	{.compatible = "andestech,atl2c",}
+	{.compatible = "andestech,atl2c",},
+	{}
 };
 
 static int __init atl2c_of_init(void)
-- 
2.7.0


