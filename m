Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C665C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139DB20878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLB357AC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139DB20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbeG2Ang (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:43:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35301 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731561AbeG2AnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:43:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id a3-v6so8710321wrt.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48ZzOtNbhn/IsYIwefHOSQm85U1tNjkP07tK7Mq0MOY=;
        b=VLB357ACu+k+XVYY41Rn4Mvuz4WgfXQtCn2clVDqjNYysGp5sk3o73A5Da1BqgJsJn
         JAh3Kr4f7flEZ7gmMW7kuDTxANBGGROBif/eD2dIRjDi4Ay5c87neEUPOGI/4qCKlsUQ
         Qqi+yYkDVHtLSKVerxTx4rCuqDd1/yhl/GHV4f5sN5T9gEaYODQ8bOcghm/vcnoPl05G
         Km8x32Vg4aMyi7OH71BJR0oqg5aWSKmrmHgRS37+wX/eXLTMvDVF7GGy7AVM0S1rBvPh
         wOr5ISBPrqVLcXCezSxU6sfelzaS5wVi/Kn+8+1RNm4V6STntakEjUvBiHP4SPPxNF8v
         bdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48ZzOtNbhn/IsYIwefHOSQm85U1tNjkP07tK7Mq0MOY=;
        b=ZbY7xIsxKJP59b2QijK/D90tAKohsZFzmnOt2Mh4FEsSL8C6s0yNQIXVZqwxtyfxNG
         ofK3C4yZSGlRumvayjKd3PnaPj5S4NVzpTeuSPOtBBAshCNehMeTJCaOie7B8VZ4uPjz
         mex4w2f1FnhvrkfURUpQFR9j21y5RkIPrXuNl4f7nfnuwsdORmwhH+ZiJcl1lj0IPEF6
         MUnBFumxxpi06+NtFxsmVTHa7g5inu730Z0X8rWI1MsP/9xkpLHjuKaGQ+3oqFxbD6TU
         EEEpAyc7HCpl3Vdp5EYdbpGHtmGun087+hZd9E+Tw1YbMzvy/RbBBdBkTtavaUa7p4E1
         odUQ==
X-Gm-Message-State: AOUpUlF0N1wlD1b9+3m7YX2pL4H0LdeFDHVyzuVgwpbL77ZkRTye2pXE
        Tztvy3HVX2KN8BzJZ6WWTnhrVobj
X-Google-Smtp-Source: AAOMgpc4j8r2afLz1zapR0Dq5vE5bplBHcKUMLF4Y9xnVQUvGDcn8EYxFAHH8F2eCH9jV1xOPl1Dsw==
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr11635063wrb.155.1532819707623;
        Sat, 28 Jul 2018 16:15:07 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id j131-v6sm8909745wmb.25.2018.07.28.16.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:15:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 06/08] staging:rtl8192u: Rename enum DIRECTION_VALUE - Style
Date:   Sun, 29 Jul 2018 00:14:50 +0100
Message-Id: <20180728231452.20107-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728231452.20107-1-johnfwhitmore@gmail.com>
References: <20180728231452.20107-1-johnfwhitmore@gmail.com>
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

