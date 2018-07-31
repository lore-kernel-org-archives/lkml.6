Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1144820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGGlk3Ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1144820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbeGaWm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44941 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeGaWm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so5843585edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5POgX/ajYbw9IAH4MCAOA6aXY+W+mofRKNI+psbVzUE=;
        b=OGGlk3IpCPiLwLYzNZcP+0KMfwo65u5mcFwUpBVn7xMSNjNe5zHNcq+DW2In+UBJ+O
         DwVsrVbZ3D86GqHhE4zUGOWqFXis/U6YtxOpDJjCcbQqETD2Q41Vt7nVveWtOO0QrDF8
         YGl6NxBAYiEptcOxtqsDnt7ShaUo2L6sW1cFGc3OoTAsbspDj8DMtdxLhFtVvaY+cldK
         MR6xiYu3MZU8Kwq0W4NIbh2KAJXtNZV3+fXJfMeh5Ar9mFA5B07P68g5EVmHMYyqSyyf
         u11QqedRC9fbxpbSI2rcc3HKtjpEyeV7z5mPUmRWuYpKIq/51qAjFQYUTB9+9n6OhnQN
         pSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5POgX/ajYbw9IAH4MCAOA6aXY+W+mofRKNI+psbVzUE=;
        b=ZC4r70CPdIESnbqa8rE4eoHAd03qt7Ap68PVOkSfW6/ZTLd/6UbhgELhUaoYceRRwC
         fxoKBq3kIeI5G9Es+CTY4kykm+W1N55vQXDp1zbNas5cVlovuoPxNEgZyUjyc7OAEHVS
         U06XCV94e3WLLpB13c7PqjUOOsIJU4RquHhsYo26rCDjMjjKINQA2Tqvg5sQEjUINZx5
         8xm8f+TRp09+FohN311hcBSJkgG2q/o8A7zBRv0QI8/fVVbFCAWEwO/kkmUV2p9tKtUg
         j2n3FpxrRnd6Nj2dBu5iINVXwu+d/68R8pb1v4ee3cV3asGisYLFynA5SscZtbIDk9SF
         /MXQ==
X-Gm-Message-State: AOUpUlF8M4e9iBgM9TsfzJbAX7KfZ2z1cjLanWZ4M9Y+PT7HLfNOxvKA
        4nvrnvUezoXsJ0msOtSRGVDkveUw
X-Google-Smtp-Source: AAOMgpe2wNFi/jPwaNnXt1VyDXeMcmZuDWRz7mK/Vh3IwxdbVLJmQROX7222kX+8wEFj6pb+A7ZiuA==
X-Received: by 2002:a50:cc4d:: with SMTP id n13-v6mr1079909edi.171.1533070844921;
        Tue, 31 Jul 2018 14:00:44 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:44 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/14] staging:rtl8192u: Rename octet_string members - Style
Date:   Tue, 31 Jul 2018 22:00:02 +0100
Message-Id: <20180731210005.17452-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the structure octet_string's member variables Octet to octet and
Length to length. This change clears the checkpatch issue with CamelCase
naming of variables.

This is purely a coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 34 +++++++++----------
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       |  4 +--
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  |  4 +--
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 706b4419e643..51cb5e4658b0 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -1066,49 +1066,49 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		struct octet_string	osCcxAironetIE;
 
 		memset(CcxAironetBuf, 0, 30);
-		osCcxAironetIE.Octet = CcxAironetBuf;
-		osCcxAironetIE.Length = sizeof(CcxAironetBuf);
+		osCcxAironetIE.octet = CcxAironetBuf;
+		osCcxAironetIE.length = sizeof(CcxAironetBuf);
 		//
 		// Ref. CCX test plan v3.61, 3.2.3.1 step 13.
 		// We want to make the device type as "4500-client". 060926, by CCW.
 		//
-		memcpy(osCcxAironetIE.Octet, AironetIeOui, sizeof(AironetIeOui));
+		memcpy(osCcxAironetIE.octet, AironetIeOui, sizeof(AironetIeOui));
 
 		// CCX1 spec V1.13, A01.1 CKIP Negotiation (page23):
 		// "The CKIP negotiation is started with the associate request from the client to the access point,
 		//  containing an Aironet element with both the MIC and KP bits set."
-		osCcxAironetIE.Octet[IE_CISCO_FLAG_POSITION] |= (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC);
+		osCcxAironetIE.octet[IE_CISCO_FLAG_POSITION] |= (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC);
 		tag = skb_put(skb, ckip_ie_len);
 		*tag++ = MFIE_TYPE_AIRONET;
-		*tag++ = osCcxAironetIE.Length;
-		memcpy(tag, osCcxAironetIE.Octet, osCcxAironetIE.Length);
-		tag += osCcxAironetIE.Length;
+		*tag++ = osCcxAironetIE.length;
+		memcpy(tag, osCcxAironetIE.octet, osCcxAironetIE.length);
+		tag += osCcxAironetIE.length;
 	}
 
 	if (beacon->bCcxRmEnable) {
 		static u8 CcxRmCapBuf[] = {0x00, 0x40, 0x96, 0x01, 0x01, 0x00};
 		struct octet_string osCcxRmCap;
 
-		osCcxRmCap.Octet = CcxRmCapBuf;
-		osCcxRmCap.Length = sizeof(CcxRmCapBuf);
+		osCcxRmCap.octet = CcxRmCapBuf;
+		osCcxRmCap.length = sizeof(CcxRmCapBuf);
 		tag = skb_put(skb, ccxrm_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
-		*tag++ = osCcxRmCap.Length;
-		memcpy(tag, osCcxRmCap.Octet, osCcxRmCap.Length);
-		tag += osCcxRmCap.Length;
+		*tag++ = osCcxRmCap.length;
+		memcpy(tag, osCcxRmCap.octet, osCcxRmCap.length);
+		tag += osCcxRmCap.length;
 	}
 
 	if (beacon->BssCcxVerNumber >= 2) {
 		u8			CcxVerNumBuf[] = {0x00, 0x40, 0x96, 0x03, 0x00};
 		struct octet_string	osCcxVerNum;
 		CcxVerNumBuf[4] = beacon->BssCcxVerNumber;
-		osCcxVerNum.Octet = CcxVerNumBuf;
-		osCcxVerNum.Length = sizeof(CcxVerNumBuf);
+		osCcxVerNum.octet = CcxVerNumBuf;
+		osCcxVerNum.length = sizeof(CcxVerNumBuf);
 		tag = skb_put(skb, cxvernum_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
-		*tag++ = osCcxVerNum.Length;
-		memcpy(tag, osCcxVerNum.Octet, osCcxVerNum.Length);
-		tag += osCcxVerNum.Length;
+		*tag++ = osCcxVerNum.length;
+		memcpy(tag, osCcxVerNum.octet, osCcxVerNum.length);
+		tag += osCcxVerNum.length;
 	}
 	//HT cap element
 	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 264d15fbcc6b..b948eae5909d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -738,10 +738,10 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	   section of code.
 	if(IS_UNDER_11N_AES_MODE(Adapter))
 	{
-		posRT2RTAgg->Octet[5] |= RT_HT_CAP_USE_AMPDU;
+		posRT2RTAgg->octet[5] |= RT_HT_CAP_USE_AMPDU;
 	}else
 	{
-		posRT2RTAgg->Octet[5] &= 0xfb;
+		posRT2RTAgg->octet[5] &= 0xfb;
 	}
 	*/
 #else
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 531a3e22e799..50b05ee52210 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -73,8 +73,8 @@ struct tspec_body {
 //      802.11 Management frame Status Code field
 //----------------------------------------------------------------------------
 struct octet_string {
-	u8		*Octet;
-	u16             Length;
+	u8		*octet;
+	u16             length;
 };
 
 //Added by joseph
-- 
2.18.0

