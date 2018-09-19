Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A0EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A94C2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A94C2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbeISRWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:22:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728334AbeISRWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:22:15 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B37927A6EEBD1;
        Wed, 19 Sep 2018 19:44:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 19:44:39 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <ubraun@linux.ibm.com>, <jwi@linux.ibm.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <Ariel.Elior@cavium.com>,
        <everest-linux-l2@cavium.com>, <grygorii.strashko@ti.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <borntraeger@de.ibm.com>
Subject: [RESEND PATCH 5/5] net: ti: Use FIELD_SIZEOF directly instead of reimplementing its function
Date:   Wed, 19 Sep 2018 19:32:14 +0800
Message-ID: <1537356734-51676-6-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1537356734-51676-1-git-send-email-zhongjiang@huawei.com>
References: <1537356734-51676-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FIELD_SIZEOF is defined as a macro to calculate the specified value. Therefore,
We prefer to use the macro rather than calculating its value.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ethernet/ti/cpsw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 832bce0..16dcbf3 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -484,13 +484,13 @@ enum {
 };
 
 #define CPSW_STAT(m)		CPSW_STATS,				\
-				sizeof(((struct cpsw_hw_stats *)0)->m), \
+				FIELD_SIZEOF(struct cpsw_hw_stats, m), \
 				offsetof(struct cpsw_hw_stats, m)
 #define CPDMA_RX_STAT(m)	CPDMA_RX_STATS,				   \
-				sizeof(((struct cpdma_chan_stats *)0)->m), \
+				FIELD_SIZEOF(struct cpdma_chan_stats, m), \
 				offsetof(struct cpdma_chan_stats, m)
 #define CPDMA_TX_STAT(m)	CPDMA_TX_STATS,				   \
-				sizeof(((struct cpdma_chan_stats *)0)->m), \
+				FIELD_SIZEOF(struct cpdma_chan_stats, m), \
 				offsetof(struct cpdma_chan_stats, m)
 
 static const struct cpsw_stats cpsw_gstrings_stats[] = {
-- 
1.7.12.4

