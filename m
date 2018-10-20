Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7D5ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F6921523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiimPwuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F6921523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJTTSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 15:18:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35544 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeJTTSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 15:18:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id y19-v6so33656072edd.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xLa5dzj2qhRAorU6GFxV4vIqINuCii9odEyUB2VkvIk=;
        b=aiimPwuTWKsbKjzFEEfdlsenFdw/bDGVS6PCJR0/8yGHBS+0L4eG2AhpsM8mY0egpC
         Uel+FdVG6cUEtD6NcubgqdOi+IyyVZuZg5o1bJfHFXA3UOpOongTKYhmyfrcC0Zz9gli
         auYWF4kGhb5z5SSFWws0pgD0stDNrdzQu3P5hp14JDozKWSLJh8+tWbKGKNL+3LZX98j
         CKepCEsP+ap6AuPG+6poWch0Ub6ei2AzQzwTr8adTeWso7Mfth0kcSP7rLrU/uUUWsBT
         qVycL3tHfhSLVf5peC/0bu6/8ROLZ5qiABGwS2AwhdPNWEkcQg4VlRJ5AMovGGJ9UuCy
         JQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xLa5dzj2qhRAorU6GFxV4vIqINuCii9odEyUB2VkvIk=;
        b=Bdl21Lp3W6mnVAg1YB+Y3yAvTsUuIMXgJ8WI9fFpEhycPXN2Usy9QSHJ4kpemMxyNd
         91DebBT8Mvsy6tdzayVp12dpPUrWv1d/8mvw1Uz86t4cnEYt3BtrIL4nFkNLeaQcy1wP
         ySz88HhEZ9SRUTqA0fj9zZImlOW7C3qrqrDshgPtHIu7SObvER3wV8q1q3mmMKA+36oO
         ROsSDDMF0pxydJBxexR7K9K/1ukaBj7wkIDHgcx0g8xZLooke0023nhm0L801TuLRtUs
         mCYbYuhTrpLe33eaNZLIKEPqbQFUjodBwTi7XXkme+lIIUlWqfwH/dETLQG9MaE3MESR
         0EQA==
X-Gm-Message-State: ABuFfogRyxPmQ5hXVsySdnjcAoRCSfhrz3YSOCXoYVOL6YBeoQHUIW2m
        9oaF0Fe1aOPOIJ3E7UqRNyY=
X-Google-Smtp-Source: ACcGV62fxG7WtPdyBKkZMb42F49O8id5ABvXSjzIOSyUYtJTifWyH0C4NvD4HByv3BAS89qB3VnbkQ==
X-Received: by 2002:a17:906:2111:: with SMTP id 17-v6mr32044151ejt.206.1540033712125;
        Sat, 20 Oct 2018 04:08:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id r23-v6sm11418422eda.44.2018.10.20.04.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 04:08:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: rename variable Max_spatial_stream - style
Date:   Sat, 20 Oct 2018 13:08:18 +0200
Message-Id: <20181020110819.1576-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181020110819.1576-1-straube.linux@gmail.com>
References: <20181020110819.1576-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable Max_spatial_stream to avoid CamelCase.
Max_spatial_stream -> max_spatial_stream

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 0c034b19d3dd..d7bdbb141b2b 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -67,7 +67,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			struct odm_per_pkt_info *pPktinfo)
 {
 	struct sw_ant_switch *pDM_SWAT_Table = &dm_odm->DM_SWAT_Table;
-	u8 i, Max_spatial_stream;
+	u8 i, max_spatial_stream;
 	s8 rx_pwr[4], rx_pwr_all = 0;
 	u8 EVM, PWDB_ALL = 0, PWDB_ALL_BT;
 	u8 RSSI, total_rssi = 0;
@@ -215,11 +215,11 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 
 		/*  (3)EVM of HT rate */
 		if (pPktinfo->Rate >= DESC92C_RATEMCS8 && pPktinfo->Rate <= DESC92C_RATEMCS15)
-			Max_spatial_stream = 2; /* both spatial stream make sense */
+			max_spatial_stream = 2; /* both spatial stream make sense */
 		else
-			Max_spatial_stream = 1; /* only spatial stream 1 makes sense */
+			max_spatial_stream = 1; /* only spatial stream 1 makes sense */
 
-		for (i = 0; i < Max_spatial_stream; i++) {
+		for (i = 0; i < max_spatial_stream; i++) {
 			/*  Do not use shift operation like "rx_evmX >>= 1" because the compilor of free build environment */
 			/*  fill most significant bit to "zero" when doing shifting operation which may change a negative */
 			/*  value to positive one, then the dbm value (which is supposed to be negative)  is not correct anymore. */
-- 
2.19.1

