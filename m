Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB4FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06FD21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrCqbnbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbfA1QOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:14:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39469 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732992AbfA1QN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so14487890wmi.4;
        Mon, 28 Jan 2019 08:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5EffI9q2BZp3g+80ucZcvCbCgpN9YaivlTi4sYtsNkk=;
        b=KrCqbnbuV4AhLGlkPXUp1JZDjyKLk3YTkemj+Y7kkgz0ICdAgMEe8Wt/gqWnTQMKrt
         FVp9NuLlm3EpDKwUyFobAUl+zsABmPC2P0ekjGH9IvOXxi211MqZWeVJolLINWuSUVnf
         sqNcE8diOxzrRvjMSMZ55h0lU/y7dzoeLosibf2gYBgXCa6z/t/o5tjXKuamrgE+HVw0
         CCrq6INUyE4FlJD0L+OzS3C3sHL5Ecamn+aVZ/jVoBs2PgAajoG+aV3dEDUSy/0ED3we
         kRth46by5L0PAezpZc6/hv/Kn1P741G+SSta7XRWeaco8/wJKAxHLFAUksvPQopm2i9X
         2Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5EffI9q2BZp3g+80ucZcvCbCgpN9YaivlTi4sYtsNkk=;
        b=l+E5jkGmvRLQ0xkgzzoJfAtByVDQxnW/+nxbiCZlu9Gp8derqJvexFo6UIXTBljdXX
         V1OB9x0F6dFHtJwM9y2XdbPte0vvRTtQ2hFpam02YK1Z13W69WJMRPv3ESIegjeI4k92
         ZF+2fs79lVIOtNMb1uYLfkuI1eswm/v+U8Ma/pSZi7iYabDGB6Kp1k3Rb56p2r4J7trN
         tX9n+qBATjpVb1EbH6RsynaByfvKDB85m3aZYOfWtKrmb0nRDxcYCZk9Cg84/W4BXv/j
         tEiNGaP3glKwEAxcuWwyRSlh6vGh5AiZBCI5U9FSstznwwLdXLb5Y2frPEfRVvn5jw6W
         IKTA==
X-Gm-Message-State: AJcUukfzLi5TRYYW6+HZ5xZK/TGtu85B/slQARBeW4OFXLoJpsUTVGe7
        SC54/JrIb6//Ol9dBdBizDw=
X-Google-Smtp-Source: ALg8bN6/xSkxkF0zDGNSwHl0rOIAHbwu4KbxEcDN4/X1nfdyVjWwTmYUvoO32rQ8f+f2XV+iJdnPfA==
X-Received: by 2002:a1c:87cc:: with SMTP id j195mr17449412wmd.2.1548692035066;
        Mon, 28 Jan 2019 08:13:55 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:54 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH lora-next 08/11] net: lora: sx130x: add test transmission
Date:   Mon, 28 Jan 2019 16:13:02 +0000
Message-Id: <20190128161306.27805-9-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128161306.27805-1-ben.whitten@lairdtech.com>
References: <20190128161306.27805-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First transmission from the SX130x, all metadata values are hardcoded
and will be replaced with a suitable alternative.
Data sent into the socket is sent straight out of the card.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 drivers/net/lora/sx130x.c | 128 +++++++++++++++++++++++++++++++++++++-
 drivers/net/lora/sx130x.h |  11 ++++
 2 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 820ec0220e28..f96f32d2e1ff 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -49,8 +49,50 @@ static const struct reg_field sx130x_regmap_fields[] = {
 	/* EMERGENCY_FORCE_HOST_CTRL */
 	[F_EMERGENCY_FORCE_HOST_CTRL] =
 		REG_FIELD(SX1301_EMERGENCY_FORCE_HOST_CTRL, 0, 0),
+	/* TX_TRIG */
+	[F_TX_TRIG_IMMEDIATE] = REG_FIELD(SX1301_TX_TRIG, 0, 0),
+	[F_TX_TRIG_DELAYED] = REG_FIELD(SX1301_TX_TRIG, 1, 1),
+	[F_TX_TRIG_GPS] = REG_FIELD(SX1301_TX_TRIG, 2, 2),
 };
 
+struct sx130x_tx_header {
+	u8	tx_freq[3];
+	u32	start;
+	u8	tx_power:4,
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
 struct sx130x_tx_gain_lut {
 	s8 power;	/* dBm measured at board connector */
 	u8 dig_gain;
@@ -646,6 +688,83 @@ static int sx130x_agc_init(struct sx130x_priv *priv)
 	return ret;
 }
 
+static int sx130x_tx(struct sx130x_priv *priv, void *data, int len)
+{
+	int ret, i;
+	u8 buff[256 + 16];
+	struct sx130x_tx_header *hdr = (struct sx130x_tx_header *)buff;
+	struct net_device *netdev = dev_get_drvdata(priv->dev);
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
+	hdr->tx_freq[2] = 0;
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
+	ret = sx130x_field_force_write(priv, F_TX_TRIG_IMMEDIATE, 1);
+	if (ret)
+		return ret;
+
+	netdev_dbg(netdev, "Transmitting packet of size %d: ", len);
+	for (i = 0; i < len + 16; i++)
+		netdev_dbg(netdev, "%X", buff[i]);
+
+	return ret;
+}
+
 static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct sx130x_priv *priv = netdev_priv(netdev);
@@ -672,8 +791,13 @@ static void sx130x_tx_work_handler(struct work_struct *ws)
 	netdev_dbg(netdev, "%s\n", __func__);
 
 	if (priv->tx_skb) {
-
-		/* TODO actual tx* */
+		ret = sx130x_tx(priv, priv->tx_skb->data, priv->tx_skb->len);
+		if (ret) {
+			netdev->stats.tx_errors++;
+		} else {
+			netdev->stats.tx_packets++;
+			netdev->stats.tx_bytes += priv->tx_skb->len;
+		}
 
 		if (!(netdev->flags & IFF_ECHO) ||
 		    priv->tx_skb->pkt_type != PACKET_LOOPBACK ||
diff --git a/drivers/net/lora/sx130x.h b/drivers/net/lora/sx130x.h
index 2878dd3cc547..38f1b58b2165 100644
--- a/drivers/net/lora/sx130x.h
+++ b/drivers/net/lora/sx130x.h
@@ -32,6 +32,10 @@
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
@@ -49,6 +53,9 @@
 #define SX1301_FORCE_CTRL   (SX1301_PAGE_BASE(0) + 0x69)
 #define SX1301_MCU_CTRL     (SX1301_PAGE_BASE(0) + 0x6A)
 
+/* Page 1 */
+#define SX1301_TX_TRIG      (SX1301_PAGE_BASE(1) + 0x21)
+
 /* Page 2 */
 #define SX1301_RADIO_A_SPI_DATA     (SX1301_PAGE_BASE(2) + 0x21)
 #define SX1301_RADIO_A_SPI_DATA_RB  (SX1301_PAGE_BASE(2) + 0x22)
@@ -87,6 +94,10 @@ enum sx130x_fields {
 	F_FORCE_DEC_FILTER_GAIN,
 
 	F_EMERGENCY_FORCE_HOST_CTRL,
+
+	F_TX_TRIG_IMMEDIATE,
+	F_TX_TRIG_DELAYED,
+	F_TX_TRIG_GPS,
 };
 
 struct regmap *sx130x_get_regmap(struct device *dev);
-- 
2.17.1

