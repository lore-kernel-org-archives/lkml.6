Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951ABC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BD120673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oN/LGMR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BD120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeGYXak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:30:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43794 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeGYXaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:30:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id b20-v6so14754edt.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yy6ZEDIC/vSWmlNd0ya7PCBbNMS89G0Qyrlws7DPuUE=;
        b=oN/LGMR8bN3HwInkPo3Z6VgqTzMa5HQdTJb7Ln3zAnC0m0nDB5WLxQF1mNbv5o5Q+4
         BlPe5apvbdR9QuqUk7OYYY+RoR940XZHkVTwdgAq6fQEScu4SfyCLRtDatx5uhTKQJ3w
         ZIpY7v9ipXsGZ/LAzqHB79K05Bzxjdl8fpHrpITcL1yEwRtvrWllaR/mprMByYBrK/+7
         4d1nphl+qeKjVSxZJndaHsk9X76MATk4HdSQcd4RVUiNDUfUn8Th4yVudS5CEkvKLSU8
         N7RKWomlg9PPGkccJ1Y2+6IxNRn+xsqBjV9ikHyewkIt5e9YT714iVBC+0K0aKAO54De
         BZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yy6ZEDIC/vSWmlNd0ya7PCBbNMS89G0Qyrlws7DPuUE=;
        b=m/B41eWtlYOnqWqqcpYuzJpq5tvNjtPuV3KAn4aAde1aP5X47NIdBQjaz8bF3sls5q
         wYzpJ0UZTCbBB9rmnU3k5pCgDHcwYK5/QGFzuzY0pY4GjCI5PJWI5HDrT4JQSbsusMbD
         ZtsqiXJWjSwm4knWPGQw2WaIggu9BjR4gBQHQTS16e3n6LGjh9txvbYEY/HWHa68b3ZB
         7kidYzMSMw76bZoMsw+iBe4Xq758yhsTIenrf8+gqINf4R01O4VjLTjspI+wzlYAa4Gk
         C0ddQjPBQCCzJ5lILM276NpKudMGqXOt/VunFkEZBPSK7eHTE9THbJrkHb5c4mMhhSjz
         jukA==
X-Gm-Message-State: AOUpUlFnsEWgoAZawX7s/Xsb8i8OKP0MnChRaAL8/5D5d1K4l6J9rM/F
        Ep0+EV48MqHs/OGD6EL+qf89rqdq
X-Google-Smtp-Source: AAOMgpehFSow6Sn48/NOtSxR6SSBcJH3Hn0u+ZNMIxze2pNql35D7mfGbUAuJgqVdQYtvZ/AzCw0jQ==
X-Received: by 2002:a50:ba6e:: with SMTP id 43-v6mr25533929eds.292.1532557014812;
        Wed, 25 Jul 2018 15:16:54 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.113])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6808814edi.16.2018.07.25.15.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:16:54 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/10] staging:rtl8192u: Remove typedef of struct cmpk_txfb_t - Style
Date:   Wed, 25 Jul 2018 23:16:21 +0100
Message-Id: <20180725221630.28595-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725221630.28595-1-johnfwhitmore@gmail.com>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef of the structure cmpk_txfb_t. This clears the
checkpatch issue with defining new types. This change is purely
a coding style change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 8 ++++----
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index 80672100ea26..0e3fccd4a55c 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -66,7 +66,7 @@ rt_status SendTxCommandPacket(struct net_device *dev, void *pData, u32 DataLen)
  * Overview:
  *
  * Input:       PADAPTER	pAdapter
- *              CMPK_TXFB_T	*psTx_FB
+ *              STRUCT CMPK_TXFB_T	*psTx_FB
  *
  * Output:      NONE
  *
@@ -78,7 +78,7 @@ rt_status SendTxCommandPacket(struct net_device *dev, void *pData, u32 DataLen)
  *
  *---------------------------------------------------------------------------
  */
-static void cmpk_count_txstatistic(struct net_device *dev, cmpk_txfb_t *pstx_fb)
+static void cmpk_count_txstatistic(struct net_device *dev, struct cmpk_txfb_t *pstx_fb)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 #ifdef ENABLE_PS
@@ -163,7 +163,7 @@ static void cmpk_count_txstatistic(struct net_device *dev, cmpk_txfb_t *pstx_fb)
 static void cmpk_handle_tx_feedback(struct net_device *dev, u8 *pmsg)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
-	cmpk_txfb_t		rx_tx_fb;
+	struct cmpk_txfb_t rx_tx_fb;
 
 	priv->stats.txfeedback++;
 
@@ -173,7 +173,7 @@ static void cmpk_handle_tx_feedback(struct net_device *dev, u8 *pmsg)
 	 * endian type before copy the message copy.
 	 */
 	/* Use pointer to transfer structure memory. */
-	memcpy((u8 *)&rx_tx_fb, pmsg, sizeof(cmpk_txfb_t));
+	memcpy((u8 *)&rx_tx_fb, pmsg, sizeof(struct cmpk_txfb_t));
 	/* 2. Use tx feedback info to count TX statistics. */
 	cmpk_count_txstatistic(dev, &rx_tx_fb);
 	/* Comment previous method for TX statistic function. */
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index 85fb49ca7bc8..3f366e8317e6 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -2,7 +2,7 @@
 #ifndef R819XUSB_CMDPKT_H
 #define R819XUSB_CMDPKT_H
 /* Different command packet have dedicated message length and definition. */
-#define		CMPK_RX_TX_FB_SIZE		sizeof(cmpk_txfb_t)	/* 20 */
+#define		CMPK_RX_TX_FB_SIZE		sizeof(struct cmpk_txfb_t)	/* 20 */
 #define		CMPK_TX_SET_CONFIG_SIZE		sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_BOTH_QUERY_CONFIG_SIZE	sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_RX_TX_STS_SIZE		sizeof(cmpk_tx_status_t)
@@ -20,7 +20,7 @@
 /*------------------------------Define structure----------------------------*/
 /* Define different command packet structure. */
 /* 1. RX side: TX feedback packet. */
-typedef struct tag_cmd_pkt_tx_feedback {
+struct cmpk_txfb_t {
 	/* DWORD 0 */
 	u8	element_id;			/* Command packet type. */
 	u8	length;				/* Command packet length. */
@@ -53,7 +53,7 @@ typedef struct tag_cmd_pkt_tx_feedback {
 	/* DWORD 5 */
 	u16	reserve3;
 	u16	duration;
-} cmpk_txfb_t;
+};
 
 /* 2. RX side: Interrupt status packet. It includes Beacon State,
  * Beacon Timer Interrupt and other useful informations in MAC ISR Reg.
-- 
2.18.0

