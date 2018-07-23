Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87ABECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EBE20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZO/O37n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EBE20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeGWEXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:23:13 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44289 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbeGWEXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:23:13 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so7620159pls.11;
        Sun, 22 Jul 2018 20:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4J1koG4+EGfcsIqa6o7V7IMGrrz9tyBAcg5wvF1hAro=;
        b=ZO/O37n1BrvctJNO5U7d81ZjYEYtSXUjFac4czg/nRteXRWmqEzfYO3fG8GDB6hTdv
         vt1cRLDUFHRecLsmzGdN2YskPfrBJ/377g1LiTIEVsvQckEaWqOz4EgF8DNPRIbzJyKE
         TMK5RIT1H5QfmlaRP/0ikNtnjUfhDXEGOQlR6JVZaZqEwq7ytHQKSkTPgYKDFZKCY+p+
         78RxnYF1pPfLWhjFOWvLK1LpBSJl2iHCqj0OEHGnlvEnoRnmnx/TbLUGIeXfj9eoQf0Z
         SnwYGX7/31I4TO+3AS5BGPkNUoFy6u/juWktH9YgZ33vrbvK51Fk/MyUXEZEPF5toKk9
         5Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4J1koG4+EGfcsIqa6o7V7IMGrrz9tyBAcg5wvF1hAro=;
        b=ZnjbVA5adjp/WVFz0Aq56nOEKrTs9/bZ/DbF2NMBwgrzXFQ3wniTf3goBERdHzYufP
         QbaHA0bcV85ZtKwGXYagTffH4rpAVr9jVyI5oo97wbrm2buu2r+KFQc+OFPMJJsJaWxH
         g8YyI/hUK3VbXLFCZHHqWAcfAE890+MK0Q1us3bqPMnNzcc09WTlDjzeCHQGbWxr/Gja
         Gl6778UO5aU2dhBYpaX2J0KfNFAZ72smivnlbrzfsoEKBx8RN2BfxTupxt0UXWkN3QNe
         xJywuMESVO3b3iad8Kql2r4F0yz/h7DhGVPam0wcme0dsyHWpi+amZNShc0nENmfkHJP
         JB0g==
X-Gm-Message-State: AOUpUlEacoKE4Bf5PRl6iVEvgg5uVkVLUZzOYQ0gZG4Nev9Dm/WQCkJ2
        U84FDoDc6Zd2l3EI5FVd7pWAyMui
X-Google-Smtp-Source: AAOMgpdLy4b4GWLL6GS9xjE4c9Zc0SGau6DoKUXiViIHO3ss+gx0E7ObSyDpqwn+nW3Ovmj1TY1lZA==
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr11158501plf.320.1532316250673;
        Sun, 22 Jul 2018 20:24:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:c122:f95a:1d53:1f82])
        by smtp.gmail.com with ESMTPSA id g85-v6sm19147834pfk.39.2018.07.22.20.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:24:10 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: bpa10x: Replace GFP_ATOMIC with GFP_KERNEL in bpa10x_send_frame()
Date:   Mon, 23 Jul 2018 11:24:02 +0800
Message-Id: <20180723032402.7676-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpa10x_send_frame() is only set to hdev->send, and hdev->send() is never 
called in atomic context.

bpa10x_send_frame() calls usb_alloc_urb(), kmalloc() and usb_submit_urb() 
with GFP_ATOMIC, which is not necessary. 
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/bpa10x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index c6f7cc57db14..d1c2adf08576 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -289,7 +289,7 @@ static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	skb->dev = (void *) hdev;
 
-	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!urb)
 		return -ENOMEM;
 
@@ -298,7 +298,7 @@ static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
-		dr = kmalloc(sizeof(*dr), GFP_ATOMIC);
+		dr = kmalloc(sizeof(*dr), GFP_KERNEL);
 		if (!dr) {
 			usb_free_urb(urb);
 			return -ENOMEM;
@@ -343,7 +343,7 @@ static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	usb_anchor_urb(urb, &data->tx_anchor);
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	err = usb_submit_urb(urb, GFP_KERNEL);
 	if (err < 0) {
 		bt_dev_err(hdev, "urb %p submission failed", urb);
 		kfree(urb->setup_packet);
-- 
2.17.0

