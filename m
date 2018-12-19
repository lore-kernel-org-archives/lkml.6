Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DDBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B95218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNc2WOqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbeLSP47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:56:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52068 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbeLSP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:56:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so6517940wmj.1;
        Wed, 19 Dec 2018 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yjdj3iu/mF3pgb/qOEW4+jiU3xEZ/IKAQeEQmGe4lEY=;
        b=NNc2WOqw/ReMZMYkW9ez4MCZWAOSS4LIBgSm5JKxcTvEe5bXydaQmosc9iYof+kG2w
         /DPjAmku1o9blE7VAh4Ru0i5fMICqS/c/80k4FkKqKtiVlCViVGiccCLMaPga4PU9kOk
         aBERgu4bfj+5bJCbNbl6uyIWqilX0tAGShQ9HscacyORRo7tqki2TX1e3r6a8q59jplJ
         wnhLzuI+gXLRs7Q0POIVWUA6LEHhhO6sZnKkcPh0dfB/cCuvczUtNv8hByydawAwuKnx
         G7F5FEQJ3q2aHt/2bM3pEeP2CGSTGlrKfe5290OGAssaqLi/il6+yEJmaeA4dhSIjxe1
         Q/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Yjdj3iu/mF3pgb/qOEW4+jiU3xEZ/IKAQeEQmGe4lEY=;
        b=oAyaXaAUkGph62dCuC/3gVySh7CJrHl3vhIKSy4diAG09AS0ViAlMngwz6zKV49oUN
         iBTGfwENYILf01iELojUrxboV/wzzNb1Uc5aBwcpiFe8qu+OCOlTzcSSYhQlmvGvnvnL
         oZevrAGRyysUMOvYe3I6BhxnFu86McXK31Af2nqtY6uAMoaKfvr3ZpXlXsX5dAEs6O7M
         equQ9jzk5oqC8QjtpSYZozuAFrWytdxAz8Sd8G5dU7/LYMqqOF3dgp/r6kjJfJLDgIGl
         7xs3dbdGOYAUI5ILoyMwH1Lu46J0HB2xltGqswq5VKDYH3oDhs86WygQV8ppwr1O2fbw
         9ruQ==
X-Gm-Message-State: AA+aEWYwqMs16qAMFI9YJ3HOsjoExF/uhICXIYZvwqiA8Gu6zEDuHcFN
        Cg47ZIb9efv0djGMGt0O6pA=
X-Google-Smtp-Source: AFSGD/VHzRhZ5EAASjPGCZvBVQO5Kmjgq9gBZEuqlXjQAPLk5CS3qnVyb501uJulC/1HpUsMIwMldA==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr8074847wml.102.1545234989325;
        Wed, 19 Dec 2018 07:56:29 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id c9sm6836099wmh.27.2018.12.19.07.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 07:56:28 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     starnight@g.ncu.edu.tw, jiri@resnulli.us, afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC lora-next 3/4] net: lora: sx1301: add minimal to get transmission out
Date:   Wed, 19 Dec 2018 15:56:15 +0000
Message-Id: <20181219155616.9547-4-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219155616.9547-1-ben.whitten@lairdtech.com>
References: <20181219155616.9547-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because we cannot wait inside start_xmit so we copy the pointer to the skb
and schedule transmission work to be done.

For the transmission a lot is hard coded to just get a signal out of the
sx1301, it looks like using a header like CAN frames do will be a good
mechanism to get information such as coding rate, spreading factor and
power into the transmission.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 drivers/net/lora/sx1301.c | 166 +++++++++++++++++++++++++++++++++++++-
 drivers/net/lora/sx1301.h |  21 +++++
 2 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
index 0c7b6d0b31af..9bcbb967f307 100644
--- a/drivers/net/lora/sx1301.c
+++ b/drivers/net/lora/sx1301.c
@@ -24,6 +24,44 @@
 
 #include "sx1301.h"
 
+struct sx1301_tx_header {
+	u8	tx_freq[3];
+	u32	start;
+	u8  tx_power:4,
+		modulation_type:1,
+		radio_select:1,
+		resered0:2;
+	u8	reserved1;
+
+	union {
+		struct lora_t {
+			u8	sf:4,
+				cr:3,
+				crc16_en:1;
+			u8	payload_len;
+			u8	mod_bw:2,
+				implicit_header:1,
+				ppm_offset:1,
+				invert_pol:1,
+				reserved0:3;
+			u16	preamble;
+			u8	reserved1;
+			u8	reserved2;
+		} lora;
+		struct fsk_t {
+			u8	freq_dev;
+			u8	payload_len;
+			u8	packet_mode:1,
+				crc_en:1,
+				enc_mode:2,
+				crc_mode:1,
+				reserved0:3;
+			u16	preamble;
+			u16	bitrate;
+		} fsk;
+	} u;
+} __packed;
+
 static struct sx1301_tx_gain_lut tx_gain_lut[] = {
 	{
 		.dig_gain = 0,
@@ -546,9 +584,87 @@ static int sx1301_load_tx_gain_lut(struct sx1301_priv *priv)
 	return ret;
 };
 
+static int sx1301_tx(struct sx1301_priv *priv, void *data, int len)
+{
+	int ret, i;
+	u8 buff[256 + 16];
+	struct sx1301_tx_header *hdr = (struct sx1301_tx_header *)buff;
+
+	/* TODO general checks to make sure we CAN send */
+
+	/* TODO Enable notch filter for lora 125 */
+
+	/* TODO get start delay for this TX */
+
+	/* TODO interpret tx power, HACK just set max power */
+
+	/* TODO get TX imbalance for this pow index from calibration step */
+
+	/* TODO set the dig gain */
+
+	/* TODO set TX PLL freq based on radio used to TX */
+
+	memset(buff, 0, sizeof(buff));
+
+	/* HACK set to 868MHz */
+	hdr->tx_freq[0] = 217;
+	hdr->tx_freq[1] = 0;
+	hdr->tx_freq[3] = 0;
+
+	hdr->start = 0; /* Start imediatly */
+	hdr->radio_select = 0; /* HACK Radio A transmit */
+	hdr->modulation_type = 0; /* HACK modulation LORA */
+	hdr->tx_power = 15; /* HACK power entry 15 */
+
+	hdr->u.lora.crc16_en = 1; /* Enable CRC16 */
+	hdr->u.lora.cr = 1; /* CR 4/5 */
+	hdr->u.lora.sf = 7; /* SF7 */
+	hdr->u.lora.payload_len = len; /* Set the data len to the skb len */
+	hdr->u.lora.implicit_header = 0; /* No implicit header */
+	hdr->u.lora.mod_bw = 0; /* Set 125KHz BW */
+	hdr->u.lora.ppm_offset = 0; /* TODO no ppm offset? */
+	hdr->u.lora.invert_pol = 0; /* TODO set no inverted polarity */
+
+	hdr->u.lora.preamble = 8; /* Set the standard preamble */
+
+	/* TODO 2 Msb in tx_freq0 for large narrow filtering, unset for now */
+	hdr->tx_freq[0] &= 0x3F;
+
+	/* Copy the TX data into the buffer ready to go */
+
+	memcpy((void *)&buff[16], data, len);
+
+	/* Reset any transmissions */
+	ret = regmap_write(priv->regmap, SX1301_TX_TRIG, 0);
+	if (ret)
+		return ret;
+
+	/* Put the buffer into the tranmit fifo */
+	ret = regmap_write(priv->regmap, SX1301_TX_DATA_BUF_ADDR, 0);
+	if (ret)
+		return ret;
+	ret = regmap_noinc_write(priv->regmap, SX1301_TX_DATA_BUF_DATA, buff,
+				 len + 16);
+	if (ret)
+		return ret;
+
+	/* HACK just go for immediate transfer */
+	ret = sx1301_field_write(priv, F_TX_TRIG_IMMEDIATE, 1);
+	if (ret)
+		return ret;
+
+	dev_dbg(priv->dev, "Transmitting packet of size %d: ", len);
+	for (i = 0; i < len + 16; i++)
+		dev_dbg(priv->dev, "%X", buff[i]);
+
+	return ret;
+}
+
 static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb,
 					     struct net_device *netdev)
 {
+	struct sx1301_priv *priv = netdev_priv(netdev);
+
 	if (skb->protocol != htons(ETH_P_LORA)) {
 		kfree_skb(skb);
 		netdev->stats.tx_dropped++;
@@ -556,11 +672,42 @@ static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb,
 	}
 
 	netif_stop_queue(netdev);
+	priv->tx_skb = skb;
+	queue_work(priv->wq, &priv->tx_work);
 
-	/* TODO */
 	return NETDEV_TX_OK;
 }
 
+static void sx1301_tx_work_handler(struct work_struct *ws)
+{
+	struct sx1301_priv *priv = container_of(ws, struct sx1301_priv,
+						tx_work);
+	struct net_device *netdev = dev_get_drvdata(priv->dev);
+	int ret;
+
+	netdev_dbg(netdev, "%s\n", __func__);
+
+	if (priv->tx_skb) {
+		ret = sx1301_tx(priv, priv->tx_skb->data, priv->tx_skb->len);
+		if (ret) {
+			netdev->stats.tx_errors++;
+		} else {
+			netdev->stats.tx_packets++;
+			netdev->stats.tx_bytes += priv->tx_skb->len;
+		}
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
 	struct sx1301_priv *priv = netdev_priv(netdev);
@@ -676,6 +823,12 @@ static int sx130x_loradev_open(struct net_device *netdev)
 	if (ret)
 		return ret;
 
+	priv->tx_skb = NULL;
+
+	priv->wq = alloc_workqueue("sx1301_wq",
+				   WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
+	INIT_WORK(&priv->tx_work, sx1301_tx_work_handler);
+
 	netif_start_queue(netdev);
 
 	return 0;
@@ -683,11 +836,22 @@ static int sx130x_loradev_open(struct net_device *netdev)
 
 static int sx130x_loradev_stop(struct net_device *netdev)
 {
+	struct sx1301_priv *priv = netdev_priv(netdev);
+
 	netdev_dbg(netdev, "%s", __func__);
 
 	netif_stop_queue(netdev);
 	close_loradev(netdev);
 
+	destroy_workqueue(priv->wq);
+	priv->wq = NULL;
+
+	if (priv->tx_skb)
+		netdev->stats.tx_errors++;
+	if (priv->tx_skb)
+		dev_kfree_skb(priv->tx_skb);
+	priv->tx_skb = NULL;
+
 	return 0;
 }
 
diff --git a/drivers/net/lora/sx1301.h b/drivers/net/lora/sx1301.h
index 04c9af64c181..86116f3a1fa4 100644
--- a/drivers/net/lora/sx1301.h
+++ b/drivers/net/lora/sx1301.h
@@ -28,6 +28,10 @@
 /* Page independent */
 #define SX1301_PAGE     0x00
 #define SX1301_VER      0x01
+#define SX1301_RX_DATA_BUF_ADDR 0x02 /* 16 wide */
+#define SX1301_RX_DATA_BUF_DATA 0x04
+#define SX1301_TX_DATA_BUF_ADDR 0x05
+#define SX1301_TX_DATA_BUF_DATA 0x06
 #define SX1301_MPA      0x09
 #define SX1301_MPD      0x0A
 #define SX1301_GEN      0x10
@@ -45,6 +49,9 @@
 #define SX1301_FORCE_CTRL   (SX1301_PAGE_BASE(0) + 0x69)
 #define SX1301_MCU_CTRL     (SX1301_PAGE_BASE(0) + 0x6A)
 
+/* Page 1 */
+#define SX1301_TX_TRIG      (SX1301_PAGE_BASE(1) + 0x21)
+
 /* Page 2 */
 #define SX1301_RADIO_A_SPI_DATA     (SX1301_PAGE_BASE(2) + 0x21)
 #define SX1301_RADIO_A_SPI_DATA_RB  (SX1301_PAGE_BASE(2) + 0x22)
@@ -83,6 +90,10 @@ enum sx1301_fields {
 	F_FORCE_DEC_FILTER_GAIN,
 
 	F_EMERGENCY_FORCE_HOST_CTRL,
+
+	F_TX_TRIG_IMMEDIATE,
+	F_TX_TRIG_DELAYED,
+	F_TX_TRIG_GPS,
 };
 
 static const struct reg_field sx1301_regmap_fields[] = {
@@ -108,6 +119,11 @@ static const struct reg_field sx1301_regmap_fields[] = {
 	/* EMERGENCY_FORCE_HOST_CTRL */
 	[F_EMERGENCY_FORCE_HOST_CTRL] =
 		REG_FIELD(SX1301_EMERGENCY_FORCE_HOST_CTRL, 0, 0),
+	/* TX_TRIG */
+	[F_TX_TRIG_IMMEDIATE] = REG_FIELD(SX1301_TX_TRIG, 0, 0),
+	[F_TX_TRIG_DELAYED] = REG_FIELD(SX1301_TX_TRIG, 1, 1),
+	[F_TX_TRIG_GPS] = REG_FIELD(SX1301_TX_TRIG, 2, 2),
+
 };
 
 struct sx1301_tx_gain_lut {
@@ -126,6 +142,11 @@ struct sx1301_priv {
 	struct regmap		*regmap;
 	struct regmap_field *regmap_fields[ARRAY_SIZE(sx1301_regmap_fields)];
 
+	struct sk_buff *tx_skb;
+
+	struct workqueue_struct *wq;
+	struct work_struct tx_work;
+
 	struct sx1301_tx_gain_lut tx_gain_lut[SX1301_TX_GAIN_LUT_MAX];
 	u8 tx_gain_lut_size;
 };
-- 
2.17.1

