Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163A2C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4052538C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/QKnSM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4052538C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeF3SPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 14:15:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35767 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeF3SPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 14:15:00 -0400
Received: by mail-wr0-f193.google.com with SMTP id h40-v6so592311wrh.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZxK5c05Pw3Jy7OtoX5OPGtGnPv4yoTUy2SdkDz0lEy4=;
        b=e/QKnSM08JpIsmymNinacz5ohu0xqPc8Xh7HePrO3EWrgM//HVawPVIZE8p3HrwAS1
         YNLvIYNFMghSLHksl9p57dIX2tVGmnEB34GtlCVODIu73MoJIiXY+LVWrBQ534ah+uJj
         uhm/DHIhiX8Qjm0G3IhASXzjRqs865pT9lzIVO7ncS65RjONIOIFYnU10fpvakD8qh8c
         /oFnpsPFJFEentAcqjgHsQMmLO3ZDJQ7E+n4lxZylPSF4CKLccE3m/E/GsXzr2oNeCzZ
         MY/qejd7/KFseItfk/ygkU3VJNWTFbo/70B0W5/CjCogj6BjBLoaUU804Lcsegd03zgX
         ACJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZxK5c05Pw3Jy7OtoX5OPGtGnPv4yoTUy2SdkDz0lEy4=;
        b=OLhxPSNbJZLjK7WnNXeq5TCEq2oudvAJv9++Huh8KPuYNhf6FKbpiZPXOPk0KIfbou
         Tc0BUgrpVIdR/LkiA9X1TTpyQId+qU6sy9ezCkojovUAnwLVmLESigZtueIr7OjS66iC
         WSkfDtycqqUGaQj8z+SnM9EGQ9DMxwegn5poW/M9lvf1//Q4bfmtGyQidESzo9xzs8Vd
         0PI2KbkFor9ySR9SfxLwyrOa4exhrsaRD9LweIgOjeYKLGiRWxuLGGoqQAKG6faJKlFa
         X90u9I2F+ZqNVwCa8MCsYS78C+GoCbPgkmr4jjvdXIX9QeYmOrs1GmDtS3kdfGQjfct8
         KGJg==
X-Gm-Message-State: APt69E0gJ0SinGW67TBWiJswitS9PvGfystAIJxGesAyBDJQYswZR08+
        1hJlwAqWRkebT8UwdODdfRRnRgYN
X-Google-Smtp-Source: AAOMgpcchnMhDAeGJ4fmsx9ZIFzlsieZLWm3I8OsqRVHczYi3TObI+uIISDlIn6jguMrly0BRlqjJg==
X-Received: by 2002:adf:8307:: with SMTP id 7-v6mr15919538wrd.243.1530382499606;
        Sat, 30 Jun 2018 11:14:59 -0700 (PDT)
Received: from arch.localdomain (x4db215a8.dyn.telefonica.de. [77.178.21.168])
        by smtp.gmail.com with ESMTPSA id l78-v6sm9769732wmb.39.2018.06.30.11.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 11:14:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: fix block comments - coding style
Date:   Sat, 30 Jun 2018 20:14:40 +0200
Message-Id: <20180630181440.3097-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180630181440.3097-1-straube.linux@gmail.com>
References: <20180630181440.3097-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write multiple single line comments as block comments to
follow kernel coding style and improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_com.c | 50 ++++++++++++++-----------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_com.c b/drivers/staging/rtl8188eu/hal/hal_com.c
index ca26a4f4dd86..7202e1767fc0 100644
--- a/drivers/staging/rtl8188eu/hal/hal_com.c
+++ b/drivers/staging/rtl8188eu/hal/hal_com.c
@@ -189,11 +189,13 @@ static void two_out_pipe(struct adapter *adapter, bool wifi_cfg)
 {
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
 
-	if (wifi_cfg) { /* WMM */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  0,  1,  0,  1,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:L */
-
+	if (wifi_cfg) {
+		/*
+		 * WMM
+		 * BK, BE, VI, VO, BCN, CMD, MGT, HIGH, HCCA
+		 *  0,  1,  0,  1,   0,   0,   0,    0,    0
+		 * 0:H, 1:L
+		 */
 		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[1];/* VO */
 		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
 		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[1];/* BE */
@@ -203,12 +205,13 @@ static void two_out_pipe(struct adapter *adapter, bool wifi_cfg)
 		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
 		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
 		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
-
-	} else {/* typical setting */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  1,	1,  0,  0,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:L */
-
+	} else {
+		/*
+		 * typical setting
+		 * BK, BE, VI, VO, BCN, CMD, MGT, HIGH, HCCA
+		 *  1,  1,  0,  0,   0,   0,   0,    0,    0
+		 * 0:H, 1:L
+		 */
 		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
 		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
 		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[1];/* BE */
@@ -225,11 +228,13 @@ static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
 {
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
 
-	if (wifi_cfg) {/* for WMM */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  1,	2,  1,  0,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:N, 2:L */
-
+	if (wifi_cfg) {
+		/*
+		 * for WMM
+		 * BK, BE, VI, VO, BCN, CMD, MGT, HIGH, HCCA
+		 *  1,  2,  1,  0,   0,   0,   0,    0,    0
+		 * 0:H, 1:N, 2:L
+		 */
 		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
 		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
 		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
@@ -239,12 +244,13 @@ static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
 		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
 		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
 		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
-
-	} else {/* typical setting */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  2,  2,  1,  0,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:N, 2:L */
-
+	} else {
+		/*
+		 * typical setting
+		 * BK, BE, VI, VO, BCN, CMD, MGT, HIGH, HCCA
+		 *  2,  2,  1,  0,   0,   0,   0,    0,    0
+		 * 0:H, 1:N, 2:L
+		 */
 		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
 		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
 		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
-- 
2.18.0

