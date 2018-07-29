Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAD5137663B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FAF20894
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4/0zbdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FAF20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeG2Whg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:37:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43667 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731466AbeG2Whf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:37:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so10585507wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5cz0rr5ju+kARfOhhNqLn0JkWKaAk+splISZpg/rmw=;
        b=A4/0zbdAKAg2llbO0RGcfbAMxTuG/3oPbRYAefp2mtclxusVB0hodxOCAbCPhqNQmi
         q3W2zwdaM+H8IRZh43QyKvRkYnrwA4J0K3IDl4ddHLNSFLeZTTgStvPEFZuT/yhnSDjn
         szB5TtqQKCmol6F+9FBX4faAsLFNLYSLj9INKfgY3n8PUN8jfAaB69on3HZWZOJgg8Zd
         pQ+jeyhYlx6aux8bVKvm7YT55SRlGungIRjXMtJz1tYRuPhOSKWQtxrptdnnd7rSRgeO
         PFX9zQcgRSzju5yS5+0B86ACTtdSEfzFkC0TNJ6DxHwB2vQ3lnTLRs7tXz3Gf5kZogm9
         a3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5cz0rr5ju+kARfOhhNqLn0JkWKaAk+splISZpg/rmw=;
        b=a6pu8cMty9ZTDbgGPQ/tFdLXGq6iAyR48F99MsJrs+12BThh7C7FEC5s86HaHAQc5d
         xiWlsXMGV/TqJ06WjIXaSzbaMNaihAwFHNsJiKm0d4I5Y8+vSn4n31ZA80NX8rbXiOFa
         bQXkNE8PcXlXi2uQVeWcio5tduXGQqKitCl2HXABkwE9QuimvEOm5JCa3UdLnHDW1SVI
         rQK08ZfJ0N6u4yv94SRAfHgoItfJ2/B2uMBIVlibaOHZLmf1mqXkYLhntlPtdqk8eT5J
         0jF6HG+EX42FLllV1n1xAsY0lnFAAgV8XhKNxK7rPhN/4kjo1RYY/nmXX0Mx6SB3z0b0
         +qUw==
X-Gm-Message-State: AOUpUlEpvVhMXgda63qdvI2JB6bmiIj3JMiSfCyqLRPRnGa9lfZqCPN8
        BIUv3anlm9tDdTdfoS1/7UIfdAdHnjA=
X-Google-Smtp-Source: AAOMgpcPdLS1U0xs8ENpvzrxB71r+e4faZJroBszKjcEXcuZnuKZG+f7EcRY5wZEQkcNrC011IjZGA==
X-Received: by 2002:a5d:5088:: with SMTP id a8-v6mr14982203wrt.37.1532898344891;
        Sun, 29 Jul 2018 14:05:44 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id l19-v6sm10476876wmc.3.2018.07.29.14.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:05:44 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 01/15] staging:rtl8192u: Remove typedef of struct cmpk_txfb_t - Style
Date:   Sun, 29 Jul 2018 22:05:13 +0100
Message-Id: <20180729210534.10617-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210534.10617-1-johnfwhitmore@gmail.com>
References: <20180729210534.10617-1-johnfwhitmore@gmail.com>
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

