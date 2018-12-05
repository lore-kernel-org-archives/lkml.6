Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D527C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33BB2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFh+xq4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33BB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeLERDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:03:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40857 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbeLERDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:03:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so13609677wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+LaNoZ81q4MRBS5n/cL3NFI6ELrDAeI7zFOQzJ+Ehw=;
        b=HFh+xq4fVH8HmZ0+WuQHdBG3xIR8ZasCW6loQG5CuA6GrrDh6Ja4rDJz8dmO62TbW8
         RZTSWD+DfmtnYfQEEnqeUuSXDS95pf9bu8Av1oq1CsiBD9MVj99K8uTGBFHFWrzlX/UZ
         2AP9Xk2ZXp8vQP/8lCOANTPjddBQjN3JfnlKHgI8vlgXzP/ljTuHBWk1l3fhNppmcZJi
         oh/CBW/3USTbldmSfRGI5ohSRlJc1UlmGjR42CjsQ0l5573G0mHlA0ovBPUwxm6VTUsf
         0YrToX/uO2Wl1aQxlwGs44KnZHt0jZEo9AB14a8RnVlZNpqafFg2pbEyu9Q8trL4/45r
         fcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+LaNoZ81q4MRBS5n/cL3NFI6ELrDAeI7zFOQzJ+Ehw=;
        b=BpgSzIEOQPPAsMa7TQOlORsUeCQiH24uywovHIeKNfqPogIlp05RwXLYxMUSR29tRg
         W0CCqgCwslPAHbtfiUasu+KT4xTz/Std2c2Z1LeWs68TNl6GSrAoxL8Sv6CkOgJgibqE
         Atz+9DVLk0Mb0OhaEfqF3dklmtFeKzgNsmEskRGDpx0o/oA1OWyigoMoOKTLRfAqRhza
         PNJhYhtyJ3vFbM9c2dQZc2y2P1bxOCcE50KZH8TNsrNRr06AC8juV9loOLTMZsOJQQ5s
         ml4Kn0BPrIvG4qbuWjUpU9HWzmyrVJL91j4BsdahebVf3tMiFqiDWiU9l3g147bojuKh
         uvew==
X-Gm-Message-State: AA+aEWZ+iCQg9o6O7n/kUeIej7tHZAu3vwFQeaFEes7vT1N4iUjLTXi1
        k8FkCEbU2zmImB8ZkXpo80c=
X-Google-Smtp-Source: AFSGD/XQXL95gGgzX4qKuzfzOz3v6NFnkUDXQDKvDfpPOT+hQRa08ZjtHtf82jckK/+xd7k3PrUueA==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr15687316wmd.151.1544029388049;
        Wed, 05 Dec 2018 09:03:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id n127sm7949825wmd.20.2018.12.05.09.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:03:07 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/12] staging: rtl8188eu: write out multiplying in wifirate2_ratetbl_inx()
Date:   Wed,  5 Dec 2018 18:02:44 +0100
Message-Id: <20181205170247.5401-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205170247.5401-1-straube.linux@gmail.com>
References: <20181205170247.5401-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write out multiplying in wifirate2_ratetbl_inx() to improve
readabilitiy and clear checkpatch issues with missing spaces
around '*' operator.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 0eb904317118..7af3dd910c93 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -1123,29 +1123,29 @@ static int wifirate2_ratetbl_inx(unsigned char rate)
 	rate = rate & 0x7f;
 
 	switch (rate) {
-	case 54*2:
+	case 108:
 		return 11;
-	case 48*2:
+	case 96:
 		return 10;
-	case 36*2:
+	case 72:
 		return 9;
-	case 24*2:
+	case 48:
 		return 8;
-	case 18*2:
+	case 36:
 		return 7;
-	case 12*2:
+	case 24:
 		return 6;
-	case 9*2:
+	case 18:
 		return 5;
-	case 6*2:
+	case 12:
 		return 4;
-	case 11*2:
+	case 22:
 		return 3;
 	case 11:
 		return 2;
-	case 2*2:
+	case 4:
 		return 1;
-	case 1*2:
+	case 2:
 		return 0;
 	default:
 		return 0;
-- 
2.19.2

