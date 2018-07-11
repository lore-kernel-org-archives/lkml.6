Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21C4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959992087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3yym/PN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959992087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389703AbeGKT2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:28:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39338 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732685AbeGKT2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:28:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id w14-v6so20010490eds.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJL2SNHte90ui3fHQGwylEg8KhhDOv3V+QilNCLbGi8=;
        b=c3yym/PNmvpNxeCNFSopdtKepGFqsoKS3wd0jfUs+/QgoGxHMRkEAAjd4NX9UKJk45
         ISaxDmaMWamL0Jk3za67FB7cCK5FIGVgTZm009RPnXFCLYIl3xx5hFFP3mFEzazRcDkU
         dV2D8DB23sNkKiHjBr0UktESCOeoznIJhmkJnu7tWXiN/R+0NoOeb7ufoxhl8IlpOvei
         ALkeQGb7lzAc2KHUlvOM7ToMtB/4/PwngqXU20KlkClPQK7gOem/4V/pHCbLl5TjS9Oa
         IBQidm68oVt0JYJfUEE/QUcpf4lo61EnTTwPbsxXRFFsDkVFc/FTFUXrOtg0puASUoXw
         7SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJL2SNHte90ui3fHQGwylEg8KhhDOv3V+QilNCLbGi8=;
        b=K682vBYJCVQkC6oid+vgewcfdrZH8pVPAEoMcab9DXJWs3EltTfKewc28TEKYRyfbX
         2YK4RS8rotOO9QIo5bHx57rfeErwaXnwzHnm4TORW2jX++vghQjBxz3BYX8WM7MORPpM
         VWS/k0YN7h4TRZX73dYiQJSB6GbqrMZJEUWiLqpxV2J+PfMtpRjUDCDBpS4dp5/9rwzb
         1qy33nNMfNyYqampwS4fBXOz+voXDLI5wt5BZLu8A4816DwT89CO6PrNQH8u8bL4vYuv
         Jbu5skrae1tKya20QhQU/EgTGEVOkEylkCNmr1rvE2SCG4TjEpWrn2WaHMymk9AEBGnM
         jihg==
X-Gm-Message-State: APt69E02u4b4GtNF8jhQT5cURMQkSfRrUWuMtnOHt3VO0C05TgdM+giN
        JGtyGS47UzcBai/TVE394n3dPUzW
X-Google-Smtp-Source: AAOMgpdE6MwRAeXnvbPS6WnmW5+Qh+1hVsm33o4jRkLTQYI0vK6CBTWXACVJLkJNhyxmtWJCcTbwgg==
X-Received: by 2002:a50:9704:: with SMTP id c4-v6mr31771700edb.246.1531336943786;
        Wed, 11 Jul 2018 12:22:23 -0700 (PDT)
Received: from localhost.localdomain ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm7107787edc.37.2018.07.11.12.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:22:23 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/10] staging:rtl8192u: typedef struct tx_desc_819x_usb > struct tx_desc_819x_usb
Date:   Wed, 11 Jul 2018 20:21:40 +0100
Message-Id: <20180711192149.21621-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711192149.21621-1-johnfwhitmore@gmail.com>
References: <20180711192149.21621-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change structure tx_desc_819x_usb from being typedef to being a simple
structure, without the typedef.

checkpatch warns about defining new types in code.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 6 +++---
 drivers/staging/rtl8192u/r8192U_core.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 37aa36126d19..fa451c6081ef 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -177,7 +177,7 @@ extern u32 rt_global_debug_component;
 #define	CCK_Table_length	12
 
 /* For rtl819x */
-typedef struct _tx_desc_819x_usb {
+struct tx_desc_819x_usb {
 	/* DWORD 0 */
 	u16	PktSize;
 	u8	Offset;
@@ -213,7 +213,7 @@ typedef struct _tx_desc_819x_usb {
 	u32	Reserved5;
 	u32	Reserved6;
 	u32	Reserved7;
-} tx_desc_819x_usb, *ptx_desc_819x_usb;
+};
 
 #ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
 typedef struct _tx_desc_819x_usb_aggr_subframe {
@@ -371,7 +371,7 @@ typedef struct rx_drvinfo_819x_usb {
 #define MAX_FIRMWARE_INFORMATION_SIZE   32
 #define MAX_802_11_HEADER_LENGTH        (40 + MAX_FIRMWARE_INFORMATION_SIZE)
 #define ENCRYPTION_MAX_OVERHEAD		128
-#define	USB_HWDESC_HEADER_LEN		sizeof(tx_desc_819x_usb)
+#define	USB_HWDESC_HEADER_LEN		sizeof(struct tx_desc_819x_usb)
 #define TX_PACKET_SHIFT_BYTES		(USB_HWDESC_HEADER_LEN + sizeof(tx_fwinfo_819x_usb))
 #define MAX_FRAGMENT_COUNT		8
 #ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 848239e24859..a2a107521450 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1462,7 +1462,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
-	tx_desc_819x_usb *tx_desc = (tx_desc_819x_usb *)skb->data;
+	struct tx_desc_819x_usb *tx_desc = (struct tx_desc_819x_usb *)skb->data;
 	tx_fwinfo_819x_usb *tx_fwinfo =
 		(tx_fwinfo_819x_usb *)(skb->data + USB_HWDESC_HEADER_LEN);
 	struct usb_device *udev = priv->udev;
@@ -1535,7 +1535,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	/* Fill Tx descriptor */
-	memset(tx_desc, 0, sizeof(tx_desc_819x_usb));
+	memset(tx_desc, 0, sizeof(struct tx_desc_819x_usb));
 	/* DWORD 0 */
 	tx_desc->LINIP = 0;
 	tx_desc->CmdInit = 1;
-- 
2.18.0

