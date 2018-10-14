Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51072C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82D920652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzc6o8LF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82D920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeJNR6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 13:58:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42586 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeJNR6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 13:58:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id b7-v6so15158550edd.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 03:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DlVEKoo3GZomnIAZAGMwGBY5bHpl1iOaQgHnxUkZK38=;
        b=uzc6o8LFxhXbaWK0gO4IllxkNJ40zXnjo8RIEGAQIjaxu+DfBdhRHV3Iwxk7ucK9Ze
         1+EPlEe57lgucUT4PZV+9R1KNyc8PfPvZhvUMDtR3AsNqqmQp3DgkMG4VKKPWzwVqzwe
         BVe3JTENm/zcEXHE78zkzoh7EQ/LV0ldOwPaZeex4MUH7pBpKSs7TAqLAjAmKAfLOakK
         elIt0jFHI5CJqVdjzKBMn/DXNhFZWlSvqKLNZIt+vpiCXC2hhCaFsjS5OU2IX12jPLs0
         RO2Jp1ilyhYJFsMiyvXDE6uF7mv24KasHQCHmjCQ9QVCDWAFgQF7lQ0cXvYVrbRVhkcU
         zAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DlVEKoo3GZomnIAZAGMwGBY5bHpl1iOaQgHnxUkZK38=;
        b=ZDZw+tisnBYNY62ld4/JlEkKvUSIyA+8V7WUw8yAQSGYbZRGglaNJWrrTOIvk04G/b
         6Yj/87wCGkfmQY0YoisrbtxNZsHCHJW7xNK0ZTGNvfdS3ZGXLi6aymslNHtYg+5RMdpG
         SJ6vDZ9ns5OTsLHLerk5xc93+Y6OZendLVT87x5NN7P1GyLEM271DfzhnpLIcdVLf+22
         AUn/i4hBk5MZh/8mCLfAKj1NwszRyi8iQsUkyTZyNSYSyIDwDHu56ro5VAd+7Hn+CqDq
         2onVuu3uFQilMAsJo0QoWT7dh0AYimkYg8piMHgrovtJlPLX+v150SZNFTqnZ0Npag3C
         HM/g==
X-Gm-Message-State: ABuFfoilUhMr1IIzMfe2Xt9LUr0VboDmnFJLlbQazw2JPle7b3PAFAwl
        HIWCpBYD6eMf7bhDZjwyYMA=
X-Google-Smtp-Source: ACcGV62ks6ygN24mrREQGf+U3FvGL9bqF4aYMg9YwvudKAowsYxuGGiJy0FyktkxLtaoiEsA7E1uPA==
X-Received: by 2002:a17:906:6b42:: with SMTP id o2-v6mr14142077ejs.186.1539512280057;
        Sun, 14 Oct 2018 03:18:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id o13-v6sm1475630ejb.34.2018.10.14.03.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 03:17:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/8] staging: rtl8188eu: remove unused parameter of HalSetBrateCfg()
Date:   Sun, 14 Oct 2018 12:17:35 +0200
Message-Id: <20181014101742.10952-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter 'struct adapter *adapt' of HalSetBrateCfg() is unused,
so remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_com.c     | 2 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 2 +-
 drivers/staging/rtl8188eu/include/hal_com.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_com.c b/drivers/staging/rtl8188eu/hal/hal_com.c
index 7202e1767fc0..039abbcd6ad0 100644
--- a/drivers/staging/rtl8188eu/hal/hal_com.c
+++ b/drivers/staging/rtl8188eu/hal/hal_com.c
@@ -119,7 +119,7 @@ u8 MRateToHwRate(u8 rate)
 	return ret;
 }
 
-void HalSetBrateCfg(struct adapter *adapt, u8 *brates, u16 *rate_cfg)
+void HalSetBrateCfg(u8 *brates, u16 *rate_cfg)
 {
 	u8 i, is_brate, brate;
 
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 75a28bf095fb..71c3c5642466 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -1267,7 +1267,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			/*  Select RRSR (in Legacy-OFDM and CCK) */
 			/*  For 8190, we select only 24M, 12M, 6M, 11M, 5.5M, 2M, and 1M from the Basic rate. */
 			/*  We do not use other rates. */
-			HalSetBrateCfg(Adapter, val, &BrateCfg);
+			HalSetBrateCfg(val, &BrateCfg);
 			DBG_88E("HW_VAR_BASIC_RATE: BrateCfg(%#x)\n", BrateCfg);
 
 			/* 2011.03.30 add by Luke Lee */
diff --git a/drivers/staging/rtl8188eu/include/hal_com.h b/drivers/staging/rtl8188eu/include/hal_com.h
index 428a2a92820e..2e194f7a1352 100644
--- a/drivers/staging/rtl8188eu/include/hal_com.h
+++ b/drivers/staging/rtl8188eu/include/hal_com.h
@@ -148,7 +148,7 @@ u8 hal_com_get_channel_plan(struct adapter *padapter,
 
 u8 MRateToHwRate(u8 rate);
 
-void HalSetBrateCfg(struct adapter *Adapter, u8 *mBratesOS, u16 *pBrateCfg);
+void HalSetBrateCfg(u8 *mBratesOS, u16 *pBrateCfg);
 
 bool Hal_MappingOutPipe(struct adapter *pAdapter, u8 NumOutPipe);
 
-- 
2.19.1

