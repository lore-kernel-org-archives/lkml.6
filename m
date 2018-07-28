Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02B2C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E3A20893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIbqv2fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E3A20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeG2AbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:31:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37560 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbeG2AbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:31:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so8696542wrd.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48ZzOtNbhn/IsYIwefHOSQm85U1tNjkP07tK7Mq0MOY=;
        b=oIbqv2fRshTg6LtmKQgs1AiiG7dZjukkS0xNXcXcYxYoxGP8ppKrOZLJGEOOfc7Rb9
         W8JpvmIUNRIelshCp0YOSpu1AIrZ/KqwZdo99IiNRek5y8529KN2dIwtyadxpRH0dmDj
         y/zCzSpyDWuwucxhFddnHdGYuNQeXyUTdtrO4WLjbEvjUcgg8Ls1HpLTboI4IgUVFa0M
         xsXGTuT58cy+1TdmygRsf9YRN4uYN3mDWty2EdVyURah7fW2mU1gLPDEtcDz0gwmx/Ue
         zavcp7IW1XK3mh42wHyuFPYj+6LUKpfXw0eFa+xWDnIfSjU0xLd3INvrE/TS2c9r1EIQ
         2BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48ZzOtNbhn/IsYIwefHOSQm85U1tNjkP07tK7Mq0MOY=;
        b=f4Z3/miebZJn9ZGDSmnelPv6xhmNJ07B/GYiO/g8xYVsGwmpPmSKwz0MUEQBKN07b2
         /dZILIfv1ZEyTuRiuZhULRdHINEg5smfpHZZMhtiZH12JeS7fbdpPNdVT2JwAuVwtyYL
         EB1Duer5jJy/3B+ot3fLhtu+u5ns5DrBN0blk00bv5xMEdhW3k7h0VBeBwyaxs8f82l5
         AsAHWixEH/5tAy8Q3iSDvrTc5JlCeHJjHwNd/zr1Fs2Az3uALhuKkXs6RZVFNbiosuHg
         f1w8y/gglJOQkrlXJVnUVXl/dRUpVNsRWUgQmkLOZJAjSF5XFQCLNEOTryGC0he4y1bH
         i24Q==
X-Gm-Message-State: AOUpUlFWAUh3I8u9j8/EsPWljRYVW6Qs7H6IDHNO3JLFVf0Qu/RbTEaZ
        zipjNnREgSOHFt9t9dLNWijxhcaz
X-Google-Smtp-Source: AAOMgpcNPF3hjzfXZDBJxZW4aHHtLkNo2P04AzB28ZcstnHPNVjj0XUer/ZAqQfpOXIjND54YTBOeQ==
X-Received: by 2002:a5d:44c6:: with SMTP id z6-v6mr10778842wrr.236.1532818994047;
        Sat, 28 Jul 2018 16:03:14 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m207-v6sm11490569wma.31.2018.07.28.16.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:03:13 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/12] staging:rtl8192u: Rename enum DIRECTION_VALUE - Style
Date:   Sun, 29 Jul 2018 00:02:58 +0100
Message-Id: <20180728230300.19732-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728230300.19732-1-johnfwhitmore@gmail.com>
References: <20180728230300.19732-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type DIRECTION_VALUE should be named in lowercase to
comply with coding standard so is renamed to direction_value. In
addition the 'typedef' directive has been removed to clear the
checkpatch issue with defining new types.

These changes are coding style changes which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h    | 4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 65d7c9f4d840..428a8c4cebf1 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -28,12 +28,12 @@ union aci_aifsn {
 // Direction Field Values.
 // Ref: WMM spec 2.2.11: WME TSPEC Element, p.18.
 //
-typedef	enum _DIRECTION_VALUE {
+enum direction_value {
 	DIR_UP			= 0,		// 0x00	// UpLink
 	DIR_DOWN		= 1,		// 0x01	// DownLink
 	DIR_DIRECT		= 2,		// 0x10	// DirectLink
 	DIR_BI_DIR		= 3,		// 0x11	// Bi-Direction
-} DIRECTION_VALUE, *PDIRECTION_VALUE;
+};
 
 
 //
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 4b2da7f31166..79c96da41d8b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -366,7 +366,7 @@ bool GetTs(
 								(&ieee->Tx_TS_Admit_List):
 								(&ieee->Rx_TS_Admit_List);
 
-			DIRECTION_VALUE		Dir =		(ieee->iw_mode == IW_MODE_MASTER)?
+			enum direction_value	Dir =		(ieee->iw_mode == IW_MODE_MASTER)?
 								((TxRxSelect==TX_DIR)?DIR_DOWN:DIR_UP):
 								((TxRxSelect==TX_DIR)?DIR_UP:DIR_DOWN);
 			IEEE80211_DEBUG(IEEE80211_DL_TS, "to add Ts\n");
-- 
2.18.0

