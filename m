Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F1EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFEB2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvA63Aq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFEB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030810AbeFST5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:57:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54149 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030777AbeFST5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:57:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so2284109wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WYmJC+h+Y6ZiaFPyVdO/Ph+Ugk8LaY/L7+7+ZHoZAm4=;
        b=gvA63Aq90Vum21YMNqrS4E2ltiOTa359+KuHNiIQnvr4AHCNVnS7P/thkhozetW7p8
         oLzB2C5cJ/YZpSJnJaYSrUfK2YE9Q+6qt5srbotRl+cWw0Do/tiQhG/OFmHv1w2EvIgp
         0KhIC+UjCrLBvmmgO5hpVhwwevWsEMr69Axkb7zzuFlnw7u0tRFopPuB3d9ZJ0azRZnt
         GK31eC+L5FUBKXL33VrjvvneB7PMUPBf5NP6oUzWyBRhQJaUcGsHRUTw4JkptyUk1HlD
         5o/X49cDmFxKIDFw/7dmN33qK3c6wVGq+ZTIeGcrV/Tw1z+p/uQ4hOa8Zr94ffRy7Vgg
         8ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WYmJC+h+Y6ZiaFPyVdO/Ph+Ugk8LaY/L7+7+ZHoZAm4=;
        b=lBuVvZEX2IPEinVEw+cMDNp+ZQdmoF1+ucy0AlL9LOzzoOjAY6GhsYBE5zSP/61LjV
         kpVMvS/j+yeMcsEwKNB1EQqeJCvARGsAt5wp5Cra0+67RS1/kzd4Mvk+1mfoXzfDmx8O
         4tq91aVvqJGbWM+/BIM/I7fHNV9awYkd733cnt0vlqem/ze17JfE/5lWyIH1eLL8BcOx
         NFSJKT8VxIRRrMzhUOGHnIEKw78lCxCiQH98Knc04isaLGXPrikkqqALLwx0+icNTnRm
         ceEp9IAKT/qszuACf8WSgoakKj/gOzToOEJb9Vl4yL8Nnk83A/zkrGzbMBN9uBmTHOdD
         1yCQ==
X-Gm-Message-State: APt69E3c6cwEcEWpDoxhbb30tqKbT32+o8SYSkK7dI3i48rqiERAkJkS
        j8Oz0sYo8AF5cdKRxCBfVCty3Q==
X-Google-Smtp-Source: ADUXVKKzDc/P7e1LVnKzvhPVO5IPPHErY0DUS5mD8jNALwDw7qXVrh8h9KECbsV1y3rgJj+obaElxQ==
X-Received: by 2002:a1c:f513:: with SMTP id t19-v6mr13843487wmh.50.1529438221458;
        Tue, 19 Jun 2018 12:57:01 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id c53-v6sm1105983wrg.12.2018.06.19.12.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:57:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 4/9] staging: rtl8192u: Removal of white space from end of lines - Coding Style
Date:   Tue, 19 Jun 2018 20:56:00 +0100
Message-Id: <20180619195605.31321-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619195605.31321-1-johnfwhitmore@gmail.com>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous truncation of comment blocks to 80 character line length resulted in
some white space at endof line.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 40dcb4105e78..e5ca4f3bfc7e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -98,8 +98,8 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 	pMgntInfo->bTxEnableFwCalcDur = (BOOLEAN)pNdisCommon->bRegTxEnableFwCalcDur;
 #endif
 	/*
-	 * 8190 only, Realtek proprietary aggregation mode Set MPDUDensity=2,   
-	 * 1: Set MPDUDensity=2(32k) for Realtek AP 
+	 * 8190 only, Realtek proprietary aggregation mode Set MPDUDensity=2,
+	 * 1: Set MPDUDensity=2(32k) for Realtek AP
 	 * and set MPDUDensity=0(8k) for others
 	 */
 	pHTInfo->bRegRT2RTAggregation = 1;//0: Set MPDUDensity=2,   1: Set MPDUDensity=2(32k)  for Realtek AP and set MPDUDensity=0(8k) for others
@@ -121,7 +121,7 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 }
 
 /*
- *function:  This function print out each field on HT capability 
+ *function:  This function print out each field on HT capability
  *           IE mainly from (Beacon/ProbeRsp/AssocReq)
  *   input:  u8*	CapIE       //Capability IE to be printed out
  *	     u8*	TitleString //mainly print out caller function
@@ -393,7 +393,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 }
 
 /*
- *function:  Check whether driver should declare received rate up to MCS13 
+ *function:  Check whether driver should declare received rate up to MCS13
  *           only since some chipset is not good
  *	     at receiving MCS14~15 frame from some AP.
  *   input:  struct ieee80211_device*	ieee
@@ -409,7 +409,7 @@ static u8 HTIOTActIsDisableMCS14(struct ieee80211_device *ieee, u8 *PeerMacAddr)
 /*
  * Function:	HTIOTActIsDisableMCS15
  *
- * Overview:	Check whether driver should declare capability of receiving 
+ * Overview:	Check whether driver should declare capability of receiving
  *              MCS15
  *
  * Input:
@@ -447,7 +447,7 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_device *ieee)
 /*
  * Function:	HTIOTActIsDisableMCSTwoSpatialStream
  *
- * Overview:	Check whether driver should declare capability of receiving 
+ * Overview:	Check whether driver should declare capability of receiving
  *              All 2 ss packets
  *
  * Input:
@@ -481,7 +481,7 @@ static u8 HTIOTActIsDisableEDCATurbo(struct ieee80211_device *ieee,
 }
 
 /*
- *function:  Check whether we need to use OFDM to send MGNT frame for 
+ *function:  Check whether we need to use OFDM to send MGNT frame for
  *           broadcom AP
  *   input:  struct ieee80211_network *network   //current network we live
  *  output:  none
@@ -602,7 +602,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	/*
 	 * 2008.06.12
-	 * For RTL819X, if pairwisekey = wep/tkip, ap is ralink, 
+	 * For RTL819X, if pairwisekey = wep/tkip, ap is ralink,
 	 * we support only MCS0~7.
 	 */
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
@@ -997,7 +997,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 			pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 	} else {
 		/*
-		 * Set MPDU density to 2 to Realtek AP, 
+		 * Set MPDU density to 2 to Realtek AP,
 		 * and set it to 0 for others
 		 * Replace MPDU factor declared in original association
 		 * response frame format. 2007.08.20 by Emily
@@ -1112,7 +1112,7 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	/*
 	 * CCK rate support
 	 * This flag is set to true to support CCK rate by default.
-	 * It will be affected by "pHTInfo->bRegSuppCCK" and AP capabilities 
+	 * It will be affected by "pHTInfo->bRegSuppCCK" and AP capabilities
 	 * only when associate to 11N BSS.
 	 */
 	pHTInfo->bCurSuppCCK = true;
@@ -1177,7 +1177,7 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 /*
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  struct ieee80211_device	*ieee
- *	     struct ieee80211_network	*pNetwork //usually current network 
+ *	     struct ieee80211_network	*pNetwork //usually current network
  *                                                  we are live in
  *  output:  none
  *  return:  none
@@ -1197,7 +1197,7 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 	//
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "==============>%s()\n", __func__);
 	/*
-	 * unmark bEnableHT flag here is the same reason why unmarked in 
+	 * unmark bEnableHT flag here is the same reason why unmarked in
 	 * function ieee80211_softmac_new_net. WB 2008.09.10
 	 */
 //	if( pHTInfo->bEnableHT &&  pNetwork->bssht.bdSupportHT)
@@ -1226,7 +1226,7 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 
 		/*
 		 * Decide IOT Action
-		 * Must be called after the parameter of 
+		 * Must be called after the parameter of
 		 * pHTInfo->bCurrentRT2RTAggregation is decided
 		 */
 		pHTInfo->IOTAction = 0;
-- 
2.17.1

