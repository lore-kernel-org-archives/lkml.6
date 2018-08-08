Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D888DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B23B2173C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B23B2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeHHODV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:03:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51491 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbeHHODV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:03:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 784B3FBF46483;
        Wed,  8 Aug 2018 19:43:57 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Wed, 8 Aug 2018
 19:43:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <willemb@google.com>,
        <dja@axtens.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <ast@kernel.org>, <pabeni@redhat.com>, <posk@google.com>,
        <daniel@iogearbox.net>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: skbuff.h: fix using plain integer as NULL warning
Date:   Wed, 8 Aug 2018 19:40:31 +0800
Message-ID: <20180808114031.12292-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:
./include/linux/skbuff.h:2365:58: warning: Using plain integer as NULL pointer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7ebdf15..7e237a6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2362,7 +2362,7 @@ static inline void skb_probe_transport_header(struct sk_buff *skb,
 	if (skb_transport_header_was_set(skb))
 		return;
 
-	if (skb_flow_dissect_flow_keys_basic(skb, &keys, 0, 0, 0, 0, 0))
+	if (skb_flow_dissect_flow_keys_basic(skb, &keys, NULL, 0, 0, 0, 0))
 		skb_set_transport_header(skb, keys.control.thoff);
 	else
 		skb_set_transport_header(skb, offset_hint);
-- 
2.7.0


