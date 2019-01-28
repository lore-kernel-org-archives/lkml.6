Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDBEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C97F21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhEsWxvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbfA1RDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:03:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38784 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387535AbfA1QN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so18668851wrw.5;
        Mon, 28 Jan 2019 08:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cQEg/fY/4fwqAOKXHFbwz+lUp8voIQMkvzv/xUhihWI=;
        b=LhEsWxvcA8ZKFNzXsM8CAXLOkre80zmk59bJiSD+C/XpA5l9CSJoTAd0prZvVyRjL4
         /+I+qiJ544oeVDg+KbjlaReAyMgjfElTe8kDzic+EM041ocHSkii0Hw0mrKAUr7mDb6H
         5OwLxQ7cLeWixUT56F05SUmWy+axQ7PUT6OQGkGhXbvp3/M5AARyYzZBwDYZy2C9iAuv
         qikbphP6R9RHJuy44so1aX+g/m5jcZL8sUnVcX7jjyETQAz99zfm0vEWIBlWEGdSWRaI
         Xn640JFN/j9UeG0XRBIU7w7JloyZ74vfcR8SduruBEDYLcEsy+7U8nMhI2e4WZrPYASU
         5alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=cQEg/fY/4fwqAOKXHFbwz+lUp8voIQMkvzv/xUhihWI=;
        b=IZe89kZOzCqDrimDiyQrlg5TifhvTgsl6Oi+BbcZSXEWGxBBmxE0UtP//I6HscA3iL
         aBiOzE0vz8DnaMwE9wQH2VfY4ES+5Eh+MX4I8mU1iVQNvjmLi9JCNjw8TE6ZdOyWkllx
         6YWZkj89nBWVaciLXpZjdEOuk9LNWvkv3Oiti7cIM1dwe9zIbcgs7ARP+fyzn8w37XoA
         CEVpa0PCpeVRAA23wsYzeJCpQRzKGbRtGHFhZOdyYg4U91rn6n8hAookl4wu+85m0X4x
         dmrcxjtOELAezYMpH7bMZBJcKsh6ZQoO63pmgyfeJoh/m6v2/WthwFAnNI+Adr0/u8pu
         Bf1A==
X-Gm-Message-State: AJcUukeNSlWdiNNJJ4sW9GPH3z1MQSgAvLhrJxTzEMVCmnCM8JxFR+NE
        aWgDiADxVlxBqWtW9C+rlnY=
X-Google-Smtp-Source: ALg8bN5s7yfAyHgs+ZB4dPMs59FIlB2K5LwQJlwtLnfbJccI+k0i0Sb1E/NqiUNYMBk9eFZPvs9dzw==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr23765784wrq.175.1548692037725;
        Mon, 28 Jan 2019 08:13:57 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:57 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH lora-next 10/11] net: lora: sx130x: make use of lora address metadata in transmission
Date:   Mon, 28 Jan 2019 16:13:04 +0000
Message-Id: <20190128161306.27805-11-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128161306.27805-1-ben.whitten@lairdtech.com>
References: <20190128161306.27805-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We take the metadata encoded in the lora address and apply it to the
outgoing transmission.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 drivers/net/lora/sx130x.c | 58 ++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index f96f32d2e1ff..428e82b4ccb8 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/gpio/consumer.h>
 #include <linux/lora/dev.h>
+#include <linux/lora/skb.h>
 #include <linux/spi/spi.h>
 
 #include "sx130x.h"
@@ -688,12 +689,13 @@ static int sx130x_agc_init(struct sx130x_priv *priv)
 	return ret;
 }
 
-static int sx130x_tx(struct sx130x_priv *priv, void *data, int len)
+static int sx130x_tx(struct sx130x_priv *priv, struct sk_buff *skb)
 {
 	int ret, i;
 	u8 buff[256 + 16];
 	struct sx130x_tx_header *hdr = (struct sx130x_tx_header *)buff;
 	struct net_device *netdev = dev_get_drvdata(priv->dev);
+	u8 sf;
 
 	/* TODO general checks to make sure we CAN send */
 
@@ -722,11 +724,47 @@ static int sx130x_tx(struct sx130x_priv *priv, void *data, int len)
 	hdr->tx_power = 15; /* HACK power entry 15 */
 
 	hdr->u.lora.crc16_en = 1; /* Enable CRC16 */
-	hdr->u.lora.cr = 1; /* CR 4/5 */
-	hdr->u.lora.sf = 7; /* SF7 */
-	hdr->u.lora.payload_len = len; /* Set the data len to the skb len */
+
+	switch (lora_skb_prv(skb)->cr) {
+	case 5:
+		hdr->u.lora.cr = 1; /* CR 4/5 */
+		break;
+	case 6:
+		hdr->u.lora.cr = 2; /* CR 4/6 */
+		break;
+	case 7:
+		hdr->u.lora.cr = 3; /* CR 4/7 */
+		break;
+	case 8:
+		hdr->u.lora.cr = 4; /* CR 4/8 */
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	sf = lora_skb_prv(skb)->sf;
+	if ((sf < 6) || (sf > 12))
+		return -ENXIO;
+
+	hdr->u.lora.sf = sf;
+
+	hdr->u.lora.payload_len = skb->len; /* Set the data length */
 	hdr->u.lora.implicit_header = 0; /* No implicit header */
-	hdr->u.lora.mod_bw = 0; /* Set 125KHz BW */
+
+	switch(lora_skb_prv(skb)->bw) {
+	case 125:
+		hdr->u.lora.mod_bw = 0; /* 125KHz BW */
+		break;
+	case 250:
+		hdr->u.lora.mod_bw = 1; /* 250KHz BW */
+		break;
+	case 500:
+		hdr->u.lora.mod_bw = 2; /* 500KHz BW */
+		break;
+	default:
+		return -ENXIO;
+	}
+
 	hdr->u.lora.ppm_offset = 0; /* TODO no ppm offset? */
 	hdr->u.lora.invert_pol = 0; /* TODO set no inverted polarity */
 
@@ -737,7 +775,7 @@ static int sx130x_tx(struct sx130x_priv *priv, void *data, int len)
 
 	/* Copy the TX data into the buffer ready to go */
 
-	memcpy((void *)&buff[16], data, len);
+	memcpy((void *)&buff[16], skb->data, skb->len);
 
 	/* Reset any transmissions */
 	ret = regmap_write(priv->regmap, SX1301_TX_TRIG, 0);
@@ -749,7 +787,7 @@ static int sx130x_tx(struct sx130x_priv *priv, void *data, int len)
 	if (ret)
 		return ret;
 	ret = regmap_noinc_write(priv->regmap, SX1301_TX_DATA_BUF_DATA, buff,
-				 len + 16);
+				 skb->len + 16);
 	if (ret)
 		return ret;
 
@@ -758,8 +796,8 @@ static int sx130x_tx(struct sx130x_priv *priv, void *data, int len)
 	if (ret)
 		return ret;
 
-	netdev_dbg(netdev, "Transmitting packet of size %d: ", len);
-	for (i = 0; i < len + 16; i++)
+	netdev_dbg(netdev, "Transmitting packet of size %d: ", skb->len);
+	for (i = 0; i < skb->len + 16; i++)
 		netdev_dbg(netdev, "%X", buff[i]);
 
 	return ret;
@@ -791,7 +829,7 @@ static void sx130x_tx_work_handler(struct work_struct *ws)
 	netdev_dbg(netdev, "%s\n", __func__);
 
 	if (priv->tx_skb) {
-		ret = sx130x_tx(priv, priv->tx_skb->data, priv->tx_skb->len);
+		ret = sx130x_tx(priv, priv->tx_skb);
 		if (ret) {
 			netdev->stats.tx_errors++;
 		} else {
-- 
2.17.1

