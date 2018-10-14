Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D523C71125
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FCF20652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAAGAnK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FCF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJNR6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 13:58:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40384 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeJNR6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 13:58:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id r1-v6so15182667edd.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 03:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LpCSQZROPkhyziu22BFUeZ93bKbKJNb+tCl2OIVVIuc=;
        b=HAAGAnK/U0zFFG3RHqwRQRB2+gvdH2lEEjgLE4L6TWJXuYZWtXQnxno0lvTjIuBEuZ
         R33/KhwFJYdZ8p/OSc86iH5j0b1v3yTP0P+hBiOlnf+RtbOqqclzRKhbbYO+ULXytllj
         t2zGKZ74jFk4de4xW1yT3DAMuwChyGThu8EofpmcOe01255/VS0AwTXRPpzDK2DYrOLI
         SBSJut8TLvbwrpvU7e4l54usQkwhyBJp4hHoKR7wTxGCG+G2Gbmj1oR+NMTax1MtSd3R
         xSHE6vM4Zy1WxsrWWnZJW3pdmIDeeQ/bSW3LOpshz/K3hkcRGw3U2EhyToVGpYllYnAv
         fZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LpCSQZROPkhyziu22BFUeZ93bKbKJNb+tCl2OIVVIuc=;
        b=kdH9qKhSTaKfW2nz1K8+f0aYVtPlqcb8rWklBnQGLR5UKGLGe7H5CoBRVbnDbJO7T0
         iRLOqqP/THXkuXglMDt2+OtX8Sovg6JbgrfM8eeWcEU1+4QyUwoWcMAzl9ZsAMwJGgR0
         N5SqeAaUr7koFMqbduWc7mHJXdCMSgudHH5Zi2zN5cc1HcoI/LzlhHpqe86JT6hxgCNJ
         wQa1/VaUPkRbL4fEUwC5TUBWIRVIyKSW90HV4jUUlB6Tb96dJrb3nwwypH77QNFjLI4v
         yS/kYF67IgEFTp+AgDJP5m1UAWPs1BPL9sBwPUdpD0ENgYC0y1+JvsV6BmbdWyYG2YHP
         eIkw==
X-Gm-Message-State: ABuFfogyLCNjndlOkRIiyhMqD7ro5F5CvygDEnx8J+1SsgBUnHvun9t1
        mKq2h4nYr2WrO58BvJ67B2w=
X-Google-Smtp-Source: ACcGV61w3FEcBYhu8J8vD+Xd2iSuLQHMRggsmgBaarGSPgA8IlDcoRTsmL0QIMwzBLONkBqcGXPmRQ==
X-Received: by 2002:a50:8387:: with SMTP id 7-v6mr18629881edi.84.1539512281630;
        Sun, 14 Oct 2018 03:18:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id o13-v6sm1475630ejb.34.2018.10.14.03.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 03:18:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: rtl8188eu: rename HalSetBrateCfg() - style
Date:   Sun, 14 Oct 2018 12:17:37 +0200
Message-Id: <20181014101742.10952-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181014101742.10952-1-straube.linux@gmail.com>
References: <20181014101742.10952-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename HalSetBrateCfg() to avoid CamelCase.
HalSetBrateCfg -> hal_set_brate_cfg

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_com.c     | 2 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 2 +-
 drivers/staging/rtl8188eu/include/hal_com.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_com.c b/drivers/staging/rtl8188eu/hal/hal_com.c
index 039abbcd6ad0..9853ebc6056c 100644
--- a/drivers/staging/rtl8188eu/hal/hal_com.c
+++ b/drivers/staging/rtl8188eu/hal/hal_com.c
@@ -119,7 +119,7 @@ u8 MRateToHwRate(u8 rate)
 	return ret;
 }
 
-void HalSetBrateCfg(u8 *brates, u16 *rate_cfg)
+void hal_set_brate_cfg(u8 *brates, u16 *rate_cfg)
 {
 	u8 i, is_brate, brate;
 
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 71c3c5642466..8f26427a8bc9 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -1267,7 +1267,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			/*  Select RRSR (in Legacy-OFDM and CCK) */
 			/*  For 8190, we select only 24M, 12M, 6M, 11M, 5.5M, 2M, and 1M from the Basic rate. */
 			/*  We do not use other rates. */
-			HalSetBrateCfg(val, &BrateCfg);
+			hal_set_brate_cfg(val, &BrateCfg);
 			DBG_88E("HW_VAR_BASIC_RATE: BrateCfg(%#x)\n", BrateCfg);
 
 			/* 2011.03.30 add by Luke Lee */
diff --git a/drivers/staging/rtl8188eu/include/hal_com.h b/drivers/staging/rtl8188eu/include/hal_com.h
index c966f43aed6e..0a87595c3a7e 100644
--- a/drivers/staging/rtl8188eu/include/hal_com.h
+++ b/drivers/staging/rtl8188eu/include/hal_com.h
@@ -148,7 +148,7 @@ u8 hal_com_get_channel_plan(struct adapter *padapter,
 
 u8 MRateToHwRate(u8 rate);
 
-void HalSetBrateCfg(u8 *brates, u16 *rate_cfg);
+void hal_set_brate_cfg(u8 *brates, u16 *rate_cfg);
 
 bool Hal_MappingOutPipe(struct adapter *pAdapter, u8 NumOutPipe);
 
-- 
2.19.1

