Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4C1C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235EF2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwi8r31H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235EF2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbeKBAyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:54:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45334 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBAyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:54:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id o19-v6so9118386pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CsrizFUWqJjeUa6x0LNvHSIN9ApQNxa4zdWdrY5G6EI=;
        b=gwi8r31H8W+48NO9s02/OyE7vOPmTZJLm0+U2lq5AjK5qUo/MGpxlcYTCX6G4Og2xs
         OE8MEiGMxMpwFHmWl29M08+NqXfCFvFHInMRAD+9Eln91wCZgljO5vUqS53rYmk4CN99
         0Jx8heyFyd/VIz5LJo3ZHm/LCZ3abzjY3KKoau/iBbD2YSwZ1VatMck7q+NGkwr3fBCi
         LV5FnjAbvZ1XKXM6rU8vxKNeZc4Wz2bglVVDMvNg+u+fBVayidkKfr+T85Q4G27f4H+T
         rLs3IuBFBnEzHMzoleapv3tRElueRRyKpWCKDOOkdhz6k9aYyGnVbTafb5fnDaFRN2hI
         FF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CsrizFUWqJjeUa6x0LNvHSIN9ApQNxa4zdWdrY5G6EI=;
        b=E5PEN2qF4Qyg4+VgtR0rvkRyRHzyXh8HKIxGPlO+KEmOmsIbq+cYLr2Sm5uDE/jiQI
         rzJzdRHyqFrEHkCOrO013nvonxQ+W49O49+Cr68WFBXKalcr18h5K832dI01rTcZpcFR
         ubzNXWeVb26lUt+7B6ET617vmujXTHrwTGAQbEZ6XhgVDcDShtRunhoNWMK/vElBMNVB
         yEQdnpGvu/GRVnYx0J2jQ7vtmBTcyGsLA4Udkpn87k+0ty8yMvvvVEQyS2c3Notj/hlx
         k+OXG04PmGiXWQK6zGaDV6ZAj15yUJlEHQP4Zde0A5SaxsvvR0oyCyWqjAshZu513+uO
         eC9A==
X-Gm-Message-State: AGRZ1gJYIaqhJIE/QTyZKCVKh/64PHDNa+Gjbp8zJRor+/n57Lea/7kr
        xNoVujVDgnt7VJMx8wmi+Cs=
X-Google-Smtp-Source: AJdET5ce6BO0gQXFZn1pKWSON50xvvSrZKbVgR1SzujGhAczqfHf2KZkEq0lIJXB41Y7etiJB+TKhQ==
X-Received: by 2002:a17:902:4503:: with SMTP id m3-v6mr8153091pld.217.1541087441204;
        Thu, 01 Nov 2018 08:50:41 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 196-v6sm65240016pfc.71.2018.11.01.08.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:50:40 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] staging: rtl8188eu: fix small typo
Date:   Thu,  1 Nov 2018 11:50:37 -0400
Message-Id: <20181101155037.23274-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
index d5001920f77c..5352b0e45cac 100644
--- a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
+++ b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
@@ -273,7 +273,7 @@ static void rtl88eu_dm_hw_ant_div(struct odm_dm_struct *dm_odm)
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
 		entry = dm_odm->pODM_StaInfo[i];
 		if (IS_STA_VALID(entry)) {
-			/* 2 Caculate RSSI per Antenna */
+			/* 2 Calculate RSSI per Antenna */
 			main_rssi = (dm_fat_tbl->MainAnt_Cnt[i] != 0) ?
 				     (dm_fat_tbl->MainAnt_Sum[i]/dm_fat_tbl->MainAnt_Cnt[i]) : 0;
 			aux_rssi = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ?
-- 
2.17.0

