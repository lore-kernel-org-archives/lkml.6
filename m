Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C23C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9452098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9452098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbeISQQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:16:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730984AbeISQQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:16:04 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B7F2D929966A6;
        Wed, 19 Sep 2018 18:38:42 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 18:38:43 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] net: iucv: Use FIELD_SIZEOF directly instead of reimplementing its function
Date:   Wed, 19 Sep 2018 18:26:17 +0800
Message-ID: <1537352781-48532-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1537352781-48532-1-git-send-email-zhongjiang@huawei.com>
References: <1537352781-48532-1-git-send-email-zhongjiang@huawei.com>
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
 net/iucv/af_iucv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index e2f16a0..5b68ee9 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -48,7 +48,7 @@
 static const u8 iprm_shutdown[8] =
 	{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01};
 
-#define TRGCLS_SIZE	(sizeof(((struct iucv_message *)0)->class))
+#define TRGCLS_SIZE	FIELD_SIZEOF(struct iucv_message, class)
 
 #define __iucv_sock_wait(sk, condition, timeo, ret)			\
 do {									\
-- 
1.7.12.4

