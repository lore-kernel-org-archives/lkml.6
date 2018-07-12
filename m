Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B841C468C7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C825F2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPDgDH+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C825F2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeGLKp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:45:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41544 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeGLKpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:45:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id s24-v6so5300654edr.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TfPLF0zxkuMswOUFFU9bh3DPNG1+wnOww1k0X18Ly0o=;
        b=ZPDgDH+g0nntuJ9n/ea4umI5SNi8Yc4nFCMajxF2EdXkOuBsxtAZkUHFXATQ3bhr5t
         gqC4XI8YfgurXWS4bkZMV8NLWLOp8gKJ01wxxMp3g4YzNy7Rxz53+LcaKg3yp/oQus2S
         rSdlWbZgHKEB3frnJiBSVIgO+nizcItezI9oycN9brdVBvk9w4os0qnfhD3BibNUCUCf
         qG9TeQzOhqOKNgsDWTMqmb+UKoN8VDi8wf6NDeq0ceLpDqIgwA3R1LZmffPSkJyV2YrR
         YkJxD6j+CkJNIUszY7nGWmoorScFShqQ5CamSLX4+KzYcWB82Vf/2+K6MjewArXHUjzK
         WD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TfPLF0zxkuMswOUFFU9bh3DPNG1+wnOww1k0X18Ly0o=;
        b=Q9P3b8h2aHQjDgRvPng5P8PyFoizTKaKMv+PeHuoPX8T8Cb0NH8GhYI8qtM9289sVP
         pFP3wFXUgWNbVUh3VO9+Umjx98yo/z2ChlhgxZYihGBSAo2P44Ez2FdSEWXuVQ7jsiO6
         tvLTVTQQ4AALPOJf0We0eO6UW9GIN5NWvaq4kIHQAshOFywahwz+9yOt3OH2BF9qfX9j
         eMcfLK8iFtqLJfwv0Brr8EfwbUlJwDLtOxLbAQCG9qWK8zDUtP70Y8E8Ydq1sRvxy5TF
         Ce2Rylq5ZtrUf6t1sEaevp6lW+shPBgiQpPLUKz90uuxmrhpw1jKd85MvN6x4ommlPbk
         iasg==
X-Gm-Message-State: AOUpUlGX8sRBoybK5CDTZG3BwOlzHm+VwtAWdJHKkpyv/OUUZateFJSn
        wkEIbj2xCTAD66XHm7PXeJw=
X-Google-Smtp-Source: AAOMgpfUmS8tgiUUVVTbAlahwHmAuG86CIva4CwAqHPMYU8b4YDU9ivwAgkNRafyoM4U1w+y99bsaw==
X-Received: by 2002:a50:a519:: with SMTP id y25-v6mr2003972edb.105.1531391786344;
        Thu, 12 Jul 2018 03:36:26 -0700 (PDT)
Received: from arch.localdomain (x4d0a32b7.dyn.telefonica.de. [77.10.50.183])
        by smtp.gmail.com with ESMTPSA id r11-v6sm3661567edh.32.2018.07.12.03.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 03:36:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: rtl8723bs: refactor rtw_is_cckrates_included()
Date:   Thu, 12 Jul 2018 12:36:07 +0200
Message-Id: <20180712103610.19532-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712103610.19532-1-straube.linux@gmail.com>
References: <20180712103610.19532-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor rtw_is_cckrates_included() to improve readability and
slightly reduce object file size.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 3f1c7bb0eb9f..3adb58759d5f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -68,13 +68,12 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 
 uint rtw_is_cckrates_included(u8 *rate)
 {
-	u32 i = 0;
+	while (*rate) {
+		u8 r = *rate & 0x7f;
 
-	while (rate[i] !=  0) {
-		if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
-		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
+		if (r == 2 || r == 4 || r == 11 || r == 22)
 			return true;
-		i++;
+		rate++;
 	}
 
 	return false;
-- 
2.18.0

