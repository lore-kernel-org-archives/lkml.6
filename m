Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009D9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A00420846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3oCv+yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A00420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbeGWE3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:29:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46736 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeGWE3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:29:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so11193444pgv.13;
        Sun, 22 Jul 2018 20:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YlHOWb6o2UkF5uFCli32feFITCCMfW5LK+2IcBOljEk=;
        b=m3oCv+ylzjRsU/QuEhxuUVr+4vN1qRc9oYm21h+rIwFvrncoevtyzBXD/r2wbKSq55
         0tNdTVkeYpNHcmE87xZXRuF1Devm0BlWsKcXlXlCGQWooJwo4hOknXzmzwJRvpw4A7W7
         OkDMYwu00lJG8fCbH6DXJJAQ1rjzCwRREbkFhd71t3Dyv1cO7mi+XyJBQzxiQgeHS5ho
         IQWYK9buMq7jfnHqq0RycifxJIAG52GLAubqkXPw9A6XaezdK1RpqxUBIFjJCriVV+UH
         GzLuEqq2osMxktVH3Ff9aYpGa3tJ28LmcfqhNigAamtOmS0omNtSCepCeiWs/V/YZmY5
         gVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YlHOWb6o2UkF5uFCli32feFITCCMfW5LK+2IcBOljEk=;
        b=nGPDUftrqEwJhCNXW2nhJAtEbvdSCZ+li0yBCcD4Nq48+xlhNFZfv7sIQGwDbnk4z3
         nMQJSXtuh73Ja86DQQEppNgOF+6ofRT4BrMGMXpO1OtZKkQCTUgORAESIRBp91zDgYLl
         qjkj7NZRUde11DwzFos6Uw/GU35vkp9kvLrfvEoPgoTj3ssZrpbtlzIIfh/1cBL/R2S3
         T96zTfy6O5sAXeFKnnTGCAb9Wic9NO1pmGuZ3svRfUFPZiWjemKOFnedfzy+cdbcqqyx
         CbCqI3EpaDWvnIkMEt0RyldVdJf5NjeGbFCqj5lwNM3t2LRAJtk7UsgvsWnoUTSrMfzX
         qT3A==
X-Gm-Message-State: AOUpUlGjhps9496a9zsV8oKf/bKezuoB6VkNyPzUx6NcHqzJ/6f7c3Q/
        5PpHfHBtiFZSwJO9ipQfOL8So8Nh
X-Google-Smtp-Source: AAOMgpca0508Fv45qqK0N2BzPha00iqfI14YeBMIlQk4EI1sc6+54HEdZoMJUpiVxx1LrpaDhaTneQ==
X-Received: by 2002:a63:ac57:: with SMTP id z23-v6mr10289754pgn.74.1532316612556;
        Sun, 22 Jul 2018 20:30:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:c122:f95a:1d53:1f82])
        by smtp.gmail.com with ESMTPSA id m26-v6sm10230450pfi.102.2018.07.22.20.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:30:12 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: btmrvl_sdio: Replace GFP_ATOMIC with GFP_KERNEL in btmrvl_sdio_card_to_host()
Date:   Mon, 23 Jul 2018 11:30:03 +0800
Message-Id: <20180723033003.7957-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btmrvl_sdio_card_to_host() is never called in atomic context.
It calls bt_skb_alloc() with GFP_ATOMIC, which is not necessary. 
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 6f99b9f3d57f..af36ed6376ad 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -718,7 +718,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	}
 
 	/* Allocate buffer */
-	skb = bt_skb_alloc(num_blocks * blksz + BTSDIO_DMA_ALIGN, GFP_ATOMIC);
+	skb = bt_skb_alloc(num_blocks * blksz + BTSDIO_DMA_ALIGN, GFP_KERNEL);
 	if (!skb) {
 		BT_ERR("No free skb");
 		ret = -ENOMEM;
-- 
2.17.0

