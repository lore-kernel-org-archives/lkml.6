Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2363620779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgemYGLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2363620779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbeGWE4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:56:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43923 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeGWE4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:56:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so11238747pgr.10;
        Sun, 22 Jul 2018 20:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=azh75g2c9bjZRtbyaAxZ+lV3Jx3bHWmoH6s9tqIV2TA=;
        b=tgemYGLxF71nmbfsplD+HTYnl5eyRH+8Z3IOCRXrAvrpD5YDx8ha0yebCuC+ZTXDrv
         MVsmhZ5lc9rxfNro6kdsJpo/2ByJ//PE6OxBPoJWQLh9NAYvkxobZ21+Lmmqj+2bXnlT
         lWg63t8MI7p7+TQBqC7+MP5dDMKDzt9nQxQKpMjIExqdJjk3xrs/KIxikdDNxypHpLtH
         mhN1ZStRqpwlN78mmhdtcOKz6WFZCP/kMTbdJ/NiJyQ4/BMsWXnesbrN6hvUo/ZLRN8n
         Aj4ydpSymQ/TrwtixpEqrGaWOee2pDvzoeDJ4+2xCyyX3u7n5ZM8+dFKh5nVLNoOLPhd
         ztFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=azh75g2c9bjZRtbyaAxZ+lV3Jx3bHWmoH6s9tqIV2TA=;
        b=qBabaVe5if4ksCBJSAV3tRzDyv8hFmtLMHDHQLBd2XDe0gxaLTCf5S2t8OeHO5YJv/
         cjOrbGfbP790XQPyac6mzHgsVpw6KLqQHd0KMWp6bxOX1eEeEShowmVxKxZHDWFVi/Ub
         lbIAcJca2aQTuhE1sB6aGV3xoP5nK7ksHvH+kZbXS1mC3b23LPqJ1jdZAhUoHJY8OlxR
         4PjHhWpJ7xoeU7LJ1dZgIbP0ymF8UR6Bv/M0nBGPS9/kEeRtZ0+d9nOfp41s9+tXkN1J
         vJxQG5mQ3jI3d9uV9GaV0OKResuqBzmH9Lrl5VZTDVMDQ/8aWNaKdNG2xdOW/L0vgzsX
         qQHg==
X-Gm-Message-State: AOUpUlEqUA0MY5F2E8AI7vHwPxKNMmtyxwNd2GX1ticUaAPID8QbPERr
        jRtyafwd+8poSh/tnkqT6hg=
X-Google-Smtp-Source: AAOMgpcYjZCBWZYkHssoKf0PFoE3E38Il9sp/nHNIt+yI3+jah7JaOIs2kOMF+cjxCYBndlBazOqbw==
X-Received: by 2002:a62:4f5b:: with SMTP id d88-v6mr11608942pfb.225.1532318220815;
        Sun, 22 Jul 2018 20:57:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:c122:f95a:1d53:1f82])
        by smtp.gmail.com with ESMTPSA id n9-v6sm15242780pfg.21.2018.07.22.20.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:57:00 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: hci_qca: Replace GFP_ATOMIC with GFP_KERNEL
Date:   Mon, 23 Jul 2018 11:56:51 +0800
Message-Id: <20180723035651.8423-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qca_open() and qca_set_baudrate() are never called in atomic context.

They call kzalloc() and bt_skb_alloc() with GFP_ATOMIC,
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 05ec530b8a3a..021d966b8f08 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -390,7 +390,7 @@ static int qca_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p qca_open", hu);
 
-	qca = kzalloc(sizeof(struct qca_data), GFP_ATOMIC);
+	qca = kzalloc(sizeof(struct qca_data), GFP_KERNEL);
 	if (!qca)
 		return -ENOMEM;
 
@@ -861,7 +861,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	cmd[4] = baudrate;
 
-	skb = bt_skb_alloc(sizeof(cmd), GFP_ATOMIC);
+	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
 	if (!skb) {
 		bt_dev_err(hdev, "Failed to allocate baudrate packet");
 		return -ENOMEM;
-- 
2.17.0

