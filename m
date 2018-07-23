Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7A2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA82320779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qe2PaTqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA82320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeGWEQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:16:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36979 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeGWEQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:16:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so11171445pgq.4;
        Sun, 22 Jul 2018 20:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zEPh0NPzq/G43tzS/tfNSh0ugM2BW5QJyLQhCe3ksKA=;
        b=qe2PaTqtS6wD+alBtsRUl9Q62hlUdEGxSPjwQ8iq1j6R8FdGSYlvnjK5B+1VEma1+B
         0gPhZVJY4IA3TfoltzcybmMRV/XxZKAj1cFnA1ueSquzBkoDKXY4DiYKqHyxuBX5rRu+
         XVukdh4jIq4WutxkBRLyWcrtJ180C/28EVhHtOrup8K1GrTXYESp7HpJ8PhB0GsZxOWa
         2VseWyyKDxjYFmtUS033Q9sMoDJVrMwLAZ9lqRzdX3uWYk9gG9XvHvRDHPO+7W0o4Xlo
         yRnecpzHhRFP2mWtx3zfDCmUvrk360TlkpG4sOTrHEPSUIflmjDJ7rcgFF9d3IV2drvM
         4KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zEPh0NPzq/G43tzS/tfNSh0ugM2BW5QJyLQhCe3ksKA=;
        b=RkOgRgONkgA2m3KbkCDmHuJ4ahP2pz1dGd3rmnjRx8ebJDze34gZpfwcOM3CBAYJVs
         IZMJsFjB9jCqi27c8F9pN1+Wwl6OZEpZQ3bGUeYkGYUOviwMley1J9abUjI6wxV3bb3t
         f6L89xgTNpNq0mMh4vNp/3F+aKSIN0XLrQDZJDT62RFTIWH1IBcyzv9mQYjeWgEI0GI8
         b+zMl1gvbU6aiQSQGkUAeW9QEuGifLLCBsOISyQRJeGV43jusgnpw7mWcs2TMbPs8Q21
         RaOoQ5X1kZrfgd5GPp5oR95ErdLT5Hmoa/lnCXWK7e6PKY/mTjrBwUL5DRskLxedAjIK
         d+OA==
X-Gm-Message-State: AOUpUlEzkM28+uJwCNrrhiexKqzHgCA9Z+cp5FUgBQc4XYvahgqpccco
        GAUtYB6I+nry6Smftz+gRRg=
X-Google-Smtp-Source: AAOMgpcFB9Lsbq4YmFAeLj8piN/lZjiv/2c1oiFPiz3GNgu6Xn3TmsHX+VtLOi3B1Jw4W7m/dGT9fw==
X-Received: by 2002:a63:5421:: with SMTP id i33-v6mr10695237pgb.417.1532315863534;
        Sun, 22 Jul 2018 20:17:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:c122:f95a:1d53:1f82])
        by smtp.gmail.com with ESMTPSA id t186-v6sm11317202pgd.77.2018.07.22.20.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:17:43 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: bluecard_cs: Replace GFP_ATOMIC with GFP_KERNEL in bluecard_hci_set_baud_rate()
Date:   Mon, 23 Jul 2018 11:17:35 +0800
Message-Id: <20180723031735.7518-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bluecard_hci_set_baud_rate() is never called in atomic context.

bluecard_hci_set_baud_rate() is only by bluecard_hci_open(), which is 
set to hdev->open, and hdev->open() is never called in atomic context.

bluecard_hci_set_baud_rate() calls bt_skb_alloc() with GFP_ATOMIC, 
which is not necessary. GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/bluecard_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 82437a69f99c..cc6e56223656 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -565,7 +565,7 @@ static int bluecard_hci_set_baud_rate(struct hci_dev *hdev, int baud)
 	/* Ericsson baud rate command */
 	unsigned char cmd[] = { HCI_COMMAND_PKT, 0x09, 0xfc, 0x01, 0x03 };
 
-	skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
+	skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_KERNEL);
 	if (!skb) {
 		BT_ERR("Can't allocate mem for new packet");
 		return -1;
-- 
2.17.0

