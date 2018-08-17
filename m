Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93CFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBC6213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT8kncuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBC6213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeHQQHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:07:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45933 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeHQQHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:07:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so3565832pgq.12;
        Fri, 17 Aug 2018 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yWkr/muWaoqI7jxiu1oc1AyXYkxFpaFuIWx2owlEthM=;
        b=RT8kncuNF4hnabEwDpgnuH6/UIzRRFJQpMo4ru3bwmRCAfejPSd6WsxHYfVRCPKZd4
         BmU8UjxWOS3uHiYPH3ucGTELQZwb2EylgBVleswbBHRKc9p0Qm8ga9IHaSuYP8Ml8PeA
         CaQGZG8q+l3gY0xhFPcuv+oqXrguFmfbdysnHADj53Bur/wc1C6hR297qmW8j7Mwrwru
         4fJlDIr2eYempXGaDOZswWtsk7lpayouEZbJQaWzr3CYH81ROqlvYVYIVO4m4sc37NG4
         75HDnrWYMumT4HIVBp1gekusM6vLEimG+2Fxo3Wdu99TNQd6nIIx+5Sd9lsjNbyTY0+K
         wo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yWkr/muWaoqI7jxiu1oc1AyXYkxFpaFuIWx2owlEthM=;
        b=qReBnZ6X+ygxTSLPA13Pu7tnzxIDN+u9M3fh7KmwWOAFsl70JtC8OOcoQ8o9F2obQZ
         hcmBYUMr71LaQWr2nffzK0iOyY1+AJwEEwd6iDj9PCvr3B7qYUZ09/u2Kay2I6BQqlxJ
         GgfXLz3JYuN5epD+Wnfaq6+WP1G9uBkbdnktP04OI2zCYnGXlPyXYRkQqAf/r8bBGw7V
         HAA6Tb4IZA/Yr7VwgwihkO27d3oa5jCmOkjXZWDQ/BoOc2P1JcX0z35MrLGbgoCcEENH
         CqPxLkXXP9ZEgNVWRgfk9TW2glwsaMA9uBE4rVS6n6Ob4ChW+YP3gukRu9Dw38gCCy/I
         TkVA==
X-Gm-Message-State: AOUpUlFkmIPtEsh5SfeSJhB1FzZV/SV1T9S1c+9v+WMEvmJRE+0oQfIq
        f1Qcv6+bbIWGphhujBRwODI=
X-Google-Smtp-Source: AA+uWPy2Um6mLrPVvLYaJhXvjSSqhKUPf59kdjqn38Yz2XtQRtyvzKXxxTTfJoSe6fYQkSenS7aeXw==
X-Received: by 2002:a62:21cc:: with SMTP id o73-v6mr36835751pfj.21.1534511058901;
        Fri, 17 Aug 2018 06:04:18 -0700 (PDT)
Received: from localhost.localdomain ([47.88.150.209])
        by smtp.gmail.com with ESMTPSA id b1-v6sm4288053pgi.91.2018.08.17.06.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 06:04:17 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     ludovic.desroches@microchip.com, vkoul@kernel.org,
        dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Barry Song <21cnbao@gmail.com>
Subject: [PATCH 3/3] dmaengine: at_xdmac: move spin_lock_bh to spin_lock in tasklet
Date:   Fri, 17 Aug 2018 06:03:43 -0700
Message-Id: <1534511023-7871-1-git-send-email-21cnbao@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/dma/at_xdmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 4bf7256..4e55768 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1600,7 +1600,7 @@ static void at_xdmac_tasklet(unsigned long data)
 		if (atchan->status & AT_XDMAC_CIS_ROIS)
 			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
 
-		spin_lock_bh(&atchan->lock);
+		spin_lock(&atchan->lock);
 		desc = list_first_entry(&atchan->xfers_list,
 					struct at_xdmac_desc,
 					xfer_node);
@@ -1610,7 +1610,7 @@ static void at_xdmac_tasklet(unsigned long data)
 		txd = &desc->tx_dma_desc;
 
 		at_xdmac_remove_xfer(atchan, desc);
-		spin_unlock_bh(&atchan->lock);
+		spin_unlock(&atchan->lock);
 
 		if (!at_xdmac_chan_is_cyclic(atchan)) {
 			dma_cookie_complete(txd);
-- 
2.7.4

