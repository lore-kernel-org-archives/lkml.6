Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E49AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD38205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG8MXm66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD38205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeH3Aem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36774 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3Aek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id m27-v6so6033540wrf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p2R9Pz++17d7sd+x+tznwBGKpVwkM8Q11IlH/c8c/Nw=;
        b=UG8MXm66H5C9HU6TwdpBDrHiBVh7OQDHkOKja2VwsbHh0LipYSjL0xW3As4vfSwOLa
         C+1C02kXGHbNxVTmPSVEjqEQTDvFSFa/+nr5RmuIhW+wvkkRnLNe4UFIlwTcgwG4Q821
         d0CIrVBWzL7UOSvzbNhu4+wn2yaF7SNro/b+gAhl3+SEdtRoIqyDQ8AQv2wBCIj9ZOHL
         bJRKWZLpVToyNNga0hVQ75BQTEjKgrsMYPLufZwJMIn9lxX6PDo/pyg9ZhUB60hL5Epr
         gEtJfy32PSjP/6lrRwqJMHjzNSThd91lceuQrZ+jp8GNNkTtlDZIXaIymFeOku74Z6XU
         epOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p2R9Pz++17d7sd+x+tznwBGKpVwkM8Q11IlH/c8c/Nw=;
        b=BX1Up1DcddXCzCDYT7ntxp8JeKAHzKespCAmCHmj3IIApYFOY6g+hkrR4jc5WTfHvu
         FBXlWAOAJdW8mtr7UPIuXEkrK0gX60J5bDRPPb2YwtwGRnq1K+Ui9J9dg2TdePW9zsuW
         ey4ZbFlAY1L8nvyS9qwD5GuDhnOFIMgCj6uF5ZxWivsgFnEj9nW5wmCcBNyrKK8snq2t
         zqbMsw7xeNOnitGWbSe79EnClNbYSrTEVfque3ACdFFzYwxKzoK4FiNwInr37WpnigRJ
         JY/d5/lgABnf+C0XZV6xJg8WrQRUP5ftR6exCnW87N6zMpy1yHdsoPAbB+9ajJYuY+u5
         Cr2w==
X-Gm-Message-State: APzg51CDYD4ECzbQM8DASLB9QFo2qrO24zU0joUje9QGSRfxk31L8Bhp
        92TZMYBf9jSh0S22y/Kj/s5YpE4KIkI=
X-Google-Smtp-Source: ANB0Vdai8ww8s1RU9oY/fepqquqGggyQomdn5SkByVu7znTbMjxUjtQZbp/RnyDKZtjMdVjL004w1Q==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10-v6mr5421974wrt.48.1535574964848;
        Wed, 29 Aug 2018 13:36:04 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/21] staging:rtl8192u: Rename ShortGI20Mhz - Style
Date:   Wed, 29 Aug 2018 21:35:31 +0100
Message-Id: <20180829203547.15650-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member 'ShortGI20Mhz' to 'short_gi20_mhz'. This
change clears the checkpatch issue with CamelCase naming of variables.

The change if purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c   |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index 514445dc542e..a0e91763e7f3 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -157,7 +157,7 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 		is40M = (ht_cap->chl_width)?1:0;
 		isShortGI = (ht_cap->chl_width)?
 						((ht_cap->ShortGI40Mhz)?1:0):
-						((ht_cap->ShortGI20Mhz)?1:0);
+						((ht_cap->short_gi20_mhz)?1:0);
 
 		max_mcs = HTGetHighestMCSRate(ieee, ht_cap->MCS, MCS_FILTER_ALL);
 		rate = MCS_DATA_RATE[is40M][isShortGI][max_mcs&0x7f];
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 705d811cbe01..64fd6a4f3bcd 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -43,7 +43,7 @@ struct ht_capability_ele {
 	u8	chl_width:1;
 	u8	mimo_power_save:2;
 	u8	not_used_green_field:1;
-	u8	ShortGI20Mhz:1;
+	u8	short_gi20_mhz:1;
 	u8	ShortGI40Mhz:1;
 	u8	TxSTBC:1;
 	u8	RxSTBC:2;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 73745d8406aa..fe8d75d8bd96 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -143,7 +143,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString);
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->chl_width) ? "20MHz" : "20/40MHz");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->ShortGI20Mhz) ? "YES" : "NO");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->short_gi20_mhz) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->ShortGI40Mhz) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport TX STBC = %s\n", (pCapELE->TxSTBC) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->MaxAMSDUSize) ? "3839" : "7935");
@@ -253,7 +253,7 @@ static bool IsHTHalfNmodeSGI(struct ieee80211_device *ieee, bool is40MHz)
 		else
 			retValue = false;
 	} else {
-		if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->ShortGI20Mhz) // ap support 40 bw short GI
+		if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->short_gi20_mhz) // ap support 40 bw short GI
 			retValue = true;
 		else
 			retValue = false;
@@ -557,10 +557,10 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 //	pCapELE->chl_width		= (pHT->bRegBW40MHz?1:0);
 	pCapELE->mimo_power_save        = pHT->SelfMimoPs;
-	pCapELE->ShortGI20Mhz		= 1; // We can receive Short GI!!
+	pCapELE->short_gi20_mhz		= 1; // We can receive Short GI!!
 	pCapELE->ShortGI40Mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
-	//pCapELE->chl_width, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
+	//pCapELE->chl_width, pCapELE->short_gi20_mhz, pCapELE->ShortGI40Mhz);
 	pCapELE->TxSTBC			= 1;
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;	// Do not support now!!
@@ -944,7 +944,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	 * TODO:
 	 */
 	pHTInfo->bCurShortGI20MHz = pHTInfo->bRegShortGI20MHz &&
-				    (pPeerHTCap->ShortGI20Mhz == 1);
+				    (pPeerHTCap->short_gi20_mhz == 1);
 	pHTInfo->bCurShortGI40MHz = pHTInfo->bRegShortGI40MHz &&
 				   (pPeerHTCap->ShortGI40Mhz == 1);
 
-- 
2.18.0

