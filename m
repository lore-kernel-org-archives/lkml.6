Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8260BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B46020C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAPcfpX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B46020C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbeGKT2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:28:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33736 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbeGKT2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:28:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so16334694edr.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h1ykbo/3AcprZUHJ+uy0fBpKBSiCx/uIOOjDjQB5Euk=;
        b=mAPcfpX9G2SClHss9gNHuMVi2p+G7dPqZGxINfI40CRSDeK1/EPJWlUkACEbBHQ/gm
         2J+Decldf6I5q5naPxSr2PpY2ZUE45HQxvx6bZZ6aMJzFDwM6L3+QV6CP7cC8BbiqXUi
         IUb5jD8EqLBpcAU+KF58lkvX3WyIun0bkdXLv7RMi/fBGP+nEsPi3FGvf8Jaz8PSQq21
         x0ssALODjgyW5XAdnnQ5QjnH57WVhxofrbtYyR57HmQM2+qUAUqnfDzlHzn/7JVUKkBc
         lpjxr45TZx3HlmEUGVddkdnwZdPrAbxKPJDyXWwtx0yOJeEGxd2lPVCq3jtMjiBnW1RD
         gOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h1ykbo/3AcprZUHJ+uy0fBpKBSiCx/uIOOjDjQB5Euk=;
        b=WCQZxhvak0BI74cctwO1csQg5SCeYL0xrR5kE5sWrvW0tR0Uda/neDvxlYbGq1Roxk
         jJ6YWR0o+ywGUxngbI4q7A7bpAXdLMh19AyojNKGR3LvIlPzW+ckF5JKqke3/jy/6hfY
         YcieaMbL1IctntiO57gX6IQ9nRcg5WXte60RWfNHn5FB6rXt3wLq3qr64aMPoXGnUS9e
         01AH6bPEhGMfVnbXwmrBOxyxDaZqQoyADYLJzKrwMtf8tpPSuw+EOdWMsbtoibN0x7P+
         UapHmBvqKPPuQ0Sz03K6gBefGljmUfj7LADoJJ/IpceVBrYIXcdMbym5c+FkdRuH/oJ1
         QAfQ==
X-Gm-Message-State: APt69E1VNtztt86ylYFoXigy58gBbFgHTppJLNuRbUWe/KXGAJE7aCFF
        pkzUZgh81noTKh7mYgmrwrWD9coF
X-Google-Smtp-Source: AAOMgpeFdKe7aoOZfnuf7Q60dIr+JSTnID0YSM7g3DiRKQfL5/SLtWtbmKdBBvUmiyE/ynVUvJDUJQ==
X-Received: by 2002:a50:9a02:: with SMTP id o2-v6mr28291384edb.236.1531336945428;
        Wed, 11 Jul 2018 12:22:25 -0700 (PDT)
Received: from localhost.localdomain ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm7107787edc.37.2018.07.11.12.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:22:24 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/10] staging:rtl8192u: trim multiple blank lines - Coding Style
Date:   Wed, 11 Jul 2018 20:21:41 +0100
Message-Id: <20180711192149.21621-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711192149.21621-1-johnfwhitmore@gmail.com>
References: <20180711192149.21621-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trim the extra blank lines from the code, to clear checkpatch messages.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index fa451c6081ef..da23e7e9e3b9 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -59,7 +59,6 @@ extern u32 rt_global_debug_component;
 #define COMP_DBG                BIT(1)
 #define COMP_INIT               BIT(2)  /* Driver initialization/halt/reset. */
 
-
 #define COMP_RECV               BIT(3)  /* Receive data path. */
 #define COMP_SEND               BIT(4)  /* Send data path. */
 #define COMP_IO                 BIT(5)
@@ -127,7 +126,6 @@ extern u32 rt_global_debug_component;
 #define RT_DEBUG_DATA(level, data, datalen) do {} while (0)
 #endif /* RTL8169_DEBUG */
 
-
 /* Queue Select Value in TxDesc */
 #define QSLT_BK                                 0x1
 #define QSLT_BE                                 0x0
@@ -240,8 +238,6 @@ typedef struct _tx_desc_819x_usb_aggr_subframe {
 } tx_desc_819x_usb_aggr_subframe, *ptx_desc_819x_usb_aggr_subframe;
 #endif
 
-
-
 typedef struct _tx_desc_cmd_819x_usb {
 	/* DWORD 0 */
 	u16	Reserved0;
@@ -269,7 +265,6 @@ typedef struct _tx_desc_cmd_819x_usb {
 	u32	Reserved8;
 } tx_desc_cmd_819x_usb, *ptx_desc_cmd_819x_usb;
 
-
 typedef struct _tx_fwinfo_819x_usb {
 	/* DOWRD 0 */
 	u8	TxRate:7;
@@ -492,7 +487,6 @@ typedef struct _rt_firmware_info_819xUsb {
 
 #define		PHY_RSSI_SLID_WIN_MAX				100
 
-
 typedef enum _WIRELESS_MODE {
 	WIRELESS_MODE_UNKNOWN = 0x00,
 	WIRELESS_MODE_A = 0x01,
@@ -503,7 +497,6 @@ typedef enum _WIRELESS_MODE {
 	WIRELESS_MODE_N_5G = 0x20
 } WIRELESS_MODE;
 
-
 #define RTL_IOCTL_WPA_SUPPLICANT		(SIOCIWFIRSTPRIV + 30)
 
 typedef struct buffer {
@@ -523,11 +516,6 @@ typedef struct rtl_reg_debug {
 	unsigned char buf[0xff];
 } rtl_reg_debug;
 
-
-
-
-
-
 typedef struct _rt_9x_tx_rate_history {
 	u32             cck[4];
 	u32             ofdm[8];
@@ -642,13 +630,11 @@ typedef struct Stats {
 	u32	CurrentShowTxate;
 } Stats;
 
-
 /* Bandwidth Offset */
 #define HAL_PRIME_CHNL_OFFSET_DONT_CARE		0
 #define HAL_PRIME_CHNL_OFFSET_LOWER			1
 #define HAL_PRIME_CHNL_OFFSET_UPPER			2
 
-
 typedef struct	ChnlAccessSetting {
 	u16 SIFS_Timer;
 	u16 DIFS_Timer;
@@ -757,7 +743,6 @@ typedef struct _ccktxbbgain_struct {
 	u8	ccktxbb_valuearray[8];
 } ccktxbbgain_struct, *pccktxbbgain_struct;
 
-
 typedef struct _init_gain {
 	u8				xaagccore1;
 	u8				xbagccore1;
@@ -793,7 +778,6 @@ typedef struct _phy_cck_rx_status_report_819xusb {
 	u8	cck_agc_rpt;
 } phy_sts_cck_819xusb_t;
 
-
 struct phy_ofdm_rx_status_rxsc_sgien_exintfflag {
 	u8			reserved:4;
 	u8			rxsc:2;
@@ -885,7 +869,6 @@ typedef struct r8192_priv {
 	short sens;
 	short max_sens;
 
-
 	short up;
 	/* If 1, allow bad crc frame, reception in monitor mode */
 	short crcmon;
@@ -924,7 +907,6 @@ typedef struct r8192_priv {
 	short  tx_urb_index;
 	atomic_t tx_pending[0x10]; /* UART_PRIORITY + 1 */
 
-
 	struct tasklet_struct irq_rx_tasklet;
 	struct urb *rxurb_task;
 
@@ -937,7 +919,6 @@ typedef struct r8192_priv {
 	u32     LastRxDescTSFHigh;
 	u32     LastRxDescTSFLow;
 
-
 	/* Rx Related variables */
 	u16	EarlyRxThreshold;
 	u32	ReceiveConfig;
@@ -1172,5 +1153,4 @@ void rtl819xusb_beacon_tx(struct net_device *dev, u16 tx_rate);
 void EnableHWSecurityConfig8192(struct net_device *dev);
 void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType, u8 *MacAddr, u8 DefaultKey, u32 *KeyContent);
 
-
 #endif
-- 
2.18.0

