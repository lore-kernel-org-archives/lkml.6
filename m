Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E65BC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4593A2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb0ffGB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4593A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeJAC1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35468 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbeJAC1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so2278657wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+s+S/90uZAFDiqhDT+ccemRiKr/6nklizyQUFhX/o7k=;
        b=Hb0ffGB60PMYFdrFHYUIkVW5/ikEjzUi9G39WhpRj0lcYM5VkooIUa9D00aHysUi9/
         f5+tLLkFyp63EzOXZl3cxyJeAZt7QkZSgg9DuFt1FtJ5mj/KPlLFMNTyfI49y+Zob+RR
         lTU8OZ5TKip/xx2HT08w2TvNwa3qIMgqUse4onncu2Radz+btrNE8C7xQv/TH9HOmwSp
         4MGVi01IyhNibTHkkYVUrIeoX48jPLOgVYFsAr3DP/PzyKIjm4dWEbe+0b6uV6t1Cs5l
         +bI79Vg2ffrhHSCaVKToxNhhqj0OB5zI6qCr+oFv25CCUh/w2W/REAdYIytwy24HRZRd
         6ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+s+S/90uZAFDiqhDT+ccemRiKr/6nklizyQUFhX/o7k=;
        b=D8F8zfEraFqymVNcjC+5Oag41y7jT2TZ6/Tep5iPrbvisbfffkVSuvE4siE0JVDdjA
         gMzDec/LP1a2f47vrsNtmcPgF09npQcSbhyg/v3BHHtJtS4qa7ystjBwV1V4AiyuDxLv
         3M/qP5ddvtm8yFnqX3qKlCjzFiHyqNFVOnNCtDpyTs8knBdB+72j9sPQbooEe0zbiyj0
         4lVIoim6K7ynNGQcDRO4ZB27mcD+eym0Zp3WRFPWAgiTaKSq1rJl+5I8ZUfRwg4r5jJJ
         phgE8ZfMg6gUExi32+tVaZTiu710oD8rHPQkEOfLDAP9CGcFg0fRxm6nU6hFwr6ee+le
         2ZhQ==
X-Gm-Message-State: ABuFfojTYlHeSciZ99HGTDsgbsG7jHbV/GjEJplbnAuPl1sCrdQ3eSW4
        dpCfKtvN60WthpXVV7AKxSA4z29P
X-Google-Smtp-Source: ACcGV61H4Ci9t2EGPmtvEQUIbUVVc1udPtBoy2mQonjFKElTdloPVfwOv987P3GPe2vPt4Pz4WXakQ==
X-Received: by 2002:adf:ef0a:: with SMTP id e10-v6mr5040962wro.292.1538337204570;
        Sun, 30 Sep 2018 12:53:24 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/19] staging: rtl8188eu: add spaces around '+' in odm_hwconfig.c
Date:   Sun, 30 Sep 2018 21:52:55 +0200
Message-Id: <20180930195310.1531-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+' in odm_hwconfig.c to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 6cc1f1f6448d..b227752f3f00 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -21,7 +21,7 @@ static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 	else if (AntPower >= 0)
 		return	100;
 	else
-		return 100+AntPower;
+		return 100 + AntPower;
 }
 
 /*  2012/01/12 MH MOve some signal strength smooth method to MP HAL layer. */
@@ -145,7 +145,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
 		if (!cck_highpwr) {
 			if (PWDB_ALL >= 80)
-				PWDB_ALL = ((PWDB_ALL-80)<<1)+((PWDB_ALL-80)>>1)+80;
+				PWDB_ALL = ((PWDB_ALL-80)<<1) + ((PWDB_ALL-80)>>1) + 80;
 			else if ((PWDB_ALL <= 78) && (PWDB_ALL >= 20))
 				PWDB_ALL += 3;
 			if (PWDB_ALL > 100)
@@ -377,7 +377,7 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 
 		if (pEntry->rssi_stat.ValidBit == 64) {
 			Weighting = min_t(u32, OFDM_pkt << 4, 64);
-			UndecoratedSmoothedPWDB = (Weighting*UndecoratedSmoothedOFDM+(64-Weighting)*UndecoratedSmoothedCCK)>>6;
+			UndecoratedSmoothedPWDB = (Weighting*UndecoratedSmoothedOFDM + (64-Weighting)*UndecoratedSmoothedCCK)>>6;
 		} else {
 			if (pEntry->rssi_stat.ValidBit != 0)
 				UndecoratedSmoothedPWDB = (OFDM_pkt * UndecoratedSmoothedOFDM +
-- 
2.19.0

