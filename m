Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E20C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253C02089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s94De3vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253C02089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeJAC1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52852 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbeJAC1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so6345214wmw.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+Dt2Q/C1w9r+5aoulClUqtaqcoevUKdKGYbLENBPSQ=;
        b=s94De3vNbVswALvtZhTj+Vd7wgO04Dm2BC5xIjmHg/vf+kf+pISDzt6SDRqRrrzxhU
         DEJNFkJrt6DShIkRI0EXOqcNYPojhAwvcw5F5RxciQ4cBoZRjcxq+RUKIV2J0bUrBO6a
         fZEEjkgE0aCjKOoC+3uNiivDPeqi8PPvQTLQJKrwOKU71XJ1o3thSJHYC8VlPGkpnDOZ
         N0rdxv3SXWqL5HIaohNQMJ6UkH4hO3jC3X7mRZkJjo/nuQGeX5t3dfwKbYMYdhli2Xym
         RB1FkW9sclaCzG/nZfM01VS9BqR51Xgnfq7rCo6Ie6cM1MWPDm3ET6qyAlTbnVhA6D4t
         Pzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+Dt2Q/C1w9r+5aoulClUqtaqcoevUKdKGYbLENBPSQ=;
        b=H8jFarXLHs5WgdfUwg1QUc/s/e68g8FUNgsAJcji7/xkvCDzSJNu2dmr9dFEr5/Ivk
         Bywywpxo6/DZqyuWKxJJRcrwTIj7wvTWzAPv0yeMySKBt1xU9tN8U2A9Oabu9jfSovVa
         oeLdzVQzIgoCoDHt3ZTf2SlDUKX5DuSEfyLSYfK3SZXZ63tNIFNDmDWkgCV8/JOb40tH
         WftWw9H57h0e21Z6dcx7tpDYyz4PblIBF+VHzliwFk6Dxrq+dxgNTPyASx/+FA/IHeWA
         YE/wXFxNwKa7d7Nz0WuA2ylzItjnGm7tocs3dtDAS/K4cNErsGE01DndEIiUIgqRDfNO
         w23g==
X-Gm-Message-State: ABuFfog0U9C/tBKBDjjRs4e7DayfRouHuYjuzITsxZ+77iJu1zFEtyNQ
        zbaYDnB8jNMfMYzEJZd4eHG0/Yn0
X-Google-Smtp-Source: ACcGV63ZFQsxXnxh8c26LXiK8EP2Uu3jfCKErMc1xE7wjJ75QyzSRWP6luQ2LDZR10D7Go+sfRQU0g==
X-Received: by 2002:a1c:8fcc:: with SMTP id r195-v6mr7316wmd.44.1538337205468;
        Sun, 30 Sep 2018 12:53:25 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/19] staging: rtl8188eu: add spaces around '*' in odm_hwconfig.c
Date:   Sun, 30 Sep 2018 21:52:56 +0200
Message-Id: <20180930195310.1531-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '*' in odm_hwconfig.c to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 28 ++++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index b227752f3f00..e9e5d2a6a06c 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -33,7 +33,7 @@ static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
 	if (CurrSig >= 51 && CurrSig <= 100)
 		RetSig = 100;
 	else if (CurrSig >= 41 && CurrSig <= 50)
-		RetSig = 80 + ((CurrSig - 40)*2);
+		RetSig = 80 + ((CurrSig - 40) * 2);
 	else if (CurrSig >= 31 && CurrSig <= 40)
 		RetSig = 66 + (CurrSig - 30);
 	else if (CurrSig >= 21 && CurrSig <= 30)
@@ -110,33 +110,33 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		switch (LNA_idx) {
 		case 7:
 			if (VGA_idx <= 27)
-				rx_pwr_all = -100 + 2*(27-VGA_idx); /* VGA_idx = 27~2 */
+				rx_pwr_all = -100 + 2 * (27-VGA_idx); /* VGA_idx = 27~2 */
 			else
 				rx_pwr_all = -100;
 			break;
 		case 6:
-			rx_pwr_all = -48 + 2*(2-VGA_idx); /* VGA_idx = 2~0 */
+			rx_pwr_all = -48 + 2 * (2-VGA_idx); /* VGA_idx = 2~0 */
 			break;
 		case 5:
-			rx_pwr_all = -42 + 2*(7-VGA_idx); /* VGA_idx = 7~5 */
+			rx_pwr_all = -42 + 2 * (7-VGA_idx); /* VGA_idx = 7~5 */
 			break;
 		case 4:
-			rx_pwr_all = -36 + 2*(7-VGA_idx); /* VGA_idx = 7~4 */
+			rx_pwr_all = -36 + 2 * (7-VGA_idx); /* VGA_idx = 7~4 */
 			break;
 		case 3:
-			rx_pwr_all = -24 + 2*(7-VGA_idx); /* VGA_idx = 7~0 */
+			rx_pwr_all = -24 + 2 * (7-VGA_idx); /* VGA_idx = 7~0 */
 			break;
 		case 2:
 			if (cck_highpwr)
-				rx_pwr_all = -12 + 2*(5-VGA_idx); /* VGA_idx = 5~0 */
+				rx_pwr_all = -12 + 2 * (5-VGA_idx); /* VGA_idx = 5~0 */
 			else
-				rx_pwr_all = -6 + 2*(5-VGA_idx);
+				rx_pwr_all = -6 + 2 * (5-VGA_idx);
 			break;
 		case 1:
-			rx_pwr_all = 8-2*VGA_idx;
+			rx_pwr_all = 8-2 * VGA_idx;
 			break;
 		case 0:
-			rx_pwr_all = 14-2*VGA_idx;
+			rx_pwr_all = 14-2 * VGA_idx;
 			break;
 		default:
 			break;
@@ -185,7 +185,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			if (dm_odm->RFPathRxEnable & BIT(i))
 				rf_rx_num++;
 
-			rx_pwr[i] = ((pPhyStaRpt->path_agc[i].gain & 0x3F)*2) - 110;
+			rx_pwr[i] = ((pPhyStaRpt->path_agc[i].gain & 0x3F) * 2) - 110;
 
 			pPhyInfo->RxPwr[i] = rx_pwr[i];
 
@@ -334,12 +334,12 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 			} else {
 				if (pPhyInfo->RxPWDBAll > (u32)UndecoratedSmoothedOFDM) {
 					UndecoratedSmoothedOFDM =
-							(((UndecoratedSmoothedOFDM)*(Rx_Smooth_Factor-1)) +
+							(((UndecoratedSmoothedOFDM) * (Rx_Smooth_Factor-1)) +
 							(RSSI_Ave)) / (Rx_Smooth_Factor);
 					UndecoratedSmoothedOFDM = UndecoratedSmoothedOFDM + 1;
 				} else {
 					UndecoratedSmoothedOFDM =
-							(((UndecoratedSmoothedOFDM)*(Rx_Smooth_Factor-1)) +
+							(((UndecoratedSmoothedOFDM) * (Rx_Smooth_Factor-1)) +
 							(RSSI_Ave)) / (Rx_Smooth_Factor);
 				}
 			}
@@ -377,7 +377,7 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 
 		if (pEntry->rssi_stat.ValidBit == 64) {
 			Weighting = min_t(u32, OFDM_pkt << 4, 64);
-			UndecoratedSmoothedPWDB = (Weighting*UndecoratedSmoothedOFDM + (64-Weighting)*UndecoratedSmoothedCCK)>>6;
+			UndecoratedSmoothedPWDB = (Weighting * UndecoratedSmoothedOFDM + (64-Weighting) * UndecoratedSmoothedCCK)>>6;
 		} else {
 			if (pEntry->rssi_stat.ValidBit != 0)
 				UndecoratedSmoothedPWDB = (OFDM_pkt * UndecoratedSmoothedOFDM +
-- 
2.19.0

