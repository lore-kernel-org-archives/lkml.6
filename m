Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E24C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A3C218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uT3RP4hZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeLSP4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:56:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37081 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbeLSP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:56:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so6969396wmd.2;
        Wed, 19 Dec 2018 07:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dx/xK0RPW2Lm4RTnTSdayPB1mXeHlkjPqDKxt/FlTYM=;
        b=uT3RP4hZ/DEf3FHnmnLfA0r3NF1GIV1bsBOVPUlc9/prQ9MSPHrlpI4O+/KnlZZaDx
         IP4kkm0Rd+OPfRycRd5UKqh+mTKCBaz0riQLbsCWStbcwqMjytVZaJf4RBCbHuagNovc
         chuD2iyqKld37WgcAzc2RzpowHlRjJ1n8RbpBWv828/Bv0fyKw+nCKbrOgmkLV5T66HU
         nMawDGBcUalrU1AT6rbLpfBU9j9JH5Hsv8wpN1TC3rVV91ruqroIQ1YAXUPdNPG4Bh/8
         SGID7Rg3z8pMAJ4JxVEDJ/2vXy2rccCXn1NhHDQH1fdHWfKVTLBVBqhuQqacWvf+nB7V
         z72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Dx/xK0RPW2Lm4RTnTSdayPB1mXeHlkjPqDKxt/FlTYM=;
        b=rQd16Z3J+8zjX2RdJv3Q5ltGqI9Ef0to2S5jtej2/lLRjtdxHTVcKEZV/uLmKx+T9N
         jcFic+4j8M53wasJmt4SMSLcgf7vkoFWisisv4Dwk0ov9rMc81wKOQS40gC75/vHvqnu
         52zsDN+ThHR7WaSLEjAj5tYS6B/Tj0gF/wdfJTZPaOn+yIj3zHpjiHwuY9sl53FjB4KU
         SErC1W1Ki5wiOVzQl5zhvIR0jINZ24QCUSqblafiAxfqwZbzNf3grBb0NFoVYVcnoS+A
         Suso78bA0CaMbbx0hI4LEuCZM407T2xd1HQLBlG+b8q9nCC+FSUcLc2xiAzzaPoiyWEw
         N+Cw==
X-Gm-Message-State: AA+aEWbAzo+319jpIVhMlJKdujVAJgYZGeNRHBXcfkeH9qKMQW9ARRHw
        3Ghqm9ZzViLagtMT4LS2d9A=
X-Google-Smtp-Source: AFSGD/WzrHrGMbMsACXlzav1xUQl3C83IiETnFwMbF8GBgDUaeahhM8ywgLn4QaMgw+3VzWzGQBK6Q==
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr8133515wmf.32.1545234990621;
        Wed, 19 Dec 2018 07:56:30 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id c9sm6836099wmh.27.2018.12.19.07.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 07:56:30 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     starnight@g.ncu.edu.tw, jiri@resnulli.us, afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC lora-next 4/4] net: lora: sx1301: introduce a lora frame for packet metadata
Date:   Wed, 19 Dec 2018 15:56:16 +0000
Message-Id: <20181219155616.9547-5-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219155616.9547-1-ben.whitten@lairdtech.com>
References: <20181219155616.9547-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Information such as spreading factor, coding rate and power are on a per
transmission basis so it makes sence to include this in a header much
like CAN frames do.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 drivers/net/lora/dev.c    |  2 -
 drivers/net/lora/sx1301.c | 79 +++++++++++++++++++++++++++++++++------
 include/uapi/linux/lora.h | 46 +++++++++++++++++++++++
 3 files changed, 114 insertions(+), 13 deletions(-)

diff --git a/drivers/net/lora/dev.c b/drivers/net/lora/dev.c
index 0d4823de8c06..62dbe21668b0 100644
--- a/drivers/net/lora/dev.c
+++ b/drivers/net/lora/dev.c
@@ -11,8 +11,6 @@
 #include <linux/lora/skb.h>
 #include <net/rtnetlink.h>
 
-#define LORA_MTU 256 /* XXX */
-
 struct sk_buff *alloc_lora_skb(struct net_device *dev, u8 **data)
 {
 	struct sk_buff *skb;
diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
index 9bcbb967f307..fed6d6201bf3 100644
--- a/drivers/net/lora/sx1301.c
+++ b/drivers/net/lora/sx1301.c
@@ -584,7 +584,7 @@ static int sx1301_load_tx_gain_lut(struct sx1301_priv *priv)
 	return ret;
 };
 
-static int sx1301_tx(struct sx1301_priv *priv, void *data, int len)
+static int sx1301_tx(struct sx1301_priv *priv, struct lora_frame *frame)
 {
 	int ret, i;
 	u8 buff[256 + 16];
@@ -617,11 +617,67 @@ static int sx1301_tx(struct sx1301_priv *priv, void *data, int len)
 	hdr->tx_power = 15; /* HACK power entry 15 */
 
 	hdr->u.lora.crc16_en = 1; /* Enable CRC16 */
-	hdr->u.lora.cr = 1; /* CR 4/5 */
-	hdr->u.lora.sf = 7; /* SF7 */
-	hdr->u.lora.payload_len = len; /* Set the data len to the skb len */
+
+	switch (frame->cr) {
+	case LORA_CR_4_5:
+		hdr->u.lora.cr = 1; /* CR 4/5 */
+		break;
+	case LORA_CR_4_6:
+		hdr->u.lora.cr = 2; /* CR 4/6 */
+		break;
+	case LORA_CR_4_7:
+		hdr->u.lora.cr = 3; /* CR 4/7 */
+		break;
+	case LORA_CR_4_8:
+		hdr->u.lora.cr = 4; /* CR 4/8 */
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	switch (frame->sf) {
+	case LORA_SF_6:
+		hdr->u.lora.sf = 6; /* SF6 */
+		break;
+	case LORA_SF_7:
+		hdr->u.lora.sf = 7; /* SF7 */
+		break;
+	case LORA_SF_8:
+		hdr->u.lora.sf = 8; /* SF8 */
+		break;
+	case LORA_SF_9:
+		hdr->u.lora.sf = 9; /* SF9 */
+		break;
+	case LORA_SF_10:
+		hdr->u.lora.sf = 10; /* SF10 */
+		break;
+	case LORA_SF_11:
+		hdr->u.lora.sf = 11; /* SF11 */
+		break;
+	case LORA_SF_12:
+		hdr->u.lora.sf = 12; /* SF12 */
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	hdr->u.lora.payload_len = frame->len; /* Set the data length */
 	hdr->u.lora.implicit_header = 0; /* No implicit header */
-	hdr->u.lora.mod_bw = 0; /* Set 125KHz BW */
+
+	switch (frame->bw) {
+	case LORA_BW_125KHZ:
+		hdr->u.lora.mod_bw = 0; /* 125KHz BW */
+		break;
+	case LORA_BW_250KHZ:
+		hdr->u.lora.mod_bw = 1; /* 250KHz BW */
+		break;
+	case LORA_BW_500KHZ:
+		hdr->u.lora.mod_bw = 2; /* 500KHz BW */
+		break;
+	default:
+		return -ENXIO;
+	}
+
 	hdr->u.lora.ppm_offset = 0; /* TODO no ppm offset? */
 	hdr->u.lora.invert_pol = 0; /* TODO set no inverted polarity */
 
@@ -632,7 +688,7 @@ static int sx1301_tx(struct sx1301_priv *priv, void *data, int len)
 
 	/* Copy the TX data into the buffer ready to go */
 
-	memcpy((void *)&buff[16], data, len);
+	memcpy((void *)&buff[16], frame->data, frame->len);
 
 	/* Reset any transmissions */
 	ret = regmap_write(priv->regmap, SX1301_TX_TRIG, 0);
@@ -644,7 +700,7 @@ static int sx1301_tx(struct sx1301_priv *priv, void *data, int len)
 	if (ret)
 		return ret;
 	ret = regmap_noinc_write(priv->regmap, SX1301_TX_DATA_BUF_DATA, buff,
-				 len + 16);
+				 frame->len + 16);
 	if (ret)
 		return ret;
 
@@ -653,8 +709,8 @@ static int sx1301_tx(struct sx1301_priv *priv, void *data, int len)
 	if (ret)
 		return ret;
 
-	dev_dbg(priv->dev, "Transmitting packet of size %d: ", len);
-	for (i = 0; i < len + 16; i++)
+	dev_dbg(priv->dev, "Transmitting packet of size %d: ", frame->len);
+	for (i = 0; i < frame->len + 16; i++)
 		dev_dbg(priv->dev, "%X", buff[i]);
 
 	return ret;
@@ -683,17 +739,18 @@ static void sx1301_tx_work_handler(struct work_struct *ws)
 	struct sx1301_priv *priv = container_of(ws, struct sx1301_priv,
 						tx_work);
 	struct net_device *netdev = dev_get_drvdata(priv->dev);
+	struct lora_frame *frame = (struct lora_frame *)priv->tx_skb->data;
 	int ret;
 
 	netdev_dbg(netdev, "%s\n", __func__);
 
 	if (priv->tx_skb) {
-		ret = sx1301_tx(priv, priv->tx_skb->data, priv->tx_skb->len);
+		ret = sx1301_tx(priv, frame);
 		if (ret) {
 			netdev->stats.tx_errors++;
 		} else {
 			netdev->stats.tx_packets++;
-			netdev->stats.tx_bytes += priv->tx_skb->len;
+			netdev->stats.tx_bytes += frame->len;
 		}
 
 		if (!(netdev->flags & IFF_ECHO) ||
diff --git a/include/uapi/linux/lora.h b/include/uapi/linux/lora.h
index 4ff00b9c3c20..d675025d2a6e 100644
--- a/include/uapi/linux/lora.h
+++ b/include/uapi/linux/lora.h
@@ -21,4 +21,50 @@ struct sockaddr_lora {
 	} lora_addr;
 };
 
+#define LORA_MAX_DLEN	256
+
+enum lora_bw {
+	LORA_BW_125KHZ,
+	LORA_BW_250KHZ,
+	LORA_BW_500KHZ,
+};
+
+enum lora_cr {
+	LORA_CR_4_5,
+	LORA_CR_4_6,
+	LORA_CR_4_7,
+	LORA_CR_4_8,
+};
+
+enum lora_sf {
+	LORA_SF_6,
+	LORA_SF_7,
+	LORA_SF_8,
+	LORA_SF_9,
+	LORA_SF_10,
+	LORA_SF_11,
+	LORA_SF_12,
+};
+
+/**
+ * struct lora_frame - LoRa frame structure
+ * @freq: Frequency of LoRa transmission in Hz
+ * @power: Power of transmission in dBm
+ * @bw:  bandwidth, 125, 250 or 500 KHz
+ * @cr:  coding rate, 4/5 to 4/8
+ * @sf:  spreading factor from SF6 to 12
+ * @data:   LoRa frame payload (up to LORA_MAX_DLEN byte)
+ */
+struct lora_frame {
+	__u32		freq; /* transmission frequency in Hz */
+	__u8		power; /* transmission power in dBm */
+	enum lora_bw	bw; /* bandwidth */
+	enum lora_cr	cr; /* coding rate */
+	enum lora_sf	sf; /* spreading factor */
+	__u8		len;
+	__u8		data[LORA_MAX_DLEN] __attribute__((aligned(8)));
+};
+
+#define LORA_MTU (sizeof(struct lora_frame))
+
 #endif /* _UAPI_LINUX_LORA_H */
-- 
2.17.1

