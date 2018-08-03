Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3EEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFE52172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFE52172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeHCI75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:59:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728147AbeHCI74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:59:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 83B334457048B;
        Fri,  3 Aug 2018 15:04:57 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Fri, 3 Aug 2018 15:04:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <woojung.huh@microchip.com>, <davem@davemloft.net>,
        <UNGLinuxDriver@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] include/net/bond_3ad: Simplify the code by using the ARRAY_SIZE
Date:   Fri, 3 Aug 2018 14:53:15 +0800
Message-ID: <1533279195-50245-3-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1533279195-50245-1-git-send-email-zhongjiang@huawei.com>
References: <1533279195-50245-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We prefer to ARRAY_SIZE rather than the open code to calculate size.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 include/net/bond_3ad.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index f358ad5..fc31115 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -283,7 +283,7 @@ static inline const char *bond_3ad_churn_desc(churn_state_t state)
 		"none",
 		"unknown"
 	};
-	int max_size = sizeof(churn_description) / sizeof(churn_description[0]);
+	int max_size = ARRAY_SIZE(churn_description);
 
 	if (state >= max_size)
 		state = max_size - 1;
-- 
1.7.12.4

