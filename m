Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5C8ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD482087B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD482087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbeIPTUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 15:20:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728470AbeIPTUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 15:20:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CB122228A8CCC;
        Sun, 16 Sep 2018 21:57:21 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Sun, 16 Sep 2018 21:57:20 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <f.fainelli@gmail.com>, <andrew@lunn.ch>
CC:     <vivien.didelot@savoirfairelinux.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: dsa: remove redundant null pointer check before put_device
Date:   Sun, 16 Sep 2018 21:45:02 +0800
Message-ID: <1537105502-65268-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_device has taken the null pinter check into account. So it is
safe to remove the duplicated check before put_device.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/dsa/legacy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/dsa/legacy.c b/net/dsa/legacy.c
index 42a7b85..8aa92b0 100644
--- a/net/dsa/legacy.c
+++ b/net/dsa/legacy.c
@@ -392,8 +392,7 @@ static void dsa_of_free_platform_data(struct dsa_platform_data *pd)
 		}
 
 		/* Drop our reference to the MDIO bus device */
-		if (pd->chip[i].host_dev)
-			put_device(pd->chip[i].host_dev);
+		put_device(pd->chip[i].host_dev);
 	}
 	kfree(pd->chip);
 }
-- 
1.7.12.4

