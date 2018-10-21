Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46070ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1080D20779
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDAPv5jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1080D20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeJVEBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:01:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36702 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeJVEBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:01:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id x2-v6so1038763eds.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5uaeUae1Hhw5EtXwoUQxokVYmXvjZ5VdGpf5XvAQysM=;
        b=qDAPv5jomWWcKOBT8PYs2MmrxVoIFT4N6fEKJgdXYYnV2CvqBPiLxMUJ1gl0bFR0id
         kjmwGlTED8LjHlO6XTsKvGx4JJkhKBW967RtaghAbYTOhIyUVBWrjJcB7MFqQjOFgBbb
         pqPYYNQ97lOPOwsQH8lDtpL5xkyHkqWxMVRUb5Jtxh5ZiSmFepo976ft8yFnnTe/PHK0
         IvzUXM7QmqVTY6vRCSbmJThD/H8B2ylt0ETuza88H4fd6kgUIyg1jT3AHvoeIPi0nrzG
         vkWoFE2bltHx3T/52NfBP+ElZUgfz55EVw+iu7HZKjilMaTdkzLraAxyiSJBcl6Gc9OE
         M5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5uaeUae1Hhw5EtXwoUQxokVYmXvjZ5VdGpf5XvAQysM=;
        b=QR+cvIWZCNPwyRUUxWOgXzq7C1GsSFOG6CU8ZL9yPFu5Y3g7j5lcpYsEqREL5xnL63
         5NgAgmz1pF86mtqPNfnO+x+MaljIk+M6arDtbAmcdOFzprVt2p7JmDIa0uyGg5ZndrbU
         /CO38vcVC5V4o5BcO4zn7dfguNqpu1Ub6rPwyVu4j0bxrnYxyWOoqPyyq84sE0fPEIK+
         IE+KavmjK62ldAnrtPzobOj4sio54P1QZ1KO3bQmICEoYeGrqxsZjsg1I4O1lGTjIpXI
         J4OypHszu8biUJ87ENQORk3iI45q/PpDm8nS1PXfDgtd7DKuI4+crNZk9alMHo6Mu4ER
         co8w==
X-Gm-Message-State: ABuFfoj2S8lxqqjNaemET2QQGX+eFbshVdVQQfVz6LYiGlLHSwxWubK9
        1sH1+jCk+fRrAP1ivx09pQY=
X-Google-Smtp-Source: ACcGV636zumGmu8fe18vXCWBuvI9fhhdxUBBEtDxmF8gSamyKbvu8D+rOWBL/hLm9+LtYNOrTxCK6g==
X-Received: by 2002:a17:906:704f:: with SMTP id r15-v6mr34744760ejj.131.1540151180263;
        Sun, 21 Oct 2018 12:46:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id w11-v6sm6159566ejv.4.2018.10.21.12.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 12:46:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/4] staging: rtl8188eu: rename variable isCCKrate - style
Date:   Sun, 21 Oct 2018 21:45:27 +0200
Message-Id: <20181021194528.15542-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181021194528.15542-1-straube.linux@gmail.com>
References: <20181021194528.15542-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable isCCKrate to avoid CamelCase.
isCCKrate -> is_cck_rate

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index d7bdbb141b2b..5d72d7f6d05f 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -71,19 +71,20 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 	s8 rx_pwr[4], rx_pwr_all = 0;
 	u8 EVM, PWDB_ALL = 0, PWDB_ALL_BT;
 	u8 RSSI, total_rssi = 0;
-	u8 isCCKrate = 0;
+	u8 is_cck_rate = 0;
 	u8 rf_rx_num = 0;
 	u8 cck_highpwr = 0;
 	u8 LNA_idx, VGA_idx;
 
 	struct phy_status_rpt *pPhyStaRpt = (struct phy_status_rpt *)pPhyStatus;
 
-	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
+	is_cck_rate = ((pPktinfo->Rate >= DESC92C_RATE1M) &&
+		       (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
 
 	pPhyInfo->RxMIMOSignalQuality[RF_PATH_A] = -1;
 	pPhyInfo->RxMIMOSignalQuality[RF_PATH_B] = -1;
 
-	if (isCCKrate) {
+	if (is_cck_rate) {
 		u8 cck_agc_rpt;
 
 		dm_odm->PhyDbgInfo.NumQryPhyStatusCCK++;
@@ -234,7 +235,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 	}
 	/* UI BSS List signal strength(in percentage), make it good looking, from 0~100. */
 	/* It is assigned to the BSS List in GetValueFromBeaconOrProbeRsp(). */
-	if (isCCKrate) {
+	if (is_cck_rate) {
 		pPhyInfo->SignalStrength = (u8)(odm_signal_scale_mapping(dm_odm, PWDB_ALL));/* PWDB_ALL; */
 	} else {
 		if (rf_rx_num != 0)
@@ -255,7 +256,7 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 {
 	s32 UndecoratedSmoothedPWDB, UndecoratedSmoothedCCK;
 	s32 UndecoratedSmoothedOFDM, RSSI_Ave;
-	u8 isCCKrate = 0;
+	u8 is_cck_rate = 0;
 	u8 RSSI_max, RSSI_min, i;
 	u32 OFDM_pkt = 0;
 	u32 Weighting = 0;
@@ -271,7 +272,8 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 	if ((!pPktinfo->bPacketMatchBSSID))
 		return;
 
-	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
+	is_cck_rate = ((pPktinfo->Rate >= DESC92C_RATE1M) &&
+		       (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
 
 	/* Smart Antenna Debug Message------------------  */
 
@@ -299,7 +301,7 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 	UndecoratedSmoothedPWDB = pEntry->rssi_stat.UndecoratedSmoothedPWDB;
 
 	if (pPktinfo->bPacketToSelf || pPktinfo->bPacketBeacon) {
-		if (!isCCKrate) { /* ofdm rate */
+		if (!is_cck_rate) { /* ofdm rate */
 			if (pPhyInfo->RxMIMOSignalStrength[RF_PATH_B] == 0) {
 				RSSI_Ave = pPhyInfo->RxMIMOSignalStrength[RF_PATH_A];
 			} else {
-- 
2.19.1

