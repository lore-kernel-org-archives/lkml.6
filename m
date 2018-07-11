Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C383C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C0520C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwD9Kc/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C0520C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390223AbeGKT2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:28:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34520 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732685AbeGKT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:28:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id d3-v6so20031266edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VDhS37ry9nfsg2/BKwpV2swNHIZ12rnvAu2JvKXDHkI=;
        b=TwD9Kc/TfqaufscU6u4/QwYxB7qGNegiTgxChshWfTsTj0I1zkhMf5o9+YMt2ly80g
         EdPpJ5YHq2ehf0dClTCaTbw7QEE26xKNPZTJVm/J0MV6min2VaenHEnrh9GkHqznp9MY
         zVw5lkhmGzqImXuBZxnMjJVbJdxigZGllLnF/nkRvrcduWANzE6PHZBGPkIA1Dtioolr
         cDzlM2AlXfm5Relntnsg4hrbqv19ljJhceX2fW9OdeaUr24Zq2y9yIA7Bbwt0PNA1oXw
         YKF+qebHhnVO8B3gIypuMEVDw/oyIJCUBkCtJ+tzy6D0RZB0mBj3YK/Bvg1ynQo6+O5l
         OoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VDhS37ry9nfsg2/BKwpV2swNHIZ12rnvAu2JvKXDHkI=;
        b=tNFIjNsSvPPDOKF4X+n4yxov2calbaWxYg/MvxbLrBcMiWAZ0iLIR16BFc4BtGZIFq
         e32Fl1ERMz2BLaYw5dymsFoeqhmUnHQswKNt6pO6qOklNouaH3qd1vgX9rVDsmKEXehP
         wHugNAzdk3evUATlfNAFeVNXia9WBfJsGm1dijigae7xUoSf7ZyCeu53ReXAMjYjrnI+
         +enUSqLlIRljaiUOhVa3jdWl6Xs+w1XySjsADwKMo9q725jf+PNJIZkbKilJC7beDuwE
         BzDtif4DZgBB3Ck5P8KshXTwuCEJNci40Gwsv5mZW329G3sZLAOaRz71J4g7Fsqkungh
         iBlw==
X-Gm-Message-State: APt69E19FqOWRck6RbLFWZhr4FA3Lnjl3i9/D3q2c0XtGVDOFxf2e8BG
        9EKlTLKTf7KjA2uR73bCERp73wus
X-Google-Smtp-Source: AAOMgpfdVVVOspdm5naAHlx8LrGsSJwMOWaI9GTf7yy4gCbF4nZ7RPbDq/NxhQJ2LqswbXrLmRR8eQ==
X-Received: by 2002:a50:94c4:: with SMTP id t4-v6mr31911321eda.128.1531336951775;
        Wed, 11 Jul 2018 12:22:31 -0700 (PDT)
Received: from localhost.localdomain ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm7107787edc.37.2018.07.11.12.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:22:31 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/10] staging:rtl8192u: typedef struct tx_fwinfo_819x_usb remove typedef
Date:   Wed, 11 Jul 2018 20:21:45 +0100
Message-Id: <20180711192149.21621-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711192149.21621-1-johnfwhitmore@gmail.com>
References: <20180711192149.21621-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change structure tx_fwinfo_819x_usb from being typedef to being a simple
structure, without the typedef.

Clears the coding style issue flagged by checkpatch, (new type definitions)

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      |  6 +++---
 drivers/staging/rtl8192u/r8192U_core.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 7dd99612620a..d9dbd3ca3dac 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -240,7 +240,7 @@ struct tx_desc_cmd_819x_usb {
 	u32	Reserved8;
 };
 
-typedef struct _tx_fwinfo_819x_usb {
+struct tx_fwinfo_819x_usb {
 	/* DOWRD 0 */
 	u8	TxRate:7;
 	u8	CtsEnable:1;
@@ -271,7 +271,7 @@ typedef struct _tx_fwinfo_819x_usb {
 	u32	TxAGCSign:1;
 	u32	Tx_INFO_RSVD:6;
 	u32	PacketID:13;
-} tx_fwinfo_819x_usb, *ptx_fwinfo_819x_usb;
+};
 
 struct rtl8192_rx_info {
 	struct urb *urb;
@@ -342,7 +342,7 @@ typedef struct rx_drvinfo_819x_usb {
 #define MAX_802_11_HEADER_LENGTH        (40 + MAX_FIRMWARE_INFORMATION_SIZE)
 #define ENCRYPTION_MAX_OVERHEAD		128
 #define	USB_HWDESC_HEADER_LEN		sizeof(struct tx_desc_819x_usb)
-#define TX_PACKET_SHIFT_BYTES		(USB_HWDESC_HEADER_LEN + sizeof(tx_fwinfo_819x_usb))
+#define TX_PACKET_SHIFT_BYTES		(USB_HWDESC_HEADER_LEN + sizeof(struct tx_fwinfo_819x_usb))
 #define MAX_FRAGMENT_COUNT		8
 #ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
 #define MAX_TRANSMIT_BUFFER_SIZE			32000
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index d7fa7ece62fb..75bbcc115141 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1463,8 +1463,8 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
 	struct tx_desc_819x_usb *tx_desc = (struct tx_desc_819x_usb *)skb->data;
-	tx_fwinfo_819x_usb *tx_fwinfo =
-		(tx_fwinfo_819x_usb *)(skb->data + USB_HWDESC_HEADER_LEN);
+	struct tx_fwinfo_819x_usb *tx_fwinfo =
+		(struct tx_fwinfo_819x_usb *)(skb->data + USB_HWDESC_HEADER_LEN);
 	struct usb_device *udev = priv->udev;
 	int pend;
 	int status;
@@ -1489,7 +1489,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	/* Fill Tx firmware info */
-	memset(tx_fwinfo, 0, sizeof(tx_fwinfo_819x_usb));
+	memset(tx_fwinfo, 0, sizeof(struct tx_fwinfo_819x_usb));
 	/* DWORD 0 */
 	tx_fwinfo->TxHT = (tcb_desc->data_rate & 0x80) ? 1 : 0;
 	tx_fwinfo->TxRate = MRateToHwRate8190Pci(tcb_desc->data_rate);
@@ -1539,7 +1539,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	/* DWORD 0 */
 	tx_desc->LINIP = 0;
 	tx_desc->CmdInit = 1;
-	tx_desc->Offset =  sizeof(tx_fwinfo_819x_usb) + 8;
+	tx_desc->Offset =  sizeof(struct tx_fwinfo_819x_usb) + 8;
 	tx_desc->PktSize = (skb->len - TX_PACKET_SHIFT_BYTES) & 0xffff;
 
 	/*DWORD 1*/
@@ -1570,7 +1570,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	tx_desc->QueueSelect = MapHwQueueToFirmwareQueue(tcb_desc->queue_index);
-	tx_desc->TxFWInfoSize =  sizeof(tx_fwinfo_819x_usb);
+	tx_desc->TxFWInfoSize =  sizeof(struct tx_fwinfo_819x_usb);
 
 	tx_desc->DISFB = tcb_desc->bTxDisableRateFallBack;
 	tx_desc->USERATE = tcb_desc->bTxUseDriverAssingedRate;
-- 
2.18.0

