Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A28DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F6B2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7jlE85x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F6B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390281AbeGKT2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:28:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46876 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389422AbeGKT2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:28:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id r17-v6so20005964edo.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uN8/41XA4vgvRAQyje6VSwgXwP2gNesvu3HOFMqQ7ic=;
        b=S7jlE85xaj5xeLaY3WHFBxMr4L/TkcIDXnkEitbBawHdTYwR3+exCHuLrmIfNYYrdF
         tsE596MNEerQRQMA7EDHbQpI02whyzuEud4VABk1ZlLZBpyZmsR3oNvGl7+dRjwpk/Hd
         UNGWKmyTkCMGs7d9Aq72lhpr1uATjf/Frh7jLWT472QTcA35jsdx29kvzXkwV13+/p/O
         dpQ6z0ZGuJdT1iA3+rBUmKH8QNYoxF7iVFuKr43BjS4EniM2dyPOq9NJTb+s6vRmGsnh
         vvSIUEf3jPWzGL3N4MDoiSK3gGYEMl+tU3nu+DPstpudA+B9aBtqjg2vdH3/ETZwikSy
         U9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uN8/41XA4vgvRAQyje6VSwgXwP2gNesvu3HOFMqQ7ic=;
        b=mYt32Ve1PJSnsGNx1HdNDzL1tYhB+iJhABy5MsaiTuR5a9ZhJfJmikwsn5g+LCsZ+9
         YyVY79JD6a6yn1aTFCb6z7JEqkdvVko2JeFf5UqAcITVOn1ty3nr6aTUKQLSi3Q/A+dW
         SddFetSiUM0rjfCB1aD8KDWt/M4ZCl+VBwuZFmaJeCfHS6PHQKCL9XXlX5GqQ5Q+4gKb
         o7YUUH1y0SiU7VpNNWSRJb0kWrYnzVAb6LkwR0pNpxGbwt9N1pSrFlgcOTRZeXX6vJZL
         xatHwISfxmc4yfC1rfMLWxxAnprQqcrMh0N+WldChemb0aMAy+3yiOhZKFeBVpQVhsfc
         +2hQ==
X-Gm-Message-State: APt69E1ynSCA0WRqxTTn715gD39qPwlBB/r8A8WZ0wsx+dxmR2uXnNOf
        8fOMspcRnqaU0J8tsdRx4oVk+xN6
X-Google-Smtp-Source: AAOMgpeCqIT2NjQrHg2UCc/APWlm1EWQA1h8O8OxoUZacJdfo2pVaRMhgOBrX5qofXWLs+BqSbrqDw==
X-Received: by 2002:a50:b807:: with SMTP id j7-v6mr32075478ede.206.1531336953460;
        Wed, 11 Jul 2018 12:22:33 -0700 (PDT)
Received: from localhost.localdomain ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm7107787edc.37.2018.07.11.12.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:22:32 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/10] staging:rtl8192u: typedef struct rx_desc_819x_usb remove typedef
Date:   Wed, 11 Jul 2018 20:21:46 +0100
Message-Id: <20180711192149.21621-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711192149.21621-1-johnfwhitmore@gmail.com>
References: <20180711192149.21621-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change structure rx_desc_819x_usb from being typedef to being a simple
structure, without the typedef.

Clears a checkpatch issue, definging new types in the code.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      |  4 ++--
 drivers/staging/rtl8192u/r8192U_core.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index d9dbd3ca3dac..d7f090c1bb44 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -279,7 +279,7 @@ struct rtl8192_rx_info {
 	u8 out_pipe;
 };
 
-typedef struct rx_desc_819x_usb {
+struct rx_desc_819x_usb {
 	/* DOWRD 0 */
 	u16                 Length:14;
 	u16                 CRC32:1;
@@ -292,7 +292,7 @@ typedef struct rx_desc_819x_usb {
 
 	/* DWORD 1 */
 	u32                 Reserved2;
-} rx_desc_819x_usb, *prx_desc_819x_usb;
+};
 
 #ifdef USB_RX_AGGREGATION_SUPPORT
 typedef struct _rx_desc_819x_usb_aggr_subframe {
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 75bbcc115141..655aae06f8a4 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -739,7 +739,7 @@ static void rtl8192_rx_isr(struct urb *urb);
 
 static u32 get_rxpacket_shiftbytes_819xusb(struct ieee80211_rx_stats *pstats)
 {
-	return (sizeof(rx_desc_819x_usb) + pstats->RxDrvInfoSize
+	return (sizeof(struct rx_desc_819x_usb) + pstats->RxDrvInfoSize
 		+ pstats->RxBufShift);
 }
 
@@ -4633,7 +4633,7 @@ static void query_rxdesc_status(struct sk_buff *skb,
 	rx_drvinfo_819x_usb  *driver_info = NULL;
 
 	/* Get Rx Descriptor Information */
-	rx_desc_819x_usb *desc = (rx_desc_819x_usb *)skb->data;
+	struct rx_desc_819x_usb *desc = (struct rx_desc_819x_usb *)skb->data;
 
 	stats->Length = desc->Length;
 	stats->RxDrvInfoSize = desc->RxDrvInfoSize;
@@ -4659,7 +4659,7 @@ static void query_rxdesc_status(struct sk_buff *skb,
 	if (stats->RxDrvInfoSize != 0) {
 		driver_info = (rx_drvinfo_819x_usb *)(
 				skb->data
-				+ sizeof(rx_desc_819x_usb)
+				+ sizeof(struct rx_desc_819x_usb)
 				+ stats->RxBufShift
 			      );
 		/* unit: 0.5M */
@@ -4704,7 +4704,7 @@ static void query_rxdesc_status(struct sk_buff *skb,
 				 driver_info->FirstAGGR, driver_info->PartAggr);
 	}
 
-	skb_pull(skb, sizeof(rx_desc_819x_usb));
+	skb_pull(skb, sizeof(struct rx_desc_819x_usb));
 	/* Get Total offset of MPDU Frame Body */
 	if ((stats->RxBufShift + stats->RxDrvInfoSize) > 0) {
 		stats->bShift = 1;
@@ -4733,7 +4733,7 @@ static void rtl8192_rx_nomal(struct sk_buff *skb)
 	bool unicast_packet = false;
 
 	/* 20 is for ps-poll */
-	if ((skb->len >= (20 + sizeof(rx_desc_819x_usb))) && (skb->len < RX_URB_SIZE)) {
+	if ((skb->len >= (20 + sizeof(struct rx_desc_819x_usb))) && (skb->len < RX_URB_SIZE)) {
 		/* first packet should not contain Rx aggregation header */
 		query_rxdesc_status(skb, &stats, false);
 		/* TODO */
@@ -4809,7 +4809,7 @@ static void rtl819xusb_process_received_packet(
 static void query_rx_cmdpkt_desc_status(struct sk_buff *skb,
 					struct ieee80211_rx_stats *stats)
 {
-	rx_desc_819x_usb *desc = (rx_desc_819x_usb *)skb->data;
+	struct rx_desc_819x_usb *desc = (struct rx_desc_819x_usb *)skb->data;
 
 	/* Get Rx Descriptor Information */
 	stats->virtual_address = (u8 *)skb->data;
@@ -4835,7 +4835,7 @@ static void rtl8192_rx_cmd(struct sk_buff *skb)
 		.freq = IEEE80211_24GHZ_BAND,
 	};
 
-	if ((skb->len >= (20 + sizeof(rx_desc_819x_usb))) && (skb->len < RX_URB_SIZE)) {
+	if ((skb->len >= (20 + sizeof(struct rx_desc_819x_usb))) && (skb->len < RX_URB_SIZE)) {
 		query_rx_cmdpkt_desc_status(skb, &stats);
 		/* prfd->queue_id = 1; */
 
-- 
2.18.0

