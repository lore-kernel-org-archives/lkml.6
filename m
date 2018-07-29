Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E317C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF88020892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRB4feJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF88020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeG2WkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45104 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeG2WkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id f12-v6so680421wrv.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5cz0rr5ju+kARfOhhNqLn0JkWKaAk+splISZpg/rmw=;
        b=TRB4feJc8UKlJXMf0IbW6G/F0E3+/tzTGjbB6Etdydi/C8tKNKuFRm5FiL0HWKMuO3
         uEsjxwRF92DEuOAbiVeV+inFvsrmRTC73r3vKYW3vfP4EaRZEr5f597vPoP3lGsfGKQ4
         BXAI4qmlBb+wZhH3asCg5pS7XwBFr+yqHqwTNuOc68gydE46HaZlpzAriL5Lc7+okq8I
         2K3ExZLX6c3j9stjmJgkbuQymPuigcl1K9fFNvHSu/0K4WGg1jVjmjueBkzWkCzs9ogd
         pmt/PGASFe3I4JKBCK1i/Zu5+dv+nbF3wvlAVLnyDwSlloO+5R+IiUUod7yAWEOODYhW
         84Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5cz0rr5ju+kARfOhhNqLn0JkWKaAk+splISZpg/rmw=;
        b=B/Dymua7KanIhd1aHq3jMGZGrTmIZTGKXk6W2csn35Buz/zfO55vkGLhA5bhoECXJ+
         qhHpoyDUV+wk73z+zxDNXKyBgMq+shhX67mFYU5Rpz7fTX4B5nEb+abtul6YTyXZXtag
         FLOmGzAf5/MzJBlgNJZzVAeT0xbsdaUs8jjqf8RNocUoBhpw8o1vnSN62DkmC8HLPESH
         INEx8HjbE739zhaxELRSMHRBSRxQbHluQvmQ8IsB99Xg2qpaRY1PV/SiwShgYmDJfan0
         qdSf05S/rNdYf3wpbySvEZdoHK0G6azOdtNJM6oRL41dlIuQ8S6ylV68Bx7BpZCHxi/T
         tqEA==
X-Gm-Message-State: AOUpUlHMaVDvMQkJWtPf1yvgh+s7EgdIOZAykJhoSWTCTCMhJEMZlaFY
        dFp+fHUIui5lO3rAnq1DDgw6P4LQaTE=
X-Google-Smtp-Source: AAOMgpcSnbbhyucD0F5YbuS8ZthUdf58ng+9+3ZDm0sk8rcvBRgOSMXqkHl390J8EQw66MXt+J4Lyw==
X-Received: by 2002:adf:f64c:: with SMTP id x12-v6mr14034739wrp.97.1532898496488;
        Sun, 29 Jul 2018 14:08:16 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:15 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 01/15] staging:rtl8192u: Remove typedef of struct cmpk_txfb_t - Style
Date:   Sun, 29 Jul 2018 22:07:33 +0100
Message-Id: <20180729210747.10803-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef of the structure cmpk_txfb_t. This clears the
checkpatch issue with defining new types.

Additionally the type is renamed from cmpk_txfb_t to cmd_pkt_tx_feedback
removing the '_t' as the typedef has been removed.

These changes are purely coding style in nature and should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 8 ++++----
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index 3140b3413f91..630cf612f265 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -66,7 +66,7 @@ rt_status SendTxCommandPacket(struct net_device *dev, void *pData, u32 DataLen)
  * Overview:
  *
  * Input:       PADAPTER	pAdapter
- *              CMPK_TXFB_T	*psTx_FB
+ *              STRUCT CMD_PKT_TX_FEEDBACK	*psTx_FB
  *
  * Output:      NONE
  *
@@ -78,7 +78,7 @@ rt_status SendTxCommandPacket(struct net_device *dev, void *pData, u32 DataLen)
  *
  *---------------------------------------------------------------------------
  */
-static void cmpk_count_txstatistic(struct net_device *dev, cmpk_txfb_t *pstx_fb)
+static void cmpk_count_txstatistic(struct net_device *dev, struct cmd_pkt_tx_feedback *pstx_fb)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 #ifdef ENABLE_PS
@@ -163,7 +163,7 @@ static void cmpk_count_txstatistic(struct net_device *dev, cmpk_txfb_t *pstx_fb)
 static void cmpk_handle_tx_feedback(struct net_device *dev, u8 *pmsg)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
-	cmpk_txfb_t		rx_tx_fb;
+	struct cmd_pkt_tx_feedback rx_tx_fb;
 
 	priv->stats.txfeedback++;
 
@@ -173,7 +173,7 @@ static void cmpk_handle_tx_feedback(struct net_device *dev, u8 *pmsg)
 	 * endian type before copy the message copy.
 	 */
 	/* Use pointer to transfer structure memory. */
-	memcpy((u8 *)&rx_tx_fb, pmsg, sizeof(cmpk_txfb_t));
+	memcpy((u8 *)&rx_tx_fb, pmsg, sizeof(struct cmd_pkt_tx_feedback));
 	/* 2. Use tx feedback info to count TX statistics. */
 	cmpk_count_txstatistic(dev, &rx_tx_fb);
 	/* Comment previous method for TX statistic function. */
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index 0eb6b2321c9c..756e08bd341a 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -2,7 +2,7 @@
 #ifndef R819XUSB_CMDPKT_H
 #define R819XUSB_CMDPKT_H
 /* Different command packet have dedicated message length and definition. */
-#define		CMPK_RX_TX_FB_SIZE		sizeof(cmpk_txfb_t)	/* 20 */
+#define		CMPK_RX_TX_FB_SIZE		sizeof(struct cmd_pkt_tx_feedback)	/* 20 */
 #define		CMPK_TX_SET_CONFIG_SIZE		sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_BOTH_QUERY_CONFIG_SIZE	sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_RX_TX_STS_SIZE		sizeof(cmpk_tx_status_t)
@@ -19,7 +19,7 @@
 /*------------------------------Define structure----------------------------*/
 /* Define different command packet structure. */
 /* 1. RX side: TX feedback packet. */
-typedef struct tag_cmd_pkt_tx_feedback {
+struct cmd_pkt_tx_feedback {
 	/* DWORD 0 */
 	u8	element_id;			/* Command packet type. */
 	u8	length;				/* Command packet length. */
@@ -52,7 +52,7 @@ typedef struct tag_cmd_pkt_tx_feedback {
 	/* DWORD 5 */
 	u16	reserve3;
 	u16	duration;
-} cmpk_txfb_t;
+};
 
 /* 2. RX side: Interrupt status packet. It includes Beacon State,
  * Beacon Timer Interrupt and other useful informations in MAC ISR Reg.
-- 
2.18.0

