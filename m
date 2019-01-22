Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7CDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1914B20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rm0rKjQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfAVIdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:33:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40598 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbfAVIda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:33:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so10723619pgp.7;
        Tue, 22 Jan 2019 00:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=56Ajni3E8oZE+o/bfMQDpPDoogGlR13oEATbHo2Cu/A=;
        b=rm0rKjQK9GUvfcDjEXiVDMLEdrgt5o9JpBVcvm6/3/4uBbT2OFpoY4kCu3buz2WZaf
         TE+PTo2JcZfISf12bVCsQQZ1g/t78GICw+q/GQd4JmEiSUVvnRWR0dIYYZrQIC+l7Q3u
         u6zi/sgMuMMUezVtWKJHgRyJ0RHc/NRRUnX/g7mzAkyed0xdKrfn+F3bYPKquVyukdvw
         4vcEBrY1rKyj6a7ViWsASljvhFRpB660snQbpAtEfaDQygjaZMJlddRVY3PHivwlKILH
         yIm+AkcDudO63Y6dUM2tdiMKjpIoB+Tz7mIkbeM5AnDHB/qC3A80VlXwkcr4uhl9BVxa
         iAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=56Ajni3E8oZE+o/bfMQDpPDoogGlR13oEATbHo2Cu/A=;
        b=Sk3I8LMm3hY4+HMjua3IvgTaP3v3Ci2dscD0HKqzRjSDeSbkhzevOj5O5X7WDtmqaY
         3Fdmlv3Atp0bberwVDNdvcaPWPnir0n2VC2k10JhKXskSh4+b2FIhIoG8nAS09nSL+Ko
         9yCiKkLORF4EJAbP+Ny7tBcpb9yYVv0Gx01y4seQ8idjH+iDY+Q640AnxPf5hxz2PUyd
         N2GVxUjEQfiuBs17IdbOXGwRMAiUq0a2W+B5TjxiK901NVnUblOvsLtUgKEn8GepXnwH
         rhxTM85no3xOIZ7qRIg+3bDZ5LUm1op4mUdq5jBv+mOosRtJtCKYVeNTOY/zd+0dEV+m
         mwYA==
X-Gm-Message-State: AJcUukfOZRy4DXUVgsgHjlbght/hX6n1C9dUPS8PxhCFJ0tMKd/sTjYQ
        lUEIB3+Q4iWdRi2VRk5rLtxe9R2p
X-Google-Smtp-Source: ALg8bN7XC3FuX9Jb2JkPCXHQm3qRM4DFi0DHCcUtFxBel/U59HqJwSLH6rGNyeCtbfbKGV+4C8mTog==
X-Received: by 2002:a63:5026:: with SMTP id e38mr31220384pgb.123.1548146009345;
        Tue, 22 Jan 2019 00:33:29 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id a65sm12860844pge.65.2019.01.22.00.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 00:33:28 -0800 (PST)
Date:   Tue, 22 Jan 2019 00:33:26 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Check if socket buffer is ERR_PTR in
 h4_recv_buf()
Message-ID: <20190122083323.GA22508@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

h4_recv_buf() callers store the return value to socket buffer and
recursively pass the buffer to h4_recv_buf() without protection. So,
ERR_PTR returned from h4_recv_buf() can be dereferenced, if called again
before setting the socket buffer to NULL from previous error. Check if
skb is ERR_PTR in h4_recv_buf().

Reported-by: syzbot+017a32f149406df32703@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 drivers/bluetooth/h4_recv.h | 4 ++++
 drivers/bluetooth/hci_h4.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/bluetooth/h4_recv.h b/drivers/bluetooth/h4_recv.h
index b432651f8236..285cf72190b7 100644
--- a/drivers/bluetooth/h4_recv.h
+++ b/drivers/bluetooth/h4_recv.h
@@ -60,6 +60,10 @@ static inline struct sk_buff *h4_recv_buf(struct hci_dev *hdev,
 					  const struct h4_recv_pkt *pkts,
 					  int pkts_count)
 {
+	/* Check if socket buffer is not reset yet from previous error */
+	if (IS_ERR(skb))
+		skb = NULL;
+
 	while (count) {
 		int i, len;
 
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index fb97a3bf069b..dea48090d2dc 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -174,6 +174,10 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	u8 alignment = hu->alignment ? hu->alignment : 1;
 
+	/* Check if socket buffer is not reset yet from previous error */
+	if (IS_ERR(skb))
+		skb = NULL;
+
 	while (count) {
 		int i, len;
 
-- 
2.17.1

