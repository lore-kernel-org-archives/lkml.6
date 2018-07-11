Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0054AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27062087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoiWyaLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27062087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbeGKT2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:28:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44169 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390199AbeGKT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:28:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id d17-v6so7925014eds.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TWDbphGDBJ32HJtYC2baVDy0Hwg+hYFU7hO3/L+HpFA=;
        b=ZoiWyaLZHnxcFmrAhEyWSDHNAQjzm2Smq/C/jpnu2cRJljky3JLNkiRfbDrM/RR5xt
         kA35Y8uv6CCbcVpTLbGRk07rqJP9hdI7Q7wa0mTdl4dZYZVfKYXd2CduFuAGVVuGLb0/
         rTxLBevidLWIqpk4ZFIb4v9JzS/Zbdo9YZr643Ag1f2J08MdHAkgtdOIC+i2TUL0NoyN
         66qB0bc7SbyQVmeoE/VZO0kBEN7FK8YOryzvhegz0pmOYQowQphEYisH5i9EVgUOSN6J
         OuwAdUA+W2ULi9J2of/eEXpnzORUAgWjuK7RBWaCDASv0rJrJeVxS3RU7B9x/ZcJXBZw
         H4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TWDbphGDBJ32HJtYC2baVDy0Hwg+hYFU7hO3/L+HpFA=;
        b=dqUFH/j+S3v1sbc02QrbqnYHP+XhSK9mIA1fjyTBJLHYtkVb/czupmfPGGDe+mdjl+
         dcipmbYWGnsjmL3BzYUlWM57xHHiTW0DF/fWHS8MMo3fvz861ZaUoFhzXsIVazML66Iw
         bv1GqKvOuSQR7CQQc5pQ/NNJxHaTOcOqQkD6m6NuLRb8rHWTA8mmgn35EIqLdDjL4dKu
         4YK0TGOrn5nj3AMkPttDCTwbJf4h1LYj+a4byRzP4LQMIBTvB3gRscx+QB9bQEZ/FsFu
         Hk7rKoXEFeN6bSEVjd4UZqY6m9UHnz3Stjutmi8hARX24BmI3cGeuv4jhDAtTKmY7Lj7
         rMGg==
X-Gm-Message-State: APt69E17YGYTWp3Q4J/nWyj80xJ26J6Wv1Bc0gVea4am/ba+SnojZXZG
        u+R5aThgwr/Ur42UFsdS49eTlbWD
X-Google-Smtp-Source: AAOMgpflohN2w7AdpiLJtpoee/nHES1Jvcf+AW/mnYozRuRsswUa+dMqM0ujnTBFzD0S0/PQnPRxAg==
X-Received: by 2002:a50:b2c6:: with SMTP id p64-v6mr32702561edd.293.1531336956666;
        Wed, 11 Jul 2018 12:22:36 -0700 (PDT)
Received: from localhost.localdomain ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm7107787edc.37.2018.07.11.12.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:22:35 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/10] staging:rtl8192u: remove typedef from struct rx_drvinfo_819x_usb
Date:   Wed, 11 Jul 2018 20:21:48 +0100
Message-Id: <20180711192149.21621-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711192149.21621-1-johnfwhitmore@gmail.com>
References: <20180711192149.21621-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the typedef from the struct rx_drvinfo_819x_usb  to leave it as a
simple structure.

This clears the issue flagged by checkpatch, defining new types.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      |  4 ++--
 drivers/staging/rtl8192u/r8192U_core.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index c8a23a831d51..83bc4cef5b17 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -294,7 +294,7 @@ struct rx_desc_819x_usb {
 	u32                 Reserved2;
 };
 
-typedef struct rx_drvinfo_819x_usb {
+struct rx_drvinfo_819x_usb {
 	/* DWORD 0 */
 	u16                 Reserved1:12;
 	u16                 PartAggr:1;
@@ -315,7 +315,7 @@ typedef struct rx_drvinfo_819x_usb {
 	/* DWORD 1 */
 	u32                  TSFL;
 
-} rx_drvinfo_819x_usb, *prx_drvinfo_819x_usb;
+};
 
 /* Support till 64 bit bus width OS */
 #define MAX_DEV_ADDR_SIZE		8
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 655aae06f8a4..c01e8d76a265 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4194,7 +4194,7 @@ static inline bool rx_hal_is_cck_rate(struct rx_drvinfo_819x_usb *pdrvinfo)
 
 static void rtl8192_query_rxphystatus(struct r8192_priv *priv,
 				      struct ieee80211_rx_stats *pstats,
-				      rx_drvinfo_819x_usb  *pdrvinfo,
+				      struct rx_drvinfo_819x_usb  *pdrvinfo,
 				      struct ieee80211_rx_stats *precord_stats,
 				      bool bpacket_match_bssid,
 				      bool bpacket_toself,
@@ -4231,7 +4231,7 @@ static void rtl8192_query_rxphystatus(struct r8192_priv *priv,
 	prxpkt = (u8 *)pdrvinfo;
 
 	/* Move pointer to the 16th bytes. Phy status start address. */
-	prxpkt += sizeof(rx_drvinfo_819x_usb);
+	prxpkt += sizeof(struct rx_drvinfo_819x_usb);
 
 	/* Initial the cck and ofdm buffer pointer */
 	pcck_buf = (phy_sts_cck_819xusb_t *)prxpkt;
@@ -4431,7 +4431,7 @@ static void rtl8192_record_rxdesc_forlateruse(
 
 static void TranslateRxSignalStuff819xUsb(struct sk_buff *skb,
 					  struct ieee80211_rx_stats *pstats,
-					  rx_drvinfo_819x_usb  *pdrvinfo)
+					  struct rx_drvinfo_819x_usb  *pdrvinfo)
 {
 	/* TODO: We must only check packet for current MAC address.
 	 * Not finish
@@ -4630,7 +4630,7 @@ static void query_rxdesc_status(struct sk_buff *skb,
 	struct rtl8192_rx_info *info = (struct rtl8192_rx_info *)skb->cb;
 	struct net_device *dev = info->dev;
 	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
-	rx_drvinfo_819x_usb  *driver_info = NULL;
+	struct rx_drvinfo_819x_usb  *driver_info = NULL;
 
 	/* Get Rx Descriptor Information */
 	struct rx_desc_819x_usb *desc = (struct rx_desc_819x_usb *)skb->data;
@@ -4657,7 +4657,7 @@ static void query_rxdesc_status(struct sk_buff *skb,
 	 * Driver info are written to the RxBuffer following rx desc
 	 */
 	if (stats->RxDrvInfoSize != 0) {
-		driver_info = (rx_drvinfo_819x_usb *)(
+		driver_info = (struct rx_drvinfo_819x_usb *)(
 				skb->data
 				+ sizeof(struct rx_desc_819x_usb)
 				+ stats->RxBufShift
-- 
2.18.0

