Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2AC20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMD1op6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2AC20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeGWEIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:08:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37235 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeGWEIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:08:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so11158726pgq.4;
        Sun, 22 Jul 2018 20:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q8HqsZ+rwzUQVqFb+oGmZmwsEgSmjkkeIGgBTWpZapw=;
        b=sMD1op6dLGCu2hDXuwPsHnYi0ZDi4J/q74wA27j0CyBRTL4O1nVfxcY9oVPSC7PIz7
         ac48/WPZw3ouiBIIfevlju3vq3IUTSZTfSr115qaEbaFtIp3JtVw6SalUMx5BEI7lAHX
         CwazGKpgCVQxrAk2v6wkOJYeuaeUO+z1CHvUw99FZUcRfb97DcZthZFgar0di7toQgZd
         07hFmeFGLwKPV7P2un7JArQ7NodNq+PSMXWQ4kozxjSbHNIBCy96nL37wo1ntfD2fuBD
         APBvn34kWwFfz5MX4jhVa7+aZt/vUjN31niUtl02GGjx68pMPF0IYeRLxyoneKgWDA3K
         WKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q8HqsZ+rwzUQVqFb+oGmZmwsEgSmjkkeIGgBTWpZapw=;
        b=SYOJBiivDQZBG7p9OtpfBg2o0Myi7lNwvMqKhSObwq1L3oX1drQkG1huPbtZWqzWXn
         h317mVPfn6/dSYGG/4NO5WlzWJTVVib8s63oRTqhtwNb3h6KFFkFMj3Nvqzj7lcuTfS+
         bExEvcK1WjTe49I7fXijdxc3QGh4Ymc9SxgDNjNsbfYUPeQmde6eduCuwvYnDoE6+HM6
         TMApEf3Tb5Li9XRiN6lJWdYzzIfSDi/hrq1Ovy+hLL/6wMvGx8gnNGHJlCdT2abZEyjp
         pbCK9c86NVZtJkIXYI/r9eFJIrJno82eAGv5ov7fNi/XSRXxKE1WgM+DUvp/nWJ8g5Fr
         4N2A==
X-Gm-Message-State: AOUpUlG/CKLeHc9uBw8EvJwwXVVJ8yl+2ewVFEdCxMec6KLkBg2rKTWR
        52jOk/XbzDkzdL9nE5guRblqztbd
X-Google-Smtp-Source: AAOMgpez/pHtiG/VkQ+m+J4ki6KE7i/V2hTpuBnMt49ov0d3zbZ0rsFHECum7SDvA1k1QTfJLtwhJA==
X-Received: by 2002:a63:db05:: with SMTP id e5-v6mr10517041pgg.152.1532315351190;
        Sun, 22 Jul 2018 20:09:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:c122:f95a:1d53:1f82])
        by smtp.gmail.com with ESMTPSA id t69-v6sm18918510pfj.7.2018.07.22.20.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:09:10 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: bfusb: Replace GFP_ATOMIC with GFP_KERNEL in bfusb_send_frame()
Date:   Mon, 23 Jul 2018 11:09:00 +0800
Message-Id: <20180723030900.7305-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bfusb_send_frame() is only set to hdev->send, and hdev->send() is never
called in atomic context.

bfusb_send_frame() calls bt_skb_alloc() with GFP_ATOMIC, which is not
necessary. GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/bfusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index ab090a313a5f..0588639b899a 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -490,7 +490,7 @@ static int bfusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	count = skb->len;
 
 	/* Max HCI frame size seems to be 1511 + 1 */
-	nskb = bt_skb_alloc(count + 32, GFP_ATOMIC);
+	nskb = bt_skb_alloc(count + 32, GFP_KERNEL);
 	if (!nskb) {
 		BT_ERR("Can't allocate memory for new packet");
 		return -ENOMEM;
-- 
2.17.0

