Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961DAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB922084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHDoT1IP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfAKGzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:55:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44455 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfAKGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:55:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so6499877pfh.11;
        Thu, 10 Jan 2019 22:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ND9+7PXVzbCVGLg9x59ZbN8q0pF2DmYmFt3qYX2lP5g=;
        b=uHDoT1IP1XyfHKt6Pyj0gYCAyO7jux99PBGQLGKGjEbsMNfdb79UI4FA09OxnLpQWg
         wD3TUdh/GMve2xiLh8Pz6mME9790SVBbyiH77RFSuSuzPNUWb0ZEtyp+Z7/uXQzQfYwp
         IWgTyTOO6biVPKL/oBrnca21MZLjLDI3qzGGCtP7EP9qK5pnbu7rtdlqy0yTCm+q8tAE
         u8wxMYTE6UYMEKoIAiDsaVgzo7CBZ0h1o7hhDwv6xfKWkWtKA8cOQ1OJMVNxdxNdvTui
         dKaRbzBC9ipINF+htOIwDCxKDAHgsPQJXW4bk4FW1wM5aTqRZqmobEAzxJRSywUsWdnF
         P0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ND9+7PXVzbCVGLg9x59ZbN8q0pF2DmYmFt3qYX2lP5g=;
        b=eboh8HQTQFYLPB0m6PU3wBMbjMFuXB6T7yXB755brxjzi5qwdJc4ndheVf0jBw+asY
         YrPrX9d4I99yGzxnE5VzdmB7igJDLmgfH5BWSsLFRdOZipIr5buUAnrGib9H2uEkOgFu
         F/hf1OqhXWjLb/7/YQYB+T5mnRdnozm8ZHT5+rWnLDd3/7MLyomjF2ygESxIbZE5KkMZ
         /4o69MAaOZX9HLIR5lQvGFf+5wfEr9ySwIroaiTGMo43fY5qVczpkPpPxv/X7+WIlsSC
         yznP+VUabSPqtNClLI6C3mCIG1fktoA6qoiEZvMeBCYR/YKsqPN288z9XRKL1Blx60hJ
         hmcQ==
X-Gm-Message-State: AJcUukdWmDgSUlbkCKaYHybVNrC2HAYtz/qDc17Yg0teEzT3SECbo3mX
        5UnmOJOOsGhlP6vpZiDUYTk=
X-Google-Smtp-Source: ALg8bN5/XgE3khJkstBqxYLL/ieDdUD7kC66zRon1vnNIIa8IjqIj1Z1EO8lt/JDtiLi/OMlQsuFPA==
X-Received: by 2002:a63:6984:: with SMTP id e126mr12458307pgc.143.1547189720752;
        Thu, 10 Jan 2019 22:55:20 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id j9sm99456381pfi.86.2019.01.10.22.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 22:55:20 -0800 (PST)
Date:   Thu, 10 Jan 2019 22:55:17 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Add a local variable to store the
 result of h4_recv_buf()
Message-ID: <20190111065514.GA26542@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In h4_recv(), if h4_recv_buf() returns error and h4_recv() is
asynchronously called again before setting rx_skb to NULL, ERR_PTR will
be dereferenced in h4_recv_buf(). Check return value in a local variable
before writing to rx_skb.

Reported-by: syzbot+017a32f149406df32703@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 drivers/bluetooth/hci_h4.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index fb97a3bf069b..fa30ec9cebd4 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -124,19 +124,22 @@ static const struct h4_recv_pkt h4_recv_pkts[] = {
 static int h4_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct h4_struct *h4 = hu->priv;
+	struct sk_buff *skb;
 
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
 
-	h4->rx_skb = h4_recv_buf(hu->hdev, h4->rx_skb, data, count,
-				 h4_recv_pkts, ARRAY_SIZE(h4_recv_pkts));
-	if (IS_ERR(h4->rx_skb)) {
-		int err = PTR_ERR(h4->rx_skb);
+	skb = h4_recv_buf(hu->hdev, h4->rx_skb, data, count,
+			  h4_recv_pkts, ARRAY_SIZE(h4_recv_pkts));
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
 		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
 		h4->rx_skb = NULL;
 		return err;
 	}
 
+	h4->rx_skb = skb;
+
 	return count;
 }
 
-- 
2.17.1

