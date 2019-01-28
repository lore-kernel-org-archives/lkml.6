Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507FCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFBC214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C64yiCtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbfA1RD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:03:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40371 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732603AbfA1QNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so18698835wrt.7;
        Mon, 28 Jan 2019 08:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4BHGAOwTGYEwJ11CGOnGrvCubOUh6o7ZP9RgKZ/+o7Y=;
        b=C64yiCtqeDPjQzdcbMPpNwOThiFFMclyyOqiQlTO1T3fLrh/nUB6QmxBIoI1D0BYxK
         tyUpATdZ4/KlbpttZLp/DbUQJq1zczXVElKwp8tnGH+zJyIYbycQUHIDVFwl0gGn/d2w
         Nz/l4RRmAaNcEoqhhsANPIlPNbvZxpZ3Mw+KhAamkrlf1vC90GMZDJk/f90XUz6/rWvm
         Ws4kmUjZ2kAmppa4nrlXOtuWQuexFiKX1RJHKUHbWIiGI0s4MIqC7KxukbmhjLYY2Zmx
         WZN+WvNUJkaX3F8NLYNWjeNuPO1CWmpmeInA4t91jivsIzXnnEvtWYFKkRYm5OhNLD3D
         WgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4BHGAOwTGYEwJ11CGOnGrvCubOUh6o7ZP9RgKZ/+o7Y=;
        b=uEzx/+1ZzblFpGbwwNmG+okUCYxiLYMAOXKA5Yk3BdZbzICHCPpTcFlsqQ39l9Wft+
         JEzmdSwoXyzkdb8D8h3Qo8Jk/KrUYiOweRYuNr8PVqPeExTnrv5VbDE/EjXf1ZZ6Wh1h
         PiJV9DUEuAre0iLPU1ziMkq7yG8T5p7XNn7owBXHN5O6IHGCz+Yyqvh3L/Ia/mSo9TTZ
         99riSknKAD2x4M4GkAo3tvq/Z3MVFYJAuusutxFxfmxMO0CTIEgnn6M+Cb8b5amQHtsb
         AnFGb4yMVNNeyoWscnd+mwh8aIEFVL9gkCcvE+8sHD02/zuNOZyxM5CGXapAlkrX1giP
         UTYw==
X-Gm-Message-State: AJcUukfChje7h3Ehma9MtICLn691swdH8EZzCoGnkNCd912uZknw4ryc
        2JZvxu81jHHZN4jyaWZB97I=
X-Google-Smtp-Source: ALg8bN5UrhY7uK212ivDf9mhJYtbQ5qQllxo2qc7aGKTaXpQys23ygTQqJeh4lIom74m4RPf6nFsaw==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr23564413wrw.113.1548692033913;
        Mon, 28 Jan 2019 08:13:53 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:53 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH lora-next 07/11] net: lora: sx130x: add work queue to tx path
Date:   Mon, 28 Jan 2019 16:13:01 +0000
Message-Id: <20190128161306.27805-8-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128161306.27805-1-ben.whitten@lairdtech.com>
References: <20190128161306.27805-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are not allowed to sleep in _start_xmit, we need to add a work queue
to handle transmission of the packets.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 drivers/net/lora/sx130x.c | 50 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 88932fbbb598..820ec0220e28 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -69,6 +69,10 @@ struct sx130x_priv {
 	void			*drvdata;
 	struct sx130x_tx_gain_lut tx_gain_lut[SX1301_TX_GAIN_LUT_MAX];
 	u8 tx_gain_lut_size;
+
+	struct sk_buff *tx_skb;
+	struct workqueue_struct *wq;
+	struct work_struct tx_work;
 };
 
 struct regmap *sx130x_get_regmap(struct device *dev)
@@ -644,6 +648,8 @@ static int sx130x_agc_init(struct sx130x_priv *priv)
 
 static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
+	struct sx130x_priv *priv = netdev_priv(netdev);
+
 	if (skb->protocol != htons(ETH_P_LORA)) {
 		kfree_skb(skb);
 		netdev->stats.tx_dropped++;
@@ -651,11 +657,36 @@ static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb, struct net_dev
 	}
 
 	netif_stop_queue(netdev);
+	priv->tx_skb = skb;
+	queue_work(priv->wq, &priv->tx_work);
 
-	/* TODO */
 	return NETDEV_TX_OK;
 }
 
+static void sx130x_tx_work_handler(struct work_struct *ws)
+{
+	struct sx130x_priv *priv = container_of(ws, struct sx130x_priv, tx_work);
+	struct net_device *netdev = dev_get_drvdata(priv->dev);
+	int ret;
+
+	netdev_dbg(netdev, "%s\n", __func__);
+
+	if (priv->tx_skb) {
+
+		/* TODO actual tx* */
+
+		if (!(netdev->flags & IFF_ECHO) ||
+		    priv->tx_skb->pkt_type != PACKET_LOOPBACK ||
+		    priv->tx_skb->protocol != htons(ETH_P_LORA))
+			kfree_skb(priv->tx_skb);
+
+		priv->tx_skb = NULL;
+	}
+
+	if (netif_queue_stopped(netdev))
+		netif_wake_queue(netdev);
+}
+
 static int sx130x_loradev_open(struct net_device *netdev)
 {
 	struct sx130x_priv *priv = netdev_priv(netdev);
@@ -715,6 +746,12 @@ static int sx130x_loradev_open(struct net_device *netdev)
 
 	mutex_unlock(&priv->io_lock);
 
+	priv->tx_skb = NULL;
+
+	priv->wq = alloc_workqueue("sx130x_wq",
+				   WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
+	INIT_WORK(&priv->tx_work, sx130x_tx_work_handler);
+
 	netif_start_queue(netdev);
 
 	return 0;
@@ -729,11 +766,22 @@ static int sx130x_loradev_open(struct net_device *netdev)
 
 static int sx130x_loradev_stop(struct net_device *netdev)
 {
+	struct sx130x_priv *priv = netdev_priv(netdev);
+
 	netdev_dbg(netdev, "%s", __func__);
 
 	netif_stop_queue(netdev);
 	close_loradev(netdev);
 
+	destroy_workqueue(priv->wq);
+	priv->wq = NULL;
+
+	if (priv->tx_skb) {
+		netdev->stats.tx_errors++;
+		dev_kfree_skb(priv->tx_skb);
+	}
+	priv->tx_skb = NULL;
+
 	return 0;
 }
 
-- 
2.17.1

