Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A86C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFAA208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjuShhqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFAA208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeJAC1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43403 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbeJAC1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so1358962wrt.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8jEsB3KZOl5fiF0nzKvXKqNDXKwDRN6NLO80UHx77Hc=;
        b=mjuShhqpyI8MzAvKx6yZVYlzi3NhxpCkOr6r99mK09OzSygBZR9+PaxOYU7OX5nuE7
         DO/l1OCZl8E6O7xiek2v0LZnUyAmb0b26nrQVcZrpN7Y67v+xFgNwohuGbn+fl3xZUAo
         +7XekDDJcPH0+v500LU628lKjCEr4hZ8UeqKM1K7bMy0PzJXnPTUtHiS1wbh6RtpkYYK
         oJDHIzLen+2Or/vS2p5kNXhfpk0Yg7egFIpBkSN1qwDyxN7JIZrpeH7P021yDcu215a6
         6YKy2EnzjNPP973kU40bINtGAN5UgkAalDuae6hAfZt9Zyh5fQWBFDtKFBEuktfAxRSk
         9r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8jEsB3KZOl5fiF0nzKvXKqNDXKwDRN6NLO80UHx77Hc=;
        b=JtoiQdedrb2dGFdOtiXxGPTf4Rgw8EIRqHi9aZ3IrIc9RYMlx1RthnIvBimULqG+e+
         TTku0TZS4UpOxGZl/299Twzw8Havm0TF9P9nXzxv1E1pBpgSKMlyE80RKm+1tBk9Mggr
         tIjIX4dJG/+CrarHAX5P4RE6G6SO6pKwcmFRaxf/aSE6kRVs3b33+RpDrS9NZCf3VRI0
         UvJBuWV01Cfh8YKCebw05XoLilfrGhkWAZwbmhC0NFFNgqoUL7rfMF7lI9M7H7LwbyjJ
         XOOZOFhWEb1tguro5DIykeLSEj9vvFa3fYaVg/7w/Ju31oPTnqH89QF2p7U4ue44gQMd
         u8yQ==
X-Gm-Message-State: ABuFfoiZwBwKOdN+AztICM/MjMesyDMh3Y0PgnL81/d0Wkb9bo6V/kvF
        RsmUqcq0EPxJeSbd9QyRwes=
X-Google-Smtp-Source: ACcGV63iyebTbOjM7RwgqZ6cwTvI0F5e1KNVX4b5IgBr7kGJIcCMgzY0d9n6eV9QVWXSCMfKrJSZHA==
X-Received: by 2002:adf:dcc7:: with SMTP id x7-v6mr1178998wrm.21.1538337207990;
        Sun, 30 Sep 2018 12:53:27 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/19] staging: rtl8188eu: rename odm_QueryRxPwrPercentage()
Date:   Sun, 30 Sep 2018 21:52:59 +0200
Message-Id: <20180930195310.1531-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename odm_QueryRxPwrPercentage() to avoid CamelCase.
odm_QueryRxPwrPercentage -> odm_query_rxpwrpercentage

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index dca39df3d8ba..07291ca90681 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -14,7 +14,7 @@
 #define READ_AND_CONFIG_MP(ic, txt) (ODM_ReadAndConfig##txt##ic(dm_odm))
 #define READ_AND_CONFIG_TC(ic, txt) (ODM_ReadAndConfig_TC##txt##ic(dm_odm))
 
-static u8 odm_QueryRxPwrPercentage(s8 antpower)
+static u8 odm_query_rxpwrpercentage(s8 antpower)
 {
 	if ((antpower <= -100) || (antpower >= 20))
 		return 0;
@@ -142,7 +142,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			break;
 		}
 		rx_pwr_all += 6;
-		PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
+		PWDB_ALL = odm_query_rxpwrpercentage(rx_pwr_all);
 		if (!cck_highpwr) {
 			if (PWDB_ALL >= 80)
 				PWDB_ALL = ((PWDB_ALL-80)<<1) + ((PWDB_ALL-80)>>1) + 80;
@@ -190,7 +190,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			pPhyInfo->RxPwr[i] = rx_pwr[i];
 
 			/* Translate DBM to percentage. */
-			RSSI = odm_QueryRxPwrPercentage(rx_pwr[i]);
+			RSSI = odm_query_rxpwrpercentage(rx_pwr[i]);
 			total_rssi += RSSI;
 
 			/* Modification for ext-LNA board */
@@ -213,7 +213,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		/*  (2)PWDB, Average PWDB calculated by hardware (for rate adaptive) */
 		rx_pwr_all = (((pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all) >> 1) & 0x7f) - 110;
 
-		PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
+		PWDB_ALL = odm_query_rxpwrpercentage(rx_pwr_all);
 		PWDB_ALL_BT = PWDB_ALL;
 
 		pPhyInfo->RxPWDBAll = PWDB_ALL;
-- 
2.19.0

