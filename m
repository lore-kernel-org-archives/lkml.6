Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A386CECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A7E21523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQgnBaTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A7E21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJTTSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 15:18:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46288 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbeJTTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 15:18:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id v22-v6so703523eds.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5uaeUae1Hhw5EtXwoUQxokVYmXvjZ5VdGpf5XvAQysM=;
        b=UQgnBaToRqyqpyL3qIMfYqoJCH4h02jqeQubJNl5QO6ftQo3LxSy5IlBL/JTUpuuW7
         Df41TC+hbgbmE3g+TJemGqPHKNjJqqigzRdjFAO/YzG5xJ+VSqOS4q32GSpZ80bKmu5s
         1NaR63lLpw4AtmhLCyMpL86tYXx0ETJit+hEUeyx622oEifBOLgVko4uWUj5nORwQcjp
         SdWMIXsBA1D6cwUnbN1g0YSGRmo7l3DFY0NsDcl1U0MXUefeFoyCvMikVGDziAl3FQI1
         FzBOkAqIVomuP9bcjotFfx17MWleNi5aAkthoMDHafm6SKrYflRXZ8byvAxm13oiLQyd
         p5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5uaeUae1Hhw5EtXwoUQxokVYmXvjZ5VdGpf5XvAQysM=;
        b=RKNbXn89YL+grxvM7stObTGE6nuoD/+S65kgw6AkVptA7/ewivdTdeRnmOiEwnHrUF
         MSLCOAGo5egua73DgzjWcWp51FOQajKqTnZNc7A37KNYIDTcjYpQhfOa9VqOj9dKaTSZ
         OeYocgEa11U3Bp1ald/ghWDTYQ0nmdeY65SIJ5DMo5u7OJ0bw5c2JtpW1hdxJt0gyLqQ
         vqFovAnevk/J+5UYc7ANYBg39b9MKlSWu/pMc+00O2eC6a45kx43gyBTZ3HTe+0/l+tu
         Ami0Yebnb/zID34ZCEUnvB3PWqK0GxK1KrgiYm8AyqkB+Hhl+9wpMIGFCH32cvse7qio
         nsTg==
X-Gm-Message-State: ABuFfoj748MXVSwMdP0MuM9QpNZTSKkGtLuOdk1Rb4gFGsEx3FKTg2AN
        LG44CMm5tmYQLZDHejrpfFU=
X-Google-Smtp-Source: ACcGV63r4ej/HgMSSiviUyTUUSEE1jC6WOfvELONmz/5DYLP7pcX+dOZQPnXrTmCxlM61lI3ua+elg==
X-Received: by 2002:a17:906:234f:: with SMTP id m15-v6mr9984919eja.78.1540033712976;
        Sat, 20 Oct 2018 04:08:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id r23-v6sm11418422eda.44.2018.10.20.04.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 04:08:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: rename variable isCCKrate - style
Date:   Sat, 20 Oct 2018 13:08:19 +0200
Message-Id: <20181020110819.1576-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181020110819.1576-1-straube.linux@gmail.com>
References: <20181020110819.1576-1-straube.linux@gmail.com>
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

