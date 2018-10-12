Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707D7C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11932075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11932075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeJLX5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:57:41 -0400
Received: from mail78-58.sinamail.sina.com.cn ([219.142.78.58]:37303 "HELO
        mail78-58.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1728689AbeJLX5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:57:41 -0400
Received: from unknown (HELO localhost.localdomain.localdomain)([171.223.32.124])
        by sina.com with ESMTP
        id 5BC0CAAF0000611D; Fri, 13 Oct 2018 00:24:22 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 583336394106
From:   Peng Hao <penghao122@sina.com.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  block/sx8 : remove unnecessory check
Date:   Fri, 12 Oct 2018 12:24:13 -0400
Message-Id: <1539361453-3383-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

TAG_VALID(tag)= ((((tag) & 0xf) == 0xf) && (TAG_DECODE(tag) < 32)).
But '(X & 0x1f) < 0x20(32)' is always true. The second half of
TAG_VALID is unnecessary.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/block/sx8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 4d90e5e..b8e9ebf 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -75,7 +75,7 @@
 /* 0xf is just arbitrary, non-zero noise; this is sorta like poisoning */
 #define TAG_ENCODE(tag)	(((tag) << 16) | 0xf)
 #define TAG_DECODE(tag)	(((tag) >> 16) & 0x1f)
-#define TAG_VALID(tag)	((((tag) & 0xf) == 0xf) && (TAG_DECODE(tag) < 32))
+#define TAG_VALID(tag)	(((tag) & 0xf) == 0xf)
 
 /* note: prints function name for you */
 #ifdef CARM_DEBUG
-- 
1.8.3.1


