Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F75C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCEE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr4eZIhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCEE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030656AbeFST6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:58:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39643 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030727AbeFST5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:57:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id w7-v6so867209wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/GiH1wUgNmLPacPEXSO+qpw70VdcJtrrUjSuxzyVso=;
        b=jr4eZIhFkeK4IyXQwmjBStkuDtam0+jN9orgeBM4R2Bg8zYv1N/TyaopiJkcZyY0dc
         Ce9yDptn2DD3xgYKreD4Q+p5thAFFDtedM8RaOMAnZif4tlDggZj3t8hTn2C1gXKlHjt
         hmTU6fHkQbeN/RMlz0vw0QubqnDOGlPsTygKdq15QsYiw2I6jrLnA2V1ZPJEI2cJX5YP
         TDGPTzOrqatuRdHCokoqPJyjIIkRs08am+jYqI5BuDiIuIB3fFeUF5HE/vTgGW1cbJb5
         5N5tBpVxp/9YxH0d66tSbSkx3TII7FDt9Sl2isfmCb/A1did72zeC6K0vFCRzKbBdavA
         dmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E/GiH1wUgNmLPacPEXSO+qpw70VdcJtrrUjSuxzyVso=;
        b=I0OcPz9RvjORLowRdcAHX8yAqvahW2EgGTVqkrfjRCOtQ2bjcawxXMtkwyZNb7EO5Y
         adhtZ5OPyFrHIEGxV2IBb86c7Cx95oEPmbw43/6btW1AniOhvkuw0S3ELim9f6KB3vV2
         W4fnGfOjTfium/W2iN91LKM56kxKkYNbi7zXDFoiN90MJuxf8ahGDsaCJk6De33p92Qr
         n6XyINPg4391CiHV+ur1kY/YmnMLsjWXnlkXx5QY6//0WhkiBqVkOvsdEdlb6lbHo2cZ
         2iWFDGVQD3KoSnZE8IC2EPKb/iad/un61nse3CuwBA1TNGYRwR91lfJfPOC3rN11MGIZ
         zMFQ==
X-Gm-Message-State: APt69E2LHRd5aHVVKsfoh7b3LrKWo7CwyCxOPIGt2lW5lNxjHA2GiiFn
        JLd/WCuheecJn5ZKmcNG8JE=
X-Google-Smtp-Source: ADUXVKLNVX6T6czR0ZVTCM7O3t+HNOt4W/CJQcknPIPimr4WJ85OzUycChAWBayklvChAngwTAXlXw==
X-Received: by 2002:adf:858f:: with SMTP id 15-v6mr16350323wrt.31.1529438226008;
        Tue, 19 Jun 2018 12:57:06 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id c53-v6sm1105983wrg.12.2018.06.19.12.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:57:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 7/9] staging: rtl8192u: Correciton of block comments - Coding Style
Date:   Tue, 19 Jun 2018 20:56:03 +0100
Message-Id: <20180619195605.31321-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619195605.31321-1-johnfwhitmore@gmail.com>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correcton of a few block comments to comply with Coding Style.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index c942d886429e..98688f9fdee6 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -643,7 +643,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
  *  output:  none
  *  return:  none
  *  notice:  posHTCap can't be null and be initialized before.
-             Only AP and IBSS sta should do this
+ *           Only AP and IBSS sta should do this
  */
 void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *len, u8 IsEncrypt)
 {
@@ -724,7 +724,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	*posRT2RTAgg++ = 0x4c;
 	*posRT2RTAgg++ = 0x02;
 	*posRT2RTAgg++ = 0x01;
-	*posRT2RTAgg = 0x10;//*posRT2RTAgg = 0x02;
+	*posRT2RTAgg = 0x10;   // *posRT2RTAgg = 0x02;
 
 	if (ieee->bSupportRemoteWakeUp)
 		*posRT2RTAgg |= 0x08;//RT_HT_CAP_USE_WOW;
@@ -734,16 +734,15 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 #ifdef TODO
 #if (HAL_CODE_BASE == RTL8192 && DEV_BUS_TYPE == USB_INTERFACE)
 	/*
-	//Emily. If it is required to Ask Realtek AP to send AMPDU during AES mode, enable this
-	   section of code.
+	 * Emily. If it is required to Ask Realtek AP to send AMPDU during AES
+	 * mode, enable this section of code.
+	 */
+#if 0
 	if(IS_UNDER_11N_AES_MODE(Adapter))
-	{
 		posRT2RTAgg->Octet[5] |=RT_HT_CAP_USE_AMPDU;
-	}else
-	{
+	else
 		posRT2RTAgg->Octet[5] &= 0xfb;
-	}
-	*/
+#endif
 #else
 	// Do Nothing
 #endif
-- 
2.17.1

